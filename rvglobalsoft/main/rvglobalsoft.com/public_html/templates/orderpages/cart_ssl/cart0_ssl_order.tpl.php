<?php
#@LICENSE@#
$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
$db = hbm_db();
$aQuery = $db->query("SELECT s.ssl_name, v.ssl_validation_id AS validation FROM hb_ssl AS s, hb_ssl_validation AS v WHERE s.ssl_id = {$this->_tpl_vars['REQUEST']['ssl_id']} AND s.ssl_validation_id = v.ssl_validation_id")->fetch();
/// Set Input
$ssl_id 		= $this->_tpl_vars['REQUEST']['ssl_id'];
$ssl_price 		= $this->_tpl_vars['REQUEST']['ssl_price'];
$servertype 	= $this->_tpl_vars['REQUEST']['servertype'];
$csr_data 		= $this->_tpl_vars['REQUEST']['csr_data'];
$email_approval = ($aQuery['validation'] == 1) ? $this->_tpl_vars['REQUEST']['email_approval'] : $this->_tpl_vars['REQUEST']['txt_email_1'];//$this->_tpl_vars['REQUEST']['txt_email'];
$commonname 	= $this->_tpl_vars['REQUEST']['commonname'];
$sendCsrLater 	= $this->_tpl_vars['REQUEST']['submitCSROption'];
$md5data		= md5($csr_data);
// store data contact form for save database hb_ssl_order_contact
$client_id		= $_SESSION['AppSettings']['login']['id'];

$oorg = isset($this->_tpl_vars['REQUEST']['o_name']) ? $this->_tpl_vars['REQUEST']['o_name'] : '';
$otel = isset($this->_tpl_vars['REQUEST']['o_phone']) ? $this->_tpl_vars['REQUEST']['o_phone'] : '';
$oaddress = isset($this->_tpl_vars['REQUEST']['o_address']) ? $this->_tpl_vars['REQUEST']['o_address'] : '';
$ocity = isset($this->_tpl_vars['REQUEST']['o_city']) ?  $this->_tpl_vars['REQUEST']['o_city'] : '';
$ostate = isset($this->_tpl_vars['REQUEST']['o_state']) ? $this->_tpl_vars['REQUEST']['o_state'] : '';
$ocountry = isset($this->_tpl_vars['REQUEST']['o_country']) ? $this->_tpl_vars['REQUEST']['o_country'] : '';
$opost = isset($this->_tpl_vars['REQUEST']['o_postcode']) ? $this->_tpl_vars['REQUEST']['o_postcode'] : '';

$firstname 		= $this->_tpl_vars['REQUEST']['txt_name'];
$lastname 		= $this->_tpl_vars['REQUEST']['txt_lastname'];
$email          = $this->_tpl_vars['REQUEST']['txt_email'];
$organize		= isset($this->_tpl_vars['REQUEST']['txt_org']) ? $this->_tpl_vars['REQUEST']['txt_org'] : '';
$job 			= $this->_tpl_vars['REQUEST']['txt_job'];
$address		= isset($this->_tpl_vars['REQUEST']['txt_address']) ? $this->_tpl_vars['REQUEST']['txt_address'] : '';
$city			= isset($this->_tpl_vars['REQUEST']['txt_city']) ? $this->_tpl_vars['REQUEST']['txt_city'] : '';
$state			= isset($this->_tpl_vars['REQUEST']['txt_state']) ? $this->_tpl_vars['REQUEST']['txt_state'] : '';
$country		= isset($this->_tpl_vars['REQUEST']['txt_country']) ? $this->_tpl_vars['REQUEST']['txt_country'] : '';
$post_code		= isset($this->_tpl_vars['REQUEST']['txt_post_code']) ? $this->_tpl_vars['REQUEST']['txt_post_code'] : '';
$tel 			= $this->_tpl_vars['REQUEST']['txt_tel'];
$ext        	= $this->_tpl_vars['REQUEST']['txt_ext'];


$firstname_1    = $this->_tpl_vars['REQUEST']['txt_name_1'];
$lastname_1     = $this->_tpl_vars['REQUEST']['txt_lastname_1'];
$email_1        = $this->_tpl_vars['REQUEST']['txt_email_1'];
$organize_1		= isset($this->_tpl_vars['REQUEST']['txt_org_1']) ? $this->_tpl_vars['REQUEST']['txt_org_1'] : '';
$job_1          = $this->_tpl_vars['REQUEST']['txt_job_1'];
$address_1		= isset($this->_tpl_vars['REQUEST']['txt_address_1']) ? $this->_tpl_vars['REQUEST']['txt_address_1'] : '';
$city_1			= isset($this->_tpl_vars['REQUEST']['txt_city_1']) ? $this->_tpl_vars['REQUEST']['txt_city_1'] : '';
$state_1		= isset($this->_tpl_vars['REQUEST']['txt_state_1']) ? $this->_tpl_vars['REQUEST']['txt_state_1'] : '';
$country_1		= isset($this->_tpl_vars['REQUEST']['txt_country_1']) ? $this->_tpl_vars['REQUEST']['txt_country_1'] : '';
$post_code_1	= isset($this->_tpl_vars['REQUEST']['txt_post_code_1']) ? $this->_tpl_vars['REQUEST']['txt_post_code_1'] : '';
$tel_1        	= $this->_tpl_vars['REQUEST']['txt_tel_1'];
$ext_1        	= $this->_tpl_vars['REQUEST']['txt_ext_1'];

$ssl_validation_id = $this->_tpl_vars['REQUEST']['ssl_validation_id'];
$isSSLOrder   = $this->_tpl_vars['REQUEST']['isSSLOrder'];
$sha   = $this->_tpl_vars['REQUEST']['sha'];
$ch_same_address = $this->_tpl_vars['REQUEST']['ch_same_address'];
$hashing_algorithm = $this->_tpl_vars['REQUEST']['hashing'];

$aCart = $_SESSION['AppSettings']['Cart'];
$cCart = count($_SESSION['AppSettings']['Cart']);

/// Get SSL Product Info
$oSSL = $oAuth->request('get', 'sslitems', array('id' => $ssl_id));
$aPrice = (array) $oSSL->_Price;

$recurring = 'a';
if ($ssl_price == 24) {
	$recurring = 'b';
} else if ($ssl_price == 36) {
	$recurring = 't';
}

$_SESSION['SSLITEM'] = array(
	'ssl_id' 			=> $ssl_id,
	'pid' 				=> $oSSL->pid,
	'contract' 			=> $ssl_price,
	'servertype' 		=> $servertype,
	'csr' 				=> $csr_data,
	'email_approval' 	=> $email_approval,
	'commonname' 		=> $commonname,
	'sendCsrLater' 		=> $sendCsrLater,
	'ssl_validation_id' => $ssl_validation_id,
	'isSSLOrder'       	=> $isSSLOrder,
	'sha'              	=> $sha,
	'same_address'		=> $ch_same_address,
	'hashing_algorithm'	=> $hashing_algorithm
);

unset($_SESSION['SSLSAN']);
if(isset($this->_tpl_vars['REQUEST']['additional_domain'])){
	$_SESSION['SSLSAN']['additional_domain'] = $this->_tpl_vars['REQUEST']['additional_domain'];
}

if(isset($this->_tpl_vars['REQUEST']['additional_server'])){
	$_SESSION['SSLSAN']['additional_server'] = $this->_tpl_vars['REQUEST']['additional_server'];
}

if(isset($this->_tpl_vars['REQUEST']['dns_name']) && trim($this->_tpl_vars['REQUEST']['dns_name']) != ''){
	$_SESSION['SSLSAN']['dns_name'] = $this->_tpl_vars['REQUEST']['dns_name'];
}

$_SESSION['ADD_LOADER_CART_SSL'] = 'TRUE';

$this->assign('cCart', $cCart);
$this->assign('ssl_id', $ssl_id);
$this->assign('aCart', $aCart);
$this->assign('pid', $oSSL->pid);
$this->assign('cycle', $recurring);

//ถ้าไม่ใส่ csr ไม่บันทึกข้อมูลการติดต่อ
if($csr_data !=""){
	if($sendCsrLater == ""){
		if($oorg != '' && $otel != '' && $oaddress != '' && $ocity != '' && $ostate != '' && $ocountry != '' && $opost != ''){
			$query_newdata = $db->query("
					INSERT INTO hb_ssl_order_contact
					(client_id,csr_md5,domain_name,organization_name,telephone,phone,address,city,country,postal_code,state,address_type) VALUES(
					:clientId,:md5,:commonname,:organize,:tel,:tel,:address,:city,:country,:post,:state,0)
			", array(":clientId" => $client_id, ":md5" => $md5data, ":commonname" => $commonname, ":organize" => $oorg, ":tel" => $otel, ":address" => $oaddress, ":city" => $ocity, ":country" => $ocountry, ":post" => $opost, ":state" => $ostate));
		}
		$query_newdata = $db->query("
				INSERT INTO hb_ssl_order_contact
				(client_id,csr_md5,domain_name,firstname,lastname,organization_name,address,city,state,country,postal_code,job,telephone,phone,email_approval,address_type,ext_number) VALUES(
				:clientId,:md5,:commonname,:firstname,:lastname,:organize,:address,:city,:state,:country,:post_code,:job,:tel,:tel,:email,1,:ext)
		", array(":clientId" => $client_id, ":md5" => $md5data, ":commonname" => $commonname, ":firstname" => $firstname, ":lastname" => $lastname, ":organize" => $organize, ":address" => $address, ":city" => $city, ":state" => $state, ":country" => $country, ":post_code" => $post_code, ":job" => $job, ":tel" => $tel, ":email" => $email, ":ext" => $ext));
		$query_newdata = $db->query("
				INSERT INTO hb_ssl_order_contact
				(client_id,csr_md5,domain_name,firstname,lastname,organization_name,address,city,state,country,postal_code,job,telephone,phone,email_approval,address_type,ext_number) VALUES(
				:clientId,:md5,:commonname,:firstname,:lastname,:organize,:address,:city,:state,:country,:post_code,:job,:tel,:tel,:email,2,:ext)
		", array(":clientId" => $client_id, ":md5" => $md5data, ":commonname" => $commonname, ":firstname" => $firstname_1, ":lastname" => $lastname_1, ":organize" => $organize_1, ":address" => $address_1, ":city" => $city_1, ":state" => $state_1, ":country" => $country_1, ":post_code" => $post_code_1, ":job" => $job_1, ":tel" => $tel_1, ":email" => $email_1, ":ext" => $ext_1));
	}
}



unset($_SESSION['SSLPROMO']);
if($this->_tpl_vars['REQUEST']['promo_code_used']){
	$_SESSION['SSLPROMO'] = json_decode(base64_decode($this->_tpl_vars['REQUEST']['promo_code_data']), 1);
}
