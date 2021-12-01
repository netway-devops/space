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
    
    public function validate_viewTrafficNetwork($request) {
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
            $input["resError"] = "__(validate_viewTrafficNetwork)__Variable missing.";
        }

        return $input;
    }
    
    
    public function viewTrafficNetwork($request) {
    	
    	$complete = "1";
        $message = "";
        
        // TODO $aTrafficNetwork["traffic_banwidth_img"] NOT GRAPH
        $aTrafficNetwork = array(
              "traffic_banwidth_img" => ""
        );
        
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_viewTrafficNetwork($request);
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
          "complete" => $complete,
          "message" => $message,
          "action" => "view"
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
    
    
    
    public function getUrlImage() {
    	
    	//return "http://192.168.1.189/hostbill.net/public_html/includes/modules/Hosting/zabbix/public_html/images/";
    	return "https://netway.co.th/includes/modules/Hosting/zabbix/public_html/images/";
    	
    }
    
    
}