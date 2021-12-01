<?php

/**
 * 
 * Hostbill Common
 * 
 * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
 * @see http://wiki.hostbillapp.com/index.php?title=Domain_Modules
 * 
 * 
 * @DEBUG
 * 
 * mysql> SELECT *  FROM  records rec WHERE rec.name='108.97.78.203.in-addr.arpa';
 * +-----+-----------+----------------------------+------+--------------------------+-------+------+-------------+
 * | id  | domain_id | name                       | type | content                  | ttl   | prio | change_date |
 * +-----+-----------+----------------------------+------+--------------------------+-------+------+-------------+
 * | 702 |        13 | 108.97.78.203.in-addr.arpa | PTR  | atstest.atsolution.co.th | 14400 |    0 |  1381252833 | 
 * +-----+-----------+----------------------------+------+--------------------------+-------+------+-------------+
 * 
 * host 203.78.97.108 ptr1.netwaygroup.com
 * 
 * http://www.dnssy.com/lookup.php?q=203.78.97.108&reverse=1
 * https://netway.co.th/7944web/?cmd=accounts&action=edit&id=3746&list=all
 * 
 */

class HostbillCommon {
    
    /**
     * Returns a singleton HostbillCommon instance.
     *
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
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
     * method is used to validate view rDNS for VPS
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $request
     */
    public function validate_doViewrDns($request) {

        $input = array(
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? trim($request["account_id"]) : null;
        
        if (isset($input["account_id"])) {
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doViewrDns)__ account id Missing.";
        }
        
        return $input;
    }
    
    
    /**
     * Method is used to view rDns for VPS
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $request
     * 
     */
    public function doViewrDns($request) {
        
        $aView = array();
        $raiseError = 0;
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doViewrDns($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            $aView = HostbillDao::singleton()->findPtrInfoByAccountId($input['account_id']);
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doViewrDns",
            "view" => $aView
        );
        
        return $aResponse;
    }
    
    
    
    /**
     * 
     * method is used to validate update rDNS for VPS
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $request
     */
    public function validate_doUpdaterDns($request) {

        $input = array(
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? trim($request["account_id"]) : null;
        $input["ptr"] = (isset($request["ptr"]) && $request["ptr"] != "") ? $request["ptr"] : array();
        
        if (isset($input["account_id"])) {
            if (count($input["ptr"])>0) {
                
                // Validate Struct aPtr.
                $input['aPtr'] = array();
                for ($i=0;$i<count($input["ptr"]);$i++) {
                    if (isset($input["ptr"][$i]['name']) && isset($input["ptr"][$i]['value'])) {
                        
                        @preg_match('/\[(.*?)+\]/', $input["ptr"][$i]['name'], $aMatch);
                        @preg_match('/\[\w+\]/', $input["ptr"][$i]['name'], $aMatch1);
                        
                        if (isset($aMatch[0]) && isset($aMatch1[0])) {
                            $key1 = @preg_replace('/[\[\]]/', '', $aMatch[0]);
                            $key2 = @preg_replace('/[\[\]]/', '', $aMatch1[0]);
                            
                            $input['aPtr'][$key1][$key2] = trim($input["ptr"][$i]['value']);
                        }
                    }
                }
                                
                if (count($input['aPtr'])>0) {
                    
                    foreach ($input['aPtr'] as $key => $value) {
                        
                        // Debug Here..
                        /// Code.
                        
                        /*
                        // Ptr Content
                        if (isset($input['aPtr'][$key]['ptrcontent']) && $input['aPtr'][$key]['ptrcontent'] != '') {
                        } else {
                            $input["isValid"] = false;
                            $input["raiseError"] = "__(validate_doUpdaterDns)__ IP " . $key . " Unable to load related .in-addr.arpa zone.";
                            break;
                        }
                        */
                        
                        // Ptr Zone
                        if (isset($input['aPtr'][$key]['ptrzone']) && $input['aPtr'][$key]['ptrzone'] != '') {
                        } else {
                            $input["isValid"] = false;
                            $input["raiseError"] = "__(validate_doUpdaterDns)__ ptr zone Missing.";
                            break;
                        }
                        
                        // Ptr Arpa
                        if (isset($input['aPtr'][$key]['arpa']) && $input['aPtr'][$key]['arpa'] != '') {
                        } else {
                            $input["isValid"] = false;
                            $input["raiseError"] = "__(validate_doUpdaterDns)__ .in-addr.arpa Missing.";
                            break;
                        }
                        
                        // Ipam ID
                        if (isset($input['aPtr'][$key]['ipamid']) && $input['aPtr'][$key]['ipamid'] != '') {
                        } else {
                            $input["isValid"] = false;
                            $input["raiseError"] = "__(validate_doUpdaterDns)__ ipam id Missing.";
                            break;
                        }
                        
                        // Server ID
                        if (isset($input['aPtr'][$key]['sid']) && $input['aPtr'][$key]['sid'] != '') {
                        } else {
                            $input["isValid"] = false;
                            $input["raiseError"] = "__(validate_doUpdaterDns)__ server id Missing.";
                            break;
                        }
                        
                    }
                    
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doUpdaterDns)__ PTR Struct Fail.";
                }
                
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doUpdaterDns)__ PTR Missing.";
            }
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doUpdaterDns)__ account id Missing.";
        }
        
        return $input;
    }
    
    
    /**
     * Method is used to update rDNS for VPS
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $request
     * 
     */
    public function doUpdaterDns($request) {
        
        try {
            
            // Validate
            $input = HostbillCommon::singleton()->validate_doUpdaterDns($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }

            
            // ที่ ipam เช็คก่อนว่า มีหรือเปล่า ถ้ามี update ถ้าไม่มีไม่ต้องทำไร 'revdns'
            // ที่ power dns 'records' เช็คก่อนว่ามีหรือเปล่า ถ้ามี  update ถ้าไม่มี insert
            // insert log
            // ที่ account แสดง rvdns ที่ vps
                        
            if (count($input['aPtr'])>0) {
                
                foreach ($input['aPtr'] as $key => $value) {
              
                    // Continue loop for PTR content is NULL, PRT content not change      
                    if ($input['aPtr'][$key]['ptrcontent'] == ''
                        || $input['aPtr'][$key]['ptrcontent'] == $input['aPtr'][$key]['oldptrcontent']) {
                        continue;
                    }
          
                    // Update rDNS Table 'hb_ipam'
                    HostbillDao::singleton()->updateIpamrDNSByIpamId($input['aPtr'][$key]['ipamid'], $input['aPtr'][$key]['ptrcontent']); 
                        
                        
                    // Update PowerDNS
                    HostbillDao::singleton()->replacePowerDnsRecords(
                        $input['aPtr'][$key]['ptrid'],
                        $input['aPtr'][$key]['ptrzone'], 
                        $input['aPtr'][$key]['arpa'], 
                        $input['aPtr'][$key]['ptrcontent']
                    );
                        
                    
                    // Insert IPAM Logs. Table 'hb_ipam_logs'
                    require_once(APPDIR . 'class.general.custom.php');
                    require_once(APPDIR . 'class.api.custom.php');
                        
                    $adminUrl = GeneralCustom::singleton()->getAdminUrl();
                    $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
                        
                    $chageby = '';
                    if (isset($_SESSION['AppSettings']['admin_login']['username'])
                       && $_SESSION['AppSettings']['admin_login']['username'] != '') {
                                            
                        $chageby = $_SESSION['AppSettings']['admin_login']['username'];
                    } else if (isset($_SESSION['AppSettings']['login']['email'])
                        && $_SESSION['AppSettings']['login']['email']) {
                                        
                        $chageby = $_SESSION['AppSettings']['login']['email'];
                    }
                        
                    $post = array(
                        'call' => 'module',
                        'module' => 'billingcycle',
                        'fn' => 'addIpamLogs',
                        'type' => 'ip',
                        'item_id' => $input['aPtr'][$key]['ipamid'],
                        'item_name' => $key,
                        'log' => $key . " - revdns changed to " . $input['aPtr'][$key]['ptrcontent'],
                        'chageby' => $chageby
                    );
                    $apiCustom->request($post);
                        
                }
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Update rDNS for VPS Success."],"STACK":0} -->';
        exit;
        
        return true;
    }
    
    
    
}