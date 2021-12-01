<?php

require_once dirname(__DIR__) . '/class.cpanellicenselisthandle.php';
require_once dirname(__DIR__) . '/model/class.cpanellicenselisthandle_model.php';

class cpanellicenselisthandle_controller extends HBController {
    
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
        
        $this->template->assign('tplPath', dirname(__DIR__) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
        
        $result     = cpanellicenselisthandle_model::singleton()->listCpanelOSServerID();
        $this->template->assign('aDatas', $result);

        $this->template->render(dirname(__DIR__) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function download ($request)
    {
        $db         = hbm_db();
        
        $result     = cpanellicenselisthandle_model::singleton()->listCpanelOSServerID();
        $aHeader    = array();
        $aHeader[]  = array('ID','AccountId','Domain','Product','Item','ItemGroup','ipid','IPAM_IP','Hostbill_IP');
        $result     = $aHeader + $result;
        $this->template->assign('aDatas', $result);
        $this->array_to_csv_download($result);
        exit;
    }
    
    public function array_to_csv_download($array, $filename = "export.csv", $delimiter=",") {
        header('Content-Type: application/csv');
        header('Content-Disposition: attachment; filename="'.$filename.'";');
    
        // open the "output" stream
        // see http://www.php.net/manual/en/wrappers.php.php#refsect2-wrappers.php-unknown-unknown-unknown-descriptioq
        $f = fopen('php://output', 'w');
    
        foreach ($array as $line) {
            fputcsv($f, $line, $delimiter);
        }
    }   
    
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}


