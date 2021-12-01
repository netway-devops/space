<?php

/**
 * Account-related module (for ex. cPanel) successfully created account
 * Following variable is available to use in this file:  $details
 * $details = array(
 *   'service' => ACCOUNT DETAILS ARRAY,
 *   'account_id' => ACCOUNT ID, 'server' => RELATED SERVER DETAILS ARRAY
 * )
 */

$accountId  = isset($details['service']['id']) ? $details['service']['id'] : 0;

require_once(APPDIR . 'modules/Site/accounthandle/admin/class.accounthandle_controller.php');
accounthandle_controller::singleton()->hookAfterAccountCreate($accountId);

