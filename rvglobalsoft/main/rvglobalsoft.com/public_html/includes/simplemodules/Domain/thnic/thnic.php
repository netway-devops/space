<?php

hbm_create('THNIC Domain Registrar', array(
    'description' => 'THNIC Domain Registrar module for HostBill, using procedural DevKit',
    'version' => '1.0'
));

hbm_add_app_config('Reseller id');
hbm_add_app_config('Password');
hbm_add_app_config('Test Mode', array('type' => 'checkbox'));

// TEST CONNECTION:
hbm_on_action('module.testconnection', function() {
    return true;
});

// SYNCHRONIZE:
hbm_on_action('domain.synchronize',function($details) {

    $return     = array();
    $aResult    = thnicDomainAPI::synchronize($details['domain']);
    if ($aResult) {
        $return['expires']  = $aResult['expires'];
        $return['status']   = $aResult['status'];
        $return['ns']       = $aResult['ns'];
    } else {
        hbm_error('CMD:thnic.domain.renew ไม่พบข้อมูล');
    }
    return $return;
});

//REGISTER:
hbm_on_action('domain.register', function($details) {
    hbm_error('CMD:thnic.domain.register รอดำเนิการ');
    return false;
});

hbm_on_action('domain.renew', function($details) {
    hbm_error('CMD:thnic.domain.renew รอดำเนิการ');
    return false;
});

hbm_on_action('domain.getnameservers', function($details) {
    $return = array();
    hbm_error('CMD:thnic.domain.getnameservers รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatenameservers', function($details) {
    hbm_error('CMD:thnic.domain.updatenameservers รอดำเนิการ');
    return false;
});

hbm_on_action('domain.getcontacts', function($details) {
    $return = array();
    hbm_error('CMD:thnic.domain.getcontacts รอดำเนิการ');
    return $return;
});

hbm_on_action('domain.updatecontacts', function($details) {
    hbm_error('CMD:thnic.domain.updatecontacts รอดำเนิการ');
    return false;
});

class thnicDomainAPI {
    
    private function send ($domainName)
    {
        $tld        = strstr($domainName, '.');
        $sld        = substr($domainName, 0, - strlen($tld));
    
        $aData      = array(
            'whoisbox'  => $sld,
            'tld'       => $tld
        );
    
        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://www.thnic.co.th/whois');
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $aData);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://www.thnic.co.th/index.php?page=whois');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $curlRes    = curl_exec($ch);
        curl_close($ch);
        
        return $curlRes;
    }
    
    public function synchronize ($domainName)
    {
        $return         = array();
        $return['ns']   = array();
        
        $result         = self::send($domainName);
        
        preg_match('/Name\sServer\s\:(.*)Status\s\:/ism', $result, $matches);
        
        if (! isset($matches[1])) {
            return false;
        }
        
        //echo '<br />OUTPUT:<pre>'.print_r($matches, true).'</pre><br />';

        $matches   = preg_split('/\s*<br\s*?\/?>\s*?/i', $matches[1]);
        if (is_array($matches)) {
            foreach ($matches as $v) {
                array_push($return['ns'], trim(strip_tags($v)));
            }
        }
        
        if (preg_match('/Status\s\:(.*)ACTIVE(.*)Created\sDate\s\:/ism', $result)) {
            $return['status']   = 'Active';
        } else {
            $return['status']   = 'Expired';
        }
        
        preg_match('/Exp\sDate\s\:(.*)Domain\sType\s\:/ism', $result, $matches);

        if (! isset($matches[1])) {
            return false;
        }
        
        $return['expires']  = date('Y-m-d', strtotime(strip_tags($matches[1])));
        
        return $return;
    }
    

}