<?php
/**
 * @file    ZabbixApi.class.php
 * @brief   Class file for the implementation of the class ZabbixApi.
 *
 * Implement your customizations in this file.
 *
 * This file is part of PhpZabbixApi.
 *
 * PhpZabbixApi is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * PhpZabbixApi is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PhpZabbixApi.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @copyright   GNU General Public License
 * @author      confirm IT solutions GmbH, Rathausstrase 14, CH-6340 Baar
 *
 * @version     $Id: ZabbixApi.class.php 138 2012-10-08 08:00:24Z dbarton $
 */


// Include zabbix abstract
include_once("class.zabbix.api.abstract.php");


/**
 * @brief   Concrete class for the Zabbix API.
 */
class ZabbixApi extends ZabbixApiAbstract {

	/**
     * Returns a singleton ZabbixApi instance.
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
	
    /**
     * Test Connect Zabbix
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $server_hostname 
     * @param $server_username
     * @param $server_password
     * @return bool
     * 
     * @example ZabbixApi::singleton()->connect("http://192.168.1.135/zabbix/api_jsonrpc.php", "admin", "zabbix");
     */
    public function _connect($server_hostname="", $server_username="", $server_password="") {

    	if ($server_hostname)
            $this->setApiUrl($server_hostname);

        return (trim($server_username) == "" || trim($server_password) == "") 
                        ? false
                    : $this->userLogin(array('user' => $server_username, 'password' => $server_password));        
    }
    
    /**
     * 
     * Enter description here ...
     * @param unknown_type $params
     * @param unknown_type $arrayKeyProperty
     */
    public function _userCreate($params=array(), $arrayKeyProperty="") {
    	
        return $this->userCreate($params, $arrayKeyProperty);    	
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param unknown_type $params
     * @param unknown_type $arrayKeyProperty
     */
    public function _usergroupGet($params=array(), $arrayKeyProperty='') {
    	
        return $this->usergroupGet($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostCreate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostCreate($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostgroupGet($params=array(), $arrayKeyProperty='') {
    	
        return $this->hostgroupGet($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostGet($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostinterfaceGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostinterfaceGet($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _itemCreate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->itemCreate($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _itemGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->itemGet($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _graphCreate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->graphCreate($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _druleCreate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->druleCreate($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _druleGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->druleGet($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionCreate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->actionCreate($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _dcheckGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->dcheckGet($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param unknown_type $params
     * @param unknown_type $arrayKeyProperty
     */
    public function _userGet($params=array(), $arrayKeyProperty='') {

    	return $this->userGet($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _triggerCreate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->triggerCreate($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _triggerGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->triggerGet($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _triggerUpdate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->triggerUpdate($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _dhostGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->dhostGet($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _druleUpdate($params=array(), $arrayKeyProperty='') {
        
        return $this->druleUpdate($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostgroupCreate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostgroupCreate($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostgroupExists($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostgroupExists($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostExists($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostExists($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _itemExists($params=array(), $arrayKeyProperty='') {
    	
    	return $this->itemExists($params, $arrayKeyProperty);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _graphExists($params=array(), $arrayKeyProperty='') {
    	
    	return $this->graphExists($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _druleExists($params=array(), $arrayKeyProperty='') {
    	
    	return $this->druleExists($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionExists($params=array(), $arrayKeyProperty='') {
    	
    	return $this->actionExists($params, $arrayKeyProperty);
    	
    }    
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _userAddMedia($params=array(), $arrayKeyProperty='') {
    	
    	return $this->userAddMedia($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _usermediaGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->usermediaGet($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _userDeleteMedia($params=array(), $arrayKeyProperty='') {
    	
    	return $this->userDeleteMedia($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _dserviceGet($params=array(), $arrayKeyProperty='') {
    	
        return $this->dserviceGet($params, $arrayKeyProperty);
        
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _graphGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->graphGet($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionGet($params=array(), $arrayKeyProperty='') {
    	
    	return $this->actionGet($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionUpdate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->actionUpdate($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _userUpdate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->userUpdate($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _userDelete($params=array(), $arrayKeyProperty='') {
    	
    	return $this->userDelete($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostDelete($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostDelete($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _druleDelete($params=array(), $arrayKeyProperty='') {
    	
    	return $this->druleDelete($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionDelete($params=array(), $arrayKeyProperty='') {
    	
    	return $this->actionDelete($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _triggerUpdateExpression($params=array(), $arrayKeyProperty='') {
    	
    	return $this->triggerUpdateExpression($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _usermediaUpdateEmail($params=array(), $arrayKeyProperty='') {
    	
    	return $this->usermediaUpdateEmail($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _itemUpdate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->itemUpdate($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostUpdate($params=array(), $arrayKeyProperty='') {
    	
    	return $this->hostUpdate($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _itemDelete($params=array(), $arrayKeyProperty='') {
    	
    	return $this->itemDelete($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _triggerDelete($params=array(), $arrayKeyProperty='') {
    	
    	return $this->triggerDelete($params, $arrayKeyProperty);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $descriptionName
     */
    public function getTriggerIdByDescription($descriptionName="") {
        	
    	$aRes= $this->_triggerGet(array(
            "output" => "extend",
            "filter" => array(
                "description" => array(
                    $descriptionName
                )
            )
        ));
        
        return (isset($aRes[0]->triggerid)) ? $aRes[0]->triggerid : null;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     * @param $descriptionName
     */
    public function getTriggerIdByHostIdByDescription($hostID="", $descriptionName="") {
    	
    	$triggerId = null;
    	
        $aRes= $this->_triggerGet(array(
                "output" => "extend",
                "selectHosts" => "extend"
        ));
        
        if (count($aRes) > 0) {
        	for ($i=0;$i<count($aRes);$i++) {
        		if (isset($aRes[$i]->triggerid) && isset($aRes[$i]->description) && isset($aRes[$i]->hosts[0]->hostid)) {
        			if (@preg_match("/" . $descriptionName . "/i", $aRes[$i]->description) && $aRes[$i]->hosts[0]->hostid == $hostID) {
        				$triggerId = $aRes[$i]->triggerid;
        				break;
        			}
        		}
        	}
        }
        
        return $triggerId;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $descriptionName
     */
    public function getTriggerByDescription($descriptionName="") {
    	
    	$aTrigger = array();
    	
    	$aRes= $this->_triggerGet(array(
            "output" => "extend",
    	    "selectHosts" => "extend",
    	    "selectItems" => "extend"
        ));
        
        if (count($aRes) > 0) {
        	for ($i=0;$i<count($aRes);$i++) {
	        	if (isset($aRes[$i]->description)) {
	        	    if (@preg_match("/" . $descriptionName . "/i", $aRes[$i]->description)) {
	                    array_push($aTrigger, $aRes[$i]);
	                }
	        	}
        	}
        }
    	
        return $aTrigger;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $userAlias
     */
    public function getUserIdByUserAlias($userAlias="") {
    	
    	$aRes= $this->_userGet(array(
            "output" => "extend",
            "filter" => array(
                "alias" => array(
                    $userAlias
                )
            )
        ));
    	
        return (isset($aRes[0]->userid) && isset($userAlias) && $userAlias != "") ? $aRes[0]->userid : null;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $userName
     */
    public function getUserAliasByUserName($userName="") {
        	
    	$aRes= $this->_userGet(array(
            "output" => "extend",
            "filter" => array(
                "name" => array(
                    $userName
                )
            )
        ));
    	
    	return (isset($aRes[0]->alias) && isset($userName) && $userName != "-") ? $aRes[0]->alias : null;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryID
     */
    public function getDiscoveryCheckIdByDiscoveryId($discoveryID="") {
    	
    	$aRes= $this->_dcheckGet(array(
            "output" => "extend",
            "filter" => array(
                "druleid" => array(
                    $discoveryID
                )
            )
        ));
    	
        return (isset($aRes[0]->dcheckid)) ? $aRes[0]->dcheckid : null;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $ruleName
     */
    public function getDiscoveryRuleIdByDiscoveryName($discoveryName="") {
    	
    	$aRes= $this->_druleGet(array(
            "output" => "extend",
            "filter" => array(
                "name" => array(
                    $discoveryName
                )
            )
        ));
        
        return (isset($aRes[0]->druleid)) ? $aRes[0]->druleid : null;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryID
     */
    public function getDiscoveryRuleByDiscoveryId($discoveryID="") {
        
        $aRes= $this->_druleGet(array(
            "output" => "extend",
            "filter" => array(
                "druleid" => array(
                    $discoveryID
                )
            )
        ));
        
        return $aRes;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryName
     */
    public function getDiscoveryRuleByDiscoveryName($discoveryName="") {
    	
    	$aRes= $this->_druleGet(array(
            "output" => "extend",
    	    "selectDChecks" => "extend",
            "filter" => array(
                "name" => array(
                    $discoveryName
                )
            )
        ));
    	
        return $aRes;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryName
     */
    public function getDCheckIdByDiscoveryName($discoveryName="") {
    	
    	$aRes= $this->_druleGet(array(
            "output" => "extend",
            "selectDChecks" => "extend",
            "filter" => array(
                "name" => array(
                    $discoveryName
                )
            )
        ));
        
        return (isset($aRes[0]->dchecks[0]->dcheckid)) ? $aRes[0]->dchecks[0]->dcheckid : null;
    }
    

    /**
     * 
     * Enter description here ...
     * @param $hostID
     * @param $itemKey
     */
    public function getItemByHostIdByItemKey($hostID="", $itemKey="") {
    	
    	return $this->_itemGet(array(
				            "output" => "extend",
				            "hostids" => $hostID,
				    	    "search" => array(
				    	        "key_" => $itemKey
				    	    )
				      ));
    }
    
    /**
     * 
     * Enter description here ...
     * @param $keyItem
     */
    public function getHostByItemKey($keyItem="") {
    	
    	$aHost = array(
    	   "hostid" => array(),
    	   "host" => array()
    	);
    	
    	$aRes = $this->_itemGet(
    	   array(
	    	   "output" => "extend",
	           "selectHosts" => "extend",
	           "selectItems" => "extend",
    	       "search" => array(
    	           "key_" => $keyItem   
    	       )
	       )
    	);
    	
    	if (count($aRes) > 0) {
    		for ($i=0;$i<count($aRes);$i++) {
    			if (isset($aRes[$i]->hosts[0]->hostid) && isset($aRes[$i]->hosts[0]->host)) {
    				if (count($aHost["hostid"]) > 0 && count($aHost["host"]) > 0) {
    					if (in_array($aRes[$i]->hosts[0]->hostid, $aHost["hostid"]) && in_array($aRes[$i]->hosts[0]->host, $aHost["host"])) {
    					} else {
    						array_push($aHost["hostid"], $aRes[$i]->hosts[0]->hostid);
                            array_push($aHost["host"], $aRes[$i]->hosts[0]->host);
    					}
    				} else {
    					array_push($aHost["hostid"], $aRes[$i]->hosts[0]->hostid);
    					array_push($aHost["host"], $aRes[$i]->hosts[0]->host);
    				}
    			}
    		}
    	}
    	
    	return $aHost;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     */
    public function getHostInterfaceIdByHostId($hostID="") {
    	
        $aRes= $this->_hostinterfaceGet(array(
            "output" => "extend",
            "hostids" => $hostID
        ));
            	
    	return (isset($aRes[0]->interfaceid)) ? $aRes[0]->interfaceid : null;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     */
    public function getHostIdByHostName($hostName="") {
  
    	$aRes= $this->_hostGet(array(
            "output" => "extend",
            "filter" => array(
                "host" => array(
                    $hostName
                )
            )
        ));
        
        return (isset($aRes[0]->hostid)) ? $aRes[0]->hostid : null;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $itemKey
     * @param $interfaceIP
     */
    public function getHostIdByItemKeyAndInterfaceIp($itemKey="", $interfaceIP="") {
        
    	$hostId = null;
    	
    	if (isset($itemKey) && $itemKey != "") {
    		
    		$aRes= $this->_itemGet(array(
	            "output" => "extend",
	            "selectHosts" => "extend",
	            "selectInterfaces" => "extend",
	            "search" => array(
	                "key_" => $itemKey
	            )
	        ));
	        
	        if (count($aRes) > 0) {
                for ($i=0;$i<count($aRes);$i++) {
                	if (isset($aRes[$i]->key_) && isset($aRes[$i]->hosts[0]->hostid) && isset($aRes[$i]->interfaces[0]->ip)) {
                		if ($aRes[$i]->interfaces[0]->ip == $interfaceIP) {
                			$hostId = $aRes[$i]->hosts[0]->hostid;
                			break;
                		}
                	}
                }
	        }
	        
    	}
    	
    	return $hostId;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $groupName
     */
    public function getHostGroupIdByGroupName($groupName="Host Group Free Monitoring") {
    	
    	// TODO Optimize function
    	
    	$hostgroupID = null;
    	
    	$aRes= $this->_hostgroupGet(array(
            "output" => "extend"
        ));
        
        foreach ($aRes as $key => $value) {
            if (isset($aRes[$key]->groupid) && isset($aRes[$key]->name) && trim($aRes[$key]->name) == $groupName) {
                $hostgroupID = $aRes[$key]->groupid;
                break;
            }
        }
        
        return $hostgroupID;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $groupName
     * @example $api->getUserGroupIdByGroupName();
     */
    public function getUserGroupIdByGroupName($groupName="Free Monitoring") {
        
    	// TODO Optimize function
    	
    	$usergroupID = null;
    	
    	$aRes= $this->_usergroupGet(array(
            "output" => "extend"
        ));
        
        foreach ($aRes as $key => $value) {
            if (isset($aRes[$key]->usrgrpid) && isset($aRes[$key]->name) && trim($aRes[$key]->name) == $groupName) {
            	$usergroupID = $aRes[$key]->usrgrpid;
            	break;
            }
        }
        
        return $usergroupID;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     */
    public function getUserMediaByUserId($userID="") {
    	    	
    	$aRes= $this->_usermediaGet(array(
            "output" => "extend",
    	    "userids" => $userID
        ));
        
        return (isset($userID) && $userID != "") ? $aRes : array();
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     * @param $emailName
     */
    public function getUserMediaIdByEmailName($userID="", $emailName="") {
    	
    	$userMediaID = null;
    	
    	$aRes = $this->getUserMediaByUserId($userID);
    	if (count($aRes)>0) {
    		for ($i=0;$i<count($aRes);$i++) {
    			if (isset($aRes[$i]->mediaid) && $aRes[$i]->mediaid != "" && isset($aRes[$i]->sendto) && $aRes[$i]->sendto != "") {
    			    if ($aRes[$i]->sendto == $emailName) {
                        $userMediaID = $aRes[$i]->mediaid;
                    }
    			}
    		}
    	}
    	
    	return $userMediaID;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     */
    public function getGraphByHostId($hostID="") {
    	
    	$params = array(
    	   "output" => "extend",
    	   "hostids" => $hostID,
    	   "sortfield" => "name"
    	);
    	
    	return (isset($hostID)) ? $this->_graphGet($params) : array();
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionName
     */
    public function getActionIdByActionName($actionName="") {
    	
        $aRes= $this->_actionGet(array(
            "output" => "extend",
            "filter" => array(
                "name" => $actionName
            )
        ));
        
        return (isset($actionName) && $actionName != "" && isset($aRes[0]->actionid)) ? $aRes[0]->actionid : null;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionName
     */
    public function getActionByActionName($actionName="") {
        
        $aAction = array();
        
        $aRes= $this->_actionGet(array(
            "output" => "extend",
            "selectOperations" => "extend",
            "selectConditions" => "extend"
        ));
        
        if (count($aRes) > 0 && isset($actionName) && $actionName != "") {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->name)) {
                    //if (@preg_match("/" . $actionName . "/i", $aRes[$i]->name)) {
                    if ($actionName == $aRes[$i]->name) {
                        array_push($aAction, $aRes[$i]);
                    }
                }
            }
        }
        
        return $aAction;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $visibleHostName
     */
    public function getHostIdByVisibleHostName($visibleHostName="") {
    	
    	$hostID = null;
    	
    	$aRes = $this->_hostGet(array(
            "output" => "extend"
        ));

        if (count($aRes) > 0 && isset($visibleHostName) && $visibleHostName != "") {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->name) && $aRes[$i]->name != "" && isset($aRes[$i]->hostid) && $aRes[$i]->hostid != "") {
                	 if (@preg_match("/" . $visibleHostName . "/i", $aRes[$i]->name)) {
                	 	$hostID = $aRes[$i]->hostid;
                	 	break;
                	 }
                }
            }
        }
        
        return $hostID;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     * @param $graphName
     */
    public function getGraphIdByHostIdGraphName($hostID="", $graphName="") {
    	
    	$graphId = null;
    	
        $aRes = $this->_graphGet(array(
            "output" => "extend",
            "hostids" => $hostID
        ));
        
        if (count($aRes) > 0 && isset($hostID) && $hostID != "" && isset($graphName) && $graphName != "") {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->graphid) && isset($aRes[$i]->name)) {
                    if (@preg_match("/" . $graphName . "/i", $aRes[$i]->name)) {
                        $graphId = $aRes[$i]->graphid;
                    }
                }
            }
        }
        
        return $graphId;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $url
     * @param $user
     * @param $password
     * @param $hostName
     * @param $graphId
     * @param $period
     * @param $imageDest
     */
    public function getGraphImage($aParams = array()) {
    	
    	$url = $aParams['url'];
        $user = $aParams['user'];
        $password = $aParams['password'];
        $visibleHostName = $aParams['visibleHostName'];
        $graphId = $aParams['graphId'];
        $period = $aParams['period'];
        $imageDest = $aParams['imageDest'];
    	
    	$ch = curl_init();
        
    	curl_setopt($ch, CURLOPT_URL, $aParams['url'] . "index.php");
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "name=$user&password=$password&autologin=1&enter=Sign+in");
        curl_setopt($ch, CURLOPT_COOKIEJAR, "zabbix_cookie.txt");
        curl_setopt($ch, CURLOPT_COOKIEFILE, "zabbix_cookie.txt");
                    
        // Login    
        $output=curl_exec($ch);

        // Get graph
        curl_setopt($ch, CURLOPT_URL, $url . "chart2.php?graphid=" . $graphId . "&width=750&height=150&period=" . $period);
        $output = curl_exec($ch);
        curl_close($ch);
                    
        if (is_file("zabbix_cookie.txt")) {
            unlink("zabbix_cookie.txt");
        }
    
        if (is_file($imageDest)) {
            unlink($imageDest);
        }
                    
        $fp = fopen($imageDest, 'w');
        fwrite($fp, $output);
        fclose($fp);
        
        return "includes/modules/Hosting/zabbix/public_html/images/tmp/" . $graphId . ".png";
    }
    
    
	/**
	 * 
	 * Enter description here ...
	 * @param unknown_type $userName
	 * @param unknown_type $usergroupID
	 * @param unknown_type $sendto
	 * @example $api->doUserCreate($userName, $usergroupID, "puttipong@rvglobalsoft.com");
	 */
    public function doUserCreate($userName="", $usergroupID="", $sendto="") {
	
        // Set Params
        $params = array(
                "alias" => $sendto,
    		    "name" => $userName,
    		    "surname" => "-",
    		    "passwd" => "bangkok548",
    		    "type" => "1",
    		    "usrgrps" => array(
                      array(
                          "usrgrpid" => $usergroupID
                      )
                ),
                "user_medias" => array(
                      array(
                          "mediatypeid" => "1",
                          "sendto" => $sendto,
                          "active" => "0",
                          "severity" => "63",
                          "period" => "1-7,00:00-24:00"
                      )             
                )
        );
    		
    	return $this->_userCreate($params);
    }
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     * @param $hostgroupID
     * @param $interfaceIP
     */
    //public function doHostCreateSNMP($hostName="", $hostVisible="", $hostgroupID="", $interfaceIP="") {
    public function doHostCreateSNMP($hostName="", $hostVisible="", $aHostGroupId=array(), $interfaceIP="") {
        // Set Params
        $params = array(
            "host" => $hostName,
            "name" => $hostVisible,
            "groups" => $aHostGroupId,
            /*"groups" => array(
                array(
                    "groupid" => $hostgroupID
                )
            ),*/
            "interfaces" => array(
                array(
                    "type" => "2",
                    "ip" => $interfaceIP,
                    "port" => "161",
                    "dns" => "",
                    "useip" => "1",
                    "main" => "1"
                )
            )
        );    	   
        
        return $this->_hostCreate($params);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param unknown_type $itemName
     * @param unknown_type $hostID
     * @param unknown_type $interfaceID
     * @param unknown_type $snmpCommunity
     * @param unknown_type $snmpOID
     */
    public function doItemCreateGraphNetworkTraffic($itemName="", $hostID="", $interfaceID="", $snmpCommunity="", $snmpOID="") {
    	
    	$params = array(
    	   "name" => $itemName,
    	   "key_" => $itemName,
    	   "hostid" => $hostID,
    	   "interfaceid" => $interfaceID,
    	   "type" => "1",
    	   "snmp_community" => $snmpCommunity,
    	   "snmp_oid" => $snmpOID,
    	   "value_type" => "3",
    	   "port" => "161",
    	   "units" => "bps",
    	   "delta" => "1",
    	   "delay_flex" => "60/1-7,00:00-24:00"
    	);
    	
    	return $this->_itemCreate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $itemName
     * @param $hostID
     * @param $interfaceID
     * @param $snmpCommunity
     * @param $snmpOID
     */
    public function doItemCreateTriggerNetworkTraffic($itemName="", $hostID="", $interfaceID="", $snmpCommunity="", $snmpOID="") {
    	
    	$params = array(
           "name" => $itemName,
           "key_" => $itemName,
           "hostid" => $hostID,
           "interfaceid" => $interfaceID,
           "type" => "1",
           "snmp_community" => $snmpCommunity,
           "snmp_oid" => $snmpOID,
           "value_type" => "3",
           "port" => "161",
           "units" => "bps",
           "delta" => "1",
           "delay_flex" => "",
    	   "multiplier" => "1",
    	   "formula" => "10",
    	   "delay" => "300"
        );
        
        return $this->_itemCreate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $itemIdIncoming
     * @param $itemIdOutgoing
     */
    public function doGraphCreateNetworkTraffic($graphName="", $itemIdIncoming="", $itemIdOutgoing="") {

    	$params = array(
    	   "name" => $graphName,
    	   "width" => "900",
    	   "height" => "200",
    	   "yaxismin" => "0.00",
    	   "yaxismax" => "100.00",
    	   "show_work_period" => "1",
    	   "show_triggers" => "1",
    	   "show_legend" => "1",
    	   "show_3d" => "0",
           "percent_left" => "0",
           "percent_right" => "0",
    	   "gitems" => array(
    	       array(
    	           "itemid" => $itemIdIncoming,
    	           "calc_fnc" => "2",
    	           "drawtype" => "5",
    	           "yaxisside" => "0",
    	           "color" => "00EE00"
    	       ),
    	       array(
    	           "itemid" => $itemIdOutgoing,
    	           "sortorder" => "1",
    	           "calc_fnc" => "2",
    	           "drawtype" => "5",
    	           "yaxisside" => "0",
    	           "color" => "0000DD"
    	       )
    	   )
    	);
    	
    	return $this->_graphCreate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryID
     */
    public function doDiscoveryRuleCreateUpDown($dRuleName="", $ipAddress="") {
    	
    	$params = array(
    	   "name" => $dRuleName,
    	   "proxy_hostid" => "0",
    	   "iprange" => $ipAddress,
    	   "delay" => "60",
    	   "status" => "0",
    	   "dchecks" => array(
    	       array(
    	           "type" => "12",
    	           "dcheckid" => "0",
    	           "name" => "ICMP ping",
    	           "uniq" => "0"
    	       )
    	   )
    	);
    	
    	return $this->_druleCreate($params);
    }
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryID
     */
    public function doDiscoveryRuleCreateDownDelay($dRuleName="", $ipAddress="") {
    	
    	$params = array(
           "name" => $dRuleName,
           "proxy_hostid" => "0",
           "iprange" => $ipAddress,
           "delay" => "1800",
           "status" => "0",
           "dchecks" => array(
               array(
                   "type" => "12",
                   "dcheckid" => "0",
                   "name" => "ICMP ping",
                   "uniq" => "0"
               )
           )
        );
        
        return $this->_druleCreate($params);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryID
     */
    public function doDiscoveryRuleCreateUpDelay($dRuleName="", $ipAddress="") {
    	
    	$params = array(
           "name" => $dRuleName,
           "proxy_hostid" => "0",
           "iprange" => $ipAddress,
           "delay" => "21600",
           "status" => "0",
           "dchecks" => array(
               array(
                   "type" => "12",
                   "dcheckid" => "0",
                   "name" => "ICMP ping",
                   "uniq" => "0"
               )
           )
        );
        
        return $this->_druleCreate($params);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param unknown_type $ipAddress
     * @param unknown_type $discoveryCheckID
     * @param unknown_type $userID
     */
    public function doActionCreateLostDown($ipAddress="", $discoveryCheckID="", $userID="") {
    	
    	$params = array(
    	   "name" => $ipAddress . " Action Lost Down",
    	   "eventsource" => "1",
    	   "evaltype" => "0",
    	   "status" => "0",
           "def_shortdata" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
           "def_longdata" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}",
    	   "recovery_msg" => "0",
    	   "conditions" => array(
    	       array(
    	           "conditiontype" => "7",
    	           "operator" => "0",
    	           "value" => $ipAddress
    	       ),
    	       array(
    	           "conditiontype" => "10",
                   "operator" => "0",
                   "value" => "3"
    	       ),
    	       array(
    	           "conditiontype" => "19",
                   "operator" => "0",
                   "value" => $discoveryCheckID
    	       )
    	   ),
    	   "operations" => array(
    	       array(
    	           "action" => "create",
    	           "operationtype" => "0",
    	           "mediatypeid" => "0",
    	           "opmessage_usr" => array(
    	               "3" => array(
    	                   "userid" => $userID
    	               )
    	           ),
    	           "opmessage" => array(
    	               "mediatypeid" => "1",
    	               "default_msg" => "1",
    	               "subject" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
    	               "message" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}"
    	           )
               )
            )
        );
    	
        return $this->_actionCreate($params);
    } 
    
    
    /**
     * 
     * Enter description here ...
     * @param $ipAddress
     * @param $discoveryCheckID
     * @param $userID
     */
    public function doActionCreateDiscoveredUp($ipAddress="", $discoveryCheckID="", $userID="") {
    	
    	$params = array(
           "name" => $ipAddress . " Action Discovered Up",
           "eventsource" => "1",
           "evaltype" => "0",
           "status" => "0",
           "def_shortdata" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
           "def_longdata" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}",
           "recovery_msg" => "0",
           "conditions" => array(
               array(
                   "conditiontype" => "7",
                   "operator" => "0",
                   "value" => $ipAddress
               ),
               array(
                   "conditiontype" => "10",
                   "operator" => "0",
                   "value" => "2"
               ),
               array(
                   "conditiontype" => "19",
                   "operator" => "0",
                   "value" => $discoveryCheckID
               )
           ),
           "operations" => array(
               array(
                   "action" => "create",
                   "operationtype" => "0",
                   "mediatypeid" => "0",
                   "opmessage_usr" => array(
                       "3" => array(
                           "userid" => $userID
                       )
                   ),
                   "opmessage" => array(
                       "mediatypeid" => "1",
                       "default_msg" => "1",
                       "subject" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
                       "message" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}"
                   )
               )
            )
        );
        
    	return $this->_actionCreate($params);
    }
    
    /**
     * 
     * Enter description here ...
     * @param $ipAddress
     * @param $discoveryCheckID
     * @param $userID
     */
    public function doActionCreateDownDelay($ipAddress="", $discoveryCheckID="", $userID="") {
    	
    	$params = array(
           "name" => $ipAddress . " Action Down Delay",
           "eventsource" => "1",
           "evaltype" => "0",
           "status" => "0",
           "def_shortdata" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
           "def_longdata" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}",
           "recovery_msg" => "0",
           "conditions" => array(
               array(
                   "conditiontype" => "7",
                   "operator" => "0",
                   "value" => $ipAddress
               ),
               array(
                   "conditiontype" => "10",
                   "operator" => "0",
                   "value" => "1"
               ),
               array(
                   "conditiontype" => "19",
                   "operator" => "0",
                   "value" => $discoveryCheckID
               )
           ),
           "operations" => array(
               array(
                   "action" => "create",
                   "operationtype" => "0",
                   "mediatypeid" => "0",
                   "opmessage_usr" => array(
                       "3" => array(
                           "userid" => $userID
                       )
                   ),
                   "opmessage" => array(
                       "mediatypeid" => "1",
                       "default_msg" => "1",
                       "subject" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
                       "message" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}"
                   )
               )
            )
        );
        
        return $this->_actionCreate($params);
    }
    
    /**
     * 
     * Enter description here ...
     * @param $ipAddress
     * @param $discoveryCheckID
     * @param $userID
     */
    public function doActionCreateUpDelay($ipAddress="", $discoveryCheckID="", $userID="") {
    	
    	$params = array(
           "name" => $ipAddress . " Action Up Delay",
           "eventsource" => "1",
           "evaltype" => "0",
           "status" => "0",
           "def_shortdata" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
           "def_longdata" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}",
           "recovery_msg" => "0",
           "conditions" => array(
               array(
                   "conditiontype" => "7",
                   "operator" => "0",
                   "value" => $ipAddress
               ),
               array(
                   "conditiontype" => "10",
                   "operator" => "0",
                   "value" => "0"
               ),
               array(
                   "conditiontype" => "19",
                   "operator" => "0",
                   "value" => $discoveryCheckID
               )
           ),
           "operations" => array(
               array(
                   "action" => "create",
                   "operationtype" => "0",
                   "mediatypeid" => "0",
                   "opmessage_usr" => array(
                       "3" => array(
                           "userid" => $userID
                       )
                   ),
                   "opmessage" => array(
                       "mediatypeid" => "1",
                       "default_msg" => "1",
                       "subject" => "Discovery: {DISCOVERY.DEVICE.STATUS} {DISCOVERY.DEVICE.IPADDRESS}",
                       "message" => "Discovery rule: {DISCOVERY.RULE.NAME}

Device IP:{DISCOVERY.DEVICE.IPADDRESS}
Device DNS: {DISCOVERY.DEVICE.DNS}
Device status: {DISCOVERY.DEVICE.STATUS}
Device uptime: {DISCOVERY.DEVICE.UPTIME}

Device service name: {DISCOVERY.SERVICE.NAME}
Device service port: {DISCOVERY.SERVICE.PORT}
Device service status: {DISCOVERY.SERVICE.STATUS}
Device service uptime: {DISCOVERY.SERVICE.UPTIME}"
                   )
               )
            )
        );
        
        return $this->_actionCreate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionName
     * @param $triggerID
     * @param $userID
     */
    public function doActionCreateNetworkTraffic($actionName="", $triggerID="", $userID="") {
    	
    	$params = array(
    	   "name" => $actionName,
    	   "eventsource" => "0",
           "evaltype" => "0",
           "status" => "0",
    	   "esc_period" => "300",
    	   "def_shortdata" => "{TRIGGER.STATUS}: {TRIGGER.NAME}",
    	   "def_longdata" => "
Trigger: {TRIGGER.NAME}
Trigger status: {TRIGGER.STATUS}
Trigger severity: {TRIGGER.SEVERITY}
Trigger URL: {TRIGGER.URL}

Item values:

1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}
2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}
3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}
    [recovery_msg] => 0
    [r_shortdata] => {TRIGGER.STATUS}: {TRIGGER.NAME}
    [r_longdata] => Trigger: {TRIGGER.NAME}
Trigger status: {TRIGGER.STATUS}
Trigger severity: {TRIGGER.SEVERITY}
Trigger URL: {TRIGGER.URL}

Item values:

1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}
2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}
3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}",
            "conditions" => array(
    	       array(
    	           "conditiontype" => "5",
                   "operator" => "0",
                   "value" => "1"
    	       ),
    	       array(
    	           "conditiontype" => "4",
    	           "operator" => "5",
    	           "value" => "2"
    	       ),
    	       array(
    	           "conditiontype" => "2",
    	           "operator" => "0",
    	           "value" => $triggerID
    	       )
    	    ),
    	    "operations" => array(
    	       array(
    	           "action" => "create",
    	           "esc_step_from" => "1",
    	           "esc_step_to" => "2",
    	           "esc_period" => "0",
    	           "operationtype" => "0",
    	           "evaltype" => "0",
    	           "mediatypeid" => "0",
    	           "opmessage_usr" => array(
    	               "1" => array(
    	                   "userid" => $userID
    	               )
    	           ),
    	           "opmessage" => array(
    	               "mediatypeid" => "1",
    	               "default_msg" => "1",
    	               "subject" => "{TRIGGER.STATUS}: {TRIGGER.NAME}",
    	               "message" => "
Trigger: {TRIGGER.NAME}
Trigger status: {TRIGGER.STATUS}
Trigger severity: {TRIGGER.SEVERITY}
Trigger URL: {TRIGGER.URL}

Item values:

1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}
2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}
3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}"
                   )
    	       )
    	    )
    	);
    	
    	return $this->_actionCreate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     * @param $port
     */
    public function doTriggerCreateNetworkTrafficIncoming($accountId="", $hostName="", $descriptionName="", $port="") {

    	$params = array(
    	   "expression" => "{" . $hostName . ":" . $accountId . ".net.if.in." . $port . ".avg(180)}>2097152",
    	   "description" => $descriptionName,
    	   "priority" => "2",
    	   "status" => "0",
    	   "type" => "1"
    	);
    	
    	return $this->_triggerCreate($params);
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     * @param $port
     */
    public function doTriggerCreateNetworkTrafficOutgoing($accountId="", $hostName="", $descriptionName="", $port="") {
    	
    	$params = array(
           "expression" => "{" . $hostName . ":" . $accountId . ".net.if.out." . $port . ".avg(180)}>2097152",
           "description" => $descriptionName,
           "priority" => "2",
           "status" => "0",
           "type" => "1"
        );
        
        return $this->_triggerCreate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $triggerID
     * @param $expression
     */
    public function doTriggerUpdateExpression($triggerID="", $expression="") {

    	$params = array(
    	   "triggerid" => $triggerID,
    	   "expression" => $expression
    	);
    	    	
    	return $this->_triggerUpdateExpression($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $triggerID
     * @param $status
     */
    public function doTriggerUpdateStatus($triggerID="", $status="0") {
    	
    	$params = array(
    	   "triggerid" => $triggerID,
    	   "status" => $status
    	);
    	
    	return $this->_triggerUpdate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $mediaID
     * @param $sendto
     */
    public function doUsermediaUpdateEmail($mediaID="", $sendto="") {
    	
    	$params = array(
           "mediaid" => $mediaID,
           "sendto" => $sendto
        );
                
        return $this->_usermediaUpdateEmail($params);
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryRuleID
     * @param $delay
     * @param $status
     */
    public function doDiscoveryRuleUpdate($discoveryRuleID="", $discoveryCheckID="", $discovryName="", $ipAddress="", $delay="", $status="") {
    	
    	$params = array(
    	   "druleid" => $discoveryRuleID,
    	   "name" => $discovryName,
    	   "iprange" => $ipAddress,
           "delay" => $delay,
           "status" => $status,
    	   "dchecks" => array(
	    	       $discoveryCheckID => array(
	    	       "dcheckid" => $discoveryCheckID,
	               "druleid" => $discoveryRuleID,
	               "type" => "12",
	    	       "name" => "ICMP ping",
	    	       "uniq" => "0"
    	       )
    	   )
    	);
    	
    	return $this->_druleUpdate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostGroupName
     */
    public function doHostGroupCreate($hostGroupName="") {
    	
    	$params = array(
    	   "name" => $hostGroupName
    	);
    	
    	return $this->_hostgroupCreate($params);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     * @param $emailName
     */
    public function doUserAddMedia($userID="", $emailName="") {
    	
    	$params = array(
    	   "users" => array(
                array(
                    "userid" => $userID
                )
            ),
            "medias" => array(
                "mediatypeid" => "1",
                "sendto" => $emailName,
                "active" => "0",
                "severity" => "63",
                "period" => "1-7,00:00-24:00"
            )
    	);
    	
    	return $this->_userAddMedia($params);
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @example $api->doUserDeleteMedia(array("20"))
     */
    public function doUserDeleteMedia($params=array()) {
    	
    	return $this->_userDeleteMedia($params);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionID
     * @param $status
     */
    public function doActionUpdateStatus($actionID="", $status="0") {
    	
    	$params = array(
    	   "actionid" => $actionID,
           "status" => $status
    	);
    	
    	return $this->_actionUpdate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionID
     * @param $EscPeriod
     */
    public function doActionUpdateEscPeriod($actionID="", $escPeriod="600") {
    	
    	$params = array(
           "actionid" => $actionID,
           "esc_period" => $escPeriod
        );
        
        return $this->_actionUpdate($params);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     * @param $aliasName
     */
    public function doUserUpdateAlias($userID="", $aliasName="") {
    	
    	$params = array(
    	   "userid" => $userID,
    	   "alias" => $aliasName
    	);
    	
    	return $this->_userUpdate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     */
    public function doUserDelete($userID="") {
    	
    	$params = array(
    	   "userid" => $userID
    	);
    	
    	return $this->_userDelete($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     */
    public function doHostDelete($hostID="") {
    	
    	$params = array(
    	   "hostid" => $hostID
    	);
    	
    	return $this->_hostDelete($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $dRuleID
     */
    public function doDRuleDelete($dRuleID="") {
    	
    	$params = array(
    	   $dRuleID
    	);
    	
    	return $this->_druleDelete($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionID
     */
    public function doActionDelete($actionID="") {
    	
    	$params = array(
    	   $actionID
    	);
    	
    	return $this->_actionDelete($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $itemID
     * @param $delay
     */
    public function doItemUpdateDelay($itemID="", $delay="300") {
    	
    	$params = array(
    	    "itemid" => $itemID,
    	    "delay" => $delay
    	);
    	
    	return $this->_itemUpdate($params);
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $itemID
     */
    public function doItemDelete($itemID="") {
    	
    	$params = array(
           $itemID
        );
        
        return $this->_itemDelete($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $triggerID
     */
    public function doTriggerDelete($triggerID="") {
    	
    	$params = array(
           $triggerID
        );
        
        return $this->_itemDelete($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     * @param $hostName
     */
    public function doHostUpdate($hostID="", $hostName="") {
    	
    	$params = array(
    	   "hostid" => $hostID,
    	   "host" => $hostName,
    	   "name" => $hostName
    	);
    	
    	return $this->_hostUpdate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     * @param $emailName
     */
    public function isUserMediaEmailNameExists($userID="", $emailName="") {
    	
    	$isUserMediaEmailExists = false;
    	
    	$aRes = $this->getUserMediaByUserId($userID);
    	
    	if (count($aRes)>0) {
    		for ($i=0;$i<count($aRes);$i++) {
    			if (isset($aRes[$i]->sendto) && $aRes[$i]->sendto != "") {
    				if ($aRes[$i]->sendto == $emailName) {
    					$isUserMediaEmailExists = true;
    					break;
    				}
    			}
    		}
    	}
    	
    	return $isUserMediaEmailExists;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionName
     */
    public function isActionNameExists($actionName="") {
    	
    	$res = $this->_actionExists(array(
            "name" => $actionName
        ));
    	
    	return (isset($res) && $res == true && $actionName != "") ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $dRuleName
     */
    public function isDruleNameExists($dRuleName="") {
    	
    	$res = $this->_druleExists(array(
            "name" => $dRuleName
        ));
        
    	return (isset($res) && $res == true && $dRuleName != "") ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     * @param $graphName
     */
    public function isGraphNameExists($hostName="", $graphName="") {
        
        $res = $this->_graphExists(array(
            "host" => $hostName,
            "name" => $graphName
        ));
        
        return (isset($res) && $res == true && $hostName != "" && $graphName != "") ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     * @param $key
     */
    public function isItemKeyExists($hostName="", $key="") {
    	
    	$res = $this->_itemExists(array(
           "host" => $hostName,
    	   "key_" => $key
        ));
    	
    	return (isset($res) && $res == true && $hostName != "" && $key != "") ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $userName
     * @example $api->isUserNameExists("628")
     */
    public function isUserNameExists($userName="") {
    	
    	$aRes= $this->_userGet(array(
            "output" => "extend",
            "filter" => array(
                "name" => array(
                    $userName
                )
            )
        ));
        
        return (isset($aRes[0]->name)) ? true : false;
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $aliasName
     */
    public function isUserNameExistsByAliasName($aliasName="") {
    	
    	$aRes= $this->_userGet(array(
            "output" => "extend",
            "filter" => array(
                "alias" => array(
                    $aliasName
                )
            )
        ));
    	
        return (isset($aRes[0]->alias)) ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostGroupName
     */
    public function isHostGroupExists($hostGroupName="") {
    	
    	$res = $this->_hostgroupExists(array(
    	   "name" => $hostGroupName
    	));
    	
    	return (isset($res) && $res == true && $hostGroupName != "") ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param unknown_type $hostName
     */
    public function isHostExists($hostName="") {
    	
    	$res = $this->_hostExists(array(
    	   "name" => $hostName
    	));
    	
    	return (isset($res) && $res == true && $hostName != "") ? true : false; 
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $descriptionName
     */
    public function IsTriggerExists($descriptionName="") {
            
        $aRes= $this->_triggerGet(array(
            "output" => "extend",
            "filter" => array(
                "description" => array(
                    $descriptionName
                )
            )
        ));
        
        return (isset($aRes[0]->triggerid)) ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $discoveryRuleID
     */
    public function isDiscoveryUpByDCheckId($dCheckID="") {
    	
    	$aRes= $this->_dserviceGet(array(
    	    "output"=>"extend",
                "filter" => array(
                    "dcheckid" => array($dCheckID)
                )
        ));
    	
        return (isset($aRes["0"]->lastup) && $aRes["0"]->lastup > 0) ? true : false;
    }
    
    
    
    
    
    // TODO
    // {1234:net.if.in.avg(120)}<500K   => OK
    // {1234:net.if.in.avg(180)}>100  => PROBLEM
    
    // {1234:net.if.in.avg(300)}<500K => OK
    
    // Warning  Over 100 .2   {www.thaihost.net:net.if.in.min(60)}>10K
    
}

?>