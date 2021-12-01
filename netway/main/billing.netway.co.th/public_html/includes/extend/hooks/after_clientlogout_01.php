<?php

/**
 * Client with ID=$details just logged out
 * Following variable is available to use in this file:  $details client id in HostBill
 */
require_once(APPDIR . 'modules/Site/logouthandle/user/class.logouthandle_controller.php');

$clientId  = $details;
logouthandle_controller::singleton()->hookAfterclientlogout($clientId);