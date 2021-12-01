<?php

hbm_create('DotArai Domain Registrar', array(
    'description' => 'DotArai Domain Registrar module for HostBill, using procedural DevKit',
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
        hbm_error('CMD:dotarai.domain.action is testmode');
        return $return;
    }
    
    $aResult    = dotAraiDomainAPI::synchronize($details['domain']);
    
    if ($aResult) {
        $return['expires']  = $aResult['expires'];
        $return['status']   = $aResult['status'];
        $return['ns']       = $aResult['ns'];
    } else {
        hbm_error('CMD:dotarai.domain.synchronize ไม่พบข้อมูล');
    }
    
    return $return;
});

//REGISTER:
hbm_on_action('domain.register', function($details) {

    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:dotarai.domain.action is testmode');
        return false;
    }
    
    $result    = dotAraiDomainAPI::register($details);
    if ($result) {
        return true;
    } else {
        hbm_error('CMD:dotarai.domain.register เกิดข้อผิดพลาด');
    }
    return false;
});

hbm_on_action('domain.renew', function($details) {

    // --- hostbill helper ---
    $db         = hbm_db();
    // --- hostbill helper ---
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    if ($isTestMode) {
        hbm_error('CMD:dotarai.domain.action is testmode');
        return false;
    }
    
    /*--- ถ้า order ทำ provisioning ผ่านมาแล้วไม่เกิน 90 วันไม่ให้ renew ---*/
    $domainId       = $details['id'];
    $domainName     = $details['domain'];
    
    require_once(APPDIR . 'class.general.custom.php');
    $result     = GeneralCustom::singleton()->isDomainAllowRenewable($domainId);
    if (! $result) {
        hbm_error('Domain #' . $domainId  . ' ไม่อยู่ในเงื่อนไขที่จะทำการ autorenew ได้ ');
        return false;
    }
    
    $result    = dotAraiDomainAPI::renew($details);
    
    if ($result) {
        return true;
    } else {
        hbm_error('CMD:dotarai.domain.renew เกิดข้อผิดพลาด');
    }
    
    return false;
});

hbm_on_action('domain.transfer', function($details) {

    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:dotarai.domain.action is testmode');
        return false;
    }
    
    $result    = dotAraiDomainAPI::transfer($details);
    if ($result) {
        return true;
    } else {
        hbm_error('CMD:dotarai.domain.transfer เกิดข้อผิดพลาด');
    }
    
    return false;
});

hbm_on_action('domain.getcontacts', function($details) {
    // [TODO] ไม่มี API
    hbm_error('CMD:dotarai.domain.getcontacts รอดำเนิการ');
    return false;
});

hbm_on_action('domain.updatecontacts', function($details) {
    // [TODO] ไม่มี API
    hbm_error('CMD:dotarai.domain.updatecontacts รอดำเนิการ');
    return false;
});

hbm_on_action('domain.getnameservers', function($details) {
    $return     = array();
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:dotarai.domain.action is testmode');
        return false;
    }
    
    $aResult    = dotAraiDomainAPI::synchronize($details['domain']);
    
    if ($aResult) {
        $return     = $aResult['ns'];
    } else {
        hbm_error('CMD:dotarai.domain.getnameservers ไม่พบข้อมูล');
    }
    
    return $return;
});

hbm_on_action('domain.updatenameservers', function($details) {
    
    $isTestMode = hbm_get_app_config('Use Test Mode');
    
    if ($isTestMode) {
        hbm_error('CMD:dotarai.domain.action is testmode');
        return false;
    }
    
    $result     = dotAraiDomainAPI::updatenameservers($details);
    
    if ($result) {
        
        /* --- sync update domain info --- */
        $api = new ApiWrapper();
        $params = array( 'id' => $details['id'] );
        $api->domainSynch($params);
        
        return true;
        
    } else {
        return false;
    }
});

class dotAraiDomainAPI {
    
    public static $aHBFieldToReg      = array(
                'firstname'         => 'fname',
                'lastname'          => 'lname',
                'companyname'       => 'company',
                'address1'          => 'address1',
                'address2'          => 'address2',
                'address3'          => 'address3', //  ไม่ปรากฏ
                'city'              => 'city',
                'state'             => 'state',
                'postcode'          => 'zip',
                'country'           => 'country',
                'email'             => 'email',
                'phonenumber'       => 'phone',
                'fax'               => 'fax'
                );
    public static $aContact = array('admin' => 'admin', 'tech' => 'tech', 'registrant' => 'reg', 'billing' => 'bill');
    
    private function send ($action, $param)
    {
        $apiLogin   = hbm_get_app_config('API Login');
        $apiKey     = hbm_get_app_config('API Key');
        
        $strRequest = '&api_login='     . $apiLogin
                    . '&api_key='       . $apiKey
                    . $param
                    . '&action='        . $action;
        
        $hoststring = 'https://bp.dotarai.com/api/index.php';
        $ch = curl_init ();
        curl_setopt ($ch, CURLOPT_URL,$hoststring);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt ($ch, CURLOPT_POST, 1);
        curl_setopt ($ch, CURLOPT_POSTFIELDS, $strRequest);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
        
        $result = curl_exec ($ch);

        return $result;
    }
    
    public function synchronize ($domainName)
    {
        $return         = array();
        $return['ns']   = array();
        
        $param          = '&domain_name='   . $domainName;
        
        $result         = self::send('whois', $param);
        
        preg_match('/Status:\s(.*)/i', $result, $matches);
        
        if (! isset($matches[1])) {
            return false;
        }
        
        $status         = ucfirst(strtolower(trim($matches[1])));
        
        if ($status != 'Active') {
            return false;
        }
        
        $return['status']       = 'Active';
        
        preg_match_all('/Name\sServer:\s(.*)/i', $result, $matches);
        
        if (isset($matches[1]) && count($matches[1]) && is_array($matches[1])) {
            $return['ns']       = $matches[1];
        }
        
        preg_match('/Exp\sdate:\s(.*)/i', $result, $matches);
        
        if (isset($matches[1])) {
            $return['expires']  = date('Y-m-d', strtotime(trim($matches[1])));
        }
        
        return $return;
    }
    
    public function register ($details)
    {
        // [TODO] ทดสอบ
        return false;
        $domainName     = $details['domain'];
        $year           = $details['period'];
        
        $param          = '&domain_name='   . $domainName . '&years=' . $year;
        
        foreach (self::$aContact as $k => $v) {
            foreach (self::$aHBFieldToReg as $ki => $vi) {
                $key    = $v . '_' . $vi;
                $value  = isset($details[$k][$ki]) ? $details[$k][$ki] : '';
                $param .= '&' . $key . '=' . $value;
            }
        }
        
        foreach ($details['nameservers'] as $k => $v) {
            $param     .= '&' . $k . '=' . $v;
        }
        
        $return         = self::send('register', $param);
        // Error Result result=-1 Success Result result=0&orderId=#orderId
        parse_str($return);
        
        if (isset($result) && $result == '0') {
            return true;
        }
        
        return false;
    }
    
    public function renew($details)
    {
        // [TODO] ทดสอบ
        return false;
        $domainName     = $details['domain'];
        $period         = $details['period'];
        
        $param          = '&domain_name='   . $domainName . '&years=' . $period;
        
        $return         = self::send('renew', $param);
        
        parse_str($return);
        
        if (isset($result) && $result == '0') {
            return true;
        }
        
        return false;
    }
    
    public function transfer($details)
    {
        // [TODO] ทดสอบ
        return false;
        $domainName     = $details['domain'];
        
        $param          = '&domain_name='   . $domainName;
        
        foreach (self::$aContact as $k => $v) {
            foreach (self::$aHBFieldToReg as $ki => $vi) {
                $key    = $v . '_' . $vi;
                $value  = isset($details[$k][$ki]) ? $details[$k][$ki] : '';
                $param .= '&' . $key . '=' . $value;
            }
        }
        
        $return         = self::send('transfer', $param);
        
        parse_str($return);
        
        if (isset($result) && $result == '0') {
            return true;
        }
        
        return false;
    }
    
    public function updatenameservers($details)
    {
        
        if ( ! isset($details['nameservers']) || ! is_array($details['nameservers'])) {
            return false;
        }
        
        $domainName     = $details['domain'];
        
        $param          = '&domain_name='   . $domainName;
        
        foreach ($details['nameservers'] as $k => $v) {
            if (trim($v)) {
                $param .= '&' . $k . '=' . trim($v);
            }
        }
        
        $return         = self::send('update_ns', $param);
        
        parse_str($return);
        
        if (isset($result) && $result == '0') {
            return true;
        }
        
        return false;
    }
    
    

}