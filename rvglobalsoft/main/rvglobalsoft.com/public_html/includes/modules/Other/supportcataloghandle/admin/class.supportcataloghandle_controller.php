<?php

class supportcataloghandle_controller extends HBController {
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db             = hbm_db();
        
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function isAssignClient ($request)
    {
        $db             = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result         = $db->query("
                SELECT t.id, t.client_id
                FROM hb_tickets t
                WHERE t.id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function isEnableSupportCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $result         = $db->query("
                SELECT
                    mc.*
                FROM
                    hb_modules_configuration mc
                WHERE
                    mc.module = 'supportcataloghandle'
                ")->fetch();
        
        $aAccess        = isset($result['access']) ? explode('|', $result['access']) : array();
        $isActive       = isset($result['active']) ? $result['active'] : 0;
        $isEnable       = ($isActive && in_array($aAdmin['id'], $aAccess)) ? 1 : 0;
        
        $result         = array('isEnable' => $isEnable);
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($result));
        $this->json->show();
    }
    
    public function displayServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        
        $result         = $db->query("
                SELECT
                    t2r.*
                FROM
                    sc_ticket_2_request t2r
                WHERE
                    t2r.ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $requestType    = isset($result['request_type']) ? $result['request_type'] : '';
        $this->template->assign('requestType', $requestType);
        
        $this->template->assign('unixTime', time());
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.display_service_catalog.tpl',array(), false);
    }
    
    public function selectRequest ($request)
    {
        $db             = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $requestType    = isset($request['requestType']) ? $request['requestType'] : '';
        
        $db->query("
            INSERT INTO sc_ticket_2_request (
                ticket_id, request_type
            ) VALUES (
                :ticketId, :requestType
            )
            ON DUPLICATE KEY UPDATE request_type = :requestType
            ", array(
                ':ticketId'     => $ticketId,
                ':requestType'  => $requestType,
            ));
        /*
        echo '<!-- {"ERROR":[],"INFO":["ตั้ง Request type เป็น '. $requestType .' ให้กับ Ticket#'. $ticketId .' เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
        */
    }
    
    public function displayServiceRequest ($request)
    {
        $db             = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        
        $result         = $db->query("
                SELECT c.*
                FROM sc_category c
                WHERE c.parent_id = 0
                ORDER BY c.orders ASC
                ")->fetchAll();
        
        $aMainCategory  = array(json_encode(array('label' => '--- แสดงทั้งหมด ---', 'value' => 0)));
        $aMainCat       = array();
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aMainCategory, json_encode(array('label' => $arr['name'], 'value' => $arr['id'])));
                $aMainCat[$arr['id']]   = '';
            }
        }
        $this->template->assign('mainCategory', implode(',', $aMainCategory));
        
        $aCategory      = self::_getCategory();
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        $aTotal         = self::_totalServiceCatalogByCategory();
        $aCatalogs      = self::_listServiceCatalog();
        //echo '<pre>'.print_r($aMainCategory,true).'</pre>';echo '<pre>'.print_r($aCategories,true).'</pre>';echo '<pre>'.print_r($aCatalogs,true).'</pre>';
        $aCategoryList  = array();
        if (count($aCategories)) {
            $currentId          = 0;
            foreach ($aCategories as $arr) {
                if (! $arr['parent_id']) {
                    if ($currentId) {
                        $aMainCat[$currentId]       = implode(',', $aSubCat);
                    }
                    $currentId      = $arr['id'];
                    $aSubCat        = array();
                }
                $level  = substr($arr['level'], 3);
                $level  = preg_replace('/\-/', '&nbsp;', $level);
                $json   = json_encode(array(
                    'label'     => $level .' '. $arr['name'] . 
                                    (($aTotal[$arr['id']]) ? ' ('. $aTotal[$arr['id']] .')' : ''),
                    'value'     => $arr['id']
                    ));
                array_push($aCategoryList, $json);
                array_push($aSubCat, $json);
                
                if (isset($aCatalogs[$arr['id']])) {
                    foreach ($aCatalogs[$arr['id']] as $arr2) {
                        $json          = json_encode(array(
                            'label'     => '<span style="color:#428CB0">'.$level .' &nbsp;&nbsp;&nbsp; '. $arr2['title'] . ' '.
                                            (! $arr2['is_publish'] ? '<span style="color:red;">(Un-Publsih)</span>': '') .
                                            '</span>',
                            'value'     => $arr['id'] .'.'. $arr2['id']
                            ));
                        array_push($aCategoryList, $json);
                        array_push($aSubCat, $json);
                    }
                }
                
            }
            
            $aMainCat[$currentId]       = implode(',', $aSubCat);
        }
        $this->template->assign('categoryList', implode(',', $aCategoryList));
        $this->template->assign('mainCat', $aMainCat);
        
        $result         = $db->query("
                SELECT
                    t2r.*, sc.category_id, c.id AS requestCatId
                FROM
                    sc_ticket_2_request t2r
                    LEFT JOIN sc_service_catalog sc
                    ON sc.id = t2r.sc_id
                    LEFT JOIN sc_category c
                    ON c.id = sc.category_id
                        AND c.name = 'Request for Service Catalog'
                WHERE
                    t2r.ticket_id = :ticketId
                    AND t2r.request_type = 'Service Request'
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $this->template->assign('aSelected', $result);
        $selectedId     = isset($result['category_id']) ? $result['category_id'] .'.'. $result['sc_id'] : 0;
        $this->template->assign('selectedId', $selectedId);
        $isServiceRequest       = isset($result['requestCatId']) ? $result['requestCatId']  : 0;
        $this->template->assign('isServiceRequest', $isServiceRequest);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.display_service_request.tpl',array(), false);
    }
    
    public function displayIncidentKB ($request)
    {
        $db             = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        
        $result         = $db->query("
                SELECT c.*
                FROM in_category c
                WHERE c.parent_id = 0
                ORDER BY c.orders ASC
                ")->fetchAll();
        
        $aMainCategory  = array(json_encode(array('label' => '--- แสดงทั้งหมด ---', 'value' => 0)));
        $aMainCat       = array();
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aMainCategory, json_encode(array('label' => $arr['name'], 'value' => $arr['id'])));
                $aMainCat[$arr['id']]   = '';
            }
        }
        $this->template->assign('mainCategory', implode(',', $aMainCategory));
        
        $aCategory      = self::_getCategory('incidentKB');
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        $aTotal         = self::_totalIncidentKBByCategory();
        $aIncidentKBs   = self::_listIncidentKB();
        
        $aCategoryList  = array();
        if (count($aCategories)) {
            $currentId          = 0;
            foreach ($aCategories as $arr) {
                if (! $arr['parent_id']) {
                    if ($currentId) {
                        $aMainCat[$currentId]       = implode(',', $aSubCat);
                    }
                    $currentId      = $arr['id'];
                    $aSubCat        = array();
                }
                $level  = substr($arr['level'], 3);
                $level  = preg_replace('/\-/', '&nbsp;', $level);
                $json   = json_encode(array(
                    'label'     => $level .' '. $arr['name'] . 
                                    (($aTotal[$arr['id']]) ? ' ('. $aTotal[$arr['id']] .')' : ''),
                    'value'     => $arr['id']
                    ));
                array_push($aCategoryList, $json);
                array_push($aSubCat, $json);
                
                if (isset($aIncidentKBs[$arr['id']])) {
                    foreach ($aIncidentKBs[$arr['id']] as $arr2) {
                        $json          = json_encode(array(
                            'label'     => '<span style="color:#428CB0">'.$level .' &nbsp;&nbsp;&nbsp; '. $arr2['title'] . ' '.
                                            (! $arr2['is_publish'] ? '<span style="color:red;">(Un-Publsih)</span>': '') .
                                            '</span>',
                            'value'     => $arr['id'] .'.'. $arr2['id']
                            ));
                        array_push($aCategoryList, $json);
                        array_push($aSubCat, $json);
                    }
                }
                
            }
            
            $aMainCat[$currentId]       = implode(',', $aSubCat);
        }
        
        array_push($aCategoryList, $json);
        
        $this->template->assign('categoryList', implode(',', $aCategoryList));
        $this->template->assign('mainCat', $aMainCat);
        
        $result         = $db->query("
                SELECT
                    t2r.*, kb.category_id, c.id AS requestCatId
                FROM
                    sc_ticket_2_request t2r
                    LEFT JOIN in_incident_kb kb
                    ON kb.id = t2r.sc_id
                    LEFT JOIN in_category c
                    ON c.id = kb.category_id
                        AND c.name = 'Request for Incident KB'
                WHERE
                    t2r.ticket_id = :ticketId
                    AND t2r.request_type = 'Incident'
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $this->template->assign('aSelected', $result);
        $selectedId     = isset($result['category_id']) ? $result['category_id'] .'.'. $result['sc_id'] : 0;
        $this->template->assign('selectedId', $selectedId);
        $isServiceRequest       = isset($result['requestCatId']) ? $result['requestCatId']  : 0;
        $this->template->assign('isServiceRequest', $isServiceRequest);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.display_incident_kb.tpl',array(), false);
    }
    
    public function displayChangeManagement ($request)
    {
        $db             = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        
        $result         = $db->query("
                SELECT cr.*, a.domain, ca.email, cd.firstname, cd.lastname, cd.companyname
                FROM sc_ticket_2_request t2r,
                    ch_request cr,
                    hb_accounts a,
                    hb_client_access ca,
                    hb_client_details cd
                WHERE t2r.ticket_id = :ticketId
                    AND t2r.request_type = 'Change'
                    AND cr.ticket_id = t2r.ticket_id
                    AND a.id = cr.account_id
                    AND a.client_id = ca.id
                    AND ca.id = cd.id
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        if (! isset($result['id'])) {
            return false;
        }
        
        $aAccountInfo   = $result;
        $arr            = explode(':', $aAccountInfo['operation_time']);
        $aAccountInfo['operation_time_hour']    = isset($arr[0]) ? $arr[0] : '';
        $aAccountInfo['operation_time_minute']  = isset($arr[1]) ? $arr[1] : '';
        $this->template->assign('aAccountInfo', $aAccountInfo);
        
        $aClient        = array();
        
        $hostname       = isset($aAccountInfo['domain']) ? $aAccountInfo['domain'] : '';
        $result         = self::_changeManagementGetClient($hostname, $aAccountInfo['confirm'], $aAccountInfo['id'], 1);
        $aResult        = $result;
        if (count($aResult)) {
            foreach ($aResult as $arr) {
                $arr['level']   = 1;
                array_push($aClient, $arr);
                
                $result         = self::_changeManagementGetClient($arr['domain'], $aAccountInfo['confirm'], $aAccountInfo['id'], 2);
                if (count($result)) {
                    foreach ($result as $arr2) {
                        $arr2['level']  = 2;
                        array_push($aClient, $arr2);
                    }
                }
                
            }
        }
        
        $this->template->assign('aClient', $aClient);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.display_change_management.tpl',array(), false);
    }
    
    public function updateChangeManagement ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $changeId       = isset($request['change_id']) ? $request['change_id'] : 0;
        $field          = isset($request['field']) ? $request['field'] : '';
        $value          = isset($request['value']) ? $request['value'] : '';
        
        $result         = $db->query("
                SELECT *
                FROM ch_request
                WHERE id = :id
                ", array(
                    ':id'   => $changeId
                ))->fetch();
        
        if ( !isset($result['id'])) {
            echo '<!-- {"ERROR":["ไม่สามารถบันทึกข้อมูล '. $field .' ได้"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $ticketId       = $result['ticket_id'];
        $adminId        = $aAdmin['id'];
        $adminName      = $aAdmin['firstname'];
        $adminEmail     = $aAdmin['email'];
        
        switch ($field) {
            case 'client_confirm'   : {
                $db->query("
                    UPDATE ch_request 
                    SET is_client_confirm = 1, client_confirm_date = NOW() 
                    WHERE id = '{$changeId}'
                    ");
                $db->query("
                    INSERT INTO hb_tickets_notes (
                    id, ticket_id, admin_id, name, email, date, note
                    ) VALUES (
                    '', '{$ticketId}', '{$adminId}', '{$adminName}', '{$adminEmail}', NOW(),
                    '{$adminName} ได้บันทึกว่าลูกค้าได้ทำการยืนยันข้อมูลแล้ว'
                    )
                    ");
                break;
            }
            case 'edm_send'         : {
                $db->query("
                    UPDATE ch_request 
                    SET is_edm_send = 1, edm_send_date = NOW() 
                    WHERE id = '{$changeId}'
                    ");
                $db->query("
                    INSERT INTO hb_tickets_notes (
                    id, ticket_id, admin_id, name, email, date, note
                    ) VALUES (
                    '', '{$ticketId}', '{$adminId}', '{$adminName}', '{$adminEmail}', NOW(),
                    '{$adminName} ได้บันทึกว่าส่ง EDM ถึงลูกค้าแล้ว'
                    )
                    ");
                break;
            }
            case 'start_date'       : 
            case 'end_date'         : {
                $value      = self::_convertStrtotime($value);
                $value      = date('Y-m-d', $value);
                $db->query("
                    UPDATE ch_request 
                    SET {$field} = '{$value}'
                    WHERE id = '{$changeId}'
                    ");
                break;
            }
            case 'note_for_staff'   :
            case 'note_for_client'  :
            case 'operation_time'   :
            case 'start_date_time'  :
            case 'end_date_time'    : {
                $db->query("
                    UPDATE ch_request 
                    SET {$field} = '{$value}'
                    WHERE id = '{$changeId}'
                    ");
                break;
            }
            case 'client_confirm_account'   : {
                $db->query("
                    UPDATE ch_account_relate 
                    SET is_confirm = 1,
                        confirm_date = NOW()
                    WHERE change_request_id = '{$changeId}'
                        AND account_id = '{$value}'
                    ");
                break;
            }
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":["บันทึกข้อมูล '. $field .' เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
    public function exportChangeManagementClient ($request)
    {
        $db             = hbm_db();
        
        $hostname       = isset($request['hostname']) ? $request['hostname'] : '';
        
        $aClient        = array();
        
        $result         = self::_changeManagementGetClient($hostname);
        $aResult        = $result;
        if (count($aResult)) {
            foreach ($aResult as $arr) {
                $arr['level']   = 1;
                array_push($aClient, $arr);
                
                $result         = self::_changeManagementGetClient($arr['domain']);
                if (count($result)) {
                    foreach ($result as $arr2) {
                        $arr2['level']  = 2;
                        array_push($aClient, $arr2);
                    }
                }
                
            }
        }
        
        header("Content-type: text/csv");
        header("Content-Disposition: attachment; filename=email.csv");
        header("Pragma: no-cache");
        header("Expires: 0");
        foreach ($aClient as $arr) {
            echo $arr['email'] ."\n";
        }
        exit;
    }
    
    private function _changeManagementGetClient ($hostname, $confirmType = '', $changeId = 0, $level = 0)
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT id
                FROM hb_servers
                WHERE name = :name
                ", array(
                    ':name'     => $hostname
                ))->fetch();
        
        $serverId       = isset($result['id']) ? $result['id'] : 0;
        
        if (! $serverId) {
            return array();
        }
        
        $result         = $db->query("
                SELECT a.id, a.domain, ca.email, cd.firstname, cd.lastname, cd.companyname,
                    p.name,
                    ar.id AS accountRelateId, ar.is_confirm, ar.confirm_date
                FROM hb_accounts a
                    LEFT JOIN hb_products p ON p.id = a.product_id
                    LEFT JOIN ch_account_relate ar ON ar.account_id =a.id AND ar.change_request_id = '{$changeId}',
                    hb_client_access ca,
                    hb_client_details cd
                WHERE a.server_id = :serverId
                    AND a.status IN ('Active', 'Suspended')
                    AND a.client_id = ca.id
                    AND ca.id = cd.id
                ", array(
                    ':serverId' => $serverId
                ))->fetchAll();
        
        if (! $changeId || $confirmType != 'confirm') {
            return $result;
        }
        
        foreach ($result as $arr) {
            if (! $arr['accountRelateId']) {
                $db->query("
                    INSERT INTO ch_account_relate (
                    id, change_request_id, account_id, level
                    ) VALUES (
                    '', :changeId, :accountId, :level
                    )
                    ", array(
                        ':changeId'     => $changeId,
                        ':accountId'    => $arr['id'],
                        ':level'        => $level
                    ));
            }
        }
        
        return $result;
    }
    
    public function noticChangeManagement ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        
        $result         = $db->query("
                SELECT
                    cr.*, a.domain
                FROM
                    hb_tickets t,
                    hb_accounts a,
                    ch_request cr
                WHERE
                    t.id = :ticketId
                    AND t.client_id = a.client_id
                    AND a.id = cr.account_id
                
                UNION
                
                SELECT
                    cr.*, a.domain
                FROM
                    hb_tickets t,
                    hb_accounts a,
                    ch_account_relate car,
                    ch_request cr
                WHERE
                    t.id = :ticketId
                    AND t.client_id = a.client_id
                    AND a.id = car.account_id
                    AND car.change_request_id = cr.id
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetchAll();
        
        $aChange        = $result;
        $aNotic         = array();
        
        if (count($aChange)) {
            foreach ($aChange as $arr) {
                $id     = $arr['ticket_id'];
                $result = $db->query("
                    SELECT t.id, t.status, t.ticket_number
                    FROM sc_ticket_2_request t2r,
                        hb_tickets t
                    WHERE t2r.ticket_id = :id
                        AND t2r.ticket_id != :ticketId
                        AND t2r.ticket_id = t.id
                        AND t.status != 'Closed'
                    ", array(
                        ':id'           => $id,
                        ':ticketId'     => $ticketId
                    ))->fetch();
                if (! isset($result['id'])) {
                    continue;
                }
                $arr['status']          = $result['status'];
                $arr['ticket_number']   = $result['ticket_number'];
                array_push($aNotic, $arr);
            }
        }
        
        $this->template->assign('aNotic', $aNotic);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.notic_change_management.tpl',array(), false);
    }
    
    private function _listServiceCatalog ()
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT sc.*
                FROM sc_service_catalog sc
                WHERE sc.category_id >= 1
                    AND sc.is_delete = 0
                ORDER BY sc.is_publish DESC, sc.orders ASC, sc.modified DESC
                ")->fetchAll();
        
        $aList          = array();
        foreach ($result as $arr) {
            $catId      = $arr['category_id'];
            if (! is_array($aList[$catId])) {
                $aList[$catId]  = array();
            }
            array_push($aList[$catId], $arr);
        }
        
        return $aList;
    }
    
    private function _listIncidentKB ()
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT kb.*
                FROM in_incident_kb kb
                WHERE kb.category_id >= 1
                    AND kb.is_delete = 0
                ORDER BY kb.is_publish DESC, kb.orders ASC, kb.modified DESC
                ")->fetchAll();
        
        $aList          = array();
        foreach ($result as $arr) {
            $catId      = $arr['category_id'];
            if (! is_array($aList[$catId])) {
                $aList[$catId]  = array();
            }
            array_push($aList[$catId], $arr);
        }
        
        return $aList;
    }
    
    private function _getCategory ($type = '')
    {
        $db             = hbm_db();
        
        $table          = ($type == 'incidentKB') ? 'in_category' : 'sc_category';
        
        $result         = $db->query("
                SELECT c.*
                FROM {$table} c
                ORDER BY c.orders ASC
                ")->fetchAll();
        
        $aCategory      = array();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $catId          = $arr['id'];
                $parentId       = $arr['parent_id'];
                $aCategory[$parentId][$catId]      = $arr;
            }
        }
        
        return $aCategory;
    }
    
    private function _listCategory ($aLists, $aCategory, $parentId = 0, $level = 0)
    {
        if (! count($aCategory[$parentId])) {
            return $aLists;
        }
        
        $level++;
        $aCategory_temp     = $aCategory[$parentId];
        
        foreach ($aCategory_temp as $catId => $arr) {
            $arr['level']   = str_repeat('--- ', $level);
            array_push($aLists, $arr);
            $aLists         = self::_listCategory($aLists, $aCategory, $catId, $level);
        }
        
        return $aLists;
    }
    
    private function _totalServiceCatalogByCategory ()
    {
        $db             = hbm_db();
        
        $aTotal         = array();
        
        $result         = $db->query("
                SELECT COUNT(sc.id) AS total, sc.category_id
                FROM sc_service_catalog sc
                WHERE sc.is_delete = 0
                GROUP BY sc.category_id
                ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aTotal[$arr['category_id']]    = $arr['total'];
            }
        }
        
        return $aTotal;
    }
    
    private function _totalIncidentKBByCategory ()
    {
        $db             = hbm_db();
        
        $aTotal         = array();
        
        $result         = $db->query("
                SELECT COUNT(kb.id) AS total, kb.category_id
                FROM in_incident_kb kb
                WHERE kb.is_delete = 0
                GROUP BY kb.category_id
                ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aTotal[$arr['category_id']]    = $arr['total'];
            }
        }
        
        return $aTotal;
    }
    
    public function listServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $scId           = 0;
        $aCatId         = explode('.', ''. $catId .'');
        if (isset($aCatId[1])) {
            $catId      = $aCatId[0];
            $scId       = $aCatId[1];
        }
        
        $this->template->assign('ticketId', $ticketId);
        $this->template->assign('catId', $catId);
        $this->template->assign('scId', $scId);
        
        $aCategory      = self::_getCategory();
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        $aPath          = self::_pathWay($aCategories, $catId);
        krsort($aPath);
        $catName        = '';
        foreach ($aPath as $arr) {
            $catName    .= ' &gt; ' . $arr['name'];
        }
        $this->template->assign('catName', $catName);
        
        $result         = $db->query("
                SELECT
                    sc.id, sc.title, sc.is_publish, sc.staff_id, sc.description, 
                    tm.level, ad.firstname
                FROM
                    sc_service_catalog sc
                    LEFT JOIN sc_team_member tm
                        ON tm.staff_id = sc.staff_id
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = sc.staff_id
                WHERE
                    sc.category_id = :catId
                    AND sc.is_delete = 0
                ORDER BY sc.orders ASC, sc.modified DESC
                ", array(
                    ':catId'        => $catId
                ))->fetchAll();
        
        $this->template->assign('aLists', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.list_service_catalog.tpl',array(), false);
    }
    
    public function listIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $scId           = 0;
        $aCatId         = explode('.', ''. $catId .'');
        if (isset($aCatId[1])) {
            $catId      = $aCatId[0];
            $scId       = $aCatId[1];
        }
        
        $this->template->assign('ticketId', $ticketId);
        $this->template->assign('catId', $catId);
        $this->template->assign('scId', $scId);
        
        $aCategory      = self::_getCategory('incidentKB');
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        $aPath          = self::_pathWay($aCategories, $catId);
        krsort($aPath);
        $catName        = '';
        foreach ($aPath as $arr) {
            $catName    .= ' &gt; ' . $arr['name'];
        }
        $this->template->assign('catName', $catName);
        
        $result         = $db->query("
                SELECT
                    kb.*,
                    tm.level, ad.firstname
                FROM
                    in_incident_kb kb
                    LEFT JOIN sc_team_member tm
                        ON tm.staff_id = kb.staff_id
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = kb.staff_id
                WHERE
                    kb.category_id = :catId
                    AND kb.is_delete = 0
                ORDER BY kb.orders ASC, kb.modified DESC
                ", array(
                    ':catId'        => $catId
                ))->fetchAll();
        
        $this->template->assign('aLists', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.list_incident_kb.tpl',array(), false);
    }
    
    public function viewServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $scId           = isset($request['scId']) ? $request['scId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        $this->template->assign('catId', $catId);
        $this->template->assign('scId', $scId);
        
        $aCategory      = self::_getCategory();
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        $aPath          = self::_pathWay($aCategories, $catId);
        krsort($aPath);
        $catName        = '';
        foreach ($aPath as $arr) {
            $catName    .= ' &gt; ' . $arr['name'];
        }
        
        $result         = $db->query("
                SELECT
                    sc.*,
                    ad.firstname,
                    b.service_detail, b.request_permission, b.request_order, b.order_time_available, b.delivery_time,
                    b.price_rate, b.service_related, b.service_policy, b.sale_person, b.warranty_rate,
                    t.recovery_info, t.emergency_info
                FROM
                    sc_service_catalog sc
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = sc.staff_id
                    LEFT JOIN sc_business b
                        ON b.id = sc.id
                    LEFT JOIN sc_technical t
                        ON t.id = sc.id
                WHERE
                    sc.id = :scId
                ", array(
                    ':scId'     => $scId
                ))->fetch();
        
        $aData          = isset($result['id']) ? $result : array();
        $aData['catName']   = $catName;
        
        $endingSLA      = self::_slaRemaining($ticketId, $scId);
        $aData['endingSLA'] = date('Y/m/d H:i', $endingSLA);
        
        $result         = self::_getEscalationPolicy($aData['staff_id']);
        $aData['escalationPolicy']  = isset($result['policy_'. $aData['escalation_policy']])
                        ? $result['policy_'. $aData['escalation_policy']] : '--- ไม่ระบุ ---';
        
        $this->template->assign('aData', $aData);
        
        $result         = $db->query("
                SELECT rtg.*, ad.firstname, 'is_global'
                FROM sc_reply_template_global rtg,
                    hb_admin_details ad
                WHERE rtg.staff_id = ad.id
                    AND rtg.is_delete = 0
                ORDER BY rtg.orders ASC
                ")->fetchAll();
        
        $aReplies       = $result;
        
        $result         = $db->query("
                SELECT rt.*, ad.firstname
                FROM sc_reply_template rt
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = rt.staff_id,
                    sc_catalog_2_template c2t
                WHERE c2t.sc_id = :scId
                    AND c2t.rt_id = rt.id
                ORDER BY rt.subject ASC
                ", array(
                    ':scId'     => $scId
                ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aReplies, $arr);
            }
        }
        
        $this->template->assign('aReplies', $aReplies);
        
        $result         = $db->query("
                SELECT
                    pg.*
                FROM
                    sc_process_group pg
                WHERE
                    pg.sc_id = :scId
                ORDER BY
                    pg.orders
                ", array(
                    ':scId'     => $scId
                ))->fetchAll();
        
        $this->template->assign('aProcessGroup', $result);
        
        /***/
        $isInprogressFulfillment = false;
        
        $result =	$db->query("
        		SELECT 
        			tf.*
        		FROM
        			sc_ticket_fulfillment tf
        		WHERE
        			tf.ticket_id = :ticket_id
        			AND tf.is_cancel = 0
        			", array(
        				':ticket_id'	=>	$ticketId
        		))->fetchAll();
        
		if(count($result)){
			$isInprogressFulfillment = true;
			$ticketFulfillmentId = $result[0]['id'];
		}
				
		$this->template->assign('currentFulfillmentData', $result[0]);
		$this->template->assign('isInprogressFulfillment', $isInprogressFulfillment);
		
		$result	=	$db->query("
					SELECT
						* , tt.name as team_name , ta.id as activity_id , CONCAT(ad.firstname , ' ' , ad.lastname) as staff_name , ta.staff_id as activity_staff_id
					FROM
						sc_ticket_activity ta , sc_ticket_team tt , sc_ticket_fulfillment tf , sc_process_task pt , hb_admin_details ad
					WHERE
						tf.id = tt.ticket_fulfillment_id
						AND tt.id = ta.ticket_team_id
						AND ta.process_task_id = pt.id
						AND tf.ticket_id = :ticket_id
        				AND tf.is_cancel = 0
        				AND ad.id = ta.staff_id
        				ORDER BY ta.orders
				", array(
        				':ticket_id'	=>	$ticketId
        		))->fetchAll();
		
		$this->template->assign('currentActivityData', $result);
		
		$result = $db->query("
						SELECT
							*	
						FROM
							sc_ticket_fulfillment_attachment
						WHERE
							ticket_fulfillment_id = :ticketFulfillmentId
						" ,array(
							':ticketFulfillmentId'		=>	$ticketFulfillmentId
						))->fetchAll();
		if(count($result)){
			$this->template->assign('haveAttachment', true);
			$this->template->assign('fulfillmentAttachment', $result);
			$this->template->assign('imgExt', array('.jpg', '.jpeg', '.gif', '.png'));
		}
		
		$result	= $db->query("
							SELECT
								tac.* , afv.value as adminAvatar
							FROM
								sc_ticket_activity_comment tac , hb_admin_fields_values afv
							WHERE
								tac.ticket_id = :ticketId
								AND tac.is_delete = 0
								AND tac.staff_id = afv.admin_id
								AND afv.field_id = 2
								ORDER BY tac.date ASC
						", array(
							':ticketId'		=>	$ticketId
						))->fetchAll();
						
		if(count($result)){
			$this->template->assign('aActivityCommentData',$result);
		}
		
		$result = $db->query("
							SELECT
								ad.id as adminId , ad.firstname as adminName , CONCAT(ad.firstname , ' ' , ad.lastname) as adminFullName , ad.email as adminEmail , afv.value as adminAvatar
							FROM 
								hb_admin_access aa , hb_admin_details ad , hb_admin_fields_values afv
							WHERE
								aa.status = 'Active'
								AND aa.id = ad.id
								AND aa.id = afv.admin_id
								AND afv.field_id = 2
								ORDER BY ad.firstname ASC
						")->fetchAll();
		$this->template->assign('staff_members', $result);
		
	 	$aAssign        = array();        
        $result         = $db->query("
                SELECT t.id AS teamId, t.name AS teamName,
                    tm.staff_id, tm.level, ad.firstname
                FROM sc_team t,
                    sc_team_member tm,
                    hb_admin_details ad
                WHERE
                    t.id = tm.team_id
                    AND tm.staff_id = ad.id
                ORDER BY t.name ASC, tm.level ASC, ad.firstname ASC
                ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $teamId         = $arr['teamId'];
                $staffId        = $arr['staff_id'];
                
                if (! isset($aAssign[$teamId])) {
                    $aAssign[$teamId]   = array(
                        'team'          => $arr['teamName'],
                        'staff'         => array(),
                        );
                }
                
                $aAssign[$teamId]['staff'][$staffId]    = array(
                    'firstname'     => $arr['firstname'],
                    'level'         => $arr['level'],
                    );
                
            }
        }
		$this->template->assign('aAssign', $aAssign);
		
        /***/
        
        
        $aProcess       = array();
        
        $result         = $db->query("
                SELECT
                    c2t.*, pt.name, pt.assign_team_id, pt.assign_staff_id, pt.ola_in_minute,
                    t.name AS teamName, ad.firstname
                FROM
                    sc_catalog_2_task c2t,
                    sc_process_task pt,
                    sc_process_group pg,
                    sc_team t,
                    hb_admin_details ad
                WHERE
                    c2t.sc_id = :scId
                    AND c2t.pt_id = pt.id
                    AND c2t.pg_id = pg.id
                    AND pt.assign_team_id = t.id
                    AND pt.assign_staff_id = ad.id
                ORDER BY pg.orders ASC, c2t.orders ASC
                ", array(
                    ':scId'     => $scId,
                ))->fetchAll();
        
        if (count($result)) {
            $idx        = 0;
            $name       = $result[0]['teamName'];
            
            foreach ($result as $arr) {
                $groupId        = $arr['pg_id'];
                $taskId         = $arr['id'];
                
                if (! is_array($aProcess[$groupId])) {
                    $aProcess[$groupId]     = array();
                }
                
                if ($arr['teamName'] != $name) {
                    $name       = $arr['teamName'];
                    $idx++;
                }
                
                if (! is_array($aProcess[$groupId][$idx])) {
                    $aProcess[$groupId][$idx]   = array(
                        'team'      => $arr['teamName'],
                        'task'      => array(),
                        );
                }
                
                $aProcess[$groupId][$idx]['task'][$taskId]  = $arr;
            }
            
        }
        $this->template->assign('aProcess', $aProcess);
        
        $result         = self::_getSelectedRequest($ticketId);
        $this->template->assign('aSelected', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.view_service_catalog.tpl',array(), false);
    }
    
    public function viewIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $scId           = isset($request['scId']) ? $request['scId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        $this->template->assign('catId', $catId);
        $this->template->assign('scId', $scId);
        
        $aCategory      = self::_getCategory('incidentKB');
        $aCategories    = array();
        $aCategories    = self::_listCategory($aCategories, $aCategory);
        $aPath          = self::_pathWay($aCategories, $catId);
        krsort($aPath);
        $catName        = '';
        foreach ($aPath as $arr) {
            $catName    .= ' &gt; ' . $arr['name'];
        }
        
        $result         = $db->query("
                SELECT
                    kb.*,
                    ad.firstname
                FROM
                    in_incident_kb kb
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = kb.staff_id
                WHERE
                    kb.id = :scId
                ", array(
                    ':scId'     => $scId
                ))->fetch();
        
        $aData          = isset($result['id']) ? $result : array();
        $aData['catName']   = $catName;
        
        $endingSLA      = self::_slaRemaining($ticketId, $scId, 'incidentKB');
        $aData['endingSLA'] = date('Y/m/d H:i', $endingSLA);
        
        $result         = self::_getEscalationPolicy($aData['staff_id']);
        $aData['escalationPolicy']  = isset($result['policy_'. $aData['escalation_policy']])
                        ? $result['policy_'. $aData['escalation_policy']] : '--- ไม่ระบุ ---';
        
        $this->template->assign('aData', $aData);
        
        $result         = $db->query("
                SELECT rtg.*, ad.firstname, 'is_global'
                FROM sc_reply_template_global rtg,
                    hb_admin_details ad
                WHERE rtg.staff_id = ad.id
                    AND rtg.is_delete = 0
                ORDER BY rtg.orders ASC
                ")->fetchAll();
        
        $aReplies       = $result;
        
        $result         = $db->query("
                SELECT rt.*, ad.firstname
                FROM sc_reply_template rt
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = rt.staff_id,
                    in_incident_2_template i2t
                WHERE i2t.in_id = :inId
                    AND i2t.rt_id = rt.id
                ORDER BY rt.subject ASC
                ", array(
                    ':inId'     => $scId
                ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aReplies, $arr);
            }
        }
        
        $this->template->assign('aReplies', $aReplies);
        
        $result         = self::_getSelectedRequest($ticketId);
        
        $this->template->assign('aSelected', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.view_incident_kb.tpl',array(), false);
    }
    
    private function _getSelectedRequest ($ticketId)
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT
                    t2r.*, 
                    IF (sc.title, sc.title, kb.title) AS title,
                    IF (sc.category_id, sc.category_id, kb.category_id) AS category_id,
                    UNIX_TIMESTAMP(t2r.resume_date) AS resumeDate, UNIX_TIMESTAMP(t2r.start_date) AS startDate,
                    UNIX_TIMESTAMP(t2r.end_date) AS endDate
                FROM
                    sc_ticket_2_request t2r
                    LEFT JOIN in_incident_kb kb
                        ON kb.id = t2r.sc_id
                        AND t2r.request_type = 'Incident'
                    LEFT JOIN sc_service_catalog sc
                        ON sc.id = t2r.sc_id
                        AND t2r.request_type = 'Service Request'
                WHERE
                    t2r.ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        return $result;
    }
    
    private function _getEscalationPolicy ($staffId)
    {
        $db             = hbm_db();
        
        $result         = $db->query("
                SELECT tm.*, t.manager, ad.firstname
                FROM sc_team_member tm
                    LEFT JOIN sc_team t
                        ON t.id = tm.team_id
                    LEFT JOIN hb_admin_details ad
                        ON tm.staff_id = ad.id
                WHERE tm.staff_id = :staffId
                ", array(
                    ':staffId'      => $staffId
                ))->fetch();
        
        if (isset($result['id'])) {
            $owner              = $result['firstname'];
            $manager            = $result['manager'];
            for ($i = 1; $i <= 3; $i++) {
                $result['policy_'. $i]  = $result['escalation_policy_'. $i];
                $result['policy_'. $i]  = preg_replace('/\{\$manager\}/', '<u>'. $manager .'</u>', $result['policy_'. $i]);
                $result['policy_'. $i]  = preg_replace('/\{\$owner\}/', '<u>'. $owner .'</u>', $result['policy_'. $i]);
            }
        }
        
        return $result;
    }
    
    private function _slaRemaining ($ticketId, $scId, $type = '')
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        
        $result         = $db->query("
                SELECT t.id, t.date
                FROM hb_tickets t
                WHERE t.id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $startDate      = isset($result['date']) ? strtotime($result['date']) : time();
        $typeName       = ($type == 'incidentKB') ? 'Incident' : 'Service Request';
        $table          = ($type == 'incidentKB') ? 'in_incident_kb' : 'sc_service_catalog';
        
        $result         = $db->query("
                SELECT
                    t2r.*
                FROM
                    sc_ticket_2_request t2r
                WHERE
                    t2r.ticket_id = :ticketId
                    AND t2r.sc_id = :scId
                ", array(
                    ':ticketId'     => $ticketId,
                    ':scId'         => $typeName
                ))->fetch();
        
        if (! isset($result['sla_in_minute'])) {
            $result     = $db->query("
                    SELECT id, sla_in_minute
                    FROM {$table}
                    WHERE id = :scId
                    ", array(
                        ':scId'         => $scId
                    ))->fetch();
        }
        
        $sla            = isset($result['sla_in_minute']) ? $result['sla_in_minute'] : 0;
        
        $endDate        = $startDate + ($sla*60);
        
        return $endDate;
    }
    
    private function _pathWay ($aCategories, $catId, $aPath = array())
    {
        if (! count($aCategories)) {
            return $aPath;
        }
        
        $aCategories_       = $aCategories;
        foreach ($aCategories_ as $arr) {
            if ($arr['id'] == $catId) {
                array_push($aPath, $arr);
                $aPath  = self::_pathWay($aCategories, $arr['parent_id'], $aPath);
                break;
            }
        }
        
        return $aPath;
    }
    
    public function viewTaskDetail ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $scId           = isset($request['scId']) ? $request['scId'] : 0;
        $taskId         = isset($request['taskId']) ? $request['taskId'] : 0;
        $this->template->assign('ticketId', $ticketId);
        $this->template->assign('scId', $scId);
        $this->template->assign('taskId', $taskId);
        
        
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.view_task_detail.tpl',array(), false);
    }
    
    public function useThisServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $scId           = isset($request['scId']) ? $request['scId'] : 0;
        
        $result         = $db->query("
                SELECT t.id
                FROM hb_tickets t
                WHERE t.id = :ticketId
                    AND t.status = 'Closed'
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        if (isset($result['id'])) {
            echo '<!-- {"ERROR":["ไม่อนุญาติให้ดำเนินการต่อ เนื่องจาก Ticket#'. $ticketId .' มีสถาณะ Closed"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $request['requestType']     = 'Service Request';
        self::selectRequest($request);
        
        $result         = $db->query("
                SELECT * 
                FROM sc_service_catalog 
                WHERE id = :id
                ", array(
                    ':id'   => $scId
                ))->fetch();
        
        $aCatalog       = isset($result['id']) ? $result : array();
        
        $log            = 'Staff#'. $aAdmin['firstname'] .' use service catalog #'. $aCatalog['id']  
                        .' '. $aCatalog['title'];
        
        $result         = $db->query("
                SELECT * ,
                    UNIX_TIMESTAMP(resume_date) AS resumeDate, UNIX_TIMESTAMP(start_date) AS startDate
                FROM sc_ticket_2_request 
                WHERE ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $relId          = 0;
        $aSelected      = isset($result['ticket_id']) ? $result : array();
        
        if ($aSelected['ticket_id']) {
            $log        = 'Staff#'. $aAdmin['firstname'] .' change service catalog to #'. $aCatalog['id']  
                        .' '. $aCatalog['title'];
            
            $db->query("
                    UPDATE sc_ticket_2_request_log
                    SET end_date = NOW()
                    WHERE id = :id
                    ", array(
                        ':id'       => $aSelected['rel_id']
                    ));
            
        }
        
        $db->query("
                INSERT INTO sc_ticket_2_request_log (
                    id, ticket_id, staff_id, event, start_date, logs, rel_id
                ) VALUES (
                    '', :ticketId, :staffId, 'Use Service Catalog', NOW(), :log, :relId
                )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':staffId'      => $aAdmin['id'],
                    ':log'          => $log,
                    ':relId'        => $aSelected['rel_id'],
                ));
        
        $result         = $db->query("SELECT MAX(id) AS id FROM sc_ticket_2_request_log ")->fetch();
        $id             = isset($result['id']) ? $result['id'] : 0;
        
        $startDate      = date('Y-m-d H:i:s');
        $resumeDate     = 'NULL';
        
        if ($aSelected['ticket_id']) {
            $startDate      = $aSelected['start_date'];
            $resumeDate     = $aSelected['is_pause'] ? date('Y-m-d H:i:s') : $aSelected['resume_date'];
            
        }
        
        $db->query("
                UPDATE sc_ticket_2_request 
                SET
                    start_date = :startDate,
                    resume_date = :resumeDate,
                    is_pause = 0,
                    sc_id = :scId,
                    rel_id = :relId,
                    sla_in_minute = :sla
                WHERE
                    ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId,
                    ':startDate'    => $startDate,
                    ':resumeDate'   => $resumeDate,
                    ':scId'         => $scId,
                    ':relId'        => $id,
                    ':sla'          => $aCatalog['sla_in_minute']
                ));
        
        echo '<!-- {"ERROR":[],"INFO":["เลือก Service Catalog เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function useThisIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $kbId           = isset($request['kbId']) ? $request['kbId'] : 0;
        
        $result         = $db->query("
                SELECT t.id
                FROM hb_tickets t
                WHERE t.id = :ticketId
                    AND t.status = 'Closed'
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        if (isset($result['id'])) {
            echo '<!-- {"ERROR":["ไม่อนุญาติให้ดำเนินการต่อ เนื่องจาก Ticket#'. $ticketId .' มีสถาณะ Closed"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $request['requestType']     = 'Incident';
        self::selectRequest($request);
        
        $result         = $db->query("
                SELECT * 
                FROM in_incident_kb 
                WHERE id = :id
                ", array(
                    ':id'   => $kbId
                ))->fetch();
        
        $aKB            = isset($result['id']) ? $result : array();
        
        $log            = 'Staff#'. $aAdmin['firstname'] .' use Incident KB #'. $aKB['id']  
                        .' '. $aKB['title'];
        
        $result         = $db->query("
                SELECT * ,
                    UNIX_TIMESTAMP(resume_date) AS resumeDate, UNIX_TIMESTAMP(start_date) AS startDate
                FROM sc_ticket_2_request 
                WHERE ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $relId          = 0;
        $aSelected      = isset($result['ticket_id']) ? $result : array();
        
        if ($aSelected['ticket_id']) {
            $log        = 'Staff#'. $aAdmin['firstname'] .' change Incident KB to #'. $aKB['id']  
                        .' '. $aKB['title'];
            
            $db->query("
                    UPDATE sc_ticket_2_request_log
                    SET end_date = NOW()
                    WHERE id = :id
                    ", array(
                        ':id'       => $aSelected['rel_id']
                    ));
            
        }
        
        $db->query("
                INSERT INTO sc_ticket_2_request_log (
                    id, ticket_id, staff_id, event, start_date, logs, rel_id
                ) VALUES (
                    '', :ticketId, :staffId, 'Use Incident KB', NOW(), :log, :relId
                )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':staffId'      => $aAdmin['id'],
                    ':log'          => $log,
                    ':relId'        => $aSelected['rel_id'],
                ));
        
        $result         = $db->query("SELECT MAX(id) AS id FROM sc_ticket_2_request_log ")->fetch();
        $id             = isset($result['id']) ? $result['id'] : 0;
        
        $startDate      = date('Y-m-d H:i:s');
        $resumeDate     = 'NULL';
        
        if ($aSelected['ticket_id']) {
            $startDate      = $aSelected['start_date'];
            $resumeDate     = $aSelected['is_pause'] ? date('Y-m-d H:i:s') : $aSelected['resume_date'];
        }
        
        $db->query("
                UPDATE sc_ticket_2_request 
                SET
                    start_date = :startDate,
                    resume_date = :resumeDate,
                    is_pause = 0,
                    sc_id = :scId,
                    rel_id = :relId,
                    sla_in_minute = :sla
                WHERE
                    ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId,
                    ':startDate'    => $startDate,
                    ':resumeDate'   => $resumeDate,
                    ':scId'         => $kbId,
                    ':relId'        => $id,
                    ':sla'          => $aKB['sla_in_minute']
                ));
        
        echo '<!-- {"ERROR":[],"INFO":["เลือก Incident KB เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function requestForServiceCatalog ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result         = $db->query("
                SELECT c.*
                FROM sc_category c
                WHERE c.name = 'Request for Service Catalog'
                ")->fetch();
        
        $catId          = isset($result['id']) ? $result['id'] : 0;
        
        if (! $catId) {
            echo '<!-- {"ERROR":["ไม่สามารถหาหมวด Request for Service Catalog ได้"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $result         = $db->query("
                SELECT t2r.*
                FROM sc_ticket_2_request t2r
                WHERE t2r.ticket_id = :ticketId
                    AND t2r.sc_id != 0
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        if (isset($result['ticket_id'])) {
            echo '<!-- {"ERROR":["Ticket#'. $ticketId .' นี้มีการ request service catalog ไปแล้ว"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tickets t
                WHERE t.id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $aTicket        = $result;
        $title          = 'Staff#'. $aAdmin['firstname'] .' request Service Catalog for Ticket#'. 
                        $aTicket['ticket_number'] .' ';
        $desc           = 'ดูรายละเอียดเพิ่มเติมที่ https://netway.co.th/7944web/?cmd=ticketviews&tview=5#'.
                        $aTicket['ticket_number'] .' ';
        
        $db->query("
                INSERT INTO sc_service_catalog (
                    id, category_id, staff_id, title, description, modified
                ) VALUES (
                    '', :catId, :staffId, :title, :desc, NOW()
                )
                ", array(
                    ':catId'        => $catId,
                    ':staffId'      => 34, // passaraporn@netway.co.th
                    ':title'        => $title,
                    ':desc'         => $desc,
                ));
        
        $result         = $db->query("SELECT MAX(id) AS id FROM sc_service_catalog ")->fetch();
        $id             = isset($result['id']) ? $result['id'] : 0;
        $request['scId']    = $id;
        
        self::useThisServiceCatalog($request);
        
        $html       = '
                เจ้าหน้าที่ Staff#'. $aAdmin['firstname'] .' แจ้งให้สร้าง service catalog สำหรับรองรับ <br />
                Ticket: 
                <a href="https://netway.co.th/7944web/?cmd=tickets&action=view&num='. $aTicket['ticket_number'] .'"
                    >https://netway.co.th/7944web/?cmd=tickets&action=view&num='. $aTicket['ticket_number'] .'</a> <br />
                สามารถเข้าไปแก้ไข Service catalog ที่ถูกสร้างขึ้นอัตโนมัติจากระบบได้ที่ <br />
                <a href="https://netway.co.th/7944web/?cmd=servicecataloghandle&action=view&id='. $id .'"
                    >https://netway.co.th/7944web/?cmd=servicecataloghandle&action=view&id='. $id .'</a> <br />
                <br /><br />
                <u>หมายเหตุ</u><br />
                คุณสามารถแก้ไขเพื่อให้ เป็น service catalog template ที่สามารถนำไปใช้ได้ <br />
                หรือลบทิ้งหากมี service catalog ที่พูดถึงเรื่องเดียวกันนี้แล้ว <br />
                หรือเปลี่ยนผู้รับผิดชอบ service catalog เพื่อให้เขาไปดำเนินการปรับปรุงต่อไป <br />
                ควรแจ้งผู้ที่เกี่ยวข้องทุกครั้งหากมีการเปลี่ยนแปลง <br />
                <br />
                ';
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/html; charset=utf-8' . "\r\n" .
                'From: admin@netway.co.th' . "\r\n" .
                'Reply-To: admin@netway.co.th' . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        @mail('passaraporn@netway.co.th', 'Request for service catalog #'. $aTicket['ticket_number'], $html, $header);
        
        echo '<!-- {"ERROR":[],"INFO":["เลือก Service Catalog เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function requestForIncidentKB ($request)
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result         = $db->query("
                SELECT c.*
                FROM in_category c
                WHERE c.name = 'Request for Incident KB'
                ")->fetch();
        
        $catId          = isset($result['id']) ? $result['id'] : 0;
        
        if (! $catId) {
            echo '<!-- {"ERROR":["ไม่สามารถหาหมวด Request for Incident KB ได้"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $result         = $db->query("
                SELECT t2r.*
                FROM sc_ticket_2_request t2r
                WHERE t2r.ticket_id = :ticketId
                    AND t2r.sc_id != 0
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        if (isset($result['ticket_id'])) {
            echo '<!-- {"ERROR":["Ticket#'. $ticketId .' นี้มีการ request Incident KB ไปแล้ว"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tickets t
                WHERE t.id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $aTicket        = $result;
        $title          = 'Staff#'. $aAdmin['firstname'] .' request Incident KB for Ticket#'. 
                        $aTicket['ticket_number'] .' ';
        $desc           = 'ดูรายละเอียดเพิ่มเติมที่ https://netway.co.th/7944web/?cmd=ticketviews&tview=5#'.
                        $aTicket['ticket_number'] .' ';
        
        $db->query("
                INSERT INTO in_incident_kb (
                    id, category_id, staff_id, title, description, modified
                ) VALUES (
                    '', :catId, :staffId, :title, :desc, NOW()
                )
                ", array(
                    ':catId'        => $catId,
                    ':staffId'      => 6, // thirawat@netway.co.th
                    ':title'        => $title,
                    ':desc'         => $desc,
                ));
        
        $result         = $db->query("SELECT MAX(id) AS id FROM in_incident_kb ")->fetch();
        $id             = isset($result['id']) ? $result['id'] : 0;
        $request['kbId']    = $id;
        
        self::useThisIncidentKB($request);
        
        $html       = '
                เจ้าหน้าที่ Staff#'. $aAdmin['firstname'] .' แจ้งให้สร้าง Incident KB สำหรับรองรับ <br />
                Ticket: 
                <a href="https://netway.co.th/7944web/?cmd=tickets&action=view&num='. $aTicket['ticket_number'] .'"
                    >https://netway.co.th/7944web/?cmd=tickets&action=view&num='. $aTicket['ticket_number'] .'</a> <br />
                สามารถเข้าไปแก้ไข Incident KB ที่ถูกสร้างขึ้นอัตโนมัติจากระบบได้ที่ <br />
                <a href="https://netway.co.th/7944web/?cmd=servicecataloghandle&action=viewIncidentKB&id='. $id .'"
                    >https://netway.co.th/7944web/?cmd=servicecataloghandle&action=viewIncidentKB&id='. $id .'</a> <br />
                <br /><br />
                <u>หมายเหตุ</u><br />
                คุณสามารถแก้ไขเพื่อให้ เป็น Incident KB ที่สามารถนำไปใช้ได้ <br />
                หรือลบทิ้งหากมี Incident KB ที่พูดถึงเรื่องเดียวกันนี้แล้ว <br />
                หรือเปลี่ยนผู้รับผิดชอบ Incident KB เพื่อให้เขาไปดำเนินการปรับปรุงต่อไป <br />
                ควรแจ้งผู้ที่เกี่ยวข้องทุกครั้งหากมีการเปลี่ยนแปลง <br />
                <br />
                ';
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/html; charset=utf-8' . "\r\n" .
                'From: admin@netway.co.th' . "\r\n" .
                'Reply-To: admin@netway.co.th' . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        @mail('thirawat@netway.co.th', 'Request for Incident KB #'. $aTicket['ticket_number'], $html, $header);
        
        echo '<!-- {"ERROR":[],"INFO":["เลือก Incident KB เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
	
	public function startFulfillment($request){
		
		$db             = hbm_db();
		
		$ticketId			=	isset($request['ticketId']) ? $request['ticketId'] : 0 ;
		$serviceCatalogId	=	isset($request['serviceCatalogId']) ? $request['serviceCatalogId'] : 0 ;
		$processGroupId		=	isset($request['processGroupId']) ? $request['processGroupId'] : 0 ;
		$processGroupName	=	isset($request['processGroupName']) ? $request['processGroupName'] : '' ;
		
		$result	=	$db->query("
						SELECT
							t.date
						FROM
							hb_tickets t
						WHERE
							id = :ticketId
					", array(
						':ticketId'		=>	$ticketId
					))->fetch();
		$ticketDate	=	$result['date'];
		
		$result	=	$db->query("
						SELECT
							tf.*
						FROM
							sc_ticket_fulfillment tf
						WHERE
							tf.ticket_id = :ticketId
							AND tf.process_group_id = :processGroupId
					", array(
						':ticketId'			=> $ticketId,
						':processGroupId'	=> $processGroupId
					))->fetchAll();
					
		if(count($result)){ //ถ้า process group นั้นถูก startfulfillment ไว้แล้ว
			
			$db->query("
					UPDATE
						sc_ticket_2_request
					SET
						is_fulfillment = 1
					WHERE
						ticket_id = :ticketId
					", array(
						':ticketId'		=>	$ticketId
					));
			
			$db->query("
					UPDATE
						sc_ticket_fulfillment tf
					SET
						is_cancel = 0
					WHERE
						tf.ticket_id = :ticketId
						AND tf.process_group_id = :processGroupId
					", array(
						':ticketId'			=> $ticketId,
						':processGroupId'	=> $processGroupId
					));
					
			$result	=	$db->query("
								SELECT 
									id
								FROM
									sc_ticket_fulfillment
								WHERE
									ticket_id = :ticket_id
									AND is_cancel = 0
								", array(
									':ticket_id'			=> $ticketId
								))->fetch();	
								
			$ticket_fulfillment_id = $result['id'];
			$maxTicketFulfillmentId = $ticket_fulfillment_id;
					
			$result	=	$db->query("
								SELECT DISTINCT
									t.*
								FROM
									sc_process_task pt, sc_catalog_2_task ct , sc_team t
								WHERE
									ct.pg_id = :processGroupId
									AND ct.sc_id = :serviceCatalogId
									AND pt.id = ct.pt_id
									AND pt.assign_team_id = t.id
								", array(
									':processGroupId'	=>	$processGroupId ,
									':serviceCatalogId'	=>	$serviceCatalogId
								))->fetchAll();
								
			foreach($result as $aTeams){
				
				$result	= $db->query("
								SELECT 
									t.*
								FROM
									sc_ticket_team t
								WHERE
									t.team_id = :team_id
									AND t.ticket_fulfillment_id = :ticket_fulfillment_id
								", array(
									':team_id'					=>	$aTeams['id'] ,
									':ticket_fulfillment_id'	=>	$ticket_fulfillment_id
								))->fetchAll();
								
				if(count($result)){
										
					$maxTicketTeamId	=	$result[0]['id'];
					
				}else{ //ถ้ามีทีมเพิ่มเข้ามา
						
					$db->query("
						INSERT INTO sc_ticket_team (
				            id, ticket_fulfillment_id, team_id, name, orders, start_date
				        ) VALUES (
				            '', :ticket_fulfillment_id, :team_id, :name, 99, NOW()
				        )
				        ", array(
				            ':ticket_fulfillment_id'    => $ticket_fulfillment_id,
				            ':team_id'      			=> $aTeams['id'],
				            ':name'        				=> $aTeams['name']
						));
						
					$result         				= $db->query("SELECT MAX(id) AS id FROM sc_ticket_team ")->fetch();
	        		$maxTicketTeamId          		= isset($result['id']) ? $result['id'] : 0;
	        		
				}
					
				$result	=	$db->query("
									SELECT DISTINCT
										pt.* , ct.orders
									FROM
										sc_catalog_2_task ct , sc_process_task pt
									WHERE
										ct.pg_id = :processGroupId
										AND ct.sc_id = :serviceCatalogId
										AND pt.id = ct.pt_id
										AND pt.assign_team_id = :teamId
										ORDER BY ct.orders
								", array(
									':processGroupId'	=>	$processGroupId ,
									':serviceCatalogId'	=>	$serviceCatalogId,
									':teamId'			=>	$aTeams['id']
								))->fetchAll();
				
				foreach($result as $aTasks){
						
					$result	=	$db->query("
										SELECT
											ta.id , ta.process_task_id , ta.name , ta.staff_id , ta.orders , ta.is_complete
										FROM
											sc_ticket_activity ta , sc_ticket_team tt , sc_ticket_fulfillment tf
										WHERE
											ta.process_task_id = :process_task_id
											AND ta.ticket_team_id = tt.id
											AND tt.ticket_fulfillment_id = tf.id
											AND tf.ticket_id = :ticket_id
									", array(
										':process_task_id'	=>	$aTasks['id'],
										':ticket_id'		=>	$ticketId
									))->fetchAll(); //หาว่าเคยมี activity นี้เคยถูกทำอยู่ใน ticket fulfillment นี้หรือไม่
									
					if(count($result)){
							
						$db->query("
								UPDATE
									sc_ticket_activity
								SET
									ticket_team_id = :ticket_team_id ,
									process_task_id = :process_task_id ,
									name	= :name ,
									staff_id = :staff_id ,
									orders = :orders
								WHERE
									id = :ticket_activity_id
							", array(
					            ':ticket_team_id'    				=> $maxTicketTeamId,
					            ':process_task_id'      			=> $aTasks['id'],
					            ':name'        						=> $aTasks['name'],
					            ':staff_id'							=> $aTasks['assign_staff_id'],
					            ':orders'							=> $aTasks['orders'],
					            ':ticket_activity_id'				=> $result[0]['id']
							));
						
					}else{
							
						$db->query("
							INSERT INTO sc_ticket_activity (
					            id, ticket_team_id, process_task_id, name, staff_id, orders, start_date
					        ) VALUES (
					            '', :ticket_team_id, :process_task_id, :name, :staff_id, :orders, NOW()
					        )
					        ", array(
					            ':ticket_team_id'    				=> $maxTicketTeamId,
					            ':process_task_id'      			=> $aTasks['id'],
					            ':name'        						=> $aTasks['name'],
					            ':staff_id'							=> $aTasks['assign_staff_id'],
					            ':orders'							=> $aTasks['orders']
							));
							
					}		
						
				}
			}
			
		}else{
			
			$db->query("
					UPDATE
						sc_ticket_2_request
					SET
						is_fulfillment = 1
					WHERE
						ticket_id = :ticketId
					", array(
						':ticketId'		=>	$ticketId
					));
			
			$db->query("
			        INSERT INTO sc_ticket_fulfillment (
			            id, ticket_id, ticket_date, service_catalog_id, process_group_id, name, start_date
			        ) VALUES (
			            '', :ticketId, :ticketDate, :serviceCatalogId, :processGroupId, :processGroupName, NOW()
			        )
			        ", array(
			            ':ticketId'        			=> $ticketId,
			            ':ticketDate'      			=> $ticketDate,
			            ':serviceCatalogId'        	=> $serviceCatalogId,
			            ':processGroupId'         	=> $processGroupId,
			            ':processGroupName'			=> $processGroupName
			        ));
			
			$result         				= $db->query("SELECT MAX(id) AS id FROM sc_ticket_fulfillment ")->fetch();
        	$maxTicketFulfillmentId          = isset($result['id']) ? $result['id'] : 0;
					
			$result	=	$db->query("
								SELECT DISTINCT
									t.*
								FROM
									sc_process_task pt, sc_catalog_2_task ct , sc_team t
								WHERE
									ct.pg_id = :processGroupId
									AND ct.sc_id = :serviceCatalogId
									AND pt.id = ct.pt_id
									AND pt.assign_team_id = t.id
								", array(
									':processGroupId'	=>	$processGroupId ,
									':serviceCatalogId'	=>	$serviceCatalogId
								))->fetchAll();
						
			foreach($result as $aTeams){
			
				$db->query("
					INSERT INTO sc_ticket_team (
			            id, ticket_fulfillment_id, team_id, name, orders, start_date
			        ) VALUES (
			            '', :ticket_fulfillment_id, :team_id, :name, 99, NOW()
			        )
			        ", array(
			            ':ticket_fulfillment_id'    => $maxTicketFulfillmentId,
			            ':team_id'      			=> $aTeams['id'],
			            ':name'        				=> $aTeams['name']
					));
					
				$result         				= $db->query("SELECT MAX(id) AS id FROM sc_ticket_team ")->fetch();
        		$maxTicketTeamId          		= isset($result['id']) ? $result['id'] : 0;
					
				$result	=	$db->query("
									SELECT DISTINCT
										pt.* , ct.orders
									FROM
										sc_catalog_2_task ct , sc_process_task pt
									WHERE
										ct.pg_id = :processGroupId
										AND ct.sc_id = :serviceCatalogId
										AND pt.id = ct.pt_id
										AND pt.assign_team_id = :teamId
										ORDER BY ct.orders
								", array(
									':processGroupId'	=>	$processGroupId ,
									':serviceCatalogId'	=>	$serviceCatalogId,
									':teamId'			=>	$aTeams['id']
								))->fetchAll();
				
				foreach($result as $aTasks){
						
					$result	=	$db->query("
									SELECT
										ta.id , ta.process_task_id , ta.name , ta.staff_id , ta.orders , ta.is_complete
									FROM
										sc_ticket_activity ta , sc_ticket_team tt , sc_ticket_fulfillment tf
									WHERE
										ta.process_task_id = :process_task_id
										AND ta.ticket_team_id = tt.id
										AND tt.ticket_fulfillment_id = tf.id
										AND tf.ticket_id = :ticket_id
								", array(
									':process_task_id'	=>	$aTasks['id'],
									':ticket_id'		=>	$ticketId
								))->fetchAll(); //หาว่าเคยมี activity นี้เคยถูกทำอยู่ใน ticket fulfillment นี้หรือไม่
								
					if(count($result)){
							
						$db->query("
								UPDATE
									sc_ticket_activity
								SET
									ticket_team_id = :ticket_team_id ,
									process_task_id = :process_task_id ,
									name	= :name ,
									staff_id = :staff_id ,
									orders = :orders
								WHERE
									id = :ticket_activity_id
							", array(
					            ':ticket_team_id'    				=> $maxTicketTeamId,
					            ':process_task_id'      			=> $aTasks['id'],
					            ':name'        						=> $aTasks['name'],
					            ':staff_id'							=> $aTasks['assign_staff_id'],
					            ':orders'							=> $aTasks['orders'],
					            ':ticket_activity_id'				=> $result[0]['id']
							));
						
					}else{
							
						$db->query("
							INSERT INTO sc_ticket_activity (
					            id, ticket_team_id, process_task_id, name, staff_id, orders, start_date
					        ) VALUES (
					            '', :ticket_team_id, :process_task_id, :name, :staff_id, :orders, NOW()
					        )
					        ", array(
					            ':ticket_team_id'    				=> $maxTicketTeamId,
					            ':process_task_id'      			=> $aTasks['id'],
					            ':name'        						=> $aTasks['name'],
					            ':staff_id'							=> $aTasks['assign_staff_id'],
					            ':orders'							=> $aTasks['orders']
							));
						
					}		
					
				}
				
			}
			
		}		

			
		$result	=	$db->query("
				SELECT
					* , tt.name as team_name , ta.id as activity_id , CONCAT(ad.firstname , ' ' , ad.lastname) as staff_name
				FROM
					sc_ticket_activity ta , sc_ticket_team tt , sc_ticket_fulfillment tf , sc_process_task pt , hb_admin_details ad
				WHERE
					tf.id = tt.ticket_fulfillment_id
					AND tt.id = ta.ticket_team_id
					AND ta.process_task_id = pt.id
					AND tf.id = :fulfillmentId
    				AND tf.is_cancel = 0
    				AND ad.id = ta.staff_id
    				ORDER BY ta.orders
			", array(
    				':fulfillmentId'	=>	$maxTicketFulfillmentId
    		))->fetchAll();
			
		foreach($result as $aData){
			if($aData['is_complete'] == 0){
				$result	=	$db->query("
									SELECT ticket_number
									FROM hb_tickets
									WHERE
									id = :ticketId
								", array(
									':ticketId'		=> $ticketId
								))->fetch();	
				
				$html       = '
		                เจ้าหน้าที่ Staff#'. $aData['staff_name'] .' <br />
		                Ticket: <a href="https://netway.co.th/7944web/?cmd=tickets&action=view&num='. $result['ticket_number'] .'"
		                >https://netway.co.th/7944web/?cmd=tickets&action=view&num='. $result['ticket_number'] .'</a> <br />
		                ';
		        
		        $header     = 'MIME-Version: 1.0' . "\r\n" .
		                'Content-type: text/html; charset=utf-8' . "\r\n" .
		                'From: admin@netway.co.th' . "\r\n" .
		                'Reply-To: admin@netway.co.th' . "\r\n" .
		                'X-Mailer: PHP/' . phpversion();
		        @mail($aData['email'], 'Ticket Fulfillment: Activity '.$aData['name'].' #'. $result['ticket_number'], $html, $header);	
		        require_once(APPDIR_MODULES .'Site/supporthandle/admin/class.supporthandle_controller.php');
				$obj =	new supporthandle_controller();
				$obj->alsoAssignTo(array('ticketId' => $ticketId , 'assignTo'	=>	$aData['assign_staff_id'].',' , 'force' => 1));	
				break;
			}
		}
		
		echo '<!-- {"ERROR":[],"INFO":["Start Fulfillment เรียบร้อยแล้ว"]'
	            . ',"STACK":0} -->';
	    exit;
		
	}
	
	public function cancelFulfillment($request){
		
		$db             = hbm_db();
		
		$fulfillmentId	=	isset($request['fulfillmentId']) ? $request['fulfillmentId'] : 0 ;
		$ticketId		=	isset($request['ticketId']) ? $request['ticketId'] : 0 ;
		
		$db->query("
					UPDATE
						sc_ticket_fulfillment
					SET
						is_cancel = 1
					WHERE
						id = :fulfillmentId
					", array(
						':fulfillmentId'	=> $fulfillmentId
					));
					
		$db->query("
					UPDATE
						sc_ticket_2_request
					SET
						is_fulfillment = 0
					WHERE
						ticket_id = :ticketId
					", array(
						':ticketId'		=>	$ticketId
					));
		
		echo '<!-- {"ERROR":[],"INFO":["Cancel Fulfillment เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
		
	}
	
	public function getGFormData($request){
		
		$db             = hbm_db();
		$ticketId		= isset($request['ticketId']) ? $request['ticketId'] : 0 ;
		
		$result	=	$db->query("
					SELECT
						* , tt.name as team_name , ta.id as activity_id , CONCAT(ad.firstname , ' ' , ad.lastname) as staff_name
					FROM
						sc_ticket_activity ta , sc_ticket_team tt , sc_ticket_fulfillment tf , sc_process_task pt , hb_admin_details ad
					WHERE
						tf.id = tt.ticket_fulfillment_id
						AND tt.id = ta.ticket_team_id
						AND ta.process_task_id = pt.id
						AND tf.ticket_id = :ticket_id
						AND pt.assign_team_id
        				AND tf.is_cancel = 0
        				AND ad.id = ta.staff_id
        				ORDER BY ta.orders
				", array(
        				':ticket_id'	=>	$ticketId
        		))->fetchAll();
		
		$haveGFormData = 0;
		foreach($result as $aGFormData){
			if($aGFormData['link_google_form'] != ''){
				$haveGFormData = 1;
				break;
			}
		}

		$this->template->assign('isGForm', $haveGFormData);
		
		$result	=	$db->query("
					SELECT
						* , tt.name as team_name
					FROM
						sc_ticket_activity ta , sc_ticket_team tt , sc_ticket_fulfillment tf , sc_process_task pt
					WHERE
						tf.id = tt.ticket_fulfillment_id
						AND tt.id = ta.ticket_team_id
						AND ta.process_task_id = pt.id
						AND tf.ticket_id = :ticket_id
						AND pt.assign_team_id
        				AND tf.is_cancel = 0
        				ORDER BY ta.orders
				", array(
        				':ticket_id'	=>	$ticketId
        		))->fetchAll();
		
		$haveGFormData = false;
		foreach($result as $aGFormData){
			if($aGFormData['link_response_google_form'] != ''){
				$haveGFormData = true;
				$result = $aGFormData;
				break;
			}
		}
		
		$this->template->assign('responseTitle', $result['name']);
		$this->template->assign('ticketId', $ticketId);
		
		$currentGFormTicketData = array();
		if($haveGFormData){
			
			$gFormData = $this->googleSheetApi($result);	
			
			foreach($gFormData as $aFormData){
				if($aFormData['ticketid'] == $ticketId){
					$currentGFormTicketData = $aFormData;
					break;
				}
			}
			
		}

		$this->template->assign('gFormData', $currentGFormTicketData);
		
		$this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.view_GFormData.tpl',array(), false);
		
	}
	
	public function googleSheetApi($aData){
			
		$configuration    = array(
		        'Client ID'     => array(
		            'value'     => '40825206682-kc25gdri7emglrem0j7id182qttnpgtt.apps.googleusercontent.com',
		            'type'      => 'input'
		        ),
		        'Client Secret' => array(
		            'value'     => 'sua2Jw7X2thgz2AllHQ1Nyx0',
		            'type'      => 'input'
		        ),
		        'Auth Code'     => array(
		            'value'     => '4/U7q0_joXuUan_WBQmz3FbW9rs4ev.skNHePIvYaIZXE-sT2ZLcbQbfvU6hQI',
		            'type'      => 'input'
		        ),
		        'Access Token'  => array(
		            'value'     => '{-quote-access_token-quote-:-quote-ya29.WQBKV-lfKyHyVhwAAADU-4T7UWWWysz0UHUBpX7G0c6nermJrUwrQlmxNe83_w-quote-,-quote-token_type-quote-:-quote-Bearer-quote-,-quote-expires_in-quote-:3600,-quote-refresh_token-quote-:-quote-1\/AWViTMv12Fznrx-wBvSd6xLyJv2OZ6DklMouz663Ei8-quote-,-quote-created-quote-:1407293618}',
		            'type'      => 'input'
		        )
		    );
			
			$aConfigs       = $configuration; 
		    $clientId       = $aConfigs['Client ID']['value'];
		    $clientSecret   = $aConfigs['Client Secret']['value'];
		    $authCode       =  $aConfigs['Auth Code']['value'];
		    $accessToken    = $aConfigs['Access Token']['value'];
			
			require_once(APPDIR_MODULES .'Other/importongoogle/google-api-php-client/src/Google_Client.php');
	    	require_once(APPDIR_MODULES .'Other/importongoogle/google-api-php-client/src/contrib/Google_DriveService.php');
			
			$client     = new Google_Client();
		
		    $client->setAccessType('offline');
		    $client->setClientId($clientId);
		    $client->setClientSecret($clientSecret);
		    $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
		    $client->setScopes(array('https://www.googleapis.com/auth/drive', 'https://www.googleapis.com/auth/drive.file', 'https://spreadsheets.google.com/feeds'));
		          
			
		    $accessToken = preg_replace('/\-quote\-/','"', $accessToken);
		    $client->setAccessToken($accessToken);
		
		    if($client->isAccessTokenExpired()){
		        $newAccessToken = json_decode($client->getAccessToken());
		        $client->refreshToken($newAccessToken->refresh_token);
		    }
		
		    require_once(APPDIR_MODULES .'Other/importongoogle/Google/Spreadsheet/Autoloader.php');
			
			$service = new Google_DriveService($client);
		
			$oToken     = json_decode($client->getAccessToken());
		    
		    $request            = new Google\Spreadsheet\Request($oToken->access_token);
		    
		    $serviceRequest     = new Google\Spreadsheet\DefaultServiceRequest($request);
		    Google\Spreadsheet\ServiceRequestFactory::setInstance($serviceRequest);
		    
		    $spreadsheetService = new Google\Spreadsheet\SpreadsheetService();
		     
		     
		    try{
		            
		        $spreadsheetFeed    = $spreadsheetService->getSpreadsheets();
				
		    }catch(exception $e){
		        $message = $e->getMessage();
				return array();
		    }
		    
		    $spreadsheet        = $spreadsheetFeed->getByTitle($aData['link_response_google_form']); 
			if( ! isset($spreadsheet)) return array();
		    $worksheetFeed      = $spreadsheet->getWorksheets();
			if( ! isset($worksheetFeed)) return array();
		    $worksheet          = $worksheetFeed->getByTitle($aData['link_response_google_form']);
			if( ! isset($worksheet)) return array();
		    $listFeed           = $worksheet->getListFeed();
			
			foreach ($listFeed->getEntries() as $entry) {
		        $values[] = $entry->getValues();
		    }
			
			return $values;
		
	}

	public function completeActivity($request){
		
		$db             = hbm_db();
		
		$activityId		=	isset($request['activityId']) ? $request['activityId'] : 0 ;
		$activityName	=	isset($request['activityName']) ? $request['activityName'] : '';
		$status			=	isset($request['status']) ? $request['status'] : 0;
		$fulfillmentId	=	isset($request['fulfillmentId']) ? $request['fulfillmentId'] : 0;
		$ticketId		=	isset($request['ticketId']) ? $request['ticketId'] : 0;
		
		$db->query("
					UPDATE
						sc_ticket_activity
					SET
						is_complete = :status ,
						end_date = NOW()						
					WHERE
						id = :activityId
					", array(
						':activityId'	=> $activityId ,
						':status'		=> $status
					));
					
		$result	=	$db->query("
					SELECT
						* , tt.name as team_name , ta.id as activity_id , CONCAT(ad.firstname , ' ' , ad.lastname) as staff_name
					FROM
						sc_ticket_activity ta , sc_ticket_team tt , sc_ticket_fulfillment tf , sc_process_task pt , hb_admin_details ad
					WHERE
						tf.id = tt.ticket_fulfillment_id
						AND tt.id = ta.ticket_team_id
						AND ta.process_task_id = pt.id
						AND tf.id = :fulfillmentId
        				AND tf.is_cancel = 0
        				AND ad.id = ta.staff_id
        				ORDER BY ta.orders
				", array(
        				':fulfillmentId'	=>	$fulfillmentId
        		))->fetchAll();
		
		$nextActivity = 0;
		$unassignId = 0;
		foreach($result as $aData){
			if($aData['activity_id'] == $activityId){
				$nextActivity = 1;
				$unassignId = $aData['assign_staff_id'];
				continue;
			}
			if($nextActivity == 1){
				if($aData['is_complete'] == 1) continue;
				if($status){
							
					$result	=	$db->query("
										SELECT ticket_number
										FROM hb_tickets
										WHERE
										id = :ticketId
									", array(
										':ticketId'		=> $ticketId
									))->fetch();		
					
					require_once(APPDIR . 'class.general.custom.php');
					$ticketUrl  = GeneralCustom::singleton()->getAdminUrl() .'?cmd=tickets&action=view&num='. $result['ticket_number'];		
					
					$html       = '
			                เจ้าหน้าที่ Staff#'. $aData['staff_name'] .' <br />
			                Ticket: <a href="' . $ticketUrl .'"
			                " >' . $ticketUrl .'</a> <br />
			                ';
			        
			        $header     = 'MIME-Version: 1.0' . "\r\n" .
			                'Content-type: text/html; charset=utf-8' . "\r\n" .
			                'From: admin@netway.co.th' . "\r\n" .
			                'Reply-To: admin@netway.co.th' . "\r\n" .
			                'X-Mailer: PHP/' . phpversion();
			        @mail($aData['email'],'Ticket Fulfillment: Activity ' .$aData['name'] .' #'. $result['ticket_number'], $html, $header);
					
					require_once(APPDIR_MODULES .'Site/supporthandle/admin/class.supporthandle_controller.php');
					$obj =	new supporthandle_controller();
					$obj->alsoAssignTo(array('ticketId' => $ticketId , 'assignTo'	=>	$aData['assign_staff_id'].',' , 'force' => 1));
					break;
				}else{
					break;
				}
			}
		}
					
		$returnStr = 'Complete';
		if(!$status){
			$returnStr = 'Active';
		}
		
		echo '<!-- {"ERROR":[],"INFO":["' . $returnStr . ' Activity ' . $activityName . ' เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
		
	}
    
    public function createchangeticket ($request)
    {
        $db             = hbm_db();
        
        
        
        //$this->template->assign('aAddress', $aAddress);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.create_change_ticket.tpl', array(), false);
    }
    
    public function addChangeTicket ($request)
    {
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
           
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl . '/api.php');
        
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $api            = new ApiWrapper();
        
        $subject        = isset($request['subject']) ? $request['subject'] : '';
        $account        = isset($request['account']) ? $request['account'] : 0;
        $confirm        = isset($request['confirm']) ? $request['confirm'] : '';
        
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => $aAdmin['firstname'] .' '. $aAdmin['lastname'],
            'subject'   => $subject,
            'body'      => '--- กรุณาระบุข้อมูล ---',
            'email'     => $aAdmin['email']
        );
        $result         = $apiCustom->request($aParam);
        $aResult        = $result;
       
        $ticketNum      = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        $result     = $db->query("
            SELECT id FROM hb_tickets WHERE ticket_number = :ticketNum 
            ", array(
                ':ticketNum'    => $ticketNum
            ))->fetch();
        
        $ticketId   = isset($result['id']) ? $result['id'] : 0;
        
        if ($ticketId) {
            
            $db->query("
                INSERT INTO ch_request (
                id, account_id, ticket_id, date,title, confirm
                ) VALUES (
                '', :accountId, :ticketId, NOW(), :title, :confirm
                )
                ", array(
                    ':accountId'    => $account,
                    ':ticketId'     => $ticketId,
                    ':title'        => $subject,
                    ':confirm'      => $confirm
                ));
            
            $result         = $db->query("SELECT MAX(id) AS id FROM ch_request ")->fetch();
            $id             = isset($result['id']) ? $result['id'] : 0;
            
            $request['ticketId']    = $ticketId;
            $request['requestType'] = 'Change';
            $this->selectRequest($request);
            
            $log            = 'Staff#'. $aAdmin['firstname'] .' create Change Management #'. $id  .' '. $subject;
            
            $db->query("
                    INSERT INTO sc_ticket_2_request_log (
                        id, ticket_id, staff_id, event, start_date, logs, rel_id
                    ) VALUES (
                        '', :ticketId, :staffId, 'Create Change Management', NOW(), :log, 0
                    )
                    ", array(
                        ':ticketId'     => $ticketId,
                        ':staffId'      => $aAdmin['id'],
                        ':log'          => $log
                    ));
            
            $result         = $db->query("SELECT MAX(id) AS id FROM sc_ticket_2_request_log ")->fetch();
            $relId          = isset($result['id']) ? $result['id'] : 0;
            
            $result         = $db->query("
                    UPDATE sc_ticket_2_request
                    SET sc_id = :scId,
                        rel_id = :relId
                    WHERE ticket_id = :ticketId
                    ", array(
                        ':ticketId'     => $ticketId,
                        ':scId'         => $id,
                        ':relId'        => $relId
                    ));
            
            $result         = $db->query("
                SELECT ca.id, ca.email, cd.firstname, cd.lastname
                FROM hb_accounts a,
                    hb_client_access ca,
                    hb_client_details cd
                WHERE a.id = :accountId
                    AND a.client_id = ca.id
                    AND ca.id = cd.id
                ", array(
                    ':accountId'        => $account
                ))->fetch();
            
            if (isset($result['id'])) {
                $db->query("
                    UPDATE hb_tickets
                    SET client_id = :clientId,
                        name = :name,
                        email = :email,
                        dept_id = 16
                    WHERE id = :ticketId
                    ", array(
                        ':ticketId'     => $ticketId,
                        ':clientId'     => $result['id'],
                        ':name'         => $result['firstname'] .' '. $result['lastname'],
                        ':email'        => $result['email']
                    ));
            }
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":["สร้าง change management ticket เรียบร้อยแล้ว"]'
            . ',"DATA":['. json_encode($aResult) .']'
            . ',"STACK":0} -->';
        exit;
    }
    
	public function addActivityComment($request){
		
		$db             = hbm_db();
		$aAdmin         = hbm_logged_admin();
		
		$ticketActivityId		=	isset($request['ticketActivityId']) ? $request['ticketActivityId'] : 0;
		$ticketId				=	isset($request['ticketId']) ? $request['ticketId'] : 0;
		$comment				=	isset($request['comment'])	? $request['comment'] : 0;
		$activityName			=	isset($request['activityName']) ? $request['activityName']	: '';
		$currentFulfillment		=	isset($request['currentFulfillment']) ? $request['currentFulfillment'] : '';
		
		$result = $db->query("
							SELECT
								ad.id as adminId ,CONCAT(ad.firstname , ' ' , ad.lastname) as adminFullName , ad.email
							FROM 
								hb_admin_access aa , hb_admin_details ad
							WHERE
								aa.status = 'Active'
								AND aa.id = ad.id
								ORDER BY ad.firstname ASC
						")->fetchAll();
						
		$aAssignStaffFromComment = '0';
		foreach($result as $adminData){
			$needlePos = self::str_contains($comment,'<a class="tag-incomment" href="#">' . $adminData['adminFullName'] . '</a>');
			if($needlePos){
				$aAssignStaffFromComment.= ',' . $adminData['adminId'];
			}	
		}
		
		$db->query("
				INSERT INTO
					sc_ticket_activity_comment
					(id, comment, ticket_activity_id, ticket_id, staff_id, date, last_update)
				VALUES
					(null, :comment, :ticket_activity_id, :ticketId, :staff_id, NOW(), NOW())
			", array(
				':comment'				=>	$comment,
				':ticket_activity_id'	=>	$ticketActivityId,
				':ticketId'				=>	$ticketId,
				':staff_id'				=>	$aAdmin['id'],
			));
			
		$result         = $db->query("SELECT MAX(id) AS id FROM sc_ticket_activity_comment ")->fetch();
        $id             = isset($result['id']) ? $result['id'] : 0;
		
		$result			= $db->query("
									SELECT 
										tac.* , afv.value as adminAvatar
									FROM
										sc_ticket_activity_comment tac , hb_admin_fields_values afv
									WHERE
										tac.id = :id 
										AND tac.staff_id = afv.admin_id
										AND afv.field_id = 2
								", array(
									':id'		=>	$id
								))->fetch();
		
		$commentHtml	=	'<div class="comment-item comment-id-'.$id.'">
	                			<div><span style=" float: left">เวลา: ' . $result['date'] . '</span>
		                			<span style=" float: right">
		                				<!--<a style="margin-top: 2px" class="menuitm" title="edit" onclick=""><span class="editsth"></span></a>-->
	            						<a style="margin-top: 2px" class="menuitm" title="Delete" onclick="deleteActivityComment(\''.$id.'\',\''.$activityName.'\')"><span class="delsth"></span></a>
		                			</span>
	                			</div>
	                			<div class="comment-avatar">
									<img src="' . $result['adminAvatar'] . '" alt="avatar">
									<span style="padding: 5px;">' . $result['comment'] .'</span>
								</div>
							 </div>';
							 
		$aStaffTags	=	self::getTicketTags(array('ticketId'		=>	$ticketId));
		
		/* --- list staff tag --- */
        $result         = $db->query("
                SELECT
                    aa.id, aa.username
                FROM
                    hb_admin_access aa
                WHERE
                    1
                ")->fetchAll();
                
        if (count($result)) {
            foreach ($result as $arr) {
                $username               = '@' . substr($arr['username'],0, strpos($arr['username'], '@'));
                $aStaff[$arr['id']]     = $username;
            }
        }
		
		if(count($aStaffTags)){
			/* --- list staff email --- */
	        $result         = $db->query("
	                SELECT
	                    ad.id, ad.email
	                FROM
	                    hb_admin_details ad
	                WHERE
	                    1
	                ")->fetchAll();
	                
	        if (count($result)) {
	            foreach ($result as $arr) {
	                $aStaffEmail[$arr['id']]     = $arr['email'];
	            }
	        }
			
			
			$aEmailTo = array();
			$currentStaffTags = '';
			$currentStaffTagsId = '';
			foreach($aStaffTags as $arr){
				foreach($aStaff as $k => $v){
					if($v == $arr['tag']){
						$currentStaffTags .= ',' . $aStaff[$k];
						$currentStaffTagsId .= ',' . $k;
						if($k == $aAdmin['id']) continue;
						$aEmailTo[]	=	$aStaffEmail[$k];
					}
				}
			}
		}
		
		if(count($aEmailTo)){
			
			$result	=	$db->query("
										SELECT ticket_number
										FROM hb_tickets
										WHERE
										id = :ticketId
									", array(
										':ticketId'		=> $ticketId
									))->fetch();	
			
			require_once(APPDIR . 'class.general.custom.php');
			$ticketUrl  = GeneralCustom::singleton()->getAdminUrl() .'?cmd=tickets&action=view&num='. $result['ticket_number'];		
			$emailTo    = implode(',', $aEmailTo);
			$subject    = $aAdmin['firstname'] .' ได้เพิ่ม comment ใน fulfillemt ticket #'. $result['ticket_number'];
			$html       = '
	                เจ้าหน้าที่ Staff#'. $aAdmin['firstname'] .' <br />
	                Fulfillment > Activity: '. $currentFulfillment . ' > '. $activityName . '<br>
	                Comment: '. $comment .' <br>
	                URL: <a href="' . $ticketUrl .'
	                
	                " >' . $ticketUrl .'</a>
	                ';
	        
	        $header     = 'MIME-Version: 1.0' . "\r\n" .
	                'Content-type: text/html; charset=utf-8' . "\r\n" .
	                'From: admin@netway.co.th' . "\r\n" .
	                'Reply-To: admin@netway.co.th' . "\r\n" .
	                'X-Mailer: PHP/' . phpversion();
					
			@mail($emailTo, $subject, $html, $header);
		
		}
		
		$data['commentHtml']		=	$commentHtml;
		$data['assign_staff_id']	=	$aAssignStaffFromComment;
		$data['currentStaffTags']	=	$currentStaffTags;
		$data['currentStaffTagsId'] =	$currentStaffTagsId;
				
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($data));
        $this->json->show();
		
	}

	public function str_contains($haystack, $needle, $ignoreCase = false) {
	    if ($ignoreCase) {
	        $haystack = strtolower($haystack);
	        $needle   = strtolower($needle);
	    }
	    $needlePos = strpos($haystack, $needle);
	    return ($needlePos === false ? false : ($needlePos+1));
	}
	
	public function assignStaffFromComment($request){
		
		$ticketId				=	isset($request['ticketId']) ? $request['ticketId'] : 0;
		$assignStaffFromComment	=	isset($request['to'])	? $request['to'] : '0';
		
		if($assignStaffFromComment != '0'){
			require_once(APPDIR_MODULES .'Site/supporthandle/admin/class.supporthandle_controller.php');
			$obj =	new supporthandle_controller();
			$obj->alsoAssignTo(array('ticketId' => $ticketId , 'assignTo'	=>	$assignStaffFromComment , 'force' => 1));
		}
		
	}

	public function assignCurrentStaff($request){
		
		$ticketId				=	isset($request['ticketId']) ? $request['ticketId'] : 0;
		$currentStaffTags		=	isset($request['currentStaffTags']) ? $request['currentStaffTags'] : '';
		$currentStaffTagsId		=	isset($request['currentStaffTagsId']) ? $request['currentStaffTagsId'] : '';
		
		if($currentStaffTags != '' && $currentStaffTagsId != ''){
			$db             = hbm_db();
			$aStaffTags		= explode(',', $currentStaffTags);
			$aStaffTagsId	= explode(',', $currentStaffTagsId);
			
			foreach($aStaffTags as $k => $v){
				if($v == '') continue;				
				$tagName	= $v;
				$staffId	= $aStaffTagsId[$k];
				$result     = $db->query("
                        SELECT
                            t.*
                        FROM
                            hb_tags t
                        WHERE
                            t.tag = :tagName
                        ", array(
                            ':tagName'  => $tagName
                        ))->fetch();
                    
                if (isset($result['id']) && $result['id']) {
                    $tagId      = $result['id'];
                    
                } else {
                    $db->query("
                        INSERT INTO hb_tags (
                            id, tag
                        ) VALUES (
                            '', :tagName
                        )
                        ", array(
                            ':tagName'      => $tagName
                        ));
                    $tagId      = mysql_insert_id();
                }
				
				$db->query("
                    REPLACE INTO hb_tickets_tags (
                        tag_id, ticket_id
                    ) VALUES (
                        :tagId, :ticketId
                    )
                    ", array(
                        ':tagId'        => $tagId,
                        ':ticketId'     => $ticketId
                    ));
                
                /* --- subscribe --- */
                $db->query("
                    REPLACE INTO hb_ticket_subscriptions (
                        admin_id, ticket_id
                    ) VALUES (
                        :adminId, :ticketId
                    )
                    ", array(
                        ':adminId'      => $staffId,
                        ':ticketId'     => $ticketId
                    ));
				
			}
		}
		
	}
	
	public function getTicketTags($request){
		
		$db             = hbm_db();
		$result			= $db->query("
									SELECT
										t.tag
									FROM
										hb_tags t , hb_tickets_tags tt
									WHERE
										tt.tag_id = t.id
										AND tt.ticket_id = :ticket_id
								", array(
									':ticket_id'		=>	$request['ticketId']
								))->fetchAll();
		return $result;
		
	}
	
	public function deleteActivityComment($request){
		
		$db             = hbm_db();
		$aAdmin         = hbm_logged_admin();
		
		$ticketId	=	isset($request['ticketId']) ? $request['ticketId'] : 0;
		$commentId 	= isset($request['commentId']) ? $request['commentId'] : 0;
		$activityName			=	isset($request['activityName']) ? $request['activityName']	: '';
		$currentFulfillment		=	isset($request['currentFulfillment']) ? $request['currentFulfillment'] : '';
		
		$db->query("
				UPDATE
					sc_ticket_activity_comment
				SET
					is_delete = 1 ,
					last_update = NOW()
				WHERE
					id = :commentId
				", array(
					':commentId'		=>	$commentId
				));
				
		$aStaffTags	=	self::getTicketTags(array('ticketId'		=>	$ticketId));
		
		/* --- list staff tag --- */
        $result         = $db->query("
                SELECT
                    aa.id, aa.username
                FROM
                    hb_admin_access aa
                WHERE
                    1
                ")->fetchAll();
                
        if (count($result)) {
            foreach ($result as $arr) {
                $username               = '@' . substr($arr['username'],0, strpos($arr['username'], '@'));
                $aStaff[$arr['id']]     = $username;
            }
        }
		
		if(count($aStaffTags)){
			/* --- list staff email --- */
	        $result         = $db->query("
	                SELECT
	                    ad.id, ad.email
	                FROM
	                    hb_admin_details ad
	                WHERE
	                    1
	                ")->fetchAll();
	                
	        if (count($result)) {
	            foreach ($result as $arr) {
	                $aStaffEmail[$arr['id']]     = $arr['email'];
	            }
	        }
			
			$aEmailTo = array();
			foreach($aStaffTags as $arr){
				foreach($aStaff as $k => $v){
					if($v == $arr['tag']){
						if($k == $aAdmin['id']) continue;
						$aEmailTo[]	=	$aStaffEmail[$k];
					}
				}
			}
		}
		
		if(count($aEmailTo)){
			
			$result	=	$db->query("
										SELECT ticket_number
										FROM hb_tickets
										WHERE
										id = :ticketId
									", array(
										':ticketId'		=> $ticketId
									))->fetch();	
									
			$commentTxt	=	$db->query("
										SELECT comment
										FROM sc_ticket_activity_comment
										WHERE
										id = :commentId
									", array(
										':commentId'		=>	$commentId
									))->fetch();
			
			require_once(APPDIR . 'class.general.custom.php');
			$ticketUrl  = GeneralCustom::singleton()->getAdminUrl() .'?cmd=tickets&action=view&num='. $result['ticket_number'];		
			$emailTo    = implode(',', $aEmailTo);
			$subject    = $aAdmin['firstname'] .' ได้ลบ comment ใน fulfillemt ticket #'. $result['ticket_number'];
			$html       = '
	                เจ้าหน้าที่ Staff#'. $aAdmin['firstname'] .' <br />
	                Fulfillment > Activity: '. $currentFulfillment . ' > '. $activityName . '<br>
	                Delete Comment: '. $commentTxt['comment'] .' <br>
	                URL: <a href="' . $ticketUrl .'
	                
	                " >' . $ticketUrl .'</a>
	                ';
	        
	        $header     = 'MIME-Version: 1.0' . "\r\n" .
	                'Content-type: text/html; charset=utf-8' . "\r\n" .
	                'From: admin@netway.co.th' . "\r\n" .
	                'Reply-To: admin@netway.co.th' . "\r\n" .
	                'X-Mailer: PHP/' . phpversion();
					
			@mail($emailTo, $subject, $html, $header);
		
		}
		
		echo '<!-- {"ERROR":[],"INFO":["ลบ Comment เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
		
	}

	public function editActivityComment($request){
		
		$db             = hbm_db();
		$aAdmin         = hbm_logged_admin();
		
		$ticketId				=	isset($request['ticketId']) ? $request['ticketId'] : 0;
		$commentId 				=	isset($request['commentId']) ? $request['commentId'] : 0;
		$comment 				=	isset($request['comment']) ? $request['comment'] : '';
		$activityName			=	isset($request['activityName']) ? $request['activityName']	: '';
		$currentFulfillment		=	isset($request['currentFulfillment']) ? $request['currentFulfillment'] : '';
		
		$oldcomment	=	$db->query("
										SELECT comment
										FROM sc_ticket_activity_comment
										WHERE
										id = :commentId
									", array(
										':commentId'		=>	$commentId
									))->fetch();
		
		$db->query("
				UPDATE
					sc_ticket_activity_comment
				SET
					comment = :newcomment ,
					last_update = NOW()
				WHERE
					id = :commentId
				", array(
					':commentId'		=>	$commentId ,
					':newcomment'		=>	$comment
				));
				
		$aStaffTags	=	self::getTicketTags(array('ticketId'		=>	$ticketId));
		
		/* --- list staff tag --- */
        $result         = $db->query("
                SELECT
                    aa.id, aa.username
                FROM
                    hb_admin_access aa
                WHERE
                    1
                ")->fetchAll();
                
        if (count($result)) {
            foreach ($result as $arr) {
                $username               = '@' . substr($arr['username'],0, strpos($arr['username'], '@'));
                $aStaff[$arr['id']]     = $username;
            }
        }
		
		if(count($aStaffTags)){
			/* --- list staff email --- */
	        $result         = $db->query("
	                SELECT
	                    ad.id, ad.email
	                FROM
	                    hb_admin_details ad
	                WHERE
	                    1
	                ")->fetchAll();
	                
	        if (count($result)) {
	            foreach ($result as $arr) {
	                $aStaffEmail[$arr['id']]     = $arr['email'];
	            }
	        }
			
			$aEmailTo = array();
			foreach($aStaffTags as $arr){
				foreach($aStaff as $k => $v){
					if($v == $arr['tag']){
						if($k == $aAdmin['id']) continue;
						$aEmailTo[]	=	$aStaffEmail[$k];
					}
				}
			}
		}
		
		if(count($aEmailTo)){
			
			$result	=	$db->query("
										SELECT ticket_number
										FROM hb_tickets
										WHERE
										id = :ticketId
									", array(
										':ticketId'		=> $ticketId
									))->fetch();	
			
			require_once(APPDIR . 'class.general.custom.php');
			$ticketUrl  = GeneralCustom::singleton()->getAdminUrl() .'?cmd=tickets&action=view&num='. $result['ticket_number'];		
			$emailTo    = implode(',', $aEmailTo);
			$subject    = $aAdmin['firstname'] .' ได้แก้ไข comment ใน fulfillemt ticket #'. $result['ticket_number'];
			$html       = '
	                เจ้าหน้าที่ Staff#'. $aAdmin['firstname'] .' <br />
	                Fulfillment > Activity: '. $currentFulfillment . ' > '. $activityName . '<br>
	                Update Comment: '. $comment .' <br>
	                Old Comment: '. $oldcomment['comment'] .' <br>
	                URL: <a href="' . $ticketUrl .'
	                
	                " >' . $ticketUrl .'</a>
	                ';
	        
	        $header     = 'MIME-Version: 1.0' . "\r\n" .
	                'Content-type: text/html; charset=utf-8' . "\r\n" .
	                'From: admin@netway.co.th' . "\r\n" .
	                'Reply-To: admin@netway.co.th' . "\r\n" .
	                'X-Mailer: PHP/' . phpversion();
					
			@mail($emailTo, $subject, $html, $header);
		
		}
		
		echo '<!-- {"ERROR":[],"INFO":["แก้ไข Comment เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
		
	}

	public function	reassignStaff($request){
		
		$db             = hbm_db();
		$aAdmin         = hbm_logged_admin();
		
		$ticketId				=	isset($request['ticketId']) ? $request['ticketId'] : 0;
		$reassignStaffId 		=	isset($request['reassignStaffId']) ? $request['reassignStaffId'] : 0;
		$activityId 			=	isset($request['activityId']) ? $request['activityId'] : '';
		$activityName			=	isset($request['activityName']) ? $request['activityName']	: '';
		$currentFulfillment		=	isset($request['currentFulfillment']) ? $request['currentFulfillment'] : '';
		
		$oldstaff	=	$db->query("
								SELECT
									ad.id , ad.firstname , ad.lastname
								FROM
									hb_admin_details ad , sc_ticket_activity ta
								WHERE
									ta.staff_id = ad.id
									AND	ta.staff_id = (SELECT staff_id FROM sc_ticket_activity WHERE id = :activityId)
							", array(
								':activityId'			=>	$activityId
							))->fetch();
		
		$db->query("
				UPDATE
					sc_ticket_activity
				SET 
					staff_id = :reassignStaffId
				WHERE
					id = :activityId
				", array(
					':activityId'			=>	$activityId ,
					':reassignStaffId'		=>	$reassignStaffId
				));
		
		$result         = $db->query("
                SELECT
                    aa.id, aa.username , ad.firstname , ad.lastname , ad.email
                FROM
                    hb_admin_access aa , hb_admin_details ad 
                WHERE
                    aa.id = :id
                    AND aa.id = ad.id
                ",array(':id'	=>	$reassignStaffId))->fetch();

        $username               = '@' . substr($result['username'],0, strpos($result['username'], '@'));
		$staffFullname			= $result['firstname'] . ' ' . $result['lastname'];
		$staffEmail				= $result['email'];
		self::assignCurrentStaff(array('ticketId'	=>	$ticketId , 'currentStaffTags'	=>	$username ,	'currentStaffTagsId'	=>	$reassignStaffId));
		
		$result	=	$db->query("
										SELECT ticket_number
										FROM hb_tickets
										WHERE
										id = :ticketId
									", array(
										':ticketId'		=> $ticketId
									))->fetch();	
			
		require_once(APPDIR . 'class.general.custom.php');
		$ticketUrl  = GeneralCustom::singleton()->getAdminUrl() .'?cmd=tickets&action=view&num='. $result['ticket_number'];		
		$emailTo    = $staffEmail;
		$subject    = $aAdmin['firstname'] .' ได้ Assign คุณให้เข้าไปช่วยทำ fulfillment ticket #'. $result['ticket_number'];
		$html       = '
                เจ้าหน้าที่ Staff#'. $aAdmin['firstname'] .' <br />
                Fulfillment > Activity: '. $currentFulfillment . ' > '. $activityName . '<br>
                Assign Staff: '. $staffFullname .' <br>
                Old Staff: '. $oldstaff['firstname'] . ' ' . $oldstaff['lastname'] .' <br>
                URL: <a href="' . $ticketUrl .'
                
                " >' . $ticketUrl .'</a>
                ';
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/html; charset=utf-8' . "\r\n" .
                'From: admin@netway.co.th' . "\r\n" .
                'Reply-To: admin@netway.co.th' . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
				
		@mail($emailTo, $subject, $html, $header);
		
		echo '<!-- {"ERROR":[],"INFO":["Reassign เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
		
	}
	
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}