<?php

/**
 * 
 * Hostbill Common
 * 
 */

class HostbillCommon {
	
    /**
     * Returns a singleton HostbillCommon instance.
     *
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
     * 
     */
     public function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
    
    
    public function validate_view($request) {
        
        $input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        
        // Variable For Traffic Bandwidth Graph
        $input["hostName"] = (isset($request["hostName"]) && $request["hostName"] != "") ? trim($request["hostName"]) : "";
        $input["graphId"] = (isset($request["graphId"]) && $request["graphId"] != "") ? $request["graphId"] : null;
        $input["period"] = (isset($request["period"]) && $request["period"] != "") ? ($request["period"] * 3600 * 24) : "86400";
                
        
        if (isset($input["serverId"]) && isset($input["accountId"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_view)__Variable missing.";
        }

        return $input;
    }

    
    public function view($request) {
    	
    	$complete = "1";
        $message = "";
        
        $aTrafficNetwork = array(
              "traffic_banwidth_img" => ""
        );
        // TODO $aTrafficNetwork["traffic_banwidth_img"] NOT GRAPH
        $aDiscovery = array();
                
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_view($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            
             // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Traffic Bandwidth Graph Image
            $imageDest = APPDIR_MODULES . "Hosting/zabbix/public_html/images/tmp/" . $input["hostName"] . "_" . $input["graphId"] . ".png";
            $pattern = "/api_jsonrpc.php/";
            $url = preg_replace($pattern, "", $serverHostname);
            $user = $serverUsername;
            $password = $serverPassword;
            $aTrafficNetwork["traffic_banwidth_img"] = $api->getGraphImage($url, $user, $password, $hostName, $graphId, $period, $imageDest);
        
            // Get Traffic Host
            $aTrafficNetwork["traffic_banwidth_select_host_and_graph"] = HostbillCommon::singleton()->getTrafficNetworkSelectHostAndGraph($api, $input["accountId"]);
            
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        
        $aResponse = array(
          "traffic_network" => $aTrafficNetwork,
          // TODO "discovery" => $aDiscovery,
          "complete" => $complete,
          "message" => $message,
          "action" => "view"
        );
        
        return $aResponse;
    }
    
    
    public function validate_doIpamDelete($request) {
    	$input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["ipaddress"] = (isset($request["ipaddress"]) && $request["ipaddress"] != "") ? $request["ipaddress"] : null;
        
        if (isset($input["serverId"]) && isset($input["accountId"]) && isset($input["ipaddress"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_doIpamDelete)__Variable missing.";
        }

        return $input;
        
    }
    
    public function deleteDiscoveryRule($api, $ipaddress="") {
    	
        // RULE UP/DOWN
        $dRuleName = $ipaddress . " Up Down";
        if ($api->isDruleNameExists($dRuleName)) {
            $discoveryID = $api->getDiscoveryRuleIdByDiscoveryName($dRuleName);
            $api->doDRuleDelete($discoveryID);
        }
        
        // RULE DOWN DELAY    
        $dRuleName = $ipaddress . " Down Delay";
        if ($api->isDruleNameExists($dRuleName)) {
            $discoveryID = $api->getDiscoveryRuleIdByDiscoveryName($dRuleName);
            $api->doDRuleDelete($discoveryID);
        }
                     
        
        // RULE UP DELAY
        $dRuleName = $ipaddress . " Up Delay";
        if ($api->isDruleNameExists($dRuleName)) {
            $discoveryID = $api->getDiscoveryRuleIdByDiscoveryName($dRuleName);
            $api->doDRuleDelete($discoveryID);
        }
        
        
        return true;
    }
    
    public function deleteActionDiscorvery($api, $ipaddress="") {
    	
        // ACTION DOWN
        $actionName = $ipaddress . " Action Lost Down";
        if ($api->isActionNameExists($actionName)) {
            $actionId = $api->getActionIdByActionName($actionName);
            if (isset($actionId)) {
                $api->doActionDelete($actionId);
            }
        }
                            
                            
        // ACTION UP
        $actionName = $ipaddress . " Action Discovered Up";
        if ($api->isActionNameExists($actionName)) {
            $actionId = $api->getActionIdByActionName($actionName);
            if (isset($actionId)) {
                $api->doActionDelete($actionId);
            }
        }
        
        
        // ACTION DOWN DELAY
        $actionName = $ipaddress . " Action Down Delay";
	    if ($api->isActionNameExists($actionName)) {
            $actionId = $api->getActionIdByActionName($actionName);
            if (isset($actionId)) {
                $api->doActionDelete($actionId);
            }
        }
        
        
        // ACTION UP DELAY
        $actionName = $ipaddress . " Action Up Delay";
        if ($api->isActionNameExists($actionName)) {
            $actionId = $api->getActionIdByActionName($actionName);
            if (isset($actionId)) {
                $api->doActionDelete($actionId);
            }
        }
        
    	
        return true;
    }
    
    public function doIpamDelete($request) {
        
        $complete = "1";
        $message = "";
        
        try {
            
        	// 0. Zabbix Connect
        	// 1. Delete Discovery Rule
        	// 2. Delete Action Discovery
        	
        	
            // Validate
            $input = HostbillCommon::singleton()->validate_doIpamDelete($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = $aServer["server"]["host"];
            $serverUsername = $aServer["server"]["username"];
            $serverPassword = $aServer["server"]["password"];       
            
            // 0. Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            
            if ($input["ipaddress"] == "all") {
            	
            	$aIpAddress = HostbillApi::singleton()->getIpByAccountId($input["accountId"]);
            	if (count($aIpAddress) > 0) {
            		for ($i=0;$i<count($aIpAddress);$i++) {
                        if (isset($aIpAddress[$i]) && $aIpAddress[$i] != "") {
                        	// 1. Delete Discovery Rule
		                    $this->deleteDiscoveryRule($api, $aIpAddress[$i]);
		                    // 2. Delete Action Discovery
		                    $this->deleteActionDiscorvery($api, $aIpAddress[$i]);
                        }
            		}
            	}
            	
            } else {
            	
            	$domainName = HostbillApi::singleton()->getDomainByAccountId($input["accountId"]);
            	if (isset($domainName) && $api->isHostExists($domainName)) {
            		// 1. Delete Discovery Rule
            		$this->deleteDiscoveryRule($api, $input["ipaddress"]);
            		// 2. Delete Action Discovery
            		$this->deleteActionDiscorvery($api, $input["ipaddress"]);
            	}
            	
            }
            
            
            
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        $aResponse = array(
          "complete" => $complete,
          "message" => $message,
          "action" => "doIpamDelete"
        );
        
        return $aResponse;
        
    }
    
    
    public function validate_doSwitchDelete($request) {
        
        $input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["item_id"] = (isset($request["item_id"]) && $request["item_id"] != "") ? $request["item_id"] : null;
        $input["port_id"] = (isset($request["port_id"]) && $request["port_id"] != "") ? $request["port_id"] : null;
        
        if (isset($input["serverId"]) && isset($input["accountId"]) && isset($input["port_id"]) && isset($input["item_id"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_doSwitchDelete)__Variable missing.";
        }

        return $input;  
    }
    
    
    public function doSwitchDelete($request) {
    	
    	$complete = "1";
        $message = "";
        
        try {
            
            // 0. Zabbix Connect
            // 1. Delete Item
            // 2. Delete Trigger
            // 3. Delete Action
            
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doSwitchDelete($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = $aServer["server"]["host"];
            $serverUsername = $aServer["server"]["username"];
            $serverPassword = $aServer["server"]["password"];       
            
            // 0. Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            $itemKey = $input["accountId"] . "-network-traffic-incoming-port-" . $input["port_id"];
            $interfaceIp = HostbillApi::singleton()->getServerIdByItemIdAndPortId($input["item_id"], $input["port_id"]);
            
            if (isset($interfaceIp)) {
            	$hostId = $api->getHostIdByItemKeyAndInterfaceIp($itemKey, $interfaceIp);
            	
            	if (isset($hostId)) {
            		
            		
            		// 1. Delete Item
            	   $aItem = $api->getItemByHostIdByItemKey($hostId, $input["accountId"] . "-network-traffic-incoming-port-" . $input["port_id"]);
                   if (isset($aItem["0"]->itemid)) {
                   	    $api->doItemDelete($aItem["0"]->itemid);
                   }
                   
            	   $aItem = $api->getItemByHostIdByItemKey($hostId, $input["accountId"] . "-network-traffic-outgoing-port-" . $input["port_id"]);
                   if (isset($aItem["0"]->itemid)) {
                        $api->doItemDelete($aItem["0"]->itemid);
                   }
                   
            	   $aItem = $api->getItemByHostIdByItemKey($hostId, $input["accountId"] . ".net.if.in." . $input["port_id"]);
                   if (isset($aItem["0"]->itemid)) {
                        $api->doItemDelete($aItem["0"]->itemid);
                   }
                   
                   
            	   $aItem = $api->getItemByHostIdByItemKey($hostId, $input["accountId"] . ".net.if.out." . $input["port_id"]);
                   if (isset($aItem["0"]->itemid)) {
                        $api->doItemDelete($aItem["0"]->itemid);
                   }
                   
                   
                   // 2. Delete Trigger
                   $triggerId = $api->getTriggerIdByHostIdByDescription($hostId, $input["accountId"] . "-trigger-network-traffic-incoming-" . $input["port_id"]);
                   if (isset($triggerId)) {
                   	    $api->doTriggerDelete($triggerId);
                   }
                   
                   
            	   $triggerId = $api->getTriggerIdByHostIdByDescription($hostId, $input["accountId"] . "-trigger-network-traffic-outgoing-" . $input["port_id"]);
                   if (isset($triggerId)) {
                        $api->doTriggerDelete($triggerId);
                   }
                   
                   
                   // 3. Delete Action
                   // TODO duplicate action
            	   $actionId = $api->getActionIdByActionName("action-" . $input["accountId"] . "-trigger-network-traffic-incoming-" . $input["port_id"]);
                   if (isset($actionId)) {
                        $api->doActionDelete($actionId);
                   }
                   
                   
                   $actionId = $api->getActionIdByActionName("action-" . $input["accountId"] . "-trigger-network-traffic-outgoing-" . $input["port_id"]);
                   if (isset($actionId)) {
                   	    $api->doActionDelete($actionId);
                   }
                               		
            		
            	}
            	
            }
            
            
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        $aResponse = array(
          "complete" => $complete,
          "message" => $message,
          "action" => "doSwitchDelete"
        );
        
        return $aResponse;
    }
    
    
    public function validate_doCreateZabbix($request) {
    	$input = array( 
                "isValid" => true,
                "raiseError" => ""
        );
        
        // Variable Default
        // Connect Zabbix
        $input["server_hostname"] = (isset($request["server_hostname"]) && $request["server_hostname"] != "") ? $request["server_hostname"] : null;
        $input["server_username"] = (isset($request["server_username"]) && $request["server_username"] != "") ? $request["server_username"] : null;
        $input["server_password"] = (isset($request["server_password"]) && $request["server_password"] != "") ? $request["server_password"] : null;
        
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        $input["client_email"] = (isset($request["client_email"]) && $request["client_email"] != "") ? $request["client_email"] : null;
        $input["client_ccmail"] = (isset($request["client_ccmail"]) && $request["client_ccmail"] != "") ? $request["client_ccmail"] : null;
        
        if (isset($input["server_hostname"]) && isset($input["server_username"]) && isset($input["server_password"])) {
            if (isset($input["account_id"])) {
            	if (isset($input["client_id"])) {
            		if (isset($input["client_email"])) {
            		} else {
            			$input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doCreateZabbix)__ client_email Missing.";
            		}
            	} else {
            		$input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doCreateZabbix)__ client_id Missing.";
            	}
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doCreateZabbix)__ account_id Missing.";
            }
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doCreateZabbix)__ Servers zabbix missing. Please check products connect with app zabbix on Hostbill.";
        }
        
        return $input;
    }
    
    
    public function doCreateZabbix($request) {
        
        $raiseError = 0;
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doCreateZabbix($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Zabbix Connect By Root
            $api = ZabbixApi::singleton();
            $api->_connect($input["server_hostname"], $input["server_username"], $input["server_password"]);
            
            // ขั้นตอนการทำงาน เมื่อ click create zabbix app
            // 3. บน zabbix: match hostbill account w/ zabbix discovered host by IP address and update visible name to [h-__hb_account_id__]
            // 1. บน zabbix: add user [u-__hb_user_id__] (ถ้ายังไม่มี) ใส่ email และ CCemail ใน ช่อง media
            // 2. บน zabbix: add user เข้า hostbill usergroup (ถ้ายังไม่มี)
            // 4. บน zabbix: create action [a-__hb_account_id__-ping] สำหรับ ping test ของใครของมัน
            // 5. บน hostbill: update ค่า switch ID and switch port จาก zabbix โดยอัตโนมัติ  จะใช้ ip switch เพื่อให้เข้าใจตรงกันระหว่าง hostbill และ zabbix [s__ip_switch]
            // 6. ซึ่ง ip ต้องอยู่ใน range ip mask 203.78.96.0/20
            
            // 3. บน zabbix: match hostbill account w/ zabbix discovered host by IP address and update visible name to [h-__hb_account_id__]
            // ข้อตกลงคือเอา ip ตัวแรกไป match
            $ipaddress = HostbillDao::singleton()->findIpamConnectZabbixByAccountId($input["account_id"]);
            if (isset($ipaddress) && $ipaddress != "") {
                
                $aParams = array();
                $aParams['host']['ip'] = $ipaddress;
                $aParams['host']['name'] = "h-" . $input["account_id"] . "_" . $ipaddress;
            
                $api->rvcustom_enableHost($aParams);
                $api->rvcustom_createUpdateVisibleHost($aParams);
            } else {
                throw new Exception("Cannot get main ip. Please check IPAM or field input 'IP address'");
            }
            
            
            // 1. บน zabbix: add user [u-__hb_user_id__] (ถ้ายังไม่มี) ใส่ email และ CCemail ใน ช่อง media
            // 2. บน zabbix: add user เข้า hostbill usergroup (ถ้ายังไม่มี)
            $aParams = array();
            $aParams['user']['groupname'] = "Hostbill Users"; // Fix Group Name "Hostbill Users"
            $aParams['user']['username'] = "u-" . $input["client_id"];
            $aParams['user']['sendto'] = $input["client_email"];
            $aParams['user']['ccmail'] = $input["client_ccmail"];
                                                                            
            $api->rvcustom_createAddUser($aParams);
            
            
            
            // 4. บน zabbix: create action [a-__hb_account_id__-ping] สำหรับ ping test ของใครของมัน
            $aParams = array();
            
            $aParams['action']['name'] = "a-" . $input["account_id"] . "-ping";
            $aParams['action']['useralias'] = "u-" . $input["client_id"];
            $aParams['action']['visiblehost'] = "h-" . $input["account_id"] . "_";       
            
            $api->rvcustom_createActionTriggerPing($aParams);
            
            
            
            // TODO OoO
            // 5. บน hostbill: update ค่า switch ID and switch port จาก zabbix โดยอัตโนมัติ  จะใช้ ip switch เพื่อให้เข้าใจตรงกันระหว่าง hostbill และ zabbix [s__ip_switch]
            // 6. ซึ่ง ip ต้องอยู่ใน range ip mask 203.78.96.0/20
            if (HostbillCommon::singleton()->isIpMask($ipaddress) === true) {
                $aParams = array();
    
                $aParams['switch']['visiblehost'] = "h-" . $input["account_id"] . "_"; 
                $aSwitchInfo = $api->rvcustom_getSwitchInfoByVisibleHostName($aParams);
                
                if (isset($aSwitchInfo->port_id) && isset($aSwitchInfo->port_name) && isset($aSwitchInfo->switch_id)) {
                    $item_id = HostbillApi::singleton()->getRackItemIdBySwitchId($aSwitchInfo->switch_id);
                    
                    if (isset($item_id) && $item_id != "") {
                        // Curl to cmd addassignment
                        $curlOptionUrl = "?cmd=module&module=dedimgr&do=addassignment";
                        $curlOptionUrl .= "&account_id=" . $input["account_id"];
                        $curlOptionUrl .= "&item_id=" . $item_id;
                        $curlOptionUrl .= "&port_id=" . $aSwitchInfo->port_id;
                        $curlOptionUrl .= "&port_name=" . $aSwitchInfo->port_name;
                        
                        HostbillApi::singleton()->execCurl($curlOptionUrl);
                    } else {
                        throw new Exception("Not found item id. Please check on Hostbill 'Extras > Dedicated Servers Manager > inventory' ");
                    }
                } else {
                    throw new Exception("Host interface snmp dose not exist. Please check host interface snmp and check item on Zabbix server.");
                }
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doCreateZabbix"
        );
        
        return $aResponse;
    }
    
    
    public function validate_doCleanZabbix($request) {
    	$input = array( 
                "isValid" => true,
                "raiseError" => ""
        );
        
        // Variable Default
        // Connect Zabbix
        $input["server_hostname"] = (isset($request["server_hostname"]) && $request["server_hostname"] != "") ? $request["server_hostname"] : null;
        $input["server_username"] = (isset($request["server_username"]) && $request["server_username"] != "") ? $request["server_username"] : null;
        $input["server_password"] = (isset($request["server_password"]) && $request["server_password"] != "") ? $request["server_password"] : null;
        
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        
    
        if (isset($input["server_hostname"]) && isset($input["server_username"]) && isset($input["server_password"])) {
        	if (isset($input["account_id"])) {
        	} else {
        		$input["isValid"] = false;
        		$input["raiseError"] = "__(validate_doCleanZabbix)__ account_id Missing.";
        	}
        } else {
        	$input["isValid"] = false;
            $input["raiseError"] = "__(validate_doCleanZabbix)__ Servers zabbix missing. Please check products connect with app zabbix on Hostbill.";
        }
               
        return $input;
    }
    
    
    public function doCleanZabbix($request) {
        
        $raiseError = 0;
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doCleanZabbix"
        );
        
        return $aResponse;
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doCleanZabbix($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // 3. บน hostbill: การทำงานของ button "Create" และ "Re-Create" เหมือนกัน คือ
            //     3.1 บน zabbix: ถ้ามี host visible name [h-__hb_account_id__] ให้ update เป็นตั้งค่าเป็นค่าว่าง
            //     3.2 บน zabbix: ถ้ามี action [a-__hb_account_id__] ให้ delete
            //     3.3 บน hostbill: uassign Switch
            
            // Zabbix Connect By Root
            $api = ZabbixApi::singleton();
            $api->_connect($input["server_hostname"], $input["server_username"], $input["server_password"]);
            
            // TODO OoO
            // 3.3 บน hostbill: uassign Switch
            $aParams = array();
    
            $aParams['switch']['visiblehost'] = "h-" . $input["account_id"] . "_";
            $aSwitchInfo = $api->rvcustom_getSwitchInfoByVisibleHostName($aParams);
                
            if (isset($aSwitchInfo->port_id) && isset($aSwitchInfo->port_name) && isset($aSwitchInfo->switch_id)) {
                    $item_id = HostbillApi::singleton()->getRackItemIdBySwitchId($aSwitchInfo->switch_id);
                    
                    if (isset($item_id) && $item_id != "") {
                        
                        $curlOptionUrl = "?cmd=module&module=dedimgr&do=rmassignment";
                        $curlOptionUrl .= "&account_id=" . $input["account_id"];
                        $curlOptionUrl .= "&item_id=" . $item_id;
                        $curlOptionUrl .= "&port_id=" . $aSwitchInfo->port_id;
                        
                        HostbillApi::singleton()->execCurl($curlOptionUrl);
                    }
            }
            
            
            // 3.2 บน zabbix: ถ้ามี action [a-__hb_account_id__*] ให้ delete
            // 3.1 บน zabbix: ถ้ามี host visible name [h-__hb_account_id__] ให้ update เป็นตั้งค่าเป็นค่าว่าง
            $aParams = array();
            
            $aParams['action']['name'] = "a-" . $input["account_id"] . "-ping"; // TODO action a-__*
            $aParams['action']['visiblehost'] = "h-" . $input["account_id"] . "_";
            
            $api->rvcustom_cleanBeforeCreate($aParams);
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doCleanZabbix"
        );
        
        return $aResponse;
    }
    
    
    public function validate_doViewIpVps($request) {
        $input = array( 
                "isValid" => true,
                "raiseError" => ""
        );
        
        // Variable Default
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["ipaddress"] = (isset($request["ipaddress"]) && $request["ipaddress"] != "") ? $request["ipaddress"] : null;
        
        if (isset($input["accountId"])) {
            if (isset($input["ipaddress"])) {
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doViewIpVps)__ ipaddress Missing."; 
            }
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doViewIpVps)__ account_id Missing."; 
        }
        
        return $input;
    }
    
    
    public function doViewIpVps($request) {
        
        $raiseError = 0;
        $aIpVps = array(
            'accountId' => '',
            'rDNS' => ''
        );
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doViewIpVps($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // IP VPS
            $aRes = HostbillDao::singleton()->findAccountByIp($input["ipaddress"]);
            if (count($aRes)>0) {
                for ($i=0;$i<count($aRes);$i++) {
                    if (isset($aRes[$i]['account_id']) && $aRes[$i]['account_id'] != '') {
                        if ($aRes[$i]['account_id'] == $input["accountId"]) {
                        } else {
                            if (HostbillDao::singleton()->isHypervisorByAccountId($aRes[$i]['account_id']) === true) {
                                $aIpVps['accountId'] = $aRes[$i]['account_id'];
                                break;
                            }
                        }
                    }
                }
            }
            
            // rDNS
            $aIpVps['rDNS'] = HostbillDao::singleton()->findIpamrDnsByIp($input["ipaddress"]);
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doViewIpVps",
            "raiseData" => $aIpVps
        );
        
        return $aResponse;
    }
    
    
    public function validate_doViewIpamVPS($request) {
        $input = array( 
                "isValid" => true,
                "raiseError" => ""
        );
        
        // Variable Default
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        
        if (isset($input["accountId"])) {
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doViewIpamVPS)__ account_id Missing."; 
        }
        
        return $input;
    }
    
    public function doViewIpamVPS($request) {
        
        $raiseError = 0;
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doViewIpamVPS($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // IPAM VPS Hypervisor
            $aIpamVps = HostbillDao::singleton()->findIpamVpsByAccountId($input["accountId"]);
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doViewIpamVPS",
            "raiseData" => $aIpamVps
        );
        
        return $aResponse;
    }
    
    
    public function validate_doViewIpamZabbix($request) {
    	$input = array( 
                "isValid" => true,
                "raiseError" => ""
        );
        
        // Variable Default
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        
        if (isset($input["accountId"])) {
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doViewIpamZabbix)__ account_id Missing."; 
        }
        
        return $input;
    }
    
    
    public function doViewIpamZabbix($request) {
        
        $raiseError = 0;
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doViewIpamZabbix($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Ipam connect zabbix
            $ipaddress = HostbillDao::singleton()->findIpamConnectZabbixByAccountId($input["accountId"]);
            $ipaddress = (isset($ipaddress) && $ipaddress != "") ? $ipaddress : "";
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doViewIpamZabbix",
            "ipaddress" => $ipaddress
        );
        
        return $aResponse;
    }
    
    
    public function validate_doSetupIpamZabbix($request) {
    	$input = array( 
                "isValid" => true,
                "raiseError" => ""
        );
        
        // Variable Default
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["ipaddress"] = (isset($request["ipaddress"]) && $request["ipaddress"] != "") ? $request["ipaddress"] : null;
        
        if (isset($input["accountId"]) && isset($input["ipaddress"])) {
        	
        	$accountAssignByIp = HostbillDao::singleton()->findIpamConnectZabbixByIpaddress($input["ipaddress"]);
        	if (isset($accountAssignByIp) && $accountAssignByIp != "" && $accountAssignByIp != $input["accountId"]) {
        		$input["isValid"] = false;
                $input["raiseError"] = "__(validate_doSetupIpamZabbix)__ Ip " . $input["ipaddress"] . " exists. Assing to account " . $accountAssignByIp . ".";
        	}
        	
        } else {
        	$input["isValid"] = false;
            $input["raiseError"] = "__(validate_doSetupIpamZabbix)__Variable missing.";
        }
        
        return $input;
    }
    
    
    public function doSetupIpamZabbix($request) {
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doSetupIpamZabbix($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Replace IPam Connect Zabbix
            HostbillDao::singleton()->replaceIpamConnectZabbix($input["accountId"], $input["ipaddress"]);
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit; 
        }

        echo '<!-- {"ERROR":[],"INFO":["__doSetupIpamZabbix__"],"STACK":0} -->';
        exit;
        
        return true;
    }
    
    
    public function validate_doDiscoveryRule($request) {
    	
    	$input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["target"] = (isset($request["target"]) && $request["target"] != "") ? $request["target"] : null;
        $input["druleid"] = (isset($request["druleid"]) && $request["druleid"] != "") ? $request["druleid"] : null;
        $input["delay"] = (isset($request["delay"]) && $request["delay"] != "") ? $request["delay"] : null;
        $input["status"] = (isset($request["status"]) && $request["status"] != "") ? $request["status"] : null;
        $input["iprange"] = (isset($request["iprange"]) && $request["iprange"] != "") ? $request["iprange"] : null;
        $input["nextcheck"] = (isset($request["nextcheck"]) && $request["nextcheck"] != "") ? $request["nextcheck"] : null;
        
        
        if (isset($input["serverId"]) && isset($input["target"]) && isset($input["druleid"]) && isset($input["delay"]) && isset($input["status"]) 
            && isset($input["iprange"]) && isset($input["nextcheck"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_doDiscoveryRule)__Variable missing.";
        }

        return $input;  
    }
    
    public function doDiscoveryRule($request) {
    	
    	$raiseError = 1;
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doDiscoveryRule($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = $aServer["server"]["host"];
            $serverUsername = $aServer["server"]["username"];
            $serverPassword = $aServer["server"]["password"];       
            
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            $discoveryCheckID = $api->getDiscoveryCheckIdByDiscoveryId($input["druleid"]);
            
            $name = "";
            if ($input["target"] == "up_down") {
                $name = $input["iprange"] . " Up Down";
            } else if ($input["target"] == "down") {
                $name = $input["iprange"] . " Down Delay";
            } else if ($input["target"] == "up") {
                $name = $input["iprange"] . " Up Delay";
            }
                        
            
            $api->doDiscoveryRuleUpdate($input["druleid"], $discoveryCheckID, $name, $input["iprange"], $input["delay"], $input["status"]);
                
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
          "raiseError" => $raiseError,
          "action" => "doDiscoveryRule"
        );
        
        return $aResponse;
    }
    
    
    public function validate_doViewDiscoveryIp($request) {
    	
    	$input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["ip"] = (isset($request["ip"]) && $request["ip"] != "") ? $request["ip"] : null;
        
        if (isset($input["serverId"]) && isset($input["accountId"]) && isset($input["ip"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_doViewDiscoveryIp)__Variable missing.";
        }

        return $input;    	
    }
    
    
    public function doViewDiscoveryIp($request) {
    	 
    	$raiseError = 1;
        
        $aDiscovery = array();
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doViewDiscoveryIp($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";

                
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
                
                
            // Get Discovery
            $aDiscoveryUpDown = $api->getDiscoveryRuleByDiscoveryName($input["ip"] . " Up Down");
            $aDiscoveryDownDelay = $api->getDiscoveryRuleByDiscoveryName($input["ip"] . " Down Delay");
            $aDiscoveryUpDelay = $api->getDiscoveryRuleByDiscoveryName($input["ip"] . " Up Delay");
            
            
            // TODO validate isset
            $aDiscovery = array(
                       "up_down" => array( 
                           "druleid" => $aDiscoveryUpDown[0]->druleid,
                           "delay" => $aDiscoveryUpDown[0]->delay,
                           "status" => $aDiscoveryUpDown[0]->status,
                           "iprange" => $aDiscoveryUpDown[0]->iprange,
                           "nextcheck" => $aDiscoveryUpDown[0]->nextcheck
                       ),
                       "down" => array(
                           "druleid" => $aDiscoveryDownDelay[0]->druleid,
                           "delay" => $aDiscoveryDownDelay[0]->delay,
                           "status" => $aDiscoveryDownDelay[0]->status,
                           "iprange" => $aDiscoveryDownDelay[0]->iprange,
                           "nextcheck" => $aDiscoveryDownDelay[0]->nextcheck
                       ),
                       "up" => array(
                           "druleid" => $aDiscoveryUpDelay[0]->druleid,
                           "delay" => $aDiscoveryUpDelay[0]->delay,
                           "status" => $aDiscoveryUpDelay[0]->status,
                           "iprange" => $aDiscoveryUpDelay[0]->iprange,
                           "nextcheck" => $aDiscoveryUpDelay[0]->nextcheck
                       )
            );
                
                
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
          "discovery" => $aDiscovery,
          "raiseError" => $raiseError,
          "action" => "doViewDiscoveryIp"
        );
    	
        return $aResponse;
    }
    
    
    public function validate_viewDiscovery($request) {
    	
    	$input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        
        if (isset($input["serverId"]) && isset($input["accountId"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_viewDiscovery)__Variable missing.";
        }

        return $input;
    	
    }
    
    public function viewDiscovery($request) {
    	
    	$complete = "1";
        $message = "";
    	
    	
        $aDiscovery = array();
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_viewDiscovery($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            
                // Get Server
                $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";

                
                // Zabbix Connect
                $api = ZabbixApi::singleton();
                $api->_connect($serverHostname, $serverUsername, $serverPassword);
                
                
                // Get IPAM
                $aIpAddress = HostbillApi::singleton()->getIpByAccountId($input["accountId"]);
                
                if (count($aIpAddress) > 0) {
                    for ($i=0;$i<count($aIpAddress);$i++) {
                        
                        if (isset($aIpAddress[$i]) && $aIpAddress[$i] != "") {
                            
                            // Get Discovery UpDown
                            $discoveryName = $aIpAddress[$i] . " Up Down";
                            $aRes = $api->getDiscoveryRuleByDiscoveryName($discoveryName);
                            
                            if (count($aRes) > 0) {
                                
                                if (isset($aRes[0]->druleid) && isset($aRes[0]->nextcheck)) {
                                    
                                    // Set Discovery
                                    $aDiscovery[$i]["ip"] = $aIpAddress[$i];
                                    $aDiscovery[$i]["druleid"] = $aRes[0]->druleid;
                                    $aDiscovery[$i]["nextcheck"] = date("H:i:s", $aRes[0]->nextcheck);
                                    
                                    $dCheckID = $api->getDCheckIdByDiscoveryName($discoveryName);
                                    $aDiscovery[$i]["isup"]  = ($api->isDiscoveryUpByDCheckId($dCheckID)) ? "1" : "0";
                                    
                                }
                            }
                        }
                    }
                }
            
            
            
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }
        
        
        $aResponse = array(
          "discovery" => $aDiscovery,
          "complete" => $complete,
          "message" => $message,
          "action" => "viewDiscovery"
        );
        
        return $aResponse;
        
        
    }
    
    public function validate_doNetworkTrafficMediaAdmin($request) {
    	
    	$input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["status"] = (isset($request["status"]) && $request["status"] != "") ? $request["status"] : null;
        $input["emailName"] = (isset($request["emailName"]) && $request["emailName"] != "") ? $request["emailName"] : null;
        $input["mediaId"] = (isset($request["mediaId"]) && $request["mediaId"] != "") ? $request["mediaId"] : null;
        
        if (isset($input["serverId"]) && isset($input["accountId"]) && isset($input["status"]) && isset($input["emailName"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_doNetworkTrafficMediaAdmin)__Variable missing.";
        }

        return $input;
    }
    
    
    public function doNetworkTrafficMediaAdmin($request) {
        
        $raiseError = 1;
        $resMediaId = "";
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doNetworkTrafficMediaAdmin($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            
            
            // Get User ID
            $userID = $api->getUserIdByUserAlias("Admin");
                
            if ($input["status"] == "edit") {
                    
                $mediaId = (isset($input["mediaId"]) && $input["mediaId"] != "") ? $input["mediaId"] : null;
                    
                if (isset($mediaId) && $mediaId != "") {
                    $api->doUsermediaUpdateEmail($mediaId, $input["emailName"]);
                } else {
                    throw new Exception("Media id missing.");
                }
                    
	       } else if ($input["status"] == "add") {
                    
                if ($api->isUserMediaEmailNameExists($userID, $input["emailName"])) {
                    throw new Exception($emailName . " exists.");
                } else {
                    $aResAddMedia = $api->doUserAddMedia($userID, $input["emailName"]);
                    $resMediaId = (isset($aResAddMedia->mediaids[0])) ? $aResAddMedia->mediaids[0] : "";
                }
                    
                    
            } else if ($input["status"] == "delete") {
                    
            	// Get mediaID
                $mediaId = $api->getUserMediaIdByEmailName($userID, $input["emailName"]);
                if (isset($mediaId)) {
                    $api->doUserDeleteMedia(array($mediaId));
                } else {
                    throw new Exception("Media ID missage.");
                }
                    
            }
            
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
          "raiseError" => $raiseError,
          "mediaid" => $resMediaId,
          "action" => "doNetworkTrafficMediaAdmin"
        );
        
        
        return $aResponse;
    }
    
    
    
    
    public function validate_doDiscoveryMedia($request) {
    	
    	$input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["status"] = (isset($request["status"]) && $request["status"] != "") ? $request["status"] : null;
        $input["emailName"] = (isset($request["emailName"]) && $request["emailName"] != "") ? $request["emailName"] : null;
        $input["mediaId"] = (isset($request["mediaId"]) && $request["mediaId"] != "") ? $request["mediaId"] : null;
        
        if (isset($input["serverId"]) && isset($input["accountId"]) && isset($input["status"]) && isset($input["emailName"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_doDiscoveryMedia)__Variable missing.";
        }

        return $input;
    	
    }
    
    
    public function validate_doNetworkTrafficTrigger($request) {
        
        $input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
         // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        $input["target"] = (isset($request["target"]) && $request["target"] != "") ? $request["target"] : null;
        $input["status"] = (isset($request["status"]) && $request["status"] != "") ? $request["status"] : null;
        $input["triggerId"] = (isset($request["triggerId"]) && $request["triggerId"] != "") ? $request["triggerId"] : null;
        $input["itemId"] = (isset($request["itemId"]) && $request["itemId"] != "") ? $request["itemId"] : null;
        $input["triggerByte"] = (isset($request["triggerByte"]) && $request["triggerByte"] != "") ? $request["triggerByte"] : null;
        $input["itemDelay"] = (isset($request["itemDelay"]) && $request["itemDelay"] != "") ? $request["itemDelay"] : null;
        $input["expression"] = (isset($request["expression"]) && $request["expression"] != "") ? $request["expression"] : null;      
                 

        if (isset($input["serverId"]) && isset($input["accountId"]) && isset($input["target"]) && isset($input["status"])
            && isset($input["triggerId"]) && isset($input["itemId"]) && isset($input["triggerByte"]) && isset($input["itemDelay"])
            && isset($input["expression"])) {
        } else {
            $input["isValid"] = false;
            $input["resError"] = "__(validate_doNetworkTrafficTrigger)__Variable missing.";
        }

        return $input;
    }
    
    
    public function doNetworkTrafficTrigger($request) {
    	
    	$raiseError = 1;
    	
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doNetworkTrafficTrigger($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            
            if ($input["target"] == "on-off") {
            	
            	// Item delay
            	$api->doItemUpdateDelay($input["itemId"], $input["itemDelay"]);
            	
            	// Trigger update status
            	$api->doTriggerUpdateStatus($input["triggerId"], $input["status"]);
            	
            	// Trigger update exprssion
                $api->doTriggerUpdateExpression($input["triggerId"], $input["expression"]);
            	
            } else if ($input["target"] == "triggerExpression") {
            	
            	// Trigger update exprssion
                $api->doTriggerUpdateExpression($input["triggerId"], $input["expression"]);
            	
            } else if ($input["target"] == "itemDelay") {
            	
            	// Item delay
                $api->doItemUpdateDelay($input["itemId"], $input["itemDelay"]);
            	
            }
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
          "raiseError" => $raiseError,
          "action" => "doNetworkTrafficTrigger"
        );
                
        return $aResponse;
    }
    
    public function doDiscoveryMedia($request) {
    	
        $raiseError = 1;
        $resMediaId = "";
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doDiscoveryMedia($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            }
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            
            // Get User ID
            $clientId = HostbillApi::singleton()->getClientIdByAccountId($input["accountId"]);
            $userID = "";
            if (isset($clientId)) {
                $aClient = HostbillApi::singleton()->getClientDetailsByClientId($clientId);
                if (isset($aClient["client"]["email"])) {
	               $userAlias = $aClient["client"]["email"];
                   $userID = $api->getUserIdByUserAlias($userAlias);
                }
            } else {
                throw new Exception("Client ID missing.");
            }
            
            
                // Get mediaID
                $mediaID = $api->getUserMediaIdByEmailName($userID, $input["emailName"]);
                
                if ($input["status"] == "edit") {
                    
                    if (isset($input["mediaId"]) && $input["mediaId"] != "") {
                    	
                    	$emailName = $input["emailName"];
                        $mediaID = $input["mediaId"];
                    	$api->doUsermediaUpdateEmail($mediaID, $emailName);
                    	
                    } else {
                        throw new Exception("Media id missing.");
                    }
                    
                    
                    
                    
                } else if ($input["status"] == "add") {
                    
                    if ($api->isUserMediaEmailNameExists($userID, $input["emailName"])) {
                        throw new Exception($input["emailName"] . " exists.");
                    } else {
                        $aResAddMedia = $api->doUserAddMedia($userID, $input["emailName"]);
                        $resMediaId = (isset($aResAddMedia->mediaids[0])) ? $aResAddMedia->mediaids[0] : "";
                    }
                    
                    
                } else if ($input["status"] == "delete") {
                    
                    if (isset($mediaID)) {
                        $api->doUserDeleteMedia(array($mediaID));
                    } else {
                        throw new Exception("Media ID missage.");
                    }
                    
                }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
    	
        $aResponse = array(
          "raiseError" => $raiseError,
          "mediaid" => $resMediaId,
          "action" => "doDiscoveryMedia"
        );
        
        
        return $aResponse;
    }
    
    
    public function validate_doAddUserMedia($request) {
 
        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["emailName"] = (isset($request["emailName"]) && $request["emailName"] != "") ? $request["emailName"] : null;
        
        if (isset($input["client_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["client_id"])) {
                if (isset($input["server_id"])) {
                	if (isset($input["emailName"])) {
                	} else {
                		$input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doAddUserMedia)__ Email Not Empty.";
                	}
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doAddUserMedia)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doAddUserMedia)__ client_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function doAddUserMedia($request) {
        
        $raiseError = true;
        $raiseData = array(
            'aMedia' => array(
                'mediaid' => ""
            )
        );
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doAddUserMedia($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Graph Id By 
            
            // Get Server Zabbix
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doAddUserMedia)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            
	        $userAlias = "u-" . $input["client_id"];
			$userID = $api->getUserIdByUserAlias($userAlias);
			if (isset($userID) && $userID != "") {
			    if ($api->isUserMediaEmailNameExists($userID, $input["emailName"])) {
			        throw new Exception("__(doAddUserMedia)__ Email " . $input["emailName"] . " exists. User Media Name " . $userAlias);
			    } else {
			        $aResAddMedia = $api->doUserAddMedia($userID, $input["emailName"]);
			        $raiseData['aMedia']['mediaid'] = (isset($aResAddMedia->mediaids[0])) ? $aResAddMedia->mediaids[0] : "";
			    }
			} else {
			    throw new Exception("__(doAddUserMedia)__ Cannot get user_id. Please Check Zabbix User Media Name " . $userAlias);
			}
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doAddUserMedia",
            "preViewAs" => "",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    
    public function validate_doDeleteUserMedia($request) {
 
        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["media_id"] = (isset($request["media_id"]) && $request["media_id"] != "") ? $request["media_id"] : null;
        
        if (isset($input["account_id"]) && isset($input["server_id"]) && isset($input["media_id"])) {
        } else {
            if (isset($input["account_id"])) {
                if (isset($input["server_id"])) {
	                if (isset($input["media_id"])) {
	                } else {
	                    $input["isValid"] = false;
	                    $input["raiseError"] = "__(validate_doDeleteUserMedia)__ media_id Missing.";
	                }
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doDeleteUserMedia)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doDeleteUserMedia)__ account_id Missing.";
            }
        }
        
        return $input;
    }
    
    public function doDeleteUserMedia($request) {
        
        $raiseError = true;
        $raiseData = array();
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doDeleteUserMedia($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Graph Id By 
            
            // Get Server Zabbix
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doDeleteUserMedia)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            $api->doUserDeleteMedia(array($input["media_id"]));
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doDeleteUserMedia",
            "preViewAs" => "",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    
    
    public function validate_doActionPing($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["status"] = (isset($request["status"]) && $request["status"] != "") ? $request["status"] : "0";
        $input["esc_period"] = (isset($request["esc_period"]) && $request["esc_period"] != "") ? $request["esc_period"] : "600";       
        
        if (isset($input["account_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["account_id"])) {
                if (isset($input["server_id"])) {
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doActionPing)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doActionPing)__ account_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function doActionPing($request) {
        
        $raiseError = true;
        
        $raiseData = array();
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doActionPing($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Server Zabbix
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doActionPing)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            $actionName = "a-" . $input["account_id"] . "-ping";
            $aResAction = $api->getActionByActionName($actionName);
            if (count($aResAction)>0 && isset($aResAction[0]->actionid)) {
            	
                $api->doActionUpdateStatus($aResAction[0]->actionid, $input["status"]);
                $api->doActionUpdateEscPeriod($aResAction[0]->actionid, $input["esc_period"]);
                
            } else {
                throw new Exception("__(doActionPing)__ Cannot get action_id. Please Check Zabbix Action name " . $actionName);
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doActionPing",
            "preViewAs" => "",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    
    public function validate_viewPing($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        
        if (isset($input["account_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["account_id"])) {
                if (isset($input["server_id"])) {
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_viewPing)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_viewPing)__ account_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function viewPing($request) {
        
        $raiseError = true;
        
        $raiseData = array();
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_viewPing($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Server Zabbix
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(viewPing)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            $actionName = "a-" . $input["account_id"] . "-ping";
            $aResAction = $api->getActionByActionName($actionName);
            if (count($aResAction)>0 && isset($aResAction[0])) {
            	$raiseData = $aResAction[0];
            } else {
            	throw new Exception("__(viewPing)__ Cannot get action. Please Check Zabbix Action name " . $actionName);
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "viewPing",
            "preViewAs" => "ping",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    
    
    
    public function validate_doRecreate($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        
        if (isset($input["account_id"]) && isset($input["server_id"]) && isset($input["client_id"])) {
        } else {
            if (isset($input["account_id"])) {
                if (isset($input["server_id"])) {
                	if (isset($input["client_id"])) {
                	} else {
                		$input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doRecreate)__ client_id Missing.";
                	}
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doRecreate)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doRecreate)__ account_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function doRecreate($request) {

        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doRecreate($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Server Zabbix
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doRecreate)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            // Clean Zabbix
	        $request = array(
	           "server_hostname" => $serverHostname,
	           "server_username" => $serverUsername,
	           "server_password" => $serverPassword,
	           "account_id" => $input["account_id"]
	        );
	        $aResponse = HostbillCommon::singleton()->doCleanZabbix($request);
	        if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
	             throw new Exception("__(doRecreate)__ " . $aResponse['raiseError']);
	        }
            
            
            // Click ReCreate zabbix app
            $aClient = HostbillApi::singleton()->getClientDetailsByClientId($input["client_id"]);
	        $request = array(
	           "server_hostname" => $serverHostname,
	           "server_username" => $serverUsername,
	           "server_password" => $serverPassword,
	           "account_id" => $input["account_id"],
	           "client_id" => $input["client_id"],
	           "client_email" => (isset($aClient['client']['email'])) ? $aClient['client']['email'] : null,
	           "client_ccmail" => (isset($aClient['client']['ccmail'])) ? $aClient['client']['ccmail'] : null
	        );
	        $aResponse = HostbillCommon::singleton()->doCreateZabbix($request);
	        if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
	            throw new Exception("__(doRecreate)__ " . $aResponse['raiseError']);
	        }
            
	        
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":["create account"],"STACK":0} -->';
        exit;
        
        return true;
    }
    
    
    public function validate_viewUserMedia($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        
        if (isset($input["client_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["client_id"])) {
                if (isset($input["server_id"])) {
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_viewUserMedia)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_viewUserMedia)__ client_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function viewUserMedia($request) {
        
        $raiseError = true;
        
        $raiseData = array(
            'aMedia' => array()
        );
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_viewUserMedia($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Graph Id By 
            
            // Get Server Zabbix
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(viewUserMedia)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            $userAlias = "u-" . $input["client_id"];
            $userID = $api->getUserIdByUserAlias($userAlias);
            if (isset($userID) && $userID != "") {
            	$raiseData['aMedia'] = $api->getUserMediaByUserId($userID);
            } else {
                throw new Exception("__(viewUserMedia)__ Cannot get user_id. Please Check Zabbix User Media Name" . $userAlias);
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "viewUserMedia",
            "preViewAs" => "user_media",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    
    public function validate_viewTrafficBandwidth($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["period"] = (isset($request["period"]) && $request["period"] != "") ? ($request["period"] * 3600 * 24) : "86400";
        
        if (isset($input["account_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["account_id"])) {
            	if (isset($input["server_id"])) {
            	} else {
            		$input["isValid"] = false;
                    $input["raiseError"] = "__(validate_viewTrafficBandwidth)__ server_id Missing.";
            	}
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_viewTrafficBandwidth)__ account_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function viewTrafficBandwidth($request) {
    	
    	$raiseError = true;
        
    	$raiseData = array(
              "traffic_bandwidth_url_graph" => "" 
        );
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_viewTrafficBandwidth($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Graph Id By 
            
            // Get Server Zabbix
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
            	$serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
            	throw new Exception("__(viewTrafficBandwidth)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            
            // Get Host Id
            $visibleHostName = "h-" . $input["account_id"] . "_";
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            if (isset($hostId) && $hostId != "") {
                    
                // Check is VPS
                if (HostbillDao::singleton()->isCategorieVpsByAccountId($input["account_id"]) == true) {
                        
                    $graphName = "Network traffic on eth0"; // Pattern Agentd
                    $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);
                    
                    if (isset($graphId) && $graphId != "") {
                    } else {
                        throw new Exception("__(viewTrafficBandwidth)__ Cannot get graph_id. Because VPS. Require Zabbix Agentd. Please install zabbix agentd from visible host name " . $visibleHostName . "<BR><BR>ยังไม่รองรับ รอการ Integrate กับ OnApp !!");
                    }
                    
                } else {
                    // Etc. Dedicate, Colo, Manage External Server
                    
                    $graphName = "Network traffic on eth0"; // Pattern Agentd
                    if ($input["account_id"] == '3340') {
                        // Fix: isl.phuketdir.com
                        // Etc. Fix Here
                        $graphName = "Network traffic on eth1"; // Pattern Agentd
                    }
                    $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);
                    
                    if (isset($graphId) && $graphId != "") {
                    } else {
                        
                        $graphName = "- Traffic \(bits\/sec\, 95th Percentile\)"; // Pattern SNMP
                        $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);
                        
                        if (isset($graphId) && $graphId != "") {
                        } else {
                            throw new Exception("__(viewTrafficBandwidth)__ Cannot get graph_id. Please Check Zabbix server graph match name '- Traffic (bits/sec, 95th Percentile) [for SNMP]' or 'Network traffic on eth0 [for Agentd]' from visible host name " . $visibleHostName);
                        }
                    }
                }

            } else {
            	throw new Exception("__(viewTrafficBandwidth)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }
            
            
            // Get Graph Image
            $aParams = array(
                'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                'user' => $serverUsername,
                'password' => $serverPassword,
                'visibleHostName' => $visibleHostName,
                'graphId' => $graphId,
                'period' => $input["period"],
                'imageDest' => APPDIR_MODULES . "Hosting/zabbix/public_html/images/tmp/" . $graphId . ".png"
            );
            $raiseData["traffic_bandwidth_url_graph"] = $api->getGraphImage($aParams);
               
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "viewTrafficBandwidth",
            "preViewAs" => "traffic_bandwidth",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    
    public function validate_doTrafficBandwidthGraph($request) {
    	
    	$input = array( 
                "isValid" => true,
                "resError" => ""
        );
        
        // Variable Default
        $input["serverId"] = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
        $input["accountId"] = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
        
        // Variable For Traffic Bandwidth Graph
        $input["hostName"] = (isset($request["hostName"]) && $request["hostName"] != "") ? trim($request["hostName"]) : "";
        $input["graphId"] = (isset($request["graphId"]) && $request["graphId"] != "") ? $request["graphId"] : null;
        $input["period"] = (isset($request["period"]) && $request["period"] != "") ? ($request["period"] * 3600 * 24) : "86400";
                
        if (isset($input["serverId"]) && isset($input["accountId"]) && isset($input["hostName"]) && isset($input["graphId"])) {
        	
        } else {
        	$input["isValid"] = false;
            $input["resError"] = "__(validate_doTrafficBandwidthGraph)__Variable missing.";
        }
        
        return $input;
    }
    
    
    
    public function doTrafficBandwidthGraph($request) {
    	
        $raiseError = 1;
        
        $aTrafficNetwork = array(
              "traffic_banwidth_img" => ""
        );
        
        
        try {
            
	            // Validate
	            $input = HostbillCommon::singleton()->validate_doTrafficBandwidthGraph($request);
	            if ($input["isValid"] == false) {
	                throw new Exception($input["resError"]);
	            }
                
                // Get Server
                $aServer = HostbillApi::singleton()->getServerDetailsByServerId($input["serverId"]);
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";

                
                // Zabbix Connect
                $api = ZabbixApi::singleton();
                $api->_connect($serverHostname, $serverUsername, $serverPassword);
                
                
                // Get Graph
                $hostName = $input["hostName"];
                $graphId = $input["graphId"];
                $period = $input["period"];
                
                
                // FIX PATH HERE...
                $imageDest = APPDIR_MODULES . "Hosting/zabbix/public_html/images/tmp/" . $hostName . "_" . $graphId . ".png";
                $pattern = "/api_jsonrpc.php/";
                $url = preg_replace($pattern, "", $serverHostname);
                $user = $serverUsername;
                $password = $serverPassword;
                   
                $aTrafficNetwork["traffic_banwidth_img"] = $api->getGraphImage($url, $user, $password, $hostName, $graphId, $period, $imageDest);
               
            
        } catch(Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        
        $aResponse = array(
          "traffic_network" => $aTrafficNetwork,
          "raiseError" => $raiseError,
          "action" => "doTrafficBandwidthGraph"
        );
        
        return $aResponse;
    }
    
    
    public function getTrafficNetworkSelectHostAndGraph($api, $accountId) {
        
        $aBandwidthSelectHostAndGraph = array();
        
        $aServer = HostbillApi::singleton()->getServerByAccountId($accountId);
        
        if (count($aServer)>0) {
            
            try {
                                
                $hostNameOriginal = HostbillApi::singleton()->getDomainByAccountId($accountId);
                
                for ($i=0;$i<count($aServer);$i++) {
                      
                      $prefix = ($i == 0) ? "" : "-" . $i;
                      $hostName = $hostNameOriginal . $prefix;
                      $hostId = $api->getHostIdByHostName($hostName); 
                      
                      // Get Host
                      $aBandwidthSelectHostAndGraph["hostName"][$hostId] = $hostName;
                      $aBandwidthSelectHostAndGraph["hostId"][$hostId] = $hostId;
                      
                      
                       // Get Graph
                       $aGraph = $api->getGraphByHostId($hostId);
                        if (count($aGraph)>0) {
                            for ($j=0;$j<count($aGraph);$j++) {
                                if (isset($aGraph[$j]->graphid) && isset($aGraph[$j]->name)) {
                                    $graphId = $aGraph[$j]->graphid;
                                    $graphName = $aGraph[$j]->name;
                                    
                                    $aBandwidthSelectHostAndGraph["GraphName"][$hostId][$j] = $graphName;
                                    $aBandwidthSelectHostAndGraph["GraphId"][$hostId][$j] = $graphId;
                                }
                            }
                        }
                      
                      
                      
                 }
                
            } catch (Exception $e) {
                
            }
            
        }
        
        return $aBandwidthSelectHostAndGraph;
    }
    
    
    public function getNetworkTrafficTrigger($accountId, $serverId) {
        
        $aRes = array();
        
        // Get Server
        $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
        $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
        $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
        $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";

                
        // Zabbix Connect
        $api = ZabbixApi::singleton();
        $api->_connect($serverHostname, $serverUsername, $serverPassword);
        
        $descriptionName = $accountId . "-trigger";
        $aTrigger = $api->getTriggerByDescription($descriptionName);
        
        if (count($aTrigger)>0) {
            for ($i=0;$i<count($aTrigger);$i++) {
                if (isset($aTrigger[$i]->hosts[0]->hostid) && isset($aTrigger[$i]->items[0]->snmp_oid) 
                      && isset($aTrigger[$i]->triggerid) && isset($aTrigger[$i]->description) && isset($aTrigger[$i]->hosts[0]->host)) {
                    
                    $aRes[$i]['hostid'] = $aTrigger[$i]->hosts[0]->hostid;
                    $aRes[$i]['hostname'] = $aTrigger[$i]->hosts[0]->host;
                    $aRes[$i]['portid'] = preg_replace("/(.*?)\./", "", $aTrigger[$i]->items[0]->snmp_oid);
                    $aRes[$i]['triggerid'] = $aTrigger[$i]->triggerid;
                    $aRes[$i]['triggerdesc'] = $aTrigger[$i]->description;
                    $aRes[$i]['type'] = (preg_match("/-incoming-/i", $triggerDesc)) ? "incoming" : "outgoing";
                    $aRes[$i]['expression'] = $aTrigger[$i]->expression;
                    $aRes[$i]['triggerbyte'] = preg_replace("/(.*?)\>/", "", $aTrigger[$i]->expression);
                    $aRes[$i]['itemdelay'] = $aTrigger[$i]->items[0]->delay;
                    $aRes[$i]['itemid'] = $aTrigger[$i]->items[0]->itemid;
                    $aRes[$i]['triggerstatus'] = $aTrigger[$i]->status;
                    
                }
            }
        }
        
        
        return $aRes;
    }
    
    
    public function outputNetworkTrafficTrigger($accountId, $serverId) {
    	$output = "";
    	
    	// Get Server
        $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
        $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
        $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
        $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";

                
        // Zabbix Connect
        $api = ZabbixApi::singleton();
        $api->_connect($serverHostname, $serverUsername, $serverPassword);
        
        
        $descriptionName = $accountId . "-trigger";
        $aTrigger = $api->getTriggerByDescription($descriptionName);
        
        $output .= <<<EOF
            <table id="network-traffic-trigger-table" cellpadding="0" cellspacing="0" width="866" class="tbl-status">
                <tbody>
                  <tr>
                    <th align="left" valign="top">Trigger name</th>
                    <th align="center" valign="top">Host name</th>
                </tr>
EOF;
        
        if (count($aTrigger)>0) {
   
        	for ($i=0;$i<count($aTrigger);$i++) {
        		
        		if (isset($aTrigger[$i]->hosts[0]->hostid) && isset($aTrigger[$i]->items[0]->snmp_oid) 
        		      && isset($aTrigger[$i]->triggerid) && isset($aTrigger[$i]->description) && isset($aTrigger[$i]->hosts[0]->host)) {
        			
        			$hostId = $aTrigger[$i]->hosts[0]->hostid;
        			$hostName = $aTrigger[$i]->hosts[0]->host;
        			$portId = preg_replace("/(.*?)\./", "", $aTrigger[$i]->items[0]->snmp_oid);
        			$triggerId = $aTrigger[$i]->triggerid;
        			$triggerDesc = $aTrigger[$i]->description;
        			$type = (preg_match("/-incoming-/i", $triggerDesc)) ? "incoming" : "outgoing";
        			$expression = $aTrigger[$i]->expression;
        			$triggerByte = preg_replace("/(.*?)\>/", "", $expression);
        			$itemDelay = $aTrigger[$i]->items[0]->delay;
        			$itemId = $aTrigger[$i]->items[0]->itemid;
        			$triggerStatus = $aTrigger[$i]->status;
        			
        			$output .= <<<EOF
                <tr>
                    <td align="left" valign="top">
                        <a href="javascript:void(0);" id="network-traffic-trigger-list-name-$i" attrId="network-traffic-trigger-list-name-$i" attrExpression="$expression" attrItemId="$itemId" attrHostId="$hostId" attrPortId="$portId" attrTriggerId="$triggerId" attrType="$type" attrTriggerByte="$triggerByte" attrItemDelay="$itemDelay" attrTriggerStatus="$triggerStatus" attrTriggerDesc="$triggerDesc" onclick="$.zabbix.makeEventDoViewNetworkTrafficTrigger('network-traffic-trigger-list-name-$i');">$triggerDesc</a>                       
                    </td>
                    <td align="center" valign="top">
                        $hostName
                    </td>
                </tr>                                        
EOF;
        			
        		}
        		
        		
        	}
        	
        	
        	
        }
    	
        
        $output .= <<<EOF
                </tbody>
            </table>
EOF;
        
    	return $output;
    }   
    
    
    
    public function outputDiscoveryMedia($accountId, $serverId) {
        $output = "";
        
        
        // Get Server
        $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
        $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
        $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
        $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";

                
        // Zabbix Connect
        $api = ZabbixApi::singleton();
        $api->_connect($serverHostname, $serverUsername, $serverPassword);
        
        
        // Get User Media
        $aMedia = array();
        $clientId = HostbillApi::singleton()->getClientIdByAccountId($accountId);
        if (isset($clientId)) {
            $aClient = HostbillApi::singleton()->getClientDetailsByClientId($clientId);
            if (isset($aClient["client"]["email"])) {
                        
                $userAlias = $aClient["client"]["email"];
                $userID = $api->getUserIdByUserAlias($userAlias);
                $aMedia = $api->getUserMediaByUserId($userID);
            }
        }
        
        
        
        
        
        if (count($aMedia)>0) {
            
        	$imgDelete = HostbillCommon::singleton()->getUrlImage() . "delete.gif";
        	
            $output = <<<EOF
            <table id="discovery-media-table" cellpadding="0" cellspacing="0" width="866" class="tbl-status">
                <tbody>
                 <tr>
                    <th align="left" valign="top" width="90%">Email Group User</th>
                    <th align="center" valign="top">Delete</th>
                </tr>
EOF;
            
        for ($i=0;$i<count($aMedia);$i++) {
            if (isset($aMedia[$i]->mediaid) && isset($aMedia[$i]->userid) && isset($aMedia[$i]->sendto)) {
                $mediaId = $aMedia[$i]->mediaid;
                $mediaSendto = $aMedia[$i]->sendto;
                $userId = $aMedia[$i]->userid;
                
                $output .= <<<EOF
            <tr id="tr-discovery-$i">
                <td align="left" valign="top" class="bg">
                    <p id="inline-edit-discovery-media-$i" class="inline-edit-discovery-media-class" attrStatus="edit" attrMediaId="$mediaId" attrUserId="$userId" onclick="$.zabbix.makeEventInlineEdit($(this), 'makeEventAddDiscoverMedia');">$mediaSendto</p>
                </td>
                <td align="center" valign="top" class="bg">     
                    <img class="discovery-remove-media" id="discovery-remove-media-$i" attrNum="$i" src="$imgDelete" alt="Remove Row" onclick="$.zabbix.makeEventRemoveRowDiscoverMedia($(this));"/>
                </td>
            </tr>                
EOF;

                
            }
        }
        
        
        $output .= <<<EOF
            </tbody>
        </table>
        <div class="position"><a id="add-row-discovery-media" href="javascript:void(0);" class="btn">Add Email Address</a></div>
EOF;
        
     } else {
        
        //$output .= "User $userAlias Missing !!";
        $output = "";
        
     }
        
   
                
        return $output;
    }
    
    
    public function getTrafficBandwidthMediaAdmin($serverId) {
        
        $aRes = array();
        
        try {
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Admin Media
            $userAlias = "Admin";
            $userID = $api->getUserIdByUserAlias($userAlias);
            $aMedia = $api->getUserMediaByUserId($userID);
            
            if (count($aMedia)>0) {
                $imgDelete = HostbillCommon::singleton()->getUrlImage() . "delete.gif";
                
                for ($i=0;$i<count($aMedia);$i++) {
                    if (isset($aMedia[$i]->mediaid) && isset($aMedia[$i]->userid) && isset($aMedia[$i]->sendto)) {
                       
                    	$aRes[$i]['mediaid'] = $aMedia[$i]->mediaid;
                    	$aRes[$i]['mediasendto'] = $aMedia[$i]->sendto;
                    	$aRes[$i]['userid'] = $aMedia[$i]->userid;
                    	$aRes[$i]['imgdelete'] = $imgDelete;
                    	
                    }
                }
            }
            
            
        } catch(Exception $e) {
            
        }
        
        return $aRes;
    }
    
    
    public function outputTrafficBandwidthMediaAdmin($serverId) {
        
        $output = "";
        
        try {
            
            // Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Admin Media
            $userAlias = "Admin";
            $userID = $api->getUserIdByUserAlias($userAlias);
            $aMedia = $api->getUserMediaByUserId($userID);
            
            
            $output = <<<EOF
            <table id="traffic-bandwidth-media-admin-table" cellpadding="0" cellspacing="0" width="866" class="tbl-status">
                <tbody>
                  <tr>
                    <th align="left" valign="top" width="90%">Email Group Admin</th>
                    <th align="center" valign="top">Delete</th>
                </tr>
EOF;

            if (count($aMedia)>0) {
                
            	$imgDelete = HostbillCommon::singleton()->getUrlImage() . "delete.gif";
            	
                for ($i=0;$i<count($aMedia);$i++) {
                    if (isset($aMedia[$i]->mediaid) && isset($aMedia[$i]->userid) && isset($aMedia[$i]->sendto)) {
                       
                        $mediaId = $aMedia[$i]->mediaid;
                        $mediaSendto = $aMedia[$i]->sendto;
                        $userId = $aMedia[$i]->userid;
                        
                        // TODO javascript
                        $output .= <<<EOF
              
                <tr id="tr-traffic-bandwidth-$i">
                <td align="left" valign="top" class="bg">
                    <p id="inline-edit-traffic-bandwidth-media-$i" class="inline-edit-traffic-bandwidth-media-class" attrStatus="edit" attrMediaId="$mediaId" attrUserId="$userId" onclick="$.zabbix.makeEventInlineEdit($(this), 'makeEventAddNetworkTrafficMediaAdmin');">$mediaSendto</p>
                </td>
                <td align="center" valign="top" class="bg">      
                    <img class="traffic-bandwidth-remove-media" id="traffic-bandwidth-discovery-remove-media-$i" attrNum="$i" src="$imgDelete" alt="Remove Row" onclick="$.zabbix.makeEventRemoveRowNetworkTrafficMedia($(this));"/>
                </td>
            </tr>                
EOF;
                        
                       
                        
                        
                        
                    }
                }
                
                
            }
            
            $output .= <<<EOF
            </tbody>
        </table>
        <div class="position"><a id="add-row-traffic-bandwidth-media-admin" href="javascript:void(0);" class="btn">Add Email Address</a></div>
EOF;
            
            
        } catch(Exception $e) {
            
        }
        
        return $output;
    }
    
    
    public function getSelectionNetworkTrafficByte() {
    	// 2, 3, 5 Mb
    	return array(
    	   "2097152",
    	   "3145728",
    	   "5242880"
    	);
    }
    
    public function getSelectionNetworkTrafficDelay() {
    	// 5, 10 Minute
    	return array(
           "300",
           "600",
        );
    }
    
    
    public function getSelectonDiscoveryDelay() {
    	
    	return array(
    	   "up_down" => array(
    	       "60" => "1 Minute", // 1 Minute
    	       "120" => "2 Minute", // 2 Minute
    	       "180" => "3 Minute" // 3 Minute
    	    ),
    	   "down" => array(
    	       "300" => "5 Minute", // 5 Minute
    	       "600" => "10 Minute", // 10 Minute
    	       "900" => "15 Minute" // 15 Minute
    	    ),
    	   "up" => array(
    	       "21600" => "6 Hour", // 6 Hour
    	       "43200" => "12 Hour", // 12 Hour
    	       "86400" => "24 Hour" // 24 Hour
    	    )
    	);
    	
    }
    
    
    /**
     * 
     * Reference: http://php.net/manual/en/ref.network.php
     * @param $ip
     * 
     */
    public function isIpMask($ip) {
        
        // IGNORE
        $aIgnore = array("202.44.53.242");
        if (in_array($ip, $aIgnore)) {
            return true;
        }
        
        // SKIP
        $aSkip = array("203.78.110.57");
        if (in_array($ip, $aSkip)) {
            return false;
        }
    
        $rangIpMask = "203.78.96.0/20";
        list ($net, $mask) = split("/", $rangIpMask);
    
        $ip_net = ip2long($net);
        $ip_mask = ~((1 << (32 - $mask)) - 1);

        $ip_ip = ip2long($ip);
        $ip_ip_net = $ip_ip & $ip_mask;

        return ($ip_ip_net == $ip_net);
  }
    
    public function doDisableHost($request) {
        
        $raiseError = '';
        
        try {
            $ipaddress = HostbillDao::singleton()->findIpamConnectZabbixByAccountId($request["account_id"]);
            if (isset($ipaddress) && $ipaddress != "") {
                    
                $aParams = array();
                $aParams['host']['ip'] = $ipaddress;
                
                $api = ZabbixApi::singleton();
                $api->_connect($request["server_hostname"], $request["server_username"], $request["server_password"]);
                $api->rvcustom_disableHost($aParams);
            }
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doDisableHost"
        );
        
        return $aResponse;
    }
    
    public function doDeleteActionPing($request) {
        
        $raiseError = '';
        
        try {
            
            $aParams = array();
            $aParams['action']['name'] = 'a-' . $request['account_id'] . '-ping';
            
            $api = ZabbixApi::singleton();
            $api->_connect($request["server_hostname"], $request["server_username"], $request["server_password"]);
            $api->rvcustom_doDeleteActionPing($aParams);
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doDeleteActionPing"
        );
        
        return $aResponse;
    }
    
    public function getUrlImage() {
    	
    	//return "http://192.168.1.189/hostbill.net/public_html/includes/modules/Hosting/zabbix/public_html/images/";
    	return "https://netway.co.th/includes/modules/Hosting/zabbix/public_html/images/";
    	
    }
    
    
}