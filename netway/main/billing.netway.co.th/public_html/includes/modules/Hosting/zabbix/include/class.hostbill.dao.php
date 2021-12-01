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
     * Find Account By Ip Address
     * 
     * @param $ipaddress
     * @return STRING
     * 
     * @example HostbillDao::singleton()->findIpamrDnsByIp("203.78.99.77")
     */
    public function findIpamrDnsByIp($ipaddress="") {
        
        $rDNS = "";
        
        $query = sprintf("   
                            SELECT
                                cast(conv(hex(ip.ipaddress), 16, 10) as unsigned integer) AS ipaddress
                                , ip.revdns
                            FROM 
                                %s ip                                  
                            "
                            , "hb_ipam"
        );
        $aRes = $this->db->query($query)->fetchAll();
            
        if (count($aRes)>0) {
            for ($i=0;$i<count($aRes);$i++) {
                if (long2ip($aRes[$i]['ipaddress']) == $ipaddress) {
                    $rDNS = $aRes[$i]['revdns'];
                    break;
                }
            }
        }
        
        return ($rDNS == "") ? "" : $rDNS;
    }
    
    /**
     * Find Account By Ip Address
     * 
     * @param $ip
     * @return ARRAY
     * 
     * @example HostbillDao::singleton()->findAccountByIp("203.78.99.77")
     */
    public function findAccountByIp($ip) {
        
        $query = sprintf("   
                                SELECT
                                    vps.account_id
                                FROM 
                                    %s vps
                                WHERE
                                    vps.ip LIKE '%%%s%%'
                                OR
                                    vps.additional_ip LIKE '%%%s%%'                                  
                                "
                                , "hb_vps_details"
                                , $ip
                                , $ip
                        );
                        
       return $this->db->query($query)->fetchAll();
    }
    
    /**
     * Is Hypervisor by Account
     * 
     * @param $accountID
     * @return ARRAY
     * 
     * @example HostbillDao::singleton()->isHypervisorByAccountId("3528")
     */
    public function isHypervisorByAccountId($accountID="") {
        
        $query = sprintf("   
                            SELECT
                                c2a.account_id
                            FROM 
                                %s c2a
                                , %s cic
                                , %s ci
                            WHERE
                                c2a.account_id='%s'
                            AND
                                c2a.rel_type='Hosting'
                            AND
                                c2a.config_cat=cic.id
                            AND
                                cic.variable='hypervisor'
                            AND
                                c2a.config_cat=ci.category_id
                            AND
                                c2a.config_id=ci.id
                            AND
                                ci.variable_id='1'                                                                  
                            "
                            , "hb_config2accounts"
                            , "hb_config_items_cat"
                            , "hb_config_items"
                            , $accountID
        );

        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes)>0 && isset($aRes[0]["account_id"]) && $aRes[0]["account_id"] != '') ? true : false;
        
    }
    
    
    /**
     * IPAM VPS Hypervisor
     * 
     * @param $accountID
     * @return ARRAY
     * 
     * @example HostbillDao::singleton()->findIpamVpsByAccountId("3529")
     */
    public function findIpamVpsByAccountId($accountID="") {
        
        $aIpamVps = array(
            'accountID' => array(),
            'ip' => array(),
            'hostname' => array()
        );
        
        $aRes = $this->db->query("
                    SELECT
                        ci.variable_id, cic.variable
                    FROM
                        hb_accounts a,
                        hb_config2accounts c2a,
                        hb_config_items ci,
                        hb_config_items_cat cic
                    WHERE
                        a.id = :accountId
                        AND a.id = c2a.account_id
                        AND c2a.rel_type = 'Hosting'
                        AND c2a.config_id = ci.id
                        AND c2a.config_cat = cic.id
                        AND cic.variable IN ('hypervisor')
                    ", array(
                        ':accountId' => $accountID
                ))->fetchAll();

        if (count($aRes)>0 && isset($aRes[0]["variable_id"]) && $aRes[0]["variable_id"] == 1) {
            
            $query = sprintf("   
                            SELECT
                                cast(conv(hex(ip.ipaddress), 16, 10) as unsigned integer) AS ipaddress
                            FROM 
                                %s ipa
                                , %s ip
                            WHERE
                                ipa.item_type='account'
                            AND
                                ipa.item_id='%s'
                            AND
                                ipa.ip_id=ip.id                                   
                            "
                            , "hb_ipam_assign"
                            , "hb_ipam"
                            , $accountID
            );
                       
           $aRes = $this->db->query($query)->fetchAll();
           if (count($aRes)>0) {
                for ($i=0;$i<count($aRes);$i++) {
                    if (isset($aRes[$i]["ipaddress"]) && $aRes[$i]["ipaddress"] != '') {
                        
                        $ip = long2ip($aRes[$i]["ipaddress"]);
                        $query = sprintf("   
                                SELECT
                                    vps.ip, vps.additional_ip, vps.account_id
                                FROM 
                                    %s vps
                                WHERE
                                    vps.ip='%s'
                                OR
                                    vps.additional_ip LIKE '%%%s'                                  
                                "
                                , "hb_vps_details"
                                , $ip
                                , $ip
                        );
                        
                        $aRes1 = $this->db->query($query)->fetchAll();
                        if (count($aRes1)>0 && isset($aRes1[0]['account_id']) && $aRes1[0]['account_id'] != '') {
                            if ($aRes1[0]['account_id'] == $accountID) {
                            } else {
                                
                                array_push($aIpamVps['accountID'], $aRes1[0]['account_id']);
                                array_push($aIpamVps['ip'], $ip);
                                
                                $hostname = gethostbyaddr($ip);
                                if ($hostname == $ip) {
                                    $query = sprintf("   
                                            SELECT
                                                hbac.domain
                                            FROM 
                                                %s hbac
                                            WHERE
                                                hbac.id='%s'                                 
                                            "
                                            , "hb_accounts"
                                            , $aRes1[0]['account_id']
                                    );
                                    $aRes2 = $this->db->query($query)->fetchAll();
                                    if (count($aRes2)>0 && isset($aRes2[0]['domain']) && $aRes2[0]['domain'] != '') {
                                        $hostname = $aRes2[0]['domain'];
                                    }
                                }
                                
                                array_push($aIpamVps['hostname'], $hostname);
                                
                                
                            }
                        }
                        
                    }   
                }          
            }  
                   
        } 

        return $aIpamVps;
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
    
    
    /**
     * 
     * Enter description here ...
     * @param $switchID
     * 
     * HostbillDao::singleton()->findRackItemIdBySwitchId("32")
     */
    public function findRackItemIdBySwitchId($switchID) {
    	
    	$query = sprintf("   
                        SELECT
                            ri.id
                        FROM 
                            %s rit,
                            %s ri
                        WHERE
                            rit.name LIKE '%%%s'
                        AND
                            rit.id=ri.item_type_id   
                        "
                        , "tb_rack_item_type"
                        , "tb_rack_item"
                        , $switchID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes) > 0 && isset($aRes[0]["id"])) ? $aRes[0]["id"] : null;
        	
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * 
     * 
     * HostbillDao::singleton()->replaceIpamConnectZabbix("32", "192.168.1.72")
     */
    public function replaceIpamConnectZabbix($accountID="", $ipaddress="") {
    	
    	if (isset($accountID) && isset($ipaddress) && $accountID != "" && $ipaddress != "'") {
    		$query = sprintf("   
                        REPLACE INTO
                            %s (%s, %s)
                        VALUES
                            ('%s', '%s')
                       "
                       , "tb_zabbix_ipam_assing"
    		           , "account_id"
    		           , "ipaddress"
    		           , $accountID
    		           , $ipaddress
                    );
            
            $this->db->query($query);
    	}
    	
    	return true;
    }
    
    
    /**
     * 
     * @param $accountID
     * @return bool
     * 
     * HostbillDao::singleton()->findVpsDetailsByAccountId("584")
     * 
     * Fix bug from hostbill. Order Pages "VPS Hosting"
     */
    public function findVpsDetailsByAccountId($accountID="") {
        
        $query = sprintf("   
                        SELECT
                            vps.account_id
                        FROM 
                            %s vps
                        WHERE
                            vps.account_id='%s' 
                        "
                        , "hb_vps_details"
                        , $accountID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes) > 0 && isset($aRes[0]["account_id"])) ? true : false;
    }
    
    
    
    /**
     * 
     * @param $accountID
     * @return bool
     * 
     * @example HostbillDao::singleton()->insertVpsDetails("584")
     * 
     * Fix bug from hostbill. Order Pages "VPS Hosting"
     */
    public function insertVpsDetails($accountID="") {
        
        $query = sprintf("   
                        INSERT INTO
                            %s
                            (account_id, type)
                        VALUES
                            ('%s', 'OpenVZ')
                        "
                        , "hb_vps_details"
                        , $accountID
                );

        $aRes = $this->db->query($query);
        
        return true;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * 
     * HostbillDao::singleton()->findIpamConnectZabbixByAccountId("32")
     */
    public function findIpamConnectZabbixByAccountId($accountID="") {
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
       
        $adminUrl = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     
        $post = array(
              'call' => 'module',
              'module' => 'billingcycle',
              'fn' => 'getMainIpFromIpam',
              'accountID' => $accountID
        );
        $res = $apiCustom->request($post);
        
        return (isset($res['ip']) && $res['ip'] != "") ? $res['ip'] : null;
        
        /*
        $query = sprintf("   
                        SELECT
                            z.ipaddress
                        FROM 
                            %s z
                        WHERE
                            z.account_id=%s
                        "
                        , "tb_zabbix_ipam_assing"
                        , $accountID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes) > 0 && isset($aRes[0]["ipaddress"])) ? $aRes[0]["ipaddress"] : null;
        */
        
        
        /*
        $query = sprintf("   
                        SELECT
                            z.ip
                        FROM 
                            %s z
                        WHERE
                            z.account_id=%s
                        "
                        , "hb_vps_details"
                        , $accountID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        
        $ip = (count($aRes) > 0 && isset($aRes[0]["ip"]) && $aRes[0]["ip"] != "") ? $aRes[0]["ip"] : null;
        
        if (isset($ip)) {
        } else {
            $aRes = HostbillDao::singleton()->findIpByAccountId($accountID);
            $ip = (count($aRes) > 0 && isset($aRes[0]) && $aRes[0] != "") ? $aRes[0] : null;
        }
        
        return $ip;
        */
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * 
     * HostbillDao::singleton()->findIpamConnectZabbixByIpaddress("203.78.109.252")
     */
    public function findIpamConnectZabbixByIpaddress($ipaddress="") {
        $query = sprintf("   
                        SELECT
                            z.account_id
                        FROM 
                            %s z
                        WHERE
                            z.ipaddress='%s'
                        "
                        , "tb_zabbix_ipam_assing"
                        , $ipaddress
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes) > 0 && isset($aRes[0]["account_id"])) ? $aRes[0]["account_id"] : null;   
    }
    
    /**
     * 
     * Enter description here ...
     * @param $accountID
     * 
     * HostbillDao::singleton()->isCategorieVpsByAccountId('3434')
     */
    public function isCategorieVpsByAccountId($accountID="") {

        $query = sprintf("   
                        SELECT
                            hbpro.category_id
                        FROM
                            %s hbacc,
                            %s hbpro
                        WHERE
                            hbacc.id='%s'
                        AND
                            hbacc.product_id=hbpro.id
                        "
                        , "hb_accounts"
                        , "hb_products"
                        , $accountID
                    );
                                       
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes) > 0 && isset($aRes[0]["category_id"]) && $aRes[0]["category_id"] == 24) ? true : false;
        
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


 