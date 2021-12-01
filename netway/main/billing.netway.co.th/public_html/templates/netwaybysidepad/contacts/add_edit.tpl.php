<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : null;
// --- hostbill helper ---


// --- Get template variable ---
$aProfiles          = $this->get_template_vars('profiles');
// --- Get template variable ---

$this->assign('oClient', $oClient);
$this->assign('act', (isset($_GET['act']) ? $_GET['act'] : ''));


//echo '<pre>'.print_r($aIsUnableToDelete, true).'</pre>';