<?php

/**
 * Invoice total amount has been changed (new item has been added/items edited etc)
 * Following variable is available to use in this file:  $details This variable keeps invoice id that total was updated
 */

require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

$invoiceId  = $details;
invoicehandle_controller::singleton()->hookAfterInvoiceUpdateTotal($invoiceId);
