<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.qrpayment.php
 * Type:     function
 * Name:     qrpayment
 * Purpose:  add promptpay to url
 * -------------------------------------------------------------
 */
function smarty_modifier_qrpayment($string)
{
    $hostname   = $_SERVER['HTTP_HOST'] ? $_SERVER['HTTP_HOST'] : 'billing.netway.co.th';
    $savePath = MAINDIR . '/qrPaymentTag30/invoice_' . $string . '.png';
    if (! is_file($savePath)) {
        $url    = 'https://'. $hostname .'/qr_payment.php?id='. $string;
        $ch = curl_init ();
        curl_setopt ($ch, CURLOPT_URL,$url);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_exec ($ch);
    }
    if (! is_file($savePath)) {
        return '';
    }
    return '<img src="https://'. $hostname .'/qrPaymentTag30/invoice_'. $string .'.png" width="100">';
}