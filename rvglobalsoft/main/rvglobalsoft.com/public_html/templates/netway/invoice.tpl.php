<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

$aGateways           = $this->get_template_vars('gateways');
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

/* ในข้อง description ของ payment gateway มันจะแทรก tag nl2br */
$gatewayDesc    = $this->get_template_vars('gateway');
$gatewayDesc    = preg_replace('/<br\s?\/>/ism', "\n", $gatewayDesc);
$this->assign('gatewayDesc', $gatewayDesc);

// ปิดไม่ให้ลูกค้าใช้ credit ให้เจ้าหน้าที่ดำเนินการเอง
$this->assign('isEnableCreditAvailable', false);

