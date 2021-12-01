<?php

/**
 * New invoice has just been created with ID=$details
 *  This event is called after every items saved for the invoice.
 *  So if you will get this event you will be sure that invoice has been successfully created.
 * Following variable is available to use in this file:  $details This variable keeps invoice id
 */

require_once(APPDIR . 'class.discount.custom.php');
require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

$invoiceId          = $details;
invoicehandle_controller::singleton()->hookAfterInvoiceCreate($invoiceId);
