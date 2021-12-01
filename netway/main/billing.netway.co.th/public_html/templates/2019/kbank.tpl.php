<?php
//--------------------
DEFINE("MAILADMIN","siripen@webexperts.co.th");
DEFINE("MERCHANT_THB","401001922580001");
DEFINE("TERMINAL_THB","74404839");
DEFINE("MERCHANT_USD","402001015707001");
DEFINE("TERMINAL_USD","70340653");
//--------------------
function getInvoice()
{
//MAINDIR
        $boaordernumber = MAINDIR . 'boaordernumber.txt';
       //echo '==============>'.$boaordernumber;exit;
        $file_read = @file($boaordernumber);
        
        if ($file_read) {
            $string = trim($file_read[0]);
            $string++;
        } else {
            // non use
            $string = '301002';
            $total_price = 0;
        }

        $file_order = fopen($boaordernumber, "w+");
        fputs($file_order, $string);
        fclose($file_order);
        return sprintf("%12s",$string);

}
function sendMailRW($aData)
{
        // Send Email to MAILADMIN
        $subject = 'Netway :: Summary Order';
        $headers = 'From: admin@netway.co.th' . "\r\n" .
        'Reply-To: admin@netway.co.th' . "\r\n" .
        'X-Mailer: PHP/' . phpversion();

        $message = "KASIKORN BANK :: Summary Order\n";
        $message .= "--------------------------------------------\n";
        $message .= "Merchant ID: " . $aData['merchantid'] . "\n";
		$message .= "Transaction No: " . $aData['transaction_id'] . "\n";
        $message .= "Invoice No: " . $aData['inv_id'] . "\n";
        $message .= "Amount: " . $aData['amount'] . " THB" . "\n";

        //@mail(MAILADMIN, $subject, $message, $headers);
        @mail('monthira@netway.co.th', $subject, $message, $headers);
}

//=== start ผลการจ่ายเงิน =====
//$_POST['PMGWRESP'] = "00XXXXXXXXXXXX009189XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX00000000328611122013140032000000002000XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKBANKCARDXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX764XXXXXXXXXXXX";
if (isset($_POST['PMGWRESP']) && $_POST['PMGWRESP'] != '') {
    //echo 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
	$codeBank = $_POST['PMGWRESP'];
	$verified = (substr($codeBank, 0, 2) == '00') ? true: false;
	
	if ($verified == false) {
		exit;
	}

	$amount= substr($codeBank, 82, 12);//$_POST['amount'];
	$amount= (ltrim($amount, "0"))/100;
	$invoice_id=  substr($codeBank, 56, 12);//$_POST['invoiceid'];
    $invoice_id = ltrim($invoice_id, "0");
	$transaction_id = substr($codeBank, 14, 6);
   // echo '<br>inv : '.$invoice_id;
   // echo '<br>amout : '.$amount;
    //echo '<br>$transaction_id : '.$transaction_id;
	sendMailRW(array(
        'merchantid'=>MERCHANT_THB,
        'transaction_id'=>$transaction_id,
        'inv_id'=>$invoice_id,
        'amount'=>$amount,
        'currency'=>'THB',
        'detail'=>$_POST['detail']
    ));
	
	
}

//=== end ผลการจ่ายเงิน =====



$action = (isset($_POST['action']) && $_POST['action'] == 'kkpaymentForm')
            ? 'kkpaymentForm'
            : 'view';

//echo '<pre>';print_r($_POST);
//$action = 'kkpaymentForm';
//$_POST['amount'] = '90027853';
if ($action == 'view' || $_POST['amount'] == '' || $_POST['inv'] == '') {
    $this->assign('forPutData', true);
    $this->assign('forSend', false);
    $this->assign('oMerchantTHB', MERCHANT_THB);
} elseif ($action == 'kkpaymentForm') {

    $this->assign('forPutData', false);

    $this->assign('forSend', true);
    ################ Get input ###############

    $this->assign('merchantId',MERCHANT_THB);

    $this->assign('terminal',TERMINAL_THB);

    $this->assign('currency','THB.');

    $orderno = $_POST['inv'];//getInvoice();
    $this->assign('orderNo',$orderno);
	
    $amount = $_POST['amount'];
    $amount = trim($amount);
    $amount = number_format($amount, 2, '.', '');
    $this->assign('amount',$amount);
    $transac_amount = sprintf("%012s", $amount);
    $transac_amount =  ereg_replace('\.', '', $transac_amount);
    $this->assign('transac_amount',$transac_amount);

    $this->assign('detail',$_POST['detail']);
     $url    = (isset($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST'] . '/kbank';
     $this->assign('urlcallback',$url);
   /* sendMailRW(array(
        'merchantid'=>MERCHANT_THB,
        'order_no'=>$orderNo,
        'amount'=>$amount,
        'currency'=>'THB',
        'detail'=>$_POST['detail']
    ));
*/
    ################ End input ###############
}
//=== end case add form
//include 'kkpaymenthtml.php';




?>