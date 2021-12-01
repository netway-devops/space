<?php

/*************************************************************
 *
 * Other Module Class - Hostname Update rDNS
 * 
 *  https://dev.hostbillapp.com/dev-kit/advanced-topics/adding-cron-to-your-modules/ 
 * 
 ************************************************************/

class hostname_update_rdns_controller extends HBController {
    
    /**
     * Update Hostname Dedicate, VPS, VPS Clound.
     * Call ApiCustom fn: updateHostnamerDNS
     * Fix: Connect App 'App Zabbix' server_id=62
     * 
     * @author puttipong at rvglobalsoft.com
     * @return STRING
     * 
     */
    function call_Daily() {
        
        $db = hbm_db();
        $raiseMsg = '';
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $adminUrl = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
      
        $post = array(
            'call' => 'module',
            'module' => 'billingcycle',
            'fn' => 'updateHostnamerDNS'
        );
        $aRes = $apiCustom->request($post);
        
        if (count($aRes['raiseData']['not_same_rDNS']['account_id']) > 0) {
            
            for ($i=0;$i<count($aRes['raiseData']['not_same_rDNS']['account_id']);$i++) {
              
              $account_id = $aRes['raiseData']['not_same_rDNS']['account_id'][$i];
              $domain = $aRes['raiseData']['not_same_rDNS']['domain'][$i];
              $rDns = $aRes['raiseData']['not_same_rDNS']['rDNS'][$i];
              
              $raiseMsg .= "Update hostname account_id#$account_id. domain#$domain to rDns#$rDns\r\n";
            }
        }
        
        return $raiseMsg;
    }
    
}