<?php

/**
 * HostBill succesfully renewed domain
 * $details = array('id'=>RELATED DOMAIN ID IN HOSTBILL,
 * 'name'=>DOMAIN NAME);
 * Following variable is available to use in this file:  $details
 */

$domainId  = isset($details['id']) ? $details['id'] : 0;

require_once(APPDIR . 'modules/Site/domainhandle/admin/class.domainhandle_controller.php');
domainhandle_controller::singleton()->hookAfterDomainRenew($domainId);


