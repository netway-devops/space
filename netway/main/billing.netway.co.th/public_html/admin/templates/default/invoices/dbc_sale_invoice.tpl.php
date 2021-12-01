<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}



require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aInvoice       = $this->get_template_vars('invoice');
// --- Get template variable ---


$result     = invoicehandle_controller::singleton()->is_connect_sale_invoice_dbc($aInvoice);

$this->assign('isConnected', $result);

if(isset($result['sale_invoice_no'])){
    $item   = invoicehandle_controller::singleton()->set_sale_invoice_items_dbc($result);  
     
}
$this->assign('item', $item);


//invoicehandle_controller::singleton()->dbcconnect(array('method'=>'GET','service'=>'salesInvoices'));
