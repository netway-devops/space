<?php

class virtualizorlicensehandle_controller extends HBController 
{
    protected $moduleName = 'virtualizorlicensehandle';
    
    public function view($request) 
    {
    
    }
    
    public function accountdetails($params) 
    {
        $db = hbm_db();
        
    }
    
    public function changeip ($params) 
    {
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;
        
        $accountId      = $params['accountId'];
        $ip             = $params['ip'];
        $oldIp          = $params['oldIp'];

        $result         = $db->query("
                SELECT
                    a.*
                FROM
                    hb_accounts a
                WHERE
                    a.id = :accountId
                    AND a.client_id = :clientId
                ", array(
                    ':accountId'        => $accountId,
                    ':clientId'         => $clientId,
                ))->fetch();
        
        if (! isset($result['id'])) {
            $aRespond   = array(
                'success'   => false,
                'message'   => 'Invalid account owner.'
                );
            return $aRespond;
        }
        
        require_once (APPDIR .'modules/Hosting/virtualizorlicensehandle/class.virtualizorlicensehandle.php');
        
        $oHandle    = virtualizorlicensehandle::singleton();
        $oHandle->connect(array());
        
        $result     = $oHandle->noc->virt_licenses('', $oldIp);
        
        if (! isset($result['licenses']) || ! count($result['licenses'])) {
            $aRespond   = array(
                'success'   => false,
                'message'   => 'Connection error please try again.'
                );
            return $aRespond;
        }
        
        $aKey       = array_keys($result['licenses']);
        $licenseId  = isset($aKey[0]) ? $aKey[0] : 0;
        
        if (! $licenseId) {
            $aRespond   = array(
                'success'   => false,
                'message'   => 'License for IP:'. $oldIp .' not found.'
                );
            return $aRespond;
        }
        
        $result     = $oHandle->noc->virt_editips($licenseId, $ip);
        
        $to      = 'sirishom@rvglobalsoft.com,paisarn@netway.co.th,prasit@netway.co.th';
        $subject = 'softaculouslicensehandle ลูกค้าทำการเปลี่ยน ip จาก '. $oldIp .' to '. $ip;
        $message = 'Account ID:'. $accountId .' '. print_r($result, true);
        $headers = 'From: support@rvglobalsoft.com' . "\r\n" .
            'Reply-To: support@rvglobalsoft.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();
        @mail($to, $subject, $message, $headers);
        
        $aRespond   = array(
            'success'   => true,
            'message'   => 'Command send successfully.',
            'rawdata'   => print_r($result, true)
            );
        return $aRespond;
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
