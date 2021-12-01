<?php

class vatservicehandle_controller extends HBController {
    
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
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl', array(), true);
    }
    
    public function getByTaxId ($request)
    {
        $db     = hbm_db();
        $aData  = array();
        $taxUd  = isset($request['taxId']) ? $request['taxId'] : '';
        
        require_once(APPDIR . 'libs/nusoap-0.9.6/src/nusoap.php');
        
        $wsdl   = 'https://rdws.rd.go.th/serviceRD3/vatserviceRD3.asmx?wsdl';
        $soapclient = new nusoap_client($wsdl, true);
        $soapclient->soap_defencoding = 'UTF-8';
        $soapclient->decode_utf8 = false;
        $err    = $soapclient->getError();
        if ($err) {
            $aData['error'] = $err;
        } else {
            $aParam     = array(
                'username'  => 'anonymous',
                'password'  => 'anonymous',
                'TIN'       => $taxUd,
                'skip'      => 0
            );
            $result     = $soapclient->call('Service', $aParam);
            $result     = isset($result['ServiceResult']) ? $result['ServiceResult'] : array();
            foreach ($result as $k => $arr) {
                $aData[$k]  = $arr['anyType'];
            }
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($aData));
        $this->json->show();
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        
        $_SESSION['notification']   = array();
    }
}