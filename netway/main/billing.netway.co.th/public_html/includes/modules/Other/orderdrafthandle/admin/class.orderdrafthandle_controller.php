<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_MODULES . 'Other/orderdrafthandle/model/class.orderdrafthandle_model.php');

class orderdrafthandle_controller extends HBController {
    
    private static  $instance;
    private $tplPath;
    
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
    
    public function __construct ()
    {
        $this->tplPath  =  dirname(__DIR__) . '/templates/admin/';
    }

    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', $this->tplPath);
    }
    
    public function _default ($request)
    {
        
        $aConfig    = $this->module->configuration;
        
        $this->template->render( $this->tplPath .'/default.tpl', array(), true);
    }

    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
    
    public function addDealForm ($request)
    {
        $orderDraftId   = isset($request['orderDraftId']) ? $request['orderDraftId'] : 0;

        $result         = orderdrafthandle_model::singleton()->getOrderDraftById($orderDraftId);

        $clickupTaskId  = isset($result['clickup_task_id']) ? $result['clickup_task_id'] : '';
        $this->template->assign('clickupTaskId', $clickupTaskId);

        $this->template->assign('orderDraftId', $orderDraftId);
        
        $this->template->render( $this->tplPath .'/ajax.add_deal_form.tpl');
    }
    
    public function updateDealId  ($request)
    {
        $orderDraftId   = isset($request['orderDraftId']) ? $request['orderDraftId'] : 0;

        $aData          = $request;
        orderdrafthandle_model::singleton()->updateDealByOrderDraftId($orderDraftId, $aData);

        $this->loader->component('template/apiresponse', 'json');
        $this->json->show();
    }

    
    
}