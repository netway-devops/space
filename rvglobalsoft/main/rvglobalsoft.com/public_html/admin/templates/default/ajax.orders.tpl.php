<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Custom helper ---
require_once(APPDIR . 'class.api.custom.php');
$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

// --- Get template variable ---
$aOrders    = $this->get_template_vars('orders');
// --- Get template variable ---

// --- เพิ่ม service หน้าแสดงรายการสั่งซื้อ ---
if (is_array($aOrders) && count($aOrders)) {
    for ($i = 0; $i< count($aOrders); $i++) {
        $orderId        = $aOrders[$i]['id'];
        
        $result         = $db->query("
                SELECT
                    a.id, a.domain, p.name
                FROM
                    hb_accounts a,
                    hb_products p
                WHERE
                    a.order_id = :orderId
                    AND a.product_id = p.id
                ", array(
                    ':orderId'      => $orderId
                ))->fetchAll();
        
        $aOrders[$i]['service'] = '';
        if (count($result)) {
            foreach ($result as $arr) {
                $aOrders[$i]['service'] .= '<a href="?cmd=accounts&action=edit&id='. $arr['id'] .'" target="_blank">'
                                        . $arr['name'] .' '. $arr['domain'] .'</a><br />';
            }
        }
        
        
        
    }
}

$this->assign('orders', $aOrders);

//echo '<pre>'.print_r($aOrders,true).'</pre>';
