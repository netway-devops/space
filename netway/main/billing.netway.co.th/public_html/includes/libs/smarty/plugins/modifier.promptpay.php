<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.promptpay.php
 * Type:     function
 * Name:     promptpay
 * Purpose:  add promptpay to url
 * -------------------------------------------------------------
 */
function smarty_modifier_promptpay($string)
{
    $savePath = MAINDIR . '/promptpayQr/' . 'iv_' . $string . '.png';
    if (! is_file($savePath)) {
        @file_get_contents('https://netway.co.th/promptpay_qr_code.php?id='. $string);
    }
    if (! is_file($savePath)) {
        return '';
    }
    return '<img src="https://netway.co.th/promptpayQr/iv_'. $string .'.png" width="100">';
}