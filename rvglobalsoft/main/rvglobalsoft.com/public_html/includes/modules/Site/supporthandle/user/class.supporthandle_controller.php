<?php

class supporthandle_controller extends HBController {

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    /**
     * รายชื่อ kb category id อิงตามหมวดหลัก
     */
    public function _listKbSubCateogry($request)
    {
        $db             = hbm_db();
        
        require_once(APPDIR . 'modules/Site/kbhandle/user/class.kbhandle_controller.php');
        
        $rootCategory   = isset($request['catId']) ? $request['catId'] : 0;
        $aList          = array();
        $aLabel         = array();
        
        if (! $rootCategory) {
            return $aList;
        }


        $aAllowSupportKBCategory    = array(31,32,35);
        
        $result         = $db->query("
                SELECT
                    kc.*
                FROM
                    hb_knowledgebase_cat kc
                WHERE
                    kc.id = :id
                ", array(
                    ':id'   => $rootCategory
                ))->fetch();
        
        
        $result['label']    = $result['name'];

        if (! in_array($result['id'], $aAllowSupportKBCategory)) {
            array_push($aList, $result);
        }
        
        $aLabel[0]      = $result['name'];
        
        $result         = kbhandle_controller::_listCategory(array('parentId'=>$rootCategory));
        
        if (! count($result)) {
            return $aList;
        }
        
        foreach ($result as $arr) {
            if (! in_array($arr['id'], $aAllowSupportKBCategory)) {
                continue;
            }

            $aLabel[$arr['level']]  = $arr['name'];
            $label          = $aLabel[0];
            for ($i = 1; $i < $arr['level']; $i ++) {
                $label     .= ' &gt; '. $aLabel[$i];
            }
            $label         .= ' &gt; '. $arr['name'];
            $arr['label']   = $label;
            array_push($aList, $arr);
        }
        
        return $aList;
    }
    
    public function loadCustomField ($request)
    {
        $db             = hbm_db();

        $kbCategoryName = isset($request['kbCategoryName']) ? $request['kbCategoryName'] : '';
        
        if (preg_match('/rvskin/i', $kbCategoryName)) {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.customfield_rvskin.tpl', array(), false);
        } elseif (preg_match('/cpanel/i', $kbCategoryName)) {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.customfield_cpanel.tpl', array(), false);
        } elseif (preg_match('/rvsitebuilder.*\shosting\sprovider/i', $kbCategoryName)) {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.customfield_rvsitebuilder_provider.tpl', array(), false);
        } elseif (preg_match('/rvsitebuilder.*\suser/i', $kbCategoryName)) {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.customfield_rvsitebuilder_user.tpl', array(), false);
        }
        
        //$this->template->assign('aItems', $result);
        //$this->template->render(dirname(dirname(__FILE__)) .'/templates/user/ajax.sorter.tpl', array(), false);
    }

    public function encodeCustomfield ($request)
    {
        $db             = hbm_db();

        $catId          = isset($request['cat_id']) ? $request['cat_id'] : '';
        $aCustomfield   = isset($request['cf']) ? $request['cf'] : array();
        $aCustomfield['cat_id'] = $catId;
        
        if (! count($aCustomfield)) {
            exit;
        }
        
        $customfield    = serialize($aCustomfield);
        $customfield    = base64_encode($customfield);
        
        $cfBlockStart   = md5('{customfield}');
        $cfBlockEnd     = md5('{/customfield}');
        
        echo $cfBlockStart . $customfield . $cfBlockEnd;
        exit;
    }
    
    /**
     * แปลงข้อความใน ticket ที่เป็น customfield
     * ให้แยกออกมาเก็บ
     */
    public function _extractCustomfield ($request)
    {
        $db             = hbm_db();

        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result         = $db->query("
                SELECT
                    tc.*
                FROM
                    hb_ticket_customfields tc,
                    hb_tickets t
                WHERE
                    tc.ticket_id = :ticketId
                    AND tc.ticket_id = t.id
                ", array(
                    ':ticketId'     => $ticketId,
                ))->fetch();
        
        if (isset($result['id'])) {
            return array(
                'customfield'   => $result['content']
                );
        }
        
        $cfBlockStart   = md5('{customfield}');
        $cfBlockEnd     = md5('{/customfield}');
        
        $result         = $db->query("
                SELECT
                    t.body
                FROM
                    hb_tickets t
                WHERE
                    t.id = :ticketId
                    AND t.body LIKE :body
                ", array(
                    ':ticketId'     => $ticketId,
                    ':body'         => '%'.$cfBlockStart.'%'.$cfBlockEnd.'%'
                ))->fetch();
        
        if (! isset($result['body'])) {
            return false;
        }
        
        $body           = $result['body'];
        
        preg_match('/'. $cfBlockStart .'(.*)'. $cfBlockEnd .'/', $body, $matches);
        
        if (! isset($matches[1])) {
            return false;
        }
        
        $customField    = base64_decode($matches[1]);
        
        $db->query("
            INSERT INTO hb_ticket_customfields (
                id, ticket_id, date, content
            ) VALUES (
                '', :ticketId, NOW(), :content
            )
            ", array(
                ':ticketId'     => $ticketId,
                ':content'      => $customField
            ));
        
        $body           = str_replace($matches[0], '', $body);
        
        $db->query("
            UPDATE
                hb_tickets
            SET
                body = :body
            WHERE
                id = :ticketId
            ", array(
                ':ticketId'     => $ticketId,
                ':body'         => $body
            ));
            
        return array(
            'customfield'   => $customField,
            'body'          => $body
            );
    }
    
    /**
     * ลบพวก customfield
     */
    public function deleteCustomfield ($request)
    {
        $db             = hbm_db();
        
        $client         = hbm_logged_client();
        $oClient        = isset($client['id']) ? (object) $client : (object) array();
        
        if (! isset($oClient->id)) {
            return false;
        }
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result         = $db->query("
                SELECT
                    t.id
                FROM
                    hb_tickets t
                WHERE
                    t.id = :ticketId
                    AND t.client_id = :clientId
                ", array(
                    ':ticketId'     => $ticketId,
                    ':clientId'     => $oClient->id
                ))->fetch();
        
        if (! isset($result['id'])) {
            return false;
        }
        
        $db->query("
            DELETE FROM
                hb_ticket_customfields
            WHERE
                ticket_id = :ticketId
            ", array(
                ':ticketId'     => $ticketId
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["Customfield is deleted."]'
            . ',"STACK":0} -->';
        exit;
    }
    
    /**
     * ลบพวก customfield
     */
    public function updateCustomfield ($request)
    {
        $db             = hbm_db();
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        $client         = hbm_logged_client();
        $oClient        = isset($client['id']) ? (object) $client : (object) array();
        
        if (! isset($oClient->id)) {
            return false;
        }
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $cf             = isset($request['cf']) ? $request['cf'] : array();
        
        $result         = $db->query("
                SELECT
                    t.id
                FROM
                    hb_tickets t
                WHERE
                    t.id = :ticketId
                    AND t.client_id = :clientId
                ", array(
                    ':ticketId'     => $ticketId,
                    ':clientId'     => $oClient->id
                ))->fetch();
        
        if (! isset($result['id'])) {
            return false;
        }
        
        $db->query("
            UPDATE
                hb_ticket_customfields
            SET
                content = :content
            WHERE
                ticket_id = :ticketId
            ", array(
                ':content'      => serialize($cf),
                ':ticketId'     => $ticketId
            ));
        
        /*
         * [XXX] ไม่เข้าใจว่าทำไมใช้ไม่ได้
        $aParam         = array(
            'call'          => 'setTicketStatus',
            'id'            => $ticketId,
            'status'        => 'Client-Reply'
        );
        $result         = $apiCustom->request($aParam);
        
        $aParam         = array(
            'call'          => 'addTicketNotes',
            'id'            => $ticketId,
            'notes'         => 'Client update customfield'
        );
        $result         = $apiCustom->request($aParam);
        */
        
        $db->query("
            UPDATE
                hb_tickets
            SET
                status = 'Client-Reply'
            WHERE
                id = :ticketId
                AND status != 'Closed'
            ", array(
                ':ticketId'     => $ticketId
            ));
            
        $db->query("
            INSERT INTO hb_tickets_notes (
                id, ticket_id, admin_id, name, email, date, note
            ) VALUES (
                '', :ticketId, 0, :name, :email, NOW(), :note
            )
            ", array(
                ':ticketId'     => $ticketId,
                ':name'         => $oClient->firstname .' '. $oClient->lastname,
                ':email'        => $oClient->email,
                ':note'         => 'Customfield is updated.'
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["Customfield is updated."]'
            . ',"STACK":0} -->';
        exit;
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }
}