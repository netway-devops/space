<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvskin_perpetual_license_controller extends HBController 
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

  // ของ product ที่เป็น propertual license
	private function getRecurringDate($next_due_date)
	{ 
	 	date_default_timezone_set('UTC');
	//	echo '<br>next = '.$next_due_date;
		$startDate = strtotime($next_due_date);
		$calDate = mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate),
                                date('j', $startDate),
                                date('Y', $startDate) +1
                            );
	    $aDate['txt'] = date("d/m/Y",$startDate) . ' - ' . date("d/m/Y",$calDate);//d-m-Y;
	    $aDate['new_next_due'] = date("Y-m-d",$calDate);
		return $aDate;			
	}

	public function cal_price_renew ($total) 
	{
		$price = 0;
		if ($total <= 9) {
			$price = 26;
		} elseif ($total > 9 && $total <= 19) {
			$price = 22;
		} elseif ($total > 19 && $total <= 49) {
			$price = 18;
		} elseif ($total > 49 && $total <= 99) {
			$price = 14;
		} else {
			$price = 10;
		}
		return $price;
	}
	
    public function verify_license_rvskin($ip)
	{
		$res = array();
		$res['res'] = false;
		// หา ip 
		$db = hbm_db();
		$getIP  = $db->query("
                    SELECT 
	            		license_id,hb_acc,active
	        		FROM 
	            		rvskin_license
	        		WHERE
	            		main_ip=:ip
	            		OR second_ip=:ip 
                    ", array(
                    ':ip' => $ip
                    ))->fetch();
		
        $aProductPrepertual = array(81, 82,92,93,88,89);
        if ($getIP) {
        	$product = RVProductLicenseDao::singleton()->getCheckProductLicenseByAccid($getIP['hb_acc']);
        	// ถ้าเป็น product propertual แล้วเป็น suspend สามารถสั่งซื้อได้
        	// $getIP['active'] = (yes,no,'')
        	if (in_array($product['product_id'], $aProductPrepertual) && $getIP['active'] != 'yes') {
        		$aRes['res'] = true;
        	} else {
        		$aRes['res'] = false;
            	$aRes['msg'] = 'License RVSkin IP:' . $ip . ' already exists in thesystem (' . $product['email'] . ')';
        	}
        } else {
        	$aRes['res'] = true;
        } 
		//echo '<pre>';print_r($aRes);
        return $aRes;
	}
	public function addlicense($params)
    {
        $aRes 			= array();
        $txt 			= '';
        $clientid 		= $_SESSION['AppSettings']['login']['id'];
        $chkAccid 		= true;
        $aRes['res'] 	= true;
		
		$aProduct 	= RVProductLicenseDao::singleton()->getAddLicensePerpetual($clientid,$params['server_type']);
		$achk 		= $this->verify_license_rvskin($params['main_ip']);
		if ($aProduct == false || $achk['res'] == false) {
			$aRes['res'] = false;
			$aRes['msg'] = ($achk['res'] == false) ? $achk['msg'] : 'หา product id ไม่เจอ';
		} elseif (isset($aProduct['num_active'])) {
			$product_id = $aProduct['product_id_' . $params['server_type']];
		} else {
			//echo '===>'.$clientid;
			$aQuota = RVProductLicenseDao::singleton()->getQuota($clientid);
			if ($aQuota != false) {
				$product_id = $aProduct['product_id_' . $params['server_type']];
				if (($params['server_type'] == 'vps' && $aQuota['vps'] <= 0)
				 || ($params['server_type'] == 'ded' && $aQuota['ded'] <= 0)){
				 	$aRes['res'] = false;
					$aRes['msg'] = 'Quata limit : ' . $params['server_type'];
				 }
			} else {
				$product_id = $aProduct['product_id_' . $params['server_type']];
			}
		}
		if ($aRes['res'] == false) {
			$this->loader->component('template/apiresponse', 'json');
        	$this->json->assign("aResponse", $aRes);
        	$this->json->show();
		}
		
		
		
		if (isset($_SERVER['SERVER_NAME']) && $_SERVER['SERVER_NAME'] == '192.168.1.82') { 
			$url = 'http://192.168.1.82/demo/rvglobalsoft.com/public_html/7944web/api.php';
		} else {
			$url = 'https://rvglobalsoft.com/7944web/api.php';
		}
        // echo $url;
		$db         = hbm_db();
		$result     = $db->query("
				SELECT aa.*
				FROM hb_api_access aa
				WHERE aa.ip = :aaIp
			", array(
				':aaIp' => $_SERVER['SERVER_ADDR']
			))->fetch();//exit;
		if (isset($params['main_ip']) && !preg_match("/^\d*\.\d*\.\d*\.\d*$/", $params['main_ip'])) {
            $aRes['res'] = false;
            $aRes['msg'] = 'format ip invalid';
        } elseif (isset($result['id'])) {
            $apiid    = $result['api_id'];
            $apikey   = $result['api_key'];
			$post = array(
		      'api_id' 		=> $apiid,
		      'api_key' 	=> $apikey,
		      'call' 		=> 'addOrder',
		      'client_id'	=> $clientid,
		      'product'		=> $product_id,
		      'cycle'		=> 'a',
		      'confirm'		=> 1,
		      'module' 		=> 11,
		      'ip' 			=> $params['main_ip'],
		      'invoice_generate'	=> 0,
		      'invoice_info'		=> 'product perpetual'
	   		);
               // echo '<pre>=======>';print_r($post);
			$ch = curl_init();
	   		curl_setopt($ch, CURLOPT_URL, $url);
	   		curl_setopt($ch, CURLOPT_POST, 1);
	   		curl_setopt($ch, CURLOPT_TIMEOUT, 30);
	   		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	   		curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
	   		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	   		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
	   		$data = curl_exec($ch);
	   		curl_close($ch);
	   		$return = json_decode($data, true);
			if (isset($return['success']) &&  $return['success'] == 1) {
		
			} else {
				$aRes['res'] = false;
				$aRes['msg'] = 'api error';
			}
		} else {
			$aRes['res'] = false;
			$aRes['msg'] = 'error api key';
		}
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aRes);
        $this->json->show();
    }
	
	public function renewal_license($params)
	{
	    $clientid 	= $_SESSION['AppSettings']['login']['id'];
		$resAcc 	= array();
		
	    if (isset($params['accid'])) {
	    	$api 		= new ApiWrapper();
			$paramsInv 	= array('client_id'=>$clientid);
			$res 		= $api->addInvoice($paramsInv);
			if (isset($res['invoice_id'])) {
				$invoiceid 	=  $res['invoice_id'];
				$subtotal 	= 0;
				$netActive 	= RVProductLicenseDao::singleton()->getActiveByClientId($clientid);
				$netSelect 	= count($params['accid']);
				$netTotal	= $netActive + $netSelect;
				//echo '<br>'.$netActive . ' , '.$netSelect;
				$unit_price			= $this->cal_price_renew($netTotal);
                $aProduct_peprotual = array(92,93);
				$price_normal 		= 0;
				foreach ($params['accid'] as $k =>$accid) {
					$aDtlAcc 		= RVProductLicenseDao::singleton()->getIpByAccountId($accid);
					$price_normal 	= (in_array($aDtlAcc['product_id'], $aProduct_peprotual)) ? $unit_price : $aDtlAcc['firstpayment'];

					if (isset($aDtlAcc['data'])) {
						$ip = $aDtlAcc['data'];
						//$aGenDate = $this->getRecurringDate($aDtlAcc['next_due']);
						//$productname = $aDtlAcc['name'] . " " . $ip . " (" . $aGenDate['txt'] . ")";
						$productname = 'Renew ' . $aDtlAcc['name'] . " " . $ip ;
						$aInvoiceItem = array(
						   'invoice_id' 	=> $invoiceid,
						   'item_id' 		=> $accid,
						   'description' 	=> $productname,
						   'type' 			=> 'Hosting',
						   'amount' 		=> $price_normal,
						   'taxed'			=> 1,
						   'qty' 			=> 1
				   		);
					   	$resAddInvItem = RVProductLicenseDao::singleton()->insertInvoiceItem($aInvoiceItem);
					   	if ($resAddInvItem == true) {
					   		$subtotal 		+= $price_normal;
							$resAcc[$accid] = 'ok';
							$datenow 		= time();
							$resAddInvItem 	= RVProductLicenseDao::singleton()->save_log_renew(array('account_id'=>$accid,'itype'=>'renew','dt_update'=>$datenow));
					   	} else {
					   	     $resAcc[$accid] = 'error';
					   	}
					}
				}
                $accDetail = $this->getAccountStatusAndNextDueDate($accid); 
                if($accDetail['status'] == 'Active'){
                     $resUpdateInvoice = RVProductLicenseDao::singleton()->updateInvoiceAccountStatusActiveById(array(
                    'subtotal'  => $subtotal,
                    'total'     => $subtotal,
                    'status'    => 'Unpaid',
                    'id'        => $invoiceid,
                    'duedate'   => $accDetail['next_due']
                    ));
                }
                else{
                    $resUpdateInvoice = RVProductLicenseDao::singleton()->updateInvoiceById(array(
                    'subtotal'  => $subtotal,
                    'total'     => $subtotal,
                    'status'    => 'Unpaid',
                    'id'        => $invoiceid
                    ));
                }
                
			} else {
				//echo 'สร้าง invoice ไม่ได้';
			}
	    }
        echo 'waiting.......';
		echo '<script langquage=\'javascript\'>window.location="https://rvglobalsoft.com/index.php?/clientarea/invoice/'.$invoiceid.'"; </script>';
        echo "<meta http-equiv='refresh' content='=2;https://rvglobalsoft.com/index.php?/clientarea/invoice/".$invoiceid."' />";
	}  


    private function getAccountStatusAndNextDueDate($accid){
        $db         = hbm_db();
        $accDetail  = $db->query("
                    SELECT 
                        a.status,a.next_due
                    FROM 
                        hb_accounts a
                    WHERE
                        a.id = :accid
                    ", array(
                    ':accid' => $accid
                    ))->fetch();
        return $accDetail;
    }
	
}

