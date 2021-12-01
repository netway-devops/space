<?php

require_once(APPDIR .'class.cache.extend.php');
require_once(APPDIR . 'class.general.custom.php');
require_once dirname(__DIR__) . '/model/class.clienthandle_model.php';

class clienthandle_controller extends HBController {
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    /**
     * คืนค่า credit ใน field credit_swap กลับไปให้ลูกค้า
     * @return unknown_type
     */
    public function swapcredit ($request)
    {
        $db     = hbm_db();
        
        $clientId       = isset($request['client_id']) ? $request['client_id'] : 0;
        if (! $clientId) {
            return false;
        }
        
        $aClientBilling     = $db->query("
                        SELECT cb.credit, cb.credit_swap
                        FROM hb_client_billing cb
                        WHERE cb.client_id = :clientId
                        ", array(
                            ':clientId' => $clientId
                        ))->fetch();
        if ( ! isset($aClientBilling['credit'])) {
            return false;
        }
        
        $credit     = $aClientBilling['credit'] + $aClientBilling['credit_swap'];
        $creditSwap = 0;
        
        $db->query("
            UPDATE hb_client_billing 
            SET credit = :credit,
                credit_swap = :creditSwap
            WHERE client_id = :clientId
        ", array(
            ':credit'       => $credit,
            ':creditSwap'   => $creditSwap,
            ':clientId'     => $clientId
        ));
        
        echo 'success';
        exit;
    }
    
    public function detail ($request)
    {
        $db     = hbm_db();
        
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        $aFields        = isset($request['fields']) ? explode(',',$request['fields']) : array();
        
        $result         = $db->query("
                    SELECT
                        ca.id, ca.email
                    FROM 
                        hb_client_access ca
                    WHERE ca.id = :clientId
                    ", array(
                        ':clientId' => $clientId
                    ))->fetch();
        if ( ! isset($result['id'])) {
            exit;
        }
        
        $aDatas     = array();
        if (count($aFields)) {
            foreach ($aFields as $k) {
                $aDatas[$k]     = $result[$k];
            }
        }
        
        header ('Content-type: text/html; charset=utf-8');
        echo json_encode($aDatas);
        exit;
    }

    public function getClient ($request)
    {
        $db             = hbm_db();
        $aLists         = array('lists' => array());
        
        $cacheKey   = md5(serialize($request).serialize($aLists));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result         = $db->query("
                    SELECT
                        ca.id, cd.firstname, cd.lastname
                    FROM
                        hb_client_access ca,
                        hb_client_details cd
                    WHERE
                        ca.id = cd.id
                    ORDER BY ca.id ASC
                    ")->fetchAll();
            CacheExtend::singleton()->set($cacheKey, $result, 3600*12);
        }
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aLists['lists'][$arr['id']]    = $arr;
            }
        }
        
        return $aLists;
    }
    
    /**
     * แสดง client note ที่เกี่ยวข้อง
     */
    public function notes ($request)
    {
        $db             = hbm_db();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $result         = $db->query("
                SELECT
                    n.*
                FROM
                    hb_notes n
                WHERE
                    n.rel_id = :clientId
                    AND n.type = 'client'
                ORDER BY n.date DESC
                ", array(
                    ':clientId'     => $clientId
                ))->fetchAll();
        
        $this->template->assign('aClientNotes', $result);
        $this->template->assign('noteType', $type);
        
        if ($type) {
            
            $result         = $db->query("
                    SELECT
                        n.*, x.domain AS name
                    FROM
                        hb_notes n,
                        hb_accounts x
                    WHERE
                        n.rel_id = x.id
                        AND x.client_id = :clientId
                        AND n.type = 'account'
                    ORDER BY n.rel_id DESC, n.date DESC
                    ", array(
                        ':clientId'     => $clientId
                    ))->fetchAll();
            
            $this->template->assign('aNotesAccount', $result);
            
            $result1         = $db->query("
                    SELECT
                        n.*, x.name AS name
                    FROM
                        hb_notes n,
                        hb_domains x
                    WHERE
                        n.rel_id = x.id
                        AND x.client_id = :clientId
                        AND n.type = 'domain'
                    ORDER BY n.rel_id DESC, n.date DESC
                    ", array(
                        ':clientId'     => $clientId
                    ))->fetchAll();
            
            $this->template->assign('aNotesDomain', $result1);
            
            
            
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.notes.tpl', array(), false);
    }
    
    public function search ($request)
    {
        $db                 = hbm_db();
        $keyword            = isset($request['keyword']) ? $request['keyword'] : 0;
        $extend             = isset($request['extend']) ? $request['extend'] : 0;
        
        $cacheKey   = md5(serialize($request));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            
            $result             = $db->query("
                    SELECT tblA.*
                    FROM (
                        SELECT
                            ca.id, ca.email, cd.firstname, cd.companyname,
                            IF (cd.parent_id, cd.parent_id, ca.id) AS parentId,
                            IF (cd.parent_id, 'Contact Account', 'Main Account') AS clientType
                        FROM
                            hb_client_access ca,
                            hb_client_details cd
                        WHERE
                            ca.id = cd.id
                            AND ( ca.email LIKE '%{$keyword}%'
                                OR cd.firstname LIKE '%{$keyword}%'
                                OR cd.companyname LIKE '%{$keyword}%'
                                OR BINARY ca.id = '{$keyword}'
                                )
                        LIMIT 15
                    ) tblA
                    
                    UNION ALL
                    
                    SELECT tblB.*
                    FROM (
                        SELECT
                            ca.id, ca.email, cd.firstname, cd.companyname,
                            IF (cd.parent_id, cd.parent_id, ca.id) AS parentId,
                            IF (cd.parent_id, 'Contact Account', 'Main Account') AS clientType
                        FROM
                            hb_accounts a,
                            hb_client_access ca,
                            hb_client_details cd
                        WHERE
                            a.client_id = ca.id
                            AND ca.id = cd.id
                            AND ( a.domain LIKE '%{$keyword}%')
                        LIMIT 15
                    ) tblB
                    
                    UNION ALL
                    
                    SELECT tblC.*
                    FROM (
                        SELECT
                            ca.id, ca.email, cd.firstname, cd.companyname,
                            IF (cd.parent_id, cd.parent_id, ca.id) AS parentId,
                            IF (cd.parent_id, 'Contact Account', 'Main Account') AS clientType
                        FROM
                            hb_domains d,
                            hb_client_access ca,
                            hb_client_details cd
                        WHERE
                            d.client_id = ca.id
                            AND ca.id = cd.id
                            AND ( d.name LIKE '%{$keyword}%')
                        LIMIT 15
                    ) tblC
                    ORDER BY parentId ASC, clientType DESC
                    ")->fetchAll();
            
            CacheExtend::singleton()->set($cacheKey, $result, 3600);
        }
        
        $aClient            = array();
        if (count($result)) {
            foreach ($result as $arr) {
                if (isset($aClient[$arr['id']])) {
                    continue;
                }
                $aClient[$arr['id']]    = (($arr['id'] == $arr['parentId']) ? '' : ' --- ')
                                        . '#'. $arr['id'] .' '. $arr['firstname']  .' ('. $arr['clientType'] .') '. $arr['companyname'];
                if ($extend) {
                    $aClient[$arr['id']]    .= '<div>'. $arr['email'] .'</div>';
                }
            }
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Success"]'
            . ',"DATA":['. json_encode($aClient) .']'
            . ',"STACK":0} -->';
            
        exit;
    }
    
    public function updateCustomfield ($request)
    {
        $db             = hbm_db();
        
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        $fieldName      = isset($request['field']) ? $request['field'] : '';
        $value          = isset($request['value']) ? $request['value'] : 0;
        
        $result         = $db->query("
            SELECT cfv.*
            FROM hb_client_fields cf,
                hb_client_fields_values cfv
            WHERE cf.code = :fieldName
                AND cf.id = cfv.field_id
                AND cfv.client_id = :clientId
            ", array(
                ':fieldName'    => $fieldName,
                ':clientId'     => $clientId
            ))->fetch();
        
        if (isset($result['client_id'])) {
            $fieldId    = $result['field_id'];
            
            $db->query("
                UPDATE hb_client_fields_values
                SET value = :value
                WHERE client_id = :clientId
                    AND field_id = :fieldId
                ", array(
                    ':value'    => $value,
                    ':clientId' => $clientId,
                    ':fieldId'  => $fieldId
                ));
            
        } else {
            
            $result     = $db->query("
                SELECT cf.*
                FROM hb_client_fields cf
                WHERE cf.code = :fieldName
                ", array(
                    ':fieldName'    => $fieldName
                ))->fetch();
            
            $fieldId    = isset($result['id']) ? $result['id'] : 0;
            
            if ($fieldId) {
                $db->query("
                    INSERT INTO hb_client_fields_values (
                    client_id, field_id, value
                    ) VALUES (
                    :clientId, :fieldId, :value
                    )
                    ", array(
                        ':clientId'     => $clientId,
                        ':fieldId'      => $fieldId,
                        ':value'        => $value,
                    ));
            }
            
        }
        
        $aData      = array(
            'clientId'      => $clientId,
            'fieldId'       => $fieldId,
            'value'         => $value,
        );
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function getList ($request)
    {
        return self::getClient($request);
    }
    
    public function isProfileChanged ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $clientId       = isset($request['id']) ? $request['id'] : 0;
        
        $result         = $db->query("
            SELECT *
            FROM hb_client_details
            WHERE id = :clientId
            ", array(
                ':clientId'     => $clientId
            ))->fetch();
        
        $serial         = md5(serialize($result));
        
        $result         = $db->query("
            SELECT *
            FROM hb_client_extend_data
            WHERE client_id = :clientId
            ", array(
                ':clientId'     => $clientId
            ))->fetch();
        
        if ($result['data_md5'] == $serial) {
            return false;
        }
        
        $admin          = $aAdmin['firstname'];
        
        if (! isset($result['client_id'])) {
            $db->query("
                INSERT INTO `hb_client_extend_data` (
                    `client_id`, `data_md5`, `date_update`, `date_update_by`
                ) VALUES (
                    :clientId, :serial, NOW(), :admin
                )
                ", array(
                    ':clientId'     => $clientId,
                    ':serial'       => $serial,
                    ':admin'        => $admin
                ));
            
            return true;
        }
        
        $db->query("
            UPDATE hb_client_extend_data
            SET date_update = NOW(),
                data_md5 = :serial,
                date_update_by = :admin
            WHERE client_id = :clientId
            ", array(
                ':clientId'     => $clientId,
                ':serial'       => $serial,
                ':admin'        => $admin
            ));
        
        
        return true;
    }
    
    public function markUpdate ($request)
    {
        $db         = hbm_db();
        
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $db->query("
            UPDATE hb_client_details
            SET notes = CONCAT(notes, ' ')
            WHERE id = :clientId
            ", array(
                ':clientId'     => $clientId
            ));
        
        $aData      = array(
            'clientId'      => $clientId,
        );
        
        $request['id']  = $clientId;
        $this->isProfileChanged($request);
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function getCustomFieldOption ($code)
    {
        $result     = clienthandle_model::singleton()->getCustomField($code);
        $aOption    = isset($result['default_value']) ? explode(';', $result['default_value']) : array();
        return $aOption;
    }
    
    public function hookAfterClientAdded ($details)
    {
        $clientId  = isset($details['id']) ? $details['id'] : 0;
        
        $this->_setDefaultTaxidBranch($clientId);

    }
    
    public function hookAfterClientEdit ($details)
    {
        $clientId  = isset($details['new']['id']) ? $details['new']['id'] : 0;
        
        $this->_setDefaultTaxidBranch($clientId);

    }
    
    public function _setDefaultTaxidBranch ($clientId)
    {
        $api        = new ApiWrapper();

        $params     = array(
            'id'    => $clientId
        );
        $result     = $api->getClientDetails($params);

        $aClient    = isset($result['client']) ? $result['client'] : array();

        if (! isset($aClient['taxid']) || $aClient['taxid'] == '') {
            return true;
        }
        if (isset($aClient['branch']) && $aClient['branch'] != '') {
            return true;
        }

        $branch     = 'สำนักงานใหญ่';

        $params     = array(
            'id'        => $clientId,
            'branch'    => $branch,
        );
        $result     = $api->setClientDetails($params);

    }    
    
    public function afterCall ($request)
    {
        
    }

    public function hookAfterClientLogin ($clientId)
    {
        $aClient    = clienthandle_model::singleton()->getClientById($clientId);
        
        // ไม่ให้ login ด้วย client contact
        // ให้เปลี่ยน email เป็น email+xxx@domain.com
        $this->_afterClientLoginCheckLoginAsClientContact($aClient);


    }

    private function _afterClientLoginCheckLoginAsClientContact ($aClient)
    {
        if (! isset($aClient['parent_id']) || ! $aClient['parent_id']) {
            return true;
        }

        $email      = $aClient['email'];
        $_SESSION['notification']   = array('type' => 'error', 'message' => 'ไม่อนุญาติให้ login ด้วย contact email address '. $email);

        header('location:/index.php?action=logout');
        exit;
    }


}