<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aFields        = $this->get_template_vars('fields');
// --- Get template variable ---
$result =	array();
$result	=	$db->query("
						SELECT
							*
						FROM
							hb_cloud_os_template
					")->fetchAll();
$newData = array();
foreach($result as $aData){
	$newData[$aData['id']] = $aData;
}
$this->assign('aCloudOsTempConfig', $newData);
/*
require_once('/home/prasit/public_html/manage.netway.co.th/public_html/includes/libs/configoptions/fileupload/class.fileupload.php');
$x = new Fileupload();

echo '<pre>'.print_r($x, true).'</pre>';
*/