<?php

class RvLibs_SSL_Libs
{
    private static $instance = null;

    function __construct()
    {

    	require_once HBFDIR_LIBS . 'RvLibs/RVSymantecApi.php';
    	require_once APPDIR . 'class.api.custom.php';
     	header('Content-type: text/html; charset=utf-8');

        if(file_exists(HBFDIR_LIBS . 'RvLibs/SSL/developer.php')) {
        	//$apiCustom  = ApiCustom::singleton((isset($_SERVER['HTTP_HOST']) && $_SERVER['HTTP_HOST'] != '') ? : 'rvglobalsoft.com' . '/7944web/api.php');
        	$this->apiCustom  = ApiCustom::singleton('http://hostbill.rvglobalsoft.net/7944web/api.php');
            $this->apiConnect =& RVSymantecApi::connect('4668249TES89180', 'rvtestapi', 'netwaY_12', true);
        //  $this->apiConnect =& RVSymantecApi::connect('4600590NOT94031', 'librarytest', '1libraryTest$', true);
            $this->contractId = 'JPNO883318';
        } else {
            $this->apiConnect =& RVSymantecApi::connect('3624834WEB13231', 'webexperts-api', '^^RV$ssl$95^^', false);
        	$this->apiCustom  = ApiCustom::singleton('https://rvglobalsoft.com/7944web/api.php');
            $this->contractId = 'ONG961004';
        }
    }

    function &singleton($force = false)
    {
        if (is_null(self::$instance) === true || $force === true) {
            $classname = __CLASS__;
            self::$instance = new $classname;
        }
        return self::$instance;
    }

    public function setContractId($ssl_id)
    {
    	if(!file_exists(HBFDIR_LIBS . 'RvLibs/SSL/developer.php')) {
	    	$db = hbm_db();
	    	$contractQuery = $db->query("
	                        SELECT
	                            ssl_contract_id
	                        FROM
	                            hb_ssl
	                        WHERE
	                            ssl_id = :sslId
	                    	", array(
	    	                	':sslId' => $ssl_id
	    	                )
	    	)->fetch();
	        $contractId = $contractQuery['ssl_contract_id'];
	        if($contractId != null && $contractId != ''){
	        	return $contractId;
	        }
    	}
    	return $this->contractId;
    }

    public function apiConnectionInfo()
    {
    	$info = $this->apiConnect->getInfo();
    	$info->contractId = $this->contractId;
    	return $info;
    }

    public function Hello($inp)
    {
    	$inputResponse = $this->apiConnect->hello($inp);
    	return $this->obj2arr($inputResponse);
    }

    public function GetUserAgreement($product, $type)
    {
    	return $this->apiConnect->GetUserAgreement($product, array('AgreementType' => $type));
    }

    public function ParseCSR($csr)
    {
        $csr = trim($csr);
        $parsed = array();
        $parseCsr = $this->apiConnect->ParseCSR($csr, array());

        if($parseCsr->status == 1 && empty($parseCsr->details->ParseCSRResult->QueryResponseHeader->Errors)){
            $domain = $parseCsr->details->ParseCSRResult->DomainName;

            $parsed['C'] = $parseCsr->details->ParseCSRResult->Country;
            $parsed['ST'] = $parseCsr->details->ParseCSRResult->State;
            $parsed['L'] = $adminDetails->address->city;
            $parsed['O'] = $parseCsr->details->ParseCSRResult->Organization;
            $parsed['Ltd.'] = '';
            $parsed['OU'] = $parseCsr->details->ParseCSRResult->OrganizationUnit;
            $parsed['Ltd., OU'] = $parseCsr->details->ParseCSRResult->OrganizationUnit;
            $parsed['CN'] = $parseCsr->details->ParseCSRResult->DomainName;
            $parsed['KeyAlgorithm'] = '';
            $parsed['KeyLength'] = '';
            $parsed['SignatureAlgorithm'] = '';
            $parsed['Signature'] = '';
            $parsed['E'] = $parseCsr->details->ParseCSRResult->Email;

            foreach($parsed as $k => $v){
                if($v == '' && $k != 'status'){
                    $parsed[$k] = '-';
                }
            }

            $parsed['status']['rvApi'] = $parseCsr->status;
            $parsed['status']['parseStatus'] = 1;

        } else {
            $parsed['status']['rv'] = $parseCsr->status;
            $parsed['status']['parseStatus'] = 0;
            if(isset($parseCsr->details->ParseCSRResult->QueryResponseHeader->Errors)){
                foreach($parseCsr->details->ParseCSRResult->QueryResponseHeader->Errors as $k => $v){
                    switch($v->Error->ErrorMessage){
                        case 'CSR Parse Failure.  Error Message: Unable to Parse CSR: badly encoded request':
                            $v->Error->ErrorMessage = 'Invalid CSR. Please confirm the content of your CSR and try again.';
                            break;
                        case 'CSR Parse Failure.  Error Message: Unable to Parse CSR: org.bouncycastle.asn1.DERTaggedObject cannot be cast to org.bouncycastle.asn1.DERInteger':
                            $v->Error->ErrorMessage = 'Not a CSR: You have supplied a certificate instead of a certificate signing request (CSR). Enter your CSR.';
                            break;
                        case 'Required Field Missing: CSR  -Please supply required field and resubmit request':
                            $v->Error->ErrorMessage = 'Required Field Missing: Please enter your CSR in the required field and resubmit request.';
                            break;
                    }
                    $parsed['error'][] = array(
                    		'code' => $v->Error->ErrorCode
                    		, 'message' => $v->Error->ErrorMessage
                    );
                }
            }
        }
        return $parsed;
    }

    public function ParseCSRByValidateOrderParameters($csr)
    {
    	$parsed = array();
    	if($csr != ''){
	    	$validateResponse = $this->apiConnect->ValidateOrderParameters('', array('CSR' => $csr), array());
	    	$result = $validateResponse->details->ValidateOrderParametersResult;
	    	if($result->OrderResponseHeader->SuccessCode >= 0){
	    		$parsedCsr = $result->ParsedCSR;
	    		if($this->checkKeySize($csr)){
		    		$parsed['Csr'] = $csr;
		    		$parsed['Country'] = $parsedCsr->Country;
		    		$parsed['State'] = $parsedCsr->State;
		    		$parsed['Locality'] = $parsedCsr->Locality;
		    		$parsed['Organization'] = $parsedCsr->Organization;
		    		$parsed['OrganizationUnit'] = $parsedCsr->OrganizationUnit;
		    		$parsed['CommonName'] = $parsedCsr->DomainName;
		    		$parsed['KeyAlgorithm'] = $parsedCsr->EncryptionAlgorithm;
		    		$parsed['SignatureAlgorithm'] = $parsedCsr->HashAlgorithm;
	// 	    		$parsed['DNSNames'] = (isset($parsedCsr->DNSNames) && $parsedCsr->DNSNames != '') ? explode(',', $parsedCsr->DNSNames) : false;
		    		$parsed['Email'] = $parsedCsr->Email;
		    		$parsed['Status'] = True;

		    		if(isset($parsedCsr->DNSNames) && $parsedCsr->DNSNames != ''){
		    			$exDNS = explode(',', $parsedCsr->DNSNames);
		    			foreach($exDNS as $index => $eachDNS){
		    				if($eachDNS == $parsedCsr->DomainName){
		    					unset($exDNS[$index]);
		    				}
		    			}
		    			$parsed['DNSNames'] = array();
		    			foreach($exDNS as $eachName){
		    				array_push($parsed['DNSNames'], $eachName);
		    			}
		    		} else {
		    			$parsed['DNSNames'] = false;
		    		}
	    		} else {
	    			$parsed['Status'] = False;
	    			$parsed['Error'][] = array('ErrorCode' => '-8001', 'ErrorMessage' => 'Your CSR contains a key size that is no longer considered secure. Security best practices require a minimum key size of 2048 bits. Please submit a new CSR with a minimum 2048 bit key size<br />You can check the CSR of the order: <a href="https://cryptoreport.websecurity.symantec.com/checker/views/csrCheck.jsp" target="_blank">https://cryptoreport.websecurity.symantec.com/checker/views/csrCheck.jsp</a>');
	    		}

	    	} else {
	    		$error = $result->OrderResponseHeader;
	    		foreach($error->Errors as $k => $v){
	    			$parsed[] = $v;
	    			if($v->Error->ErrorCode < 0){
		    			$parsed['Error'][] = array(
		    					'ErrorCode' => $v->Error->ErrorCode
		    					, 'ErrorMessage' => $v->Error->ErrorMessage
		    			);
	    			}
	    		}
	    		$parsed['Status'] = False;
	    	}
    	} else {
    		$parsed['Status'] = False;
    		$parsed['Error'][] = array('ErrorCode' => '-2001', 'ErrorMessage' => 'Required Field Missing: CSR  -Please supply required field and resubmit request');
    	}
    	return $parsed;
    }

    public function getKeySize($csr)
    {
    	error_reporting(E_ERROR | E_PARSE);
    	$csr = ' ' . trim($csr);
    	$data = substr($csr, strpos($csr, '-----BEGIN CERTIFICATE REQUEST-----')+strlen('-----BEGIN CERTIFICATE REQUEST-----'));
    	$data = substr($data, 0, strpos($data, '-----END CERTIFICATE REQUEST-----'));
    	$data = str_replace(' ', '', $data);
    	$csr = '-----BEGIN CERTIFICATE REQUEST-----' . $data . '-----END CERTIFICATE REQUEST-----';
    	$info = openssl_csr_get_public_key($csr);
    	if($info){
    		$info = openssl_pkey_get_details($info);
    		return (isset($info['bits'])) ? $info['bits'] : false;
    	}
    	return false;
    }

    public function checkKeySize($csr)
    {
    	$keySize = $this->getKeySize($csr);
    	return (isset($keySize) && $keySize > 1024) ? true : false;
    }

    public function ValidateOrderParameters($productCode, $csr, $period = '', $domainName, $options=array())
    {
        $orderParams = array(
            'ValidityPeriod' => $period,
            'CSR' => $csr,
            'DomainName' => $domainName
        );
        $validateResponse = $this->apiConnect->ValidateOrderParameters($productCode, $orderParams, $options);

        return $this->obj2arr($validateResponse);
    }

    public function GetWhoisByDomain($domain)
    {
        require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
        $oAuth =& RvLibs_RvGlobalSoftApi::singleton();
        $aSSLList = $oAuth->request('post', 'whois', array('domain' => $domain));
        unset($aSSLList->rawdata);
        unset($aSSLList->regyinfo);

        $response = (object) array();
        if(isset($aSSLList->regrinfo->registered) && $aSSLList->regrinfo->registered == 'yes'){
        	$regrinfo = $aSSLList->regrinfo;
        	$response = (object) array();
        	$role = array('owner', 'admin', 'tech');

        	for($i = 0; $i < 3; $i++){
        		if(!isset($regrinfo->{$role[$i]}->name) || sizeof(split(' ', $regrinfo->{$role[$i]}->name)) != 2 || $regrinfo->{$role[$i]}->name == ''){
        			$response->{$role[$i]}->firstName = '';
        			$response->{$role[$i]}->lastName = '';
        		} else {
        			$splitname = split(' ', $regrinfo->{$role[$i]}->name);
        			$response->{$role[$i]}->firstName = $splitname[0];
        			$response->{$role[$i]}->lastName = $splitname[1];
        		}
        		$response->{$role[$i]}->organization = (isset($regrinfo->{$role[$i]}->organization)) ? $regrinfo->{$role[$i]}->organization : '';
        		$response->{$role[$i]}->phone = (isset($regrinfo->{$role[$i]}->phone)) ? $regrinfo->{$role[$i]}->phone : '';
        		$response->{$role[$i]}->email = (isset($regrinfo->{$role[$i]}->email)) ? $regrinfo->{$role[$i]}->email : '';

        		if(isset($regrinfo->{$role[$i]}->address)){
        			$response->{$role[$i]}->address = $regrinfo->{$role[$i]}->address->street[0];
        			$response->{$role[$i]}->city = $regrinfo->{$role[$i]}->address->city;
        			$response->{$role[$i]}->state = $regrinfo->{$role[$i]}->address->state;
        			$response->{$role[$i]}->postal = $regrinfo->{$role[$i]}->address->pcode;
        			$response->{$role[$i]}->country = str_replace(': ', '', $regrinfo->{$role[$i]}->address->country);
        		} else {
        			$response->{$role[$i]}->warning = 'no address';
        		}
        	}
        	$response->status = 1;
        	$response->domain->name = $domain;
        } else if (isset($aSSLList->regrinfo->registered) && $aSSLList->regrinfo->registered == 'unknown'){
        	$response->status = 0;
        	$response->error = "Your CSR cannot be verified, as it might be incomplete or broken. Please provide your CSR letter to <a href='https://rvglobalsoft.com/tickets/new&deptId=3/tickets/new&deptId=3'  target='_blank'>RV Staff</a> in order to help you check it.";
        } else {
        	$response->status = 0;
        	$response->error = 'Not a registered domain.';
        }

        return $response;
    }

    public function GetWhoisAndEmail($domain)
    {
    	$whoisData = $this->GetWhoisByDomain($domain);
    	if($whoisData->status){
    		$emailApproval = $this->GetQuickApproverList($domain);
    		$mail = array();
    		foreach($emailApproval as $v){
    			$ex = explode('@', $v);
    			if(empty($mail[$ex[1]])){
    				$mail[$ex[1]] = array();
    			}
    			array_push($mail[$ex[1]], $v);
    		}
    		$whoisData->emailApproval = $mail;
    	}
    	return $whoisData;
    }

    public function QuickOrder($orderId, $renewalIndicator = false)
    {
        $response = array();
        $db = hbm_db();
        $supportStatus = $db->query("
                        SELECT
        					hs.ssl_id
                           , hsa.api_method
        					, hs.support_for_san
        					, hs.san_startup_domains
                        FROM
                            hb_ssl AS hs
                            , hb_ssl_authority AS hsa
                            , hb_ssl_order AS hso
                        WHERE
                            hso.order_id = :orderId
                            AND hso.ssl_id = hs.ssl_id
                            AND hs.ssl_authority_id = hsa.ssl_authority_id
                    ", array(
                        ':orderId' => $orderId
                    )
        )->fetch();

        if($supportStatus['api_method'] == 'Symantec'){
            $clientDetails = $db->query("
                        SELECT
                            hso.csr
                            , hso.contract
                            , hso.server_type
                            , hsoc.*
                            , hs.ssl_productcode
                            , hs.secure_subdomain
            				, hso.dns_name
            				, hso.san_amount
            				, hso.server_amount
            				, hso.hashing_algorithm
                        FROM
                            hb_ssl_order AS hso
                            , hb_ssl_order_contact AS hsoc
                            , hb_ssl AS hs
                        WHERE
                            hso.order_id = :orderId
                            AND hso.order_id = hsoc.order_id
                            AND hs.ssl_id = hso.ssl_id
            				ORDER BY address_type ASC
                        ", array(
                            ':orderId' => $orderId
                        )
            )->fetchAll();
            $sanNum = $clientDetails[0]['san_amount'];
            $servNum = ($clientDetails[0]['server_amount'] > 1) ? $clientDetails[0]['server_amount'] : 1;
            $dnsName = $clientDetails[0]['dns_name'];
            $hashing = $clientDetails[0]['hashing_algorithm'];


            $approvalEmail = $db->query("
                    SELECT
                        email_approval
                    FROM
                        hb_ssl_order
                    WHERE
                        order_id = :orderId
                ", array(
                    ':orderId' => $orderId
                )
            )->fetch();

            if(sizeof($clientDetails) > 0){
                $role = array('organizationInfo', 'adminContact', 'techContact');
                $organizationInfo = array();
                foreach($clientDetails as $k => $v){
                	if($v['address_type'] == 0){
                		$organizationInfo = array(
                				'OrganizationName' => $v['organization_name'],
                				'OrganizationAddress'   => array(
                						'AddressLine1'          => $v['address'],
                						'AddressLine2'          => '', // Optional
                						'AddressLine3'          => '', // Optional
                						'City'                  => $v['city'],
                						'Region'                => $v['state'],
                						'PostalCode'            => $v['postal_code'],
                						'Country'               => strtoupper($v['country']),
                						'Phone'                 => $v['phone']
                				)
                		);
                	} else {
                		${$role[$v['address_type']]} = array(
                					'FirstName' => isset($v['firstname']) ? $v['firstname'] : 'none',
                					'LastName' => isset($v['lastname']) ? $v['lastname'] : 'none',
                					'Phone' => isset($v['phone']) ? $v['phone'] : 'none',
                					'Email' => isset($v['email_approval']) ? $v['email_approval'] : 'none',
                					'Title' => isset($v['job']) ? $v['job'] : 'none',
                					'OrganizationName' => isset($v['organization_name']) ? $v['organization_name'] : 'none',
                					'AddressLine1' => isset($v['address']) ? $v['address'] : 'none',
                					'City' => isset($v['city']) ? $v['city'] : 'none',
                					'Region' => isset($v['state']) ? $v['state'] : 'none',
                					'PostalCode' => isset($v['postal_code']) ? $v['postal_code'] : 'none',
                					'Country' => isset($v['country']) ? $v['country'] : 'none'
                					//                             'OrganizationName'  => isset($v['organization_name']) ? $v['organization_name'] : 'none',
                					//                             'AddressLine1'      => isset($v['address']) ? $v['address'] : 'none',
                					//'AddressLine2'      => '', // Optional
                					//                             'City'              => isset($v['city']) ? $v['city'] : 'none',
                					//                             'Region'            => isset($v['state']) ? $v['state'] : 'none',
                					//                             'PostalCode'        => isset($v['postal_code']) ? $v['postal_code'] : 'none',
                					//                             'Country'           => isset($v['country']) ? strtoupper($v['country']) : 'none'
                		);
                		if($v['address_type'] == 1){
                            $productCode = $v['ssl_productcode'];
                        }
                    }
                }
//                 if(sizeof($clientDetails) == 2){
//                     $techContact = $adminContact;
//                     $techContact['Title'] = 'none';
//                 }

                $orderParameters = array( 'WildCard' => ($clientDetails[0]['secure_subdomain'] == 1) ? True : False
                            , 'ContractID' => $this->setContractId($supportStatus['ssl_id'])
                            , 'ValidityPeriod' => $clientDetails[0]['contract']
                            , 'CSR' => $clientDetails[0]['csr']
                            , 'WebServerType' => $clientDetails[0]['server_type']
                			, 'SignatureHashAlgorithm' => $hashing
                			, 'ServerCount' => $servNum
                			, 'RenewalIndicator' => $renewalIndicator
                );

                $parnerOrderIdCreate = $this->generatePartnerOrderId($orderId, $renewalIndicator);
                $options = array(
                    'PartnerOrderID' => $parnerOrderIdCreate
                );
                if($supportStatus['support_for_san'] == 1){
                	$options['ReservedSanCount'] = $supportStatus['san_startup_domains'];
                	$orderParameters['DNSNames'] = $dnsName;
                }
//                 return array('status' => array('symantec' => 0), 'error' => array(0 => array('code' => 'test', 'message' => print_r($orderParameters, true))));
                $orderResponse = $this->apiConnect->QuickOrder($productCode, $orderParameters, $organizationInfo, $adminContact, $techContact, array(), $approvalEmail['email_approval'], $options);
                if(isset($orderResponse->details->QuickOrderResult->OrderResponseHeader->Errors) && ($orderResponse->details->QuickOrderResult->OrderResponseHeader->SuccessCode != 0 && $orderResponse->details->QuickOrderResult->OrderResponseHeader->SuccessCode != 1)){
                    $response['status']['rv'] = $orderResponse->status;
                    $response['status']['symantec'] = 1;
                    foreach($orderResponse->details->QuickOrderResult->OrderResponseHeader->Errors as $k => $v){
                    	if($v->Error->ErrorCode < 0){
	                        $response['error'][] = array(
	                                'code' => $v->Error->ErrorCode
	                                , 'message' => $v->Error->ErrorCode . ' ' . $v->Error->ErrorMessage
	                        );
                        	$response['status']['symantec'] = 0;
                    	}
                    }
                    if($response['status']['symantec'] == 0){
	                    $mailMessage = '';
	                    foreach($response['error'] as $k => $v){
	                    	$mailMessage .= 'Code : ' . $v['code'] . '<br />';
	                    	$mailMessage .= 'Message : ' . $v['message'] . '<br /><br />';
	                    }
// 	                    $this->sendMail($orderId, 'cannotOrder', array('orderId' => $orderId, 'errorContent' => $mailMessage), 'ssl@tickets.rvglobalsoft.com');
	                    $this->sendMailNew($orderId, 'cannotOrder', array('error_content' => $mailMessage));
                    }
                } else {
                    $response['status']['rv'] = 1;
                    $response['status']['symantec'] = 1;
                    $response['symantec_order_id'] = $orderResponse->details->QuickOrderResult->GeoTrustOrderID;
                }
                if(isset($response['error']) && (sizeof($response['error']) == 1 && $response['error'][0]['code'] == '2038') || (sizeof($response['error']) == 2 && $response['error'][1]['code'] == '2007')){
                    $response['status']['symantec'] = 1;
                }
            } else {
                $response['status']['rv'] = 0;
                $response['status']['symantec'] = 0;
                $response['error'][] = 'No order found.';
            }

            if($response['status']['symantec'] == 1){
                $partnerOrderId = $orderResponse->details->QuickOrderResult->OrderResponseHeader->PartnerOrderID;
                $response['partnerOrderId'] = $partnerOrderId;
                $orderInfo = $this->GetOrderByPartnerOrderId($partnerOrderId);
                $db->query('
                		UPDATE
                			hb_ssl_order
                		SET
	                		symantec_status = :status,
	                		authority_orderid = :symantec_id,
	                		partner_order_id = :partner_id,
                			cron_update = 1,
                			is_renewal = 0
                		WHERE
                			order_id = :order_id
                		', array(
                				':order_id' => $orderId,
                				':status' => $orderInfo['details']['orderInfo']['orderState'],
                				':symantec_id' => $orderInfo['details']['orderInfo']['geoTrustOrderID'],
                				':partner_id' => $partnerOrderId
                		)
                );
            }
        } else {
//         	$this->sendMail($orderId, 'notSupport', array('orderId' => $orderId), 'ssl@tickets.rvglobalsoft.com');
        	$this->sendMailNew($orderId, 'unsupportOrder');
            $response['status']['rv'] = 1;
            $response['status']['symantec'] = 0;
        }

        return $response;
    }

    public function reissues($partnerOrderId, $reissueEmail, $csr)
    {
    	$options = array('CSR' => $csr);
    	$response =  $this->apiConnect->Reissue($partnerOrderId, $reissueEmail, $options);
    	return $response;
    }

    public function cancelOrder($partnerOrderId)
    {
//     	$response =  $this->apiConnect->ModifyOrder($partnerOrderId, 'CANCEL');
//     	$db = hbm_db();
//     	$opt = $db->query("SELECT order_id FROM hb_ssl_order WHERE partner_order_id = '{$partnerOrderId}'")->fetch();
//     	$this->orderComment($opt['order_id'], $response);
//     	return $response;
    }

    public function GetOrderByPartnerOrderId($partnerOrderId, $options = array('ReturnProductDetail' => True), $allOptions = false)
    {
    	if($allOptions){
    		$options = array(
    			'ReturnProductDetail' => True,
    			'ReturnCertificateInfo' => True,
    			'ReturnCertificateAlgorithmInfo' => True,
    			'ReturnFulfillment' => True,
    			'ReturnCACerts' => True,
    			'ReturnPKCS7Cert' => True,
    			'ReturnOrderAttributes' => True,
    			'ReturnAuthenticationComments' => True,
    			'ReturnAuthenticationStatuses' => True,
    			'ReturnTrustServicesSummary' => True,
    			'ReturnTrustServicesDetails' => True,
    			'ReturnVulnerabilityScanSummary' => True,
    			'ReturnVulnerabilityScanDetails' => True,
    			'ReturnFileAuthDVSummary' => True,
    			'ReturnDNSAuthDVSummary' => True
    		);
    	}

        $response = array();
        $getOrderByPartnerOrderIdResponse = $this->apiConnect->GetOrderByPartnerOrderID($partnerOrderId, $options);
        $symantecStatus = $getOrderByPartnerOrderIdResponse->details->GetOrderByPartnerOrderIDResult->QueryResponseHeader->SuccessCode;
        $response['status']['rv'] = $getOrderByPartnerOrderIdResponse->status;
        $response2 = $this->obj2arr($response);

        if($symantecStatus == 0 && sizeof($options) == 1 && isset($options['ReturnProductDetail'])){
            $response['status']['symantec'] = 1;
            $mainDetails = $this->obj2arr($getOrderByPartnerOrderIdResponse->details->GetOrderByPartnerOrderIDResult->OrderDetail);
            $response['details']['orderInfo'] = $mainDetails['orderInfo'];
            $response['details']['quickOrderDetail'] = $mainDetails['quickOrderDetail'];
        } else if($symantecStatus == 0){
            $response['status']['symantec'] = 1;
            $mainDetails = $this->obj2arr($getOrderByPartnerOrderIdResponse->details->GetOrderByPartnerOrderIDResult->OrderDetail);
            if(isset($mainDetails['fulfillment'])){
                $response['details']['certificateInfo']['cACert'] = $mainDetails['fulfillment']['cACertificates']['0']['cACertificate']['cACert'];
                $response['details']['certificateInfo']['type'] =   $mainDetails['fulfillment']['cACertificates']['0']['cACertificate']['type'];
                $response['details']['certificateInfo']['pKCS7'] = $mainDetails['fulfillment']['pKCS7'];
                $response['details']['certificateInfo']['certificateCode'] = $mainDetails['fulfillment']['serverCertificate'];
            }
            if(isset($mainDetails['certificateInfo'])){
                $response['details']['certificateInfo']['startDate'] = $mainDetails['certificateInfo']['startDate'];
                $response['details']['certificateInfo']['expireDate'] = $mainDetails['certificateInfo']['endDate'];
                $response['details']['certificateInfo']['certificateStatus'] = $mainDetails['certificateInfo']['certificateStatus'];
            }
            if(isset($mainDetails['orderInfo'])){
            	$response['details']['orderInfo'] = $mainDetails['orderInfo'];
            }
            if(isset($mainDetails['quickOrderDetail'])){
            	$response['details']['quickOrderDetail'] = $mainDetails['quickOrderDetail'];
            }

        } else {
            $response['status']['symantec'] = 0;
            $response['error'][] = array('message' => 'No order found.');
        }
        return $response;
    }

    public function GetOrderByPartnerOrderIdClient($partnerOrderId)
    {
    	$options = array(
    			'ReturnProductDetail' => True,
    			'ReturnCertificateInfo' => True,
    			'ReturnCertificateAlgorithmInfo' => True,
    			'ReturnFulfillment' => True,
    			'ReturnCACerts' => True,
    			'ReturnPKCS7Cert' => True,
    			'ReturnOrderAttributes' => True,
    			'ReturnAuthenticationComments' => True,
    			'ReturnAuthenticationStatuses' => True,
    			'ReturnTrustServicesSummary' => True,
    			'ReturnTrustServicesDetails' => True,
    			'ReturnVulnerabilityScanSummary' => True,
    			'ReturnVulnerabilityScanDetails' => True,
    			'ReturnFileAuthDVSummary' => True,
    			'ReturnDNSAuthDVSummary' => True
    	);
    	$output = $this->apiConnect->GetOrderByPartnerOrderID($partnerOrderId, $options);
    	if(isset($output->details->GetOrderByPartnerOrderIDResult->OrderDetail->AuthenticationComments)){
    		foreach($output->details->GetOrderByPartnerOrderIDResult->OrderDetail->AuthenticationComments AS $k => $v){
    			$response['AuthenticationComments'][] = (array) $v;
    		}
    	}

    	foreach($output->details->GetOrderByPartnerOrderIDResult->OrderDetail->AuthenticationStatuses AS $k => $v){
    		$key = '';
    		switch($v->AuthenticationStatus->AuthenticationStep){
    			case 'DOMAIN_VERIFICATION':
    				$key = 'DomainVerification';
    				break;
    			case 'ORGANIZATION_VERIFICATION':
    				$key = 'OrganizationVerfication';
    				break;
    			case 'VERIFICATION_CALL':
    				$key = 'VerificationCall';
    				break;
    		}
    		if($key != ''){
	    		$response['AuthenticationStatus'][$key] = (array) $v->AuthenticationStatus;
	    		foreach($v->AuthenticationStatus as $kk => $vv){
	    			$response['AuthenticationStatus'][$key][$kk] = '';
	    			if($kk == 'AuthenticationStep'){
	    				switch($key){
	    					case 'DomainVerification': $value = 'Proof of Domain Registration'; break;
	    					case 'OrganizationVerfication': $value = 'Proof of Organization'; break;
	    					case 'VerificationCall': $value = 'Verification'; break;

	    				}
	    				$response['AuthenticationStatus'][$key][$kk] = $value;
	    			} else if($kk == 'LastUpdated'){
	    				$response['AuthenticationStatus'][$key][$kk] = date('d/m/Y', strtotime($vv));
	    			} else {
	    				$exp = explode('_', $vv);
	    				foreach($exp as $vvv){
	    					$response['AuthenticationStatus'][$key][$kk] .= ucfirst(strtolower($vvv)) . ' ';
	    				}
	    			}
	    			$response['AuthenticationStatus'][$key][$kk] = trim($response['AuthenticationStatus'][$key][$kk]);
	    		}
    		}
    	}

    	$response['OrderInfo'] = (array) $output->details->GetOrderByPartnerOrderIDResult->OrderDetail->OrderInfo;
    	$stateText = $this->getStatusDescription($output->details->GetOrderByPartnerOrderIDResult->OrderDetail->OrderInfo->OrderState);
    	$response['OrderInfo']['OrderStateText'] = $stateText['state'];
    	$response['OrderInfo']['OrderStateDescription'] = $stateText['description'];

    	$response['CertificateInfo'] = (array) $output->details->GetOrderByPartnerOrderIDResult->OrderDetail->CertificateInfo;
    	$response['CertificateInfo']['SignatureEncryptionAlgorithm'] = $output->details->GetOrderByPartnerOrderIDResult->OrderDetail->CertificateInfo->AlgorithmInfo->SignatureEncryptionAlgorithm;
    	$response['CertificateInfo']['SignatureHashAlgorithm'] = $output->details->GetOrderByPartnerOrderIDResult->OrderDetail->CertificateInfo->AlgorithmInfo->SignatureHashAlgorithm;

    	$response['QuickOrderDetail']['ApproverEmailAddress'] = $output->details->GetOrderByPartnerOrderIDResult->OrderDetail->QuickOrderDetail->ApproverEmailAddress;

    	if(isset($response['CertificateInfo']['CertificateStatus']) && $response['CertificateInfo']['CertificateStatus'] != ''){
    		$certStatusExp = explode('_', $response['CertificateInfo']['CertificateStatus']);
    		$certStatus = '';
    		foreach($certStatusExp as $v){
    			$certStatus .= ucfirst(strtolower($v)) . ' ';
    		}
    		$certStatus = trim($certStatus);
    		$response['CertificateInfo']['CertificateStatus'] = $certStatus;
    	}
    	unset($response['CertificateInfo']['AlgorithmInfo']);

    	ksort($response['OrderInfo']);
    	ksort($response['CertificateInfo']);
    	return $response;
    }

    public function getCertStatus($partnerOrderId)
    {
    	$options = array('ReturnCertificateInfo' => true);
    	$certInfo = $this->apiConnect->GetOrderByPartnerOrderID($partnerOrderId, $options);
    	if(isset($certInfo->details->GetOrderByPartnerOrderIDResult->OrderDetail->CertificateInfo->CertificateStatus)){
    		$certStatus = $certInfo->details->GetOrderByPartnerOrderIDResult->OrderDetail->CertificateInfo->CertificateStatus;
	    	return $certStatus;
    	}
    	return false;
    }

    public function changeApproverEmail($emailApproval, $partnerOrderId)
    {
        $db = hbm_db();
        $changeResponse = $this->apiConnect->ChangeApproverEmail($partnerOrderId, $emailApproval, array());
        if($changeResponse->details->ChangeApproverEmailResult->OrderResponseHeader->SuccessCode == 0){
            $db->query("
                UPDATE
                    hb_ssl_order
                SET
                    email_approval = :email_approval
                WHERE
                    partner_order_id = :partner_order_id
                ", array(
                    ':email_approval' => $emailApproval,
                    ':partner_order_id' => $partnerOrderId
                )
            );
        }
    }

    public function resendEmail($orderId, $type='')
    {
        $db = hbm_db();
        $orderDetail = $db->query("
                    SELECT
                        hso.partner_order_id
                        , hso.symantec_order_id
                        , hs.ssl_productcode AS product_code
                    FROM
                        hb_ssl_order AS hso
                        , hb_ssl AS hs
                    WHERE
                        order_id = :orderId
                        AND hso.ssl_id = hs.ssl_id
                    ", array(
                        ':orderId' => $orderId
                    )
        )->fetch();

        if($orderDetail['partner_order_id'] != ''){
            $productCode = $orderDetail['product_code'];
            $partnerOrderID = $orderDetail['partner_order_id'];
            $this->apiConnect->ResendEmail($productCode, $partnerOrderID, $type);
        }

    }

    public function resendFulfillmentEmail($orderId)
    {
        $this->resendEmail($orderId, 'FulFillmentEmail');
    }

    public function resendApproverEmail($orderId)
    {
        $this->resendEmail($orderId, 'ApproverEmail');
    }

    public function reissue($orderId, $csr, $emailApproval)
    {
        $db = hbm_db();
        $output = array();
        $orderDetail = $db->query("
                    SELECT
                        partner_order_id
                    FROM
                        hb_ssl_order
                    WHERE
                        order_id = :orderId
                        AND symantec_status = 'COMPLETED'
                    ", array(
                        ':orderId' => $orderId
                    )
        )->fetch();

        if($orderDetail['partner_order_id'] != '' && $csr != '' && $emailApproval != ''){
            $opt = array( 'CSR' => $csr);
            $reissueResponse = $this->apiConnect->Reissue($orderDetail['partner_order_id'], $emailApproval, $opt);
            if($reissueResponse->details->ReissueResult->OrderResponseHeader->SuccessCode >= 0){
            	$output['status'] = true;
            	$db->query("UPDATE hb_ssl_order SET csr = '{$csr}', cron_update = 1 WHERE order_id = {$orderId}");
            	$this->CheckStatus($orderId);
            } else {
            	$output['status'] = false;
            	$errorList = $reissueResponse->details->ReissueResult->OrderResponseHeader;

            	if(isset($errorList->Errors)){
            		foreach($errorList->Errors as $v){
            			$output['error'][] = array(
            					'ErrorCode' => $v->Error->ErrorCode
            					, 'ErrorField' => $v->Error->ErrorField
            					, 'ErrorMessage' => $v->Error->ErrorMessage
            			);
            		}
            	}
            }
            return $output;
        }
    }

    public function getFulfillment($partnerOrderId)
    {
        $reponse = array();
        $options = array('ReturnCACerts' => 1);
        $getFulfillmentResponse = $this->apiConnect->GetFulfillment($partnerOrderID, $options);
        $getFulfillmentResponse = $this->obj2arr($getFulfillmentResponse);

        $response['status']['rv'] = $getFulfillmentResponse['status'];
        if($getFulfillmentResponse['details']['getFulfillmentResult']['queryResponseHeader']['successCode'] == 0){
            $response['status']['symantec'] = 1;
            $response['details']['CACert'] = $getFulfillmentResponse['details']['getFulfillmentResult']['fulfillment']['cACertificates']['1']['cACertificate']['cACert'];
            $response['details']['Type'] = $getFulfillmentResponse['details']['getFulfillmentResult']['fulfillment']['cACertificates']['1']['cACertificate']['type'];
        } else {
            $response['status']['symantec'] = $getFulfillmentResponse['details']['getFulfillmentResult']['queryResponseHeader']['successCode'];
            $response['error'][] = $getFulfillmentResponse['details']['getFulfillmentResult']['queryResponseHeader']['errors']['0']['error']['errorMessage'];
        }

        return $response;
    }

    public function sendMailPhoneCall($orderId)
    {
        $db = hbm_db();
        $timeDetail = $db->query("
                    SELECT
                        time_verify_from AS tf
                        , time_verify_to AS tt
                        , time_verify_from2 AS tf2
                        , time_verify_to2 AS tt2
                    FROM
                        hb_ssl_order_contact
                    WHERE
                        order_id = :orderId
                        AND address_type = 1
                    ", array(

                        ':orderId' => $orderId
                    )
        )->fetch();
        $tf = substr($timeDetail['tf'], 0, strpos($timeDetail['tf'], 'GMT')-1);
                $tt = substr($timeDetail['tt'], 0, strpos($timeDetail['tt'], 'GMT')-1);
        if($tf != '' && $tt != ''){
            $gmt = substr($timeDetail['tf'], strpos($timeDetail['tf'], 'GMT'));
            $tfSp = split(' ', $tf);
            $ttSp = split(' ', $tt);
            $timeResult['date'] = date('d M Y', strtotime($tfSp[0]));
            $timeResult['tf'] = $tfSp[1];
                        $timeResult['tt'] = $ttSp[1];
            $timeResult['gmt'] = $gmt;

                        $tf2 = substr($timeDetail['tf2'], 0, strpos($timeDetail['tf2'], 'GMT')-1);
            $tt2 = substr($timeDetail['tt2'], 0, strpos($timeDetail['tt2'], 'GMT')-1);
            if($tf2 != '' && $tt2 != ''){
                $gmt2 = substr($timeDetail['tf2'], strpos($timeDetail['tf2'], 'GMT'));
                $tf2Sp = split(' ', $tf2);
                $tt2Sp = split(' ', $tt2);
                $timeResult['date2'] = date('d M Y', strtotime($tf2Sp[0]));
                $timeResult['tf2'] = $tf2Sp[1];
                                $timeResult['tt2'] = $tt2Sp[1];
                $timeResult['gmt2'] = $gmt2;
//                 $this->sendMail($orderId, 'phoneCall2', $timeResult);
                $this->sendMailNew($orderId, 'appointment2');

            } else {
//             	$this->sendMail($orderId, 'phoneCall1', $timeResult);
            	$this->sendMailNew($orderId, 'appointment1');
            }

        }
    }

    public function sendMailPhoneCallToClient($orderId)
    {
    	$db = hbm_db();
    	$accountId = $db->query("
    					SELECT
    						ha.id AS account_id
    						, hso.email_approval
    						, hcd.firstname
    						, hcd.lastname
    					FROM
    						hb_accounts AS ha
    						, hb_ssl_order AS hso
    						, hb_client_details AS hcd
    					WHERE
    						ha.order_id = :orderId;
    						AND ha.order_id = hso.order_id
    						AND ha.client_id = hcd.id
    			", array(
    				':orderId' => $orderId
    			)
    	)->fetch();
//     	$this->sendMail($orderId, 'phoneCallToClient', $accountId, $accountId['email_approval']);
    	$this->sendMailNew($orderId, 'verificationCallAppointment');
    }

    public function sendMailDocument($orderId)
    {
    	$db = hbm_db();
    	$partnerId = $db->query("
                    SELECT
    					symantec_order_id
    				FROM
    					hb_ssl_order AS hso
    				WHERE
    					hso.order_id = :orderId
                    ", array(

    	                    		':orderId' => $orderId
    	                    )
    	)->fetch();
//         $this->sendMail($orderId, 'document', $partnerId);
        $this->sendMailNew($orderId, 'sendDocument');
    }

    public function sendMailDocumentToClient($orderId)
    {
    	$db = hbm_db();
    	$accountId = $db->query("
    					SELECT
    						ha.id AS account_id
    						, hso.email_approval
    						, hcd.firstname
    						, hcd.lastname
    					FROM
    						hb_accounts AS ha
    						, hb_ssl_order AS hso
    						, hb_client_details AS hcd
    					WHERE
    						ha.order_id = :orderId
    						AND ha.order_id = hso.order_id
    						AND ha.client_id = hcd.id
    			", array(
        					':orderId' => $orderId
        			)
    	)->fetch();
//         $this->sendMail($orderId, 'documentToClient', $accountId, $accountId['email_approval']);
        $this->sendMailNew($orderId, 'uploadDocument');
    }

    public function sendMailSubmitCSR($email)
    {
    	$db = hbm_db();
    	$clientInfo = $db->query("
    						SELECT
    							hcd.firstname
    							, hcd.lastname
    						FROM
    							hb_client_details AS hcd
    							,hb_client_access AS hca
    						WHERE
    							hca.email = :email
    							AND hca.id = hcd.id

    						", array(
    							':email' => $email
    						)
    	)->fetch();
//     	$this->sendMail('', 'submitCSR', array('firstname' => $clientInfo['firstname'], 'lastname' => $clientInfo['lastname']), $email);
    	$this->sendMailNew($orderId, 'notificateCSR');
    }

    public function sendMail($orderId, $action, $insertArr = array(), $to = '')
    {
    	require_once(HBFDIR_LIBS  . 'RvLibs/SSL/PHPMailer-master/class.phpmailer.php');
        $db = hbm_db();
        if($to == ''){
            $authorityMail = $db->query("
                        SELECT
                            authority_email
                        FROM
                            hb_ssl_authority AS hsa
                            , hb_ssl_order AS hso
                            , hb_ssl AS hs
                        WHERE
                            hso.order_id = :orderId
                            AND hso.ssl_id = hs.ssl_id
                            AND hs.ssl_authority_id = hsa.ssl_authority_id
                        ", array(
                            ':orderId' => $orderId
                        )
            )->fetch();
            $to = $authorityMail['authority_email'];
        }

        switch($action){
        	case 'document' : $subject = 'Required Organization Documents are already submitted by client'; break;
        	case 'documentToClient' : $subject = 'Your SSL Certificate Order requires Organization Documents'; break;
        	case 'phoneCall1' :
        	case 'phoneCall2' :
        		$subject = 'Re-appointed of the Failed Verification Call'; break;
        	case 'phoneCallToClient' : $subject = 'Failure of Your Verification Call Appointment for SSL Certificate Order'; break;
        	case 'rejectOrder' : $subject = 'SSL Product : Order Rejected'; break;
        	case 'notSupport' : $subject = 'SSL Product : Not Support Product Request'; break;
        	case 'submitCSR' : $subject = 'CSR is Missing in Your SSL Certificate Order'; break;
        	case 'tellStaffPhonecall' : $subject = 'Order ' . $orderId . ' need verification call appointment'; break;
        	case 'cannotOrder' : $subject = 'Cannot order ssl product on order id ' . $orderId; break;

        }
        $tempName = $action . '.tpl';
        $mail = new PHPMailerNew();
        $mail->From = 'rvsslteam@rvglobalsoft.com';                       // Sender Email
        $mail->FromName = 'RVSSL Team';                                   // Sender Name
        $mail->AddAddress($to);                                         // To
        $mail->Subject = $subject;                                  	// Subject
//      $mail->AddCC($email_1);                                     	// Cc
        $mail->Body = file_get_contents(HBFDIR_LIBS  . 'RvLibs/SSL/mail_templates/' . $tempName);   // Content

        switch($action){
            case 'document' :
                $file_location = array(
                            'acknowledgement',
                            'lawyer_license',
                            'organization',
                            'attorney_identification_card',
                            'opinion_letter'
                );
                $docLo = dirname(__FILE__) . '/../../../../uploads/ssl/documents/';
                foreach($file_location as $eachLo){
                    $fileName = $eachLo . '_' . $orderId . '.pdf';
                    $eachFile = $docLo . $eachLo . '/' . $fileName;
                    if(file_exists($eachFile)){
                        $mail->AddAttachment($eachFile, $fileName);
                    }
                }
                break;
        }

        $matchResult = array();
        $match = preg_match_all('/{\s*\w*\s*}/im', $mail->Body, $matchResult);
        $matchVar = array();

        foreach($matchResult[0] as $v){
                array_push($matchVar, substr($v, 1, -1));
        }
        $matchVar = array_unique($matchVar);
        foreach($matchVar as $eachVar){
                $mail->Body = str_replace('{' . $eachVar . '}', $insertArr[trim($eachVar)], $mail->Body);
        }
        $mail->ISHTML(true);

        $mail->Send();

        if($orderId != ''){
	        $clientId = $db->query("
	        			SELECT
	        				usr_id
	        			FROM
	        				hb_ssl_order
	        			WHERE
	        				order_id = :orderId
	        		", array(
	        				':orderId' => $orderId
	        		)
	        )->fetch();
        } else {
        	$clientId = $db->query("
	        			SELECT
	        				id AS usr_id
	        			FROM
	        				hb_client_access
	        			WHERE
	        				email = :email
        				", array(
        						':email' => $to
        				)
        	)->fetch();
        }

        $db->query("
        		INSERT INTO
        			hb_email_log
        				(
        					client_id
        					, email
        					, subject
        					, message
        					, date
        					, status
        				)
        		VALUES(
        				:clientId
        				, :email
        				, :subject
        				, :message
        				, :date
        				, 1
        		)
        	", array(
        			'clientId' => $clientId['usr_id']
        			, ':email' => $to
        			, ':subject' => $subject
        			, ':message' => $mail->Body
        			, ':date' => date('Y-m-d H:i:s')
        	)
        );
    }

    public function checkStatus($orderId, $createNow = false, $renewalIndicator = false)
    {
    	$db = hbm_db();

    	$output = array();
    	$orderInfo = array();
    	$response = false;
    	$orderInfo = $db->query("
    			SELECT
    				hso.*
    			FROM
	    			hb_ssl_order AS hso
	    			, hb_orders AS ho
	    			, hb_invoices AS hi
    			WHERE
	    			hso.csr != ''
	    			AND hso.order_id = :orderId
	    			AND ho.id = hso.order_id
	    			AND ho.invoice_id = hi.id
	    			AND hi.status = 'Paid'
    			", array(
    				':orderId' => $orderId
    			)
    	)->fetch();

    	if($orderInfo == false){
    		$orderInfo = $db->query("
    				SELECT
    					*
    				FROM
    					hb_ssl_order
    				WHERE
    					csr != ''
    					AND authority_orderid != ''
    					AND partner_order_id != ''
    					AND order_id = :orderId
    					", array(
    						':orderId' => $orderId
    					)
    		)->fetch();
    	}

    	if($orderInfo == false && $createNow){
    		$orderInfo = $db->query("
    				SELECT
    					*
    				FROM
    					hb_ssl_order
    				WHERE
	    				csr != ''
	    				AND order_id = :orderId
    				", array(
    					':orderId' => $orderId
    				)
    		)->fetch();
    	}

    	if((sizeof($orderInfo) > 0 || $createNow)){
    		$accountIdQ = $db->query("SELECT id FROM hb_accounts WHERE order_id = {$orderId}")->fetch();
    		$accountId = $accountIdQ['id'];
    		if(($orderInfo['authority_orderid'] == '' && $orderInfo['symantec_status'] == 'WAITING_SUBMIT_ORDER') || ($renewalIndicator && $orderInfo['symantec_status'] == 'WAITING_SUBMIT_ORDER')){
    			//quick order
    			$quickOrderResponse = $this->QuickOrder($orderId, $renewalIndicator);
    			if($quickOrderResponse['status']['symantec'] == 1){
    			}
    			$orderInfo['partner_order_id'] = $quickOrderResponse['partnerOrderId'];
    		}

    		$opt = array(
    				'ReturnProductDetail' => True,
    				'ReturnCertificateInfo' => True,
    				'ReturnFulfillment' => True,
    				'ReturnCACerts' => True,
    				'ReturnPKCS7Cert' => True,
    		);

    		$validateDetails = $this->GetOrderByPartnerOrderId($orderInfo['partner_order_id'], $opt);

			if($validateDetails['status']['symantec'] == 1){
    			$symantecStatusDetail = $validateDetails['details']['orderInfo']['orderState'];
    			//$symantecStatusDetail = 'WF_AUTHORIZATION';
    			if($symantecStatusDetail == 'AUTHORIZATION_FAILED' || $orderInfo['symantec_status'] == 'RV_WF_AUTHORIZATION'){
    				$contactInfo = $this->getContactCallInfo($orderId);
    				$nowTime = strtotime(date('Y-m-d H:i:s'));
    				if($contactInfo['tf'] != '' && $contactInfo['tt'] != ''){
    					$tt = strtotime($this->changeDateTimeGMT($contactInfo['tt']));

						if($tt < $nowTime){
    						$db->query("
    								UPDATE
    									hb_ssl_order_contact
    								SET
	    								time_verify_from = ''
	    								, time_verify_to = ''
    								WHERE
	    								order_id = :orderId
	    								AND address_type = 1
    								", array(
    									':orderId' => $orderId
    								)
    						);
    					}
    				}

    				$contactInfo = $this->getContactCallInfo($orderId);
    				if($contactInfo['tf'] == '' && $contactInfo['tt'] == '' && $contactInfo['tf2'] != '' && $contactInfo['tt2'] != ''){
    					$tf2 = strtotime($this->changeDateTimeGMT($contactInfo['tf2']));
    					if($tt2 < $nowTime){
    						$db->query("
    								UPDATE
    									hb_ssl_order_contact
    								SET
   										time_verify_from2 = ''
   										, time_verify_to2 = ''
    								WHERE
	    								order_id = :orderId
	    								AND address_type = 1
    								", array(
    									':orderId' => $orderId
    								)
    						);
    					}
    				}

    				$contactInfo = $this->getContactCallInfo($orderId);
    				$notNull = 0;
    				foreach($contactInfo as $v){
    					if($v != ''){
    						$notNull = 1;
    					}
    				}
    				if($notNull == 0 && $symantecStatusDetail == 'AUTHORIZATION_FAILED'){
    					$symantecStatusDetail = 'AUTHORIZATION_FAILED';
    					$this->sendMailPhoneCallToClient($orderId);
//     					$this->sendMail($orderId, 'tellStaffPhonecall', array('orderId' => $orderId), 'ssl@tickets.rvglobalsoft.com');
    					$this->sendMailNew($orderId, 'needVerificationCallAppointment');
    				} else {
    					$symantecStatusDetail = 'RV_WF_AUTHORIZATION';
    				}
    			} else if($symantecStatusDetail == 'COMPLETED'){
    				$certState = $validateDetails['details']['certificateInfo']['certificateStatus'];
    				$exCert = explode('_', $certState);
    				$certStatus = '';
    				foreach($exCert as $eachC){
    					$certStatus .= ucfirst(strtolower($eachC)) . ' ';
    				}
    				$certStatus = trim($certStatus);
    				if($certStatus == 'Active' && $orderInfo['is_revoke'] == false){
	    				$db->query("
	    						UPDATE
	    							hb_ssl_order
	    						SET
		    						code_certificate = :cert
		    						, code_ca = :ca
		    						, type_ca = :type
		    						, date_expire = :exp
		    						, code_pkcs7 = :pkcs7
	    							, date_created = :dateactive
		    						, cert_status = :certStatus
		    						, cron_update = 0
	    							, is_renewal = 0
	    						WHERE
	    							order_id = :orderId
	    						", array(
	    							':type' => $validateDetails['details']['certificateInfo']['type'],
	    							':ca' => $validateDetails['details']['certificateInfo']['cACert'],
	    							':cert' => $validateDetails['details']['certificateInfo']['certificateCode'],
	    							':exp' => strtotime($validateDetails['details']['certificateInfo']['expireDate']),
	    							':pkcs7' => $validateDetails['details']['certificateInfo']['pKCS7'],
	    							':dateactive' => strtotime($validateDetails['details']['certificateInfo']['startDate']),
	    							':certStatus' => $certStatus,
	    							':orderId' => $orderId
	    						)
	    				);

	    				$next_due = strtotime($validateDetails['details']['certificateInfo']['expireDate']);
	    				$next_due = date("Y-m-d",$next_due);

	    				$cParams = array(
	    						'call' => 'editAccountDetails',
	    						'id' => $accountId,
	    						'next_due' => $next_due
	    				);
   						$createOutput = $this->apiCustom->request($cParams);

   						$aParams = array(
   								'call' => 'setOrderActive',
   								'id' => $orderId
   						);
   						$this->apiCustom->request($aParams);

   						$response = true;

    				} else if($certStatus == 'Cancelled' || $certStatus == 'Revoked'){
    					$db->query("UPDATE hb_ssl_order SET cron_update = 0, is_revoke = 0 WHERE order_id = {$orderId}");
    					$tParams = array(
    							'call' => 'accountTerminate',
    							'id' => $accountId,
    					);
    					$this->apiCustom->request($tParams);
					}

    				$db->query("UPDATE hb_ssl_order SET cert_status = '{$certStatus}' WHERE order_id = {$orderId}");
    			} else if($symantecStatusDetail == 'SECURITY_REVIEW_FAILED'){
    				$this->sendMailNew($orderId, 'failedSecurityReview');
    			}

    			if($symantecStatusDetail != $orderInfo['symantec_status']){
    				$db->query("
    						UPDATE
    							hb_ssl_order
    						SET
    							symantec_status = :symantecStatusDetail
    						WHERE
    							order_id = :order_id
    						", array(
    							':symantecStatusDetail' => $symantecStatusDetail,
    							':order_id' => $orderId
    						)
    				);
					if($orderInfo['symantec_status'] == 'AUTHORIZATION_FAILED' && $symantecStatusDetail == 'RV_WF_AUTHORIZATION'){
						$this->sendMailPhoneCall($orderId);
					} else if($orderInfo['symantec_status'] != 'REJECTED' && $symantecStatusDetail == 'REJECTED'){
						$chkAcctStatus = $db->query("SELECT status FROM hb_accounts WHERE id = {$accountId}")->fetch();
						if($chkAcctStatus['status'] == 'Pending'){
							$db->query("
    								UPDATE
    									hb_accounts
    								SET
    									status = 'Terminated'
    								WHERE
    									order_id = :order_id
    								", array(
    									':order_id' => $orderId
    								)
    						);
    					} else {
    						$tParams = array(
    							'call' => 'accountTerminate',
    							'id' => $accountId,
    						);
    						$this->apiCustom->request($tParams);
    					}
    					$db->query("UPDATE hb_ssl_order SET cron_update = 0 WHERE order_id = {$orderId}");
//     					$this->sendMail($orderId, 'rejectOrder', array('orderId' => $orderId), 'ssl@tickets.rvglobalsoft.com');
    					$this->sendMailNew($orderId, 'rejectOrder');
    				}
    			}
    		}
    		$db->query("
    				UPDATE
    					hb_ssl_order
    				SET
    					last_updated = :last_updated
    				WHERE
    					order_id = :order_id
    				", array(
    					':last_updated' => strtotime(date('Y-m-d H:i:s')),
    					':order_id' => $orderId
    				)
    		);
    	}

    	return $response;
    }

    public function Revoke($orderId, $reason = '', $type)
    {
    	$db = hbm_db();

    	$certificate = $db->query("SELECT code_certificate FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();
    	if($certificate['code_certificate'] != ''){
    		$output = $this->apiConnect->Revoke($certificate['code_certificate'], $type);
    		if($output->details->RevokeResult->OrderResponseHeader->SuccessCode >= 0){
    			$notes = $db->query("SELECT notes FROM hb_orders WHERE id = {$orderId}")->fetch();
    			if(json_decode($notes['notes'])){
    				$nowNote = $this->obj2arr2(json_decode($notes['notes']));
    				$nowNote['revoke-reason'] = $reason;
    			} else {
    				$nowNote['revoke-reason'] = $reason;
    			}
    			$queryNote = json_encode($nowNote);
    			$db->query("UPDATE hb_orders SET notes = '{$queryNote}' WHERE id = {$orderId}");
    			$db->query("UPDATE hb_ssl_order SET cron_update = 1, is_revoke = 1 WHERE order_id = :orderId", array(':orderId' => $orderId));
    			return true;
    		} else {
    			return $output->details->RevokeResult->OrderResponseHeader->Errors[0]->Error->ErrorMessage;
    		}
    	}
    	return 'Cannot get certificate from database';
    }

    public function GetQuickApproverList($domain)
    {
    	$getlist = array();
    	$response = $this->apiConnect->GetQuickApproverList($domain);
    	if($response->details->GetQuickApproverListResult->QueryResponseHeader->SuccessCode == 0){
    		foreach($response->details->GetQuickApproverListResult->ApproverList as $v){
    			if($v->Approver->ApproverType != 'Manual' && !in_array($v->Approver->ApproverEmail, $getlist)){
    				$getlist[] = $v->Approver->ApproverEmail;
    			}
    		}
    	}
    	return $getlist;
    }

    public function GetQuickApproverListFromDB($orderId)
    {
    	$db = hbm_db();
    	$output = array();
    	$aQuery = $db->query("SELECT email_approval FROM hb_ssl_order_contact WHERE order_id = {$orderId}")->fetchAll();
    	$bQuery = $db->query("SELECT email_approval FROM hb_ssl_order WHERE order_id = {$orderId}")->fetch();

    	foreach($aQuery as $v){
    		if(!in_array($v['email_approval'], $output)){
    			$output[] = $v['email_approval'];
    		}
    	}

    	if($bQuery && !in_array($bQuery['email_approval'], $output)){
    		$output[] = $bQuery['email_approval'];
    	}

    	return $output;
    }


    public function changeDateTimeGMT($input)
    {
        $gmt = substr($input, strpos($input, 'GMT')+3);
        $input = substr($input, 0, strpos($input, 'GMT')-1);
        $output = date_format(date_create($input), 'Y-m-d H:i:s');
        $output = date('Y-m-d H:i:s', strtotime($output) + (intval($gmt)*3600));
        return $output;
    }

    public function getContactCallInfo($orderId)
    {
        $db = hbm_db();
            $contactInfo = $db->query("
                                           SELECT
                                               time_verify_from AS tf
                                                   ,time_verify_to AS tt
                                                   ,time_verify_from2 AS tf2
                                                   ,time_verify_to2 AS tt2
                                           FROM
                                                   hb_ssl_order_contact
                                           WHERE
                                                   order_id = :orderId
                                                   AND address_type = 1
                                           ", array(
                                                   ':orderId' => $orderId
                                           )
                )->fetch();
        return $contactInfo;
    }

    public function obj2arr($obj)
    {
        if(is_object($obj)) $obj = (array) $obj;
        if(is_array($obj)) {
            $new = array();
            foreach($obj as $key => $val) {
                $new[lcfirst($key)] = $this->obj2arr($val);
            }
        }
        else $new = $obj;
        return $new;
    }

    public function obj2arr2($obj)
    {
    	if(is_object($obj)) $obj = (array) $obj;
    	if(is_array($obj)) {
    		$new = array();
    		foreach($obj as $key => $val) {
    			$new[$key] = $this->obj2arr2($val);
    		}
    	}
    	else $new = $obj;
    	return $new;
    }

    public function ModifyOrder($partnerOrderID, $command, $options = array())
    {
    	$db = hbm_db();
    	if(isset($options['order_id'])){
    		$eQuery = $db->query("SELECT email_approval FROM hb_ssl_order WHERE order_id = {$options['order_id']}")->fetch();
    		$options['RequestorEmail'] = $eQuery['email_approval'];
    		unset($options['order_id']);
    	}
    	$output = array();
    	$response = $this->apiConnect->ModifyOrder($partnerOrderID, $command, $options);
    	if($response->details->ModifyOrderResult->OrderResponseHeader->SuccessCode < 0){
    		foreach($response->details->ModifyOrderResult->OrderResponseHeader->Errors as $v){
    			$output['error'][] = array(
    					'errorCode' => $v->Error->ErrorCode
    					, 'errorField' => $v->Error->ErrorField
    					, 'errorMessage' => $v->Error->ErrorMessage
    			);
    		}
    		$output['status'] = false;
    	} else {
    		if(isset($options['order_id']) && $options['order_id'] != ''){
    			$db->query("UPDATE hb_ssl_order SET cron_update = 1 WHERE order_id = {$options['order_id']}");
    		}
    		$output['status'] = true;
    	}
        return $output;
    }

    public function orderComment($orderId, $message)
    {
    	$db = hbm_db();
    	$db->query("
                		UPDATE
                			hb_ssl_order
                		SET
                			comment = :comment
                		WHERE
    						order_id = :orderId
                		", array(
    	                	':orderId' => $orderId
    	                	, ':comment' => json_encode($message)
    	                )
    	);
    }

    public function getStatusDescription($code)
    {
        $status = array();
        switch($code){
            case 'WF_AUTHORIZATION' :
            case 'RV_WF_AUTHORIZATION' :
                $status['state'] = 'Waiting for verification call';
                $status['description'] = 'The order is awaiting phone authentication. Once the customer has successfully completed phone authentication, the system kicks the order into the next state (WF_ACK_EMAIL).';
                break;
            case 'AUTHORIZATION_FAILED' :
                $status['state'] = 'Failed verification call';
                $status['description'] = 'This means that the user exceeded the maximum number of phone authorization attempts (currently 3) without success.' . "\n" . 'Customer support will need to process the order.';
                break;
            case 'WF_ACK_EMAIL' :
                $status['state'] = 'Waiting for sending of acknowledgement email';
                $status['description'] = 'Orders should almost never be in this state. As soon as an order gets into this state, the system kicks the order, thereby trying to send the order acknowledgement email.';
                break;
            case 'WF_DOMAIN_APPROVAL_ADDRESS' :
                $status['state'] = 'Waiting for change of Whois approval address';
                $status['description'] = 'This means that the applicant chose the "Other Approver Email" option for the whois approver address. Customer support needs to change the approver address to an actual approver address and then kick the order to move it to the next state.';
                break;
            case 'WF_DOMAIN_APPROVAL_EMAIL' :
                $status['state'] = 'Waiting for sending of Whois approval email';
                $status['description'] = 'Orders usually don\'t stay in this state for long. As soon as the order gets into this state, the system tries to send the approval email. If this is successful, the order moves into the WF_DOMAIN_APPROVAL state. Otherwise, the order will be in the DOMAIN_APPROVAL_EMAIL_FAILED state.';
                break;
            case 'DOMAIN_APPROVAL_EMAIL_FAILED' :
                $status['state'] = 'Failed sending Whois approval email';
                $status['description'] = 'Something went wrong when the system tried to send the domain approval email. Normally, this indicates an email misconfiguration that needs to be resolved by customer support.';
                break;
            case 'WF_DOMAIN_APPROVAL' :
                $status['state'] = 'Waiting for approval.';
                $status['description'] = 'The order is waiting for the domain/whois approver to review and approve the order. The approver should have received an email with a link to the approval page.';
                break;
            case 'WF_EXTERNAL_APPROVALS' :
                $status['state'] = 'Waiting for GeoCenter approval';
                $status['description'] = 'The order is waiting for the ESSL customer\'s administrator to log into GeoCenter and approve it.';
                break;
            case 'DOMAIN_NOT_PREVETTED' :
                $status['state'] = 'Domain not pre-vetted';
                $status['description'] = 'This is only relevant to ESSL orders. This occurs when the domain is not a subdomain of one of the enterprise\'s prevetted domains for an ESSL order.';
                break;
            case 'WF_SECURITY_REVIEW' :
                $status['state'] = 'Waiting for security review';
                $status['description'] = 'Order don\'t normally spend any time in this state. When an order gets into this state, the system automatically tries to kick the order to the next state. If any violations are found, the order is put into the "Failed Security Review" state.';
                break;
            case 'SECURITY_REVIEW_FAILED' :
                $status['state'] = 'Failed Security Review';
                $status['description'] = 'One or more resource control violations was found when performing security checks';
                break;
            case 'WF_MANUAL_VETTING' :
                $status['state'] = 'Waiting for manual vetting';
                $status['description'] = 'Orders requiring business vetting by the customer support team end up in this state when the order is ready to be vetted. Orders can be in this state for as long as several days for EV certificates.';
                break;
            case 'WF_VETTING_REVIEW' :
                $status['state'] = 'Waiting for vetting review';
                $status['description'] = 'After initial manual vetting is completed, the order is placed into this state for a second support person to review and approve it.';
                break;
            case 'WF_PAYMENT' :
                $status['state'] = 'Waiting for payment processinig';
                $status['description'] = 'If there is a credit card associated with the order, the system attempts to charge the card. If the charge fails, the order goes into the "Failed payment processing" state. Other wise, it continues to the next state "Waiting for finalization".';
                break;
            case 'PAYMENT_FAILED' :
                $status['state'] = 'Failed payment processing';
                $status['description'] = 'This usually indicates ab ad credit card, and the order remains in this state until someone in customer support changes the credit card number.';
                break;
            case 'WF_CERTGEN' :
                $status['state'] = 'Waiting for certificate generation';
                $status['description'] = 'The order is ready for requesting a certificate from the CMS. This is done automatically once the order gets into this state. If a certificates is obtained successfully, then the order is put into the WF_PAYMENT state. Otherwise, the order is put into the CERTGEN_FAILED state.';
                break;
            case 'CERTGEN_FAILED' :
                $status['state'] = 'Failed certificate generation';
                $status['description'] = 'This usually indicates either a bad CSR or that the CMS was down. Please resubmit CSR again. If this error still persists, please contact to customer support. <a href="https://rvglobalsoft.com/tickets/new&deptId=3/tickets/new&deptId=3"  target="_blank">Here</a>';
                break;
            case 'WF_FINALIZATION' :
                $status['state'] = 'Waiting for finalization';
                $status['description'] = 'Finalization is basically everything else that needs to be done after the certificate has been obtained: update the database, send out the receipt and fulfillment emails, and so on. If any of these steps fails, the order will remain in this state. The most likely failure is the sending of an email because of a configuration problem.';
                break;
            case 'WF_RESELLER_APPROVAL_POSTVETTING' :
                $status['state'] = 'Waiting for reseller approval';
                $status['description'] = 'The order is waiting for reseller approval after it has been processed by the customer support team.';
                break;
            case 'WF_RESELLER_APPROVAL_PRECERTGEN' :
                $status['state'] = 'Waiting for reseller approval';
                $status['description'] = 'The order is waiting for reseller approval (for GeoTrust SSL certificates and Thawte SSL123).';
                break;
            case 'WF_RESELLER_APPROVAL_PREVETTING' :
                $status['state'] = 'Waiting for reseller approval';
                $status['description'] = 'The order is waiting for reseller approval before the certificate has been processed by the customer support team.';
                break;
            case 'WF_TRIAL_EXPIRATION' :
                $status['state'] = 'Waiting for the trial period to expire';
                $status['description'] = 'The order is waiting for the trial period to expire before it can be converted and charged for.';
                break;
            case 'CONVERTED' :
                $status['state'] = 'Trial order has been converted';
                $status['description'] = 'The conversion occurs after day 30 of the trial period ends and the order is successfully charged for.';
                break;
            case 'COMPLETED' :
                $status['state'] = 'Completed';
                $status['description'] = 'This means that the order was fulfilled successfully and the fulfillment email was sent out. Once an order is in this state, it can be reissued.';
                break;
            case 'REJECTED' :
                $status['state'] = 'Rejected';
                $status['description'] = 'Either A) One of the approvers/vetters has "disapproved" this order at some point in the ordering process or B) The order has been canceled. The order has been marked as canceled and put in the "Rejected" state, meaning that no further processing is allowed on this order. Once it has been rejected, it cannot be "un-rejected". please contact to customer support. <a href="https://rvglobalsoft.com/tickets/new&deptId=3/tickets/new&deptId=3"  target="_blank">Here</a>';
                break;
            case 'WF_CONSUMER_AUTH' :
                $status['state'] = 'Waiting for consumer authentication';
                $status['description'] = 'The order is in this state when the product was ordered for an individual and our system is waiting for that individual to complete the eIDverifier process with Equifax.';
                break;
            case 'WF_Malware_Scan' :
                $status['state'] = 'Waiting for malware scan';
                $status['description'] = 'Orders will be in this state when the authentication process has completed and our system is in the process of scanning the domain for malware.';
                break;
            case 'WF_FILE_AUTH' :
                $status['state'] = 'Waiting for file authentication';
                $status['description'] = 'For orders with automated DV authentication enabled, this order state replaces the \'waiting for domain approval\' state.';
                break;
            case 'WAITING_SUBMIT_CSR' :
                $status['state'] = 'Waiting for submit CSR.';
                $status['description'] = '';
                break;
            case 'WAITING_SUBMIT_ORDER' :
                $status['state'] = 'Waiting for submit order.';
                $status['description'] = '';
                break;
            //NEW
            case 'WAITING_SUBMIT_PHONECALL' : //RV_WF_AUTHORIZATION & WF_AUTHORIZATION
                $status['state'] = 'Waiting for submit phone call.';
                $status['description'] = '';
                break;
            case 'WAITING_SUBMIT_DOCUMENT' :
                $status['state'] = 'Waiting for organization documents.';
                $status['description'] = '';
                        break;
            //MINOR
            case 'ORDER_WAITING_FOR_APPROVAL' :
                $status['state'] = 'Waiting for approval.';
                $status['description'] = 'An order is waiting to be approved.';
                break;
/*
            case 'ORDER_INIT' :
                $status['state'] = 'Order init';
                $status['description'] = 'An order is waiting for phone authentication, or order is in a state.';
                break;
            case 'ORDER_QUEUED' :
                $status['state'] = 'Order queued';
                $status['description'] = 'An order is queued for GeoTrust problem resolution.';
                break;
            case 'ORDER_COMPLETE' :
                $status['state'] = 'Order complete';
                $status['description'] = 'An order is complete.';
                break;
            case 'ORDER_CANCELED' :
                $status['state'] = 'Order canceled';
                $status['description'] = 'An order has been canceled.';
                break;
            case 'DEACTIVATED' :
                $status['state'] = 'Deactivated';
                $status['description'] = 'An order has been deactivated.';
                break;
            case 'FULFILLED' :
                $status['state'] = 'Fulfilled';
                $status['description'] = 'An order is fulfilled.';
                break;
            case 'QUEUED_ENT' :
                $status['state'] = 'Enterprise SSL request has been queued';
                $status['description'] = 'An Enterprise SSL request has been queued for review by the enterprise.';
                break;
*/
            default :
                $status['state'] = $code;
                $status['description'] == '';
        }
        return $status;
    }

    public function get_email_template()
    {
    	$output = array(
    			/*'Required Organization Documents are already submitted by client' => 'Authority'
    			, 'Your SSL Certificate Order requires Organization Documents' => 'Client'
    			, 'Re-appointed of the Failed Verification Call' => 'Authority'
    			, 'Failure of Your Verification Call Appointment for SSL Certificate Order' => 'Client'
    			, 'SSL Product : Order Rejected' => 'Staff'
    			, 'SSL Product : Not Support Product Request' => 'Staff'
    			, 'CSR is Missing in Your SSL Certificate Order' => 'Client'
    			, 'Order {$order_id} need verification call appointment' => 'Staff'
    			, 'Cannot order ssl product on order id {$order_id}' => 'Staff'
    			,*/
    			'uploadDocument' => array('to' => 'Client', 'text' => 'Notificate client to upload documents.')
    			, 'verificationCallAppointment' => array('to' => 'Client', 'text' => 'Notificate client to make verification call appointment.')
    			, 'notificateCSR' => array('to' => 'Client', 'text' => 'Notificate client to insert CSR for order processing.')
    			, 'sendDocument' => array('to' => 'Authority', 'text' => 'Send documents to Authority.')
    			, 'appointment1' => array('to' => 'Authority', 'text' => 'Send verification call appointment to Authority by 1 set of appointed time.')
    			, 'appointment2' => array('to' => 'Authority', 'text' => 'Send verification call appointment to Authority by 2 set of appointed time.')
    			, 'rejectOrder' => array('to' => 'Staff', 'text' => 'Notificate Staff about rejected order.')
    			, 'unsupportOrder' => array('to' => 'Staff', 'text' => 'Notificate Staff about client order an unsupported products.')
    			, 'needVerificationCallAppointment' => array( 'to' => 'Staff', 'text' => 'Notificate Staff about order need to make verification call appointment.')
    			, 'cannotOrder' => array('to' => 'Staff', 'text' => 'Notificate Staff about cannot order error message.')
    			, 'terminateOrder' => array('to' => 'Client', 'text' => 'Notificate client about Terminated order.')
    			, 'paidInvoice' => array('to' => 'Client', 'text' => 'Send email cause invoice has paid.')
    			, 'failedSecurityReview' => array('to' => 'Staff', 'text' => 'Failed Security Review Notification.')

    	);
    	return $output;
    }

    public function get_email_template_variable($orderId)
    {
    	$db = hbm_db();
    	$api = $this->generateAPICustom();

    	$request = $db->query("
    			SELECT
    				a.id
    				, a.client_id
    				, a.status AS astatus
    				, a.domain
    				, a.payment_module
    				, a.firstpayment
    				, a.total
    				, a.billingcycle
    				, a.next_due
    				, a.next_invoice
    				, o.invoice_id
    				, o.number AS onumber
    				, p.name AS pname
    				, mc.module AS module_name
    			FROM
    				hb_accounts AS a
    				, hb_orders AS o
    				, hb_products AS p
    				, hb_products_modules AS pm
    				, hb_modules_configuration AS mc
    			WHERE
    				a.order_id = {$orderId}
    				AND o.id = a.order_id
    				AND a.product_id = p.id
    				AND p.id = pm.product_id
    				AND pm.module = mc.id
    	")->fetch();

    	$sslinfo = $db->query("
    			SELECT
    				so.authority_orderid
    				, so.email_approval
    				, soc.time_verify_from
    				, soc.time_verify_to
    				, soc.time_verify_from2
    				, soc.time_verify_to2
    				, soc.ext_number

    			FROM
    				hb_ssl_order AS so
    				, hb_ssl_order_contact AS soc
    			WHERE
    				so.order_id = {$orderId}
    				AND soc.order_id = so.order_id
    				AND address_type = 1
    	")->fetch();

    	$callinfo = $db->query("
    			SELECT
    				*
    			FROM
    				hb_ssl_order_contact
    			WHERE
    				order_id = {$orderId}
    				AND address_type = 1
    	")->fetch();

    	$invoiceInfo = $db->query("
    			SELECT
    				i.*
    			FROM
    				hb_invoices AS i
    				, hb_orders AS o
    			WHERE
    				o.id = {$orderId}
    				AND o.invoice_id = i.id
    	")->fetch();
    	$clientId = $request['client_id'];
    	$invoiceId = $request['invoice_id'];

    	$clientDetail = $api->request(array('call' => 'getClientDetails', 'id' => $clientId));
    	$invoiceDetail = $api->request(array('call' => 'getInvoiceDetails', 'id'=> $invoiceId));
    	$paymentModule = $api->request(array('call' => 'getPaymentModules'));
    	$currencies = $api->request(array('call' => 'getCurrencies'));
    	$output['client.id'] = $invoiceDetail['invoice']['client']['client_id'];
    	$output['client.email'] = $invoiceDetail['invoice']['client']['email'];
    	$output['client.firstname'] = $invoiceDetail['invoice']['client']['firstname'];
    	$output['client.lastname'] = $invoiceDetail['invoice']['client']['lastname'];
    	$output['client.companyname'] = $invoiceDetail['invoice']['client']['companyname'];
    	$output['client.address1'] = $invoiceDetail['invoice']['client']['address1'];
    	$output['client.address2'] = $invoiceDetail['invoice']['client']['address2'];
    	$output['client.city'] = $invoiceDetail['invoice']['client']['city'];
    	$output['client.state'] = $invoiceDetail['invoice']['client']['state'];
    	$output['client.postcode'] = $invoiceDetail['invoice']['client']['postcode'];
    	$output['client.country'] = $invoiceDetail['invoice']['client']['country'];
    	$output['client.phonenumber'] = $invoiceDetail['invoice']['client']['phonenumber'];
    	$output['client.partner'] = '';
    	$output['client.minimuminvoice'] = '';
    	$output['client.taxid'] = '';
    	$output['client.datecreated'] = $invoiceDetail['invoice']['client']['datecreated'];
    	$output['client.notes'] = $invoiceDetail['invoice']['client']['notes'];

    	$output['service.product_name'] = $request['pname'];
    	$output['service.username'] = '';
    	$output['service.password'] = '';
    	$output['service.rootpassword'] = '';
    	$output['service.ip'] = '';
    	$output['service.additional_ip'] = '';
    	$output['service.type'] = '';
    	$output['service.guaranteed_ram'] = '';
    	$output['service.burstable_ram'] = '';
    	$output['service.os'] = '';
    	$output['service.status'] = $request['astatus'];
    	$output['service.order_num'] = $request['onumber'];
    	$output['service.module_name'] = $request['module_name'];
    	$output['service.domain'] = $request['domain'];
    	$output['service.gateway'] = $paymentModule['modules'][$request['payment_module']];
    	$output['service.firstpaymentprice'] = $currencies['main.sign'] . $request['firstpayment'] . ' ' . $currencies['main.code'];
    	$output['service.total'] = $currencies['main.sign'] . $request['total'] . ' ' . $currencies['main.code'];
    	$output['service.billingcycle'] = $request['billingcycle'];
    	$output['service.next_due'] = date('d M Y', strtotime($request['next_due']));
    	$output['service.next_invoice'] = date('d M Y', strtotime($request['next_invoice']));

    	$output['server.name'] = '';
    	$output['server.ip'] = '';
    	$output['server.host'] = '';
    	$output['server.status_url'] = '';
    	$output['server.ns1'] = '';
    	$output['server.ip1'] = '';
    	$output['server.ns2'] = '';
    	$output['server.ip2'] = '';
    	$output['server.ns3'] = '';
    	$output['server.ip3'] = '';
    	$output['server.ns4'] = '';
    	$output['server.ip4'] = '';

    	$output['invoice.id'] = $invoiceInfo['id'];
    	$output['invoice.total'] = $invoiceInfo['total'];
    	$output['invoice.subtotal'] = $invoiceInfo['subtotal'];
    	$output['invoice.credit'] = $invoiceInfo['credit'];
    	$output['invoice.gateway'] = $paymentModule['modules'][$invoiceInfo['payment_module']];
    	$output['invoice.status'] = $invoiceInfo['status'];
    	$output['invoice.date'] = $invoiceInfo['date'];
    	$output['invoice.duedate'] = $invoiceInfo['duedate'];
    	$output['invoice.paybefore'] = $invoiceInfo['paybefore'];
    	$output['invoice.datepaid'] = $invoiceInfo['datepaid'];
    	$output['invoice.notes'] = $invoiceInfo['notes'];

    	$output['domain.name'] = '';
    	$output['domain.status'] = '';
    	$output['domain.registrar'] = '';
    	$output['domain.gateway'] = '';
    	$output['domain.order_id'] = '';
    	$output['domain.date_created'] = '';
    	$output['domain.firstpayment'] = '';
    	$output['domain.recurring_amount'] = '';
    	$output['domain.period'] = '';
    	$output['domain.expires'] = '';
    	$output['domain.next_due'] = '';
    	$output['domain.next_invoice'] = '';
    	$output['domain.epp_code'] = '';

    	$output['system_url'] = $_SERVER['HTTP_ORIGIN'];
    	$output['clientarea_url'] = $_SERVER['HTTP_ORIGIN'] . '/?cmd=clientarea';
    	$output['invoices_url'] = $_SERVER['HTTP_ORIGIN'] . '/?cmd=clientarea&action=invoices';
    	$output['invoices_url\|https'] = (substr($_SERVER['HTTP_ORIGIN'], 0, 5) == 'http:') ? 'https:' . substr($_SERVER['HTTP_ORIGIN'], 5) : $_SERVER['HTTP_ORIGIN'];
    	$output['invoices_url\|https'] .= '/?cmd=clientarea&action=invoices';

    	if($sslinfo['time_verify_from'] != ''){
	    	$makeDate1 = explode(' ', $sslinfo['time_verify_from']);
	    	$makeDate12 = explode(' ', $sslinfo['time_verify_to']);
	    	$output['date_call_1'] = date('d M Y', strtotime($makeDate1[0]));
	    	$output['call_from_1'] = $makeDate1[1];
	    	$output['call_to_1'] = $makeDate12[1];
	    	$output['gmt'] = $makeDate1[2];

	    	if($sslinfo['time_verify_from2'] != ''){
	    		$makeDate2 = explode(' ', $sslinfo['time_verify_from2']);
	    		$makeDate22 = explode(' ', $sslinfo['time_verify_to2']);
	    		$output['date_call_2'] = date('d M Y', strtotime($makeDate2[0]));
	    		$output['call_from_2'] = $makeDate2[1];
	    		$output['call_to_2'] = $makeDate22[1];
	    	}
    	}

    	$output['account_id'] = $request['id'];
    	$output['order_id'] = $orderId;
    	$output['authority_order_id'] = $sslinfo['authority_orderid'];
    	$output['email_approval'] = $sslinfo['email_approval'];


    	if($callinfo['time_verify_from'] != ''){
    		$ex1from = explode(' ', $callinfo['time_verify_from']);
    		$ex1to = explode(' ', $callinfo['time_verify_to']);
    		$date1from = date('d M Y', strtotime($ex1from[0]));
    		$date1to = date('d M Y', strtotime($ex1to[0]));
	    	$output['date_call_from_1'] = $date1from;
	    	$output['date_call_to_1'] = $date1to;
	    	$output['call_from_1'] = $ex1from[1];
	    	$output['call_to_1'] = $ex1to[1];
	    	$output['gmt'] = $ex1from[2];
    	}

    	if($callinfo['time_verify_from2'] != ''){
    		$ex2from = explode(' ', $callinfo['time_verify_from2']);
    		$ex2to = explode(' ', $callinfo['time_verify_to2']);
    		$date2from = date('d M Y', strtotime($ex2from[0]));
    		$date2to = date('d M Y', strtotime($ex2to[0]));
    		$output['date_call_from_2'] = $date2from;
    		$output['date_call_to_2'] = $date2to;
    		$output['call_from_2'] = $ex2from[1];
    		$output['call_to_2'] = $ex2to[1];
    		if(isset($output['gmt']) && $output['gmt'] == ''){
    			$output['gmt'] = $ex2from[2];
    		}
    	}

    	$output['live_chat_url'] = $this->getLiveChat($orderId);

    	return $output;
    }

    public function test_email($orderId, $to, $code, $test)
    {
    	require_once(HBFDIR_LIBS  . 'RvLibs/SSL/PHPMailer-master/class.phpmailer.php');
    	$db = hbm_db();

    	$emailDetail = $db->query("
    			SELECT
    				et.*
    			FROM
	    			hb_email_templates AS et
	    			, hb_ssl_email_templates AS ssl_et
    			WHERE
	    			ssl_et.code = '{$code}'
	    			AND ssl_et.email_template_id = et.id
	    ")->fetch();


    	$content = $emailDetail['message'];
    	$subject = $emailDetail['subject'];
    	if($test == 'false'){
    		$subject = $this->generateMailContent($orderId, $subject);
    		$content = $this->generateMailContent($orderId, $content);
    	}
    	$fromInfo = $this->generateEmailFrom($code);

    	$mail = new PHPMailerNew();
    	$mail->From = $fromInfo['mail'];                       // Sender Email
    	$mail->FromName = $fromInfo['name'];                                   // Sender Name
    	$mail->AddAddress($to);                                         // To
    	$mail->Subject = $subject;//$mailSubject;                                  	// Subject
    	//      $mail->AddCC($email_1);                                     	// Cc
    	$mail->Body = $content;//$mailContent;
    	$mail->CharSet = 'UTF-8';
    	$mail->ISHTML(true);

    	if($mail->Send()){
    		return true;
    	}
    	return $mail->ErrorInfo;
    }

    public function isTestMode()
    {
    	return (file_exists(HBFDIR_LIBS . 'RvLibs/SSL/developer.php')) ? true : false;
    }

    public function generateEmailFrom($code)
    {
    	$ssl = array('mail' => 'rvsslteam@rvglobalsoft.com', 'name' => 'RVSSL Team');
    	$rv = array('mail' => 'order@rvglobalsoft.com', 'name' => 'RVGlobalSoft Team');
    	return ($code != 'paidInvoice') ? $ssl : $rv;
    }

    public function generateSystemUrl()
    {
    	if($this->isTestMode()){
    		return 'http://hostbill.rvglobalsoft.net';
    	} else {
    		return 'https://www.rvglobalsoft.com';
    	}
    }

    public function generateAPICustom()
    {
    	require_once(APPDIR . 'class.api.custom.php');
    	if($this->isTestMode()){
    		return ApiCustom::singleton('http://hostbill.rvglobalsoft.com' . '/7944web/api.php');
    	} else {
    		return ApiCustom::singleton('https://rvglobalsoft.com' . '/7944web/api.php');
    	}
    }

    public function isRenewal($invoiceId)
    {
    	$db = hbm_db();

    	$aQuery = $db->query("
    			SELECT
    				DISTINCT so.is_renewal
    				, o.id
    			FROM
    				hb_invoice_items AS ii
    				, hb_accounts AS a
    				, hb_orders AS o
    				, hb_ssl_order AS so
    			WHERE
    				ii.invoice_id = :invoiceId
    				AND ii.item_id = a.id
    				AND a.order_id = o.id
    				AND o.invoice_id != ii.invoice_id
    				AND so.order_id = o.id
    			", array(
    				':invoiceId' => $invoiceId
    			)
    	)->fetch();

    	return ($aQuery && $aQuery['is_renewal']) ? true : false;
    }

    public function generatePartnerOrderId($orderId, $isRenew = false)
    {
    	$db = hbm_db();

    	$aQuery = $db->query("
    			SELECT
    				partner_order_id
    				, authority_orderid
    			FROM
    				hb_ssl_order
    			WHERE
    				order_id = :orderId
    			", array(
    				':orderId' => $orderId
    			)
    	)->fetch();

    	$isTest = $this->isTestMode();

    	if($aQuery){
    		if($aQuery['authority_orderid'] != '' && $isRenew){
    			$partnerId = $aQuery['partner_order_id'];
    			if(!strpos(' ' . $partnerId, 'RVSSL')){
    				$partnerId = 'RVSSL_' . $orderId;
    			}
    			$expId = explode('_', $partnerId);
    			$sizeExp = sizeof($expId);
    			$newPartnerId = '';
    			switch($sizeExp){
    				case 2 :
    					$newPartnerId .= $expId[0] . '_' . $expId[1] . '_' . '1';
    					return $newPartnerId;
    					break;
    				case 3 :
    					if($isTest){
    						$newPartnerId .= $expId[0] . '_' . $expId[1] . '_' . $expId[2] . '_' . '1';
    					} else {
    						$createTime = intval($expId[2]);
    						$createTime++;
    						$newPartnerId .= $expId[0] . '_' . $expId[1] . '_' . strval($createTime);
    					}
    					return $newPartnerId;
    					break;
    				case 4 :
    					if($isTest){
    						$createTime = intval($expId[3]);
    						$createTime++;
    						$newPartnerId .= $expId[0] . '_' . $expId[1] . '_' . $expId[2] . '_' . strval($createTime);
    						return $newPartnerId;
    					}
    					break;
    			}
    		} else {
    			return (!$isTest) ? 'RVSSL_' . $orderId : 'RVSSL_' . $orderId . '_DEV' . strtotime('now');
    		}
    	}

    	return false;
    }

    public function countryList()
    {
    	$country = array(
    			'' => 'select one', 'AF' => 'Afghanistan', 'AL' => 'Albania', 'DZ' => 'Algeria', 'AS' => 'American Samoa'
    			, 'AD' => 'Andorra', 'AG' => 'Angola', 'AI' => 'Anguilla', 'AG' => 'Antigua & Barbuda'
    			, 'AR' => 'Argentina', 'AA' => 'Armenia', 'AW' => 'Aruba', 'AU' => 'Australia'
    			, 'AT' => 'Austria', 'AZ' => 'Azerbaijan', 'BS' => 'Bahamas', 'BH' => 'Bahrain'
    			, 'BD' => 'Bangladesh', 'BB' => 'Barbados', 'BY' => 'Belarus', 'BE' => 'Belgium'
    			, 'BZ' => 'Belize', 'BJ' => 'Benin', 'BM' => 'Bermuda', 'BT' => 'Bhutan'
    			, 'BO' => 'Bolivia', 'BL' => 'Bonaire', 'BA' => 'Bosnia & Herzegovina', 'BW' => 'Botswana'
    			, 'BR' => 'Brazil', 'BC' => 'British Indian Ocean Ter', 'BN' => 'Brunei', 'BG' => 'Bulgaria'
    			, 'BF' => 'Burkina Faso', 'BI' => 'Burundi', 'KH' => 'Cambodia', 'CM' => 'Cameroon'
    			, 'CA' => 'Canada', 'IC' => 'Canary Islands', 'CV' => 'Cape Verde', 'KY' => 'Cayman Islands'
    			, 'CF' => 'Central African Republic', 'TD' => 'Chad', 'CD' => 'Channel Islands'
    			, 'CL' => 'Chile', 'CN' => 'China', 'CI' => 'Christmas Island', 'CS' => 'Cocos Island'
    			, 'CO' => 'Colombia', 'CC' => 'Comoros', 'CG' => 'Congo', 'CK' => 'Cook Islands'
    			, 'CR' => 'Costa Rica', 'CT' => 'Cote D\'Ivoire', 'HR' => 'Croatia', 'CU' => 'Cuba'
    			, 'CB' => 'Curacao', 'CY' => 'Cyprus', 'CZ' => 'Czech Republic', 'DK' => 'Denmark'
    			, 'DJ' => 'Djibouti', 'DM' => 'Dominica', 'DO' => 'Dominican Republic', 'TM' => 'East Timor'
    			, 'EC' => 'Ecuador', 'EG' => 'Egypt', 'SV' => 'El Salvador', 'GQ' => 'Equatorial Guinea'
    			, 'ER' => 'Eritrea', 'EE' => 'Estonia', 'ET' => 'Ethiopia', 'FA' => 'Falkland Islands'
    			, 'FO' => 'Faroe Islands', 'FJ' => 'Fiji', 'FI' => 'Finland', 'FR' => 'France'
    			, 'GF' => 'French Guiana', 'PF' => 'French Polynesia', 'FS' => 'French Southern Ter'
    			, 'GA' => 'Gabon', 'GM' => 'Gambia', 'GE' => 'Georgia', 'DE' => 'Germany'
    			, 'GH' => 'Ghana', 'GI' => 'Gibraltar', 'GB' => 'Great Britain', 'GR' => 'Greece'
    			, 'GL' => 'Greenland', 'GD' => 'Grenada', 'GP' => 'Guadeloupe', 'GU' => 'Guam'
    			, 'GT' => 'Guatemala', 'GN' => 'Guinea', 'GY' => 'Guyana', 'HT' => 'Haiti'
    			, 'HW' => 'Hawaii', 'HN' => 'Honduras', 'HK' => 'Hong Kong', 'HU' => 'Hungary'
    			, 'IS' => 'Iceland', 'IN' => 'India', 'ID' => 'Indonesia', 'IA' => 'Iran'
    			, 'IQ' => 'Iraq', 'IR' => 'Ireland', 'IM' => 'Isle of Man', 'IL' => 'Israel'
    			, 'IT' => 'Italy', 'JM' => 'Jamaica', 'JP' => 'Japan', 'JO' => 'Jordan', 'KZ' => 'Kazakhstan'
    			, 'KE' => 'Kenya', 'KI' => 'Kiribati', 'NK' => 'Korea North', 'KS' => 'Korea South'
    			, 'KW' => 'Kuwait', 'KG' => 'Kyrgyzstan', 'LA' => 'Laos', 'LV' => 'Latvia'
    			, 'LB' => 'Lebanon', 'LS' => 'Lesotho', 'LR' => 'Liberia', 'LY' => 'Libya'
    			, 'LI' => 'Liechtenstein', 'LT' => 'Lithuania', 'LU' => 'Luxembourg', 'MO' => 'Macau'
    			, 'MK' => 'Macedonia', 'MG' => 'Madagascar', 'MY' => 'Malaysia', 'MW' => 'Malawi'
    			, 'MV' => 'Maldives', 'ML' => 'Mali', 'MT' => 'Malta', 'MH' => 'Marshall Islands'
    			, 'MQ' => 'Martinique', 'MR' => 'Mauritania', 'MU' => 'Mauritius', 'ME' => 'Mayotte'
    			, 'MX' => 'Mexico', 'MI' => 'Midway Islands', 'MD' => 'Moldova', 'MC' => 'Monaco'
    			, 'MN' => 'Mongolia', 'MS' => 'Montserrat', 'MA' => 'Morocco', 'MZ' => 'Mozambique'
    			, 'MM' => 'Myanmar', 'NA' => 'Nambia', 'NU' => 'Nauru', 'NP' => 'Nepal'
    			, 'AN' => 'Netherland Antilles', 'NL' => 'Netherlands (Holland, \'Europe)', 'NV' => 'Nevis', 'NC' => 'New Caledonia'
    			, 'NZ' => 'New Zealand', 'NI' => 'Nicaragua', 'NE' => 'Niger', 'NG' => 'Nigeria'
    			, 'NW' => 'Niue', 'NF' => 'Norfolk Island', 'NO' => 'Norway', 'OM' => 'Oman'
    			, 'PK' => 'Pakistan', 'PW' => 'Palau Island', 'PS' => 'Palestine', 'PA' => 'Panama'
    			, 'PG' => 'Papua New Guinea', 'PY' => 'Paraguay', 'PE' => 'Peru', 'PH' => 'Philippines'
    			, 'PO' => 'Pitcairn Island', 'PL' => 'Poland', 'PT' => 'Portugal', 'PR' => 'Puerto Rico'
    			, 'QA' => 'Qatar', 'ME' => 'Republic of Montenegro', 'RS' => 'Republic of Serbia', 'RE' => 'Reunion'
    			, 'RO' => 'Romania', 'RU' => 'Russia', 'RW' => 'Rwanda', 'NT' => 'St Barthelemy'
    			, 'EU' => 'St Eustatius', 'HE' => 'St Helena', 'KN' => 'St Kitts-Nevis', 'LC' => 'St Lucia'
    			, 'MB' => 'St Maarten', 'PM' => 'St Pierre & Miquelon', 'VC' => 'St Vincent & Grenadines', 'SP' => 'Saipan'
    			, 'SO' => 'Samoa', 'AS' => 'Samoa American', 'SM' => 'San Marino', 'ST' => 'Sao Tome & Principe'
    			, 'SA' => 'Saudi Arabia', 'SN' => 'Senegal', 'RS' => 'Serbia', 'SC' => 'Seychelles'
    			, 'SL' => 'Sierra Leone', 'SG' => 'Singapore', 'SK' => 'Slovakia', 'SI' => 'Slovenia'
    			, 'SB' => 'Solomon Islands', 'OI' => 'Somalia', 'ZA' => 'South Africa', 'ES' => 'Spain'
    			, 'LK' => 'Sri Lanka', 'SD' => 'Sudan', 'SR' => 'Suriname', 'SZ' => 'Swaziland'
    			, 'SE' => 'Sweden', 'CH' => 'Switzerland', 'SY' => 'Syria', 'TA' => 'Tahiti'
    			, 'TW' => 'Taiwan', 'TJ' => 'Tajikistan', 'TZ' => 'Tanzania', 'TH' => 'Thailand'
    			, 'TG' => 'Togo', 'TK' => 'Tokelau', 'TO' => 'Tonga', 'TT' => 'Trinidad & Tobago'
    			, 'TN' => 'Tunisia', 'TR' => 'Turkey', 'TU' => 'Turkmenistan', 'TC' => 'Turks & Caicos Is'
    			, 'TV' => 'Tuvalu', 'UG' => 'Uganda', 'UA' => 'Ukraine', 'AE' => 'United Arab Emirates'
    			, 'GB' => 'United Kingdom', 'US' => 'United States of America', 'UY' => 'Uruguay', 'UZ' => 'Uzbekistan'
    			, 'VU' => 'Vanuatu', 'VS' => 'Vatican City State', 'VE' => 'Venezuela', 'VN' => 'Vietnam'
    			, 'VB' => 'Virgin Islands (Brit)', 'VA' => 'Virgin Islands (USA)', 'WK' => 'Wake Island', 'WF' => 'Wallis & Futana Is'
    			, 'YE' => 'Yemen', 'ZR' => 'Zaire', 'ZM' => 'Zambia', 'ZW' => 'Zimbabwe'
    	);
    	return $country;
    }

    public function sendMailNew($orderId, $code, $options = array())
    {
    	require_once(HBFDIR_LIBS  . 'RvLibs/SSL/PHPMailer-master/class.phpmailer.php');
    	$db = hbm_db();

    	$mailList = $this->get_email_template();
    	$to = $this->generateEmailReceiver($orderId, $mailList[$code]['to']);
    	$fromInfo = $this->generateEmailFrom($code);


    	if($to){
    		$emailDetail = $db->query("
    				SELECT
    					et.*
    				FROM
    					hb_email_templates AS et
    					, hb_ssl_email_templates AS ssl_et
    				WHERE
    					ssl_et.code = '{$code}'
    					AND ssl_et.email_template_id = et.id
    				")->fetch();
    		if($emailDetail){
    			$mail = new PHPMailerNew();
    			$mail->From = $fromInfo['mail'];
    			$mail->FromName = $fromInfo['name'];
    			$mail->AddAddress($to);
    			$mail->Subject = $this->generateMailContent($orderId, $emailDetail['subject'], $options);
    			$mail->Body = $this->generateMailContent($orderId, $emailDetail['message'], $options);

    			if($code == 'sendDocument'){
    				$file_location = array('acknowledgement', 'lawyer_license', 'organization', 'attorney_identification_card', 'opinion_letter');
    				$docLo = dirname(__FILE__) . '/../../../../uploads/ssl/documents/';
    				foreach($file_location as $eachLo){
    					$fileName = $eachLo . '_' . $orderId . '.pdf';
    					$eachFile = $docLo . $eachLo . '/' . $fileName;
    					if(file_exists($eachFile)){
    						$mail->AddAttachment($eachFile, $fileName);
    					}
    				}
    			}

    			$mail->ISHTML(true);
    			$mail->CharSet = 'UTF-8';

    			if($code == 'unsupportOrder'){
    				$mailSentCheck = $this->checkMailSent($orderId, $mail->Subject, $mail->Body);
    				if($mailSentCheck){
    					return false;
    				}
    			} else {
	    			if($this->checkEmailSent($orderId, $to, $emailDetail['subject'], $mail->Body)){
	    				return false;
	    			}
    			}

    			if($mail->Send()){
    				$this->emailLog($orderId, $to, $emailDetail['subject'], $mail->Body);
    				return true;
    			} else {
    				return false;
    			}
    		} else {
    			$subject = 'Please setting email template for "' . $mailList[$code]['text'] . '"';
    			$mail = new PHPMailerNew();
    			$mail->From = 'rvsslteam@rvglobalsoft.com';
    			$mail->FromName = 'RVSSL Team';
    			$mail->AddAddress('rvsslteam@rvglobalsoft.com');
    			$mail->Subject = $subject;
    			$mail->Body = $subject;
    			$mail->ISHTML(true);
    			$mail->CharSet = 'UTF-8';
    			$mail->Send();
    			$this->emailLog($orderId, 'rvsslteam@rvglobalsoft.com', $subject, $subject);

    			return false;
    		}
    	}
    	return false;
    }

    public function checkEmailSent($orderId, $to, $subject, $content)
    {
    	$db = hbm_db();
    	$clientId = $db->query("
	        			SELECT
	        				usr_id
	        			FROM
	        				hb_ssl_order
	        			WHERE
	        				order_id = :orderId
	        		", array(
    		        	':orderId' => $orderId
    		        )
    	)->fetch();
	    $client_id = $clientId['usr_id'];
    	$mailLog = $db->query("SELECT * FROM hb_email_log WHERE client_id = '{$client_id}' AND email = '{$to}' AND subject = '{$subject}' AND message = '{$content}'")->fetchAll();
    	return ($mailLog) ? true : false;
    }

    public function generateEmailReceiver($orderId, $type)
    {
    	$db = hbm_db();
    	$type = strtolower($type);
    	switch($type){
    		case 'authority' :
    			$aQuery = $db->query("
	    			SELECT
	    				sa.authority_email
	    			FROM
		    			hb_ssl AS s
		    			, hb_ssl_order AS so
		    			, hb_ssl_authority AS sa
	    			WHERE
		    			so.order_id = {$orderId}
		    			AND so.ssl_id = s.ssl_idclient
		    			AND s.ssl_authority_id = sa.ssl_authority_id
    			")->fetch();
    			if($aQuery){
    				$to = $aQuery['authority_email'];
    			} else {
    				return false;
    			}
    			break;
    		case 'staff' :
    			$to = 'ssl@tickets.rvglobalsoft.com';
    			break;
    		case 'client' :
    			$aQuery = $db->query("
	    			SELECT
	    				so.usr_id AS client_id
	    			FROM
	    				hb_ssl_order AS so
	    			WHERE
	    				so.order_id = {$orderId}
    			")->fetch();
    			if($aQuery){
    				$apiCustom = $this->generateAPICustom();
    				$clientDetail = $apiCustom->request(array('call' => 'getClientDetails', 'id' => $aQuery['client_id']));
    				if($clientDetail['success']){
    					$to = $clientDetail['client']['email'];
    				} else {
    					return false;
    				}
    			} else {
    				return 'false';
    				return false;
    			}
    			break;
    		default : return false;
    	}
    	return $to;
    }

    public function generateMailContent($orderId, $content, $options = array())
    {
    	$emailVar = $this->get_email_template_variable($orderId);
    	$content = preg_replace('/{(\s*)\$([\w+]*)(\s*)}/','{\$$2}', $content);

    	foreach($emailVar as $k => $v){
    		$content = preg_replace('/{\$' . $k . '}/', $v, $content);
    	}

    	foreach($options as $kk => $vv){
    		$content = preg_replace('/{\$' . $kk . '}/', $vv, $content);
    	}

    	$content = preg_replace('/{(\s*)\$([\w+]*)(\s*)}/', '', $content);

    	return $content;
    }

    public function checkMailSent($orderId, $subject, $body)
    {
    	$db = hbm_db();
    	$clientId = $db->query("
	        			SELECT
	        				usr_id
	        			FROM
	        				hb_ssl_order
	        			WHERE
	        				order_id = :orderId
	        		", array(
    		        				':orderId' => $orderId
    		        		)
    	)->fetch();
	    $clientId = $clientId['usr_id'];

	    $check = $db->query("
	    			SELECT
	    				date
	    			FROM
	    				hb_email_log
	    			WHERE
	    				client_id = :clientId
	    				AND subject = :subject
	    				AND message = :body
	    		", array(
	    			':clientId' => $clientId
	    			, ':subject' => $subject
	    			, ':body' => $body
	    		)
	    );
	    if(isset($check['date']) && $check['date'] != ''){
	    	$dateSent = explode(' ', trim($check['date']));
	    	$date = $dateSent[0];
	    	if($date == date('Y-m-d')){
	    		return true;
	    	}
	    }
	    return false;
    }

    public function emailLog($orderId, $to, $subject, $content)
    {
    	$db = hbm_db();
    	$clientId = $db->query("
	        			SELECT
	        				usr_id
	        			FROM
	        				hb_ssl_order
	        			WHERE
	        				order_id = :orderId
	        		", array(
	        			':orderId' => $orderId
	        		)
    	)->fetch();
	    if($clientId){
	    	$db->query("
	        		INSERT INTO
	        			hb_email_log
	        				(
	        					client_id
	        					, email
	        					, subject
	        					, message
	        					, date
	        					, status
	        				)
	        		VALUES(
	        				:clientId
	        				, :email
	        				, :subject
	        				, :message
	        				, :date
	        				, 1
	        		)", array(
	        			'clientId' => $clientId['usr_id']
	        			, ':email' => $to
	        			, ':subject' => $subject
	        			, ':message' => $content
	        			, ':date' => date('Y-m-d H:i:s')
	        		)
	    	);
	    }
    }

    public function checkClientCredit($orderId)
    {
    	$db = hbm_db();
    	$chk = $db->query("
    			SELECT
    				i.id
    			FROM
    				hb_orders AS o
    				, hb_invoices AS i
    			WHERE
    				o.id = {$orderId}
    				AND o.invoice_id = i.id
    				AND i.credit = i.subtotal
    				AND i.status = 'Paid'

    	")->fetch();

    	return ($chk) ? true : false;
    }

    public function getPromotionPrice($code, $pid, $cyc, $clientId)
    {
    	$db = hbm_db();
    	if(trim($code) != ''){
    		$coupon_description = $db->query("SELECT * FROM hb_coupons WHERE code = '{$code}'")->fetch();
    		$output = array('code' => $code);
    		if($coupon_description){
    			$sslDetail = $db->query("SELECT p.id FROM hb_ssl AS s, hb_products AS p WHERE s.ssl_id = {$pid} AND s.ssl_name = p.name")->fetch();
    			if($sslDetail){
    				$pid = $sslDetail['id'];
    			} else {
    				$output['messageError'] = "Sorry, the Coupon code is invalid because some data not found. Please tell staff.";
    			}

    			if(empty($output['messageError']) && $coupon_description['clients'] == 'existing' && $coupon_description['client_id'] != 0 && $coupon_description['client_id'] != $clientId){
    				$output['messageError'] = 'Sorry, coupon code is not available for this account.';
    			}

    			if (empty($output['messageError']) && $coupon_description['num_usage'] >= $coupon_description['max_usage'] && $coupon_description['max_usage'] > 0) {
    				$output['messageError'] = "Sorry, this Coupon is already reached its quota. Your order is going to have the normal price.";
    			}

    			if ($coupon_description['expires'] != "0000-00-00" && empty($output['messageError'])) {
    				$expires = strtotime($coupon_description['expires']);
    				$now = time();
    				if ($now > $expires) {
    					$output['messageError'] = "Sorry, the Coupon season is ended already. Your order is going to have the normal price.";
    				}
    			}
    			if(empty($output['messageError']) && $coupon_description['products'] != 'all'){
    				$exProduct = explode('|', $coupon_description['products']);
    				$not_found = true;
    				foreach($exProduct as $v){
    					if($v == $pid){
    						$not_found = false;
    						break;
    					}
    				}
    				if($not_found){
    					$output['messageError'] = "Sorry, the Coupon code is not available for this product.";
    				}
    			}

    			if(empty($output['messageError']) && $coupon_description['cycles'] != 'all'){
    				$pIsFree = $db->query("SELECT id FROM hb_common WHERE id = {$pid} AND rel = 'Product' AND paytype = 'Free'")->fetch();
    				if(!$pIsFree){
    					$exCycle = explode('|', $coupon_description['cycles']);
    					$cyc_not_found = true;
    					foreach($exCycle as $eachCycle){
	    					if($cyc_not_found){
		    					switch($cyc){
		    						case 'm' :
		    							if($eachCycle == 'Monthly') $cyc_not_found = false; break;
		    						case 'q' :
		    							if($eachCycle == 'Quarterly') $cyc_not_found = false; break;
		    						case 's' :
		    							if($eachCycle == 'Semi-Annually') $cyc_not_found = false; break;
		    						case 'a' :
		    						case '12' :
		    							if($eachCycle == 'Annually') $cyc_not_found = false; break;
		    						case 'b' :
		    						case '24' :
		    							if($eachCycle == 'Biennially') $cyc_not_found = false; break;
		    						case 't' :
		    						case '36' :
		    							if($eachCycle == 'Triennially') $cyc_not_found = false; break;
		    						case 'p4' :
		    							if($eachCycle == 'Quadrennially') $cyc_not_found = false; break;
		    						case 'p5' :
		    							if($eachCycle == 'Quinquennially') $cyc_not_found = false; break;
		    						case 'd' :
		    							if($eachCycle == 'Daily') $cyc_not_found = false; break;
		    						case 'w' :
		    							if($eachCycle == 'Weekly') $cyc_not_found = false; break;
		    						case 'h' :
		    							if($eachCycle == 'Hourly') $cyc_not_found = false; break;
		    						default :
		    							$cyc_not_found = true;
		    					}
	    					}
    					}
    					if($cyc_not_found){
    						$output['messageError'] = "Sorry, the Coupon code is available for another billing cycle. The billing cycle in your order is going to have the normal price.";
    					}
    				} else {
    					$output['messageError'] = "Sorry, this is free product.";
    				}
    			}
    			if(empty($output['messageError'])){
    				$output['type'] = $coupon_description['type'];
    				$output['value'] = $coupon_description['value'];
    				$output['cycle'] = $coupon_description['cycle'];
    			}
    		} else {
    			$output['messageError'] = "Sorry, the Coupon code is invalid. Please check again.";
    		}
    	} else {
    		$output = false;
    	}
    	return $output;
    }

    public function getExtraPromo($clientId, $code)
    {
    	$db = hbm_db();
    	$adminId = array('9819');

    	if(in_array($clientId, $adminId)){
    		$chk = $db->query("SELECT type, value FROM hb_coupons WHERE code = '{$code}'")->fetch();
    		if($chk && $chk['type'] == 'percent' && $chk['value'] == '100.00'){
    			return true;
    		}
    	}

    	return false;
    }

    public function getLiveChat($orderId)
    {
    	$url = '';
    	$db = hbm_db();
    	$getAuthority = $db->query("
    			SELECT
    				sa.authority_name
    			FROM
    				hb_accounts AS a
    				, hb_products AS p
    				, hb_ssl AS s
    				, hb_ssl_authority AS sa
    			WHERE
    				a.order_id = '{$orderId}'
    				AND a.product_id = p.id
    				AND p.name = s.ssl_name
    				AND s.ssl_authority_id = sa.ssl_authority_id
    			")->fetch();
    	if($getAuthority){
    		switch($getAuthority['authority_name']){
    			case 'Thawte':
    				$url = 'https://www.thawte.com/chat/chat_intro.html';
    				break;
    			case 'Rapid SSL':
    				$url = 'https://www.rapidssl.com/chat/intro.html';
    				break;
    			case 'GeoTrust':
    				$url = 'https://knowledge.geotrust.com/support/knowledge-base/index?page=chatConsole';
    				break;
    			case 'Verisign':
    				$url = 'https://knowledge.symantec.com/support/ssl-certificates-support/index?page=chatConsole';
    				break;
    		}
    	}
    	return $url;
    }
}
