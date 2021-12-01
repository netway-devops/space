<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR .'modules/Site/orderhandle/admin/class.orderhandle_controller.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$draftId    = $this->get_template_vars('draft_id');
$aOrders    = $this->get_template_vars('orders');
// --- Get template variable ---


/* --- ตรวจสอบว่า order draft นี้ เป็น quotation หรือไม่ --- */
if ($draftId) {

}

if (count($aOrders)) {
    $result     = orderhandle_controller::getOrderDetail($aOrders);
    $this->assign('aOrderDetail', $result);
}


