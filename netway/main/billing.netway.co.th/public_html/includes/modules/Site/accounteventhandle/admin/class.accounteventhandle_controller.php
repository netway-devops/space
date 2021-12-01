<?php

class accounteventhandle_controller extends HBController {

    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
    }
    
    public function lists ($request)
    {
        $db         = hbm_db();
        
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;
        $type       = isset($request['type']) ? $request['type'] : '';
        
        $type       = ($type == 'Other') ? 'Spam\',\'Overload' : $type;
        
        $result     = $db->query("
            SELECT
                ae.*
            FROM
                hb_accounts_event ae
            WHERE
                ae.account_id = :accountId
                AND ae.type IN ('{$type}')
            ", array(
                ':accountId'    => $accountId
            ))->fetchAll();
        
        $this->template->assign('accountId', $accountId);
        $this->template->assign('type', $type);
        $this->template->assign('aLists', $result);
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.lists.tpl', array(), false);
    }
    
    public function add ($request)
    {
        $db         = hbm_db();
        
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;
        $type       = isset($request['type']) ? $request['type'] : '';
        
        
        
        $this->template->assign('accountId', $accountId);
        $this->template->assign('type', $type);
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.add.tpl', array(), false);
    }
    
    public function getMessage ($request)
    {
        $db         = hbm_db();
        
        $link       = isset($request['link']) ? $request['link'] : '';
        
        if (preg_match('/(cmd=tickets)+.*#([0-9]+)/i', $link, $match)
             || preg_match('/(cmd=tickets)+.*num=([0-9]+)/i', $link, $match)
            ) {
            $ticketNumber   = $match[2];
            
            $result         = $db->query("
                    SELECT
                        t.id, t.lastupdate, t.subject
                    FROM
                        hb_tickets t
                    WHERE
                        t.ticket_number = :ticketNumber
                    ", array(
                        ':ticketNumber' => $ticketNumber
                    ))->fetch();
            
            if (isset($result['id'])) {
                echo '<!-- {"ERROR":[]'
                    . ',"INFO":["พบข้อมูลจากหน้า support"]'
                    . ',"DATA":[\''. json_encode(array(
                            'message'       => $result['lastupdate'] .' : '. $result['subject']
                            )) .'\']'
                    . ',"STACK":0} -->';
                exit;
            }
            
        } elseif (preg_match('/(cmd=accounts)+.*&id=([0-9]+)/i', $link, $match)) {
            $accountId      = $match[2];
            
            $result         = $db->query("
                    SELECT
                        n.id, n.date, TRIM(n.note) AS note
                    FROM
                        hb_notes n
                    WHERE
                        n.rel_id = :accountId
                        AND n.type = 'account'
                    ORDER BY n.date DESC
                    LIMIT 10
                    ", array(
                        ':accountId' => $accountId
                    ))->fetchAll();
            
            if (count($result)) {
                echo '<!-- {"ERROR":[]'
                    . ',"INFO":["พบข้อมูลบันทึกจากหน้า account"]'
                    . ',"DATA":[\''. json_encode(array(
                            'lists'       => $result
                            )) .'\']'
                    . ',"STACK":0} -->';
                exit;
            }
            
        }
        
        echo '<!-- {"ERROR":["ไม่พบข้อมูลที่เกี่ยวข้อง"],"INFO":[],"DATA":[],"STACK":0} -->';
        exit;
    }
    
    public function addEvent ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $type       = isset($request['type']) ? $request['type'] : '';
        $accountId  = isset($request['accountId']) ? $request['accountId'] : '';
        $link       = isset($request['link']) ? $request['link'] : '';
        $note       = isset($request['note']) ? $request['note'] : '';
        
        if (! isset($aAdmin['id']) || ! $accountId || ! $type) {
            echo '<!-- {"ERROR":["ข้อมูลไม่ถูกค้อง"],"INFO":[],"DATA":[],"STACK":0} -->';
            exit;
        }
        
        $db->query("
            INSERT INTO hb_accounts_event (
                id, account_id, date_created, type, link, note, admin
            ) VALUES (
                '', :accountId, NOW(), :type, :link, :note, :admin
            )
            ", array(
                ':accountId'    => $accountId,
                ':type'         => $type,
                ':link'         => $link,
                ':note'         => $note,
                ':admin'        => $aAdmin['firstname'] .' '. $aAdmin['lastname']
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูลเรียบร้อย"],"DATA":[],"STACK":0} -->';
        exit;
    }

    public function delete ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();
        
        $eventId    = isset($request['eventId']) ? $request['eventId'] : 0;
        if (isset($aAdmin['id'])) {
            $db->query("
                DELETE FROM hb_accounts_event WHERE id = :eventId
                ", array(
                    ':eventId'  => $eventId
                ));
        }

        echo '<!-- {"ERROR":[],"INFO":["ลบข้อมูลเรียบร้อย"],"DATA":[],"STACK":0} -->';
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