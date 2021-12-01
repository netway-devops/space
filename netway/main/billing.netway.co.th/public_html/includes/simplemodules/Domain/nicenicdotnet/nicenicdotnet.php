<?php

hbm_create('Nicenic dot net Domain Registrar', array(
    'description' => 'Nicenic dot net Domain Registrar module for HostBill, using procedural DevKit',
    'version' => '1.0'
));

hbm_add_app_config('API Login');
hbm_add_app_config('API Key');
hbm_add_app_config('Use Test Mode', array('type' => 'checkbox'));

// TEST CONNECTION:
hbm_on_action('module.testconnection', function() {
    return true;
});

// SYNCHRONIZE:
hbm_on_action('domain.synchronize',function($details) {

    $return     = array();
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:nicenicdotnet.domain.action is testmode');
        return $return;
    }
    
    $aResult    = nicenicdotnetDomainAPI::synchronize($details['domain']);
    if ($aResult) {
        $return['expires']  = $aResult['expires'];
        $return['status']   = $aResult['status'];
        $return['ns']       = $aResult['ns'];
    } else {
        hbm_error('CMD:nicenicdotnet.domain.synchronize ไม่พบข้อมูล');
    }
    
    return $return;
});

//REGISTER:
hbm_on_action('domain.register', function($details) {
    hbm_error('CMD:nicenicdotnet.domain.register รอดำเนิการ');
    return false;
});

hbm_on_action('domain.renew', function($details) {
    hbm_error('CMD:nicenicdotnet.domain.renew รอดำเนิการ');
    return false;
});

hbm_on_action('domain.getnameservers', function($details) {
    $return = array();
    hbm_error('CMD:nicenicdotnet.domain.getnameservers รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatenameservers', function($details) {
    hbm_error('CMD:nicenicdotnet.domain.updatenameservers รอดำเนิการ');
    
    require_once(APPDIR . 'class.general.custom.php');
    require_once(APPDIR . 'class.api.custom.php');
       
    $adminUrl = GeneralCustom::singleton()->getAdminUrl();
    $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     
    $post = array(
           'call' 		=> 'module',
           'module' 	=> 'dnsservicehandle',
           'fn' 		=> 'addDNSZone',
           'domainName' => $details['domain'] ,
           'domainID'	=> $details['id'] ,
           'do'			=> 'Update name server nicenicdotnet'
    );
	
    $aRes = $apiCustom->request($post);
    
    
    return false;
});

hbm_on_action('domain.getcontacts', function($details) {
    $return = array();
    hbm_error('CMD:nicenicdotnet.domain.getcontacts รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatecontacts', function($details) {
    hbm_error('CMD:nicenicdotnet.domain.updatecontacts รอดำเนิการ');
    return false;
});

class nicenicdotnetDomainAPI {
    
    private function send ($action, $param)
    {
        $apiLogin   = hbm_get_app_config('API Login');
        $apiKey     = hbm_get_app_config('API Key');
    }
    
    public function synchronize ($domainName)
    {
        $return         = array();
        $return['ns']   = array();
        
        exec('whois '. $domainName, $result);
        $result     = implode("\n", $result);
        preg_match('/Exp(iration)?\sDate:\s(.*)/i', $result, $aResult);
        
        if (isset($aResult[2])) {
            $return['expires']      = date('Y-m-d', strtotime($aResult[2]));
        } else {
            $return['expires']      = '0000-00-00';
        }
    
        return $return;
    }
    

}