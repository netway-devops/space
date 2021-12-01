<?php
/**
 * 
 * Hook Script After Client Delete
 * 
 */

$hostbillApiFile = APPDIR_MODULES . "Hosting/zabbix/include/api/class.hostbill.api.php";
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

if ($zabbixHost != "" && $zabbixUser != "" && $zabbixPass != "" && is_file($zabbixApiFile) && is_file($hostbillApiFile)) {
    
    // Load Hostbill Api
    include_once($hostbillApiFile);
    
    // Load Zabbix Api
    include_once($zabbixApiFile);
        
    
    // Flow
    // 1. Delete User Zabbix Group User In "Free Monitoring"
    // 2. Delete Host SNMP Group Host in "Host Group Free Monitoring"
    //      2.1 Delete Item SNMP IN, OUT
    //      2.2 Delete Graph SNMP
    //      2.3. Delete Item Traffic IN, OUT
    // 3. Delete Discovery Rule
    // 4. Delete Action Discovery
    // 5. Delete Action Traffic IN, OUT
    
    
    try {
       
        // Zabbix Connect
        $api = ZabbixApi::singleton();
        $api->_connect($zabbixHost, $zabbixUser, $zabbixPass);
         
        $aliasName = $details["email"];
        $clientId = $details["client_id"];
        
        
        // 1. Delete User
        if ($api->isUserNameExistsByAliasName($aliasName)) {
            $userId = $api->getUserIdByUserAlias($aliasName);
            $api->doUserDelete($userId);
        }
        
        
        $aServer = HostbillApi::singleton()->getServerByClientId($clientId);
        if (count($aServer) > 0) {
            
            $aDomain = HostbillApi::singleton()->getDomainByClientId($clientId);
            if (count($aDomain) > 0) {
                for ($i=0;$i<count($aDomain);$i++) {
                    
                    for ($j=0;$j<count($aServer);$j++) {
                        
                        $prefix = ($j == 0) ? "" : "-" . $j;
                        $hostName = $aDomain[$i]["domain"] . $prefix;
                        
                        // 2. Delete Host SNMP Group Host
                        if ($api->isHostExists($hostName)) {
                            $hostID = $api->getHostIdByHostName($hostName);
                            $api->doHostDelete($hostID);
                        }
                        
                    }
                }
            }
        }
        
        
        
        $aIpAddress = HostbillApi::singleton()->getIpByClientId($clientId);
        If (count($aIpAddress) > 0) {
                    for ($i=0;$i<count($aIpAddress);$i++) {
                        if (isset($aIpAddress[$i]) && $aIpAddress[$i] != "") {
                            
                            // 3. Delete Discovery Rule
                            // 4. Delete Action Discovery
                            
                            // RULE UP/DOWN
                            $dRuleName = $aIpAddress[$i] . " Up Down";
                            if ($api->isDruleNameExists($dRuleName)) {
                                $discoveryID = $api->getDiscoveryRuleIdByDiscoveryName($dRuleName);
                                $api->doDRuleDelete($discoveryID);
                            }
                            
                            
                            // ACTION DOWN
                            $actionName = $aIpAddress[$i] . " Action Lost Down";
                            if ($api->isActionNameExists($actionName)) {
                                $actionId = $api->getActionIdByActionName($actionName);
                                 if (isset($actionId)) {
                                    $api->doActionDelete($actionId);
                                 }
                            }
                            
                            
                            // ACTION UP
                            $actionName = $aIpAddress[$i] . " Action Discovered Up";
                            if ($api->isActionNameExists($actionName)) {
                                $actionId = $api->getActionIdByActionName($actionName);
                                 if (isset($actionId)) {
                                    $api->doActionDelete($actionId);
                                 }
                            }
                            
                            
                            // RULE DOWN DELAY    
                            $dRuleName = $aIpAddress[$i] . " Down Delay";
                            if ($api->isDruleNameExists($dRuleName)) {
                                $discoveryID = $api->getDiscoveryRuleIdByDiscoveryName($dRuleName);
                                $api->doDRuleDelete($discoveryID);
                            }
                            
                            
                            // ACTION DOWN DELAY
                            $actionName = $aIpAddress[$i] . " Action Down Delay";
                            if ($api->isActionNameExists($actionName)) {
                                $actionId = $api->getActionIdByActionName($actionName);
                                 if (isset($actionId)) {
                                    $api->doActionDelete($actionId);
                                 }
                            }
                            
                            
                            
                            // RULE UP DELAY
                            $dRuleName = $aIpAddress[$i] . " Up Delay";
                            if ($api->isDruleNameExists($dRuleName)) {
                                $discoveryID = $api->getDiscoveryRuleIdByDiscoveryName($dRuleName);
                                $api->doDRuleDelete($discoveryID);
                            }
                            
                            
                            
                            // ACTION UP DELAY
                            $actionName = $aIpAddress[$i] . " Action Up Delay";
                            if ($api->isActionNameExists($actionName)) {
                                $actionId = $api->getActionIdByActionName($actionName);
                                 if (isset($actionId)) {
                                    $api->doActionDelete($actionId);
                                 }
                            }
                            
                            
                            
                        }
                    }
                    
        }
                            
        
        
        
        // 5. Delete Action Traffic IN, OUT
        $aAccount = HostbillApi::singleton()->getAccountByClientId($clientId);
        if (count($aAccount) > 0) {
        	for ($i=0;$i<count($aAccount);$i++) {
        		
        		if (isset($aAccount[$i]["id"]) && $aAccount[$i]["id"] != "") {
        			
        			
        		    $actionName = "action-" . $aAccount[$i]["id"] . "-trigger";
			        $aAction = $api->getActionByActionName($actionName);
			        
			        if (count($aAction) > 0) {
			            for ($j=0;$j<count($aAction);$j++) {
			                
			                if (isset($aAction[$j]->actionid) && isset($aAction[$j]->name)) {
			                    if ($api->isActionNameExists($aAction[$j]->name)) {
			                        $api->doActionDelete($aAction[$j]->actionid);
			                    }
			                }
			                
			            }
			        }
        			
        			
        		}
        		
        	}
        }
        
        
        
                    
        
    } catch (Exception $e) {
        $this->addError($e->getMessage());
    }
    
}