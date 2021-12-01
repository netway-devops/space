<?php

/**
 * 
 * Hostbill Dao
 * 
 */

class HostbillDao {
	
	protected $db;
	
    /**
     * 
     * Enter description here ...
     */
    public function __construct() {
        $this->db = hbm_db();
    }
    
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
     * @param $accountID
     * @example HostbillDao::singleton()->findOrderIdByAccountId("32")
     */
    public function findOrderIdByAccountId($accountID="") {
    	
    	$query = sprintf("   
                        SELECT 
                            i.order_id
                        FROM 
                            %s i
                        WHERE
                            i.id='%s'                  
                        "
                        , "hb_accounts"
                        , $accountID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (isset($aRes["0"]["order_id"])) ? $aRes["0"]["order_id"] : null;              
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * @example HostbillApi::singleton()->getIpByAccountId($params["account"]["account_id"])
     */
    public function findIpByAccountId($accountID="") {
    	
    	$aIp = array();
    	
    	/*
    	$query = sprintf("   
                        SELECT 
                            i.ipaddress
                        FROM 
                            %s i
                        WHERE
                            i.account_id='%s'                  
                        "
                        , "hb_ipam"
                        , $accountID
                    );
        */            
                    
        $query = sprintf("   
                        SELECT
                            cast(conv(hex(i.ipaddress), 16, 10) as unsigned integer) AS ipaddress
                        FROM 
                            %s i,
                            %s ia
                        WHERE
                            ia.item_id='%s'
                        AND
                            ia.ip_id = i.id
                        AND
                            i.server_id != '0'                
                        "
                        , "hb_ipam"
                        , "hb_ipam_assign"
                        , $accountID
                    );          
              
                    
        $aRes = $this->db->query($query)->fetchAll();
        if (count($aRes)>0) {
        	for ($i=0;$i<count($aRes);$i++) {
        		if (isset($aRes[$i]["ipaddress"])) {
        			array_push($aIp, long2ip($aRes[$i]["ipaddress"]));
        		}
        	}
        }                     
                    
        return $aIp; 
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     */
    public function findServerByAccountId($accountID="") {
    	
    	$aServer = array();
    	
    	$query = sprintf("   
                        SELECT
                            DISTINCT
                            s.ip, 
                            s.username,
                            i2c.item_id
                        FROM 
                            %s i2c,
                            %s riv,
                            %s s
                        WHERE
                            i2c.account_id='%s'
                        AND 
                            i2c.item_id = riv.item_id AND riv.value = s.id           
                        "
                        , "tb_items2accounts"
                        , "tb_rack_item_field_value"
                        , "hb_servers"
                        , $accountID
                    );
    	
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0) {
        	$aServer = $aRes;
        }

        return $aServer;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     */
    public function findDomainByAccountId($accountID="") {
    	
    	$aRes = array();
    	
        $query = sprintf("   
                        SELECT
                            i.domain
                        FROM 
                            %s i
                        WHERE
                            i.id='%s'        
                        "
                        , "hb_accounts"
                        , $accountID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes) > 0 && isset($aRes["0"]["domain"]) && $aRes["0"]["domain"] != "") ? $aRes["0"]["domain"] : null;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function findServerByClientId($clientID="") {
    	
    	$aServer = array();
    	
    	$query = sprintf("   
                        SELECT
                            DISTINCT
                            s.id,
                            s.name,
                            s.ip,
                            s.username,
                            i2a.item_id
                        FROM 
                            %s a,
                            %s i2a,
                            %s riv,
                            %s s
                        WHERE
                            a.client_id='%s'
                        AND
                            a.id = i2a.account_id
                        AND
                            i2a.item_id = riv.item_id
                        AND
                            riv.value = s.id          
                        "
                        , "hb_accounts"
                        , "tb_items2accounts"
                        , "tb_rack_item_field_value"
                        , "hb_servers"
                        , $clientID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0) {
            $aServer = $aRes;
        }

        return $aServer;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     */
    public function findPortSwitchByAccountId($accountID="") {
        
        $aPort = array();
        
        $query = sprintf("   
                        SELECT
                            i2a.port_id, 
                            i2a.port_name,
                            i2a.item_id
                        FROM 
                            %s i2a
                        WHERE
                            i2a.account_id='%s'        
                        "
                        , "tb_items2accounts"
                        , $accountID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0) {
        	
        	/*
        	for ($i=0;$i<count($aRes);$i++) {
        		if (isset($aRes[$i]["port_id"]) && isset($aRes[$i]["port_name"])) {
        			if ($aRes[$i]["port_id"] == "1") {
        				$aRes[$i]["port_id"] = "1";
        			} else {
        				$aExplode = explode("/", $aRes[$i]["port_name"]);
        				$aRes[$i]["port_id"] = (isset($aExplode["1"]) && $aExplode["1"] != "") ? $aExplode["1"] : $aRes[$i]["port_id"] - 1;
        			}
        		}
        	}*/
        	
            $aPort = $aRes;
        }                    
                    
        return $aPort;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function findPortSwitchByClientId($clientID="") {
    	
    	$aPort = array();
        
        $query = sprintf("   
                        SELECT
                            i2a.port_id, 
					        i2a.port_name,
					        i2a.item_id
                        FROM 
                            %s a,
                            %s i2a
                        WHERE
                            a.client_id='%s'
                        AND
                            a.id = i2a.account_id        
                        "
                        , "hb_accounts"
                        , "tb_items2accounts"
                        , $clientID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0) {
            
        	/*
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]["port_id"]) && isset($aRes[$i]["port_name"])) {
                    if ($aRes[$i]["port_id"] == "1") {
                        $aRes[$i]["port_id"] = "1";
                    } else {
                        $aExplode = explode("/", $aRes[$i]["port_name"]);
                        $aRes[$i]["port_id"] = (isset($aExplode["1"]) && $aExplode["1"] != "") ? $aExplode["1"] : $aRes[$i]["port_id"] - 1;
                    }
                }
            }
            */
            
            $aPort = $aRes;
        }                    
                    
        return $aPort;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function findAccountByClientId($clientID="") {
    	
    	$aAccount = array();
    	
    	
    	$query = sprintf("   
                        SELECT
                            a.id,
                            a.client_id,
                            a.order_id
                        FROM 
                            %s a
                        WHERE
                            a.client_id='%s'        
                        "
                        , "hb_accounts"
                        , $clientID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0) {
        	$aAccount = $aRes;
        }
    	    	
    	return $aAccount;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function findAccountByAccountId($accountID="") {
        
        $aAccount = array();
        
        
        $query = sprintf("   
                        SELECT
                            *
                        FROM 
                            %s a
                        WHERE
                            a.id='%s'        
                        "
                        , "hb_accounts"
                        , $accountID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0 && isset($aRes[0])) {
            $aAccount = $aRes[0];
        }
                
        return $aAccount;
        
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function findDomainByClientId($clientID="") {
    	
    	$aDomain = array();
    	
    	$query = sprintf("   
                        SELECT
                            i.domain
                        FROM 
                            %s i
                        WHERE
                            i.client_id='%s'        
                        "
                        , "hb_accounts"
                        , $clientID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0) {
            $aDomain = $aRes;
        }
        
    	return $aDomain;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     */
    public function findIpByClientId($clientID="") {
    	
    	$aIp = array();
    	
    	$query = sprintf("   
                        SELECT
                            cast(conv(hex(i.ipaddress), 16, 10) as unsigned integer) AS ipaddress
                        FROM 
                            %s i
                        WHERE
                            i.client_id='%s'        
                        "
                        , "hb_ipam"
                        , $clientID
                    );
        
        
        $aRes = $this->db->query($query)->fetchAll();
        if (count($aRes)>0) {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]["ipaddress"])) {
                    array_push($aIp, long2ip($aRes[$i]["ipaddress"]));
                }
            }
        }
        
    	
    	return $aIp;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $itemID
     * @param $portID
     */
    public function findServerIdByItemIdAndPortId($itemID="", $portID="") {
    	
    	$query = sprintf("   
                        SELECT
                            s.id,
                            s.ip
                        FROM 
                            %s i2a,
                            %s rif,
                            %s s
                        WHERE
                            i2a.item_id=%s
                        AND
						    i2a.port_id=%s
						AND
						    rif.item_id=i2a.item_id
						AND
						    rif.value=s.id        
                        "
                        , "tb_items2accounts"
                        , "tb_rack_item_field_value"
                        , "hb_servers"
                        , $itemID
                        , $portID
                    );
        
        
        $aRes = $this->db->query($query)->fetchAll();
        
    	return (count($aRes) > 0 && isset($aRes[0]["ip"])) ? $aRes[0]["ip"] : null;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     */
    public function findAddonByAccountId($accountID="") {
    	
    	$aAddon = array();
        
        $query = sprintf("   
                        SELECT
                            i.id,
                            i.name,
                            i.status
                        FROM 
                            %s i
                        WHERE
                            i.account_id='%s'        
                        "
                        , "hb_accounts_addons"
                        , $accountID
                    );
        
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes) > 0) {
            $aAddon = $aRes;
        }
        
        return $aAddon;
    }
    
    
    // ========================
    // ========================
    // ========================
    // ========================
    
    
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * 
     * @example SELECT i.port_id, i.port_name FROM tb_items2accounts i WHERE i.account_id =  '27'
     *
     */
    public function findProvisionSNMP($accountID) {
    	
    	$query = sprintf("   
                        SELECT 
                            i.port_id, 
                            i.port_name
                        FROM 
                            %s i
                        WHERE
                            i.account_id='%s'                  
                        "
                        , "tb_items2accounts"
                        , $accountID
                );

        return $this->db->query($query)->fetchAll();
                        
    }
    
    


    
    
    
    
    
    
}


 