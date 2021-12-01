<?php

class billingcycle_controller extends HBController {
    
    
    /**
     * Add Ipam Logs
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return TRUE
     * 
     * @example 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'addIpamLogs',
     *       'type' => 'ip',
     *       'item_id' => '4158',
     *       'item_name' => '203.78.110.61',
     *       'log' => "Ip 203.78.110.61 - revdns changed 'free2.hostingfree.in.th' to 'free.hostingfree.in.th'",
     *       'date' => '2013-12-16 17:09:16',
     *       'chageby' => 'admin@netway.co.th'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     */
    public function addIpamLogs($request) {
        
        $type = (isset($request['type']) && $request['type'] != "") ? $request['type'] : 'ip';
        $item_id = (isset($request['item_id']) && $request['item_id'] != "") ? $request['item_id'] : null;
        $item_name = (isset($request['item_name']) && $request['item_name'] != "") ? $request['item_name'] : null;
        $log = (isset($request['log']) && $request['log'] != "") ? $request['log'] : null;
        $date = (isset($request['date']) && $request['date'] != "") ? $request['date'] : date("Y-m-d H:i:s");
        $chageby = (isset($request['chageby']) && $request['chageby'] != "") ? $request['chageby'] : '';
                
        $db = hbm_db();
        
        if (isset($item_id) && isset($item_name) && isset($log)) {
            
            
            $query = sprintf("   
                        INSERT INTO
                            %s (`%s`, `%s`, `%s`, `%s`, `%s`, `%s`)
                        VALUES
                            ('%s', '%s', '%s', '%s', '%s', '%s')
                       "
                       , "hb_ipam_logs"
                       , "type"
                       , "item_id"
                       , "item_name"
                       , "log"
                       , "date"
                       , "changedby"
                       , $type
                       , $item_id
                       , $item_name
                       , $log
                       , $date
                       , $chageby
            );
                    
            $db->query($query);            
        }
        
        return array(true, array(
            'isValid' => true,
            'resError' => ''
        ));
        
    }
    
    
    /**
     * Update Hostname Dedicate, VPS, VPS Clound
     * Fix: Connect App 'App Zabbix' server_id=62
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return ARRAY
     * 
     * @example
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'updateHostnamerDNS'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     */
    public function updateHostnamerDNS($request) {
        
        $db = hbm_db();
        $raiseData = array(
            'not_rDNS' => array(
                'account_id' => array(),
                'domain' => array(),
            ),
            'same_rDNS' => array(
                'account_id' => array(),
                'domain' => array(),
                'ip' => array()
            ),
            'not_same_rDNS' => array(
                'account_id' => array(),
                'domain' => array(),
                'ip' => array(),
                'rDNS' => array()
            )
        );
        
        $query = sprintf("   
                        SELECT
                            hbacc.id, hbacc.domain, hbvps.ip
                        FROM 
                            %s hbacc,
                            %s hbvps
                        WHERE
                            hbacc.server_id='62'
                        AND
                            hbacc.domain!=''
                        AND
                            hbacc.status='Active'                            
                        AND
                            hbvps.ip!=''
                        AND
                            hbacc.id=hbvps.account_id                                
                        "
                        , "hb_accounts"
                        , "hb_vps_details"
                    );
                    
        $aRes = $db->query($query)->fetchAll();
        
        if (count($aRes)>0) {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]['id']) && $aRes[$i]['id'] != ''
                    && isset($aRes[$i]['domain']) && $aRes[$i]['domain'] != ''
                    && isset($aRes[$i]['ip']) && $aRes[$i]['ip'] != '') {
                    
                    $account_id = $aRes[$i]['id'];
                    $domain = $aRes[$i]['domain'];
                    $ip = $aRes[$i]['ip'];
                                         
                    $rDns = gethostbyaddr($ip);
                    if ($rDns == $ip) {
                        array_push($raiseData['not_rDNS']['account_id'], $account_id);
                        array_push($raiseData['not_rDNS']['domain'], $domain);
                        array_push($raiseData['not_rDNS']['ip'], $ip);
                    } else {
                        
                        if ($rDns == $aRes[$i]['domain']) {
                            array_push($raiseData['same_rDNS']['account_id'], $account_id);
                            array_push($raiseData['same_rDNS']['domain'], $domain);
                            array_push($raiseData['same_rDNS']['ip'], $ip);
                        } else {
                            array_push($raiseData['not_same_rDNS']['account_id'], $account_id);
                            array_push($raiseData['not_same_rDNS']['domain'], $domain);
                            array_push($raiseData['not_same_rDNS']['ip'], $ip);
                            array_push($raiseData['not_same_rDNS']['rDNS'], $rDns);
                            
                            $query = sprintf("   
                                        UPDATE
                                            %s
                                        SET
                                            domain='%s'
                                        WHERE
                                            id='%s'                            
                                        "
                                        , "hb_accounts"
                                        , $rDns
                                        , $account_id
                                    );
                            $db->query($query);
                    
                        }
                    }
                    
                    
                }
            }
        }
        
        return array(true, array(
            'isValid' => true,
            'raiseError' => '',
            'raiseData' => $raiseData
        ));
    }
    
    /**
     * Get Api Access
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return ARRAY
     * 
     * @example
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'getApiAccess'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     */
    public function getApiAccess($request) {
        
        $serverAddress = (isset($_SERVER['SERVER_ADDR']) && $_SERVER['SERVER_ADDR'] != "") ? $_SERVER['SERVER_ADDR'] : null;
        $aConf = array(
            'api_id' => '',
            'api_key' => ''
        );
        
        if (isset($serverAddress)) {
            
            $db = hbm_db();
            
            $query = sprintf("   
                        SELECT
                            hbapi.api_id,
                            hbapi.api_key
                        FROM
                            %s hbapi
                        WHERE
                            hbapi.ip='%s'
                        "
                        , "hb_api_access"
                        , $serverAddress
                    );
                    
            $aRes = $db->query($query)->fetchAll();
            
            if (count($aRes)>0) {
                $aConf['api_id'] = (isset($aRes[0]["api_id"]) && $aRes[0]["api_id"] != '') ? $aRes[0]["api_id"] : '';
                $aConf['api_key'] = (isset($aRes[0]["api_key"]) && $aRes[0]["api_key"] != '') ? $aRes[0]["api_key"] : '';
            }
            
        }
        
        return array(true, array(
            'isValid' => true,
            'raiseError' => '',
            'raiseData' => $aConf
        ));
    }
    
    
    /**
     * Add Free DNS Services
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return BOOLEAN true or false
     * 
     * @example
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'addFreeDNSServices',
     *       'clientID' => '13829'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     */
    public function addFreeDNSServices($request) {
        
        $clientID = (isset($request['clientID']) && $request['clientID'] != "") ? $request['clientID'] : null;
        $res = false;
        
        if (isset($clientID)) {
            
            $db = hbm_db();
    
            $aRes = $db->query("
                            SELECT 
                                hba.id
                            FROM
                                hb_accounts hba
                            WHERE
                                hba.client_id = :ClientID
                                AND hba.product_id = '121'
                            ", array(
                                ':ClientID'=> $clientID
                               )
                    )->fetch();
                             
            $isFreeDNSServices = (count($aRes)>0 && isset($aRes['id'])) ? true : false;   
            
            if ($isFreeDNSServices === true) {
            } else {
                
                /* Use this method to access HostBill api from HostBill modules http://api.hostbillapp.com/orders/addOrder/ */
                $api = new ApiWrapper();
                $params = array(
                    'client_id' => $clientID,
                    'product' => '121', // FIX Product ID 121 
                    'cycle' => 'Free'
                    // 'confirm' => CONFIRM,
                    // 'invoice_generate' => 1,
                    // 'invoice_info' => INVOICE_INFO
                );
                $aRes = $api->addOrder($params);
                
                if (count($aRes)>0 && isset($aRes['success']) && $aRes['success'] == 1 && isset($aRes['order_id']) && $aRes['order_id'] != '') {
                    $params = array(
                        'id' => $aRes['order_id']
                    );
                    $aRes = $api->setOrderActive($params);
                    $res = (count($aRes)>0 && isset($aRes['success']) && $aRes['success'] == 1) ? true : false;
                }
                
            }
            
        }
        
        return array(true, array(
            'isValid' => $res,
            'resError' => ''
        ));
    }
    
    /**
     * Add Domain Logs
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return TRUE
     * 
     * @example 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'addDomainLogs',
     *       'domain_id' => '6856',
     *       'result' => '0',
     *       'action_' => 'Hook After Domain Register',
     *       'error' => 'DNS entry for xxxx.net already exists. NS not in my nameservers.'
     * );
     * 
     * OR
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'addDomainLogs',
     *       'domain_id' => '6856',
     *       'result' => '1',
     *       'action_' => 'Hook After Domain Register',
     *       'change_' => 'Create DNS Zone'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     */
    public function addDomainLogs($request) {
        
        $domain_id = (isset($request['domain_id']) && $request['domain_id'] != "") ? $request['domain_id'] : null;
        $admin_login = (isset($request['admin_login']) && $request['admin_login'] != "") ? $request['admin_login'] : 'Automation';
        $date = (isset($request['date']) && $request['date'] != "") ? $request['date'] : date("Y-m-d H:i:s");
        $module_ = (isset($request['module_'])) ? $request['module_'] : '(empty)';
        $action_ = (isset($request['action_'])) ? $request['action_'] : '(empty)';
        $result = (isset($request['result']) && $request['result'] != "") ? $request['result'] : null; // 1 Success, 0 Failure
        $change_ = (isset($request['change_']) && $request['change_'] != "") 
            ?  'a:2:{s:10:"serialized";b:0;s:4:"data";s:' . strlen($request['change_']) . ':"' . $request['change_'] . '";}' 
            : '';
        $error = (isset($request['error'])) ? $request['error'] : '';
        $event = (isset($request['event'])) ? $request['event'] : '(empty)';
        
        $db = hbm_db();
        
        if (isset($domain_id) && isset($result)) {
            
            
            $query = sprintf("   
                        INSERT INTO
                            %s (`%s`, `%s`, `%s`, `%s`, `%s`, `%s`, `%s`, `%s`, `%s`)
                        VALUES
                            ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')
                       "
                       , "hb_domain_logs"
                       , "domain_id"
                       , "admin_login"
                       , "date"
                       , "module"
                       , "action"
                       , "result"
                       , "change"
                       , "error"
                       , "event"
                       , $domain_id
                       , $admin_login
                       , $date
                       , $module_
                       , $action_
                       , $result
                       , $change_
                       , $error
                       , $event
            );
                    
            $db->query($query);            
        }
        
        return array(true, array(
            'isValid' => true,
            'resError' => ''
        ));
    }
    
    
    /**
     * Create DNS Zone If Not DNS Zone After Update Name Server
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return BOOLEAN true or false
     * 
     * @example 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'updateNameServer',
     *       'domainName' => 'simbi4.net.zz'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     */
    public function updateNameServer($request) {
        
        $domainName = (isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $res = true;
        
        if (isset($domainName)) {
            
            require_once(APPDIR . 'class.general.custom.php');
            require_once(APPDIR . 'class.api.custom.php');
      
            $adminUrl = GeneralCustom::singleton()->getAdminUrl();
            $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
            
            $post = array(
                   'call' => 'module',
                   'module' => 'billingcycle',
                   'fn' => 'isMyNsRecordByDomainName',
                   'domainName' => $domainName
            );
            $aRes = $apiCustom->request($post);
            $isNsRecords = $aRes['isValid'];
            
            if ($isNsRecords === true) {
                
                $post = array(
                       'call' => 'module',
                       'module' => 'billingcycle',
                       'fn' => 'isMyZoneByDomainName',
                       'domainName' => $domainName
                );
                $aRes = $apiCustom->request($post);
                $isDnsZone = $aRes['isValid'];
                
                if ($isDnsZone === true) {
                } else {
                    
                    $post = array(
                           'call' => 'module',
                           'module' => 'billingcycle',
                           'fn' => 'isOrderHostingAccountByDomainName',
                           'domainName' => $domainName
                    );
                    $aRes = $apiCustom->request($post);
                    $isOrderHostingAccount = $aRes['isValid'];
                    
                    if ($isOrderHostingAccount === true) {
                        // ให้ hosting account create host, DNS Zone แทน
                    } else {
                        
                        // Create DNS Zone
                        $post = array(
                               'call' => 'module',
                               'module' => 'billingcycle',
                               'fn' => 'createDNSZone',
                               'domainName' => $domainName
                        );
                        $aRes = $apiCustom->request($post);
                        $res = $aRes['isValid'];
                        
                        if ($res === true) {
                            
                            // Info Logs
                            $post = array(
                                'call' => 'module',
                                'module' => 'billingcycle',
                                'fn' => 'addDomainLogs',
                                'domain_id' => $domainID,
                                'result' => '1',
                                'action_' => 'Updatenameservers',
                                'change_' => 'Create DNS Zone.'
                            );
                            $apiCustom->request($post);
                            
                        } else {
                            
                            // Error. Cannot Create DNS Zone
                            $post = array(
                                'call' => 'module',
                                'module' => 'billingcycle',
                                'fn' => 'addDomainLogs',
                                'domain_id' => $domainID,
                                'result' => '0',
                                'action_' => 'Updatenameservers',
                                'error' => 'Cannot Create DNS Zone ' . $domainName . ' Please contact SYS.'
                            );
                            $apiCustom->request($post);
                            
                        }
                        
                        
                    }
                    
                }
            }
            
            
        }
        
        return array(true, array(
            'isValid' => $res,
            'resError' => ''
        ));
    }
    
    /**
     * Create DNS Zone
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return BOOLEAN true or false
     * 
     * @example 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'createDNSZone',
     *       'domainName' => 'simbi4.net.zz'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     * 
     */
    public function createDNSZone($request) {
        
        $domainName = (isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $db = hbm_db();
        $res = false;
        
        if (isset($domainName)) {
            
            $query = sprintf("   
                        SELECT
                            hbmc.config
                        FROM
                            %s hbmc
                        WHERE
                            hbmc.module='cpaneldnszonehandle'
                        "
                        , "hb_modules_configuration"
                    );
                    
            $aRes = $db->query($query)->fetchAll();
        
            $aConf = (count($aRes) > 0 && isset($aRes[0]["config"])) ? unserialize($aRes[0]["config"]) : array();
            if (count($aConf)>0 
                && isset($aConf['DNS Server3 IP']['value']) && $aConf['DNS Server3 IP']['value'] != ''
                && isset($aConf['IP Park']['value']) && $aConf['IP Park']['value'] != ''
                && isset($aConf['DNS Server3 WHM Username']['value']) && $aConf['DNS Server3 WHM Username']['value'] != ''
                && isset($aConf['DNS Server3 WHM Hash']['value']) && $aConf['DNS Server3 WHM Hash']['value'] != '') {
                
                if (function_exists('curl_init')) {

                    $user = $aConf['DNS Server3 WHM Username']['value'];
                    $ipPark = $aConf['IP Park']['value'];
                    $dnsServer = $aConf['DNS Server3 IP']['value'];
                    $remoteAccesskey = $aConf['DNS Server3 WHM Hash']['value'];
                    
                    $cleanaccesshash = preg_replace("'(\r|\n)'","", $remoteAccesskey);
                    $authstr = $user . ":" . $cleanaccesshash;
        
                    
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    curl_setopt($ch, CURLOPT_URL, 'https://' . $dnsServer . ':2087/json-api/adddns?domain=' . $domainName . '&ip=' . $ipPark);
                        
                    curl_setopt($ch, CURLOPT_HEADER, 0);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                    $curlheaders[0] = "Authorization: WHM $authstr";
                    $curlheaders[1] = "Referer: " . $referer;
                    curl_setopt($ch, CURLOPT_HTTPHEADER, $curlheaders);
                    $output = curl_exec($ch);
                    curl_close($ch);
                    
                    $aOutput = json_decode($output);
                    if (isset($aOutput->result[0]->status) && $aOutput->result[0]->status == 1) {
                        $res = true;
                    }
                         
                }
                
            }
        }
        
        return array(true, array(
            'isValid' => $res,
            'resError' => ''
        ));
        
    }
    
    /**
     * Is My Zone In My DNS
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return BOOLEAN true or false
     * 
     * @example 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'isMyZoneByDomainName',
     *       'domainName' => 'thairadio.com'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     * Array ( [isValid] => true [call] => module [server_time] => 1383047607 )
     * print res['isValid'];
     * 
     */
    public function isMyZoneByDomainName($request) {

        $domainName = (isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $db = hbm_db();
        $res = false;
        
        if (isset($domainName)) {
            
            $query = sprintf("   
                        SELECT
                            hbmc.config
                        FROM
                            %s hbmc
                        WHERE
                            hbmc.module='cpaneldnszonehandle'
                        "
                        , "hb_modules_configuration"
                    );
                    
            $aRes = $db->query($query)->fetchAll();
        
            $aConf = (count($aRes) > 0 && isset($aRes[0]["config"])) ? unserialize($aRes[0]["config"]) : array();
            if (count($aConf)>0 
                && isset($aConf['DNS Server1 IP']['value']) && $aConf['DNS Server1 IP']['value'] != ''
                && isset($aConf['DNS Server1 WHM Username']['value']) && $aConf['DNS Server1 WHM Username']['value'] != ''
                && isset($aConf['DNS Server1 WHM Hash']['value']) && $aConf['DNS Server1 WHM Hash']['value'] != '') {

                if (function_exists('curl_init')) {

                    $user = $aConf['DNS Server1 WHM Username']['value'];
                    $dnsServer = $aConf['DNS Server1 IP']['value'];
                    $remoteAccesskey = $aConf['DNS Server1 WHM Hash']['value'];
                    
                    $cleanaccesshash = preg_replace("'(\r|\n)'","", $remoteAccesskey);
                    $authstr = $user . ":" . $cleanaccesshash;
        
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    curl_setopt($ch, CURLOPT_URL, 'https://' . $dnsServer . ':2087/xml-api/listzones');
                        
                    curl_setopt($ch, CURLOPT_HEADER, 0);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
                    $curlheaders[0] = "Authorization: WHM $authstr";
                    $curlheaders[1] = "Referer: " . $referer;
                    curl_setopt($ch, CURLOPT_HTTPHEADER, $curlheaders);
                    $output = curl_exec($ch);
                    curl_close($ch);
                    
                    $xml = simplexml_load_string($output);
                    foreach ($xml->zone as $value) {
                        $aDomains = (array) $value;
                        if (isset($aDomains['domain']) && $aDomains['domain'] != '') {
                            if ($domainName == $aDomains['domain']) {
                                $res = true;
                                break;
                            }
                        }
                    }            
                }
                
            }
            
        }
        
        return array(true, array(
            'isValid' => $res,
            'resError' => ''
        ));
    }
    
    /**
     * Is NS Records In My DNS
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $request
     * @return BOOLEAN true or false
     * 
     * @example 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'isMyNsRecordByDomainName',
     *       'domainName' => 'thairadio.com'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     * Array ( [isOrderHosting] => true [call] => module [server_time] => 1383047607 )
     * print res['isOrderHosting'];
     */
    public function isMyNsRecordByDomainName($request) {
        
        $domainName = (isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $res = false;
        
        if (isset($domainName)) {
            $aRes = dns_get_record($domainName, DNS_NS);
            if (count($aRes)>0) {
                for ($i=0;$i<count($aRes);$i++) {
                    $nameServer = $aRes[$i]['target'];
                    if (isset($nameServer) && $nameServer != '') {
                        if (preg_match('/ns1.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns2.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns3.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns4.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns1.thaidomainname.com/i', $nameServer)
                           || preg_match('/ns2.thaidomainname.com/i', $nameServer)
                           || preg_match('/ns.thaidns.net/i', $nameServer)
                           || preg_match('/ns1.thaidns.net/i', $nameServer)
                           || preg_match('/ns1.netway.co.th/i', $nameServer)
                           || preg_match('/ns2.netway.co.th/i', $nameServer)
                           || preg_match('/ns1.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns2.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns3.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns4.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns9.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns10.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns1.hostingfree.in.th/i', $nameServer)
                           || preg_match('/ns2.hostingfree.in.th/i', $nameServer)
                           || preg_match('/ns3.thaihostunlimited.com/i', $nameServer)
                           || preg_match('/ns4.thaihostunlimited.com/i', $nameServer)
                       ) {
                           // My Zone
                           $res = true;
                       } else {
                           $res = false;
                           break;
                       }
                    }
                }
            }
        }
        
        return array(true, array(
            'isValid' => $res,
            'resError' => ''
        ));
        
    }
    
    
    /**
     * Is Order Hosting Account Search By Domain Name
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $require
     * @return BOOLEAN true or false
     * @example 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'isOrderHostingAccountByDomainName',
     *       'domainName' => 'jija.net.zz'
     * );
     * 
     * $res = $apiCustom->request($post);
     * print_r($res);
     * Array ( [isValid] => true [call] => module [server_time] => 1383047607 )
     * print res['isValid'];
     */
    public function isOrderHostingAccountByDomainName($request) {
        
        $domainName = (isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $db = hbm_db();
        $res = false;
        
        if (isset($domainName)) {
            $query = sprintf("   
                        SELECT
                            hba.id
                        FROM
                            %s hba,
                            %s hbs,
                            %s hbsg
                        WHERE
                            hba.domain='%s'
                        AND
                            hba.server_id=hbs.id
                        AND
                            hbs.group_id=hbsg.id
                        AND
                            hbsg.name='Cpanel'
                        "
                        , "hb_accounts"
                        , "hb_servers"
                        , "hb_server_groups"
                        , $domainName
                    );
                    
            $aRes = $db->query($query)->fetchAll();
        
            $res = (count($aRes) > 0 && isset($aRes[0]["id"])) ? true : false;
        }
        
        return array(true, array(
            'isValid' => $res,
            'resError' => ''
        ));
    }
    
    /**
     * 
     * Get Main IP From IPAM
     * 
     * @author puttipong at rvglobalsoft.com
     * @param $accountID
     * @return STRING IPAM or NULL
     * @example
     * 
     * 
     * require_once(APPDIR . 'class.general.custom.php');
     * require_once(APPDIR . 'class.api.custom.php');
     *   
     * $adminUrl = GeneralCustom::singleton()->getAdminUrl();
     * $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
     * 
     * $post = array(
     *       'call' => 'module',
     *       'module' => 'billingcycle',
     *       'fn' => 'getMainIpFromIpam',
     *       'accountID' => '873'
     * );
     * $res = $apiCustom->request($post);
     * print_r($res);
     * Array ( [ip] => 203.78.109.21 [call] => module [server_time] => 1383047607 )
     * print res['ip'];
     * 
     */
    public function getMainIpFromIpam($request) {
        
        $accountID = (isset($request['accountID']) && $request['accountID'] != "") ? $request['accountID'] : null;
        $ip = null;
        $db = hbm_db();
        
        if (isset($accountID)) {
            
            // หาจาก main ip
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
                    
            $aRes = $db->query($query)->fetchAll();
        
            $ip = (count($aRes) > 0 && isset($aRes[0]["ip"]) && $aRes[0]["ip"] != "") ? $aRes[0]["ip"] : null;
        
            if (isset($ip)) {
            } else {
                
                $aIp = array();
                
                // หาจาก IPAM
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
              
                    
                    $aRes = $db->query($query)->fetchAll();
                    if (count($aRes)>0) {
                        for ($i=0;$i<count($aRes);$i++) {
                            if (isset($aRes[$i]["ipaddress"])) {
                                array_push($aIp, long2ip($aRes[$i]["ipaddress"]));
                            }
                        }
                        $ip = (isset($aIp[0]) && $aIp[0] != "") ? $aIp[0] : null;
                    }      
                
                
            }
            
            
            if (isset($ip)) {
            } else {
                
                // หาจาก Config 2 Account กรณีที่เป็น Field type
                $query = sprintf("   
                        SELECT
                            c2a.data
                        FROM 
                            %s c2a,
                            %s cic
                        WHERE
                            c2a.account_id='%s'
                        AND
                            c2a.config_cat=cic.id
                        AND
                            cic.name='IP address'                
                        "
                        , "hb_config2accounts"
                        , "hb_config_items_cat"
                        , $accountID
                    );

                $aRes = $db->query($query)->fetchAll();
                
                $ip = (count($aRes) > 0 && isset($aRes[0]["data"]) && $aRes[0]["data"] != "") ? trim($aRes[0]["data"]) : null;
                                    
            }
        
        }
        
        
        return array(true, array(
            'ip' => $ip
        ));
        
    }
    
    public function getAccountExpiryDate ($request)
    {
        
        $db         = hbm_db();
        
        $expire         = '';
        $stmpExpire     = 0;
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $nextDue        = isset($request['nextDue']) ? strtotime($request['nextDue']) : 0;
        
        if ( ! $accountId) {
            return false;
        }
        
        $aInvoice       = $db->query("
                        SELECT ii.description, ii.invoice_id
                        FROM 
                            hb_invoices i,
                            hb_invoice_items ii
                        WHERE 
                            i.id = ii.invoice_id
                            AND i.status = 'Paid'
                            AND ii.type = 'Hosting'
                            AND ii.item_id = :itemId
                        ORDER BY i.id DESC
                        ", array(
                            ':itemId'   => $accountId
                        ))->fetch();
        
        $color      = '';
        
        if (isset($aInvoice['description'])) {
            preg_match('/\-\s(\d{2}\s[a-zA-Z]{3}\s\d{4})/', $aInvoice['description'], $matches);
            $expire     = isset($matches[1]) ? $matches[1] : '';
            if (! $expire) {
                preg_match('/-\s*(\d{1,2}\/\d{1,2}\/\d{4})/', $aInvoice['description'], $matches);
                $expire     = isset($matches[1]) ? $matches[1] : '';
            }
            if ($expire) {
                $stmpExpire     = self::_convertStrtotime($expire);
                $color          = (($nextDue - $stmpExpire) > (60*60*24*1)) ? 'red' : '';
            }
            
            /* --- ครอบคลุมการ upgrade --- */
            $invoiceId      = $aInvoice['invoice_id'];
            $result         = self::_getInvoiceAccountUpgrade($accountId, $invoiceId, $nextDue);
            if ($result['expire']) {
                $expire     = $result['expire'];
                $stmpExpire = $result['stmpExpire'];
                $color      = $result['color'];
            }
        }
        
        return array(true, array(
            'expire'            => $expire,
            'expireTimeStamp'   => $stmpExpire,
            'color'             => $color
        ));
    }
    
    /**
     * ดูวันหมดอายุของ service ครอบคลุมการ upgrade
     */
    private function _getInvoiceAccountUpgrade ($accountId, $invoiceId, $nextDue)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT
                ii.description
            FROM
                hb_upgrades u,
                hb_invoice_items ii,
                hb_invoices i
            WHERE
                ii.invoice_id > :invoiceId
                AND ii.type = 'Upgrade'
                AND ii.invoice_id = i.id
                AND i.status = 'Paid'
                AND ii.item_id = u.id
                AND u.rel_type = 'Hosting'
                AND u.account_id = :accountId
            ORDER BY i.id DESC
            ", array(
                ':invoiceId'    => $invoiceId,
                ':accountId'    => $accountId
            ))->fetch();
        
        if (! isset($result['description'])) {
            return array();
        }
        
        preg_match('/\-\s(\d{2}\s[a-zA-Z]{3}\s\d{4})/', $result['description'], $matches);
        $expire     = isset($matches[1]) ? $matches[1] : '';
        if (! $expire) {
            preg_match('/-\s*(\d{1,2}\/\d{1,2}\/\d{4})/', $aInvoice['description'], $matches);
            $expire     = isset($matches[1]) ? $matches[1] : '';
        }
        if ($expire) {
            $stmpExpire     = self::_convertStrtotime($expire);
            $color          = (($nextDue - $stmpExpire) > (60*60*24*1)) ? 'red' : '';
        }
        
        return array(
            'expire'        => $expire,
            'stmpExpire'    => $stmpExpire,
            'color'         => $color 
            );
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $aMonth     = array(
            'jan' => '1',
            'feb' => '2',
            'mar' => '3',
            'apr' => '4',
            'may' => '5',
            'jun' => '6',
            'jul' => '7',
            'aug' => '8',
            'sep' => '9',
            'oct' => '10',
            'nov' => '11',
            'dec' => '12',
        );

        if (preg_match('/(\d{2})\s([a-zA-Z]{3})\s(\d{4})/', $str, $matches)) {
            $d  = isset($matches[1]) ? $matches[1] : 00;
            $m  = ( isset($matches[2]) && isset($aMonth[strtolower($matches[2])]) ) ? $aMonth[strtolower($matches[2])] : 00;
            $y  = isset($matches[3]) ? $matches[3] : 0000;
            return strtotime($y .'-'. $m .'-'. $d);
        }

        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
    
}
