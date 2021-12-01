<?php

class litespeedlicensehandle_controller extends HBController
{
    protected $moduleName = 'litespeedlicensehandle';

    public function view($request)
    {

    }

    public function accountdetails($params)
    {
        $db = hbm_db();

        foreach($params["account"]["custom"] as $foo){
        	if($foo["variable"] == "serial_number"){
        		foreach($foo["data"] as $value){
        			if($value){
        				$this->template->assign("serial_number", $value);
        			}
        		}
        	}
        }
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

        $to      = 'sirishom@rvglobalsoft.com,paisarn@netway.co.th,prasit@netway.co.th';
        $subject = 'litespeedlicensehandle ลูกค้าทำการเปลี่ยน ip จาก '. $oldIp .' to '. $ip;
        $message = 'Account ID:'. $accountId .' ';
        $headers = 'From: support@rvglobalsoft.com' . "\r\n" .
            'Reply-To: support@rvglobalsoft.com' . "\r\n" .
            'X-Mailer: PHP/' . phpversion();
        @mail($to, $subject, $message, $headers);

        $aRespond   = array(
            'success'   => true,
            'message'   => 'Command send successfully.',
            'rawdata'   => ''
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
