<?php
/**
 * 
 * Hook Script After Client Edit
 * 
 */

$zabbixApiFile = APPDIR_MODULES . "Hosting/zabbix/include/api/class.zabbix.api.php";

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

// ##REPLACE DETAIL ZABBIX ON CREATE ORDER
// ##ZABBIX START##
$zabbixHost = "";
$zabbixUser = "";
$zabbixPass = "";
// ##ZABBIX END##

if ($zabbixHost != "" && $zabbixUser != "" && $zabbixPass != "" && is_file($zabbixApiFile)) {
	
	// Load Zabbix Api
    include_once($zabbixApiFile);
		
	try {
	   
		// Zabbix Connect
        $api = ZabbixApi::singleton();
        $api->_connect($zabbixHost, $zabbixUser, $zabbixPass);
         
        $aliasOld = $api->getUserAliasByUserName($details["previous"]["id"]);
        $aliasNew = $details['new']['email'];
        
        if (isset($aliasOld) && isset($aliasNew)) {
	        if ($api->isUserNameExistsByAliasName($aliasOld)) {
	            
	        	// Zabbix User Update
	        	$userId = $api->getUserIdByUserAlias($aliasOld);
	            $api->doUserUpdateAlias($userId, $aliasNew);
	            
	        }
        }
                    
    	
	} catch (Exception $e) {
        $this->addError($e->getMessage());
    }
	
}