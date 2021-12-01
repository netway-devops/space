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
$aInvoices            = $this->get_template_vars('invoices');
// --- Get template variable ---


/* --- แสดงหมายเลขใบกำกับภาษี --- */
$aInvoiceId     = array();
$aInvoiceDatas  = array();

if (count($aInvoices)) {
    foreach ($aInvoices as $aInvoice) {
        array_push($aInvoiceId, $aInvoice['id']);
    }
    
    $result     = $db->query("
                SELECT
                    i.*
                FROM
                    hb_invoices i
                WHERE
                    i.id IN (". implode(',', $aInvoiceId) .")
                ")->fetchAll();
    if (count($result)) {
        foreach ($result as $v) {
            $aInvoiceDatas[$v['id']]    = $v;
            if ($v['total'] == 0.01 && $v['status'] == 'Paid') {
                $aInvoiceDatas[$v['id']]['isHidden']    = 1;
            }
        }
    }
    
}

$this->assign('aInvoiceDatas', $aInvoiceDatas);
