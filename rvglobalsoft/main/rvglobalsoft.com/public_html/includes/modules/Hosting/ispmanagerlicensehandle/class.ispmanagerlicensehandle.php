<?php 

class ispmanagerlicensehandle extends HostingModule
{
    protected $description  = 'ส่วนจัดการ provisioning ISPManager license';
    
     protected $serverFields = array(
        'hostname' => false,
        'ip' => false,
        'maxaccounts' => false,
        'status_url' => false,
        'field1' => false,
        'field2' => false,
        'username' => true,
        'password' => true,
        'hash' => false,
        'ssl' => false,
        'nameservers' => false
    );
    
    protected $serverFieldsDescription = array(
    );
    
    protected $options      = array();
    
    protected $details      = array();
    
    public $aAccount        = array(
        'username'          => 'paisarn@rvglobalsoft.com',
        'password'          => ',o^db0wl;'
        );
        
    public $aCycle          = array(
        'Monthly'       => '1',
        'Quarterly'     => '3',
        'Semi-Annually' => '6',
        'Annually'      => '12'
        );
    
    public $aPackage        = array(
        '135'           => array('name' => 'ISPmanager Lite', 'pricelist' => '7'),
        '136'           => array('name' => 'ISPmanager Business', 'pricelist' => '4601'),
        );
    
    public $demo            = true;
    
    /**
     * 
     * http://en.5.ispdoc.com/index.php/Ordering_licenses_in_BILLmanager_5
     */
    public function verifyLicense ($ip)
    {
        $oResult    = new stdClass;
        $oResult->available     = false;
        $oResult->type          = '';
        $isAvailable            = true;
        
        // ISPmanager 5 Lite
        $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $this->aAccount['username'] 
                . ':'. $this->aAccount['password'] .'&out=xml&func=soft.checkip&pricelist=3541&period=12&ip='
                . $ip;
        $array      = $this->_requestService($urlRequest);
        
        if (isset($array['error']['msg'])) {
            $oResult->available     = false;
            $oResult->message       = $array['error']['msg'];
            $isAvailable            = false;
        }
        
        if ($isAvailable) {
            // ISPmanager 5 Business
            $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $this->aAccount['username'] 
                    . ':'. $this->aAccount['password'] .'&out=xml&func=soft.checkip&pricelist=4601&period=12&ip='
                    . $ip;
            $array      = $this->_requestService($urlRequest);
            
            if (isset($array['error']['msg'])) {
                $oResult->available     = false;
                $oResult->message       = $array['error']['msg'];
                $isAvailable            = false;
            }
        
        }
        
        if (! $isAvailable) {
            return $oResult;
        }
        
        if (self::_isClientLicense($ip)) {
            $oResult->available     = false;
            return $oResult;
        }
        
        $oResult->available     = 'Register';
        return $oResult;
    }
    
    private function _isClientLicense ($ip)
    {
        $db             = hbm_db();
        
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;
        
        $result         = $db->query("
                SELECT
                    c2a.*
                FROM
                    hb_accounts a,
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    a.id = c2a.account_id
                    AND c2a.rel_type = 'Hosting'
                    AND a.status = 'Active'
                    AND cic.variable = 'ip'
                    AND cic.id = c2a.config_cat
                    AND a.client_id = :clientId
                    AND a.product_id IN (". implode(',', array_keys($this->aPackage)) .")
                    AND c2a.data = :ip
                ", array(
                    ':clientId'     => $clientId,
                    ':ip'           => $ip
                ))->fetch();
        
        if (isset($result['config_id']) && $result['config_id']) {
            return true;
        }
        
        return false;
    }
    
    public function Create ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];
        $billingCycle   = $aDetail['billingcycle'];
        
        if (preg_match('/transfer/i', $aDetail['status'])) {
            return $this->_transfer();
        }
        
        $ip             = $this->_findIPAddress();
        
        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }
        
        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }
        
        $period         = $this->aCycle[$billingCycle];
        $priceList      = $this->aPackage[$productId]['pricelist'];
        
        $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $this->aAccount['username'] 
                . ':'. $this->aAccount['password'] .'&out=xml&func=soft.order.param&clicked_button=finish'
                . '&licname=name&sok=ok&skipbasket=on'
                . '&period='. $period
                . '&pricelist='. $priceList
                . '&ip='. $ip;
        $array      = $this->_requestService($urlRequest);
        
        if (isset($array['error']['msg'])) {
            $this->addError('Error:'. $array['error']['msg'] .'.');
            return false;
        }
        
        return true;
    }
    
    private function _transfer ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];
        $billingCycle   = $aDetail['billingcycle'];
        
        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Pending Transfer',
                date_changed = NOW()
            WHERE
                status = 'Transfer Request'
                AND id = :accountId
            ", array(
                ':accountId'    => $accountId
            ));
        
        if ($aDetail['status'] == 'Transfer Request') {
            $aLog       = array('serialized' => '1', 'data' => array(
                '0'     => array('name' => 'status', 'from' => 'Transfer Request', 'to' => 'Pending Transfer')
                ));
            $db->query("
                INSERT INTO hb_account_logs (
                    id, date, account_id, admin_login, module, manual, action, 
                    `change`, result, error, event
                ) VALUES (
                    '', NOW(), :accountId, :admin, 'ispmanagerlicensehandle', '0', 'Transfer Account', 
                    :logs, '1', '', 'TransferAccount'
                )
                ", array(
                    ':accountId'        => $accountId,
                    ':admin'            => $aAdmin['username'],
                    ':logs'             => serialize($aLog)
                ));
        }
        
        $ip             = $this->_findIPAddress();
        
        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }
        
        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }
        
        $period         = $this->aCycle[$billingCycle];
        $priceList      = $this->aPackage[$productId]['pricelist'];
        
        $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $this->aAccount['username'] 
                . ':'. $this->aAccount['password'] .'&out=xml&func=soft.order.param&clicked_button=finish'
                . '&licname=name&sok=ok&skipbasket=on'
                . '&period='. $period
                . '&pricelist='. $priceList
                . '&ip='. $ip;
        $array      = $this->_requestService($urlRequest);
        
        if (isset($array['error']['msg'])) {
            $this->addError('Error:'. $array['error']['msg'] .'.');
            return false;
        }
        
        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Active',
                date_changed = NOW()
            WHERE
                AND id = :accountId
            ", array(
                ':accountId'    => $accountId
            ));
        
        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => 'Pending Transfer', 'to' => 'Active')
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action, 
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, 'ispmanagerlicensehandle', '0', 'Transfer Account', 
                :logs, '1', '', 'TransferAccount'
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog)
            ));
        
        $this->addInfo('Transfer account:'. $accountId .' succcess.');
        
        return true;
    }
    
    public function Renewal ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }

        $period         = $this->aCycle[$billingCycle];
        
        $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $this->aAccount['username'] 
                . ':'. $this->aAccount['password'] .'&out=xml&func=service.prolong&sok=ok'
                . '&period='. $period
                . '&elid=';
        $array      = $this->_requestService($urlRequest);
        
        if (isset($array['error']['msg'])) {
            $this->addError('Error:'. $array['error']['msg'] .'.');
            return false;
        }
        
        return true;
    }
    
    public function Suspend ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }
        
        $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $this->aAccount['username'] 
                . ':'. $this->aAccount['password'] .'&out=xml&func=soft.suspend'
                . '&elid=';
        $array      = $this->_requestService($urlRequest);
        
        if (isset($array['error']['msg'])) {
            $this->addError('Error:'. $array['error']['msg'] .'.');
            return false;
        }
        
        return true;
    }
    
    public function Unsuspend ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        
        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }
        
        $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $this->aAccount['username'] 
                . ':'. $this->aAccount['password'] .'&out=xml&func=soft.resume'
                . '&elid=';
        $array      = $this->_requestService($urlRequest);
        
        if (isset($array['error']['msg'])) {
            $this->addError('Error:'. $array['error']['msg'] .'.');
            return false;
        }
        
        return true;
    }
    
    public function Terminate ()
    {
        return true;
    }

    private function _findIPAddress ()
    {
        $aDetail        = $this->account_details;
        $ip             = '';
        
        if (! isset($aDetail['customforms'])) {
            return $ip;
        }
        
        foreach ($aDetail['customforms'] as $arr) {
            if ($arr['name'] == 'IP Address') {
                foreach ($arr['data'] as $v) {
                    return $v;
                }
            }
        }
        
        return $ip;
    }
    
    private function _requestService ($urlRequest)
    {
        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        $result     = curl_exec($ch);
        curl_close($ch);
        
        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $array      = json_decode($json,TRUE);
        
        return $array;
    }
    
    public function connect ($detail)
    {
        $this->connection['username']   = $detail['username'];
        $this->connection['password']   = $detail['password'];
    }
    
    public function testConnection ()
    {
        return true;
    }
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
}
