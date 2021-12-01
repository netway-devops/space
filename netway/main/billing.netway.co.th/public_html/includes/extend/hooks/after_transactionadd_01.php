<?php

/**
 * Transaction has been sucessfully stored in HostBill database
 * Following variable is available to use in this file:  $details new transaction details, following keys are available:
 * $details['client_id']; //RELATED CLIENT ID,
 * $details['invoice_id']; //RELATED INVOICE ID
 * $details['module']; //RELATED GATEWAY NAME,
 * $details['date']; //TRANSACTION DATE,
 * $details['descr']; //TRANSACTION DESCRIPTION,
 * $details['in']; //IN AMOUNT,
 * $details['fee']; //APPLIED FEEs (if any),
 * $details['out']; //AMOUNT SENT to gateway from your account (if any)
 * $details['trans_id'];  //GATEWAY SPECIFIC Transaction ID)
 * $details['currency_id']; //Transaction currency id, default=0
 */


require_once(APPDIR . 'modules/Site/transactionhandle/admin/class.transactionhandle_controller.php');


transactionhandle_controller::singleton()->hookAfterTransactionAdd($details);
