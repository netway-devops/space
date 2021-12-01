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
    
    
    public function replacePowerDnsRecords($ptrID="", $ptrZone="", $ptrArpa="", $ptrContent="") {
        
        $isInsert = false;
        $aRecords = array();
        
        $dbpw = Database::singleton();
        $aResConn = $dbpw->connect_pwdns();
        
        if ($ptrID == "") {
            
            $query = sprintf("   
                        SELECT
                            rec.id
                        FROM 
                            %s rec
                        WHERE
                            rec.name='%s' 
                        "
                        , "records"
                        , $ptrArpa
                    );
                    
            $aRecords = $dbpw->fetch_all_array($query);
                 
        } else {
            
            $query = sprintf("   
                        SELECT
                            rec.id
                        FROM 
                            %s rec
                        WHERE
                            rec.name='%s'
                        AND
                            rec.id='%s' 
                        "
                        , "records"
                        , $ptrArpa
                        , $ptrID
                    );
                    
            $aRecords = $dbpw->fetch_all_array($query);
            
        }
        
        
        if (count($aRecords)>0 && isset($aRecords[0]['id']) && $aRecords[0]['id'] != '') {
            
            // Update
            $query = sprintf("   
                                UPDATE
                                    %s
                                SET
                                    content='%s'
                                WHERE
                                    id='%s'                            
                                "
                                , "records"
                                , $ptrContent
                                , $aRecords[0]['id']
                        );
                        
            $dbpw->query($query);
            
        } else {
            
            /*
            +-----+-----------+----------------------------+------+--------------------------------+-------+------+-------------+
            | id  | domain_id | name                       | type | content                        | ttl   | prio | change_date |
            +-----+-----------+----------------------------+------+--------------------------------+-------+------+-------------+
            | 702 |        13 | 108.97.78.203.in-addr.arpa | PTR  | 1test_atstest.atsolution.co.th | 14400 |    0 |  1381252833 | 
            +-----+-----------+----------------------------+------+--------------------------------+-------+------+-------------+
            */
            
            // Insert
            $query = sprintf("   
                        INSERT INTO
                            %s (`%s`, `%s`, `%s`, `%s`, `%s`, `%s`, `%s`)
                        VALUES
                            ('%s', '%s', '%s', '%s', '%s', '%s', '%s')
                       "
                       , "records"
                       , "domain_id"
                       , "name"
                       , "type"
                       , "content"
                       , "ttl"
                       , "prio"
                       , "change_date"
                       , $ptrZone
                       , $ptrArpa
                       , "PTR"
                       , $ptrContent
                       , "14400"
                       , "0"
                       , time()
            );
            
            $dbpw->query($query);
            
        }
        
        // $dbpw->close();
        
        return true;
    }
    
    
    public function updateIpamrDNSByIpamId($ipamID="", $rDNS="") {
        
        $query = sprintf("   
                        SELECT
                            ipa.id
                        FROM 
                            %s ipa
                        WHERE
                            ipa.id='%s' 
                        "
                        , "hb_ipam"
                        , $ipamID
                    );
        $aRes = $this->db->query($query)->fetchAll();
        
        if (count($aRes)>0) {
            // Update
            $query = sprintf("   
                                UPDATE
                                    %s
                                SET
                                    revdns='%s'
                                WHERE
                                    id='%s'                            
                                "
                                , "hb_ipam"
                                , $rDNS
                                , $ipamID
                        );
                        
            $this->db->query($query);
            
        }
        
        return true;
    }
    
    
    
    public function findPtrInfoByAccountId($accountID="") {
                
        $aPtrInfo = array(
            "isValid" => true,
            "raiseError" => '',
            "raiseMsgError" => ''
        );
        
        $dbpw = Database::singleton();
        $aResConn = $dbpw->connect_pwdns();
        if (isset($aResConn['isValid']) && $aResConn['isValid'] == false) {
            return $aResConn;
        }
        
        $query = sprintf("   
                        SELECT
                            vps.account_id, vps.ip, vps.additional_ip
                        FROM 
                            %s vps
                        WHERE
                            vps.account_id='%s'   
                        "
                        , "hb_vps_details"
                        , $accountID
                    );
        $aRes = $this->db->query($query)->fetchAll();
        
        // Validate Additional IP
        if (count($aRes)>0 && isset($aRes[0]['additional_ip']) && $aRes[0]['additional_ip'] != ''
            && isset($aRes[0]['account_id']) && $aRes[0]['account_id'] != ''
            && isset($aRes[0]['ip']) && $aRes[0]['ip'] != '') {
            
            $aExplodeAdditionIp = explode("|", $aRes[0]['additional_ip']);
            if (count($aExplodeAdditionIp)>0) {
                for ($i=0;$i<count($aExplodeAdditionIp);$i++) {
                    if ($aExplodeAdditionIp[$i] != '') {
                        $aAdditionIp = array(
                            'account_id' => $aRes[0]['account_id'],
                            'ip' => $aExplodeAdditionIp[$i],
                            'additional_ip' => $aRes[0]['additional_ip']
                        );
                        array_push($aRes, $aAdditionIp);
                    }
                }
            }
        }
        
//echo '<PRE>';
//print_r($aRes);
//exit;

        if (count($aRes)>0) {               
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]['ip']) && $aRes[$i]['ip'] != '') {
     
                    $aPtrInfo[$aRes[$i]['ip']]['ptrcontent'] = '';//$host;
                    $aPtrInfo[$aRes[$i]['ip']]['oldptrcontent'] = '';//$host;
                    $aPtrInfo[$aRes[$i]['ip']]['ipamid'] = '';
                    $aPtrInfo[$aRes[$i]['ip']]['sid'] = '';
                    $aPtrInfo[$aRes[$i]['ip']]['ptrid'] = '';
                    $aPtrInfo[$aRes[$i]['ip']]['ptrzone'] = '';
                    $aPtrInfo[$aRes[$i]['ip']]['arpa'] = '';
                    
                    $query = sprintf("   
                                    SELECT
                                        cast(conv(hex(ip.ipaddress), 16, 10) as unsigned integer) AS ipaddress
                                        , ip.id
                                        , ip.server_id
                                    FROM 
                                        %s ip                                  
                                    "
                                    , "hb_ipam"
                    );
                    $aRes1 = $this->db->query($query)->fetchAll();
                    if (count($aRes1)>0) {
                       for ($j=0;$j<count($aRes1);$j++) {
                           if (long2ip($aRes1[$j]['ipaddress']) == $aRes[$i]['ip']) {
                               $aPtrInfo[$aRes[$i]['ip']]['ipamid'] = $aRes1[$j]['id'];
                               $aPtrInfo[$aRes[$i]['ip']]['sid'] = $aRes1[$j]['server_id'];
                               break;
                           }
                       }
                    }
                    
                    
                    $aExplodeIp = explode(".", $aRes[$i]['ip']);
                    if (isset($aExplodeIp[0]) && $aExplodeIp[0] != ''
                        && isset($aExplodeIp[1]) && $aExplodeIp[1] != ''
                        && isset($aExplodeIp[2]) && $aExplodeIp[2] != ''
                        && isset($aExplodeIp[3]) && $aExplodeIp[3] != '') {
                        
                        $aPtrInfo[$aRes[$i]['ip']]['arpa'] = "$aExplodeIp[3].$aExplodeIp[2].$aExplodeIp[1].$aExplodeIp[0].in-addr.arpa";                    
                            
                        $query = sprintf("   
                                        SELECT
                                            re.id
                                            , re.domain_id
                                            , re.content
                                        FROM 
                                            %s re
                                        WHERE
                                           re.name='%s'
                                        AND
                                           re.type='PTR'                                   
                                        "
                                        , "records"
                                        , "$aExplodeIp[3].$aExplodeIp[2].$aExplodeIp[1].$aExplodeIp[0].in-addr.arpa"
                        );
                        $aRes1 = $dbpw->fetch_all_array($query);
                        
                        if (count($aRes1)>0 
                            && isset($aRes1[0]['id']) && $aRes1[0]['id'] != ''
                            && isset($aRes1[0]['domain_id']) && $aRes1[0]['domain_id'] != '') {
                            
                            $aPtrInfo[$aRes[$i]['ip']]['ptrcontent'] = $aRes1[0]['content'];
                            $aPtrInfo[$aRes[$i]['ip']]['oldptrcontent'] = $aRes1[0]['content'];
                            $aPtrInfo[$aRes[$i]['ip']]['ptrid'] = $aRes1[0]['id'];
                            $aPtrInfo[$aRes[$i]['ip']]['ptrzone'] = $aRes1[0]['domain_id'];
                            
                        } else {
                            
                            $query = sprintf("   
                                        SELECT
                                            dz.id
                                        FROM 
                                            %s dz
                                        WHERE
                                           dz.name='%s'                                  
                                        "
                                        , "domains"
                                        , "$aExplodeIp[2].$aExplodeIp[1].$aExplodeIp[0].in-addr.arpa"
                            );
                            $aRes1 = $dbpw->fetch_all_array($query);
                            if (count($aRes1)>0 && isset($aRes1[0]['id']) && $aRes1[0]['id'] != '') {
                                $aPtrInfo[$aRes[$i]['ip']]['ptrzone'] = $aRes1[0]['id'];
                            }
                            
                        }                           
                    }    
                }
            }
        }
        
        
/*        
        if (count($aRes)>0 && isset($aRes[0]['ip']) && $aRes[0]['ip'] != '') {
                         
            //$host = gethostbyaddr($aRes[0]['ip']);
            //if ($host == $aRes[0]['ip']) {
             //   $host = '';
            //}
            
            
            $aPtrInfo[$aRes[0]['ip']]['ptrcontent'] = '';//$host;
            $aPtrInfo[$aRes[0]['ip']]['oldptrcontent'] = '';//$host;
            $aPtrInfo[$aRes[0]['ip']]['ipamid'] = '';
            $aPtrInfo[$aRes[0]['ip']]['sid'] = '';
            $aPtrInfo[$aRes[0]['ip']]['ptrid'] = '';
            $aPtrInfo[$aRes[0]['ip']]['ptrzone'] = '';
            $aPtrInfo[$aRes[0]['ip']]['arpa'] = '';
            
            $query = sprintf("   
                            SELECT
                                cast(conv(hex(ip.ipaddress), 16, 10) as unsigned integer) AS ipaddress
                                , ip.id
                                , ip.server_id
                            FROM 
                                %s ip                                  
                            "
                            , "hb_ipam"
            );
            $aRes1 = $this->db->query($query)->fetchAll();
            if (count($aRes1)>0) {
               for ($i=0;$i<count($aRes1);$i++) {
                   if (long2ip($aRes1[$i]['ipaddress']) == $aRes[0]['ip']) {
                       $aPtrInfo[$aRes[0]['ip']]['ipamid'] = $aRes1[$i]['id'];
                       $aPtrInfo[$aRes[0]['ip']]['sid'] = $aRes1[$i]['server_id'];
                       break;
                   }
               }
            }
            
            
            $aExplodeIp = explode(".", $aRes[0]['ip']);
            if (isset($aExplodeIp[0]) && $aExplodeIp[0] != ''
                && isset($aExplodeIp[1]) && $aExplodeIp[1] != ''
                && isset($aExplodeIp[2]) && $aExplodeIp[2] != ''
                && isset($aExplodeIp[3]) && $aExplodeIp[3] != '') {
                
                $aPtrInfo[$aRes[0]['ip']]['arpa'] = "$aExplodeIp[3].$aExplodeIp[2].$aExplodeIp[1].$aExplodeIp[0].in-addr.arpa";                    
                    
                $query = sprintf("   
                                SELECT
                                    re.id
                                    , re.domain_id
                                    , re.content
                                FROM 
                                    %s re
                                WHERE
                                   re.name='%s'
                                AND
                                   re.type='PTR'                                   
                                "
                                , "records"
                                , "$aExplodeIp[3].$aExplodeIp[2].$aExplodeIp[1].$aExplodeIp[0].in-addr.arpa"
                );
                $aRes1 = $dbpw->fetch_all_array($query);
                
                if (count($aRes1)>0 
                    && isset($aRes1[0]['id']) && $aRes1[0]['id'] != ''
                    && isset($aRes1[0]['domain_id']) && $aRes1[0]['domain_id'] != '') {
                    
                    $aPtrInfo[$aRes[0]['ip']]['ptrcontent'] = $aRes1[0]['content'];
                    $aPtrInfo[$aRes[0]['ip']]['oldptrcontent'] = $aRes1[0]['content'];
                    $aPtrInfo[$aRes[0]['ip']]['ptrid'] = $aRes1[0]['id'];
                    $aPtrInfo[$aRes[0]['ip']]['ptrzone'] = $aRes1[0]['domain_id'];
                    
                } else {
                    
                    $query = sprintf("   
                                SELECT
                                    dz.id
                                FROM 
                                    %s dz
                                WHERE
                                   dz.name='%s'                                  
                                "
                                , "domains"
                                , "$aExplodeIp[2].$aExplodeIp[1].$aExplodeIp[0].in-addr.arpa"
                    );
                    $aRes1 = $dbpw->fetch_all_array($query);
                    if (count($aRes1)>0 && isset($aRes1[0]['id']) && $aRes1[0]['id'] != '') {
                        $aPtrInfo[$aRes[0]['ip']]['ptrzone'] = $aRes1[0]['id'];
                    }
                    
                }
                    
            }
            
            
            
        }

*/
        
        return $aPtrInfo;
    }    
    
}