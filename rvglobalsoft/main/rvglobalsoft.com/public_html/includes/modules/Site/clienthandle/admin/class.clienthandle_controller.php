<?php

require_once(APPDIR .'class.cache.extend.php');

class clienthandle_controller extends HBController {

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
                                OR ca.id = '{$keyword}'
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
    
    public function getList ($request)
    {
        return self::getClient($request);
    }
    
    public function afterCall ($request)
    {
        
    }
}