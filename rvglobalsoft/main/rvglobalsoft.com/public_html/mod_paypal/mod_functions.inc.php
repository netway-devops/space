<?php
// $Id: mod_functions.inc.php 2 2006-02-09 06:37:38Z mfountain $
// +----------------------------------------------------------------------+
// | ModernBill [TM] .:. Client Billing System                            |
// +----------------------------------------------------------------------+
// | Copyright (c) 2001-2003 ModernGigabyte, LLC                          |
// +----------------------------------------------------------------------+
// | This source file is subject to the ModernBill End User License       |
// | Agreement (EULA), that is bundled with this package in the file      |
// | LICENSE, and is available at through the world-wide-web at           |
// | http://www.modernbill.com/extranet/LICENSE.txt                       |
// | If you did not receive a copy of the ModernBill license and are      |
// | unable to obtain it through the world-wide-web, please send a note   |
// | to license@modernbill.com so we can email you a copy immediately.    |
// +----------------------------------------------------------------------+
// | Authors: ModernGigabyte, LLC <info@moderngigabyte.com>               |
// | Support: http://www.modernsupport.com/modernbill/                    |
// +----------------------------------------------------------------------+
// | ModernGigabyte and ModernBill are trademarks of ModernGigabyte, LLC. |
// +----------------------------------------------------------------------+
define(PAYPALPAYMENT, 'PayPal Payment');
define(PAYPALSUBSCRIPTIONPAYMENT, 'PayPal Subscription Payment');

function generate_paypal_link($item_name,$invoice_id,$amount,$pp_link_type=NULL)
{
	 GLOBAL $_CONFIG,$_GATEWAYS,$order_totals,$anniversary_billing,$allow_html_emails;

         $subscriptionOK = 1;

         // set local variables
         extract($_GATEWAYS['mod_paypal']);

         // fetch client details
         $this_client = adodb_one_array("SELECT *
                                           FROM client_invoice i, client_info c
                                          WHERE i.client_id = c.client_id
                                            AND i.invoice_id = '$invoice_id'", 'A');
         $order_snapshot = unserialize($this_client[serialized_snapshot]);

         //$has_subscription = adodb_one_data("SELECT `client_id` FROM `client_subscriptions` WHERE `client_id` = '$this_client[client_id]' AND cs_status= '1'");

// If the invoice is being resent, we need to get the order_totals information.
// from the order snapshot.
         if ( !$order_totals )
         {
           if ( is_array($order_snapshot[order_totals]))
           {
            $order_totals = $order_snapshot[order_totals];
           }
         }

         $total_domain_price = $order_snapshot['domains']['total_domain_price'];
         $recurring_price = $order_snapshot[order_totals][due_next_renewal_tax_included];
         $recurring_price = number_format($recurring_price, 2, '.', '');
         $total_domain_price = number_format($total_domain_price, 2, '.', '');


         // clean charge amount
         $amount = str_replace(",","",display_currency($amount,1));

         // subscriptions information

            if ($anniversary_billing) {

                switch ($order_totals['cp_billing_cycle']) {

                        case 12:  $cp_billing_cycle = 12; $p1 = 12; break;
                        case 6:   $cp_billing_cycle = 6;  $p1 = 6; break;
                        case 3:   $cp_billing_cycle = 3;  $p1 = 3; break;
                        case 1:   $cp_billing_cycle = 1;  $p1 = 1; break;
                        default:  $subscriptionOK   = 0;  break;
                }

                $t1 = 'M';

            } else {

                $t1 = 'D';
                $next_renewal = (!empty($order_totals['due_next_timestamp'])) ? $order_totals['due_next_timestamp'] : mktime(0,0,0,date('m')+1,1,date('Y')) ;
                $p1 = days_between($next_renewal,mktime());

                switch ($order_totals['cp_billing_cycle']) {

                        case 12:  $cp_billing_cycle = 12; break;
                        case 6:   $cp_billing_cycle = 6;  break;
                        case 3:   $cp_billing_cycle = 3;  break;
                        case 1:   $cp_billing_cycle = 1;  break;
                        default:  $subscriptionOK   = 0;  break;
                }

            }

                         // Trial amount 1. This is the price of the first trial period. For a free
                         // trial, use a value of 0
         $paypal_url2 =   "&a1=$amount&"

                         // Trial period 1. This is the length of the first trial period. The number
                         // is modified by the trial period 1 units (t1, below)
                         ."p1=$p1&"

                         // Trial period 1 units. This is the units of trial period 1 (p1, above).
                         // Acceptable values are: D (days), W (weeks), M (months), Y (years)
                         ."t1=$t1&"
                         # ."t1=D&"

                         // [required] Regular rate. This is the price of the subscription
                         ."a3=".$recurring_price."&"

                         //[required] Regular billing cycle. This is the length of the billing
                         // cycle. The number is modified by the regular billing cycle units (t3,below)
                         ."p3=$cp_billing_cycle&"

                         // [required] Regular billing cycle units. This is the units of the regular
                         // billing cycle (p3, above) Acceptable values are: D (days), W
                         // (weeks), M (months), Y (years)
                         ."t3=M&"
                         #."t3=D&"


                         // Recurring payments.
                         ."src=1&"

                         // Reattempt on failure.
                         ."sra=1&"

                         // Modification behavior. If set to zero or omitted, the button will only
                         // allow buyers to create new subscriptions. If set to “1”, the button
                         // will only allow buyers to modify existing subscriptions according to
                         // the other parameters specified by the button. If set to “2”, the
                         // button will allow buyers to modify current subscriptions if they have
                         // any, and to sign up for new subscriptions if they do not
                         ."modify=0";


         $paypal_url1 =   "&amount=$amount";

         // start building URL

         $paypal_url  = "business=$business&"

                         ."&#99;urrency_code=$currency_code&"

					."item_name=".urlencode($item_name)."&"

                         // passthrough
                         ."item_number=$invoice_id&"

                         // passthrough
                         ."custom=&"

                         // UNIQUE passthrough Not used.. invoice and item_number are treated the same.
                         //."invoice=$invoice_id&"

					."image_url=".str_replace(':','%3A',$image_url)."&"

                    ."return=".str_replace(':','%3A',$return)."&"
                         //"return=$pp_return&amp;"
                         //"cancel_return=$pp_cancel_return&amp;"

					."&#110;otify_url=".str_replace(':','%3A',$notify_url)."&"

                         // must be 1
                         ."no_note=1&"
                         ."no_shipping=1&"

                         // Return uses GET instead of POST
                         ."rm=1&"

                         // send client details
                         ."first_name=".urlencode(utf8_decode($this_client['client_fname']))."&"
                         ."last_name=". urlencode(utf8_decode($this_client['client_lname']))."&"
                         ."address1=".  urlencode(utf8_decode($this_client['client_address']))."&"
                         ."city=".      urlencode(utf8_decode($this_client['client_city']))."&"
                         ."state=".     urlencode(utf8_decode($this_client['client_state']))."&"
                         ."zip=".       urlencode(utf8_decode($this_client['client_zip']));


                         
          // Check to see if the invoice used a credit,  if so do not make the subscriptions link
          //$credit_used = $order_snapshot[order_totals][applied_credit];
          //$nocredit = ($credit_used != "0" || !$credit_used) ? 0 : 1 ;
          
          
         // check to see if client has a subscription,  if so   do not make links.
         // Needs refining   comment out for now
         //if (!$has_subscription )
         //{
                         
         // build html link from paypal URL for final order page / online invoices
         if ($pp_link_type == "button") {
         if ( ( !$subscriptionOK )  ||
              ( !$subscription_priority && $subscriptionOK ) )
         {
          $paypal_link  = "<br><a href=\"${payment_url}${paypal_url}${paypal_url1}\" target=\"_blank\">";
          $paypal_link .= (!empty($submit_image)) ? "<img src=$submit_image border=0>" : 'Pay Now' ;
          $paypal_link .= "</a>&nbsp&nbsp\n";
         }
         else
         {
          $paypal_link .= "<br>";
         }
	     // If statement here to check if we should display the additional URL
         if ($sub_enabled && $recurring_price > 0 && $subscriptionOK ) {
             $paypal_link .= "<a href=\"${sub_url}${paypal_url}${paypal_url2}\" target=\"_blank\">";
             $paypal_link .= (!empty($sub_pay_image)) ? "<img src=$sub_pay_image border=0>" : 'Pay and Subscribe Now' ;
             $paypal_link .= "</a>\n";
         }
         }//end if link type is button
         if ($pp_link_type == "link") {                
         // build html link from paypal URL 
         if ( $allow_html_emails ) {
         if ( ( !$subscriptionOK )  ||
              ( !$subscription_priority && $subscriptionOK ) )
         {
          $paypal_link  = "<br><a href=\"${payment_url}${paypal_url}${paypal_url1}\" target=\"_blank\">";
          $paypal_link .= (!empty($submit_image)) ? "<img src=$submit_image border=0>" : 'Pay Now' ;
          $paypal_link .= "</a>&nbsp&nbsp\n";
         }
         else
         {
          $paypal_link .= "<br>";
         }
	     // If statement here to check if we should display the additional URL
         if ($sub_enabled && $recurring_price > 0 && $subscriptionOK ) {
             $paypal_link .= "<a href=\"${sub_url}${paypal_url}${paypal_url2}\" target=\"_blank\">";
             $paypal_link .= (!empty($sub_pay_image)) ? "<img src=$sub_pay_image border=0>" : 'Pay and Subscribe Now' ;
             $paypal_link .= "</a>\n";
         }
         } else {
         	// build text link from paypal URL
         	if ( ( !$subscriptionOK )  ||
              ( !$subscription_priority && $subscriptionOK ) )
         {
          $paypal_link  = "${payment_url}${paypal_url}${paypal_url1}";
          $paypal_link .= "&nbsp&nbsp\n\n";
         }
         else
         {
          $paypal_link .= "\n";
         }
	     // If statement here to check if we should display the additional URL
         if ($sub_enabled && $recurring_price > 0 && $subscriptionOK ) {
             $paypal_link .= "${sub_url}${paypal_url}${paypal_url2}";
             $paypal_link .= "\n\n";
         }
         }
         }//end if link type = link
         // return the paypal payment url

         return ($amount>0) ? $paypal_link : NULL ;
         

}

function postPayment($this_client_id,$item_number,$invoice_amount_paid,$txn_id,$txn_type,$outputData)
{
     GLOBAL $paypal_id, $paypal_debug,$date_format,
           $auth_return, $dbh, $_POST, $manual_email_id,
           $send_client_email, $override_email,
           $inv_email_cc, $inv_email_priority, $inv_email_subject, $inv_email_from,
           $email_id, $email_type, $where, $email_to, $email_cc,
           $email_priority, $email_subject, $email_from, $email_body;
           ////////////////////////////////////////////////
           //******  FIX the above to not use Globals..
           ////////////////////////////////////////////////
// Connect to the DB
if (!$dbh) dbconnect();

   ( $debug == 1 || $paypal_debug == 1 ) ? $pp_debug = 1 : $pp_debug = 0;

    $trans_id = $txn_id;
    $amount_leftover = $total_auto_paid = $invoice_amount_paid;
    $invoice_id = $item_number;

    // Payment will be made on the invoice specified.  If no invoice match is found
    // We

   // select all outstanding invoices
   if ( $pp_debug )
   {
    	fputs ($outputData, "**ITEM_NUM: $item_number\n");
	fputs ($outputData, "**client_id: $this_client_id\n");
	fputs ($outputData, "**trans_id: $trans_id\n");
	fputs ($outputData, "**invoice_amount_paid: $invoice_amount_paid\n");
	fputs ($outputData, "**txn_id: $txn_id\n");
	fputs ($outputData, "**txn_type: $txn_type\n");
	fputs ($outputData, "**invoice_id: $invoice_id\n");
	
   }

// Test if Payment TXN_ID has alread been posted. If so, log duplicate and return..

   list ($transaction_exists) = mysql_fetch_row(
      mysql_query_logger("SELECT count(trans_id) FROM client_invoice WHERE trans_id = '$txn_id'"));
   if ( $transaction_exists >= 1 )
   {
    $log_comments = "PayPal Duplicate IPN: $txn_id [Status: Ignore]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
    log_event($this_client_id,$log_comments,3);
    if ( $pp_debug ) fputs ($outputData, "**: $this_client_id: $log_comments\n");
    return;
   }

///////////////////////////////////////////////////////////
//// set invoice status of current requested invoice to 99..
////  99 = Payment queued
/////////////////////////////

update_invoice_status($invoice_id, "-1", "Queued");

///////////////////////////////////////////////////////////
//// Start to process invoice
/////////////////////////////


   $result = mysql_query_logger("SELECT * FROM client_invoice
             WHERE client_id = '$this_client_id' AND ((invoice_amount - invoice_amount_paid) > 0 )
             ORDER BY invoice_status ASC, invoice_date_due");

   $amount_leftover = $total_auto_paid = $invoice_amount_paid;

   while( ($this_due_invoice=mysql_fetch_array($result)) && ($amount_leftover != 0) ) {

         $invoice_id = $this_due_invoice[invoice_id];
         $amount_left_to_pay = $this_due_invoice['invoice_amount'] - $this_due_invoice['invoice_amount_paid'];
         $apply_this_amount = ( $amount_leftover <= $amount_left_to_pay ) ? $amount_leftover : $amount_left_to_pay;

         if ( $pp_debug )
         {
              fputs ($outputData, "**Processing invoice: $invoice_id\n");
              fputs ($outputData, "**paypalId: $paypal_id\n");
              fputs ($outputData, "**This Client Id: $this_client_id\n");
              fputs ($outputData, "**Transaction Id: $trans_id\n");
              fputs ($outputData, "**This Admin: $this_admin\n");
              fputs ($outputData, "**Date Format: $date_format\n");
              fputs ($outputData, "**Auth Return: $auth_return\n");
              fputs ($outputData, "**CUSTOM: $_POST[custom]\n");
              fputs ($outputData, "*******************************\n");
              fputs ($outputData, "****** amount_paid: $this_due_invoice[invoice_amount_paid]\n");
              fputs ($outputData, "****** amount_invoice_amount: $this_due_invoice[invoice_amount]\n");
              fputs ($outputData, "****** amount_leftover: $amount_leftover\n");
              fputs ($outputData, "****** amount_left_to_pay: $amount_left_to_pay\n");
              fputs ($outputData, "****** apply This Amount: $apply_this_amount\n");
         }
         // is there any money left?  use this for the next iteration or credit.
         $amount_leftover = $amount_leftover - $apply_this_amount;

         // update the invoice with autopayment made

         mysql_query_logger("UPDATE client_invoice
                         SET invoice_amount_paid=invoice_amount_paid+$apply_this_amount,
                           invoice_date_paid='".mktime()."',
                           invoice_payment_method='$paypal_id',
                           auth_return='1',
                           auth_code='',
                           avs_code='',
                           trans_id='$trans_id',
                           batch_stamp='".mktime()."',
                           invoice_stamp='".mktime()."',
                           invoice_status='1'
                           WHERE invoice_id='$invoice_id'");


           ## client_register entry
        $reg_desc = ( $txn_type == "web_accept" ) ? PAYPALPAYMENT.": $trans_id" : PAYPALSUBSCRIPTIONPAYMENT.": $trans_id";;
        //$reg_desc = PAYPALPAYMENT.": $trans_id";
        $reg_payment = $apply_this_amount;
        $this_invoice = adodb_one_array("SELECT * FROM client_invoice WHERE invoice_id = $invoice_id", 'A');
        register_insert($this_invoice[client_id],$reg_desc,$invoice_id,NULL,$reg_payment);
        if ( $pp_debug )fputs ($outputData, "** Insert into register: $this_invoice[client_id],$reg_desc,$invoice_id,NULL,$reg_payment\n");

        //if ( $override_email  && $manual_email_id ) {

            // start email caching
            $client_invoice = adodb_one_array("SELECT * FROM client_invoice WHERE invoice_id='$invoice_id'",'A');
            $client_info = adodb_one_array("SELECT * FROM client_info WHERE client_id='".$client_invoice['client_id']."'",'A');
            $email_vars = array
            (
                 'email_type'     => 'payment', // email type
                 'email_id'       => get_payment_email_id($client_info,'manual'), // this email id
                 'client_info'    => $client_info, // array of client_info record
                 'client_invoice' => $client_invoice // array of client_invoice record
            );
            $ec_id = parse_email($email_vars);
            if ($send_client_email) {
                send_email_cache($ec_id,1);
            }

        //}

         // log transaction
         @batch_log($invoice_id,$this_client_id,1,$reg_desc);

         // log event
         $log_comments = "Process Invoice $invoice_id [Return: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
         log_event($this_client_id,$log_comments,3);


   }

   // add credits if money leftover
   if ($amount_leftover > 0) {
         if ( $txn_type == "subscr_payment" && $invoice_amount_paid == $amount_leftover)
         {
          $creditComments = SUBSCRIPTION;
         }
         else
         {
          $creditComments = OVERPAYMENT." of $$amount_leftover on Invoice $invoice_id" ;
          $creditComments1 = OVERPAYMENT."\nInvoice #:$invoice_id";
         }

   //  Determine if this is an overpayment or an recurring payment..
   //  If recurring payment set credit_comments = subscription
   //  If amount overdue != paid_amount, then credit_comments = OVERPAYMENT


   // insert debit for client credit in register
       register_insert($this_client_id,$creditComments,$invoice_id,NULL,NULL,$invoice_date_paid);
       @mysql_query_logger("INSERT INTO client_credit (credit_id,
                                                client_id,
                                            credit_amount,
                                          credit_comments,
                                             credit_stamp) VALUES (NULL,
                                                                  '$this_client_id',
                                                                  '$amount_leftover',
                                                                  '$creditComments1',
                                                                  '".mktime()."')");
   }
   return;
}



function update_invoice_status($invoice_id, $status, $description)
{
	// Connect to the DB
GLOBAL $dbh,$outputData, $paypal_debug, $pp_debug;
if (!$dbh) dbconnect();

          
          if ( $pp_debug ) fputs ($outputData, "UPDATE_INVOICE: invoice: $invoice_id  status: $status  Desc: $description \n");
          mysql_query_logger("UPDATE client_invoice
                          SET invoice_status = '$status',
                              invoice_status_desc = '$description'
                        WHERE invoice_id='$invoice_id'");
          if ( $pp_debug ) fputs ($outputData, "UPDATE_INVOICE: Query Result: $result\n");
          return $result;
}

function update_invoice_reversal($invoice_id)
{
	// Connect to the DB
GLOBAL $dbh,$outputData, $paypal_debug, $pp_debug;
if (!$dbh) dbconnect();

          
          if ( $pp_debug ) fputs ($outputData, "UPDATE_INVOICE: invoice: $invoice_id  REVERSAL / Refunded \n");
          mysql_query_logger("UPDATE client_invoice
                          SET invoice_amount_paid = '',
                              invoice_date_paid = ''
                        WHERE invoice_id='$invoice_id'");
          if ( $pp_debug ) fputs ($outputData, "UPDATE_INVOICE: Query Result: $result\n");
          return $result;
}


function pp_getClientID($item_number)
{
	GLOBAL $dbh;
if (!$dbh) dbconnect();

	      if (isset($item_number)) {
          	$this_client_id = adodb_one_data("SELECT `client_id` FROM `client_invoice` WHERE `invoice_id` = '$item_number'");
          	return $this_client_id;
         } else {
            // No invoice number specified. Do nothing, and Exit here..
            return 0;
		 }

}

function pp_getSClientID($subscr_id)
{
	GLOBAL $dbh;
if (!$dbh) dbconnect();


	if (isset($subscr_id)) {
          	$this_client_id = adodb_one_data("SELECT `client_id` FROM `client_subscriptions` WHERE `subscription` = '$subscr_id' AND cs_status= '1'");
            return $this_client_id;
         } else {
            // No invoice number specified. Do nothing, and Exit here..
            return 0;
		 }

}



?>