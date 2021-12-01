<?php

/*************************************************************
 *
 * Hosting Module Class - Zabbix
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * 
 * 
 ************************************************************/

// Load Hostbill Api
include_once(APPDIR_MODULES . "Hosting/zabbix/include/api/class.hostbill.api.php");

// Load Zabbix Api
include_once(APPDIR_MODULES . "Hosting/zabbix/include/api/class.zabbix.api.php");

class zabbix_controller extends HBController {
	
	
	/**
	 * 
	 * Enter description here ...
	 * @param $request
	 */
	public function view($request) {
		
		// Component JSON
		$this->loader->component('template/apiresponse', 'json');
        
		$complete = "1";
        $message = "";
		
		$aTrafficNetwork = array(
		      "traffic_banwidth_img" => ""
		);
		// TODO $aTrafficNetwork["traffic_banwidth_img"] NOT GRAPH
		$aDiscovery = array();
		
		
		try {
			
			$serverId = (isset($request["serverId"]) && $request["serverId"] != "") ? $request["serverId"] : null;
			$accountId = (isset($request["accountId"]) && $request["accountId"] != "") ? $request["accountId"] : null;
			
			if (isset($serverId) && isset($accountId)) {
				
				// Get Server
	            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
	            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
	            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
	            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";

	            
	            // Zabbix Connect
                $api = ZabbixApi::singleton();
                $api->_connect($serverHostname, $serverUsername, $serverPassword);
                
                
                // Get IPAM
                $aIpAddress = HostbillApi::singleton()->getIpByAccountId($accountId);
                
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
                
                
                // Get Traffic Bandwidth Graph
                $hostName = (isset($request["hostName"]) && $request["hostName"] != "") ? trim($request["hostName"]) : "";
                $graphId = (isset($request["graphId"]) && $request["graphId"] != "") ? $request["graphId"] : null;
                $period = (isset($request["period"]) && $request["period"] != "") ? ($request["period"] * 3600 * 24) : "86400";
                
                if (isset($graphId)) {
                	
                	$imageDest = APPDIR_MODULES . "Hosting/zabbix/public_html/images/tmp/" . $hostName . "_" . $graphId . ".png";
                    $pattern = "/api_jsonrpc.php/";
                    $url = preg_replace($pattern, "", $serverHostname);
                    $user = $serverUsername;
                    $password = $serverPassword;
                	
                	$aTrafficNetwork["traffic_banwidth_img"] = $api->getGraphImage($url, $user, $password, $hostName, $graphId, $period, $imageDest);
                }
                
                // Get Traffic Host
                $aTrafficNetwork["traffic_banwidth_select_host_and_graph"] = $this->getTrafficBandwidthSelectHostAndGraph($api, $accountId);
                                
                
			} else {
				throw new Exception("Variable missing.");
			}
			
			
		} catch (Exception $e) {
			
			$complete = "0";
			$message = $e->getMessage();
			
		}
		
		
		$aResponse = array(
		  "traffic_network" => $aTrafficNetwork,
		  "discovery" => $aDiscovery,
		  "complete" => $complete,
		  "message" => $message,
		  "action" => "view"
		);
		
		
		$this->json->assign("aResponse", $aResponse);
        
        $this->json->show();
		
		
		// ==================
		// ==================
		// ==================
		// ==================
		// ==================
		// ==================
		
		
		
		/*
		try {
			
			// TODO
			$serverId = $request["serverId"];
			$accountId = $request["accountId"];
			$aIpAddress = HostbillApi::singleton()->getIpByAccountId($accountId);
					
			// Get Server
            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
            $serverHostname = $aServer["server"]["host"];
            $serverUsername = $aServer["server"]["username"];
            $serverPassword = $aServer["server"]["password"];		
            
            // Zabbix Connect
            $api = ZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Discovery
            $aDiscoveryUpDown = $api->getDiscoveryRuleByDiscoveryName($aIpAddress[0] . " Up Down");
            $aDiscoveryDownDelay = $api->getDiscoveryRuleByDiscoveryName($aIpAddress[0] . " Down Delay");
            $aDiscoveryUpDelay = $api->getDiscoveryRuleByDiscoveryName($aIpAddress[0] . " Up Delay");
            
            $isDiscoveryUp = ($api->isDiscoveryUpByDiscoveryRuleId($aDiscoveryUpDown[0]->druleid)) ? 1 : 0;
            
		} catch(Exception $e) {
			// TODO
			// $e->getMessage()
		}
		
		
		
		
		
		$aData = array(
           "traffic_network" => array(
               "mail" => array(
                   "oosimbioo@gmail.com"
               )
           ),
            "discovery" => array(
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
                   ),
                   "mail" => array(
                       "puttipong@rvglobalsoft.com"
                   ),
                   "isDiscoveryUp" => $isDiscoveryUp,
                   "target" => "all"
          )
        );
        
        $this->json->assign("aData", $aData);
		
        $this->json->show();*/
	}
	
	
	
	public function doViewDiscoveryIp($request) {
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doViewDiscoveryIp($request));
        $this->json->show();
	}
	
	
	public function doNetworkTrafficTrigger($request) {
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doNetworkTrafficTrigger($request));
        $this->json->show();
	}
	
	
    public function doIpamDelete($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doIpamDelete($request));
        $this->json->show();
    }
    
    
    public function doSwitchDelete($request) {
    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doSwitchDelete($request));
        $this->json->show();
    }
	
	
    public function doNetworkTrafficMediaAdmin($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doNetworkTrafficMediaAdmin($request));
        $this->json->show();
    }
	
	
	
	public function doDiscoveryMedia($request) {
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doDiscoveryMedia($request));
        $this->json->show();
	}
	
	
	public function doTrafficBandwidthGraph($request) {
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doTrafficBandwidthGraph($request));
        $this->json->show();
	}
	
	
	
	public function doDiscoveryRule($request) {
		$this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", HostbillCommon::singleton()->doDiscoveryRule($request));
        $this->json->show();
	}
	
	
    public function accountdetails($params) {
    	
    	/* $params
    	 * Array
(
    [cmd] => accounts
    [action] => edit
    [id] => 32
    [path_info] => 
    [token_valid] => 
    [account] => Array
        (
            [account_id] => 32
            [module_id] => 44
            [server_id] => 14
            [status] => Pending
            [username] => anongc
            [password] => OcOgH9WX
            [rootpassword] => OcOgH9WX
            [extra_details] => 
            [module] => 44
            [modname] => Zabbix
            [options] => 
        )

)
    	 */
    	
    	
		//echo "<PRE>";
        //print_r(HostbillApi::singleton()->getServerDetailsByServerId($params["account"]["server_id"]));
		
    	
    	
		$accountId = $params["account"]["id"];
        $this->template->assign("accountId", $accountId);
        
        $serverId = $params["account"]["server_id"];
        $this->template->assign("serverId", $serverId);
        
        
        $this->template->assign("aNetworkTrafficTrigger", HostbillCommon::singleton()->getNetworkTrafficTrigger($accountId, $serverId));
        //$this->template->assign("outputNetworkTrafficTrigger", HostbillCommon::singleton()->outputNetworkTrafficTrigger($accountId, $serverId));
        
        
        
        //$this->template->assign("outputDiscoveryMedia", $this->outputDiscoveryMedia($accountId, $serverId));
        $this->template->assign("outputDiscoveryMedia", HostbillCommon::singleton()->outputDiscoveryMedia($accountId, $serverId));
        
        
        //$this->template->assign("outputTrafficBandwidthMediaAdmin", $this->outputTrafficBandwidthMediaAdmin($serverId));
        //$this->template->assign("outputTrafficBandwidthMediaAdmin", HostbillCommon::singleton()->outputTrafficBandwidthMediaAdmin($serverId));
        $this->template->assign("aTrafficBandwidthMediaAdmin", HostbillCommon::singleton()->getTrafficBandwidthMediaAdmin($serverId));
                
        
        $this->template->assign("aSelectionNetworkTrafficByte", HostbillCommon::singleton()->getSelectionNetworkTrafficByte());
        $this->template->assign("aSelectionNetworkTrafficDelay", HostbillCommon::singleton()->getSelectionNetworkTrafficDelay());
        
        
        /*
        $this->template->assign("outputTrafficBandwidthSelectHost", $this->outputTrafficBandwidthSelectHost($accountId, $serverId));
        $this->template->assign("outputTrafficBandwidthSelectGraph", $this->outputTrafficBandwidthSelectGraph($accountId, $serverId));
        */
                
				
    	$bandwidth = APPDIR_MODULES . 'Hosting/zabbix/templates/AdminBandwidth.tpl';
        $this->template->assign("rvbandwidthtab", $bandwidth);

        $monitor = APPDIR_MODULES . 'Hosting/zabbix/templates/AdminMonitor.tpl';
        $this->template->assign("rvmonitortab", $monitor);
    	
        $rvtooltip = APPDIR_MODULES . 'Hosting/zabbix/templates/AdminTooltip.tpl';
        $this->template->assign("rvtooltip", $rvtooltip);
        
    }
    
    
    public function getTrafficBandwidthSelectHostAndGraph($api, $accountId) {
    	
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
    
    /*public function outputTrafficBandwidthSelectHost($accountId, $serverId) {
    	$output = "";
    	
    	$aServer = HostbillApi::singleton()->getServerByAccountId($accountId);
    	$countSwitch = count($aServer);
    	
    	if ($countSwitch>0) {
    		
    		try {
    			
    			$output = <<<EOF
        <select id="traffic-bandwidth-select-host">
EOF;
    			
    			// Get Server
	            $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
	            $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
	            $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
	            $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
	            
	            // Zabbix Connect
	            $api = ZabbixApi::singleton();
	            $api->_connect($serverHostname, $serverUsername, $serverPassword);
    			
	            
	    		$hostNameOriginal = HostbillApi::singleton()->getDomainByAccountId($accountId);
	            
	            for ($i=0;$i<$countSwitch;$i++) {
	            	  
	                  $prefix = ($i == 0) ? "" : "-" . $i;
	                  $hostName = $hostNameOriginal . $prefix;
	
	                  $hostId = $api->getHostIdByHostName($hostName); 
	                  
	                  $select = "";
	                  if ($i == 0) {
	                       $select = 'selected="selected"';
	                  }
	                  
	                  $output .= <<<EOF
               <option value="$hostId" $select>$hostName</option> 
EOF;
	                  
	                  
	            }
	            
	            $output .= <<<EOF
        </select>
EOF;
	            
    		} catch (Exception $e) {
    			$output = "";
    		}
    		
    	                
    	}
        
    	return $output;
    }*/
    
    
    
    
    /*public function outputTrafficBandwidthSelectGraph($accountId, $serverId) {
        
    	$output = "";
    	
    	$aServer = HostbillApi::singleton()->getServerByAccountId($accountId);
    	$countSwitch = count($aServer);
        
        if ($countSwitch>0) {
        	
        	try {
        		
        		
        		$output = <<<EOF
        <select id="traffic-bandwidth-select-graph">
EOF;

        		// Get Server
                $aServer = HostbillApi::singleton()->getServerDetailsByServerId($serverId);
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
                
                // Zabbix Connect
                $api = ZabbixApi::singleton();
                $api->_connect($serverHostname, $serverUsername, $serverPassword);
                
                
                $hostName = HostbillApi::singleton()->getDomainByAccountId($accountId);
                if (isset($hostName)) {
                	$hostId = $api->getHostIdByHostName($hostName);
                	if (isset($hostId)) {
                		$aGraph = $api->getGraphByHostId($hostId);
                		if (count($aGraph)>0) {
                			for ($i=0;$i<count($aGraph);$i++) {
                				if (isset($aGraph[$i]->graphid) && isset($aGraph[$i]->name)) {
                					
                				    $select = "";
			                        if ($i == 0) {
			                           $select = 'selected="selected"';
			                        }
			                        
			                        $graphId = $aGraph[$i]->graphid;
			                        $graphName = $aGraph[$i]->name;
			                        
			                        $output .= <<<EOF
               <option value="$graphId" $select>$graphName</option>
EOF;
			                        
                					
                				}
                			}
                		}
                	}
                }
                
                
                $output .= <<<EOF
        </select>
EOF;
        		
        	} catch (Exception $e) {
                $output = "";
            }
        	
        }
    	
    	return $output;
    }*/
    
    
    
    
    /*
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
        	
        	$output = <<<EOF
            <div class="position"><a id="add-row-discovery-media" href="javascript:void(0);" class="btn">Add Email Address</a></div>
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
                    <img class="discovery-remove-media" id="discovery-remove-media-$i" attrNum="$i" src="http://192.168.1.189/hostbill.net/public_html/includes/modules/Hosting/zabbix/public_html/images/delete.gif" alt="Remove Row" onclick="$.zabbix.makeEventRemoveRowDiscoverMedia($(this));"/>
                </td>
            </tr>                
EOF;

                
            }
        }
        
        
        $output .= <<<EOF
            </tbody>
        </table>
EOF;
        
     } else {
     	
     	//$output .= "User $userAlias Missing !!";
     	$output = "";
     	
     }
        
   
        
                
    	return $output;
    }*/
    
             
                
	//static $moduleName = "zabbix";
	
    /*public function beforeCall($params) {
        //echo "This will always be executed before everything else";
    }
    
    public function afterCall($params) {
        //echo "This will always be executed after everything else";
    }
	
	public function _default($params) {
		
		
		
		//$this->template->assign('variable','value');
		
		//?cmd=modulex&action=noaction
		
		echo "No action was defined";
		
		$this->template->render(APPDIR_MODULES . self::$module_type . '/modulex/templates/ajax.myfile.tpl');
		
	}
	
	
	
	// TODO
	public function get_fields($params) {
		# $path_to_template = APPDIR_MODULES.'Hosting/yourmodule/templates/myadminarea.tpl';
        $this->template->assign("custom_template", APPDIR_MODULES . 'Hosting/zabbix2/templates/appconfig.tpl';);
    }
    
    // TODO
    //$custom_template
    public function servers($params) {
        # $path_to_template = APPDIR_MODULES.'Hosting/yourmodule/templates/myadminarea.tpl';
    	if (isset($params['get_fields'])) {
            $this->template->assign("custom_template", APPDIR_MODULES . 'Hosting/zabbix2/templates/appconfig.tpl';);
    	}
    	
    	$this->template->assign("custom_template", APPDIR_MODULES . 'Hosting/zabbix2/templates/appconfig.tpl';);
    	
    }
	
	public function accountdetails($params) {
		
	}
	
	public function productdetails($params) {
		
	}*/
	
}