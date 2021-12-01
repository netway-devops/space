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
     * @param $domain
     * @param $tld
     * 
     * HostbillDao::singleton()->findDomainByDomainByTld("simbi", ".com")
     */
    public function findDomainByDomainByTld($domain="", $tld="") {
    	
    	$query = sprintf("   
                        SELECT
                            *
                        FROM 
                            %s d
                        WHERE
                            d.domain='%s'
                        AND
                            d.tld='%s'
                        "
                        , "tb_domain_forwarding"
                        , $domain
                        , $tld
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes[0])>0 && isset($aRes[0])) ? $aRes[0] : array();
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $domain
     * @param $tld
     * 
     * HostbillDao::singleton()->isDomainByDomainByTld("simbi", ".com")
     */
    public function isDomainByDomainByTld($domain="", $tld="") {
    	
    	$query = sprintf("   
                        SELECT
                            *
                        FROM 
                            %s d
                        WHERE
                            d.domain='%s'
                        AND
                            d.tld='%s'
                        "
                        , "tb_domain_forwarding"
                        , $domain
                        , $tld
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes[0])>0 && isset($aRes[0])) ? true : false;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $domain
     * @param $tld
     * @param $googleCode
     * 
     * HostbillDao::singleton()->replaceDomainForwarding("simbi", ".com", "google-site-verification=NIeL_RPRCqHr-4hqRrPEwZxj-2VCNmkukAlGe4kADYU")
     */
    public function replaceDomainGoogleCode($domain="", $tld="", $googleCode="") {
    	
    	if (HostbillDao::singleton()->isDomainByDomainByTld($domain, $tld) == true) {
    		
    		$query = sprintf("   
                        UPDATE
                            %s
                        SET
                            domain='%s'
                            , tld='%s'
                            , googlecode='%s'
                        WHERE
                            domain='%s'
                         AND
                            tld='%s'
                       "
                       , "tb_domain_forwarding"
                       , $domain
                       , $tld
                       , $googleCode
                       , $domain
                       , $tld
                    );
                    
    	} else {
    		
    		$query = sprintf("   
                        INSERT INTO
                            %s (%s, %s, %s)
                        VALUES
                            ('%s', '%s', '%s')
                       "
                       , "tb_domain_forwarding"
                       , "domain"
                       , "tld"
                       , "googlecode"
                       , $domain
                       , $tld
                       , $googleCode
                    );
                    
    	}
      
        $this->db->query($query);

        return true;
    }
    
    
    
    /**
     * 
     * Enter description here ...
     * @param $domain
     * @param $tld
     * @param $urlForwarding
     * @param $cloak
     * 
     * HostbillDao::singleton()->replaceDomainForwarding("simbi", ".com", "simbi.net", 1)
     */
    public function replaceDomainForwarding($domain="", $tld="", $urlForwarding="", $cloak="") {

    	if (HostbillDao::singleton()->isDomainByDomainByTld($domain, $tld) == true) {
    		
    		$query = sprintf("
                        UPDATE
                            %s
                        SET
                            domain='%s'
                            , tld='%s'
                            , urlforwarding='%s'
                            , cloak='%s'
                        WHERE
                            domain='%s'
                        AND    
                            tld='%s'
                       "
                       , "tb_domain_forwarding"
                       , $domain
                       , $tld
                       , $urlForwarding
                       , $cloak
                       , $domain
                       , $tld
                    );
                    
                    
    	} else {
    		
    		
    		$query = sprintf("   
                        INSERT INTO
                            %s (%s, %s, %s, %s)
                        VALUES
                            ('%s', '%s', '%s', '%s')
                       "
                       , "tb_domain_forwarding"
                       , "domain"
                       , "tld"
                       , "urlforwarding"
                       , "cloak"
                       , $domain
                       , $tld
                       , $urlForwarding
                       , $cloak
                    );
    		
    		
    	}

    	$this->db->query($query);

        return true;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     * 
     * HostbillDao::singleton()->findClientDetailsByClientId("2025")
     */
    public function findClientDetailsByClientId($clientID="") {
    	
    	$query = sprintf("   
                        SELECT
                            *
                        FROM 
                            %s d
                        WHERE
                            d.id='%s'
                        "
                        , "hb_client_details"
                        , $clientID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes[0])>0 && isset($aRes[0])) ? $aRes[0] : array();
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $clientID
     * 
     * HostbillDao::singleton()->findClientAccessByClientId("2025")
     */
    public function findClientAccessByClientId($clientID="") {
    	
    	$query = sprintf("   
                        SELECT
                            *
                        FROM 
                            %s d
                        WHERE
                            d.id='%s'
                        "
                        , "hb_client_access"
                        , $clientID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        
        return (count($aRes[0])>0 && isset($aRes[0])) ? $aRes[0] : array();
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $domainID
     * 
     * HostbillDao::singleton()->findNameServersByDomainId("3324")
     */
    public function findNameServersByDomainId($domainID="") {
    	
    	$aNameServerInfo = array(
    	   'nameservers' => array(),
    	   'nsips' => array()
    	);
    	
        $query = sprintf("   
                        SELECT
                            *
                        FROM 
                            %s d
                        WHERE
                            d.id='%s'
                        "
                        , "hb_domains"
                        , $domainID
                    );
                    
        $aRes = $this->db->query($query)->fetchAll();
        if (count($aRes)>0 && isset($aRes[0]['nameservers']) && isset($aRes[0]['nsips'])) {
        	
        	$aNameServerInfo['nameservers'] = explode('|', $aRes[0]['nameservers']);
        	$aNameServerInfo['nsips'] = explode('|', $aRes[0]['nsips']);
        	
        }

        return $aNameServerInfo;
    }
    
}