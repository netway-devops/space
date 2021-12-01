<?php

// --- Get template variable ---
$aService = $this->get_template_vars('service');
// --- Get template variable ---


// Verify App Server Management Service
$this->assign('isAppManageService', 0);
if (isset($aService['modules']) && count($aService['modules'])>0) {
    foreach ($aService['modules'] as $key => $value) {
        if (isset($aService['modules'][$key]['modname']) 
            && $aService['modules'][$key]['modname'] == 'Managed Services'
            && isset($aService['modules'][$key]['status']) && strtolower($aService['modules'][$key]['status']) == 'active') {
            $this->assign('isAppManageService', 1);
        }
    }
}


// DB
$db = hbm_db();

// Validate Reverse DNS
$vpsIp = (isset($aService['vpsip']) && $aService['vpsip'] != '') ? $aService['vpsip'] : null;
if (isset($vpsIp)) {
} else {
    $vpsIp = (isset($aService['ip']) && $aService['ip'] != '') ? $aService['ip'] : null;
}

$isIpMask = true;
$this->assign('isIpMask', 1);
if (isset($vpsIp) && $vpsIp != '') {
    if (isIpMask($vpsIp) === false) {
        $this->assign('isIpMask', 0);
    }
}


// Plugin rDNS for VPS
$this->assign('isOnrDnsVps', 0);
$query = sprintf("   
                    SELECT
                        hbmc.config
                    FROM
                        %s hbmc
                    WHERE
                        hbmc.module='rdns_vps'
                    "
                    , "hb_modules_configuration"
         );
                    
$aRes = $db->query($query)->fetchAll();
if (count($aRes) > 0 && isset($aRes[0]["config"])) {
    
    $aConf = unserialize($aRes[0]["config"]);
    if (isset($aConf['Connect plugin rDNS for vps']['value']) 
        && $aConf['Connect plugin rDNS for vps']['value'] != ''
        && $aConf['Connect plugin rDNS for vps']['value'] == '1') {

        $this->assign('isOnrDnsVps', 1);            
    }    
}


// ETC. Validate Under Here...




/**
* 
* Reference: http://php.net/manual/en/ref.network.php
* @param $ip
* @author puttipong at rvglobalsoft.com
* 
*/
function isIpMask($ip) {
    
    $rangIpMask = "203.78.96.0/20";
    list ($net, $mask) = split("/", $rangIpMask);
    
    $ip_net = ip2long($net);
    $ip_mask = ~((1 << (32 - $mask)) - 1);

    $ip_ip = ip2long($ip);
    $ip_ip_net = $ip_ip & $ip_mask;

    return ($ip_ip_net == $ip_net);
}