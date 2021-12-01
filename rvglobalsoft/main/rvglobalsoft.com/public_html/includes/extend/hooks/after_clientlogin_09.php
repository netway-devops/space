<?php

/**
 * Client with ID=$details just logged in
 * Following variable is available to use in this file:  $details Client id in HostBill
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

/**
 * Create Zendesk user if not existed.
 */

$clientId       = $details;

require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');

$aParam     = array(
    'clientId'  => $clientId
);

zendeskintegratehandle_controller::singleton()->updateZendeskUser($aParam);
