<?php

require_once( dirname(__DIR__) . '/library/class.sendinbluehandle_library.php');

class sendinbluehandle_controller extends HBController {
    
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
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
        
    }
    
    public function webhook ($request)
    {
        $db         = hbm_db();

        $aConfig    = $this->module->configuration;
        
		$request    = file_get_contents("php://input");
        $request    = json_decode($request, true);
        $aData      = $request;
        
        /*
        $request    = array(
            'event'         => 'error',
            'email'         => 'prasit.webexperts.co.th@gmail.com',
            'subject'       => 'ใบแจ้งหนี้หมายเลข # 86186 (Invoice #86186: Created)',
            'message-id'    => '<202005111306.35220799608@smtp-relay.mailin.fr>',
        );

        $request    = array(
            'event'         => 'error',
            'email'         => 'prasit.webexperts.co.th@gmail.com',
            'subject'       => 'RVglobalsoft:Invoice #55737 Created',
            'message-id'    => '<202005111306.64597256112@smtp-relay.mailin.fr>',
        );
        */

        $event      = isset($request['event']) ? $request['event'] : '';
        $email      = isset($request['email']) ? $request['email'] : '';
        $subject    = isset($request['subject']) ? $request['subject'] : '';
        $messageId  = isset($request['message-id']) ? $request['message-id'] : '';

        $aEvent     = array(
            'deferred', 'soft_bounce', 'spam', 'hard_bounce', 'unsubscribed', 
            'invalid_email', 'blocked', 'error'
            );
        
        if (in_array($event, $aEvent)) {
            $aTransactions      = sendinbluehandle_library::singleton($aConfig)->getAllTransactionByMessageId($messageId);
            $aTransaction       = isset($aTransactions[0]) ? $aTransactions[0] : array();
            
            // echo '<pre>'.print_r($aTransaction,true).'</pre>';

            $from       = isset($aTransaction['from']) ? $aTransaction['from'] : '';
            $aParam     = array(
                'from'      => $from,
                'email'     => $email,
            );
            $aUser      = sendinbluehandle_library::singleton($aConfig)->getUserByEmail($aParam);

            if (! isset($aUser['id'])) {
                $aParam     = array(
                    'from'      => $from,
                    'data'      => array(
                        'user'  => array(
                            'name'  => $email,
                            'email' => $email,
                            'verified' => true,
                        ),
                    ),
                );
                $aUser  = sendinbluehandle_library::singleton($aConfig)->addUser($aParam);
            }

            // echo '<pre>'.print_r($aUser,true).'</pre>';

            $userId     = isset($aUser['id']) ? $aUser['id'] : 0;
            $message    = '
                ระบบ SENDINBLUE ไม่สามารถส่ง email ที่ request จาก hostbill ได้ <br />
                อาจจะเกิดจาก ไม่มีอีเมล์นั้นแล้ว เขาบล็อกเมล์เรา อีเมล์เขาผิด อื่นๆลองถาม system เพิ่มเติม <br /><br />
                <ol>
                    <li> การแก้ปัญหานี้จะทำให้ระบบ Quota ส่ง email ต่อชั่วโมงของ Sendinblue ได้มากขึ้น </li>
                    <li> *** อย่ามองข้ามปัญหานี้ *** </li>
                    <li> ถ้าแก้ปัญหาแล้วสามารถ close ticket ได้เลย </li>
                </ol>
                Event:
                <pre>'. print_r($request, true) .'</pre>
                Log:
                <pre>'. print_r($aTransactions, true) .'</pre>
                ';

            $aParam     = array(
                'from'      => $from,
                'data'      => array(
                    'ticket'    => array(
                        'tags'      => array('is_webhook', 'is_sendinblue', 'is_'. $event),
                        'requester_id'  => $userId,
                        'custom_fields'     => array(),
                        'priority'      => 'normal',
                        'subject'       => '[Email:'. $event .'] '. $subject,
                        'comment'       => array(
                            'html_body' => $message,
                            'public'    => false,
                        ),
                    ),
                ),
            );
            
            if ($from == $aConfig['NETWAY_SENDER_EMAIL']['value']) {
                $aParam['data']['ticket']['assignee_id']    = 19828783668; // sales netway
                $aParam['data']['ticket']['custom_fields'][]    = array('id' => 360008776752, 'value' => 'automation_system');
            } else {
                $aParam['data']['ticket']['assignee_id']    = 360175000633; // sales rv
            }
            

            $aTicket    = sendinbluehandle_library::singleton($aConfig)->importTicket($aParam);

            // echo '<pre>'.print_r($aTicket,true).'</pre>';exit;

        }

        //3.sendmail
        $subject = 'Sendinblue Handle '. date('Y-m-d H:i:s') ;
        $headers = 'From: admin@netway.co.th' . "\r\n" .
        'Reply-To: admin@netway.co.th' . "\r\n" .
        'X-Mailer: PHP/' . phpversion();

        $message = "Send ". date('Y-m-d H:i:s') ."\n";
        $message .= "--------------------------------------------\n";
        $message .= print_r($request, true) . "\n";
        $message .= "--------------------------------------------\n";

        //@mail('prasit@netway.co.th', $subject, $message, $headers);

        


        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
	
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }

}