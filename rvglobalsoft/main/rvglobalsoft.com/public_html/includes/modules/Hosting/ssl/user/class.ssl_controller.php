<?php

/*************************************************************
 *
 * Hosting Module Class - SSL
 *
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/client-area/
 *
 ************************************************************/
include_once(APPDIR_MODULES . "Hosting/ssl/include/api/class.ssl.api.php");

class ssl_controller extends HBController {

    protected $moduleName = "ssl";

    public function accountdetails($params) {
    	if($_GET['action'] == 'renew'){
    		$renewPath = APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/user/renew-main.tpl';
    		$this->template->assign('templatePath', APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/user/');
    		$this->template->assign('custom_template', $renewPath);
    	} else if($_GET['action'] == 'downloadCert'){
    		$this->downloadCert($params['account']);
//     		$downloadCertPath = APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/user/download-cert.tpl';
//     		$this->template->assign('templatePath', APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/user/');
//     		$this->template->assign('custom_template', $downloadCertPath);
    	}

    }

    public function renew($params)
    {
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", APPDIR_MODULES . 'Hosting' . $this->moduleName . '/templates/user/renew-step1.tpl');
    	$this->json->show();
//     	$this->template->render(APPDIR_MODULES . 'Hosting' . $this->moduleName . '/templates/user/renew-step1.tpl');
    }

    public function downloadCert($aData)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$db = hbm_db();
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$acctId = $aData['id'];
    	$orderId = $aData['order_id'];
    	$clientId = $aData['client_id'];

    	$output = '';

    	$getCert = $db->query("SELECT commonname, code_certificate, code_ca, code_pkcs7 FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    	if($getCert){
    		if(class_exists('ZipArchive') && ($getCert['code_certificate'] != '' || $getCert['code_ca'] != '' || $getCert['code_pkcs7'] != '')){
    			$output .= '<li><a href="?cmd=module&module=ssl&action=clientDownloadCert&order_id=' . $orderId . '&type=all&commonname=' . base64_encode($getCert['commonname']) . '">All</a> : To download all certificate files at once and upload in your server by each.</li><br />';
    		}

    		if($getCert['code_certificate'] != ''){
    			$output .= '<li><a href="?cmd=module&module=ssl&action=clientDownloadCert&order_id=' . $orderId . '&type=code_certificate&commonname=' . base64_encode($getCert['commonname']) . '">CRT File</a> : To download a specific file with .CRT extension.</li><br />';
    		}

    		if($getCert['code_ca'] != ''){
    			$output .= '<li><a href="?cmd=module&module=ssl&action=clientDownloadCert&order_id=' . $orderId . '&type=code_ca&commonname=' . base64_encode($getCert['commonname']) . '">CA File</a> : To download a specific file with .CA extension.</li><br />';
    		}

    		if($getCert['code_pkcs7'] != ''){
    			$output .= '<li><a href="?cmd=module&module=ssl&action=clientDownloadCert&order_id=' . $orderId . '&type=code_pkcs7&commonname=' . base64_encode($getCert['commonname']) . '">PKCS7 File</a> : To download a specific file with .PKCS7 extension.</li><br />';
    		}
    	}

    	$this->template->assign('downloadText', $output);
    	$this->template->assign('new_system_url', $oAuth->generateSystemUrl());
    }

    public function clientDownloadCert($request)
    {
    	$db = hbm_db();
    	$commonname = str_replace('.', '-', base64_decode($request['commonname']));
    	if($request['type'] != 'all'){
	    	$results =  $db->query("SELECT {$request['type']} AS cert FROM hb_ssl_order WHERE order_id = {$request['order_id']}")->fetch();
	    	$dataCrt =  $results['cert'];
    	}
    	switch($request['type']){
    		case 'code_certificate':
    			$extension = '.crt';
    			break;
    		case 'code_ca':
    			$extension = '.ca';
    			break;
    		case 'code_pkcs7':
    			$extension = '.pkcs7';
    			break;
    		case 'all':
    			$results = $db->query("SELECT code_certificate, code_ca, code_pkcs7 FROM hb_ssl_order WHERE order_id = {$request['order_id']}")->fetch();
    			$contentArray = array();

    			$tmp_file = dirname(__FILE__) . '/../../../../../uploads/ssl/documents/' . $commonname . '-' . strtotime('now') . '.zip';
    			$zip = new ZipArchive();
    			$zip->open($tmp_file, ZipArchive::CREATE);

    			foreach($results as $k => $v){
    				if($v != ''){
    					$extension = '';
    					switch($k){
    						case 'code_certificate' : $extension = '.crt'; break;
    						case 'code_ca' : $extension = '.ca'; break;
    						case 'code_pkcs7' : $extension = '.p7b'; break;
    					}
    					$zip->addFromString($commonname . $extension, $v);
    				}
    			}
    			$zip->close();

    			header('Content-disposition: attachment; filename=' . $commonname . '.zip');
    			header('Content-Length: ' . filesize($tmp_file));
    			header('Content-type: application/zip');
    			readfile($tmp_file);
    			unlink($tmp_file);
    			exit;


    	}
    	$this->writecrt($dataCrt, $commonname . $extension);
    	exit();
    }

    public function getClientContact($request) {
    	$db = hbm_db();
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $db->query("SELECT cd.*, ca.email FROM hb_client_details AS cd, hb_client_access AS ca WHERE cd.id = {$request['client_login_id']} AND cd.id = ca.id")->fetch());
    	$this->json->show();
    }

    public function decodecsr($request) {
    	$this->loader->component('template/apiresponse', 'json');
   	   	$this->json->assign("aResponse", SSLApiMgr::singleton()->decodecsr($request));
    	$this->json->show();
    }

    public function getwhoisdomain($request)
    {
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", SSLApiMgr::singleton()->getwhoisdomain($request));
    	$this->json->show();
    }

    public function ajax_getemaillist($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->GetQuickApproverList($request['domain']));
    	$this->json->show();
    }

    public function ajax_submitcsr($request)
    {
        $clientData       = hbm_logged_client();
        $db = hbm_db();

        $this->loader->component('template/apiresponse', 'json');

        $aResponse = array();
        $errorMsg = '';
//         $a = base64_encode(json_encode($request));
// $db->query("UPDATE hb_ssl_order SET comment = '{$a}' WHERE order_id = 20462");

        $client_id   =   isset($clientData['id']) ? $clientData['id'] : 0;
        $csr_data   =   isset($request['csr_data']) ? $request['csr_data'] : '';
        $md5data    =   md5($csr_data);
        $commonname =   isset($request['commonname']) ? trim($request['commonname']) : '';
        $order_id   =   $request['order_id'];
        $aQuery = $db->query("SELECT s.ssl_productcode, s.ssl_name, v.ssl_validation_id AS validation FROM hb_ssl AS s, hb_ssl_validation AS v, hb_ssl_order AS o WHERE o.order_id = {$order_id} AND s.ssl_id = o.ssl_id AND s.ssl_validation_id = v.ssl_validation_id")->fetch();
        $productCode = $aQuery['ssl_productcode'];
        $servertype 	= $request['servertype'];
        $email_approval = ($request['varidate'] == 1) ? trim($request['email_approval']) : trim($request['tech']['email']);
        $ssl_validation_id = $request['ssl_validation_id'];

        $aFirstName = trim($request['admin']['firstname']);
        $aLastName = trim($request['admin']['lastname']);
        $aEmail = trim($request['admin']['email']);
        $aOrganize = isset($request['admin']['organize']) ? trim($request['admin']['organize']) : '';
        $aJob = trim($request['admin']['job']);
        $aAddress = isset($request['admin']['address']) ? trim($request['admin']['address']) : '';
        $aCity = isset($request['admin']['city']) ? trim($request['admin']['city']) : '';
        $aState = isset($request['admin']['state']) ? trim($request['admin']['state']) : '';
        $aCountry = isset($request['admin']['country']) ? trim($request['admin']['country']) : '';
        $aPostCode = isset($request['admin']['postcode']) ? trim($request['admin']['postcode']) : '';
        $aPhone = trim($request['admin']['phone']);
        $aExt = trim($request['admin']['ext']);

        $tFirstName = trim($request['tech']['firstname']);
        $tLastName = trim($request['tech']['lastname']);
        $tEmail = trim($request['tech']['email']);
        $tOrganize = isset($request['tech']['organize']) ? trim($request['tech']['organize']) : '';
        $tJob = trim($request['tech']['job']);
        $tAddress = isset($request['tech']['address']) ? trim($request['tech']['address']) : '';
        $tCity = isset($request['tech']['city']) ? trim($request['tech']['city']) : '';
        $tState = isset($request['tech']['state']) ? trim($request['tech']['state']) : '';
        $tCountry = isset($request['tech']['country']) ? trim($request['tech']['country']) : '';
        $tPostCode = isset($request['tech']['postcode']) ? trim($request['tech']['postcode']) : '';
        $tPhone = trim($request['tech']['phone']);
        $tExt = trim($request['tech']['ext']);

        if(isset($request['organize'])){
        	$oName = trim($request['organize']['name']);
        	$oAddress = trim($request['organize']['address']);
        	$oState = trim($request['organize']['state']);
        	$oCity = trim($request['organize']['city']);
        	$oCountry = trim($request['organize']['country']);
        	$oPhone = trim($request['organize']['phone']);
        	$oPostCode = trim($request['organize']['postcode']);
        }

        try {
        	if($csr_data != ""){
        		$db     = hbm_db();
        		if($request['resubmit_csr'] == '1'){
        			$db->query("
        					DELETE FROM hb_ssl_order_contact WHERE order_id = {$request['order_id']}
        			");
        		}

        		if(isset($request['organize'])){
        			$db->query("INSERT INTO `hb_ssl_order_contact`(`client_id`, `order_id`, `csr_md5`, `domain_name`, `organization_name`, `address`, `city`, `state`, `country`, `postal_code`, `telephone`, `phone`, `address_type`) VALUES ({$client_id}, {$order_id}, '{$md5data}', '{$commonname}', '{$oName}', '{$oAddress}', '{$oCity}', '{$oState}', '{$oCountry}', '{$oPostCode}', '{$oPhone}', '{$oPhone}', 0)");
        		}

        		$db->query("INSERT INTO `hb_ssl_order_contact`(`client_id`, `order_id`, `csr_md5`, `domain_name`, `firstname`, `lastname`, `organization_name`, `address`, `city`, `state`, `country`, `postal_code`, `job`, `telephone`, `phone`, `email_approval`, `address_type`, `ext_number`) VALUES ({$client_id}, {$order_id}, '{$md5data}', '{$commonname}', '{$aFirstName}', '{$aLastName}', '{$aOrganize}', '{$aAddress}', '{$aCity}', '{$aState}', '{$aCountry}', '{$aPostCode}', '{$aJob}', '{$aPhone}', '{$aPhone}', '{$aEmail}', 1, '{$aExt}')");

        		$db->query("INSERT INTO `hb_ssl_order_contact`(`client_id`, `order_id`, `csr_md5`, `domain_name`, `firstname`, `lastname`, `organization_name`, `address`, `city`, `state`, `country`, `postal_code`, `job`, `telephone`, `phone`, `email_approval`, `address_type`, `ext_number`) VALUES ({$client_id}, {$order_id}, '{$md5data}', '{$commonname}', '{$tFirstName}', '{$tLastName}', '{$tOrganize}', '{$tAddress}', '{$tCity}', '{$tState}', '{$tCountry}', '{$tPostCode}', '{$tJob}', '{$tPhone}', '{$tPhone}', '{$tEmail}', 2, '{$tExt}')");

        		if(isset($request['dnsName']) && $request['dnsName'] != ''){
        			$dnsNames = '';
        			for($i = 0; $i < sizeof($request['dnsName']); $i++){
        				if(trim($request['dnsName'][$i]) != ''){
	        				$dnsNames .= trim($request['dnsName'][$i]);
	        				$dnsNames .= ($productCode == 'QuickSSLPremium') ? '.' . $commonname : '';
	        				if($i != sizeof($request['dnsName'])-1){
	        					$dnsNames .= ',';
	        				}
        				}
        			}
        			if(substr($dnsNames, -1) == ','){
        				$dnsNames = substr($dnsNames, 0, -1);
        			}
        		}

        		$db->query("
        				UPDATE
        					hb_ssl_order
        				SET
        					csr = :csr
        					, email_approval = :email_approval
        					, commonname = :commonname
        					, server_type = :server_type
        					, symantec_status = 'WAITING_SUBMIT_ORDER'
        					, custom_techaddress = :custom_techaddress
        					, hashing_algorithm = :hashing
        				WHERE
        					order_id = :order_id
        				", array(
        					':order_id' => $order_id,
        					':csr' => $csr_data,
        					':email_approval' => $email_approval,
        					':commonname' => $commonname,
        					':server_type' => $servertype,
        					':custom_techaddress' => 1,
        					':hashing' => $request['hashing']
        		));

        		if(isset($dnsNames) && $dnsNames != ''){
        			$db->query("UPDATE hb_ssl_order SET dns_name = '{$dnsNames}' WHERE order_id = {$order_id}");
        		}

        		$db->query("
        			UPDATE
        				hb_accounts
        			SET
        				domain = '{$commonname}'
        			WHERE
        				order_id = {$order_id}
        		");

	            $invoiceQuery = $db->query('
	            		SELECT
	            			i.status
	            		FROM
	            			hb_invoices AS i
	            			, hb_orders AS o
	            		WHERE
	            			o.id = :orderId
	            			AND o.invoice_id = i.id
	            		', array(
	            			':orderId' => $order_id
	            		)
	            )->fetch();

	            $invoiceStatus = ($invoiceQuery['status'] == 'Paid') ? true : false;
            	if($invoiceStatus && $csr_data != ''){
            		$aQue = $db->query("SELECT id FROM hb_accounts WHERE order_id = {$order_id}")->fetch();
            		if($aQue){
	            		require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
	            		$oAuth =& RvLibs_SSL_PHPLibs::singleton();

	            		$apiCustom = $oAuth->generateAPICustom();
	            		$apiCustom->request(array('call' => 'accountCreate', 'id' => $aQue['id']));
            		}
            	}
        	}
        	$this->json->assign("aResponse", array(
        		'status' => 'success',
        		'message' => "CSR has been updated already.",
        	));
        	// }
        }catch(PDOException $e){
        	$this->json->assign("aResponse", array(
        			'status' => 'ERROR',
        			'message' => $e->getMessage(),
        	));
        	$this->json->show();
        }
        $this->json->show();
    }

    public function ajax_submitphonecall($request){
        if($request['txt_date2_from'] == ''){
            $from2  = '';
        }else{
            $from2 = date("Y-m-d H:i:s",strtotime($request['txt_date2_from'])) . ' GMT' . $request['timezone_2'];
        }
        if($request['txt_date2_to'] == ''){
            $to2 = '';
        }else{
            $to2 = date("Y-m-d H:i:s",strtotime($request['txt_date2_to'])) . ' GMT' . $request['timezone_2'];
        }

        $this->loader->component('template/apiresponse', 'json');
        $aResponse = array();
        $errorMsg = '';
        $db     = hbm_db();
        try{
            $db->query("
                    UPDATE hb_ssl_order_contact
                    SET time_verify_from = :from1 , time_verify_to = :to1 , time_verify_from2 = :from2 , time_verify_to2 = :to2 , ext_number = :ext_number
                    WHERE order_id = :order_id
                    ",array(
                        ':from1'    => date("Y-m-d H:i:s",strtotime($request['txt_date1_from'])) . ' GMT' . $request['timezone_1'],
                        ':to1'      => date("Y-m-d H:i:s",strtotime($request['txt_date1_to'])) . ' GMT' . $request['timezone_1'],
                        ':from2'    => $from2,
                        ':to2'      => $to2,
                        ':order_id'  => $request['order_id'],
                        ':ext_number'=> $request['ext_num']
            ));
            $db->query("
                        UPDATE hb_ssl_order
                        SET symantec_status = 'RV_WF_AUTHORIZATION'
                        WHERE   order_id = {$request['order_id']}
            ");

            $this->json->assign("aResponse", array(
            		'status' => 'success',
            		'message' => "Verification Call Number has been updated already.",
            ));
            require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
            	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
            	$mailSent = $oAuth->sendMailPhoneCall($request['order_id']);
            	if(!$mailSent){
            		$this->json->assign("aResponse", array(
            				'status' => 'ERROR',
            				'message' => 'This appointment is already sent to the Authority.',
            		));
            	}

        } catch (PDOException $e){
            $this->json->assign("aResponse", array(
                    'status' => 'ERROR',
                    'message' => $e->getMessage(),
            ));
            $this->json->show();
        }

        $this->json->show();
    }

    public function resend_email_validation($request){

        $this->loader->component('template/apiresponse', 'json');
        $aResponse = array();
        $errorMsg = '';
        $db     = hbm_db();

        try{
        	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
        	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
        	$response = $oAuth->resendEmail($request['order_id'], 'ApproverEmail');
        	if($response['status']){
        		$this->json->assign("aResponse", array(
        		        			'status' => 'success',
        		        			'message' => "Resend Validation Email completed.",
        		));
        	} else {
        		$this->json->assign("aResponse", array(
        				'status' => 'ERROR',
        				'message' => $response['errorMessage'],
        		));
        	}

        }catch(PDOException $e){
        	$this->json->assign("aResponse", array(
        			'status' => 'ERROR',
        			'message' => $e->getMessage(),
        	));
        	$this->json->show();
        }
        $this->json->show();
    }

    public function change_email_approval($request){

        $this->loader->component('template/apiresponse', 'json');
        $aResponse = array();
        $errorMsg = '';
        $db     = hbm_db();
        $result = $db->query("
                                SELECT authority_orderid, partner_order_id
                                FROM hb_ssl_order
                                WHERE order_id = {$request['order_id']}
                                ")->fetch();
        if($result['authority_orderid'] != ''){
            try {
                require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
                $oAuth =& RvLibs_SSL_PHPLibs::singleton();
                $oAuth->changeApproverEmail($request['email'],$result['partner_order_id']);

                $db->query("
                        UPDATE hb_ssl_order
                        SET email_approval = :email
                        WHERE order_id = :order_id
                        ",array(
                            ':email'        => $request['email'],
                            ':order_id'     => $request['order_id']
                        ));

                $this->json->assign("aResponse", array(
                                                'status' => 'success',
                                                'message' => "Email Approval has been updated already.",
                                                ));
            }catch(PDOException $e){
                $this->json->assign("aResponse", array(
                        'status' => 'ERROR',
                        'message' => $e->getMessage(),
                    ));
                    $this->json->show();
            }
        }else{
            try {
                $db->query("
                        UPDATE hb_ssl_order
                        SET email_approval = :email
                        WHERE order_id = :order_id
                        ",array(
                            ':email'        => $request['email'],
                            ':order_id'     => $request['order_id']
                        ));


                        $this->json->assign("aResponse", array(
                                            'status' => 'success',
                                            'message' => "Email Approval has been updated already.",
                                            ));
                       // $this->resend_email_validation($request['order_id']);
            }catch(PDOException $e){
                $this->json->assign("aResponse", array(
                        'status' => 'ERROR',
                        'message' => $e->getMessage(),
                    ));
                    $this->json->show();
            }
        }
         $this->json->show();
    }

    public function upload_documents($request){

        $this->loader->component('template/apiresponse', 'json');
        $aResponse = array();
        $errorMsg = '';
        $count_empty_file = 0;
        $count_file = 0;
        $validfile = array();
        foreach ($_FILES as $afiles =>$value) {
            if($value['name'] == ''){
                $count_empty_file++;
            } else {
                $validfile[$count_file] = $value;
                $validfile[$count_file]['input'] = $afiles;
                $count_file++;
            }
        }

        if($count_empty_file == 4){
             $this->json->assign(
             		"aResponse", array(
             			'status' => 'ERROR'
             			, 'message' => "No file uploaded. Please upload your document as PDF format, and submit again."
             		)
             );
            $this->json->show();
            exit;
        }

        if(function_exists("finfo_open") && function_exists("finfo_file")){
	        $count_none_pdf = 0;
	        $count_pdf_files  = 0;
	        $apdf_files = array();
	        foreach($validfile as $avalidfiles){
	            $finfo = finfo_open(FILEINFO_MIME_TYPE);
	            $mime = finfo_file($finfo, $avalidfiles['tmp_name']);
	            //$ext = substr($avalidfiles['name'],strrpos($avalidfiles['name'],'.',-1),strlen($avalidfiles['name']));
	            //if(strtolower($avalidfiles['type']) != 'application/pdf' && strtolower($avalidfiles['type']) != 'application/force-download' && strtolower($ext) != '.pdf'){
	            if($mime != 'application/pdf' && $mime != 'application/force-download'){
	                $count_none_pdf++;
	            } else {
	                $apdf_files[$count_pdf_files] = $avalidfiles;
	                $count_pdf_files++;
	            }
	        }

	        if($count_none_pdf != 0){
	            $this->json->assign("aResponse", array(
	            		'status' => 'ERROR'
	            		, 'message' => "The uploaded file is not a PDF format. Please save your document as PDF format, and submit again."
	            ));
	            $this->json->show();
	            exit;
	        }
        } else {
        	$this->json->assign("aResponse", array(
        			'status' => 'ERROR',
        			'message' => "Something went wrong, Tell staff."
        	));
        	$this->json->show();
        	exit;
        }
        $UploadDirectory = MAINDIR . 'uploads/ssl/documents/';
        $error = 0;
        foreach($apdf_files as $apdf_file){
            if($apdf_file['size'] > 2000000){
                $this->json->assign("aResponse", array(
                		'status' => 'ERROR'
                		, 'message' => "The document should be 2MB in minimum size."
                ));
                $this->json->show();
                exit;
            } else {
                $File_Name          = $apdf_file['name'];
                $File_Ext           = substr($File_Name, strrpos($File_Name, '.')); //get file extention
                $NewFileName        = $apdf_file['input'].'_'.$request['order_id'].$File_Ext; //new file name

                if(file_exists($UploadDirectory.$apdf_file['input'].'/'.$NewFileName)){
                	unlink($UploadDirectory.$apdf_file['input'].'/'.$NewFileName);
                }

                if(move_uploaded_file($apdf_file['tmp_name'], $UploadDirectory.$apdf_file['input'].'/'.$NewFileName )){
                    $error = 0;
                }else{
                    $error = 1;
                }
            }
        }
        if($error){
            $this->json->assign("aResponse", array(
            		'status' => 'ERROR'
            		, 'message' => "Uploads Error"
            ));
        } else {
             require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
             $oAuth =& RvLibs_SSL_PHPLibs::singleton();
             $oAuth->sendMailDocument($request['order_id']);

             $this->json->assign("aResponse", array(
             		'status' => 'success'
             		, 'message' => "Uploads Completed"
             ));
        }
        $this->json->show();
    }

    public function downloadcsr($request){
        $db = hbm_db();
        $results =  $db->query("SELECT csr , commonname FROM hb_ssl_order WHERE order_id = {$request['order_id']}")->fetch();
        $this->writecsr($results['csr'], $results['commonname'].'.csr');
        exit();
    }

    public function writecsr($results, $name)
    {
        header("Content-type: text/plain");
        header("Content-Disposition: attachment; filename={$name}");
        print $results;
    }

    public function downloadcrt($request){
        $db = hbm_db();
        $results =  $db->query("SELECT code_certificate , code_ca , code_pkcs7 ,commonname FROM hb_ssl_order WHERE order_id = {$request['order_id']}")->fetch();
        $dataCrt =  $results['code_certificate'].$results['code_ca'].$results['code_pkcs7'];
        $this->writecrt($dataCrt, $results['commonname'].'.crt');
        exit();
    }

    public function writecrt($results, $name)
    {
        header("Content-type: text/plain");
        header("Content-Disposition: attachment; filename={$name}");
        print $results;
    }

    public function upload_csr($request){
        $this->loader->component('template/apiresponse', 'json');
        $aResponse = array();
        $errorMsg = '';

            $fileContent = file_get_contents($_FILES['upload_csr']['tmp_name']);
            $this->json->assign("aResponse", array(
                                        'status' => 'success',
                                        'message' => $fileContent,
                                        ));

        $this->json->show();
    }

    public function resend_fulfillment_email($request){

    }

    public function ajax_reissue($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	$db = hbm_db();

    	if($request['email'] == ''){
    		$aQuery = $db->query("SELECT email_approval FROM hb_ssl_order_contact WHERE order_id = {$request['order_id']} AND address_type = 2")->fetch();
    		$request['email'] = $aQuery['email_approval'];
    	}

    	$response = $oAuth->reissue($request['order_id'], $request['csr'], $request['email']);

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $response);
    	$this->json->show();
    }

    public function ajax_update_info($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	$db = hbm_db();

    	$apiCustom = $oAuth->generateAPICustom();
    	$aParams = array('call' => 'accountCreate', 'id' => $request['acct_id']);
    	$apiCustom->request($aParams);

    	$now = strtotime('now');

    	$db->query("UPDATE hb_ssl_order SET last_updated = {$now} WHERE order_id = {$request['order_id']}");

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign('aResponse', $response);
    	$this->json->show();
    }

    public function ajax_parse_csr($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->ParseCSRByValidateOrderParameters($request['csr'], $request['ssl_id']));
    	$this->json->show();
    }

    public function ajax_get_whois_by_domain($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->GetWhoisAndEmail($request['domain']));
    	$this->json->show();
    }

    public function ajax_get_contact_info($request)
    {
    	$db = hbm_db();
    	$qContact = $db->query("SELECT * FROM hb_ssl_order_contact WHERE order_id = {$request['orderId']}")->fetchAll();
    	$contact = array();
    	foreach($qContact as $v){
    		switch($v['address_type']){
    			case 0:
    				$contact['organization'] = array(
    				'name' => $v['organization_name']
    				, 'address' => $v['address']
    				, 'city' => $v['city']
    				, 'state' => $v['state']
    				, 'country' => $v['country']
    				, 'post_code' => $v['postal_code']
    				, 'phone' => $v['phone']
    				, 'ext' => $v['ext_number']
    				);
    				break;
    			case 1:
    			case 2:
    				$key = ($v['address_type'] == 1) ? 'admin' : 'tech';
    				$contact[$key] = array(
    						'firstname' => $v['firstname']
    						, 'lastname' => $v['lastname']
    						, 'job' => $v['job']
    						, 'phone' => $v['phone']
    						, 'email' => $v['email_approval']
    						, 'ext' => $v['ext_number']
    				);
    				break;
    		}
    	}
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $contact);
    	$this->json->show();
    }

    public function ajax_get_promo_code($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$db = hbm_db();
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$code = $request['code'];
    	$pid = $request['pid'];
    	$cyc = $request['cyc'];
    	$clientId = $request['cid'];

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->getPromotionPrice($code, $pid, $cyc, $clientId));
    	$this->json->show();

//     	$oAuth->getPromotionPrice($code, $pid, $price, $cyc);
    }

    public function ajax_get_country_list($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->countryList());
    	$this->json->show();

    }

    public function ajax_get_edit_contact($request)
    {
    	$db = hbm_db();
    	$orderId = $request['order_id'];

    	$contact = $db->query("
    			SELECT
    				sc.*
    				, a.product_id
    				, p.name AS product_name
    				, au.authority_name
    				, s.ssl_validation_id AS validation_id
    				, s.ssl_productcode AS product_code
    			FROM
    				hb_ssl_order_contact AS sc
    				, hb_accounts AS a
    				, hb_products AS p
    				, hb_ssl AS s
    				, hb_ssl_authority AS au
    			WHERE
    				sc.order_id = {$orderId}
    				AND a.order_id = sc.order_id
    				AND p.id = a.product_id
    				AND s.ssl_name = p.name
    				AND au.ssl_authority_id = s.ssl_authority_id


    	")->fetchAll();
    	$output = array();
    	$output['organize'] = array(
    			'Organization_Name' => ''
    			, 'Address' => ''
    			, 'City' => ''
    			, 'State_Province' => ''
    			, 'Postal_Code' => ''
    			, 'Phone_Number' => ''
    			, 'Country' => ''
    			, 'Postal_Code' => ''
    	);

    	$output['admin'] = array(
    		'First_Name' => ''
    		, 'Last_Name' => ''
    		, 'Email_Address' => ''
    		, 'Job_Title' => ''
    		, 'Phone_Number' => ''
    		, 'Ext_Number' => ''
    	);
    	if($contact[0]['authority_name'] == 'Verisign'){
    		$output['admin']['Organization_Name'] = '';
    		$output['admin']['Address'] = '';
    		$output['admin']['City'] = '';
    		$output['admin']['State_Province'] = '';
    		$output['admin']['Country'] = '';
    		$output['admin']['Postal_Code'] = '';
    	}
    	$output['tech'] = $output['admin'];

    	foreach($contact as $vv){
    		$key = '';
    		switch($vv['address_type']){
    			case 0: $key = 'organize'; break;
    			case 1: $key = 'admin'; break;
    			case 2: $key = 'tech'; break;
    		}
    		if($vv['firstname'] != '') $output[$key]['First_Name'] = $vv['firstname'];
    		if($vv['lastname'] != '') $output[$key]['Last_Name'] = $vv['lastname'];
    		if($vv['organization_name'] != '') $output[$key]['Organization_Name'] = $vv['organization_name'];
    		if($vv['address'] != '') $output[$key]['Address'] = $vv['address'];
    		if($vv['city'] != '') $output[$key]['City'] = $vv['city'];
    		if($vv['state'] != '') $output[$key]['State_Province'] = $vv['state'];
    		if($vv['country'] != '') $output[$key]['Country'] = $vv['country'];
    		if($vv['postal_code'] != '') $output[$key]['Postal_Code'] = $vv['postal_code'];
    		if($vv['phone'] != '') $output[$key]['Phone_Number'] = $vv['phone'];
    		if($vv['ext_number'] != '') $output[$key]['Ext_Number'] = $vv['ext_number'];
    		if($vv['email_approval'] != '') $output[$key]['Email_Address'] = $vv['email_approval'];
    		if($vv['job'] != '') $output[$key]['Job_Title'] = $vv['job'];
    	}

    	if($contact[0]['validation_id'] == 1 && $contact[0]['product_code'] != 'SSL123'){
    		unset($output['organize']);
    	}

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $output);
    	$this->json->show();
    }

    function ajax_update_edit_contact($request)
    {
    	$data = $request['edit_data'];
    	$db = hbm_db();
    	$order_id = $request['order_id'];
    	try{
	    	foreach($data as $k => $v){
	    		switch($k){
	    			case 'organize':
	    				$db->query("
	    						UPDATE
	    							hb_ssl_order_contact
	    						SET
	    							organization_name = :org_name
	    							, telephone = :phone
	    							, phone = :phone
	    							, address = :address
	    							, city = :city
	    							, state = :state
	    							, country = :country
	    							, postal_code = :postcode
	    						WHERE
	    							order_id = :orderId
	    							AND address_type = 0
	    						", array(
	    							':org_name' => $v['Organization_Name']
	    							, ':phone' => $v['Phone_Number']
	    							, ':address' => $v['Address']
	    							, ':city' => $v['City']
	    							, ':state' => $v['State_Province']
	    							, ':country' => $v['Country']
	    							, ':postcode' => $v['Postal_Code']
	    							, ':orderId' => $order_id
	    						)
	    				);
	    				break;
	    			case 'admin':
	    			case 'tech':
	    				$type = ($k == 'admin') ? 1 : 2;
	    				$db->query("
	    						UPDATE
	    							hb_ssl_order_contact
	    						SET
	    							firstname = :fname
	    							, lastname = :lname
	    							, email_approval = :email
	    							, organization_name = :org_name
	    							, job = :job
	    							, address = :address
	    							, city = :city
	    							, state = :state
	    							, country = :country
	    							, postal_code = :postcode
	    							, telephone = :phone
	    							, phone = :phone
	    							, ext_number = :ext_num
	    						WHERE
	    							order_id = :orderId
	    							AND address_type = :type
	    						", array(
	    							':fname' => (isset($v['First_Name'])) ? $v['First_Name'] : ''
	    							, ':lname' => (isset($v['Last_Name'])) ? $v['Last_Name'] : ''
	    							, ':email' => (isset($v['Email_Address'])) ? $v['Email_Address'] : ''
	    							, ':org_name' => (isset($v['Organization_Name'])) ? $v['Organization_Name'] : ''
	    							, ':job' => (isset($v['Job_Title'])) ? $v['Job_Title'] : ''
	    				    		, ':address' => (isset($v['Address'])) ? $v['Address'] : ''
	    				    		, ':city' => (isset($v['City'])) ? $v['City'] : ''
	    				    		, ':state' => (isset($v['State_Province'])) ? $v['State_Province'] : ''
	    				    		, ':country' => (isset($v['Country'])) ? $v['Country'] : ''
	    				    		, ':postcode' => (isset($v['Postal_Code'])) ? $v['Postal_Code'] : ''
	    				    		, ':phone' => (isset($v['Phone_Number'])) ? preg_replace('//', '', $v['Phone_Number']) : ''
	    				    		, ':ext_num' => (isset($v['Ext_Number'])) ? $v['Ext_Number'] : ''
	    				    		, ':orderId' => $order_id
	    							, ':type' => $type
	    				    	)
	    				);
	    				break;
	    		}
	    	}

	    	$this->loader->component('template/apiresponse', 'json');
	    	$this->json->assign("aResponse", array('status' => true));
	    	$this->json->show();

    	} catch(Exception $e){
    		$output = array('status' => false, 'error' => $e->errorInfo[2]);
    		$this->loader->component('template/apiresponse', 'json');
    		$this->json->assign("aResponse", $output);
    		$this->json->show();
    	}
    }

    public function ajax_validate_order($request)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$dns = '';
    	if($request["dns_name"]){
    		foreach($request["dns_name"] as $eDns){
    				$dns .= ($dns == '') ? $eDns : ",{$eDns}";
    		}
    	}

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->ValidateBeforeOrder(
    				$request["csr"]
    				, $request["ssl_id"]
	    			, $request["product_code"]
	    			, $request["is_wildcard"]
	    			, $request["validityPeriod"]
    				, $request["hashing_algorithm"]
	    			, $request["server_type"]
	    			, $request["san_amount"]
    				, $dns
	    			, $request["server_amount"]
    			)
    	);
// $this->json->assign('aResponse', $dns);
    	$this->json->show();
    }
}