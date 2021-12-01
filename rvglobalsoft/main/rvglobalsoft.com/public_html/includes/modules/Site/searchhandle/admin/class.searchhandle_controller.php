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
        if (! $query) {
            return $aResult;
        }

        $sql        = "
            SELECT 'cmdLink', 'itemPrefix'
            , 'itemId', 'itemName', 'itemDate'
            , 'clientId', 'clientFirstName', 'clientLastName', 'clientCompanyName'
            , 'itemStatus', 'productName' 
            ";
        $sql    .= $this->_getQueryClientMail($query);       
        $sql    .= $this->_getQueryInvoice($query);
        $sql    .= $this->_getProductLicenseIP($query);
       
        
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
        
         //echo '<pre>'. print_r($aResult, true) .'</pre>';

        return $aResult;
    }

    public function _default ($request)
    {
        $db     = hbm_db();
        
        echo '<!-- {"ERROR":[],"INFO":[],"STACK":0} -->'; // ไม่ไส่ error
        //$url        = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS']) ? 'https://' : 'http://';
        //$url       .= $_SERVER['SERVER_NAME'] . $_SERVER['SCRIPT_NAME'] . '?cmd=search';
        
        $keyword  = isset($request['query']) ? trim(trim($request['query'], '%')) : '';
        
        if ($keyword == '') {
            return false;
        }
        
        $sql    = "
                SELECT 'cmdLink', 'itemPrefix'
                    , 'itemId', 'itemName', 'clientFirstName', 'clientLastName' 
                ";
        $sql    .= $this->_getQueryClientMail($keyword);

        $sql    .= $this->_getQueryInvoice($keyword);

        $sql    .= $this->_getProductLicenseIP($keyword);
       
        $cacheKey   = md5(serialize($request));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null) {
            $result     = $db->query($sql)->fetchAll();
            CacheExtend::singleton()->set($cacheKey, $result, 3600);
        }
        $aDatas     = $result;
        
        $this->template->assign('aDatas', $aDatas);
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.result.tpl', array(), false);
    }
    //=== search by ip ===
 	private function _getProductLicenseIP ($keyword)
    {
        $sql    = "";
        if (preg_match("/^\d*\.\d*\.\d*\.\d*$/", $keyword)) {
            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=accounts&action=edit&id=', acc.id), 'Account'
                        , acc.id, CONCAT(p.name,':',ac.data,'#Account',acc.id), acc.date_created
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , acc.status, p.name
                    FROM hb_accounts acc
                        LEFT JOIN hb_client_details cd ON cd.id = acc.client_id
                        LEFT JOIN hb_products p ON ( acc.product_id = p.id )
                        LEFT JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                        INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )                    
                    WHERE
                        ac.data LIKE '{$keyword}%'
                    ORDER BY acc.id DESC LIMIT 0, 5
                    )
                    ";
        }
        return $sql;
    }

	//=== search by หา client จาก mail ===
 	private function _getQueryClientMail ($keyword)
    {

            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=clients&action=show&id=', cd.id), 'Clients'
                        , cd.id, CONCAT(cd.firstname,' ',cd.lastname,' ',ca.email),cd.datecreated
                        ,cd.id, cd.firstname, cd.lastname,cd.companyname
                        ,ca.status,''
                        
                    FROM hb_client_access ca JOIN hb_client_details cd ON (ca.id=cd.id)              
                    WHERE
                       
                        ca.email LIKE '%{$keyword}%'
                    ORDER BY ca.id DESC LIMIT 0, 5
                    )
                    ";
        return $sql;
    }
    


   
    private function _getQueryInvoice ($keyword)
    {
        /* --- ค้นหาหมายเลข invoice --- */
        /**
         * %Q- unpaid
         * %I- paid
         * %H- invoice_number
         */
        $sql    = "";
        
        if (preg_match('/^(HS|HN)/', $keyword)) {
            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=invoices&action=edit&id=', i.id), 'Invoice'
                        , i.id, i.invoice_number, i.date,cd.id,cd.firstname, cd.lastname, cd.companyname
                        , i.status, ''
                    FROM hb_invoices i
                        LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                    WHERE
                        i.invoice_number LIKE '{$keyword}%'
                    ORDER BY i.id DESC LIMIT 0, 5
                    )
                    ";
        }
        if (preg_match('/^I\-/', $keyword)) {
            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=invoices&action=edit&id=', i.id), 'Invoice'
                        , i.id, i.paid_id, i.date , cd.id,cd.firstname, cd.lastname, cd.companyname
                        , i.status, ''
                    FROM hb_invoices i
                        LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                    WHERE
                        i.paid_id LIKE '{$keyword}%'
                    ORDER BY i.id DESC LIMIT 0, 5
                    )
                    ";
        }
        if (preg_match('/^Q\-/', $keyword)) {
            $invoiceId      =  substr($keyword, strrpos($keyword, '-')+1);
            $sql    .= " UNION (
                    SELECT CONCAT('?cmd=invoices&action=edit&id=', i.id), 'Invoice'
                        , i.id, CONCAT('Q',DATE_FORMAT(i.date,'-%Y-%m-'),i.id),i.date
                        , cd.id, cd.firstname, cd.lastname, cd.companyname
                        , i.status, ''
                    FROM hb_invoices i
                        LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                    WHERE
                        i.id LIKE '{$invoiceId}%'
                    ORDER BY i.id DESC LIMIT 0, 5
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
                    , i.date, cd.id,cd.firstname, cd.lastname, cd.companyname
                    , i.status, ''
                FROM hb_invoices i
                    LEFT JOIN hb_client_details cd ON cd.id = i.client_id
                WHERE
                    i.id = '{$invoiceId}'
                )
                ";
        
        return $sql;
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