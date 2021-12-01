<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR_MODULES . 'Other/exportsettinghandle/model/class.exportsettinghandle_model.php');

class exportsettinghandle_controller extends HBController {
    
    private static  $instance;
    private $tplPath;
    private $aSettings;
    private $savePath;

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
        $this->savePath = dirname(dirname(APPDIR)) .'/hostbill_settings';
    }

    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', $this->tplPath);
    }

    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
    
    public function _default ($request)
    {
        $aConfig    = $this->module->configuration;

        $this->_listSetting();

        $this->template->assign('aSettings', $this->aSettings);
        $this->template->assign('savePath', $this->savePath);

        $this->template->render( $this->tplPath .'/default.tpl', array(), true);
    }

    private function _listSetting ()
    {
        $this->aSettings  = array(
            'hostbill_settings'      => array(
                'url'   => '?cmd=configuration&action=export&export=true',
                'name'  => 'General setting',
            ),
        );

        $result     = exportsettinghandle_model::singleton()->getAllProduct();
        foreach ($result as $arr) {
            $key    = 'HostBill_Product_'. $arr['id'];
            $this->aSettings[$key]    = array(
                'url'   => '?cmd=services&action=productexport&id='. $arr['id'],
                'name'  => $arr['name'],
            );

        }
    }
    
    public function export  ($request)
    {
        $aData      = array();
        $filename   = isset($request['filename']) ? $request['filename'] : '';

        $this->_listSetting();

        $aSetting   = isset($this->aSettings[$filename]) ? $this->aSettings[$filename] : array();

        if (isset($aSetting['url'])) {
            $result     = GeneralCustom::singleton()->adminUIActionRequest($aSetting['url'], array(), 1);
            $filePath   = $this->savePath .'/'. $filename.'.json';
            $file       = fopen($filePath, 'w+');
            fwrite($file, $result);
            fclose($file);

            $aData      = $result;

        }

        $this->loader->component('template/apiresponse', 'json');
        //$this->json->assign('data', $aData);
        $this->json->show();
    }

    
    
}