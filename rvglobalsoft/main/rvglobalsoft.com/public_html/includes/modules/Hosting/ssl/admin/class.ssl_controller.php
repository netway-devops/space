<?php

/*************************************************************
 *
 * Hosting Module Class - SSL
 *
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 *
 *
 ************************************************************/

class ssl_controller extends HBController {

    protected $moduleName = 'ssl';
    /**
     *
     * Enter description here ...
     * @param $request
     */

    protected $admindata = array(
    	'access' => false,
    	'allow' => array(
			'suspend' => true,
    		'unsuspend' => true,
    		'terminate' => true,
    		'renewal' => true,
    	)
    );

    public function view($request) {

    }


    /**
     *
     * Enter description here ...
     * @param $params
     */
    public function accountdetails($params) {
    	if($params['account']['status'] == 'Terminated'){
    		$this->template->assign('term', 1);
    	}
    	$db         = hbm_db();
    	$api = new ApiWrapper();
//     	require_once HBFDIR_LIBS . 'RvLibs/SSL/Libs.php';
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
//     	$oAuth =& RvLibs_SSL_Libs::singleton();
    	$oAuthPHP =& RvLibs_SSL_PHPLibs::singleton();

    	$accountInfo = $params['account'];
    	$orderId = $accountInfo['order_id'];
    	$accountInfo = $this->getOrderDetail($orderId);

    	$ssl_type = $this->getSSLType($orderId);
    	$accountInfo['ssl_type'] = $ssl_type;

    	$isTestmode = $oAuthPHP->isTestMode();

    	if($isTestmode){
    		$this->template->assign('showorderid', true);
    		if(($accountInfo['authority_orderid'] != '' && $accountInfo['acct_status'] == 'Pending') || ($accountInfo['cert_status'] == 'Pending Reissue') || $accountInfo['acct_status'] == 'Renewing'){
    			$this->template->assign('dev', true);
    			if($accountInfo['cert_status'] == 'Pending Reissue'){
    				$this->template->assign('pending_reissue', true);
    			}
    		} else if($accountInfo['acct_status'] == 'Active'){
    			$this->template->assign('dev', true);
    		}
    	}
    	if($accountInfo['symantec_status'] == 'COMPLETED'){
    		$opt = array('ReturnCertificateInfo' => True, 'ReturnProductDetail' => True, 'ReturnFulfillment' => True, 'ReturnCACerts' => True, 'ReturnPKCS7Cert' => True);
    		$certStatus = $this->getCertStatus($accountInfo['partner_order_id']);
    		$certInfo = $oAuthPHP->GetOrderByPartnerOrderId($accountInfo['partner_order_id'], $opt);

    		$startDate = preg_replace('/(T)|(\+[0-9]{2}\:[0-9]{2})/', ' ', $certInfo['details']['certificateInfo']['startDate']);
    		$refundDate = ($isTestmode) ? $accountInfo['date_created'] : strtotime($startDate);
    		$now = strtotime('now');
    		$getCertDB = $db->query("SELECT cert_status FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    		if($getCertDB && $getCertDB['cert_status'] != '') $this->template->assign('cert_status_db', $getCertDB['cert_status']);

    		$this->template->assign('cert_status', ucfirst(strtolower($certStatus)));

    		$this->template->assign('cert_start_date', date('d F Y H:i:s', $refundDate));
    		$refundDate = $refundDate + (60*60*24*30);
    		$this->template->assign('thirty_day_refund', ($refundDate >= $now) ? true : false);
    	}

    	$cancelRequest = $this->getClientCancelRequest($accountInfo['acct_id']);

    	if($cancelRequest){
    		$this->template->assign('client_cancel_reason', $cancelRequest);
    	}

    	if($accountInfo['is_revoke']){
    		$this->template->assign('pending_revoke', 1);
    	}

    	$sslOrderDetailTPL = APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/admin/accounts_management.tpl';
    	$this->template->assign('custom_template', $sslOrderDetailTPL);
    	$this->template->assign('csslocation', APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/admin/accounts_management.css');
    	$this->template->assign('jslocation', APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/admin/accounts_management.js');
    	$this->template->assign('accounts', $accountInfo);
    	$this->template->assign('isTestMode', $isTestmode);

    }

    public function getOrderDetail($orderId)
    {
    	$db = hbm_db();
    	$orderDetail = $db->query("
    			SELECT
    				hso.*
    				, hi.id AS inv_id
    				, hi.status AS inv_status
    				, ha.id AS acct_id
    				, ha.status AS acct_status
    				, ho.notes
    			FROM
    				hb_ssl_order as hso
    				, hb_orders as ho
    				, hb_invoices as hi
    				, hb_accounts as ha
    			WHERE
    				hso.order_id = :order_id
    				AND ho.id = hso.order_id
    				AND hi.id = ho.invoice_id
    				AND ho.id = ha.order_id
    			", array(
    				':order_id' => $orderId
    			))->fetch();

    	if($orderDetail['acct_status'] == 'Renewing'){
	    	$renewInvoiceQuery = $db->query("
	    			SELECT
	    				i.status
	    				, i.id
	    			FROM
	    				hb_accounts AS a
	    				, hb_invoices AS i
	    				, hb_invoice_items AS ii
	    			WHERE
	    				a.order_id = {$orderId}
	    				AND a.id = ii.item_id
	    				AND ii.invoice_id = i.id
	    			ORDER BY
	    				i.id DESC
	    				LIMIT 0,1
	    	")->fetch();

	    	if($renewInvoiceQuery){
	    		$orderDetail['inv_status'] = $renewInvoiceQuery['status'];
	    		$orderDetail['inv_id'] = $renewInvoiceQuery['id'];
	    	}
    	}

    	$verificationCall = $db->query("SELECT time_verify_from, time_verify_to, time_verify_from2, time_verify_to2 FROM hb_ssl_order_contact WHERE order_id = {$orderId} AND address_type = 1")->fetch();
    	if($verificationCall){
    		$orderDetail['time_from'] = $verificationCall['time_verify_from'];
    		$orderDetail['time_to'] = $verificationCall['time_verify_to'];
    		$orderDetail['time_from2'] = $verificationCall['time_verify_from2'];
    		$orderDetail['time_to2'] = $verificationCall['time_verify_to2'];
    	}

    	$orderDetail["dns_name"] = explode(",", $orderDetail["dns_name"]);
    	return $orderDetail;
    }

    public function getCertStatus($partnerOrderID)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	$certStatus = $oAuth->getCertStatus($partnerOrderID);

    	return $certStatus;
    }

    public function getClientCancelRequest($accountId)
    {
    	$db = hbm_db();
    	$message = $db->query("SELECT account_id, reason FROM hb_cancel_requests WHERE account_id = {$accountId}")->fetch();
    	if(isset($message['account_id']) && $message['account_id'] != ''){
	    	return $message['reason'];
    	}
    	return false;
    }

    public function getContactDetail($orderId){
    	$db = hbm_db();
    	$contactDetail = $db->query("
    			SELECT
    				*
    			FROM
    				hb_ssl_order_contact
    			WHERE
    				order_id = :order_id
    			ORDER BY address_type ASC
    			", array(
    				':order_id' => $orderId
    			))->fetchAll();
    	return $contactDetail;
    }

    private function _order_process($params, $orderItrmInfo)
    {
    	$checked = 'checked = "checked"';
    	$this->template->assign('sta1' , ($orderItrmInfo['status_extend'] == '1' || $orderItrmInfo['status_extend'] == '') ? $checked : '');
    }

    public function ajax_authority_orderid($request) {
    	$this->loader->component('template/apiresponse', 'json');
    	$order_id = $request['order_id'];
    	$auth_orderid = $request['auth_orderid'];

    	$db         = hbm_db();
    	$orderItrmInfo = $db->query("
			UPDATE
    			hb_ssl_order
    		SET
    			authority_orderid = :authority_orderid
    		WHERE
    			order_id = :order_id
    	", array(
			':authority_orderid' => $auth_orderid,
    		':order_id' => $order_id
    	));

   	   	$this->json->assign("aResponse", array('status' => 'success'));
    	$this->json->show();
    }
	 public function ajax_updatecsr($request) {
    	$this->loader->component('template/apiresponse', 'json');
    	$order_id = $request['order_id'];
		$csr_old = $request['csr_old'];
		$csr_new = $request['csr_new'];
    	$db         = hbm_db();
		$csrlog= $db->query("
			INSERT INTO
    			 hb_ssl_csr_log
    		(id,order_id,csr_old,csr_new,i_date)
    		VALUEs(NULL,:order_id,:csr_old,:csr_new,:i_date)
    	", array(
    		':order_id' => $order_id,
    		':csr_old' => $csr_old,
    		':csr_new' => $csr_new,
    		':i_date' => time(),
    	));

    	$orderItrmInfo = $db->query("
			UPDATE
    			hb_ssl_order
    		SET
    			csr = :csr_new
    		WHERE
    			order_id = :order_id
    	", array(
			':csr_new' => $csr_new,
    		':order_id' => $order_id
    	));

   	   	$this->json->assign("aResponse", array('status' => 'success'));
    	$this->json->show();
    }

    public function ajax_set_status($request){
        $db = hbm_db();

        $this->loader->component('template/apiresponse', 'json');
        $aResponse = array();
        $errorMsg = '';
        try {
            $db->query("
                        UPDATE hb_ssl_order
                        SET symantec_status = :ssl_status
                        WHERE order_id = :order_id
                        ",array(
                               ':order_id'  =>  $request['order_id']     ,
                               ':ssl_status'    => $request['ssl_status']
                        ));
            if($request['ssl_status'] == 'WAITING_SUBMIT_DOCUMENT'){
                require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
                $oAuth =& RvLibs_SSL_PHPLibs::singleton();
                $oAuth->sendMailDocumentToClient($request['order_id']);
            }

            $this->json->assign("aResponse", array(
                        'status' => 'success',
                        'message' => "Status has been updated already.",
                ));

        }catch(PDOException $e){
            $this->json->assign("aResponse", array(
                        'status' => 'ERROR',
                        'message' => $e->getMessage()
                    ));
                $this->json->show();
        }
        $this->json->show();
    }

    public function ajax_upload_csr($request){
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

    public function getSSLType($orderId)
    {
    	$db = hbm_db();

    	$sslType = $db->query('
    			SELECT
    				s.ssl_name
    				, sv.validation_name
    			FROM
    				hb_ssl_order AS so
    				, hb_ssl AS s
    				, hb_ssl_validation AS sv
    			WHERE
    				so.order_id = :orderId
    				AND so.ssl_id = s.ssl_id
    				AND sv.ssl_validation_id = s.ssl_validation_id
    			', array(
    				':orderId' => $orderId
    			)
    	)->fetch();
    	if(strpos($sslType['validation_name'], '(DV)') > -1){
    		return 'DV';
    	} else if(strpos($sslType['validation_name'], '(EV)') > -1){
    		return 'EV';
    	} else if(strpos($sslType['validation_name'], '(OV)') > -1){
    		return 'OV';
    	}
    	return null;
    }

    public function ajax_parsecsr($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
		$parseResponse = $oAuth->ParseCSR($input['csr']);
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $parseResponse);
    	$this->json->show();
    }

    public function ajax_getwhois($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_Libs::singleton();

    	$whois = $oAuth->GetWhoisByDomain($input['domain']);

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $whois);
    	$this->json->show();
    }

    public function ajax_get_email_approval($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign('aResponse', $oAuth->GetQuickApproverList($input['domain']));
    	$this->json->show();
    }

    public function ajax_getcontactinfo($input)
    {
    	$db = hbm_db();
    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $db->query("SELECT * FROM hb_ssl_order_contact WHERE order_id = {$input['orderid']} ORDER BY address_type ASC")->fetchAll());
    	$this->json->show();
    }

    public function ajax_getbillingcontact($input)
    {
    	$output = array();
    	$api = new ApiWrapper();

    	$clientDetail = $api->getClientDetails(array('id' => $input['clientid']));
    	$clientDetail = $clientDetail['client'];

    	$output['firstname'] = $clientDetail['firstname'];
    	$output['lastname'] = $clientDetail['lastname'];
    	$output['email'] = $clientDetail['email'];
    	$output['organization'] = $clientDetail['companyname'];
    	$output['job'] = '';
    	$output['city'] = $clientDetail['city'];
    	$output['state'] = $clientDetail['state'];
    	$output['country'] = $clientDetail['country'];
    	$output['postcode'] = $clientDetail['postcode'];
    	$output['phone'] = $clientDetail['phonenumber'];
    	$output['ext'] = '';
    	$output['address'] = $clientDetail['address1'];
    	if($clientDetail['address2'] != ''){
    		$output['address'] .= ' ' . $clientDetail['address2'];
    	}
    	if($clientDetail['address3'] != ''){
    		$output['address'] .= ' ' . $clientDetail['address3'];
    	}

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $output);
    	$this->json->show();
    }

    public function ajax_updatesslorder($input)
    {
    	$db = hbm_db();
    	$db->query("
    		UPDATE
    			hb_ssl_order
    		SET
    			csr = '{$input['csr']}'
    			, email_approval = '{$input['email']}'
    			, server_type = '{$input['servertype']}'
    			, commonname = '{$input['domain']}'
    			, symantec_status = 'WAITING_SUBMIT_ORDER'
    			, custom_techaddress = 1
    		WHERE
    			order_id = '{$input['orderid']}'
    	");
    }

    public function ajax_updatesslcontact($input)
    {
    	$db = hbm_db();
    	$mdcsr = md5($input['csr']);
    	for($i = 0; $i < 3; $i++){
    		$check = array();
    		switch($i){
    			case 0 :
    				$data = json_decode($input['organization']);
    				break;
    			case 1 :
    				$data = json_decode($input['admin']);
    				break;
    			case 2 :
    				$data = json_decode($input['tech']);
    				break;
    		}
    		$check = $db->query("SELECT address_type FROM hb_ssl_order_contact WHERE address_type = {$i} AND order_id = {$input['orderid']}")->fetchAll();
	    	if(sizeof($check) > 0){
	    		$db->query("
	    			UPDATE
	    				hb_ssl_order_contact
	    			SET
	    				client_id = {$input['clientid']}, order_id = {$input['orderid']}, csr_md5 = '{$mdcsr}',
	    				domain_name = '{$input['domain']}', firstname = '{$data->firstname}', lastname = '{$data->lastname}',
	    				organization_name = '{$data->organization}', address = '{$data->address}', city = '{$data->city}',
	    				state = '{$data->state_and_region}', country = '{$data->country}', postal_code = '{$data->postcode}',
	    				job = '{$data->job}', telephone = '{$data->phone}', phone = '{$data->phone}', email_approval = '{$data->email}',
	    				ext_number = '{$data->ext}'
	    			WHERE
	    				address_type = {$i}
	    				AND order_id = {$input['orderid']}
	    		");
	    	} else {
	    		$db->query("
	    			INSERT INTO
	    				hb_ssl_order_contact
	    					(
	    						client_id, order_id, csr_md5, domain_name, firstname,
	    						lastname, organization_name, address, city,
	    						state, country, postal_code, job, telephone,
	    						phone, email_approval, address_type, ext_number
	    					)
	    				VALUES
	    					(
	    						{$input['clientid']}, {$input['orderid']}, '{$mdcsr}', '{$input['domain']}', '{$data->firstname}',
	    						'{$data->lastname}', '{$data->organization}', '{$data->address}', '{$data->city}',
	    						'{$data->state_and_region}', '{$data->country}', '{$data->postcode}', '{$data->job}', '{$data->phone}',
	    						'{$data->phone}', '{$data->email}', {$i}, '{$data->ext}'

	    					)
	    		");
	    	}
    	}
    }

    public function ajax_submitorder($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$db = hbm_db();
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

//     	$apiCustom = $oAuth->generateAPICustom();
//     	$aQuery = $db->query("SELECT id FROM hb_accounts WHERE order_id = {$input['orderid']}")->fetch();
//     	$orderResponse =  $apiCustom->request(array('call' => 'accountCreate', 'id' => $aQuery['id']));

    	$orderResponse = $oAuth->QuickOrder($input['orderid']);

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $orderResponse);
    	$this->json->show();
    }

    public function ajax_checkstatus($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$db = hbm_db();
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();


    	$response = $oAuth->checkStatus($input['orderid']);
	    $checkComplete = $db->query("SELECT symantec_status, cert_status FROM hb_ssl_order WHERE order_id = {$input['orderid']}")->fetch();

	    if($checkComplete['symantec_status'] == 'COMPLETED' && $checkComplete['cert_status'] == 'Active'){
	    	$db->query("UPDATE hb_accounts SET status = 'Active' WHERE order_id = {$input['orderid']}");
	    }

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $checkComplete);
    	$this->json->show();

    }

	public function ajax_updateData($input) 
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
		$db = hbm_db();
		$runtime = strtotime(date('Y-m-d H:i:s'));
		$dateCreate = str_replace('/','-',$input['date_created']);
		$dateCreated = strtotime($dateCreate);
		$dateExpire = str_replace('/','-',$input['date_expire']);
		$dateExpired = strtotime($dateExpire);
		
		$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	//$response = $oAuth->checkStatus($input['orderid']);
	    $checkOrder = $db->query("
						SELECT * 
						FROM hb_ssl_order 
						WHERE order_id = {$input['orderid']}
					")->fetch();

		if($input['invoiceStatus'] == 'Paid'){
			if(isset($checkOrder['order_id']) && ($checkComplete['symantec_status'] != 'COMPLETED'||$checkComplete['symantec_status'] == 'COMPLETED')){
				
				
				$db->query("
					UPDATE hb_ssl_order 
					SET  date_created  = '{$dateCreated}'
						,last_updated  = '{$runtime}'
						,code_certificate = '{$input['servCertFocus']}'
						,code_ca		  = '{$input['caCertFocus']}'	
						,type_ca		  = '{$input['caType']}'	
						,code_pkcs7       = '{$input['pkcs7Focus']}'
						,date_expire      = '{$dateExpired}'
						,authority_orderid = '{$input['authorityOrderid']}'	
						,symantec_status   = '{$input['status']}'
						
					WHERE order_id     = {$checkOrder['order_id']}
				");
			}

		}else{
			mail('jaruwan','pass',$input);
			if(isset($checkOrder['order_id']) && $checkComplete['symantec_status'] != 'COMPLETED'){
			
				$db->query("
					UPDATE hb_ssl_order 
				SET last_updated   = '{$runtime}'
					,authority_orderid = '{$input['authorityOrderid']}'
					,symantec_status   = '{$input['status']}' 
				WHERE order_id     = {$checkOrder['order_id']}
				");
			}
		}

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $checkComplete);
    	$this->json->show();
    }
    public function ajax_modifyorder($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	switch($input['modifyaction']){
    		case 'Approve':
    		case 'Cancel':
    			$oAuth->ModifyOrder($input['partnerorderid'], $input['modifyaction']);
    			$oAuth->checkStatus($input['orderid']);
    			break;
    		case 'Complete':
    			$oAuth->ModifyOrder($input['partnerorderid'], 'APPROVE');
    			$oAuth->ModifyOrder($input['partnerorderid'], 'SYNC');
    			$oAuth->ModifyOrder($input['partnerorderid'], 'APPROVE');
    			$oAuth->ModifyOrder($input['partnerorderid'], 'RESELLER_APPROVE');
    			$oAuth->checkStatus($input['orderid']);
    			break;
    		case 'standbyRevoke':
    			$db = hbm_db();
    			$dateCreate = $db->query("SELECT date_created FROM hb_ssl_order WHERE order_id = :orderId", array(":orderId" => $input['orderid']))->fetch();
    			$dateCreate = $dateCreate['date_created'];
    			$dateCreate = $dateCreate - 2678400;
    			$db->query("UPDATE hb_ssl_order SET date_created = :date_created WHERE order_id = :orderId", array(":date_created" => $dateCreate, ":orderId" => $input["orderid"]));
    			break;
    	}
    }

    public function ajax_cancel_order($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	$db = hbm_db();

		$modifyOutput = $oAuth->ModifyOrder($input['partnerorderid'], 'Cancel', array('order_id' => $input['orderid']));
		if($modifyOutput['status']){
			$oAuth->checkStatus($input['orderid']);
			$db->query("UPDATE hb_ssl_order SET cron_update = 1 WHERE order_id = {$input['orderid']}");
			$output = true;
		} else {
			$output = $modifyOutput;
		}
		$this->loader->component('template/apiresponse', 'json');
		$this->json->assign("aResponse", $output);
		$this->json->show();
   }

    public function ajax_checktime($input)
    {
    	$date = str_replace('/', '-', $input['date']);

    	$from = $input['from'];
    	$to = $input['to'];
    	$gmt = $input['gmt'];
    	$state = $input['state'];

    	date_default_timezone_set('UTC');
    	$this->loader->component('template/apiresponse', 'json');
    	$output = '';

    	$g = intval($gmt) * (-1);
    	$gout = ($g > 0) ? '+' . $g : strval($g);
    	$nowTime = date('d/m/Y H:i', strtotime('now') + ($g*60*60));
    	$gmt = intval($gmt) * (60*60);
    	if($state != 3){
    		$timeFrom = ($from == 'now') ? strtotime('now') : strtotime($date . ' ' . $from) + $gmt;
    		$timeTo = strtotime($date . ' ' . $to) + $gmt;
    		if($from == 'now' && $timeFrom >= $timeTo){
    			$output = "Verification Call {$state}: Appointment time cannot be less than now.({$nowTime} at GMT {$gout})";
    		} else if($timeFrom > $timeTo){
    			$output = "Verification Call {$state}: Appointment time from cannot call before or same appointment time to.";
    		}
    	} else {
    		$dateex = explode('AND', $date);
    		$timeFrom = strtotime($dateex[0] . ' ' . $from) + $gmt;
    		$timeTo = strtotime($dateex[1] . ' ' . $to) + $gmt;
    		if($timeFrom > $timeTo){
    			$output = "Verification Call 2 : Verification call 1 must be called before verification call 2.";
    		}
    	}

    	$this->json->assign("aResponse", $output);
    	$this->json->show();

    }

    public function ajax_updatetime($input)
    {
    	$db = hbm_db();
    	date_default_timezone_set('UTC');
    	$date1 = str_replace('/', '-', $input['date']);
    	$date2 = str_replace('/', '-', $input['date2']);
    	$from1 = $input['from'];
    	$from2 = $input['from2'];
    	$to1 = $input['to'];
    	$to2 = $input['to2'];
    	$gmt = $input['gmt'];
    	$gmt = intval($gmt) * (-1);
    	$gmt = ($gmt > 0) ? '+' . $gmt : strval($$gmt);

    	$from1 = date('Y-m-d H:i:00', strtotime($date1 . ' ' . $from1)) . ' GMT' . $gmt;
    	$to1 = date('Y-m-d H:i:00', strtotime($date1 . ' ' . $to1)) . ' GMT' . $gmt;
    	$db->query("UPDATE hb_ssl_order_contact SET time_verify_from = '{$from1}', time_verify_to = '{$to1}' WHERE order_id = {$input['orderid']}");
    	if($date2 != 'No Detail'){
    		$from2 = date('Y-m-d H:i:00', strtotime($date2 . ' ' . $from2)) . ' GMT' . $gmt;
    		$to2 = date('Y-m-d H:i:00', strtotime($date2 . ' ' . $to2)) . ' GMT' . $gmt;
    		$db->query("UPDATE hb_ssl_order_contact SET time_verify_from2 = '{$from2}', time_verify_to2 = '{$to2}' WHERE order_id = {$input['orderid']}");
    	} else {
    		$db->query("UPDATE hb_ssl_order_contact SET time_verify_from2 = '', time_verify_to2 = '' WHERE order_id = {$input['orderid']}");
    	}

    	$db->query("UPDATE hb_ssl_order SET symantec_status = 'RV_WF_AUTHORIZATION' WHERE order_id = {$input['orderid']}");
    }

    public function ajax_reissue($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();
    	$db = hbm_db();

    	if($input['email'] == ''){
    		$aQuery = $db->query("SELECT email_approval FROM hb_ssl_order_contact WHERE order_id = {$input['order_id']} AND address_type = 2")->fetch();
    		$input['email'] = $aQuery['email_approval'];
    	}

    	$response = $oAuth->reissue($input['order_id'], $input['csr'], $input['email']);

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $response);
    	$this->json->show();
    }

    public function ajax_revoke($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$db = hbm_db();
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->Revoke($input['orderid'], $input['reason'], $input['type']));
    	$this->json->show();
    }

    public function get_email_template_lib($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->get_email_template());
    	$this->json->show();
    }

    public function update_email_template($input)
    {
    	$db = hbm_db();
    	$check = $db->query("SELECT * FROM hb_ssl_email_templates WHERE code = '{$input['emailcode']}'")->fetch();

    	if($check){
    		$db->query("UPDATE hb_ssl_email_templates SET email_to = '{$input['emailto']}', email_template_id = {$input['emailtempid']} WHERE code = '{$input['emailcode']}'");
    	} else {
    		$db->query("INSERT INTO hb_ssl_email_templates (code, email_to, email_template_id) VALUES ('{$input['emailcode']}', '{$input['emailto']}', {$input['emailtempid']})");
    	}
    }

    public function delete_email_template($input)
    {
    	$db = hbm_db();
    	$db->query("DELETE FROM hb_ssl_email_templates WHERE id = {$input['id']}");
    }

    public function get_email_template_variable($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->get_email_template_variable($input['orderid']));
    	$this->json->show();
    }

    public function test_email_template($input)
    {
    	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

    	$this->loader->component('template/apiresponse', 'json');
    	$this->json->assign("aResponse", $oAuth->test_email($input['emailorderid'], $input['emailto'], $input['emailcode'], $input['test']));
    	$this->json->show();
    }
}
