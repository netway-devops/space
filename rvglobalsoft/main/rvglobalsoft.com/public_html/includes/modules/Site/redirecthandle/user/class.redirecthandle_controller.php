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
    
    public function devRvsitebuilder ($request)
    {
        $db         = hbm_db();
        $aClient    = hbm_logged_client();

        require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');

        $key = "6H6LwKTbudkPw9X7lG59KDijZIfBXSehHvvCrlEscaQHOo4nVSZFmQJbVNeTjGZJ";
        $now        = time();
        $token      = array(
            'jti'   => md5($now . rand()),
            'iat'   => $now,
            'name'  => $aClient['firstname'] .' '. $aClient['lastname'] .' '. $aClient['compannyname'],
            'email' => $aClient['email']
        );
        
        $jwt        = JWT::encode($token, $key);
        $location   = 'https://dev.rvsitebuilder.com/devportal/sso/login?token=' . $jwt;

        header('Location: '. $location);
        exit;
    }
    
    public function afterCall ($request)
    {
        $aClient        = hbm_logged_client();
        $this->template->assign('aClient', $aClient);
        
        $_SESSION['notification']   = array();
    }
    
}