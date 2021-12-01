<?php
use GuzzleHttp\Client;

require_once dirname(__DIR__) . '/model/class.accountaddonhandle_model.php';

class accountaddonhandle_controller extends HBController {
    
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
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }

    public function hookAfterAccountAddonCreate ($addonId)
    {

        /**
         * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
         */
         $result    = accountaddonhandle_model::singleton()->getInvoiceItemFromAccountAddonOrder($addonId);
         if (isset($result['id'])) {
            accountaddonhandle_model::singleton()->setInvoiceItenIsShip($result['id']);
         }

    }

}