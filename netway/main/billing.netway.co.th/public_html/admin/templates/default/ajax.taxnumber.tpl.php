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
$aDetails   = $this->get_template_vars('details');
// --- Get template variable ---
$aInvoice   = $this->get_template_vars('invoice');
require_once(APPDIR . 'class.config.custom.php');
$nwSODNumber    = ConfigCustom::singleton()->getValue('nwSODNumber');
$nwSODNumber++;
$this->assign('nwSODNumber', $nwSODNumber);

$aQueryCanCreateSOD = $db->query("
SELECT
create_sod_status
FROM
hb_invoices
WHERE
id = :invoiceID
", array(
    ':invoiceID' => $aInvoice['id']
))->fetch();
    
$showCreateSODButton = 0;

if (isset($aQueryCanCreateSOD['create_sod_status']) && $aQueryCanCreateSOD['create_sod_status'] == 1 && ($aInvoice['status'] == 'Paid' || $aInvoice['status'] == 'Collections')) {
    require_once(APPDIR_MODULES . 'Other/dbc_integration/model/class.dbc_integration_model.php');
    $dbcCustomerRowId = dbc_integration_model::singleton()->getDBCCustomerIDByHBClientID($aInvoice['client_id']);
    if (!empty($dbcCustomerRowId)) {
        $showCreateSODButton = 1;
   }
}

$this->assign('showCreateSODButton', $showCreateSODButton);