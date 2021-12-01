<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Other/dbccustomerhandle/model/class.dbccustomerhandle_model.php');
require_once(APPDIR . 'modules/Other/dbccustomerhandle/library/class.dbccustomerhandle_library.php');

class dbccustomerhandle_controller extends HBController {
    
    private static  $instance;
    private $aPage  = array(
        'customer'  => 21,
        'item'      => 30,
    );
    
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
            'title' => 'Customer',
            'desc'  => '',
            );
        $this->template->assign('oInfo', $oInfo);
        
        $aConfig    = $this->module->configuration;
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function detail ($request)
    {
        $oInfo      = (object) array(
            'title' => 'Customer Detail',
            'desc'  => '',
            );
        $this->template->assign('oInfo', $oInfo);
        
        $api        = new ApiWrapper();
        $aConfig    = $this->module->configuration;
        $dbcWebUrl  = $aConfig['DBC_WEB_URL']['value'];
        
        
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $result     = dbccustomerhandle_model::singleton()->getByClientId($clientId);
        $customerNo = isset($result['customer_no']) ? $result['customer_no'] : '';
        $aCustomer  = array();
        if ($customerNo) {
            $request['customerNo']  = $customerNo;
            $request['isReturn']    = 1;
            $aCustomer  = $this->getCustomerByNo($request);
            $aCustomer['sync_by']   = $result['sync_by'];
            $aCustomer['sync_at']   = $result['sync_at'];
        }
        
        $aParam     = array(
            'id'    => $clientId
        );
        $result     = $api->getClientDetails($aParam);
        $aClient    = isset($result['client']) ? $result['client'] : array();
        
        $aCustomer  = $this->_compareCustomerData($aCustomer, $aClient);

        $findBookmark      = '00000011'.$this->_strigToBinary($customerNo);
        $customerBookmark  = $this->_bin2base64($findBookmark);
        $customerBookmark  = substr($customerBookmark,1);
        
        $this->template->assign('clientId', $clientId);
        $this->template->assign('customerNo', $customerNo);
        $this->template->assign('aCustomer', $aCustomer);
        $this->template->assign('aClient', $aClient);
        $this->template->assign('dbcWebUrl', $dbcWebUrl);
        $this->template->assign('customerEtag',$customerBookmark);
               
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.detail.tpl',array(), false);
    }
    
    private function _compareCustomerData ($aCustomer, $aClient)
    {
        if ($aCustomer['Name'] == $aClient['companyname']) {
            $aCustomer['_Name'] = 1;
        }
        if ($aCustomer['Address'] == $aClient['address1']) {
            $aCustomer['_Address'] = 1;
        }
        if ($aCustomer['Address_2'] == $aClient['address2']) {
            $aCustomer['_Address_2'] = 1;
        }
        if ($aCustomer['VAT_Registration_No'] == $aClient['taxid']) {
            $aCustomer['_VAT_Registration_No'] = 1;
        }
        if ($aCustomer['ContactName'] == $aClient['firstname'] .' '. $aClient['lastname']) {
            $aCustomer['_ContactName'] = 1;
        }
        if ($aCustomer['City'] == $aClient['city']) {
            $aCustomer['_City'] = 1;
        }
        if ($aCustomer['County'] == $aClient['state']) {
            $aCustomer['_County'] = 1;
        }
        if ($aCustomer['Post_Code'] == $aClient['postcode']) {
            $aCustomer['_Post_Code'] = 1;
        }
        if ($aCustomer['E_Mail'] == $aClient['email']) {
            $aCustomer['_E_Mail'] = 1;
        }
        if ($aCustomer['Phone_No'] == $aClient['phonenumber']) {
            $aCustomer['_Phone_No'] = 1;
        }
        if ($aCustomer['Fax_No'] == $aClient['fax']) {
            $aCustomer['_Fax_No'] = 1;
        }
        
        return $aCustomer;
    }
    
    public function getCustomerByNo ($request)
    {
        $aData      = array();
        $aConfig    = $this->module->configuration;
        
        $customerNo = isset($request['customerNo']) ? $request['customerNo'] : '';
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $result     = dbccustomerhandle_library::singleton($aConfig)->getCustomerByNo($customerNo);
        $aData      = $result;
        
        $result     = dbccustomerhandle_model::singleton()->getByCustomerNo($customerNo);
        if (isset($result['client_id'])) {
            $aData['client_id'] = $result['client_id'];
        }
        
        if ($isReturn) {
            return $aData;
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function connectCustomer ($request)
    {
        $aData      = array();
        $aConfig    = $this->module->configuration;
        
        $customerNo = isset($request['customerNo']) ? $request['customerNo'] : '';
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $aData      = array(
            'clientId'      => $clientId,
            'customerNo'    => $customerNo,
        );
        $result     = dbccustomerhandle_model::singleton()->connectCustomer($aData);
        $aData      = $result;
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
    
    public function syncCustomer ($request)
    {
        $api        = new ApiWrapper();
        $aData      = array();
        $aConfig    = $this->module->configuration;
        $aAdmin     = hbm_logged_admin();
        
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $aParam     = array(
            'id'    => $clientId
        );
        $result     = $api->getClientDetails($aParam);
        $aClient    = isset($result['client']) ? $result['client'] : array();
        
        
        $result     = dbccustomerhandle_model::singleton()->getByClientId($clientId);
        $customerNo = isset($result['customer_no']) ? $result['customer_no'] : '';
        
        $result     = dbccustomerhandle_library::singleton($aConfig)->getCustomerByNo($customerNo);
        $aCustomer  = isset($result['No']) ? $result : array();
        
        if (isset($aCustomer['No']) && isset($aClient['id'])) {
            $customerNo = $aCustomer['No'];
            $eTag       = $aCustomer['@odata.etag'];
            $aData  = array(
                'aHeader'       => array(
                    'If-Match'      => $eTag,
                ),
                'aBody'         => array(
                    'Name'      => $aClient['companyname'],
                    'Address'   => $aClient['address1'],
                    'Address_2' => $aClient['address2'],
                    'VAT_Registration_No'   => $aClient['taxid'],
                    'ContactName'   => $aClient['firstname'] .' '. $aClient['lastname'],
                    'City'      => $aClient['city'],
                    'County'    => $aClient['state'],
                    'Post_Code' => $aClient['postcode'],
                    'E_Mail'    => $aClient['email'],
                    'Phone_No'  => $aClient['phonenumber'],
                    'Fax_No'    => $aClient['fax'],
                ),
            );
            dbccustomerhandle_library::singleton($aConfig)->syncCustomer($customerNo, $aData);
            $aData      = array(
                'sync_by'       => $aAdmin['firstname'],
                'sync_at'       => date('Y-m-d H:i:s'),
            );
            dbccustomerhandle_model::singleton()->update($clientId, $aData);
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }
	
    private function _strigToBinary($customerNo)
    {
        $characters = str_split($customerNo);
     
        $binary = array();
        foreach ($characters as $character) {
            $data = unpack('H*', $character);
            $str  = base_convert($data[1], 16, 2);
            $binary[] = sprintf('%08s', $str);
        }
     
        return implode('00000000', $binary);    
    }

     private function _bin2base64($bookmarkID) {
            $arr = str_split($bookmarkID, 8);
            $str = '';
            foreach ( $arr as $binNumber ) {
                $str .= chr(bindec($binNumber));
            }
         return base64_encode($str);
        }

    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}