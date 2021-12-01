<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvskin_license_controller extends HBController 
{
	protected $moduleName = 'rvskin_license';
	public $conn;
	public function view($request) 
	{
	
	}
	
	public function accountdetails($params) 
	{
		$db	= hbm_db();
		
	}
	
    
    private function _chkValidate($ip='', $accid='', $chkPartner=false , $pbIp='')
    {
        $db 	= hbm_db();
        $aRes 	= array();
        $aRes['res'] = true;
		if($pbIp == '') $pbIp = $ip;
        if(!preg_match("/^(([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/", $ip) || !preg_match("/^(([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]).){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/", $pbIp)) {
            $aRes['res'] = false;
            $aRes['msg'] = 'format ip invalid';
			if($ip == ''){
				$aRes['msg'] = 'You did not enter a server ip';
			}
        } else {
            if ($chkPartner == true) {
                $aGetIp = array('ip'=>$ip);
            } else {
                $aGetIp = RVProductLicenseDao::singleton()->getIpByAccountId($accid);
				$aGetPbIp = RVProductLicenseDao::singleton()->getPbIpByAccountId($accid);
            }
            if ((count($aGetIp) > 0)) {
                $aRes['ip'] =  $aGetIp;
				$aRes['pbip'] =  $aGetPbIp;
              
                $getIP = $db->query("
                	SELECT 
                        license_id,hb_acc,active
                    FROM 
                        rvskin_license
                    WHERE
                        main_ip=:ip
                        AND second_ip=:pbip", array(':ip' => $ip, ':pbip'=>$pbIp))->fetch();
                if ($getIP) {
                	$aProductPrepertual =  array(81, 82,92,93,88,89);
					$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
                    if (in_array($product['product_id'], $aProductPrepertual) && $getIP['active'] != 'yes') {
                    	$aRes['res'] = true;
                    } elseif (defined('RVTRANFER_CPANEL_FREE_RVSKIN')) {
                    	$aRes['res'] = true;
                    }else {
                    	$aRes['res'] = false;
                    	$aRes['msg'] = 'Sorry the IP Address you entered already exists in our system.';
					}
                }
            
            } else {
                $aRes['res'] = false;
                $aRes['msg'] = 'ไม่พบข้อมูลบน hostbill ip='.$ip;
            }
        }
       
        return $aRes;
    }
    

    public function changeip($params, $jsonRespont=true, $limitCount=true)
    {
        $db 	= hbm_db();
        $aRes 	= array();
        $txt 	= '';
		
        if($params['isNat'] == 1){
			$aChkValidate 	= $this->_chkValidate($params['to_ip'], $params['acc_id'] , false , $params['to_pbip']);
		}else{
			$aChkValidate 	= $this->_chkValidate($params['to_ip'], $params['acc_id'] , false , $params['to_ip']);
		}
        $aRes['res'] 	= true;
		
        $chkAccid 		= true;
        if (!isset($params['acc_id']) || $params['acc_id']=='' || $params['acc_id']==0) {
			$chkAccid = false;
        }
        if ( $aChkValidate['res']  == true && $chkAccid == true) {
			$ipnew 	= $params['to_ip'];
			$pbipnew= $params['to_pbip'];
			if($params['to_pbip'] == '') $pbipnew = $ipnew;            
            		
		    $accid 	= $params['acc_id'];
			
            $aGetIp = $aChkValidate['ip'];
            $ipOld 	= $aGetIp['data'];
			
			if(!empty($aChkValidate['pbip'])){
		    	$aGetPbIp = $aChkValidate['pbip'];
            	$pbipOld 	= $aGetPbIp['data'];
			}else{
				$pbipOld = $ipOld;
			}
			
        	$queryLicenseUser = $db->query("
				UPDATE
					rvskin_license 
				SET
					main_ip=:ipnew, second_ip=:pbipnew
            	WHERE
            		main_ip=:ipold 
            		AND hb_acc=:accid
            		AND second_ip=:pbipold
            	", array(
            		':ipnew' 	=> $ipnew,
            		':ipold'	=> $ipOld,
            		':accid'	=> $accid,
            		':pbipnew'	=>	$pbipnew,
            		':pbipold'	=>	$pbipOld
					));
            if ($queryLicenseUser) {
                $db_license_type    = ($params['server_type'] == 'VPS') ? 11 : 9;
                $expiredate         = $this->calExpireDateHalfMonth();
                
                
              
				$resUpdateIp = RVProductLicenseDao::singleton()->UpdateIpFormCustom(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                    'data'          => $params['to_ip'],
                    'account_id'    => $params['acc_id'],
                    'config_cat'    => $aGetIp['config_cat'],
                    'config_id'     => $aGetIp['config_id']
                ));
				
				if(empty($aChkValidate['pbip'])){
						
					$result	=	$db->query("
											SELECT i.id as itemId , c.id as catId
											FROM hb_accounts a , hb_config_items_cat c , hb_config_items i 
											WHERE a.id = :accId
											AND	a.product_id = c.product_id
											AND c.id = i.category_id
											AND c.name = 'Public IP Address'
											",array(
													':accId'	=>	 $params['acc_id']
											))->fetch();
					
					$db->query("
								INSERT INTO hb_config2accounts
									(rel_type , account_id , config_cat , config_id , qty , data)
								VALUES
									('Hosting' , :accId , :config_cat , :config_id , 1 , :data)
								",array(
										':accId'			=>	$params['acc_id'],
										':config_cat'		=>	$result['catId'],
										':config_id'		=>	$result['itemId'],
										':data'				=>	$pbipnew
								));
					
				}else{
					$resUpdatePbIp = RVProductLicenseDao::singleton()->UpdateIpFormCustom(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                            'data' 			=> $pbipnew,
                            'account_id' 	=> $params['acc_id'],
                            'config_cat' 	=> $aGetPbIp['config_cat'],
                            'config_id' 	=> $aGetPbIp['config_id']
                    ));
				}
				
                $aRes['msg'] = 'success:'.$txt;
				
                if ($resUpdateIp == false) {
                    $aRes['res'] = false;
                    $aRes['msg'] = 'update ip from database rvskin error::'.$txt;
                } else {
                	if($aGetIp['data'] != $ipnew){
	                    $resInsertLogIp = RVProductLicenseDao::singleton()->InsertLogTransferIp(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
	                            'from_ip'   => $ipOld,
	                            'acc_id'    => $params['acc_id'],
	                            'to_ip'     => $ipnew,
	                            'active_by' => 'user',
	                            'active_id' => $params['acc_id'],
	                            'product_type' => 'rvk'
	                    ));
                    }
					if($aGetPbIp['data'] != $pbipnew){
						$resInsertLogIp = RVProductLicenseDao::singleton()->InsertLogTransferIp(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
	                            'from_ip'   => $pbipOld,
	                            'acc_id'    => $params['acc_id'],
	                            'to_ip'     => $pbipnew,
	                            'active_by' => 'user',
	                            'active_id' => $params['acc_id'],
	                            'product_type' => 'rvk'
	                    ));
					}
                    if ($resInsertLogIp == false) {
                        $aRes['msg'] = 'update ข้อมูลใน hb_transfer_log database error';
                    }
                    else{
                        try{
                        	$db->query("
							DELETE
							FROM rvsitebuilder_license_trial 
							WHERE main_ip = :ip
							AND	second_ip = :pbip
							",array(
									':ip'		=>	$ipOld,
									':pbip'		=>	$pbipOld
							));
							
                            $sql_ins_license_tril = $db->query("
                                    INSERT INTO rvskin_license_trial             
                                        (license_type, main_ip, second_ip, exprie, effective_expiry) 
                                    VALUES
                                        ( :licensetype , :main_ip , :second_ip , :expire, :eff)
                                    ",array(
                                    ':licensetype'  => $db_license_type,
                                    ':main_ip'      => $ipOld,
                                    ':second_ip'	=> $pbipOld,
                                    ':expire'       => $expiredate['exp'],
                                    ':eff'          => $expiredate['eff']));
                        }catch(exception $e){
                            $aRes['res'] = false;
                            $aRes['msg'] .= 'insert temporary rvskin error::'.$txt;
                        }
                    }
                }
            }
        } else {
            $aRes['res'] = false;
            $aRes['msg'] = $aChkValidate['msg'];
        }
        if($ipnew != $aGetIp['data']) $changeServerIp = true; 
        else  $changeServerIp = false;
        if ($aRes['res'] == true && $limitCount == true && $changeServerIp) {
            $resSaveLimit = RVProductLicenseDao::singleton()->InsertTransferLimitByAccid($accid);
            if ($resSaveLimit == false || (int)$resSaveLimit < 2) {
            	$aRes['res'] = true;
                $aRes['msg'] = 'Your Change IP Request exceeds limitation of 2 requests per year.';
            } else {
                $aRes['countLimit'] = $resSaveLimit;
            }
        }
        
        if ($jsonRespont == true) {
			$this->loader->component('template/apiresponse', 'json');
    	    $this->json->assign("aResponse", $aRes);
        	$this->json->show();
        } else {
        	return $aRes;
        }
    }

	public function ip_is_private ($request , $star = '') {
		
	    $pri_addrs = array (
	                      '10.0.0.0|10.255.255.255', // single class A network
	                      '172.16.0.0|172.31.255.255', // 16 contiguous class B network
	                      '192.168.0.0|192.168.255.255', // 256 contiguous class C network
	                      '169.254.0.0|169.254.255.255', // Link-local address also refered to as Automatic Private IP Addressing
	                      '127.0.0.0|127.255.255.255' // localhost
	                     );
		$aRes = false;
	    $long_ip = ip2long ($request['ip']);
	    if ($long_ip != -1) {
	
	        foreach ($pri_addrs AS $pri_addr) {
	            list ($start, $end) = explode('|', $pri_addr);
	
	             // IF IS PRIVATE
	             if ($long_ip >= ip2long ($start) && $long_ip <= ip2long ($end)) {
	                 $aRes = true;
	             }
	        }
	    }
		
	    $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aRes);
        $this->json->show();
		
	}


     public function changeipNOC($params)
    {
        $db     = hbm_db();
        $aRes   = array();
        $txt    = '';
        $aChkValidate   = $this->_chkValidate($params['to_ip'],$params['acc_id'],false,$params['to_subip']);
        $aRes['res']    = true;
        $chkAccid       = true;
        $accid          = $params['acc_id'];
        
        if (!isset($params['acc_id']) || $params['acc_id']=='' || $params['acc_id']==0) {
            $chkAccid = false;
        }
        if ( $aChkValidate['res']  == true && $chkAccid == true) {
            $ipnew          = $params['to_ip'];
            $ipsubnew 		= (isset($params['to_subip']) && $params['to_subip'] != '') ?  $params['to_subip'] : $params['to_ip'];
            $is_update_na   = $this->module->check_ip_update_na($ipnew);
            $userId         = 'hb_acc_'.$params['acc_id'];
            $accid          = $params['acc_id'];
            $aGetIp         = $aChkValidate['ip'];
            $ipOld          = $params['old_ip'];
            $subipOld = (isset($params['old_supip']) && $params['old_supip'] != '') ?  $params['old_supip'] : $params['old_ip'];
            
            $queryLicenseUser = $db->query("
                UPDATE
                    rvskin_license 
                SET
                    main_ip=:ipnew, second_ip=:ipsubnew
                WHERE
                    main_ip=:ipold 
                    AND hb_acc=:accid
                ", array(
                    ':ipnew'    => $ipnew,
                	':ipsubnew'	=> $ipsubnew,
                    ':ipold'    => $ipOld,
                    ':accid'    => $accid
                    ));
            if ($queryLicenseUser) {
                $db_license_type    = ($params['server_type'] == 'VPS') ? 11 : 9;
                $expiredate         = $this->calExpireDateHalfMonth();
               
                
 
                $aRes['msg'] = 'success:'.$txt;
               
                $resInsertLogIp = RVProductLicenseDao::singleton()->InsertLogTransferIp(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                        'from_ip'   => $ipOld,
                        'acc_id'    => $params['acc_id'],
                        'to_ip'     => $ipnew,
                        'active_by' => 'user',
                        'active_id' => $accid,
                        'product_type' => 'rvk'
                ));
                if ($resInsertLogIp == false) {
                    $aRes['msg'] = 'update ข้อมูลใน hb_transfer_log database error';
                }
                else{
                        try{
                             $sql_ins_license_tril = $db->query("
                            INSERT INTO rvskin_license_trial             
                                (license_type, main_ip, second_ip, exprie, effective_expiry) 
                            VALUES
                                ( :licensetype , :main_ip , :second_ip , :expire, :eff)
                            ",array(
                            ':licensetype'  => $db_license_type,
                         	//':main_ip'      => $ipOld, ทำไมถึงเอา oldip ใส่ใน license trial ความจริงข้อมูลจะต้องตรงกันทั้ง rvsb_license และ rvsb_license_trial ไม่ใช่เหรอ
                         	':main_ip'      => $ipOld,
                        	':second_ip'	=> $subipOld,
                            ':expire'       => $expiredate['exp'],
                            ':eff'          => $expiredate['eff']));
                        }catch(exception $e){
                            //$aRes['res'] = false;
                            //$aRes['msg'] .= 'insert temporary rvskin error::'.$e;
                        }
                 }
                
            }
        } else {
            $aRes['res'] = false;
            $aRes['msg'] = $aChkValidate['msg'];
        }
        
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aRes);
        $this->json->show();
    }
    
    public function partner_terminate_license($params){
    	$db = hbm_db();
        $licenseid = $params['licenseid'];
		$sql = "DELETE FROM rvskin_license WHERE license_id=:licenseid";
        $res = $db->query($sql,array(':licenseid'=>$licenseid));
        if ($res) {
             $aRes['res'] = true;
             $aRes['msg'] = 'Success.';
        } else {
            $aRes['res'] = false;
            $aRes['msg'] = 'Error Delete License.';
        }
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aRes);
        $this->json->show();
    
    }

    public function addlicense($params)
    {
        $db = hbm_db();
        $aRes 			= array();
        $txt 			= '';
        $clientid 		= $_SESSION['AppSettings']['login']['id'];

        $chkAccid 		= true;
        $aRes['res'] 	= true;
        
        $acc_id = RVProductLicenseDao::singleton()->getAccByProductId($clientid,$params['product_id'], $params['server_type']);
        if (!isset($acc_id) || $acc_id == '' || $acc_id == 0) {
			$chkAccid = false;
        }

        $aChkValidate = $this->_chkValidate($params['main_ip'],'',true);
               
        $aChkDuplicate = $this->_ChkDuplicate($params['main_ip'],(isset($params['sec_ip']) && $params['sec_ip'] != '') ? $params['sec_ip'] : '');
        
        if ( $aChkValidate['res']  == true && $chkAccid == true && $aChkDuplicate['res'] == true) {
            $db_license_type 	= ($params['server_type'] == 'vps' ) ? 'VPS' : '';
            $db_ip 				= $params['main_ip'];
            $db_pv_ip			= (isset($params['sec_ip']) && $params['sec_ip'] != '') ? $params['sec_ip'] : '';
			$is_update_na 		= $this->module->check_ip_update_na($db_ip);
            $expiredate 		= mktime(23,59,59,date("m")+1,  7,  date("Y"));  
			$eff_exp 			= mktime(23,59,59,date("m")+1,  10,  date("Y"));  
			$query  			= $db->query("
				INSERT INTO rvskin_license
					(license_type, user_id,hb_acc , main_ip, second_ip,   active,expire,effective_expiry)
				VALUES
				    (:license_type, :userid, :hb_acc, :main_ip, :second_ip, :active, :expire,:effect_exp)
				", array(
				':license_type' => $db_license_type,
				':userid' 		=> RVProductLicenseDao::singleton()->getUserSnd($_SESSION['AppSettings']['login']['email']),
				':hb_acc' 		=> $acc_id,
				':main_ip' 		=> ($db_pv_ip != '') ? $db_pv_ip : $db_ip,
				':second_ip' 	=> $db_ip,
				':active' 		=> 'yes',
				':expire' 		=> $expiredate,
				':effect_exp'	=> $eff_exp
				));
          
            if ($query) {
               $aRes['res'] = true;
            } else {
                //echo 'vvv';
                $aRes['res'] = false;
                $aRes['msg'] = 'Error insert to rvskin : license_user';
            }
        } else {
            $aRes['res'] = false;
            $aRes['msg'] = $aChkValidate['msg'].' '.$aChkDuplicate['msg'] ;
        }
        

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aRes);
        $this->json->show();
    }
    
    private function _ChkDuplicate($main_ip, $sec_ip) {
    	$db 	= hbm_db();
    	$aRes 	= array();
    	$aRes['res'] = true;
    	$getDupIP = $db->query("
                	SELECT
                        *
                    FROM
                        rvskin_license
                    WHERE
                        main_ip=:ip
                        AND second_ip=:pbip", 
    			array(':ip' => $sec_ip, ':pbip'=>$main_ip))->fetch();
    	if ($getDupIP) {
	  			$aRes['res'] = false;
	  			$aRes['msg'] = 'Main IP and Secondary IP is exist ('.$main_ip.'/'.$sec_ip.')';
    	}
    	return $aRes;
    }
    
    private function calExpireDateHalfMonth(){
        $startDate = time();
        $time['exp'] =  mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate),
                                date('j', $startDate)+15,
                                date('Y', $startDate)
                            );
                            
        $time['eff'] =  mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate),
                                date('j', $startDate)+18,
                                date('Y', $startDate)
                            );
                            
        return $time;
    }
    
	
}

