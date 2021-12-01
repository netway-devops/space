<?php

/**
 * Client details has been updated in database
 * Following variable is available to use in this file:  $details contains previous and currend details.
 * Sample $details keys available:
 * $details['previous']['id'];
 * $details['previous']['firstname'];
 * $details['previous']['lastname'];
 * $details['previous']['comapnyname'];
 * $details['previous']['email'];
 * $details['previous']['address1'];
 * $details['previous']['address2'];
 * $details['previous']['city'];
 * $details['previous']['state'];
 * $details['previous']['postcode'];
 * $details['previous']['country'];
 * $details['previous']['phonenumber'];
 * $details['new']['id'];
 *  $details['new']['firstname'];
 *  $details['new']['lastname'];
 *  $details['new']['comapnyname'];
 *  $details['new']['email'];
 *  $details['new']['address1'];
 *  $details['new']['address2'];
 *  $details['new']['city'];
 *  $details['new']['state'];
 *  $details['new']['postcode'];
 *  $details['new']['country'];
 *  $details['new']['phonenumber']; //
 */

require_once(APPDIR . 'modules/Site/clienthandle/admin/class.clienthandle_controller.php');

clienthandle_controller::singleton()->hookAfterClientEdit($details);