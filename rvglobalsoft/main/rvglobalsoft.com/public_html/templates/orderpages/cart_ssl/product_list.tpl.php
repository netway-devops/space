<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
	exit;
}
require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';

$oSSL =& RvLibs_RvGlobalSoftApi::singleton();
$aSSLbyprice = $oSSL->request('get', 'ssl_productlistbyprice');
$aSSLbyproperty = $oSSL->request('get', 'ssl_productlistbyproperty');
$chksession = $_SESSION['AppSettings']['login'];
/// Assign Values to Template

$this->assign('aSSLbyprice', getSort($aSSLbyprice, $_GET['sort']));
$this->assign('aSSLbyproperty', $aSSLbyproperty);
$this->assign('chksession', $chksession);
$this->assign('now_url', str_replace('&sort=' . $_GET['sort'], '', $_SERVER['PHP_SELF']));
$this->assign('nowSort', strtolower($_GET['sort']));

function getSANPrice($priceList)
{
	$db = hbm_db();
	$api = new ApiWrapper();
	foreach($priceList as $k => $v){
		$aQuery = $db->query("SELECT id FROM hb_products WHERE name = '{$v->ssl_name}'")->fetch();
		$priceList[$k]->pid = $aQuery['id'];
		$productAddonsList = $api->getProductApplicableAddons(array('id' => $aQuery['id']));
		if($productAddonsList['success']){
			foreach($productAddonsList['addons']['addons'] as $vv){
				$productId = explode(',', $vv['products']);
				if(in_array($aQuery['id'], $productId)){
					$addonDetail = $api->getAddonDetails(array('id' => $vv['id']));
					$priceList[$k]->sanPrice = $addonDetail['addon']['a'];
				}
			}
		}
	}
	return $priceList;
}

function getSort($priceList, $sort)
{
	$aSSLbypriceSort = array();
	$buff = array();
	if(strtolower($sort) == 'validation'){
		foreach($priceList as $k => $v){
			$buff[$v->validation_name][] = $k;
		}

		foreach($buff as $k => $v){
			foreach($v as $vv){
				$aSSLbypriceSort[] = $priceList[$vv];
			}
		}
		$priceList = $aSSLbypriceSort;
	} else if(strtolower($sort) == 'price'){
		foreach($priceList as $k => $v){
			$buff[$k]= $v->oneyear;
		}

		asort($buff);
		foreach($buff as $k => $v){
			$aSSLbypriceSort[] = $priceList[$k];
		}
		$priceList = $aSSLbypriceSort;
	}

	return $priceList;
}

