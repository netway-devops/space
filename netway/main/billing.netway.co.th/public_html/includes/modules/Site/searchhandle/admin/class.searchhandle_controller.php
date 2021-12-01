<?php

require_once(APPDIR .'class.cache.extend.php');

class searchhandle_controller extends HBController {

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }

    public function search ($request)
    {
        $db         = hbm_db();
        $aResult    = array();

        $query  = isset($request['query']) ? trim($request['query']) : '';
        $limit  = isset($request['options']['maxresults']) ? (int) $request['options']['maxresults'] : 10;

        if (! $query) {
            return $aResult;
        }

        $sql        = "
            SELECT 'cmdLink', 'itemPrefix'
            , 'itemId', 'itemName', 'itemDate'
            , 'clientId', 'clientFirstName', 'clientLastName', 'clientCompanyName'
            , 'itemStatus', 'productName' 
            ";
        
        $sql    .= $this->_getQueryInvoice($query, $limit);
        $sql    .= $this->_getQueryCustomField($query, $limit);
        $sql    .= $this->_getQueryIp($query, $limit);
        $sql    .= $this->_getQueryDomain($query, $limit);
        
        
        $cacheKey   = md5(serialize($request));
        $result     = null;//CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result     = $db->query($sql)->fetchAll();
            CacheExtend::singleton()->set($cacheKey, $result, 300);
        }

        if (count($result)) {
            foreach ($result as $arr) {
                if ($arr['cmdLink'] == 'cmdLink') {
                    continue;
                }
                
                $arr['id']          = $arr['itemId'];
                $arr['date']        = $arr['itemDate'];
                $arr['status']      = $arr['itemStatus'];
                $arr['client_id']   = $arr['clientId'];
                $arr['product']     = $arr['productName'];
                $arr['_matches']    = array(
                    $arr['itemPrefix']  => $query
                );
                $aResult[]  = $arr;
            }
        }
        
        // echo '<pre>'. print_r($aResult, true) .'</pre>';

        return $aResult;
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        echo '<!-- {"ERROR":[],"INFO":[],"STACK":0} -->'; // ไม่ไส่ error
        
        $keyword  = isset($request['query']) ? trim(trim($request['query'], '%')) : '';
        
        if ($keyword == '') {
            return false;
        }
        
        $sql    = "
                SELECT 'cmdLink', 'itemPrefix'
                    , 'itemId', 'itemName', 'clientFirstName', 'clientLastName' 
                ";
        
        $sql    .= $this->_getClient($keyword);
        $sql    .= $this->_getClientNoSpace($keyword);
        $sql    .= $this->_getQueryInvoice($keyword);
        $sql    .= $this->_getQueryCustomField($keyword);
        $sql    .= $this->_getQueryDomain($keyword);
        $sql    .= $this->_getQueryIp($keyword);
        
        $cacheKey   = md5(serialize($request));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result     = $db->query($sql)->fetchAll();
            CacheExtend::singleton()->set($cacheKey, $result, 3600);
        }
        $aDatas     = $result;
        
        $this->template->assign('aDatas', $aDatas);
        
        
        // Display Domain IDN
        $displayIdn = 0;
        if (count($aDatas)>0) {
            for ($i=0;$i<count($aDatas);$i++) {
                if (isset($aDatas[$i]['itemPrefix']) && $aDatas[$i]['itemPrefix'] == 'Domains(idn)') {
                    $displayIdn = 1;
                    break;
                }
            }     
        }
        $this->template->assign('displayIdn', $displayIdn);
        
        
        // Display Account Dededicate, VPS, Clound VPS
        $displayIp = 0;
        if (count($aDatas)>0) {
            for ($i=0;$i<count($aDatas);$i++) {
                if (isset($aDatas[$i]['itemName']) && @preg_match("/Main IP/i", $aDatas[$i]['itemName'])) {
                    $displayIp = 1;
                    break;
                }
            }     
        }
        $this->template->assign('displayIp', $displayIp);
        
        
        // TODO Managed External Service
        
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.result.tpl', array(), false);
    }
    
    private function _getClient ($keyword, $limit = 10)
    {
        $sql    .= " UNION (
                SELECT CONCAT('?cmd=clients&action=show&id=', ca.id), 'Client'
                    , ca.id
                    , ca.email
                    , cd.firstname, cd.lastname
                FROM hb_client_access ca
                    LEFT JOIN hb_client_details cd ON cd.id = ca.id
                WHERE
                    ca.id = '{$keyword}'
                )
                LIMIT 0, {$limit}
                ";
        
        return $sql;
    }
    
    private function _getClientNoSpace ($keyword, $limit = 10)
    {
        $keyword    = preg_replace('/\s/', '', $keyword);
        
        $sql    .= " UNION (
                SELECT CONCAT('?cmd=clients&action=show&id=', ca.id), 'Client'
                    , ca.id
                    , cd.firstname, cd.lastname
                    , cd.companyname
                FROM hb_client_access ca
                    LEFT JOIN hb_client_details cd ON cd.id = ca.id
                WHERE
                    REPLACE(cd.companyname, ' ', '') LIKE '%{$keyword}%'
                    OR REPLACE(cd.firstname, ' ', '') LIKE '%{$keyword}%'
                    OR REPLACE(ca.email, ' ', '') LIKE '%{$keyword}%'
                )
                LIMIT 0, {$limit}
                ";
        
        return $sql;
    }
    
    private function _getQueryInvoice ($keyword, $limit = 10)
    {
        /* --- ค้นหาหมายเลข invoice --- */
        /**
         * %Q- unpaid
         * %I- paid
         * %H- invoice_number
         */
        $sql    = "";
        
        if (preg_match('/^(HS|SOD|HR|SIM|RE)/', $keyword)) {
            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=invoices&action=edit&id=', i.id), 'Invoice'
                        , i.id, i.invoice_number, i.date
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , i.status, ''
                    FROM hb_invoices i
                        LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                    WHERE
                        i.invoice_number LIKE '{$keyword}%'
                        OR i.sim_number LIKE '{$keyword}%'
                    ORDER BY i.id DESC LIMIT 0, {$limit}
                    )
                    ";
        }
        if (preg_match('/^I\-/', $keyword)) {
            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=invoices&action=edit&id=', i.id), 'Invoice'
                        , i.id, i.paid_id, i.date
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , i.status, ''
                    FROM hb_invoices i
                        LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                    WHERE
                        i.paid_id LIKE '{$keyword}%'
                    ORDER BY i.id DESC LIMIT 0, {$limit}
                    )
                    ";
        }
        if (preg_match('/^Q\-/', $keyword)) {
            $invoiceId      =  substr($keyword, strrpos($keyword, '-')+1);
            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=invoices&action=edit&id=', i.id), 'Invoice'
                        , i.id, CONCAT('Q',DATE_FORMAT(i.date,'-%Y-%m-'),i.id), i.date
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , i.status, ''
                    FROM hb_invoices i
                        LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                    WHERE
                        i.id LIKE '{$invoiceId}%'
                    ORDER BY i.id DESC LIMIT 0, {$limit}
                    )
                    ";
        }
        
        if (preg_match('/\-/', $keyword)) {
            $invoiceId      =  substr($keyword, strrpos($keyword, '-')+1);
        } else {
            $invoiceId      =  $keyword;
        }
        $sql    .= " UNION (
                    SELECT CONCAT('?cmd=invoices&action=edit&id=', i.id), 'Invoice'
                        , i.id
                        , IF(i.paid_id, i.paid_id, CONCAT('Q',DATE_FORMAT(i.date,'-%Y-%m-'),i.id))
                        , i.date
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , i.status, ''
                    FROM hb_invoices i
                        LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                    WHERE
                        i.id = '{$invoiceId}'
                    LIMIT 0, {$limit}
                    )
                    ";
        
        return $sql;
    }
    
    private function _getQueryCustomField ($keyword, $limit = 10)
    {
        $sql    = "";

        // hosting
        $sql    .= " UNION (
                SELECT CONCAT('?cmd=accounts&action=edit&id=', c2a.account_id ), 'Service(cf)'
                    , c2a.account_id, a.domain, a.date_created
                    , cd.id, cd.firstname, cd.lastname, cd.companyname
                    , a.status, p.name
                FROM 
                    hb_config2accounts c2a,
                    hb_config_items_cat cic,
                    hb_accounts a,
                    hb_products p,
                    hb_client_details cd
                WHERE
                    c2a.data LIKE '%{$keyword}%'
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.config_cat = cic.id
                    AND c2a.account_id = a.id
                    AND a.client_id = cd.id
                    AND a.product_id = p.id
                GROUP BY a.id
                LIMIT 0, {$limit}
                )
                ";
                
        return $sql;
    }
    
    /**
     * Get Query Domain
     * 
     * @author Puttipong Pengprakhon (puttipong at rvglobalsoft.com)
     * @param STRING $keyword
     * @return STRING
     */
    private function _getQueryDomain ($keyword, $limit = 10)
    {
        $sql    = "";

        return " UNION (
                    SELECT CONCAT('?cmd=domains&action=edit&id=', c2a.account_id ), 'Domains(idn)'
                        , c2a.account_id, do.name, do.date_created
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , do.status, ''
                    FROM 
                        hb_config2accounts c2a,
                        hb_config_items_cat cic,
                        hb_domains do,
                        hb_client_details cd
                    WHERE
                        c2a.data LIKE '%{$keyword}%'
                        AND c2a.rel_type = 'Domain'
                        AND c2a.config_cat = cic.id
                        AND c2a.account_id = do.id
                        AND do.client_id = cd.id
                    GROUP BY do.id
                    LIMIT 0, {$limit}
                )
                ";
    }
    
    
    /**
     * Get Query Ip Dedicate, VPS, Clound VPS
     * 
     * @author Puttipong Pengprakhon (puttipong at rvglobalsoft.com)
     * @param STRING $keyword
     * @return STRING
     */
    private function _getQueryIp($keyword, $limit = 10) {

        return " UNION (
                    SELECT CONCAT('?cmd=accounts&action=edit&id=', vps.account_id ), 'Accounts'
                        , vps.account_id
                        , CONCAT( ' ', acc.domain, ' IP ', vps.ip, ' , ', vps.additional_ip ,' ')
                        , acc.expiry_date
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , acc.status, p.name
                    FROM
                        hb_vps_details vps,
                        hb_accounts acc,
                        hb_products p,
                        hb_client_details cd
                    WHERE
                        (
                            vps.ip LIKE '%{$keyword}%'
                            OR vps.additional_ip LIKE '%$keyword%'
                        ) AND acc.id = vps.account_id
                        AND acc.client_id = cd.id
                        AND acc.product_id = p.id
                    GROUP BY vps.account_id
                    LIMIT 0, {$limit}
                )
                ";
    }
    
    
    private function _getQueryIpExternal($keyword) {
        // TODO      
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