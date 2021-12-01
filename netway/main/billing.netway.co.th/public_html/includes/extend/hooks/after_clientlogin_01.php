<?php

/**
 * Client with ID=$details just logged in
 * Following variable is available to use in this file:  $details Client id in HostBill
 */

require_once(APPDIR . 'modules/Site/clienthandle/admin/class.clienthandle_controller.php');

$clientId       = $details;
//clienthandle_controller::singleton()->hookAfterClientLogin($clientId);
