<?php

hbm_create('Onlydomains dot com Domain Registrar', array(
    'description' => 'Onlydomains dot com Domain Registrar module for HostBill, using procedural DevKit',
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
        hbm_error('CMD:onlydomainsdotcom.domain.action is testmode');
        return $return;
    }
    
    $aResult    = onlydomainsdotcomDomainAPI::singleton()->synchronize($details['domain'], $details);

    if ($aResult) {
        $return['expires']  = $aResult['expires'];
        $return['status']   = $aResult['status'];
        $return['ns']       = $aResult['ns'];
    } else {
        hbm_error('CMD:onlydomainsdotcom.domain.synchronize ไม่พบข้อมูล');
    }
    
    return $return;
});

//REGISTER:
hbm_on_action('domain.register', function($details) {
    hbm_error('CMD:onlydomainsdotcom.domain.register รอดำเนิการ');
    return false;
});

hbm_on_action('domain.renew', function($details) {
    hbm_error('CMD:onlydomainsdotcom.domain.renew รอดำเนิการ');
    return false;
});

hbm_on_action('domain.getnameservers', function($details) {
    $return = array();
    hbm_error('CMD:onlydomainsdotcom.domain.getnameservers รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatenameservers', function($details) {
    hbm_error('CMD:onlydomainsdotcom.domain.updatenameservers รอดำเนิการ');
    
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
           'do'			=> 'Update name server onlydomaindotcom'
    );
	
    $aRes = $apiCustom->request($post);
    
    
    return false;
});

hbm_on_action('domain.getcontacts', function($details) {
    $return = array();
    hbm_error('CMD:onlydomainsdotcom.domain.getcontacts รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatecontacts', function($details) {
    hbm_error('CMD:onlydomainsdotcom.domain.updatecontacts รอดำเนิการ');
    return false;
});

class onlydomainsdotcomDomainAPI {
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
    
    private function __construct () 
    {
        
    }

    private function send ($action, $param)
    {
        $apiLogin   = hbm_get_app_config('API Login');
        $apiKey     = hbm_get_app_config('API Key');
    }
    
    public function synchronize ($domainName, $detail = array())
    {
        $return         = array();
        $return['ns']   = array();
        
        $expire     = $this->_getExpireDateFromImport($domainName);
        if ($expire) {
            $expireDate     = strtotime($expire);
            $status         = $detail['status'];
            /*
            if ($expireDate < strtotime('-10 year')) {
                $expire     = $detail['expires'];
                $expireDate = strtotime($expire);
            }
            */
            if ($expireDate < time()) {
                $status     = 'Expired';
            }
            $return['status']   = $status;
            $return['expires']  = $expire;

            return $return;
        }

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
    
    private function _getExpireDateFromImport ($domainName)
    {
        $db         = hbm_db();

        $expire     = '';
        
        $result     = $db->query("
            SELECT *
            FROM import_domain_opensrs
            WHERE `1` = :1
            ", array(
                ':1'    => $domainName
            ))->fetch();
        
        if (isset($result['id'])) {
            $expire     = date('Y-m-d', strtotime(trim($result['5'])));
        }

        if (! $expire) {

            $result     = $db->query("
                SELECT *
                FROM import_domain_srsplus
                WHERE `1` = :1
                ", array(
                    ':1'    => $domainName
                ))->fetch();
            
            if (isset($result['id'])) {
                $expire     = date('Y-m-d', strtotime(trim($result['3'])));
            }

        }

        if (! $expire) {

            $result     = $db->query("
                SELECT *
                FROM import_domain_resellerclub
                WHERE `1` = :1
                ORDER BY `10` DESC
                ", array(
                    ':1'    => $domainName
                ))->fetch();
            
            if (isset($result['id'])) {
                $expire     = date('Y-m-d', strtotime(trim($result['10'])));
            }

        }

        if (! $expire) {

            $result     = $db->query("
                SELECT *
                FROM import_domain_dotarai
                WHERE `1` LIKE '". $domainName ."%'
                ", array(

                ))->fetch();
            
            if (isset($result['id'])) {
                $aExpire    = explode(' ', trim($result['2']));
                $expire     = $aExpire[0];
                $expire     = date('Y-m-d', strtotime($expire));
            }

        }

        return $expire;
    }

}
