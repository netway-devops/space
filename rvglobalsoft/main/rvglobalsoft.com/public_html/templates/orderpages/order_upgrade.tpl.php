<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

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

$con  = $this->get_template_vars('contents');
//echo '<pre>'.print_r($this->get_template_vars(),true).'</pre>';
if($con['product']['new_product_id'] == 59 && $con['product']['product_id'] == 58){
    

    $subtotal   = $this->get_template_vars('subtotal');
    $subtotal['recurring'][$_SESSION['UpgradeCustom']['product']['new_billing']] = $_SESSION['UpgradeCustom']['config'][13]['charge'];
    $sum        = $_SESSION['UpgradeCustom']['config'][13]['charge'];
    $tax        = $this->get_template_vars('tax');
    
    
    $tax['subtotal']= $sum; 
    if($tax['credit'] >= $tax['subtotal'])
    $tax['credit'] = $sum;
    
    if($tax['credit'] <=0){
        $tax['total'] = $sum;
    }
    else {
        $tax['total'] = $tax['subtotal']-$tax['credit']; 
    }
    $this->assign('contents', $_SESSION['UpgradeCustom']);
    $this->assign('subtotal', $subtotal);
    $this->assign('tax', $tax);
 
}
$this->assign('gateways2', $aGateway);
