<?php
// $Id: paypal_return.inc.php 2 2006-02-09 06:37:38Z mfountain $
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
/////////////////////////////////////////////////
// The following allows script to be used with the an internal paypal test script.
// Do not change this, unless you have the test script.
//$test_return_func=1;
/////////////////////////////////////////////////


$basePath   =   dirname(__FILE__);
include('../includes/hostbill.php');

$db         	= hbm_db();
$path_to_curl 	= 'PHP';
$test_debug 	= true;

if ($test_debug == true) {
    $outputData = fopen ( dirname(__FILE__)."/MYPayPalReturn_netway.txt", "a+");
} else {
    $outputData = fopen ( "/home/rvglobal/public_html/mod_paypal/MYPayPalReturn.txt", "a+");
}
fputs ( $outputData, "***********START_RETURN***************\n");


$error 			= 0;
$post_string 	= '';
$output 		= '';
$valid_post 	= '';

$workString 	= 'cmd=_notify-validate';
/* Get PayPal Payment Notification variables including the encrypted code */
/*********************************************
failed
denied
pending
Refunded
Reversed
Completed
************************************************/
/*
if ($test_debug == true || isset($_GET['rvdebug'])) { 
	$_POST['item_name'] 		= 'TEST';
	$_POST['item_number'] 		= '124536';
	$_POST[cp_id] 				= 7788;
	$_POST[client_id] 			= 88456;
	$_POST['mc_gross'] 			= 12;
	$_POST['payment_status'] 	= 'Completed';
	$_POST['txn_type'] 			= 'subscr_payment';
	$_POST 	   = $_POST;

}
*/

reset($_POST);
while(list($key, $val) = each($_POST)) {
	$post_string 	.= $key . '=' . $val . '&';
	$val 			= stripslashes($val);
	$val 			= urlencode($val);
	$workString 	.= '&' . $key . '=' . $val;
}

fputs ( $outputData, "POST STRING:$post_string\n");



/* assign posted variables to local variables */

$merchant           = isset($_GET['merchant']) ? $_GET['merchant'] : '';

$item_name 			= trim(stripslashes($_POST['item_name']));
$item_number 		= trim(stripslashes($_POST['item_number']));
$payment_status 	= trim(stripslashes($_POST['payment_status']));
$payment_gross 		= trim(stripslashes($_POST['payment_gross']));
$txn_id 			= trim(stripslashes($_POST['txn_id']));
$receiver_email 	= trim(stripslashes($_POST['receiver_email']));
$payer_email 		= trim(stripslashes($_POST['payer_email']));
$payment_date 		= trim(stripslashes($_POST['payment_date']));
$invoice 			= trim(stripslashes($_POST['invoice']));
$quantity 			= trim(stripslashes($_POST['quantity']));
$pending_reason 	= trim(stripslashes($_POST['pending_reason']));
$payment_method 	= trim(stripslashes($_POST['payment_method']));
$first_name 		= trim(stripslashes($_POST['first_name']));
$last_name 			= trim(stripslashes($_POST['last_name']));
$address_street 	= trim(stripslashes($_POST['address_street']));
$address_city 		= trim(stripslashes($_POST['address_city']));
$address_state 		= trim(stripslashes($_POST['address_state']));
$address_zipcode 	= trim(stripslashes($_POST['address_zip']));
$address_country 	= trim(stripslashes($_POST['address_country']));
$payer_email 		= trim(stripslashes($_POST['payer_email']));
$address_status 	= trim(stripslashes($_POST['address_status']));
$payer_status 		= trim(stripslashes($_POST['payer_status']));
$notify_version 	= trim(stripslashes($_POST['notify_version']));
$verify_sign 		= trim(stripslashes($_POST['verify_sign']));
$business 			= trim(stripslashes($_POST['business']));
$custom 			= trim(stripslashes($_POST['custom']));
$txn_type 			= trim(stripslashes($_POST['txn_type']));

$settle_amount 		= trim(stripslashes($_POST['settle_amount']));
$settle_currency 	= trim(stripslashes($_POST['settle_currency']));
$exchange_rate 		= trim(stripslashes($_POST['exchange_rate']));
$payment_fee 		= trim(stripslashes($_POST['payment_fee']));
$mc_gross 			= trim(stripslashes($_POST['mc_gross']));
$mc_fee 			= trim(stripslashes($_POST['mc_fee']));
$mc_currency 		= trim(stripslashes($_POST['mc_currency']));
$tax 				= trim(stripslashes($_POST['tax']));
$for_auction 		= trim(stripslashes($_POST['for_auction']));
$memo 				= trim(stripslashes($_POST['memo']));
$option_name1 		= trim(stripslashes($_POST['option_name1']));
$option_selection1 	= trim(stripslashes($_POST['option_selection1']));
$option_name2 		= trim(stripslashes($_POST['option_name2']));
$option_selection2 	= trim(stripslashes($_POST['option_selection2']));
$num_cart_items 	= trim(stripslashes($_POST['num_cart_items']));


// subscription variables
$username 		= trim(stripslashes($_POST['username']));
$password 		= trim(stripslashes($_POST['password']));
$subscr_id 		= trim(stripslashes($_POST['subscr_id']));
$subscr_date 	= trim(stripslashes($_POST['subscr_date']));
$subscr_effective = trim(stripslashes($_POST['subscr_effective']));
$period1 		= trim(stripslashes($_POST['period1']));
$period2 		= trim(stripslashes($_POST['period2']));
$period3 		= trim(stripslashes($_POST['period3']));
$amount1 		= trim(stripslashes($_POST['amount1']));
$amount2 		= trim(stripslashes($_POST['amount2']));
$amount3 		= trim(stripslashes($_POST['amount3']));
$mc_amount1 	= trim(stripslashes($_POST['mc_amount1']));
$mc_amount2 	= trim(stripslashes($_POST['mc_amount2']));
$mc_amount3 	= trim(stripslashes($_POST['mc_amount3']));
$recurring 		= trim(stripslashes($_POST['recurring']));
$recur_times 	= trim(stripslashes($_POST['recur_times']));
$subscr_eot 	= trim(stripslashes($_POST['subscr_eot']));
$subscr_cancel 	= trim(stripslashes($_POST['subscr_cancel']));

$invoice_amount_paid 	= $mc_gross;
$invoice_id     		= $item_number;

// post back to PayPal using cURL with https url
$url = ($test_debug) 
		? "https://ipnpb.sandbox.paypal.com/cgi-bin/webscr" 
		: "https://ipnpb.paypal.com/cgi-bin/webscr";
if ($path_to_curl=='PHP') {
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_VERBOSE, 0);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $workString);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	$output = curl_exec($ch);
	curl_close($ch);
}

if ($output == '') {
   echo "cURL did not receive a response back from PayPal.\n";
   exit;
}

fputs ( $outputData, "ipnpb:$output\n");

// remove post headers if present.
$output = preg_replace("'Content-type: text/plain'si", "", $output);

fputs ( $outputData, "RETURN STRING:$output\n");

$subject 	= 'DEBUG HOSTBILL billing.rvglobalsoft.com : Paypal';
$headers 	= 'From: admin@rvglobalsoft.com' . "\r\n" .
'Reply-To: rvglobalsoft.com' . "\r\n" .
'X-Mailer: PHP/' . phpversion();

$message 	= "Paypal output::".$output. "\n";
$message 	.= "workString: " . $workString . "\n";

//@mail('paisarn@netway.co.th', $subject, $message, $headers);		

// logic for handling the INVALID or VERIFIED responses.
/* valid response from PayPal*/
if ($test_debug == true ||  (isset($_GET['rvdebug'])) )  {
	$output = 'VERIFIED';
}

if (preg_match('/VERIFIED/i',$output)) {
 		
    if (isset($_GET['rvdebug'])) {
    	$my_cp_id 		= $_POST[cp_id];
		$my_client_id 	= $_POST[client_id];
		$my_inv_id 		= $item_number;
    } else {
	 	$result = $db->query("
		 	SELECT 
		 		* 
		 	FROM 
		 		mb_invoice_log 
		 	WHERE 
		 		invoice_id =:item_number 
		 	"
	 		,array(':item_number'=>$item_number))->fetch();
		 if ($result) {
		 	$my_cp_id 		= $result[cp_id];
		 	$my_client_id 	= $result[client_id];
		 	$my_inv_id 		= $result[invoice_id];
		 } else {
		 	$result2 		= $db->query("SELECT * FROM mb_client_invoice WHERE invoice_id =:item_number ",array(':item_number'=>$item_number))->fetch();
			$my_client_id 	= $result2[client_id];
		 	$my_inv_id 		= $result2[invoice_id];
		}
	}

    // Add paypal settlement. Insert 2 round. First insert subscr_signup, Second insert subscr_payment 
    // darawan ใช้งานจริงจำเป็นต้องใช้นะ
    if(!isset($_GET['rvdebug'])){
     $in_mb_paypal = $db->query("
     		INSERT INTO mb_paypal_settlement 
     			(cp_id,client_id,txn_type, paypal_data) 
     		VALUES 
     			(:cp_id,:client_id,:txn_type,:paypal_data)"
     		,array(
     		':cp_id' 		=> $my_cp_id,
     		':client_id' 	=> $my_client_id,
     		':txn_type' 	=> $txn_type,
     		':paypal_data' 	=> $post_string,
    		));
    }

    // Insert all data to license table 

    if ($txn_type == 'subscr_payment' || $txn_type == 'web_accept') {
		/// RV Global Soft - Stop 
	    if (preg_match('/Completed/',$payment_status)) {
	        mail_to_admin($my_cp_id, $invoice_amount_paid, $my_client_id, $my_inv_id, $payer_email, $txn_id, $merchant);
        } else {
            paypal_ipn_failed($payment_status,$item_number,$txn_id,$date_format,$subscr_id,$pending_reason,$outputData,$pp_debug,$mc_gross);
        }
	}
}   // end VERIFIED response from paypal


exit;

/* ======================================================================== */
function mail_to_admin ($cpid, $paid, $client_id, $invid, $payer_email, $txn_id, $merchant = '')
{
	$db = hbm_db();
	
	/*
	$cpid = 10111;	
	$txn_id = 'ABACDEFGHIGADDDDSFSDF';
	$payer_email = 'tst@hotmail.com';
	$client_id = 142522;
	$paid=125;
	$invid = 125;
    */
    
	$subject 	= 'NEW 21 04 57 billing.rvglobalsoft.com : Paypal';
    $headers 	= 'From: admin@rvglobalsoft.com' . "\r\n" .
    'Reply-To: rvglobalsoft.com' . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

    $message 	= "LICENSE Paypal :: Summary Order New\n";
    $message 	.= "--------------------------------------------\n";
    $message 	.= "client_id: " . $client_id . "\n";
    $message 	.= "invoice id: " . $invid . "\n";
    $message 	.= "cp_id: " . $cpid . "\n";
	$message 	.= "txn_id: " . $txn_id . "\n";
	
	$message 	.= "email: " . $payer_email . "\n";
    $message 	.= "Money: " . $paid . " US" . "\n\n";
	
	//@mail('paisarn@netway.co.th', $subject, $message, $headers);		

	$res 			= array();
	$res['result'] 	= false;
	$res['txt'] 	= '';
	$mail_hostbill 	= '-';
	
    $resgethbacc = $db->query("
        SELECT l.hb_acc, l.primary_ip FROM mb_client_package_variables c, rvsitebuilder_license l
        WHERE c.cpv_id = l.cpv_id
        AND c.cp_id = :cpid
        ",array(':cpid'=>$cpid))->fetch();
    if (isset($resgethbacc['hb_acc']) && $resgethbacc['hb_acc'] != '' && $resgethbacc['hb_acc'] != 0) {
        $hb_acc_id = $resgethbacc['hb_acc'];
    } else {
        $res['txt']     = 'หา account id ไม่เจอ';
    }
    
	$sqlgetmail = $db->query("
		SELECT c.email FROM hb_client_access c,hb_accounts a WHERE c.id=a.client_id and a.id =:accid
		"
		,array(':accid'=>$hb_acc_id))->fetch();	
	if (isset($sqlgetmail['email']) && $sqlgetmail['email'] != '') {
		$mail_hostbill = $sqlgetmail['email'];
	}
				
	// 1. connect กับ database ของ hostbill สำเร้จ 
	$ipallow   = $_SERVER['SERVER_ADDR'];
	//  1.2 หาใบ invoice ที่ยังไม่ได้จ่าย

	$getinv = $db->query("SELECT i.id
		 FROM `hb_invoices` i, hb_invoice_items ii
		 WHERE i.id = ii.invoice_id AND ii.item_id =:accid AND i.status =  'Unpaid'",array(':accid'=>$hb_acc_id))->fetch();
		
	$date = date('Y-m-d H:i:s');

	$getapi = $db->query("SELECT aa.* FROM hb_api_access aa WHERE aa.ip =:iparrow",array(':iparrow'=>$ipallow))->fetch();

	if (isset($getapi['api_id']) && isset($getapi['api_key']) && isset($getinv['id'])) {
		// 1.3 หา invoice ได้ก็ให้ add payment ไปเลย

		$url = 'https://rvglobalsoft.com/7944web/api.php';
		$apiid    	= $getapi['api_id'];
        $apikey   	= $getapi['api_key'];
		$inv_id 	= $getinv['id'];
             
		$post = array(
	      'api_id' 		=> $apiid,
	      'api_key' 	=> $apikey,
	      'call' 		=> 'addInvoicePayment',
	      'transnumber' => $txn_id,
	      'id'			=> $inv_id,
	      'paymentmodule'=>11,
	      'fee'			=> '0',
	      'date'		=> $date,
	      'amount' 		=>$paid
   		);

		$ch = curl_init();
   		curl_setopt($ch, CURLOPT_URL, $url);
   		curl_setopt($ch, CURLOPT_POST, 1);
   		curl_setopt($ch, CURLOPT_TIMEOUT, 30);
   		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
   		curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
   		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
   		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
   		$data = curl_exec($ch);
   		curl_close($ch);
   		$return = json_decode($data, true);
		if (isset($return['success']) &&  $return['success'] == 1) {
            $res['result']  = true;
			$res['txt'] 	=  "\n" . '[complete] add payment ไปแล้ว ตรวจสอบได้ที่ invoice = ' . $inv_id . ' ,time=' . $date . "\n";
            
            if ($merchant == 'netway') {
                $db->query("
                    UPDATE hb_invoices
                    SET is_netway = 1
                    WHERE id = :id
                    ", array(
                        ':id'   => $inv_id
                    ));
            }
            
		} else {
			$entry 			= '[error modern bill] api add payment inv = ' . $inv_id;
			
			$reserrorlog 	= $db->query("INSERT INTO hb_error_log (`id`,`date`,`entry`,`type`)
				VALUE (NULL,:date,:entry,'Other')",array(':date'=>$date,':entry'=>$entry));
			$res['txt'] 	=   "\n".'[Error] add payment ไม่สำเร็จ ตรวจสอบได้ที่ invoice = '.$inv_id."\n";
		}
	} else {
		if (isset($getinv['id'])) {
			$inv_id = $getinv['id'];
			$entry = '[error modern bill] api add payment inv = '.$inv_id;
		} elseif(isset($getapi['api_id']) && isset($getapi['api_key']))  {
			$entry = '[error modern bill] api not connect';
		} else {
			$entry = '[error modern bill] หา invoice ไม่เจอ';
		}

		$reserrorlog = $db->query("INSERT INTO hb_error_log (`id`,`date`,`entry`,`type`)
				VALUE (NULL,:date,:entry,'Other')", array(':date' => $date, ':entry' => $entry));
		$res['txt'] .=  $entry;
	}

	if ($res['result'] == false) {
		
    	// 1.4 มี eror ให้ add recode เข้าที่ gateway log รอพี่กวงมาตรวจอีกที
    	$inv_hb = (isset($inv_id) && $inv_id != '') ? $inv_id : '-';
    	$output =<<<EOF
[transaction_id] => $txn_id
[email] => $payer_email
[cp_id] => $cpid
[paid] => $paid
[method] => subscr_sb_payment
[client_id] => $client_id
[invoice] => $invid
[invoice_hostbill] => $inv_hb 
[email_hostbill] => $mail_hostbill
EOF;

		$resgateway = $db->query("INSERT INTO  hb_gateway_log (id,module,date,output,result)
    		VALUE (NULL,'11',:date,:output,'Successfull')", array(':date' => $date, ':output' => $output));
		$res['txt'] .=  'บันทึกลง gateway log เรียบร้อยแล้ว' . "\n";
    }
    
    $message .= "Note: " . $res['txt'] . "\n";
	
	@mail('paisarn@netway.co.th', $subject, $message, $headers);
}

function  paypal_ipn_verified($txn_id,$txn_type,$pp_debug,$subscr_id,$item_number,$payment_status,$invoice_amount_paid,$outputData){


  switch ($txn_type)
       {
                  case 'reversal':
                        if ( $pp_debug ) { fputs ($outputData, "********* Reversal\n"); }

                  break;
                  // The payment was sent by your customer via Buy Now Buttons, Donations, or Auction Smart Logos
                  case 'web_accept':
                        // Receive Payment.. Post, to invoice. Should be for amount listed on invoice.
                        // Update invoice table.
                        if ( !$this_client_id = pp_getClientID($item_number) )
                        {
                             if ( $pp_debug ) fputs ($outputData, "WEB_ACCEPT: No Item Number\n");
                             fclose ( $outputData );
                             exit(1);
                        }

                  		if ( $pp_debug )
                        {
                         fputs ($outputData, "********* WEB-ACCEPT \n");
                         fputs ($outputData, "*********  Calling Post Payment Function :: $payment_status \n");
                        }
                        if ( $payment_status == "Completed")
                        {
                        	postPayment($this_client_id,$item_number,$invoice_amount_paid,$txn_id,$txn_type,$outputData);
                        	update_invoice_status($item_number, "1", "Completed");
                            $log_comments = "PayPal Completed: $item_number: $txn_id [Status: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                            log_event($this_client_id,$log_comments,3);
                        }

                  break;

                  // This payment was sent by your customer via the PayPal Shopping Cart feature
                  case 'cart':
                        // Update invoice Table. We do not have an invoice number for this post.
                        // Post to oldest due, similiar to recurring.
                        //  DO NOTHING.. EXIT
                  if ( $pp_debug ) { fputs ($outputData, "********* CART\n");
                  fclose ( $outputData );
                  }


                  break;

                  // This payment was sent by your customer from the PayPal website, using the "Send Money" tab
                  case 'send_money':
                        // Update invoice Table. We do not have an invoice number for this post.
                        // Post to oldest due, similiar to recurring.
                  if ( $pp_debug ) { fputs ($outputData, "********* SEND_MONEY\n");
                  fclose ( $outputData );
                  }

                  break;

                  // This IPN is for a subscription sign-up
                  case 'subscr_signup':
                        if ( !$this_client_id = pp_getSClientID($subscr_id) )
                        {
                           $this_client_id = pp_getClientID($item_number) ;


                  // Add client Signup Info to subscription table
                  // Post initial/trial payment info
                  // CS: Client Subscription
                  // CP: Client Package
                        if ( $pp_debug )
                        {
                         fputs ($outputData, "*******\n");
                         fputs ($outputData, "**Adding Client Subscription\n");
                         fputs ($outputData, "**Adding Client ID: $this_client_id\n");
                         fputs ($outputData, "**Adding Subscription: $subscr_id \n");
                         fputs ($outputData, "**Adding Invoice ID: $item_number\n");
                         fputs ($outputData, "**Adding CP ID: \n");
                         fputs ($outputData, "**Adding CS Status: 1\n");
                         fputs ($outputData, "**Adding CD STAMP: ".mktime()."\n");
                         fputs ($outputData, "**Adding GW Module: mod_paypal\n");
                        }


                  		mysql_query_logger("INSERT INTO client_subscriptions
                                     SET  client_id ='$this_client_id',
                                          subscription='$subscr_id',
                                          invoice_id='$item_number',
                                          cs_status='1',
                                          cs_create_stamp='".mktime()."',
                                          cs_modify_stamp='".mktime()."',
                                          gateway_module='mod_paypal'
                                     ");
                  		if ( $pp_debug ) { fputs ($outputData, "********* SUBSCR_SIGNUP\n"); }
						postPayment($this_client_id,$item_number,$invoice_amount_paid,$txn_id,$txn_type,$outputData);
						update_invoice_status($item_number, "1", "Completed");
                            $log_comments = "PayPal Subscription Completed: $item_number: $txn_id [Status: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                            log_event($this_client_id,$log_comments,3);
                        		} else {
						if ( $pp_debug ) fputs ($outputData, "SUBSCR_Payment: PAYMENT MADE\n");
                             postPayment($this_client_id,$item_number,$invoice_amount_paid,$txn_id,$txn_type,$outputData);
                             // get correct invoice id for update_invoice_status function when it is a subscription payment
                             $result = mysql_query_logger("SELECT * FROM client_invoice
             					WHERE client_id = '$this_client_id' AND ((invoice_amount - invoice_amount_paid) > 0 )
             					ORDER BY invoice_status ASC, invoice_date_due");
                             $this_due_invoice=mysql_fetch_array($result);
                             $invoice_id = $this_due_invoice[invoice_id];
                             update_invoice_status($invoice_id, "1", "Completed");
                            $log_comments = "PayPal Subscription Completed: $invoice_id: $txn_id [Status: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                            log_event($this_client_id,$log_comments,3);
                             }


                  break;

                  // This IPN is for a subscription cancellation
                  // remove client Info to subscription table
                  case 'subscr_cancel':

                        if ( !$this_client_id = pp_getSClientID($subscr_id) )
                        {
                             if ( $pp_debug ) fputs ($outputData, "SUBSCR_CANCEL: No Item Number\n");
                             fclose ( $outputData );
                             exit(1);
                        }                          //
                          mysql_query_logger("UPDATE client_subscriptions
                                     SET  cs_status='3',
                                          cs_modify_stamp='".mktime()."'
                                     WHERE client_id = '$this_client_id'
                                     ");

                  if ( $pp_debug ) { fputs ($outputData, "********* SUBSCR_CANCEL\n"); }

                  break;

                  // This IPN is for a subscription modification
                  // update client info in subscription table
                  case 'subscr_modify':
                        if ( !$this_client_id = pp_getSClientID($subscr_id) )
                        {
                             if ( $pp_debug ) fputs ($outputData, "SUBSCR_MODIFY: No Item Number\n");
                             fclose ( $outputData );
                             exit(1);
                        }                          //

                          mysql_query_logger("UPDATE client_subscriptions
                                     SET  client_id ='$this_client_id',
                                          subscription='$subscr_id',
                                          invoice_id='$item_number',
                                          cs_status='1',
                                          cs_modify_stamp='".mktime()."',
                                          gateway_module='mod_paypal'
                                     WHERE client_id = '$this_client_id'
                                     ");


                  if ( $pp_debug ) { fputs ($outputData, "********* SUBSCR_MODIFY\n"); }

                  break;

                  // This IPN is for a subscription payment failure
                  // Subscription Failure
                  case 'subscr_failed':
                        if ( !$this_client_id = pp_getSClientID($subscr_id) )
                        {
                             if ( $pp_debug ) fputs ($outputData, "SUBSCR_FAILED: No Item Number\n");
                             fclose ( $outputData );
                             exit(1);
                        }                          //

                          mysql_query_logger("UPDATE client_subscriptions
                                     SET  client_id ='$this_client_id',
                                          subscription='$subscr_id',
                                          invoice_id='$item_number',
                                          cs_status='4',
                                          cs_modify_stamp='".mktime()."',
                                          gateway_module='mod_paypal'
                                     WHERE client_id = '$this_client_id'
                                     ");

                  if ( $pp_debug ) { fputs ($outputData, "********* SUBSCR_FAILED\n"); }

                  break;

                  // This IPN is for a subscription payment
                  // Post payment info
                  // update client info in suscription table

                  case 'subscr_payment':
                        if ( !$this_client_id = pp_getSClientID($subscr_id) )
                        		{
                             $this_client_id = pp_getClientID($item_number) ;


                  // Add client Signup Info to subscription table
                  // Post initial/trial payment info
                  // CS: Client Subscription
                  // CP: Client Package
                        if ( $pp_debug )
                        {
                         fputs ($outputData, "*******\n");
                         fputs ($outputData, "**Adding Client Subscription\n");
                         fputs ($outputData, "**Adding Client ID: $this_client_id\n");
                         fputs ($outputData, "**Adding Subscription: $subscr_id \n");
                         fputs ($outputData, "**Adding Invoice ID: $item_number\n");
                         fputs ($outputData, "**Adding CP ID: \n");
                         fputs ($outputData, "**Adding CS Status: 1\n");
                         fputs ($outputData, "**Adding CD STAMP: ".mktime()."\n");
                         fputs ($outputData, "**Adding GW Module: mod_paypal\n");
                        }


                  		mysql_query_logger("INSERT INTO client_subscriptions
                                     SET  client_id ='$this_client_id',
                                          subscription='$subscr_id',
                                          invoice_id='$item_number',
                                          cs_status='1',
                                          cs_create_stamp='".mktime()."',
                                          cs_modify_stamp='".mktime()."',
                                          gateway_module='mod_paypal'
                                     ");
                  		if ( $pp_debug ) { fputs ($outputData, "********* SUBSCR_SIGNUP\n"); }
						postPayment($this_client_id,$item_number,$invoice_amount_paid,$txn_id,$txn_type,$outputData);
						update_invoice_status($item_number, "1", "Completed");
                            $log_comments = "PayPal Subscription Completed: $item_number: $txn_id [Status: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                            log_event($this_client_id,$log_comments,3);
                        		} else {
						if ( $pp_debug ) fputs ($outputData, "SUBSCR_Payment: PAYMENT MADE\n");
                             postPayment($this_client_id,$item_number,$invoice_amount_paid,$txn_id,$txn_type,$outputData);
                             // get correct invoice id for update_invoice_status function when it is a subscription payment
                             $result = mysql_query_logger("SELECT * FROM client_invoice
             					WHERE client_id = '$this_client_id' AND ((invoice_amount - invoice_amount_paid) > 0 )
             					ORDER BY invoice_status ASC, invoice_date_due");
                             $this_due_invoice=mysql_fetch_array($result);
                             $invoice_id = $this_due_invoice[invoice_id];
                             update_invoice_status($invoice_id, "1", "Completed");
                            $log_comments = "PayPal Subscription Completed: $item_number: $txn_id [Status: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                            log_event($this_client_id,$log_comments,3);
                             }


                  break;

                  // This IPN is for a subscription's end of term
                  // update/cancel client info in subscription table.. End of term request.
                  case 'subscr_eot':
                        if ( !$this_client_id = pp_getSClientID($subscr_id) )
                        {
                             if ( $pp_debug ) fputs ($outputData, "SUBSCR_EOT: No Item Number\n");
                             fclose ( $outputData );
                             exit(1);
                        }                          //

                          mysql_query_logger("UPDATE client_subscriptions
                                     SET  client_id ='$this_client_id',
                                          subscription='$subscr_id',
                                          invoice_id='$item_number',
                                          cs_status='1',
                                          cs_modify_stamp='".mktime()."',
                                          gateway_module='mod_paypal'
                                     WHERE client_id = '$this_client_id'
                                     ");

                  if ( $pp_debug ) { fputs ($outputData, "********* SUBSCR_EOT\n"); }

                  break;

          }


}
function pp_getClientID($item_number)
{
        $db         	= hbm_db();
	      if (isset($item_number)) {
          	//$this_client_id = adodb_one_data("SELECT `client_id` FROM `client_invoice` WHERE `invoice_id` = '$item_number'");
          	$this_client_id = $db->query("SELECT `client_id` FROM `mb_client_invoice` WHERE `invoice_id` = :itemnumber",array(':itemnumber'=>$item_number))->fetch();
          	return isset($this_client_id['client_id']) ? $this_client_id['client_id'] : 0;
         } else {
            // No invoice number specified. Do nothing, and Exit here..
            return 0;
		 }

}
function log_event ($this_client_id,$log_comments,$status){
	$db         	= hbm_db();
	$insertlog = $db->query("INSERT INTO mb_log_event (`id`, `mb_client_id`, `log_comment`, `status`) 
	 VALUES (NULL, :clientid, :comment,:status)"
	                     ,array(':clientid'=>$this_client_id,':comment'=>$log_comments,':status'=>$status));
	            
	
}
function paypal_ipn_failed($payment_status,$item_number,$txn_id,$date_format,$subscr_id,$pending_reason,$outputData,$pp_debug,$mc_gross) {
          //////////////////////////////////////////////////////////////
          //  Support for Failed, Denied, Refunded,
          //          and Canceled are not completed\
          //  client_invoice -> invoice_status -> type int  --
          //              1-active Reversed
          //              2-void
          //              3-pending
          //              4-refund
// test : default = false
if ( $pp_debug )
{
		$outputData = fopen ( dirname(__FILE__)."/MYPayPalReturn.txt", "a+");
// $outputData = fopen ( "/home/rvbill/public_html/include/misc/mod_paypal/MYPayPalReturn.txt", "a+");
 fputs ( $outputData, "********* We are in the paypal ipn failed function*************\n");
} else {
	$outputData = fopen ( "/home/rvglobal/public_html/mod_paypal/MYPayPalReturn.txt", "a+");
	// $outputData = fopen ( "/home/rvbill/public_html/include/misc/mod_paypal/MYPayPalReturn.txt", "a+");
 fputs ( $outputData, "********* We are in the paypal ipn failed function*************\n");
}

$invoice_id = $item_number;
$this_client_id = pp_getClientID($item_number);

          switch ($payment_status)
          {
                  case 'Pending':

                       switch ($pending_reason) {
                               case 'echeck':
                                    $p_txt = 'The payment is pending because it was made by an eCheck, which has not yet cleared';
                               break;
                               case 'multi_currency':
                                    $p_txt = 'You do not have a balance in the currency sent, and you do not have your Payment Receiving Preferences set to automatically convert and accept this payment. You must manually accept or deny this payment.';
                               break;
                               case 'intl':
                                    $p_txt = 'The payment is pending because you, the merchant, hold a non-U.S. account and do not have a withdrawal mechanism. You must manually accept or deny this payment from your Account Overview.';
                               break;
                               case 'verify':
                                    $p_txt = 'The payment is pending because you, the merchant, are not yet verified. You must verify your account before you can accept this payment.';
                               break;
                               case 'address':
                                    $p_txt = 'The payment is pending because your customer did not include a confirmed shipping address and you, the merchant, have your Payment Receiving Preferences set such that you want to manually accept or deny each of these payments. To change your preference, go to the "Preferences" section of your "Profile".';
                               break;
                               case 'upgrade':
                                    $p_txt = 'The payment is pending because it was made via credit card and you, the merchant, must upgrade your account to Business or Premier status in order to receive the funds.';
                               break;
                               case 'unilateral':
                                    $p_txt = 'The payment is pending because it was made to an email address that is not yet registered or confirmed.';
                               break;
                               case 'other':
                               default:
                                    $p_txt = 'The payment is pending for an "other" reason. For more information, contact customer service.';
                               break;
                        }
                       // update_invoice_status($item_number, "3", "$p_txt");
                        $log_comments = "PayPal Pending-$pending_reason: Invoice #:$item_number: $txn_id [Status: 3]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                        log_event($this_client_id,$log_comments,3);

                  break;
                  case 'Failed':
                        $log_comments = "PayPal Failed: $item_number: $txn_id [Status: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                        log_event($this_client_id,$log_comments,3);
						echo 'xxxxxxxxxxxxxxbbbb';
                      //  update_invoice_status($invoice_id, "1", "Failed");

                  break;
                  case 'Denied':
                        $log_comments = "PayPal Denied: $item_number: $txn_id [Status: 1]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                        log_event($this_client_id,$log_comments,3);
                        //update_invoice_status($invoice_id, "1", "Denied");

                  break;
                  case 'Refunded':
                        $log_comments = "PayPal Refunded: $item_number: $txn_id [Status: 4]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                        log_event($this_client_id,$log_comments,3);
                       // update_invoice_status($invoice_id, "4", "Refunded");
                        //update_invoice_reversal($invoice_id);
                        //$reg_desc = "PayPal Refunded: $txn_id";
                        //register_insert($this_client_id,$reg_desc,$invoice_id, NULL, $mc_gross);
                  break;
                  case 'Reversed':
                        $log_comments = "PayPal Reversed: $item_number: $txn_id [Status: 4]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                        log_event($this_client_id,$log_comments,3);
                       // update_invoice_status($invoice_id, "4", "Reversed");
                        //update_invoice_reversal($invoice_id);
                        //$reg_desc = "PayPal Reversed: $txn_id";
                       // register_insert($this_client_id,$reg_desc,$invoice_id, NULL, $mc_gross);
                  break;

                  case 'Canceled':
                        $log_comments = "PayPal Canceled: $item_number: $txn_id [Status: 2]: on ".date("$date_format: h:i:s")." by ".$this_admin['admin_realname'];
                        log_event($this_client_id,$log_comments,3);
                        //update_invoice_status($item_number, "2", "Canceled");
                  break;

          }
          if ( $pp_debug ) { fclose ( $outputData ); }
}

?>
