<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Other/internalcontrolhandle/model/class.internalcontrolhandle_model.php');
require_once(APPDIR . 'modules/Other/internalcontrolhandle/library/class.internalcontrolhandle_library.php');

class internalcontrolhandle_controller extends HBController {
    
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
        $oInfo      = (object) array(
            'title' => 'Internal Control',
            'desc'  => '',
            );
        $this->template->assign('oInfo', $oInfo);
        
        $db         = hbm_db();
        $aConfig    = $this->module->configuration;
        
        $viewId     = $aConfig['ZENDESK_ERROR_VIEW_ID']['value'];
        
        $result     = internalcontrolhandle_library::singleton($aConfig)->getViewCountById($viewId);
        $totalTicket    = isset($result['value']) ? $result['value'] : 0;
        
        
                
        # echo '<pre>'. print_r($result, true) .'</pre>';
        
        
        $this->template->assign('totalTicket', $totalTicket);

        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
	
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}