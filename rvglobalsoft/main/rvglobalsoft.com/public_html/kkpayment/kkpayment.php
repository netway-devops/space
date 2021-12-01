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

        $boaordernumber = './boaordernumber.txt';
      // echo '==============>'.$boaordernumber;exit;
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
        $subject = 'Web Experts :: Summary Order';
        $headers = 'From: bus@webexperts.co.th' . "\r\n" .
        'Reply-To: bus@webexperts.co.th' . "\r\n" .
        'X-Mailer: PHP/' . phpversion();

        $message = "KASIKORN BANK :: Summary Order\n";
        $message .= "--------------------------------------------\n";
        $message .= "Merchant ID: " . $aData['merchantid'] . "\n";
        $message .= "Invoice No: " . $aData['order_no'] . "\n";
        $message .= "Amount: " . $aData['amount'] . " " . $aData['currency'] . "\n";
        $message .= "Payment For: " . trim($aData['detail']) . "\n";

        @mail(MAILADMIN, $subject, $message, $headers);
        @mail('bus@webexperts.co.th', $subject, $message, $headers);
}

$action = (isset($_POST['action']) && $_POST['action'] == 'kkpaymentForm')
            ? 'kkpaymentForm'
            : 'view';
//echo '<pre>';print_r($_POST);
//$action = 'kkpaymentForm';
//$_POST['amount'] = '90027853';
if ($action == 'view') {
    $forPutData = true;
    $forSend = false;
    $oMerchantUSD = MERCHANT_USD;
    $oMerchantTHB = MERCHANT_THB;
} elseif ($action == 'kkpaymentForm') {
    $forPutData = false;
    $forSend = true;
    ################ Get input ###############
    $merchantId = MERCHANT_THB;//$_POST['merchant_id'];
/*
    if ($_POST['merchant_id'] == MERCHANT_USD) {
        $terminal = TERMINAL_USD;
        $currency = 'USD.';
    } else {
        $terminal = TERMINAL_THB;
        $currency = 'THB.';
    }
    */
    $terminal = TERMINAL_THB;
    $currency = 'THB.';
    $orderNo = getInvoice();
    $amount = $_POST['amount'];
    $amount = trim($amount);
    $amount = number_format($amount, 2, '.', '');
    $transac_amount = sprintf("%012s", $amount);
    $transac_amount =  ereg_replace('\.', '', $transac_amount);
    $detail = $_POST['detail'];
    sendMailRW(array(
        'merchantid'=>$merchantId,
        'order_no'=>$orderNo,
        'amount'=>$amount,
        'currency'=>$currency,
        'detail'=>$detail
    ));

    ################ End input ###############
}
//=== end case add form
include 'kkpaymenthtml.php';




?>