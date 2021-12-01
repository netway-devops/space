<?php

class requesttrialhandle_controller extends HBController {

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
        $this->_beforeRender();
    }

    public function _default ($request)
    {
        $db             = hbm_db();
    }

    public function getProductInfo ($productId)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    p.*
                FROM
                    hb_products p
                WHERE
                    p.id = :productId
                ", array(
                    ':productId'    => $productId
                ))->fetch();

        return $result;
    }

    public function isClient ()
    {
        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":['. $clientId .']'
            . ',"STACK":0} -->';
        exit;
    }

    public function send ($request)
    {
        $db             = hbm_db();
        $api            = new ApiWrapper();

        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        $ip             = isset($request['ip']) ? $request['ip'] : '';
        $productId      = isset($request['id']) ? $request['id'] : 0;
        $serverType     = isset($request['type']) ? $request['type'] : '';

        if (! $clientId) {
            echo '<!-- {"ERROR":["Require customer login."]'
                . ',"RESULT":["ERROR"]'
                . ',"STACK":0} -->';
            exit;
        }

        $oClient        = (object) $client;
        $aProduct       = self::getProductInfo($productId);

        $subject        = 'Request trial for IP:'. $ip;
        $message    = "\n"
                . "\n" . '============================================================'
                . "\n" . 'Client:   '. $oClient->firstname .' '. $oClient->lastname
                . "\n" . 'E-mail:   '. $oClient->email
                . "\n" . 'Request trial for:    '. $aProduct['name']
                . "\n" . 'IP Address:           '. $ip
                . "\n" . 'Server type:          '. $serverType
                . "\n"
                . "\n" . '============================================================'
                ;

        $aParam         = array(
            'name'      => $oClient->firstname .' '. $oClient->lastname,
            'subject'   => $subject,
            'body'      => $message,
            'email'     => $oClient->email,
            );

        $result         = $api->addTicket($aParam);

        echo '<!-- {"ERROR":[]'
            . ',"SUCCESS":["Your request has been send success."]'
            . ',"RESULT":["SUCCESS"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function sendcpanel($request)
    {
    	$db             = hbm_db();
    	$client         = hbm_logged_client();
    	$oClient        = (object) $client;
    	$productId      = isset($request['id']) ? $request['id'] : 0;
    	$aProduct       = self::getProductInfo($productId);


    	if(strpos(' ' . strtolower($aProduct['name']), 'cpanel license')){
    		$emailTemplate = $db->query("SELECT * FROM hb_email_templates WHERE id = 186")->fetch();
    		if($emailTemplate){
    			require_once (HBFDIR_LIBS . 'phpmailer/class.phpmailer.php');
    			$mailContent = $emailTemplate['message'];
    			$mailContent = preg_replace('/{(\s*)\$([\w+]*)(\s*)}/','{\$$2}', $mailContent);
    			$mailContent = preg_replace('/{\$client.firstname}/', $oClient->firstname, $mailContent);
    			$mailContent = preg_replace('/{\$client.lastname}/', $oClient->lastname, $mailContent);

    			$mail = new PHPMailer();
    			$mail->From = 'order@rvglobalsoft.com';
    			$mail->FromName = 'RVGlobalSoft Team';
    			$mail->AddAddress($oClient->email);
    			$mail->Subject = $emailTemplate['subject'];
    			$mail->Body = $mailContent;
    			$mail->ISHTML(true);
    			$ndate = date('Y-m-d H:i:s', strtotime('now'));
    			$mailContent = str_replace("'", '\\\'', $mailContent);
    			if($mail->Send()){
    				$db->query("
    						INSERT INTO
    							hb_email_log (
    								client_id, email, subject, message, date, status
    							) VALUES (
    								{$oClient->id}, '{$oClient->email}', '{$emailTemplate['subject']}', '{$mailContent}', '{$ndate}', '1'
    							)
    				");
    			}
    		}
    	}

    	echo '<!-- {"ERROR":[]'
    			. ',"SUCCESS":["email sent to client."]'
    			. ',"RESULT":["SUCCESS"]'
    					. ',"STACK":0} -->';
    	exit;

    }

    public function login ($request)
    {
        $db             = hbm_db();
        $api            = new ApiWrapper();

        $email          = isset($request['email']) ? $request['email'] : '';
        $password       = isset($request['password']) ? $request['password'] : '';

        $aParam         = array(
            'email'     => $email,
            'password'  => $password,
            );
        $result         = $api->verifyClientLogin($aParam);

        echo '<!-- {"ERROR":[]'
            . ',"RESULT":['. json_encode($result) .']'
            . ',"STACK":0} -->';
        exit;
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