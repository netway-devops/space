<?php

class dnsservicehandle_controller extends HBController {
    
	/**
	   require_once(APPDIR . 'class.general.custom.php');
	   require_once(APPDIR . 'class.api.custom.php');
	       
	   $adminUrl = GeneralCustom::singleton()->getAdminUrl();
	   $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
	   $post = array(
	           'call' => 'module',
	           'module' => 'dnsservicehandle',
	           'fn' => 'addDNSZoneSkipVerifyNs',
	           'domainName' => 'example.com',
	 		   'domainID'	=> $domainID
	   );
	   $aRes = $apiCustom->request($post)
	 */
	
	public function addDNSZoneSkipVerifyNs($request){
		
		$domainName = (isset($request['domainName']) && $request['domainName'] != '') ? $request['domainName'] : null;
		$domainID	= (isset($request['domainID']) && $request['domainID'] != '') ? $request['domainID'] : null;
		$do			=	(isset($request['do']) && $request['do'] != '') ? $request['do'] : '-';
		
		if (isset($domainName) && isset($domainID)){
			
			$response		=	self::haveHosting(array('domainName'	=>	$domainName));
			$haveHosting	=	$response[1]['isValid'];
			
			if($haveHosting){ //ถ้ามี Hosting account อยู่แล้ว
				$res 	=	false;
				$error	=	'ไม่ดำเนินการมี Hosting account อยู่แล้ว';
			}else{
				
				$response		=	self::haveDNSZone(array('domainName'	=>	$domainName));
				$haveDNSZone	=	$response[1]['isValid'];
				
				if($haveDNSZone){ //ถ้ามี DNS Zone  อยู่แล้ว
					$res 	=	false;
					$error	=	'ไม่ดำเนินการมี DNS Zone อยู่แล้ว';
				}else{
					//Create DNS Zone
					$response		=	self::send(array('domainName'	=>	$domainName));
					$isCreateDnsZone=	$response[1]['isValid'];
					
					if($isCreateDnsZone){
						$res 	=	true;
						$error	=	'ดำเนินการสำเร็จ';
						$response		=	self::addDomainLogs(
																	array(
																			'module' 	=> 'dnsservicehandle' ,
																			'domain_id'	=>	$domainID ,
														                    'result' 	=>	'1' ,
														                    'action_' 	=>	$do,
														                    'change_' 	=>	'Create DNS Zone.'
																		)
																);
					}else{
						$res 	=	false;
						$error	=	'ดำเนินการไม่สำเร็จ : Please contact SYS.';
						$response		=	self::addDomainLogs(
																	array(
																			'module' => 'dnsservicehandle' ,
														                    'domain_id' => $domainID ,
														                    'result' => '0' ,
														                    'action_' => $do ,
														                    'error' => 'Cannot Create DNS Zone ' . $domainName . ' Please contact SYS.'
																		)
																);
							
					}
					
				}
				
			}
						
		}else{
			$res 	=	false;
			$error	=	'ไม่สามารถดำเนินการไม่มีค่า Domain Name';
		}

		return array(true, array(
	            'isValid'	=>	$res,
	            'resError'	=>	$error
	        ));
		
	}
	
	public function addDNSZone($request){
		
		$domainName =	(isset($request['domainName']) && $request['domainName'] != '') ? $request['domainName'] : null;
		$domainID	=	(isset($request['domainID']) && $request['domainID'] != '') ? $request['domainID'] : null;
		$do			=	(isset($request['do']) && $request['do'] != '') ? $request['do'] : '-';
        
		if (isset($domainName) && isset($domainID)){
		
			$response		=	self::verifyNs(array('domainName'	=>	$domainName));
			$weNameServer	=	$response[1]['isValid'];
			
			if($weNameServer){ //ถ้า Name Server ชี้มาที่เรา
				
				$response		=	self::haveDNSZone(array('domainName'	=>	$domainName));
				$haveDNSZone	=	$response[1]['isValid'];
				
				if($haveDNSZone){ //ถ้ามี DNS Zone  อยู่แล้ว
					$res 	=	false;
					$error	=	'ไม่ดำเนินการมี DNS Zone อยู่แล้ว';
				}else{
					
					$response		=	self::haveHosting(array('domainName'	=>	$domainName));
					$haveHosting	=	$response[1]['isValid'];
					
					if($haveHosting){ //ถ้ามี Hosting account อยู่แล้ว
						$res 	=	false;
						$error	=	'ไม่ดำเนินการมี Hosting account อยู่แล้ว';
					}else{
						//Create DNS Zone
						$response		=	self::send(array('domainName'	=>	$domainName));
						$isCreateDnsZone=	$response[1]['isValid'];
						
						if($isCreateDnsZone){
							$res 	=	true;
							$error	=	'ดำเนินการสำเร็จ';
							$response		=	self::addDomainLogs(
																		array(
																				'module' 	=> 'dnsservicehandle' ,
																				'domain_id'	=>	$domainID ,
															                    'result' 	=>	'1' ,
															                    'action_' 	=>	$do ,
															                    'change_' 	=>	'Create DNS Zone.'
																			)
																	);
						}else{
							$res 	=	false;
							$error	=	'ดำเนินการไม่สำเร็จ : Please contact SYS.';
							$response		=	self::addDomainLogs(
																		array(
																				'module' => 'dnsservicehandle' ,
															                    'domain_id' => $domainID ,
															                    'result' => '0' ,
															                    'action_' => $do ,
															                    'error' => 'Cannot Create DNS Zone ' . $domainName . ' Please contact SYS.'
																			)
																	);
								
						}
						
					}
					
				}
				
			}else{
				$res 	=	false;
				$error	=	'ไม่ดำเนินการ Name Server ไม่ถูกชี้มาที่เรา';
			}
		
		}else{
			$res 	=	false;
			$error	=	'ไม่สามารถดำเนินการไม่มีค่า Domain Name';
		}
		
		return array(true, array(
	            'isValid'	=>	$res,
	            'resError'	=>	$error
	        ));
		
	}
	
	private function verifyNs($request){
		
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
                           || preg_match('/ns3.netway.co.th/i', $nameServer)
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
	
	private function addDomainLogs($request) {
        
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
	
	private function send($request){
	        
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
                    curl_setopt($ch, CURLOPT_URL, 'https://' . $dnsServer . ':2087/json-api/adddns?domain=' . $domainName . '&ip=' . $ipPark . '&template=simple&trueowner=parktha');
                        
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
	
	private function haveHosting($request){
		
		$domainName	=	(isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $db = hbm_db();
        $res = false;
        
        if (isset($domainName)) {
        	
			$aRes	=	$db->query("
									SELECT
										hba.id
									FROM
										hb_accounts hba , hb_servers hbs , hb_server_groups hbsg
									WHERE
										hba.server_id = hbs.id
				                        AND hbs.group_id = hbsg.id
				                        AND hbsg.name = 'Cpanel'
				                        AND hba.domain = :domainName
				                        AND hba.status IN ('Pending' , 'Active' , 'Suspended')
									",array(
											':domainName'	=>	$domainName
									))->fetchAll();
            
        
            $res = (count($aRes) > 0 && isset($aRes[0]["id"])) ? true : false;
        }
        
        return array(true, array(
            'isValid' => $res ,
            'resError' => ''
        ));
		
	}
	
	private function haveDNSZone($request){
		
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
                    $authstr = $user . ":" . $remoteAccesskey;
        
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    curl_setopt($ch, CURLOPT_URL, 'https://' . $dnsServer . ':2087/json-api/listzones');
                        
                    curl_setopt($ch, CURLOPT_HEADER, 0);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
                    $curlheaders[0] = "Authorization: whm $authstr";
                    $curlheaders[1] = "Referer: " . $referer;
                    curl_setopt($ch, CURLOPT_HTTPHEADER, $curlheaders);
                    $output = curl_exec($ch);
                    curl_close($ch);
                    
                    $output = json_decode($output);
                    $output = $output->zone;
                    
                    foreach ($output as $value) {
                        if (isset($value->domain) && $value->domain != '') {
                            if ($domainName == $value->domain) {
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

	public function getCPanelDNSConfig(){
        
        $db = hbm_db();
        $response = array();    
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
                
            $response['user'] = $aConf['DNS Server1 WHM Username']['value'];
            $response['server'] = $aConf['DNS Server1 IP']['value'];
            $remoteAccesskey = $aConf['DNS Server1 WHM Hash']['value'];
            $cleanaccesshash = preg_replace("'(\r|\n)'","", $remoteAccesskey);
            $response['cleanaccesshash'] = $cleanaccesshash;
                        
        }
        return $response;
    }
}
