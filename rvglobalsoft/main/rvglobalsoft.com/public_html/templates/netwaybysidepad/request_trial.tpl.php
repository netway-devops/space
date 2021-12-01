<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api            = new ApiWrapper();
$db             = hbm_db();
$client         = hbm_logged_client();
// --- hostbill helper ---

require_once(APPDIR .'modules/Site/requesttrialhandle/user/class.requesttrialhandle_controller.php');

// --- Get template variable ---
$aSubmit        = $this->get_template_vars('submit');
$productId      = isset($_GET['id']) ? $_GET['id'] : 0;
// --- Get template variable ---

$this->assign('productId', $productId);

$result         = requesttrialhandle_controller::singleton()->getProductInfo($productId);
$this->assign('aProduct', $result);


//echo '<pre>'.print_r($_GET, true).'</pre>';


