<?php

/**
 * 
 * Hostbill API
 * 
 * http://api.hostbillapp.com/apps/getServerDetails/
 * http://wiki.hostbillapp.com/index.php?title=API:HBWrapper
 * 
 */

// Load Hostbill Wrapper
include_once("class.hbwrapper.php");

// Load Hostbill Common
include_once(APPDIR_MODULES . "Hosting/zabbix/include/class.hostbill.common.php");

// Load Hostbill Dao
include_once(APPDIR_MODULES . "Hosting/zabbix/include/class.hostbill.dao.php");

class HostbillApi {
	
	//protected $params;
	
	protected $moduleName = "zabbix";
	
	/**
	 * 
	 * Enter description here ...
	 */
    public function __construct() {}
	
    /**
     * Returns a singleton HostbillApi instance.
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
     * 
     * Enter description here ...
     * @param $params
     */
    public function _getOrderDetails($params = array()) {
    	
    	return HBWrapper::singleton()->getOrderDetails($params);

    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     */
    public function _getAppGroups($params = array()) {
    	
    	return HBWrapper::singleton()->getAppGroups($params);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     */
    public function _getServerDetails($params = array()) {
    	
    	return HBWrapper::singleton()->getServerDetails($params);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     */
    public function _getAccounts($params = array()) {
        
        return HBWrapper::singleton()->getAccounts($params);
        
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     */
    public function _getClientDetails($params = array()) {
    	
    	return HBWrapper::singleton()->getClientDetails($params);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->getAccountByAccountId("32")
     */
    public function getAccountByAccountId($accountID="") {
    	
        return HostbillDao::singleton()->findAccountByAccountId($accountID);
        
    	/*
    	$aAccount = array();
    	
    	
    	$aRes = $this->_getAccounts();
    	foreach ($aRes["accounts"] as $key => $value) {
    		if (isset($aRes["accounts"][$key]["id"]) && isset($aRes["accounts"][$key]["id"]) && trim($aRes["accounts"][$key]["id"]) == $accountID) {
    			$aAccount = $aRes["accounts"][$key];
    			break;
    		}
    	}
    	
    	
    	return $aAccount;
    	*/
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->getDomainByAccountId($params["account"]["id"])
     */
    public function getDomainByAccountId($accountID="") {
    	
    	//$aAccount = HostbillApi::singleton()->getAccountByAccountId($accountID);
    	//return (isset($aAccount["domain"]) && $aAccount["domain"]) ? $aAccount["domain"] : null;
    	
    	return HostbillDao::singleton()->findDomainByAccountId($accountID);
    }
    

    /**
     * 
     * Enter description here ...
     * @param $appId
     * @example $aServer = HostbillApi::singleton()->getServerDetailsByServerId($params["account"]["server_id"]);
     */
    public function getServerDetailsByServerId($serverID="") {
    	
    	$params = array(
           "id" => $serverID
        );
    	
        return $this->_getServerDetails($params);
    }
    
    /**
     * 
     * Enter description here ...
     * @param $moduleName
     * @example $return = HostbillApi::singleton()->getServerIdByModulename("zabbix");
     */
    public function getServerIdByModulename($moduleName="") {
    	
    	$serverID = null;
    	
    	$aRes = HBWrapper::singleton()->getAppGroups();
        foreach ($aRes["servers"] as $key => $value) {
            if (isset($aRes["servers"][$key]["modulename"]) && isset($aRes["servers"][$key]["modulename"]) 
                && trim($aRes["servers"][$key]["modulename"]) == $moduleName) {
                	
                $serverID = $aRes["servers"][$key]["id"];
                break;
            }
        }
    	
        return $serverID;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $orderID
     * @example $return = HostbillApi::singleton()->getOrderByOrderId("3081");
     */
    public function getOrderByOrderId($orderID="") {
    	
    	$params = array(
    	   "id" => $orderID
    	);
    	
    	return $this->_getOrderDetails($params);
    }
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     */
    public function getClientIdByAccountId($accountID="") {
    	
    	$aRes = HostbillApi::singleton()->getAccountByAccountId($accountID);
    	
    	return (isset($aRes["client_id"]) && $aRes["client_id"] != "") ? $aRes["client_id"] : null;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function getClientDetailsByClientId($clientID="") {
    	
    	$params = array(
           "id" => $clientID
        );
        
        return $this->_getClientDetails($params);
    	
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->getOrderIdByAccountId("32")
     */
    public function getOrderIdByAccountId($accountID="") {
    	
    	return HostbillDao::singleton()->findOrderIdByAccountId($accountID);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example 
     */
    public function getIpByAccountId($accountID="") {
    	
    	return HostbillDao::singleton()->findIpByAccountId($accountID);
    	
    }
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     */
    public function getServerByAccountId($accountID="") {
    	
    	return HostbillDao::singleton()->findServerByAccountId($accountID);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     */
    public function getPortSwitchByAccountId($accountID="") {
    	
    	return HostbillDao::singleton()->findPortSwitchByAccountId($accountID);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function getDomainByClientId($clientID="") {
    	
    	return HostbillDao::singleton()->findDomainByClientId($clientID);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     * @example HostbillApi::singleton()->getIpByClientId($clientID)
     */
    public function getIpByClientId($clientID="") {
    	
    	return HostbillDao::singleton()->findIpByClientId($clientID);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     * @example HostbillApi::singleton()->getServerByClientId($params["account"]["client_id"])
     */
    public function getServerByClientId($clientID="") {
    	
    	return HostbillDao::singleton()->findServerByClientId($clientID);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function getPortSwitchByClientId($clientID="") {
    	
    	return HostbillDao::singleton()->findPortSwitchByClientId($clientID);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     * @example HostbillApi::singleton()->getAccountByClientId($params["account"]["client_id"])
     */
    public function getAccountByClientId($clientID="") {
    	
    	return HostbillDao::singleton()->findAccountByClientId($clientID);
    	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $itemID
     * @param $portID
     * @example HostbillApi::singleton()->getServerIdByItemIdAndPortId(3, 14)
     */
    public function getServerIdByItemIdAndPortId($itemID="", $portID="") {
    	
    	return HostbillDao::singleton()->findServerIdByItemIdAndPortId($itemID, $portID);
    	
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->isAddonFreeMonitorActive($params["account"]["id"])
     */
    public function isAddonFreeMonitorActive($accountID="") {
    	
    	$res = false;
    	$aAddon = HostbillDao::singleton()->findAddonByAccountId($accountID);
    	if (count($aAddon) > 0) {
    		for ($i=0;$i<count($aAddon);$i++) {
    			if (isset($aAddon[$i]['name']) && isset($aAddon[$i]['status']) 
    			     && preg_match("/Free/i", $aAddon[$i]['name'])
    			     && $aAddon[$i]['status'] == "Active") {
    				 $res = true;
    				 break;
    			}
    		}
    	}
    	
    	return $res;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->getAddonFreeMonitorStatus($params["account"]["id"])
     */
    public function getAddonFreeMonitorStatus($accountID="") {
        
        $status = "Pending";
        $aAddon = HostbillDao::singleton()->findAddonByAccountId($accountID);
        if (count($aAddon) > 0) {
            for ($i=0;$i<count($aAddon);$i++) {
                if (isset($aAddon[$i]['name']) && isset($aAddon[$i]['status']) 
                     && preg_match("/Free/i", $aAddon[$i]['name'])) {
                     $status = $aAddon[$i]['status'];
                     break;
                }
            }
        }
        
        return $status;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->isAddonManageServiceActive($params["account"]["id"])
     */
    public function isAddonManageServiceActive($accountID="") {
    	
    	$res = false;
        $aAddon = HostbillDao::singleton()->findAddonByAccountId($accountID);
        if (count($aAddon) > 0) {
            for ($i=0;$i<count($aAddon);$i++) {
                if (isset($aAddon[$i]['name']) && isset($aAddon[$i]['status']) 
                     && preg_match("/Manage/i", $aAddon[$i]['name'])
                     && $aAddon[$i]['status'] == "Active") {
                     $res = true;
                     break;
                }
            }
        }
        
        return $res;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->getAddonManageServiceStatus($params["account"]["id"])
     */
    public function getAddonManageServiceStatus($accountID="") {
        
        $status = "Pending";
        $aAddon = HostbillDao::singleton()->findAddonByAccountId($accountID);
        if (count($aAddon) > 0) {
            for ($i=0;$i<count($aAddon);$i++) {
                if (isset($aAddon[$i]['name']) && isset($aAddon[$i]['status']) 
                     && preg_match("/Manage/i", $aAddon[$i]['name'])) {
                     $status = $aAddon[$i]['status'];
                     break;
                }
            }
        }
        
        return $status;
    }
    
    /**
     * 
     * Redeclare
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->getDomainByAccountId($params["account"]["id"])
    public function getDomainByAccountId($accountID="") {
    	
    	return HostbillDao::singleton()->findDomainByAccountId($accountID);
    	
    }
    */

}