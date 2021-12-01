<?php

hbm_create('Go Daddy Domain Registrar', array(
    'description' => 'Go Daddy Domain Registrar module for HostBill, using procedural DevKit',
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
        hbm_error('CMD:godaddy.domain.action is testmode');
        return $return;
    }
    
    $aResult    = godaddyDomainAPI::synchronize($details['domain']);
    if ($aResult) {
        $return['expires']  = $aResult['expires'];
        $return['status']   = $aResult['status'];
        $return['ns']       = $aResult['ns'];
    } else {
        hbm_error('CMD:godaddy.domain.synchronize ไม่พบข้อมูล');
    }
    
    return $return;
});

//REGISTER:
hbm_on_action('domain.register', function($details) {
    hbm_error('CMD:godaddy.domain.register รอดำเนิการ');
    return false;
});

hbm_on_action('domain.renew', function($details) {
    hbm_error('CMD:godaddy.domain.renew รอดำเนิการ');
    return false;
});

hbm_on_action('domain.getnameservers', function($details) {
    $return = array();
    hbm_error('CMD:godaddy.domain.getnameservers รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatenameservers', function($details) {
    hbm_error('CMD:godaddy.domain.updatenameservers รอดำเนิการ');
    return false;
});

hbm_on_action('domain.getcontacts', function($details) {
    $return = array();
    hbm_error('CMD:godaddy.domain.getcontacts รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatecontacts', function($details) {
    hbm_error('CMD:godaddy.domain.updatecontacts รอดำเนิการ');
    return false;
});

class godaddyDomainAPI {
    
    private function send ($action, $param)
    {
        $apiLogin   = hbm_get_app_config('API Login');
        $apiKey     = hbm_get_app_config('API Key');
    }
    
    public function synchronize ($domainName)
    {
        $return         = array();
        $return['ns']   = array();

        return $return;
    }
    

}