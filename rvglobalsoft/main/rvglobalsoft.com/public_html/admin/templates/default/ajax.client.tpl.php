<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


$aStats     = $this->get_template_vars('stats');
$clientId   = $this->get_template_vars('client_id');

$aClientBilling     = $db->query("
                    SELECT cb.credit, cb.credit_swap
                    FROM hb_client_billing cb
                    WHERE cb.client_id = :clientId
                    ", array(
                        ':clientId' => $clientId
                    ))->fetch();
if (isset($aClientBilling['credit_swap']) && $aClientBilling['credit_swap'] > 0) {
    $aStats['credit_swap']      = $aClientBilling['credit_swap'];
    $aStats['credit_total']     = $aStats['credit'] + $aStats['credit_swap'];
}


$this->assign('aStats', $aStats);