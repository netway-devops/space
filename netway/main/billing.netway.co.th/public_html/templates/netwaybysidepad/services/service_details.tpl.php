<?php

// DB
$db = hbm_db();


$isOnrDnsVps = false;
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

        $isOnrDnsVps = true;          
    }    
}

// Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
/* -- verify include for rv custom template */
$this->assign('rvcustomtemplate', '');
if (isset($_SERVER['QUERY_STRING'])) {
    if (@preg_match('/rdns_vps/', $_SERVER['QUERY_STRING']) && $isOnrDnsVps == true) {
        $this->assign('rvcustomtemplate', APPDIR_MODULES . 'Other/rdns_vps/templates/rdns/user/rdns_vps_view.tpl');
    } else {
        // Etc.
    }
}

$custom = $this->get_template_vars('service');
$custom = $custom['custom'];
foreach ($custom as $item) {
    if($item['variable'] == 'os'){
        foreach ($item['items'] as $value) {
            if(preg_match('/Windows.*/', $value['name'])){
                $this->assign('osiswindows', true);
            }
        }
    }
	
}
 
