<?php

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aGateways           = $this->get_template_vars('gateways');
// --- Get template variable ---

$aGateway            = array();

if (is_array($aGateways) && count($aGateways)) {
    foreach ($aGateways as $k => $v) {
       if ( strtolower($v) == 'cash' ) {
           continue;
       }
       if ( preg_match('/^banktransfer/i', $v) && strtolower($v) != 'banktransfer' ) {
           continue;
       }
       $aGateway[$k]   = $v;
    }
}

$this->assign('gateways2', $aGateway);

$email_Login  = $_COOKIE['user_is_client'];
$this->assign('email_Login', $email_Login);


/* ในข้อง description ของ payment gateway มันจะแทรก tag nl2br */
$gatewayDesc    = $this->get_template_vars('gateway');
$gatewayDesc    = preg_replace('/<br\s?\/>/ism', "\n", $gatewayDesc);
$this->assign('gatewayDesc', $gatewayDesc);

// ปิดไม่ให้ลูกค้าใช้ credit ให้เจ้าหน้าที่ดำเนินการเอง
$this->assign('isEnableCreditAvailable', false);

 // ------------------gtagEcommerce ----------------
