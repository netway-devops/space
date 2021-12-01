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
include_once(APPDIR_MODULES . "Hosting/manage_service/include/class.manage.service.common.php");

// Load Hostbill Dao
include_once(APPDIR_MODULES . "Hosting/manage_service/include/class.manage.service.dao.php");

class ManageHostbillApi {
	
	//protected $params;
	
	protected $moduleName = "manage_service";
	
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
     * @param $appId
     * @example $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($params["account"]["server_id"]);
     */
    public function getServerDetailsByServerId($serverID='') {
        
        $params = array(
           "id" => $serverID
        );
        
        return HBWrapper::singleton()->getServerDetails($params);
    }
    
    
    /**
     * 
     * Verify Server Managment Service
     * If check box server management services Return TRUE
     * else Return FALSE
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @return <Boolean>
     * @example ManageHostbillApi::singleton()->isServerManageService();
     */
    public function isServerManageService() {
        return true;
    }
    
    /**
     * 
     * Get status on app server management service
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @return <STRING>
     * @example ManageHostbillApi::singleton()->getStatusServerManageService(); active|terminate|pending
     * 
     */
    public function getStatusServerManageService() {
        return true;
    }
    
}