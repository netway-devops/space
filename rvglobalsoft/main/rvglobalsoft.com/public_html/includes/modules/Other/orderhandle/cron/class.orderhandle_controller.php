<?php

class orderhandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * @return string
     */
    public function call_EveryRun() 
    {
        $db         = hbm_db();
        $message    = '';
        
        /*
        # Step 1
        //$message    .= $this->_updateInvoiceItemIPAddress();
        # Step 2
        $message    .= $this->_updateInvoiceItemCountry();
        
        echo $message;
        */
        
        return $message;
    }
    public function call_Daily() 
    {
        $db         = hbm_db();
        $message    = '';
        
        $message    .= $this->_cancelFreezOrder();
        
        
        return $message;
    }
    
    private function _cancelFreezOrder ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT o.id, o.invoice_id
            FROM hb_orders o,
                hb_invoices i
            WHERE o.invoice_id = i.id
                AND o.date_created < DATE_SUB(NOW(), INTERVAL 5 DAY)
                AND o.status = 'Pending'
                AND i.status = 'Unpaid'
            ORDER BY o.date_created DESC
            LIMIT 15
            ")->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $orderId    = $arr['id'];
            $invoiceId  = $arr['invoice_id'];
            
            $result     = $db->query("
                SELECT a.id
                FROM hb_invoice_items ii,
                    hb_accounts a
                WHERE ii.item_id = a.id
                    AND ii.type = 'Hosting'
                    AND ii.invoice_id = '{$invoiceId}'
                    AND a.status = 'Pending'
                ")->fetchAll();
            
            if (! count($result)) {
                continue;
            }
            
            foreach ($result as $arr2) {
                $accountId  = $arr2['id'];
                $db->query("
                    UPDATE hb_accounts
                    SET status = 'Cancelled'
                    WHERE id = '{$accountId}'
                    ");
                $db->query("
                    UPDATE hb_invoices
                    SET status = 'Cancelled'
                    WHERE id = '{$invoiceId}'
                    ");
                $db->query("
                    UPDATE hb_orders
                    SET status = 'Cancelled'
                    WHERE id = '{$orderId}'
                    ");
                
            }
            
            $db->query("
                INSERT INTO hb_order_log (
                order_id, `date`, entry, who
                ) VALUES (
                '{$orderId}', NOW(), 'Cancel order ที่สั่งซื้อและไม่ชำระเงินภายใน 5 วัน', 'Automation'
                )
                ");
            
            $message    .= 'Cancel order #'. $orderId .' ที่สั่งซื้อและไม่ชำระเงินภายใน 5 วัน';
        }
        
        return $message;
    }
    
    private function _updateOrderFromCountryByIPAddress ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_orders
            WHERE order_ip_country = ''
                AND ( date_created BETWEEN '2018-08-01' AND '2018-11-01' )
            ORDER BY id DESC
            LIMIT 5
            ")->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $orderId    = $arr['id'];
            $ip         = $arr['order_ip'];
            
            $result     = @file_get_contents('http://api.ipstack.com/'. $ip .'?access_key=1b3cc5c0ea41e8170102d2c384d7a73e');
            $obj        = json_decode($result);
            $countryName    = isset($obj->country_name) ? $obj->country_name : '-';
            
            $db->query("
                UPDATE hb_orders
                SET order_ip_country = :country
                WHERE id = :id
                ", array(
                    ':id'   => $orderId,
                    ':country'  => $countryName
                ));
            
            $message    .= ' #'. $orderId .' '. $countryName;
            
        }
        
        return $message;
    }
    
    private function _updateInvoiceFromCountryByIPAddress ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE invoice_ip_country = ''
                AND invoice_ip != '' AND invoice_ip != '-'
            ORDER BY id DESC
            LIMIT 5
            ")->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $invoiceId  = $arr['id'];
            $ip         = $arr['invoice_ip'];
            $result     = @file_get_contents('http://api.ipstack.com/'. $ip .'?access_key=1b3cc5c0ea41e8170102d2c384d7a73e');
            $obj        = json_decode($result);
            $countryName    = isset($obj->country_name) ? $obj->country_name : '-';
            
            $db->query("
                UPDATE hb_invoices
                SET invoice_ip_country = :country
                WHERE id = :id
                ", array(
                    ':id'   => $invoiceId,
                    ':country'  => $countryName
                ));
            
            $message    .= ' #'. $invoiceId .' '. $countryName;
            
        }
        
        $db->query("
            UPDATE hb_invoices
            SET invoice_ip = '',
                invoice_ip_country = ''
            WHERE invoice_ip = 'Hosting'
                OR invoice_ip = 'Invoice'
                OR invoice_ip = 'Credit'
                
                
            ");
        
        return $message;
    }
    
    private function _updateInvoiceIPAddress ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE invoice_ip = ''
                AND ( `date` BETWEEN '2018-08-01' AND '2018-11-01' )
            ORDER BY id DESC
            LIMIT 5
            ")->fetchAll();
        
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $invoiceId  = $arr['id'];
            
            $ipaddress  = $this->_getIPAddressFromInvoiceItem($invoiceId);
            
            $db->query("
                UPDATE hb_invoices
                SET invoice_ip = :ip
                WHERE id = :id
                ", array(
                    ':id'   => $invoiceId,
                    ':ip'   => $ipaddress
                ));
            
            $message    .= ' #'. $invoiceId .' '. $ipaddress;
            
        }
        
        return $message;
    }
    
    private function _getIPAddressFromHosting ($itemId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT o.*
            FROM hb_accounts a,
                hb_orders o
            WHERE a.id = :id
                AND a.order_id = o.id
            ", array(
                ':id'   => $itemId
            ))->fetch();
        
        $ip     = isset($result['order_ip']) ? $result['order_ip'] : '-';
        
        return $ip;
    }
    
    private function _getIPAddressFromInvoice ($itemId)
    {
        return $this->_getIPAddressFromInvoiceItem($itemId);
    }
    
    private function _getIPAddressFromInvoiceItem ($invoiceId)
    {
        $db         = hbm_db();

        $ipaddress  = '';
        $type       = '-';
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoice_items
            WHERE invoice_id = :invoiceId
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $type   = $arr['type'];
            $itemId = $arr['item_id'];
            
            switch ($type) {
                case 'Hosting' : {
                    $ipaddress  = $this->_getIPAddressFromHosting($itemId);
                    break;
                }
                case 'Invoice' : {
                    $ipaddress  = $this->_getIPAddressFromInvoice($itemId);
                    break;
                }
                case 'Credit' : {
                    $ipaddress  = $this->_getIPAddressFromClientId($itemId);
                    break;
                }
            }
            
            if ($ipaddress) {
                break;
            }
            
        }
        
        $ipaddress  = $ipaddress ? $ipaddress : $type;
    
        return $ipaddress;
    }
    
    private function _getIPAddressFromClientId ($clientId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT ip
            FROM hb_client_access
            WHERE id = :id
            ", array(
                ':id'   => $clientId
            ))->fetch();
        
        $ip     = isset($result['ip']) ? $result['ip'] : '-';
        
        return $ip;
    }
    
    private function _updateInvoiceItemIPAddress ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE invoice_item_ip = ''
               AND  ( `datepaid` BETWEEN '2019-05-01' AND '2019-06-01' )
            ORDER BY id ASC
            LIMIT 50
            ")->fetchAll();
        
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $invoiceId  = $arr['id'];
            
            $aResult    = $this->_getIPAddressFromInvoiceItemList($invoiceId);
            $ipaddress  = isset($aResult['ip']) ? $aResult['ip'] : '';
            $country    = isset($aResult['country']) ? $aResult['country'] : '';
            
            $db->query("
                UPDATE hb_invoices
                SET invoice_item_ip = :ip,
                    invoice_item_ip_country = :country
                WHERE id = :id
                ", array(
                    ':id'   => $invoiceId,
                    ':ip'   => $ipaddress,
                    ':country'  => $country
                ));
            
            $message    .= ' #'. $invoiceId .' '. $country .' '. $ipaddress;
            
        }
        /*
        $db->query("
            UPDATE hb_invoices
            SET invoice_item_ip = ''
            WHERE invoice_item_ip LIKE '%Invoice%'
                AND invoice_item_ip_country = ''
            ");
        */
        return $message;
    }
    
    private function _getIPAddressFromInvoiceItemList ($invoiceId)
    {
        $db         = hbm_db();
        
        $aResult    = array('ip' => '', 'country' => '');
        $type       = '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoice_items
            WHERE invoice_id = :invoiceId
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $itemId = $arr['item_id'];
            $desc   = $arr['description'];
            $itemType_  = $arr['type'];
            
            if (preg_match('/^NOC\sLicenses/', $desc)) {
                $country    = $this->_getCountryFromClientIdByInvoiceId($invoiceId);
                $aResult['ip']      = 'NOC';
                $aResult['country'] = $country;
                break;
            }
            
            if (preg_match('/^SSL/', $desc)) {
                $domain     = $this->_getDomainFromAccount($itemId);
                if (! $type) {
                    $type   = 'SSL';
                }
                $aResult['ip'] .= $domain ."\n";
            }
            
            if (preg_match('/^Licenses/', $desc) || preg_match('/^Renew.*RVSkin/', $desc)) {
                $ip         = $this->_getIPAddressFromAccount($itemId);
                if (! $type) {
                    $type   = 'Licenses';
                }
                $aResult['ip'] .= $ip ."\n";
            }
            
            if (preg_match('/^Invoice/', $desc)) {
                $country    = $this->_getIPAddressFromInvoiceByInvoiceItem($itemId);
                $aResult['ip']      = 'Invoice';
                $aResult['country'] .= $country ."\n";
            }
            
            if ($itemType_ == 'Credit') {
                $itemType   = 'Credit';
            }
            
        }

        if (! $aResult['ip'] && isset($itemType)) {
            $type   = $itemType;
            $aResult['ip']  = '-';
        }
        
        if ($type == 'SSL') {
            $aResult['ip']  = $type ."\n". $aResult['ip'];
        }
        
        if ($type == 'Licenses') {
            $aResult['ip']  = $type ."\n". $aResult['ip'];
        }
        
        $aResult['ip']      = nl2br($aResult['ip']);
        $aResult['country'] = nl2br($aResult['country']);
        
        //echo '<pre>'. print_r($aResult,true) .'</pre>';exit;
        return $aResult;
    }
    
    private function _getCountryFromClientIdByInvoiceId ($itemId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT ll.value
            FROM hb_invoices i,
                hb_client_details cd,
                hb_language_locales ll
            WHERE i.id = :id
                AND i.client_id = cd.id
                AND cd.country = ll.keyword
                AND ll.language_id = '1' AND ll.section = 'countries'
                
            ", array(
                ':id'   => $itemId
            ))->fetch();
        
        $country    = isset($result['value']) ? $result['value'] : '-';
        
        return $country;
    }
    
    private function _getDomainFromAccount ($itemId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT domain
            FROM hb_accounts
            WHERE id = :id
            ", array(
                ':id'   => $itemId
            ))->fetch();
        
        $domain    = isset($result['domain']) ? $result['domain'] : '-';
        
        return $domain;
    }
    
    private function _getIPAddressFromAccount ($itemId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT c2a.data
            FROM hb_accounts a,
                hb_config2accounts c2a,
                hb_config_items_cat cic
            WHERE a.id = :id
                AND a.id = c2a.account_id
                AND c2a.rel_type = 'Hosting'
                AND c2a.config_cat = cic.id
                AND cic.variable = 'ip'
            ", array(
                ':id'   => $itemId
            ))->fetch();
        
        $ip     = isset($result['data']) ? $result['data'] : '-';
        
        return $ip;
    }
    
    private function _getIPAddressFromInvoiceByInvoiceItem ($item)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT invoice_item_ip_country
            FROM hb_invoices
            WHERE id = :id
            ", array(
                ':id'   => $item
            ))->fetch();
        
        $country    = isset($result['invoice_item_ip_country']) ? $result['invoice_item_ip_country'] : '-';
        
        return $country;
    }
    
    private function _updateInvoiceItemCountry ()
    {
        $db         = hbm_db();
        $message    = '';
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE invoice_item_ip_country = ''
                AND invoice_item_ip != ''
                 AND ( `datepaid` BETWEEN '2019-05-01' AND '2019-06-01' )
            ORDER BY id DESC
            LIMIT 10
            ")->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $invoiceId  = $arr['id'];
            $aList      = $this->_br2nl($arr['invoice_item_ip']);
            $aList      = explode("\n", $aList);
            $country    = '';
            foreach ($aList as $ip) {
                $ip     = trim($ip);
                if (! $ip) {
                    continue;
                }
                $result     = @file_get_contents('http://api.ipstack.com/'. trim($ip) .'?access_key=1b3cc5c0ea41e8170102d2c384d7a73e');
                $obj        = json_decode($result);
                $country    .= $ip .' : '. (isset($obj->country_name) ? $obj->country_name : '-') .'<br />';
            }
            
            $message    .= "\n". ' #'. $invoiceId .' '. $country;
            
            $db->query("
                UPDATE hb_invoices
                SET invoice_item_ip_country = :country
                WHERE id = :id
                ", array(
                    ':id'   => $invoiceId,
                    ':country'  => $country
                ));
        }
        
        return $message;
    }
    
    private function _br2nl($string)
    {
        return preg_replace('/\<br(\s*)?\/?\>/i', "\n", $string);
    } 
    
    
}


