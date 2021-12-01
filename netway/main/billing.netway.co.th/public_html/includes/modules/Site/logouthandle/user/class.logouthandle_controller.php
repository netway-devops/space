<?php

class logouthandle_controller extends HBController {

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
        $db     = hbm_db();
    }
    
    public function hookAfterclientlogout ($request)
    {
        
        $db             = hbm_db();
        $client         = hbm_logged_client();
        $oClient        = (object) $client;
        session_start();
        $_SESSION["logoutClient"]='logout';
        
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