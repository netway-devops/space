<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     
 * Type:     function
 * Name:     easypaymentlink
 * Purpose:  สร้าง link สำหรับลูกค้าให้สามารถชำระเงินโดยไม่ต้องเข้าใช้งานระบบ
 * -------------------------------------------------------------
 */
function smarty_modifier_easypaymentlink($invoiceId)
{
    require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');
    $key        = 'netwayeasypayment-gvlwvgv=5487';
    $now        = time();
    $token      = array(
        'jti'   => md5($now . rand()),
        'iat'   => $now,
        'id'    => $invoiceId
    );
    
    $jwt        = JWT::encode($token, $key);
    return $_SERVER['SERVER_NAME'].'/?cmd=easypayment&action=invoice&id='.$jwt;    
}