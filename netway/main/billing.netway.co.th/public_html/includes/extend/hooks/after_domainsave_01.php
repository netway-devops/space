<?php

/**
 * Domain details has been changed
 * Following variable is available to use in this file:  $details POST params from domain details save form.
 * Some of available keys:
 * $details['id']; // Domain id in hb_domains table
 * $details['period']; // Domain registartion period (in years)
 * $details['expires']; // Domain expiration date
 * $details['date_created']; // Domain registartion date
 * $details['reg_module']; // Domain registrar module ID
 * $details['firstpayment']; // Domain registration price
 * $details['status']; // Current domain status
 * $details['recurring_amount']; // Current domain renewal price
 * $details['name']; // Domain name, ie. example.com
 * $details['nameservers']['ns1']; // Domain NS1
 * $details['nameservers']['ns2']; // Domain NS2
 * $details['epp_code']; // Domain Epp Code
 * $details['autorenew']; // Is aytorenew enabled
 * $details['notes']; // Domain notes
 */

$domainId  = isset($details['id']) ? $details['id'] : 0;

require_once(APPDIR . 'modules/Site/domainhandle/admin/class.domainhandle_controller.php');
domainhandle_controller::singleton()->hookAfterDomainSave($domainId);
