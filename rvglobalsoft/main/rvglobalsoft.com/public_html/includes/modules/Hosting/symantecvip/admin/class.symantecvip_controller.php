<?php

/*************************************************************
 *
 * Hosting Module Class - symantecvip
 *
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 *
 *
 ************************************************************/

// Load SymantecvipDAO
include_once(APPDIR_MODULES . "Hosting/symantecvip/include/api/class.symantecvip.dao.php");

class symantecvip_controller extends HBController {

	//protected $UploadCerPath = "/home/isara/public_html/rvglobalsoft.com/public_html/upload/certificate_file/";
	//protected $UploadCerUrl = "http://192.168.1.92/rvglobalsoft.com/public_html/upload/certificate_file/";
	protected $UploadCerPath;
	protected $UploadCerUrl;
	protected $CercPanelPath;
    protected $CerAppsPath;
    protected $subFolder;

	/**
	 *
	 * Enter description here ...
	 * @param $request
	 */
	public function view($request) {
	}


	/**
	 *
	 * Enter description here ...
	 * @param $params
	 */
    public function accountdetails($params) {

    	$this->UploadCerPath = MAINDIR . "upload/certificate_file/";
    	$this->UploadCerUrl = "../upload/certificate_file/";
    	//$this->UploadCerUrl = system_url . "upload/certificate_file/";

    	$symantecVipTabs = APPDIR_MODULES . "Hosting/" . $this->getModuleName() . "/templates/AdminSymantecvip.tpl";
        $this->template->assign("symantecviptabs", $symantecVipTabs);

      //  echo "param=<pre>";
      //  print_r($params);

        $vipData1 = SymantecvipDao::singleton()->getVIPInfoByUsrID($params['account']['client_id']);

        $vipQty1 = SymantecvipDao::singleton()->getSymantecVipAccount($params['account']['id']);

        if ($vipData1['vip_info_id'] != '') {
	        if ($vipData1['quantity_at_symantec'] != $vipQty1) {
	        	// update quantity_at_symantec where account_id = $params['account']['id']
	        	SymantecvipDao::singleton()->updateSymantecVipAccount($vipData1['vip_info_id'] , $params['account']['id'] , $vipQty1);
	        }
        }

        $vipData = SymantecvipDao::singleton()->getVIPInfoByUsrID($params['account']['client_id']);

        $vipQty = SymantecvipDao::singleton()->getSymantecVipAccount($params['account']['id']);



        $HBAcctId = $params['account']['id'];

        $client_id = $params['account']['client_id'];

        $cerFileNamePem = $client_id."-".$HBAcctId."-".str_replace("'","",$params['account']['firstname'])."-".str_replace("'","",$params['account']['lastname']);

        $cerFileNameP12 = $cerFileNamePem;


    	$genPassPem = date("Y")."Vip".$params['account']['client_id']."RV".$params['account']['id'];
        $genPassP12 = $genPassPem;

        if(strlen($genPassPem) > 12)
        {
        	$genPassPem = substr($genPassPem,0,12);
        }

        if(strlen($genPassP12) > 12)
        {
        	$genPassP12 = substr($genPassP12,0,12);
        }

       // echo "<pre>";
       //print_r($params);

        $this->template->assign("account_id", $HBAcctId);

        if ($vipData['vip_info_id'] != '') {

        	$this->template->assign("vip_info_id", $vipData['vip_info_id']);
        	$this->template->assign("vip_info_type_text", $vipData['vip_info_type']);
        	$this->template->assign("vip_subscription_status", $vipData['vip_subscription_status']);
        	$this->template->assign("vip_manage_status", $vipData['vip_manage_status']);


        	//========= step 1. ou and quantity
        	$this->template->assign("vip_ou_number", $vipData['ou_number']);
        	$this->template->assign("quantity", $vipQty);
        	$this->template->assign("quantity_at_symantec", $vipData['quantity_at_symantec']);
        	$this->template->assign("symantec_connection", $vipData['symantec_connection']);


        	if ($vipData['certificate_expire_date'] > 0) {
        		$exp1 = date('d/m/Y',$vipData['certificate_expire_date']);
        		$this->template->assign("certificate_expire_date", $exp1);
        	} else {
        		$this->template->assign("certificate_expire_date", "");
        	}

        	if ($vipData['certificate_expire_date_p12'] > 0) {
        		$exp2 = date('d/m/Y',$vipData['certificate_expire_date_p12']);
        		$this->template->assign("certificate_expire_date_p12", $exp2);
        	} else {
        		$this->template->assign("certificate_expire_date_p12", "");
        	}


			//========= step 2. upload cer


        	if ($vipData['certificate_file_name_p12'] == '') {
        	    $this->template->assign("certificate_file_name_p12", $cerFileNameP12);
        	}

        	if ($vipData['certificate_file_name'] == '') {
        	    $this->template->assign("certificate_file_name", $cerFileNamePem);
        	}

        	if ($vipData['certificate_file_password'] == '') {
        		$this->template->assign("genPassPem", $genPassPem);
        		$this->template->assign("certificate_file_password", $genPassPem);
        	}

        	if ($vipData['certificate_file_password_p12'] == '') {
        		$this->template->assign("genPassP12", $genPassP12);
        		$this->template->assign("certificate_file_password_p12", $genPassP12);
        	}


        	$has_cer_pem = "0";
        	if ($vipData['certificate_file_path'] != '') {

        		$view_cer_pem_path = $this->UploadCerUrl.$params['account']['client_id']."/".$vipData['certificate_file_path'];
        		$view_cer_pem_local_path = $this->UploadCerPath.$params['account']['client_id']."/".$vipData['certificate_file_path'];

	        	if (file_exists($view_cer_pem_local_path)) {
				   	$has_cer_pem = "1";
        			$this->template->assign("has_cer_pem", $has_cer_pem);
				}

        		//========= file name path
        		$this->template->assign("certificate_file_name", $vipData['certificate_file_name']);
        		$this->template->assign("certificate_file_path", $vipData['certificate_file_path']);

        		//======== file type
        		$this->template->assign("certificate_file_type", $vipData["certificate_file_type"]);
        		$this->template->assign("view_cer_pem_path", $view_cer_pem_path);

        		//======== file size
        		$this->template->assign("file_size", number_format($vipData["certificate_file_size"],0));

        		//======== file upload date
        		if ($vipData['date_file_upload'] > 0) {
        			$date_upload = date('d/m/Y',$vipData['date_file_upload']);
        			$this->template->assign("date_file_upload_pem", $date_upload);
        		} else {
        			$this->template->assign("date_file_upload_pem", "");
        		}

        		//======== file last upload date
        		if ($vipData['date_file_last_upload'] > 0) {
        			$last_upload = date('d/m/Y',$vipData['date_file_last_upload']);
        			$this->template->assign("date_file_last_upload_pem", $last_upload);
        		} else {
        			$this->template->assign("date_file_last_upload_pem", "");
        		}

        		$this->template->assign("md5sum", $vipData["md5sum"]);

        	}


	        $has_cer_p12 = "0";
        	if ($vipData['certificate_file_path_p12'] != '') {

        		$view_cer_p12_path = $this->UploadCerUrl.$params['account']['client_id']."/".$vipData['certificate_file_path_p12'];
        		$view_cer_p12_local_path = $this->UploadCerPath.$params['account']['client_id']."/".$vipData['certificate_file_path_p12'];

        		if (file_exists($view_cer_p12_local_path)) {
        			$has_cer_p12 = "1";
        			$this->template->assign("has_cer_p12", $has_cer_p12);
				}




        		//=============== file p12
	        	$this->template->assign("certificate_file_name_p12", $vipData['certificate_file_name_p12']);
	        	$this->template->assign("certificate_file_path_p12", $vipData['certificate_file_path_p12']);
	        	$this->template->assign("certificate_expire_date_p12", $exp2);

        		//======== file type
         		$this->template->assign("certificate_file_type_p12",  $vipData['certificate_file_type_p12']);
        		$this->template->assign("view_cer_p12_path", $view_cer_p12_path);

        		//======== file size
        		$this->template->assign("file_size_p12", number_format($vipData['certificate_file_size_p12'],0));

        		//======== file upload date
        		if ($vipData['date_file_upload_p12'] > 0) {
        			$date_upload_p12 = date('d/m/Y',$vipData['date_file_upload_p12']);
        			$this->template->assign("date_file_upload_p12", $date_upload_p12);
        		} else {
        			$this->template->assign("date_file_upload_p12", "");
        		}

        		//======== file last upload date
        		if ($vipData['date_file_last_upload_p12'] > 0) {
        			$last_upload_p12 = date('d/m/Y',$vipData['date_file_last_upload_p12']);
        			$this->template->assign("date_file_last_upload_p12", $last_upload_p12);
        		} else {
        			$this->template->assign("date_file_last_upload_p12", "");
        		}

        		$this->template->assign("md5sum_p12", $vipData["md5sum_p12"]);

        	}


        	//========== step 3. cer password
        	$this->template->assign("certificate_file_password", $vipData['certificate_file_password']);
        	$this->template->assign("certificate_file_password_p12", $vipData['certificate_file_password_p12']);


        	if ($vipData['certificate_file_password'] == '') {
        		$this->template->assign("genPassPem", $genPassPem);
        		$this->template->assign("certificate_file_password", $genPassPem);
        	} else {
        		$this->template->assign("genPassPem", $genPassPem);
        	}

        	if ($vipData['certificate_file_password_p12'] == '') {
        		$this->template->assign("genPassP12", $genPassP12);
        		$this->template->assign("certificate_file_password_p12", $genPassP12);
        	} else {
        		$this->template->assign("genPassP12", $genPassP12);
        	}



        } else {
        	//if ($params['account']['product_name'] == '2-factor Authentication (Free)') {
        		$this->template->assign("quantity", $vipQty);
        		$this->template->assign("quantity_at_symantec", $vipQty);
        		$this->template->assign("vip_ou_number", $client_id);

        		$this->template->assign("certificate_file_name_p12", $cerFileNameP12);
        		$this->template->assign("certificate_file_name", $cerFileNamePem);

        		$this->template->assign("genPassP12", $genPassP12);
        		$this->template->assign("genPassPem", $genPassPem);

        		$this->template->assign("certificate_file_password", $genPassPem);
        		$this->template->assign("certificate_file_password_p12", $genPassP12);


        	//}
        }

        $pathFolderDoc = $this->UploadCerPath.$params['account']['client_id'];

	 	if (is_dir($pathFolderDoc) === false) {
			if (mkDir($pathFolderDoc,0777)) {
				//echo "make dir";
				$doc = $pathFolderDoc;
			}
		}

	 	if (is_dir($pathFolderDoc."/cPanelWebmailUser") === false) {
			if (mkDir($pathFolderDoc."/cPanelWebmailUser",0777)) {
				//echo "make dir";
				//$doc = $pathFolderDoc;
			}
		}

        if (is_dir($pathFolderDoc."/Apps") === false) {
			if (mkDir($pathFolderDoc."/Apps",0777)) {
				//echo "make dir";
				//$doc = $pathFolderDoc;
			}
		}

		$this->template->assign("upload_dir", $doc);

        $this->template->assign("usr_id", $params['account']['client_id']);
        $this->template->assign("vip_info_type", $params['account']['billingcycle']);
        $this->template->assign("product_id", $params['account']['product_id']);
        $this->template->assign("product_name", $params['account']['product_name']);



        /*
         * case UI for cPanel (product_id = 6) and Apps (product_id = 7)
         */

        if (($params['account']['product_id'] == 60) || ($params['account']['product_id'] == 61)) {

        	if ($params['account']['product_id'] == 60) {
        		$cp_apps_name = "cPanel";
        	} elseif ($params['account']['product_id'] == 61) {
        		$cp_apps_name = "Apps";
        	}

        	$vipDatacPanel = SymantecvipDao::singleton()->getVIPInfoByUsrIDcPanelAppsType($params['account']['client_id'] , $cp_apps_name);


        	/* Certificate file name */
        	if($vipDatacPanel['certificate_file_name'] != '') {
        		$this->template->assign("certificate_file_name_cp_apps", $vipDatacPanel['certificate_file_name']);
        	} else {
        		$this->template->assign("certificate_file_name_cp_apps", $cerFileNamePem."-".$cp_apps_name);
        	}


        	/* Certificate file password */
            if ($vipDatacPanel['certificate_file_password'] != '') {
        		$this->template->assign("certificate_file_password_cp_apps", $vipDatacPanel['certificate_file_password']);
        	} else {
        		$this->template->assign("certificate_file_password_cp_apps", $genPassPem.$cp_apps_name);
        	}


        	/* Symantec Connection */
        	if ($vipDatacPanel['symantec_connection'] != '') {
        		$this->template->assign("symantec_connection_cp_apps", $vipDatacPanel['symantec_connection']);
        	} else {
        		$this->template->assign("symantec_connection_cp_apps", "ยังไม่มีการเชื่อมต่อไปยัง Symantec Server");
        	}

        	/* cer file upload date  */
        	$this->template->assign("date_file_upload_cp_apps", $vipDatacPanel['date_file_upload']);
        	$this->template->assign("date_file_upload_p12_cp_apps", $vipDatacPanel['date_file_upload_p12']);

        	/* cer file date expire datepicker  */
        	if ($vipDatacPanel['certificate_expire_date'] > 0) {
        		$exp_cp_apps = date('d/m/Y',$vipDatacPanel['certificate_expire_date']);
        		$this->template->assign("certificate_expire_date_cp_apps", $exp_cp_apps);
        	} else {
        		$this->template->assign("certificate_expire_date_cp_apps", "");
        	}

        	/* ถ้ามีไฟล์ certificate .pem แล้ว */
        	$has_cer_pem_cp_apps = "0";
        	if ($vipDatacPanel['certificate_file_path'] != '') {

        		$subFolderCer = "";

        		if($vipDatacPanel['cp_apps_type'] == 'cPanel') {
        			$subFolderCer = "cPanelWebmailUser/";
        		} else if ($vipDatacPanel['cp_apps_type'] == 'Apps') {
        			$subFolderCer = "Apps/";
        		}

        		$view_cer_pem_path = $this->UploadCerUrl.$params['account']['client_id']."/".$subFolderCer.$vipDatacPanel['certificate_file_path'];
        		$view_cer_pem_local_path = $this->UploadCerPath.$params['account']['client_id']."/".$subFolderCer.$vipDatacPanel['certificate_file_path'];

        		if (file_exists($view_cer_pem_local_path)) {
        			$has_cer_pem_cp_apps = "1";
        			$this->template->assign("has_cer_pem_cp_apps", $has_cer_pem_cp_apps);
        		}

        		//========= file name path
        		$this->template->assign("certificate_file_name", $vipDatacPanel['certificate_file_name']);
        		$this->template->assign("certificate_file_path", $vipDatacPanel['certificate_file_path']);

        		//======== file type
        		$this->template->assign("certificate_file_type", $vipDatacPanel["certificate_file_type"]);
        		$this->template->assign("view_cer_pem_path", $view_cer_pem_path);

        		//======== file size
        		$this->template->assign("file_size", number_format($vipDatacPanel["certificate_file_size"],0));

        		//======== file upload date
        		if ($vipDatacPanel['date_file_upload'] > 0) {
        			$date_upload = date('d/m/Y',$vipDatacPanel['date_file_upload']);
        			$this->template->assign("date_file_upload_pem", $date_upload);
        		} else {
        			$this->template->assign("date_file_upload_pem", "");
        		}

        		//======== file last upload date
        		if ($vipDatacPanel['date_file_last_upload'] > 0) {
        			$last_upload = date('d/m/Y',$vipDatacPanel['date_file_last_upload']);
        			$this->template->assign("date_file_last_upload_pem", $last_upload);
        		} else {
        			$this->template->assign("date_file_last_upload_pem", "");
        		}

        		$this->template->assign("md5sum", $vipDatacPanel["md5sum"]);

        	}

			/* ถ้ามีไฟล์ certificate .p12 แล้ว */
        	$has_cer_p12_cp_apps = "0";
        	if ($vipDatacPanel['certificate_file_path_p12'] != '') {


        		$view_cer_p12_path_p12 = $this->UploadCerUrl.$params['account']['client_id']."/".$subFolderCer.$vipDatacPanel['certificate_file_path_p12'];
        		$view_cer_p12_local_path_p12 = $this->UploadCerPath.$params['account']['client_id']."/".$subFolderCer.$vipDatacPanel['certificate_file_path_p12'];

        		if (file_exists($view_cer_p12_local_path)) {
        			$has_cer_p12_cp_apps = "1";
        			$this->template->assign("has_cer_p12_cp_apps", $has_cer_p12_cp_apps);
        		}




        		//=============== file p12
        		$this->template->assign("certificate_file_name_p12", $vipDatacPanel['certificate_file_name_p12']);
        		$this->template->assign("certificate_file_path_p12", $vipDatacPanel['certificate_file_path_p12']);
        		$this->template->assign("certificate_expire_date_p12", $exp2);

        		//======== file type
        		$this->template->assign("certificate_file_type_p12",  $vipDatacPanel['certificate_file_type_p12']);
        		$this->template->assign("view_cer_p12_path_p12", $view_cer_p12_path_p12);

        		//======== file size
        		$this->template->assign("file_size_p12", number_format($vipDatacPanel['certificate_file_size_p12'],0));

        		//======== file upload date
        		if ($vipDatacPanel['date_file_upload_p12'] > 0) {
        			$date_upload_p12 = date('d/m/Y',$vipDatacPanel['date_file_upload_p12']);
        			$this->template->assign("date_file_upload_p12", $date_upload_p12);
        		} else {
        			$this->template->assign("date_file_upload_p12", "");
        		}

        		//======== file last upload date
        		if ($vipDatacPanel['date_file_last_upload_p12'] > 0) {
        			$last_upload_p12 = date('d/m/Y',$vipDatacPanel['date_file_last_upload_p12']);
        			$this->template->assign("date_file_last_upload_p12", $last_upload_p12);
        		} else {
        			$this->template->assign("date_file_last_upload_p12", "");
        		}

        		$this->template->assign("md5sum_p12", $vipDatacPanel["md5sum_p12"]);

        	}

        }

    }

    /**
     *
     * Enter description here ...
     */
    public function getModuleName() {
        return "symantecvip";
    }

     /*****************************************************************
     * step 1 save ou number
     *****************************************************************/
	public function _validate_doSaveAccount($params) {

        $input = array(
     		"isValid" => true,
          	"resError" => ""
        );

        // Variable Defined.
        $input["vipNum"] = (isset($params["vipNum"]) && $params["vipNum"] != "") ? $params["vipNum"] : null;
        $input["vipQuantityAtSymantec"] = (isset($params["vipQuantityAtSymantec"]) && $params["vipQuantityAtSymantec"] != "") ? $params["vipQuantityAtSymantec"] : null;
        $input["vipQuantityOrder"] = (isset($params["vipQuantityOrder"]) && $params["vipQuantityOrder"] != "") ? $params["vipQuantityOrder"] : null;
        $input["vipInfoId"] = (isset($params["vipInfoId"]) && $params["vipInfoId"] != "") ? $params["vipInfoId"] : null;
        $input["vipInfoType"] = (isset($params["vipInfoType"]) && $params["vipInfoType"] != "") ? $params["vipInfoType"] : null;
        $input["usrId"] = (isset($params["usrId"]) && $params["usrId"] != "") ? $params["usrId"] : null;
        $input["acctId"] = (isset($params["acctId"]) && $params["acctId"] != "") ? $params["acctId"] : null;
        $input["productId"] = (isset($params["productId"]) && $params["productId"] != "") ? $params["productId"] : null;
        $input["productName"] = (isset($params["productName"]) && $params["productName"] != "") ? $params["productName"] : null;

        if (!isset($input["vipNum"]) || ($input["vipNum"] == "")) {
            $resError = 'กรุณากรอก Organizational Unit Number';
            $input["isValid"] = false;
            $input["resError"] = $resError;
        } else if (!isset($input["vipQuantityAtSymantec"]) || ($input["vipQuantityAtSymantec"] == "")){
            $resError = 'กรุณากรอก จำนวน Account ที่สั่งซื้อใน Symantec VIP official site';
            $input["isValid"] = false;
            $input["resError"] = $resError;
        } else if ($input["vipQuantityAtSymantec"] != $input["vipQuantityOrder"]) {
        	$resError = 'กรุณากรอก จำนวน Account ที่สั่งซื้อใน Symantec VIP official site ให้เท่ากับจำนวน account ในการสั่งซื้อ';
        	$input["isValid"] = false;
        	$input["resError"] = $resError;
        }
        return $input;

    }

    public function doSaveAccount($params) {

    	$complete = "1";
        $message = "";

        try {

            // Validate
            $valid = symantecvip_controller::_validate_doSaveAccount($params);
            if ($valid["isValid"] == false) {
                //throw new Exception($params["resError"]);
                $message = $valid["resError"];
            } else {

            	//if($params['productName'] == '2-factor Authentication (Free)') {
            		//	$billing_cycle_unit = 'M';
            		//	$qty = 1;
            	//}

            	$vip_user_prefix = "vip".$params['usrId']."_";

            	if ($params['vipInfoId'] != '') {
            		$aData = array (
            							'usr_id' =>  $params['usrId'] ,
            							'vip_info_type' => $params['vipInfoType'] ,
            							'ou_number' => $params['vipNum'] ,
            							'quantity_at_symantec' => $params['vipQuantityAtSymantec'],
            							'product_id' => $params['productId'],
            							'billing_cycle_unit' => $billing_cycle_unit,
            							'quantity' => $params["vipQuantityOrder"]
            						);
            		$updateVip = SymantecvipDao::singleton()->updateVIP($aData , $params['vipInfoId']);
            		$resUpdate = $updateVip;
            	} else {

            		$aData = array (
            							'usr_id' =>  $params['usrId'] ,
            							'account_id' => $params['acctId'] ,
            							'vip_user_prefix' => $vip_user_prefix ,
            							'vip_info_type' => $params['vipInfoType'] ,
            							'ou_number' => $params['vipNum'] ,
            							'quantity_at_symantec' => $params['vipQuantityAtSymantec'],
            							'product_id' => $params['productId'],
            							'billing_cycle_unit' => $billing_cycle_unit,
            							'quantity' => $params["vipQuantityOrder"],
            						    'can_manage_status' => 'P' ,
            							'status' => 'P'
            						);
            						/*
            						 * 	'billing_cycle_unit' => $billing_cycle_unit,
            							'quantity' => $qty ,
            						 */

            		if($addVip = SymantecvipDao::singleton()->addVIP($aData)) {
            			$resAdd = $addVip;

            			$get_vip_info_id = SymantecvipDao::singleton()->getVIPInfoByUsrID($params['usrId']);

            			$aData2 = array (
            									'vip_info_id' => $get_vip_info_id['vip_info_id'] ,
            									'usr_id' => $params['usrId'] ,
		            							'date_created' => time() ,
            									'last_updated' => time() ,
		            						    'can_manage_status' => 'P' ,
		            							'status' => 'P' ,
		            							'cp_apps_type' => 'cPanel'
            							);

            			$addVipcPanel = SymantecvipDao::singleton()->addVIPcPanelApps($aData2);

            			$aData3 = array (
            									'vip_info_id' => $get_vip_info_id['vip_info_id'] ,
            									'usr_id' => $params['usrId'] ,
		            							'date_created' => time() ,
            									'last_updated' => time() ,
		            						    'can_manage_status' => 'P' ,
		            							'status' => 'P' ,
		            							'cp_apps_type' => 'Apps'
            							);
            			$addVipApps = SymantecvipDao::singleton()->addVIPcPanelApps($aData3);

            		}


            	}

	            if ($resAdd === true) {
		        	$message = "บันทึกข้อมูล Step 1: Register VIP Account สำเร็จ";
		        }

		        if ($resUpdate === true) {
		        	$message = "อัพเดทข้อมูล Step 1: Register VIP Account สำเร็จ";
		        }
           	}
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }



        $aResponse = array(
          "complete" => $complete,
          "message" => $message
        );

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }

    /*****************************************************************
    * step 2 save certificate file
    *****************************************************************/
	public function _validate_doSaveCertificateFile($params) {

		$this->UploadCerPath = MAINDIR . "upload/certificate_file/";
    	$this->UploadCerUrl = system_url . "upload/certificate_file/";

        $input = array(
     		"isValid" => true,
          	"resError" => ""
        );

        // Variable Defined.
        $input["usrIdFolder"] = (isset($params["usrIdFolder"]) && $params["usrIdFolder"] != "") ? $params["usrIdFolder"] : null;

        $input["usrId"] = (isset($params["usrId"]) && $params["usrId"] != "") ? $params["usrId"] : null;
        $input["vipInfoId"] = (isset($params["vipInfoId"]) && $params["vipInfoId"] != "") ? $params["vipInfoId"] : null;

        $input["vipCerFileName"] = (isset($params["vipCerFileName"]) && $params["vipCerFileName"] != "") ? $params["vipCerFileName"] : null;
        $input["vipCerFileType"] = (isset($params["vipCerFileType"]) && $params["vipCerFileType"] != "") ? $params["vipCerFileType"] : null;
        $input["vipCerFileSize"] = (isset($params["vipCerFileSize"]) && $params["vipCerFileSize"] != "") ? $params["vipCerFileSize"] : null;
        $input["vipCerFilePath"] = (isset($params["vipCerFilePath"]) && $params["vipCerFilePath"] != "") ? $params["vipCerFilePath"] : null;
		$input["vipCerExpireDate"] = (isset($params["vipCerExpireDate"]) && $params["vipCerExpireDate"] != "") ? $params["vipCerExpireDate"] : null;

        $input["vipCerFileNameP12"] = (isset($params["vipCerFileNameP12"]) && $params["vipCerFileNameP12"] != "") ? $params["vipCerFileNameP12"] : null;
        $input["vipCerFileTypeP12"] = (isset($params["vipCerFileTypeP12"]) && $params["vipCerFileTypeP12"] != "") ? $params["vipCerFileTypeP12"] : null;
        $input["vipCerFileSizeP12"] = (isset($params["vipCerFileSizeP12"]) && $params["vipCerFileSizeP12"] != "") ? $params["vipCerFileSizeP12"] : null;
        $input["vipCerFilePathP12"] = (isset($params["vipCerFilePathP12"]) && $params["vipCerFilePathP12"] != "") ? $params["vipCerFilePathP12"] : null;
		$input["vipCerExpireDateP12"] = (isset($params["vipCerExpireDate"]) && $params["vipCerExpireDate"] != "") ? $params["vipCerExpireDate"] : null;

		$input["dateFileUpload"] = (isset($params["dateFileUpload"]) && $params["dateFileUpload"] != "") ? $params["dateFileUpload"] : null;
		$input["dateFileUploadP12"] = (isset($params["dateFileUploadP12"]) && $params["dateFileUploadP12"] != "") ? $params["dateFileUploadP12"] : null;

		$input["vipCerFilePassword"] = (isset($params["vipCerFilePassword"]) && $params["vipCerFilePassword"] != "") ? $params["vipCerFilePassword"] : null;
        $input["vipCerFilePasswordP12"] = (isset($params["vipCerFilePasswordP12"]) && $params["vipCerFilePasswordP12"] != "") ? $params["vipCerFilePasswordP12"] : null;

        $input["vipInfoId"] = (isset($params["vipInfoId"]) && $params["vipInfoId"] != "") ? $params["vipInfoId"] : null;



		//echo "upload_path=".$this->UploadCerPath.$input["usrIdFolder"]."/".$_FILES["vipCerFileNameArray"]["name"];

		if (($_FILES["vipCerFileNameArray"]["size"]) > 0 && ($_FILES["vipCerFileNameArray"]["error"]==0)) {
        	if (move_uploaded_file($_FILES["vipCerFileNameArray"]["tmp_name"] , $this->UploadCerPath.$input["usrIdFolder"]."/".$_FILES["vipCerFileNameArray"]["name"])) {
        	}
        }


		if (($_FILES["vipCerFileNameArrayP12"]["size"]) > 0 && ($_FILES["vipCerFileNameArrayP12"]["error"]==0)) {
        	if (move_uploaded_file($_FILES["vipCerFileNameArrayP12"]["tmp_name"] , $this->UploadCerPath.$input["usrIdFolder"]."/".$_FILES["vipCerFileNameArrayP12"]["name"])) {
        	}
        }

        return $input;

    }

    public function doSaveCertificateFile($params) {

    	$complete = "1";
        $message = "";

        try {

            // Validate
            $valid = symantecvip_controller::_validate_doSaveCertificateFile($params);
            if ($valid["isValid"] == false) {
                //throw new Exception($valid["resError"]);
                $message = $valid["resError"];
            } else {

            	if ($params['vipInfoId'] != '') {

            		$date1 = explode("/" ,$params["vipCerExpireDate"]);
            		$exp1 = mktime(0,0,0,$date1[1],$date1[0],$date1[2]);

            		$date2 = explode("/" ,$params["vipCerExpireDate"]); // ใช้วันเดียวกันกับ .pem
            		$exp2 = mktime(0,0,0,$date2[1],$date2[0],$date2[2]);

            		if ($params['dateFileUpload'] <= 0) {
            			$date_upload = time();
            		} else {
            			$date_upload = "";
            		}

            		if ($params['dateFileUploadP12'] <= 0) {
            			$date_upload_p12 = time();
            		} else {
            			$date_upload_p12 = "";
            		}


            		if ($params['vipCerFilePath'] != '') {
            			$md5sum = md5_file($this->UploadCerPath.$valid["usrIdFolder"]."/".$valid['vipCerFilePath']);
            			$file_data = file_get_contents($this->UploadCerPath.$valid["usrIdFolder"]."/".$valid['vipCerFilePath']);

               			/*
            			$filename = $this->UploadCerPath.$input["usrIdFolder"]."/".$params['vipCerFilePath'];
            			$data = "";
						if (is_file($filename) === true) {
							$data = file($filename);
							$data = join('', $data);
						}

						$file_data = $data;
						*/

            		}

            		if ($params['vipCerFilePathP12'] != '') {
            			$md5sump12 = md5_file($this->UploadCerPath.$valid["usrIdFolder"]."/".$valid['vipCerFilePathP12']);
            			$file_data_p12 = file_get_contents($this->UploadCerPath.$valid["usrIdFolder"]."/".$valid['vipCerFilePathP12']);

						/*
            			$data_p12 = "";
						if (is_file($filename_p12) === true) {
							$data_p12 = file($filename_p12);
							$data_p12 = join('', $data_p12);
						}

						$file_data_p12 = $data_p12;
						*/

						$file_data_p12_encode = base64_encode($file_data_p12);
            		}


            	 	/*
			            [name] => vip_cert.pem
			            [type] => application/x-x509-ca-cert
			            [tmp_name] => /tmp/phpO54tbY
			            [error] => 0
			            [size] => 4765
			         */

            		$aData = array (
            							'certificate_file_name' =>  $params['vipCerFileName'] ,
            							'certificate_file_type' =>  $params['vipCerFileType'] ,
            							'certificate_file_size' =>  $params['vipCerFileSize'] ,
            							'certificate_file_path' =>  $params['vipCerFilePath'] ,
            							'certificate_file_content' => $file_data,
            							'certificate_expire_date' => $exp1 ,
            							'date_file_upload' => $date_upload,
            							'date_file_last_upload' => time(),
            							'md5sum' => $md5sum,
            							'symantec_connection' => $params['symantec_connection'],
            							'certificate_file_name_p12' =>  $params['vipCerFileNameP12'] ,
            							'certificate_file_type_p12' =>  $params['vipCerFileTypeP12'] ,
            							'certificate_file_size_p12' =>  $params['vipCerFileSizeP12'] ,
            							'certificate_file_path_p12' =>  $params['vipCerFilePathP12'] ,
            							'certificate_file_content_p12' => $file_data_p12_encode ,
            							'certificate_expire_date_p12' => $exp2 ,
            							'date_file_upload_p12' => $date_upload_p12 ,
            							'date_file_last_upload_p12' => time() ,
            							'md5sum_p12' => $md5sump12
            						);

            		$updateVipCer = SymantecvipDao::singleton()->updateVIPCertificateFile($aData , $params['vipInfoId']);
            		$resUpdate = $updateVipCer;
            	}

		        if ($resUpdate === true) {

		        	$aData2 = array (
            							'certificate_file_password' =>  $params['vipCerFilePassword'] ,
            							'certificate_file_password_p12' => $params['vipCerFilePasswordP12'] ,
            						);

            		$updateVipCerPass = SymantecvipDao::singleton()->updateVIPCertificateFilePassword($aData2 , $params['vipInfoId']);
            		$resUpdate = $updateVipCerPass;

		        	$message = "อัพเดทข้อมูล Step 2: Upload Certificate File สำเร็จ";
		        }
		        else {
		        	$message = "อัพเดทข้อมูล Step 2: Upload Certificate File ไม่สำเร็จ กรุณาลองใหม่อีกครั้ง";
		        }
           	}
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }

        $aResponse = array(
          "complete" => $complete,
          "message" => $message
        );


        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }


    /*****************************************************************
     * step 3 save password
     *****************************************************************/
	public function _validate_doSaveCertificateFilePassword($params) {

        $input = array(
     		"isValid" => true,
          	"resError" => ""
        );

        // Variable Defined.
        $input["vipCerFilePassword"] = (isset($params["vipCerFilePassword"]) && $params["vipCerFilePassword"] != "") ? $params["vipCerFilePassword"] : null;
        $input["vipCerFilePasswordP12"] = (isset($params["vipCerFilePasswordP12"]) && $params["vipCerFilePasswordP12"] != "") ? $params["vipCerFilePasswordP12"] : null;

        $input["vipInfoId"] = (isset($params["vipInfoId"]) && $params["vipInfoId"] != "") ? $params["vipInfoId"] : null;

        if (isset($input["vipCerFilePassword"]) && ($input["vipCerFilePassword"] != "")
         && isset($input["vipCerFilePasswordP12"]) && ($input["vipCerFilePasswordP12"] != "")) {

        } else {
        	$resError = "";

        	if (!isset($input["vipCerFilePassword"]) || ($input["vipCerFilePassword"] == "")) {
            	$resError = 'กรุณากรอก Certificate File Password ของไฟล์ .pem';
        	} else if (!isset($input["vipCerFilePasswordP12"]) || ($input["vipCerFilePasswordP12"] == "")){
            	$resError = 'กรุณากรอก Certificate File Password ของไฟล์ .p12';
        	}

        	$input["isValid"] = false;
        	$input["resError"] = $resError;
        }

        return $input;

    }

    public function doSaveCertificateFilePassword($params) {

    	$complete = "1";
        $message = "";

        try {

            // Validate
            $input = symantecvip_controller::_validate_doSaveCertificateFilePassword($params);
            if ($input["isValid"] == false) {
                throw new Exception($input["resError"]);
            } else {

            	if ($params['vipInfoId'] != '') {

            		$aData = array (
            							'certificate_file_password' =>  $params['vipCerFilePassword'] ,
            							'certificate_file_password_p12' => $params['vipCerFilePasswordP12'] ,
            						);

            		$updateVipCerPass = SymantecvipDao::singleton()->updateVIPCertificateFilePassword($aData , $params['vipInfoId']);
            		$resUpdate = $updateVipCerPass;
            	}

		        if ($resUpdate === true) {
		        	$message = "อัพเดทข้อมูล Step 3: Certificate Password สำเร็จ";
		        }
		        else {
		        	$message = "อัพเดทข้อมูล Step 3: Certificate Password ไม่สำเร็จ กรุณาลองใหม่อีกครั้ง";
		        }
           	}
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }

        $aResponse = array(
          "complete" => $complete,
          "message" => $message
        );


        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }





	/*****************************************************************
    * save certificate file for cPanel and Apps
    *****************************************************************/
	public function _validate_doSaveCertificateFilecPanelApps($params) {

		$this->UploadCerPath = MAINDIR . "upload/certificate_file/";
    	$this->UploadCerUrl = system_url . "upload/certificate_file/";

    	$this->CercPanelPath = "cPanelWebmailUser/";
    	$this->CerAppsPath = "Apps/";

        $input = array(
     		"isValid" => true,
          	"resError" => ""
        );

        // Variable Defined.
        $input["usrIdFolder"] = (isset($params["usrIdFolder"]) && $params["usrIdFolder"] != "") ? $params["usrIdFolder"] : null;

        $input["usrId"] = (isset($params["usrId"]) && $params["usrId"] != "") ? $params["usrId"] : null;
        $input["vipInfoId"] = (isset($params["vipInfoId"]) && $params["vipInfoId"] != "") ? $params["vipInfoId"] : null;

        $input["accountId"] = (isset($params["accountId"]) && $params["accountId"] != "") ? $params["accountId"] : null;
        $input["cerFileType"] = (isset($params["cerFileType"]) && $params["cerFileType"] != "") ? $params["cerFileType"] : null;

        $input["vipCerFileName"] = (isset($params["vipCerFileName"]) && $params["vipCerFileName"] != "") ? $params["vipCerFileName"] : null;
        $input["vipCerFileType"] = (isset($params["vipCerFileType"]) && $params["vipCerFileType"] != "") ? $params["vipCerFileType"] : null;
        $input["vipCerFileSize"] = (isset($params["vipCerFileSize"]) && $params["vipCerFileSize"] != "") ? $params["vipCerFileSize"] : null;
        $input["vipCerFilePath"] = (isset($params["vipCerFilePath"]) && $params["vipCerFilePath"] != "") ? $params["vipCerFilePath"] : null;
		$input["vipCerExpireDate"] = (isset($params["vipCerExpireDate"]) && $params["vipCerExpireDate"] != "") ? $params["vipCerExpireDate"] : null;

        $input["vipCerFileNameP12"] = $input["vipCerFileName"]; //(isset($params["vipCerFileNameP12"]) && $params["vipCerFileNameP12"] != "") ? $params["vipCerFileNameP12"] : null;
        $input["vipCerFileTypeP12"] = (isset($params["vipCerFileTypeP12"]) && $params["vipCerFileTypeP12"] != "") ? $params["vipCerFileTypeP12"] : null;
        $input["vipCerFileSizeP12"] = (isset($params["vipCerFileSizeP12"]) && $params["vipCerFileSizeP12"] != "") ? $params["vipCerFileSizeP12"] : null;
        $input["vipCerFilePathP12"] = (isset($params["vipCerFilePathP12"]) && $params["vipCerFilePathP12"] != "") ? $params["vipCerFilePathP12"] : null;
		$input["vipCerExpireDateP12"] = $input["vipCerExpireDate"]; // (isset($params["vipCerExpireDateP12"]) && $params["vipCerExpireDateP12"] != "") ? $params["vipCerExpireDateP12"] : null;


		$input["vipCerFilePassword"] = (isset($params["vipCerFilePassword"]) && $params["vipCerFilePassword"] != "") ? $params["vipCerFilePassword"] : null;
        $input["vipCerFilePasswordP12"] = $input["vipCerFilePassword"]; //(isset($params["vipCerFilePasswordP12"]) && $params["vipCerFilePasswordP12"] != "") ? $params["vipCerFilePasswordP12"] : null;


		$input["dateFileUpload"] = (isset($params["dateFileUpload"]) && $params["dateFileUpload"] != "") ? $params["dateFileUpload"] : null;
		$input["dateFileUploadP12"] = (isset($params["dateFileUploadP12"]) && $params["dateFileUploadP12"] != "") ? $params["dateFileUploadP12"] : null;

		//$input["usrId"] = (isset($params["usrId"]) && $params["usrId"] != "") ? $params["usrId"] : null;
        //$input["vipInfoId"] = (isset($params["vipInfoId"]) && $params["vipInfoId"] != "") ? $params["vipInfoId"] : null;


		//echo "upload_path=".$this->UploadCerPath.$input["usrIdFolder"]."/".$_FILES["vipCerFileNameArray"]["name"];

		$this->subFolder = "";
		if($input["cerFileType"] == "cPanel") {
			$this->subFolder = $this->CercPanelPath;
		} elseif ($input["cerFileType"] == "Apps") {
			$this->subFolder = $this->CerAppsPath;
		}




		if (($_FILES["vipCerFileNameArray"]["size"]) > 0 && ($_FILES["vipCerFileNameArray"]["error"]==0)) {
        	if (move_uploaded_file($_FILES["vipCerFileNameArray"]["tmp_name"] , $this->UploadCerPath.$input["usrIdFolder"]."/".$this->subFolder.$_FILES["vipCerFileNameArray"]["name"])) {
        	}
        }


		if (($_FILES["vipCerFileNameArrayP12"]["size"]) > 0 && ($_FILES["vipCerFileNameArrayP12"]["error"]==0)) {
        	if (move_uploaded_file($_FILES["vipCerFileNameArrayP12"]["tmp_name"] , $this->UploadCerPath.$input["usrIdFolder"]."/".$this->subFolder.$_FILES["vipCerFileNameArrayP12"]["name"])) {
        	}
        }

        return $input;

    }

    public function doSaveCertificateFilecPanelApps($params) {

    	$complete = "1";
        $message = "";

        try {

            // Validate
            $valid = symantecvip_controller::_validate_doSaveCertificateFilecPanelApps($params);
            if ($valid["isValid"] == false) {
                //throw new Exception($valid["resError"]);
                $message = $valid["resError"];
            } else {

            	if ($params['vipInfoId'] != '') {

            		$date1 = explode("/" ,$params["vipCerExpireDate"]);
            		$exp1 = mktime(0,0,0,$date1[1],$date1[0],$date1[2]);

            		$date2 = explode("/" ,$params["vipCerExpireDateP12"]);
            		$exp2 = mktime(0,0,0,$date2[1],$date2[0],$date2[2]);

            		if ($params['dateFileUpload'] <= 0) {
            			$date_upload = time();
            		} else {
            			$date_upload = "";
            		}

            		if ($params['dateFileUploadP12'] <= 0) {
            			$date_upload_p12 = time();
            		} else {
            			$date_upload_p12 = "";
            		}


            		if ($params['vipCerFilePath'] != '') {
            			$md5sum = md5_file($this->UploadCerPath.$valid["usrIdFolder"]."/".$this->subFolder.$valid['vipCerFilePath']);
            			$file_data = file_get_contents($this->UploadCerPath.$valid["usrIdFolder"]."/".$this->subFolder.$valid['vipCerFilePath']);

               			/*
            			$filename = $this->UploadCerPath.$input["usrIdFolder"]."/".$params['vipCerFilePath'];
            			$data = "";
						if (is_file($filename) === true) {
							$data = file($filename);
							$data = join('', $data);
						}

						$file_data = $data;
						*/

            		}

            		if ($params['vipCerFilePathP12'] != '') {
            			$md5sump12 = md5_file($this->UploadCerPath.$valid["usrIdFolder"]."/".$this->subFolder.$valid['vipCerFilePathP12']);
            			$file_data_p12 = file_get_contents($this->UploadCerPath.$valid["usrIdFolder"]."/".$this->subFolder.$valid['vipCerFilePathP12']);

						/*
            			$data_p12 = "";
						if (is_file($filename_p12) === true) {
							$data_p12 = file($filename_p12);
							$data_p12 = join('', $data_p12);
						}

						$file_data_p12 = $data_p12;
						*/

						$file_data_p12_encode = base64_encode($file_data_p12);
            		}


            	 	/*
			            [name] => vip_cert.pem
			            [type] => application/x-x509-ca-cert
			            [tmp_name] => /tmp/phpO54tbY
			            [error] => 0
			            [size] => 4765
			         */

            		$aData = array (
            							'usr_id' => $params['usrId'] ,
            		  					'account_id' => $params['accountId'] ,
            							'certificate_file_name' =>  $params['vipCerFileName'] ,
            							'certificate_file_type' =>  $params['vipCerFileType'] ,
            							'certificate_file_size' =>  $params['vipCerFileSize'] ,
            							'certificate_file_path' =>  $params['vipCerFilePath'] ,
            							'certificate_file_content' => $file_data,
            							'certificate_file_password' => $params['vipCerFilePassword'] ,
            							'certificate_expire_date' => $exp1 ,
            							'date_file_upload' => $date_upload,
            							'date_file_last_upload' => time(),
            							'md5sum' => $md5sum,
            							'symantec_connection' => $params['symantec_connection'],
            							'certificate_file_name_p12' =>  $params['vipCerFileNameP12'] ,
            							'certificate_file_type_p12' =>  $params['vipCerFileTypeP12'] ,
            							'certificate_file_size_p12' =>  $params['vipCerFileSizeP12'] ,
            							'certificate_file_path_p12' =>  $params['vipCerFilePathP12'] ,
            							'certificate_file_content_p12' => $file_data_p12_encode ,
            							'certificate_file_password_p12' => $params['vipCerFilePassword'] ,
            							'certificate_expire_date_p12' => $exp2 ,
            							'date_file_upload_p12' => $date_upload_p12 ,
            							'date_file_last_upload_p12' => time() ,
            							'md5sum_p12' => $md5sump12 ,
            							'cp_apps_type' => $params['cerFileType']
            						);

            		$updateVipCer = SymantecvipDao::singleton()->updateVIPCertificateFilecPanelApps($aData , $params['vipInfoId']);
            		$resUpdate = $updateVipCer;
            	}

		        if ($resUpdate === true) {
		        	$message = "อัพเดทข้อมูล Upload Certificate File สำเร็จ";
		        }
		        else {
		        	$message = "อัพเดทข้อมูล Upload Certificate File ไม่สำเร็จ กรุณาลองใหม่อีกครั้ง".$resUpdate;
		        }
           	}
        } catch (Exception $e) {
            $complete = "0";
            $message = $e->getMessage();
        }

        $aResponse = array(
          "complete" => $complete,
          "message" => $message
        );


        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", $aResponse);
        $this->json->show();
    }

    public function revoked($input){
    	$db = hbm_db();
    	$db->query("UPDATE hb_accounts SET notes = 'Revoked' WHERE id = {$input['accountid']}");
    }





}







