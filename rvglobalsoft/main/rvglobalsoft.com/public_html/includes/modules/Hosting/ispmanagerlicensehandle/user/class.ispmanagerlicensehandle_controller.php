<?php

class ispmanagerlicensehandle_controller extends HBController 
{
    protected $moduleName = 'ispmanagerlicensehandle';
    
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
        
        require_once (APPDIR .'modules/Hosting/ispmanagerlicensehandle/class.ispmanagerlicensehandle.php');
        
        $oHandle    = ispmanagerlicensehandle::singleton();
        
        $urlRequest = 'https://api.ispsystem.com/manager/billmgr?authinfo='. $oHandle->aAccount['username'] 
                . ':'. $oHandle->aAccount['password'] .'&out=xml&func=soft.edit&sok=ok'
                . '&ip='. $ip
                . '&elid=';
        $array      = $oHandle->_requestService($urlRequest);
        
        $to      = 'sirishom@rvglobalsoft.com,paisarn@netway.co.th,prasit@netway.co.th';
        $subject = 'ispmanagerlicensehandle ลูกค้าทำการเปลี่ยน ip จาก '. $oldIp .' to '. $ip;
        $message = 'Account ID:'. $accountId .' '. print_r($array, true);
        $headers = 'From: support@rvglobalsoft.com' . "\r\n" .
            'Reply-To: support@rvglobalsoft.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();
        @mail($to, $subject, $message, $headers);
        
        $aRespond   = array(
            'success'   => true,
            'message'   => 'Command send successfully.',
            'rawdata'   => print_r($array, true)
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
