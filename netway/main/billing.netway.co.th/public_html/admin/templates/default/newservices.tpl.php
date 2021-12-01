<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_MODULES . 'Other/netway_reseller/admin/class.netway_reseller_controller.php');
require_once(APPDIR_MODULES . 'Other/producthandle/admin/class.producthandle_controller.php');

// --- hostbill helper ---
$api = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aProduct   = $this->get_template_vars('product');
// --- Get template variable ---

// --- reseller enable for this product ---
if (isset($aProduct['id'])) {
    $result     = netway_reseller_controller::singleton()->isEnableProductForReseller($aProduct['id'], $aProduct['ptype']);
    $aProduct['is_reseller']    = $result;
    $this->assign('product', $aProduct);
}

if($aProduct["category_id"] == 23){
	$getDescription = $db->query("
		SELECT
			a.name AS authority_name
			, v.name AS validation_name
			, v.abbreviation AS validation_abbreviation
			, d.*
		FROM
			hb_ssl AS s
			, hb_ssl_authority AS a
			, hb_ssl_description AS d
			, hb_ssl_validation AS v
		WHERE
			s.pid = :pid
			AND s.validation_id = v.id
			AND s.authority_id = a.id
			AND s.id = d.ssl_id
	", array(":pid" => $aProduct["id"]))->fetch();
	if($getDescription){
		$validation = $db->query("SELECT id, name FROM hb_ssl_validation")->fetchAll();
		$authority = $db->query("SELECT * FROM hb_ssl_authority")->fetchAll();
		$this->assign('ssl_data', $getDescription);
		$this->assign('ssl_validation', $validation);
		$this->assign('ssl_authority', $authority);
		$this->assign('no_ssl_data', false);
	} else {
		$this->assign('no_ssl_data', true);
	}
}


// --- load additional product configuration ---
if (isset($aProduct['id'])) {

	$aOtherModuleList = $api->request(array(
    	'call'      => 'module',
    	'module'    => 'apihandle',
    	'fn'        => 'listActivityModule',
    	'moduleType'     => 'Other',
    ));

	print_r($aOtherModuleList);

    $aProduct['isReturn']   = true;
    $result     = producthandle_controller::singleton()->getConfig($aProduct);
	$aProduct['aConfig']    = $result;

	//print_r($aProduct);
    $this->assign('product', $aProduct);
}

