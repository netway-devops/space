<?php

class redirecthandle_controller extends HBController {
    
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
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/default.tpl', array(), true);
    }
    
    public function zendeskUser ($request)
    {
        $db         = hbm_db();
        
       
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $result     = $db->query("
                SELECT zu.*
                FROM hb_zendesk_user zu
                WHERE zu.client_id = :clientId
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();

        $zendeskUserId  = isset($result['user_id']) ? $result['user_id'] : 0;
       
        if (! defined('ZENDESK_URL')) {
            define('ZENDESK_URL', 'https://rvglobalsoft.zendesk.com');
        }
        header('location:'. ZENDESK_URL .'/agent/users/'. $zendeskUserId.'/requested_tickets');
        
    }
    
    public function afterCall ($request)
    {
        $aClient        = hbm_logged_client();
        $this->template->assign('aClient', $aClient);
        
        $_SESSION['notification']   = array();
    }
    
}