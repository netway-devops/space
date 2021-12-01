<?php

/**
 * 
 * Hostbill Common
 * 
 * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
 * @see http://wiki.hostbillapp.com/index.php?title=Domain_Modules
 */

class HostbillCommon {
    
    /**
     * Returns a singleton HostbillCommon instance.
     *
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
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
     * method is used to validate domain google code
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     */
    public function validate_doViewDomain($request) {

        $input = array(
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["domain_name"] = (isset($request["domain_name"]) && $request["domain_name"] != "") ? trim($request["domain_name"]) : null;
        
        if (isset($input["domain_name"])) {
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doDomainGoogleCode)__ domain_name Missing.";
        }
        
        return $input;
    }
    
    
    /**
     * Method is used to domain forwarding
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     * 
     */
    public function doViewDomain($request) {
        
    	$raiseError = 0;
    	
    	$aView = array(
    	   'domain' => '',
    	   'tld' => '',
    	   'urlforwarding' => '',
    	   'cloak' => '',
    	   'googlecode' => ''
    	);
    	
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doViewDomain($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }

            @preg_match('/(\.\w+)+$/', $input["domain_name"], $aTLD);
            @preg_match('/^(.*?)\./', $input["domain_name"], $aDomain);
            
            $domain = (count($aDomain)>0 && isset($aDomain[1]) && $aDomain[1] != "") ? $aDomain[1] : null;
            $tld = (count($aTLD)>0 && isset($aTLD[0]) && $aTLD[0] != "") ? $aTLD[0] : null;
            
            if (isset($domain) && isset($tld)) {
            	$aRes = HostbillDao::singleton()->findDomainByDomainByTld($domain, $tld);
            	if (count($aRes)>0) {
            		$aView = $aRes;
            	}
            } else {
                throw new Exception("__(doViewDomain)__ Cannot calculate domain and tld from domain name " . $input["domain_name"]);
            }
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doViewDomain",
            "view" => $aView
        );
        
        return $aResponse;
    }
    
    
    /**
     * 
     * method is used to validate domain google code
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     */
    public function validate_doDomainGoogleCode($request) {

        $input = array(
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["domain_name"] = (isset($request["domain_name"]) && $request["domain_name"] != "") ? trim($request["domain_name"]) : null;
        
        $input["google_code"] = (isset($request["google_code"]) && $request["google_code"] != "") ? trim($request["google_code"]) : "";
 
        if (isset($input["domain_name"])) {
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doDomainGoogleCode)__ domain_name Missing.";
        }
        
        return $input;
    }
    
    
    /**
     * Method is used to domain forwarding
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     * 
     */
    public function doDomainGoogleCode($request) {
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doDomainGoogleCode($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }

            @preg_match('/(\.\w+)+$/', $input["domain_name"], $aTLD);
            @preg_match('/^(.*?)\./', $input["domain_name"], $aDomain);
            
            $domain = (count($aDomain)>0 && isset($aDomain[1]) && $aDomain[1] != "") ? $aDomain[1] : null;
            $tld = (count($aTLD)>0 && isset($aTLD[0]) && $aTLD[0] != "") ? $aTLD[0] : null;
            
            if (isset($domain) && isset($tld)) {
                HostbillDao::singleton()->replaceDomainGoogleCode($domain, $tld, $input["google_code"]);
            } else {
                throw new Exception("__(validate_doDomainGoogleCode)__ Cannot calculate domain and tld from domain name " . $input["domain_name"]);
            }
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Update Google App Code Success."],"STACK":0} -->';
        exit;
        
        return true;
    }
    
    
    /**
     * 
     * method is used to validate domain forwarding
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     */
    public function validate_doDomainForwarding($request) {

        $input = array(
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["domain_name"] = (isset($request["domain_name"]) && $request["domain_name"] != "") ? trim($request["domain_name"]) : null;
        $input["tld_id"] = (isset($request["tld_id"]) && $request["tld_id"] != "") ? $request["tld_id"] : null;
        
        $input["protocal"] = (isset($request["protocal"]) && $request["protocal"] != "") ? $request["protocal"] . "://" : "";
        $input["url_forwarding"] = (isset($request["url_forwarding"]) && $request["url_forwarding"] != "") 
                                                    ? trim($input["protocal"] . $request["url_forwarding"]) : "";
        $input["cloak"] = (isset($request["cloak"]) && $request["cloak"] != "") ? $request["cloak"] : "1";
 
        if (isset($input["domain_name"])) {
        	if (isset($input["protocal"])) {
        	} else {
        		$input["isValid"] = false;
                $input["raiseError"] = "__(validate_doDomainForwarding)__ protocal Missing.";
        	}
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doDomainForwarding)__ domain_name Missing.";
        }
        
        return $input;
    }
    
    
    /**
     * Method is used to domain forwarding
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     * 
     */
    public function doDomainForwarding($request) {
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doDomainForwarding($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }

            @preg_match('/(\.\w+)+$/', $input["domain_name"], $aTLD);
            @preg_match('/^(.*?)\./', $input["domain_name"], $aDomain);
            
            $domain = (count($aDomain)>0 && isset($aDomain[1]) && $aDomain[1] != "") ? $aDomain[1] : null;
            $tld = (count($aTLD)>0 && isset($aTLD[0]) && $aTLD[0] != "") ? $aTLD[0] : null;
            
            if (isset($domain) && isset($tld)) {
            	HostbillDao::singleton()->replaceDomainForwarding($domain, $tld, $input["url_forwarding"], $input["cloak"]);
            } else {
            	throw new Exception("__(validate_doDomainForwarding)__ Cannot calculate domain and tld from domain name " . $input["domain_name"]);
            }
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Update Domain Forwarding Success."],"STACK":0} -->';
        exit;
        
        return true;
    }
    
    
    /**
     * ลบ domain forwarding
     * 
     */
    public function doDomainForwardingDelete($request) {
        
        $db         = hbm_db();
        $aClient    = (object) hbm_logged_client();
        
        $domainname = isset($request['domain_name']) ? $request['domain_name'] : '';
        
        if (! isset($aClient->id)) {
            echo '<!-- {"ERROR":["ข้อมูลผู้ใช้งาน ไม่ถูกต้อง"],"INFO":[],"STACK":0} -->';
            exit;
        }
        if (! $domainname) {
            echo '<!-- {"ERROR":["Domain name ไม่ถูกต้อง"],"INFO":[],"STACK":0} -->';
            exit;
        }
        
        $result     = $db->query("
            SELECT
                d.*
            FROM
                hb_domains d
            WHERE
                d.name = :domainname
            ", array(
                ':domainname'   => $domainname
            ))->fetch();
        
        if (! isset($result['id']) || $result['client_id'] != $aClient->id) {
            echo '<!-- {"ERROR":["Domain name ไม่ใช่ของลูกค้า"],"INFO":[],"STACK":0} -->';
            exit;
        }
        
        $pos            = strpos($domainname, '.');
        $domain         = substr($domainname, 0, $pos);
        $tld            = substr($domainname, $pos);
        
        $db->query("
            DELETE FROM
                tb_domain_forwarding
            WHERE
                domain = :domain
                AND tld = :tld
            LIMIT 1
            ", array(
                ':domain'   => $domain,
                ':tld'      => $tld
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Delete Domain Forwarding Success."],"STACK":0} -->';
        exit;
    }
    
    
    
    /**
     * 
     * method is used to validate modify the IP of Nameserver for the registrar.
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     */
    public function validate_doModifyNameServer($request) {

        $input = array( 
            "nameservers" => array(),
            "nsips" => array(),
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["domain_id"] = (isset($request["domain_id"]) && $request["domain_id"] != "") ? $request["domain_id"] : null;
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        $input["order_id"] = (isset($request["order_id"]) && $request["order_id"] != "") ? $request["order_id"] : null;
        $input["domain_name"] = (isset($request["domain_name"]) && $request["domain_name"] != "") ? $request["domain_name"] : null;
      
        $input["nameservers"][0] = (isset($request["nameservers_ns1"]) && $request["nameservers_ns1"] != "") ? $request["nameservers_ns1"] : "";
        $input["nameservers"][1] = (isset($request["nameservers_ns2"]) && $request["nameservers_ns2"] != "") ? $request["nameservers_ns2"] : "";
        $input["nameservers"][2] = (isset($request["nameservers_ns3"]) && $request["nameservers_ns3"] != "") ? $request["nameservers_ns3"] : "";
        $input["nameservers"][3] = (isset($request["nameservers_ns4"]) && $request["nameservers_ns4"] != "") ? $request["nameservers_ns4"] : "";
        $input["nameservers"][4] = (isset($request["nameservers_ns5"]) && $request["nameservers_ns5"] != "") ? $request["nameservers_ns5"] : "";
        $input["nsips"][0] = (isset($request["nsips_1"]) && $request["nsips_1"] != "") ? $request["nsips_1"] : "";
        $input["nsips"][1] = (isset($request["nsips_2"]) && $request["nsips_2"] != "") ? $request["nsips_2"] : "";
        $input["nsips"][2] = (isset($request["nsips_3"]) && $request["nsips_3"] != "") ? $request["nsips_3"] : "";
        $input["nsips"][3] = (isset($request["nsips_4"]) && $request["nsips_4"] != "") ? $request["nsips_4"] : "";
        $input["nsips"][4] = (isset($request["nsips_5"]) && $request["nsips_5"] != "") ? $request["nsips_5"] : "";
        
        if (isset($input["domain_id"])) {
        	if (isset($input["client_id"])) {
        	} else {
        		$input["isValid"] = false;
                $input["raiseError"] = "__(validate_doModifyNameServer)__ client_id Missing.";
        	}
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doModifyNameServer)__ domain_id Missing.";
        }
        
        return $input;
    }
    
    
    /**
     * Method is used to modify the IP of Nameserver for the registrar
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     * 
     */
    public function doModifyNameServer($request) {
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doModifyNameServer($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            
            // เปลี่ยน NS Server: ส่ง email แจ้งที่ domain@tickets.netway.co.th  
            // from ให้ใช้ email ลูกค้า เนื้อหา ก็บอกว่า มีการเปลี่ยนแปลงข้อมูล Name server จาก ???? ไป ??? เมื่อวันที่ ???? จาก IP ?????
            $message = "";
            
            $aNameServerInfo = HostbillDao::singleton()->findNameServersByDomainId($input["domain_id"]);
            if (count($aNameServerInfo['nameservers'])>0 && count($aNameServerInfo['nsips'])>0) {
            	for ($i=0;$i<count($aNameServerInfo['nameservers']);$i++) {
            		
            		if (isset($input['nameservers'][$i])) {
	            		if ($aNameServerInfo['nameservers'][$i] != $input['nameservers'][$i]) {
	                        // Nameserver 1
	                        $oldNameservers  = ($aNameServerInfo['nameservers'][$i] == "") ? "ค่าว่าง" : $aNameServerInfo['nameservers'][$i];
	                        $message .= "Nameserver " . ($i+1) . " : จาก " . $oldNameservers . " เป็น " . $input['nameservers'][$i] . "\n";
	                    }	
            		}
            		
            		if (isset($input['nsips'][$i])) {
	            		if ($aNameServerInfo['nsips'][$i] != $input['nsips'][$i]) {
	                        // Nameserver IP 1
	                        $oldNameserversIp  = ($aNameServerInfo['nsips'][$i] == "") ? "ค่าว่าง" : $aNameServerInfo['nsips'][$i];
	                        $message .= "Nameserver IP " . ($i+1) . " : จาก " . $oldNameserversIp . " เป็น " . $input['nsips'][$i] . "\n";
	                    }
            		}
            	}
            }
            
            
            if ($message == "") {
            } else {
            	
            	// Info Mail.
            	$aClientAccess = HostbillDao::singleton()->findClientAccessByClientId($input["client_id"]);
            	$aClientDetails = HostbillDao::singleton()->findClientDetailsByClientId($input["client_id"]);
            	
                if (count($aClientAccess)>0) {
  	
                	$today = date("Y-m-d H:i:s");
                	$ip = (isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] != "") ? $_SERVER['REMOTE_ADDR'] : $aClientAccess['ip'];
                	
                	$client_id = $input["client_id"];
                	$order_id = $input["order_id"];
                	$domain_name = $input["domain_name"];
                	
                	$firstname = $aClientDetails['firstname'];
                	$companyname = $aClientDetails['companyname'];
                	$address1 = $aClientDetails['address1'];
                	$phonenumber = $aClientDetails['phonenumber'];
                	
                	$messagePlain = <<<EOF
มีการเปลี่ยนแปลงข้อมูล Name server.
$message
เมื่อวันที่ $today จาก IP $ip
EOF;
                	
                    $aParam = array(
                        // 'recipient' => 'puttipong@rvglobalsoft.com', // [DEBUG]
                        'recipient' => 'domain@tickets.netway.co.th',
                        'from' => $aClientAccess['email'],
                        'subject' => 'มีการเปลี่ยนแปลงข้อมูล nameservers (' . $domain_name . ')',
                        'message' => $messagePlain
                    );
                    HostbillApi::singleton()->sendmail($aParam);
                    
                    
                    
                }
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":[],"STACK":0} -->';
        exit;
        
        return true;
    }
    
    
    
    /**
     * 
     * Method is used to validate update contact info at the registrar.
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     */
    public function validate_doUpdateContactInfo($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        
        $input["old_admin_email"] = (isset($request["old_admin_email"]) && $request["old_admin_email"] != "") ? trim($request["old_admin_email"]) : "";
        $input["new_admin_email"] = (isset($request["new_admin_email"]) && $request["new_admin_email"] != "") ? trim($request["new_admin_email"]) : "";
        
        $input["firstname"] = (isset($request["firstname"]) && $request["firstname"] != "") ? $request["firstname"] : "";
        $input["companyname"] = (isset($request["companyname"]) && $request["companyname"] != "") ? $request["companyname"] : "";
        $input["phonenumber"] = (isset($request["phonenumber"]) && $request["phonenumber"] != "") ? $request["phonenumber"] : "";

        
        if (true) {
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doUpdateContactInfo)__ ";
        }
        
        return $input;
    }
    
    /**
     * Method is used to update contact info at the registrar.
     * 
     * @author Puttipong Pengprakhon <puttipong@rvglobalsoft.com>
     * @param $request
     * 
     */
    public function doUpdateContactInfo($request) {
    	
    	try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doUpdateContactInfo($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }

            // เปลี่ยน Admin contact email address: ส่ง email แจ้งที่ domain@tickets.netway.co.th  
            // from ให้ใช้ email ลูกค้า เนื้อหา ก็บอกว่า มีการเปลี่ยนแปลงข้อมูล admin contact email จาก ???? ไป ??? เมื่อวันที่ ???? จาก IP ?????
            if ($input["old_admin_email"] != $input["new_admin_email"]) {
            	
            	// Info Mail.
                $aClientAccess = HostbillDao::singleton()->findClientAccessByClientId($input["client_id"]);
                
                if (count($aClientAccess)>0) {
    
                    $today = date("Y-m-d H:i:s");
                    $ip = (isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR'] != "") ? $_SERVER['REMOTE_ADDR'] : $aClientAccess['ip'];
                    
                    $client_id = $input["client_id"];
                    
                    $old_admin_email = ($input["old_admin_email"] == "") ? "ค่าว่าง" : $input["old_admin_email"];
                    $new_admin_email = ($input["new_admin_email"] == "") ? "ค่าว่าง" : $input["new_admin_email"];
                    
                    $firstname = $input["firstname"];
                    $companyname = $input["companyname"];
                    $phonenumber = $input["phonenumber"];
                    
                    $messagePlain = <<<EOF
มีการเปลี่ยนแปลงข้อมูล admin contact email จาก $old_admin_email เป็น $new_admin_email
เมื่อวันที่ $today จาก IP $ip
EOF;
                    
                    $aParam = array(
                        // 'recipient' => 'puttipong@rvglobalsoft.com', // [DEBUG]
                        'recipient' => 'domain@tickets.netway.co.th',
                        'from' => $aClientAccess['email'],
                        'subject' => 'มีการเปลี่ยนแปลงข้อมูล admin contact email',
                        'message' => $messagePlain
                    );
                    HostbillApi::singleton()->sendmail($aParam);
            	
                }
                
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":[],"STACK":0} -->';
        exit;
        
        return true;
    }
    
}