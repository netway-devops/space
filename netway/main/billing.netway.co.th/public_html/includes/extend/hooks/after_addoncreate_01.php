<?php

/**
 * Addon was activated
 * Following variable is available to use in this file:  $details is ID property in hb_accounts_addons table
 */

$addonId    = $details;

require_once(APPDIR . 'modules/Site/accountaddonhandle/admin/class.accountaddonhandle_controller.php');
accountaddonhandle_controller::singleton()->hookAfterAccountAddonCreate($addonId);



