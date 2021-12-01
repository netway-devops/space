<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : null;
// --- hostbill helper ---


// --- Get template variable ---
$aSubmit    = $this->get_template_vars('submit');
// --- Get template variable ---

$this->assign('oClient', $oClient);

$newPassword        = GeneralCustom::singleton()->randomPassword();
$this->assign('newPassword', $newPassword);

//echo '<pre>'.print_r($aSubmit, true).'</pre>';