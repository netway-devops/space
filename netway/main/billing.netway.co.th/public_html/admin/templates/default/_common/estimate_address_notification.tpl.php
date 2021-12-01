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
$aEstimate      = $this->get_template_vars('estimate');
// --- Get template variable ---

$estimateId     = isset($aEstimate['id']) ? $aEstimate['id'] : 0;

$result         = $db->query("
    SELECT
        e.*
    FROM
        hb_estimates e
    WHERE
        e.id = :id
    ", array(
        ':id'   => $estimateId
    ))->fetch();


$billingAddress   = $result['billing_address'];

$this->assign('billingAddress', $billingAddress);


//echo '<pre>'.print_r($aEstimate, true).'</pre>';