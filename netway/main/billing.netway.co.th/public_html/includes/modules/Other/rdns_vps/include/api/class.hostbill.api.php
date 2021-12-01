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
include_once(APPDIR_MODULES . "Other/rdns_vps/include/class.hostbill.common.php");

// Load Hostbill Dao
include_once(APPDIR_MODULES . "Other/rdns_vps/include/class.hostbill.dao.php");

// Load DB Mysql
include_once(APPDIR_MODULES . "Other/rdns_vps/include/class.db.mysql.php");

class HostbillApi {
    
    //protected $params;
    
    protected $moduleName = "rDNS for VPS";
    
    /**
     * 
     * Enter description here ...
     */
    public function __construct() {}
    
    /**
     * Returns a singleton HostbillApi instance.
     *
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
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
     * Get server deteails from server id.
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $appId
     * @example $aServer = HostbillApi::singleton()->getServerDetailsByServerId($params["account"]["server_id"]);
     */
    public function getServerDetailsByServerId($serverID="") {
        
        $params = array(
           "id" => $serverID
        );
        
        return HBWrapper::singleton()->getServerDetails($params);
    }
    
}