<?php
require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
$oA = RvLibs_SSL_PHPLibs::singleton();
$api = new ApiWrapper();
$db =   hbm_db();

if (isset($_GET)) {
	foreach ($_GET as $k => $v) {
		$this->_tpl_vars['REQUEST'][$k] = "{$v}";
		if($k == 'csr' && base64_decode($v)){
			$this->_tpl_vars['REQUEST'][$k] = base64_decode($v);
		}
	}
}
$ssl_id = $this->_tpl_vars['REQUEST']['ssl_id'];
$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
$oSSL = $oAuth->request('get', 'sslitems', array('id' => $ssl_id));
$pid = $oSSL->pid;
$aPrice = (array) $oSSL->_Price;

$setDefault = 24;
$selectConract = ($this->_tpl_vars['REQUEST']['ssl_price'])
? $this->_tpl_vars['REQUEST']['ssl_price']
: $setDefault;
$aCart = $_SESSION['AppSettings']['Cart'];
$cCart = count($_SESSION['AppSettings']['Cart']);

if(isset($aCart)){
	if($cCart != 0){

		foreach ($aCart as $k => $v) {
			$category_name = $v['product']['category_name'];
			//print $category_name;
			if($category_name == 'SSL'){
				$chkinOrder = 1;
				break;
			}
			else{
				$chkinOrder = 0;
			}
		}
	}else{
		$chkinOrder = 1;
	}
}
$cartItems      = isset($_SESSION['AppSettings']['Cart']) ? count($_SESSION['AppSettings']['Cart']) : 0;
$this->assign('cartItems', $cartItems);
$aSSL = (array) $oSSL;
/// Assign Values to Template
$this->assign('hide_email', ($aSSL['ssl_validation_id'] == '1') ? 0 : 1);
$this->assign('is_wild_card', ($aSSL['secure_subdomain']) ? 1 : 0);

$firstPrice = 0.00;
foreach($aPrice as $k => $v){
	if($selectConract == intval($k)){
		$firstPrice = floatval($v);
	}
}

$productAddonsList = $api->getProductApplicableAddons(array('id' => $pid));
if($productAddonsList['success']){
	$productAddonsSANPrice = array();
	foreach($productAddonsList['addons']['addons'] as $vv){
		$productId = explode(',', $vv['products']);
		if(in_array($pid, $productId)){
			$addonDetail = $api->getAddonDetails(array('id' => $vv['id']));
			$productAddonsSANPrice['12'] = $addonDetail['addon']['a'];
			$productAddonsSANPrice['24'] = $addonDetail['addon']['b'];
			$productAddonsSANPrice['36'] = $addonDetail['addon']['t'];
		}
	}
}

$sanQuery = $db->query("SELECT ssl_productcode, support_for_san, san_startup_domains, san_max_domains, san_max_servers FROM hb_ssl WHERE ssl_id = {$ssl_id}")->fetch();

$this->assign('aSSL', $aSSL);
$this->assign('selectConract', $selectConract);
$this->assign('ssl_id', $ssl_id);
$this->assign('chkinOrder', $chkinOrder);
$this->assign('firstPrice', $firstPrice);
$this->assign('ssl_productcode', $sanQuery['ssl_productcode']);
$this->assign('hashing_data', $oA->generateHashingAlgorithm());

if($sanQuery['support_for_san']){
	$this->assign('sanInclude', $sanQuery['san_startup_domains']);
	$this->assign('sanPrice', $productAddonsSANPrice);
	$this->assign('sanPriceJS', json_encode($productAddonsSANPrice));
	$this->assign('sanMax', $sanQuery['san_max_domains']);
	$this->assign('servMax', $sanQuery['san_max_servers']);
	$this->assign('support_san', true);
} else {
	$this->assign('support_san', false);
}

$authorityQuery = $db->query("
		SELECT
			s.ssl_authority_id
		FROM
			hb_ssl AS s
			, hb_ssl_authority AS sa
		WHERE
			s.ssl_id = {$ssl_id}
			AND s.ssl_authority_id = sa.ssl_authority_id
			AND sa.authority_name = 'Verisign'
")->fetch();
if($authorityQuery){
	$this->assign('is_symantec', true);
}

$oSSL =& RvLibs_RvGlobalSoftApi::singleton();
$aSSLbyprice = $oSSL->request('get', 'ssl_productlistbyprice');
$this->assign('aSSLbyprice', $aSSLbyprice);
$this->assign('client_login_id', $_SESSION['AppSettings']['login']['id']);
$this->assign('country_list', countryList());


if(file_exists('/home/rvglobal/public_html/hbf/libs/RvLibs/SSL/developer.php')){
	$this->assign('testMode', true);
}

function countryList()
{
	require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
	$oAuth =& RvLibs_SSL_PHPLibs::singleton();

	$country = $oAuth->countryList();
	return $country;
}
?>