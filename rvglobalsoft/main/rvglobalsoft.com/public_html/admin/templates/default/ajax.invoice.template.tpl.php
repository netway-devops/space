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
$aVars      = $this->get_template_vars('vars');
// --- Get template variable ---

if (isset($aVars['invoice'])) {
    
    $aVars['invoice']['{if $invoice.promotion_code}Promotion code: {$invoice.promotion_code}{/if}']  = 'Promotion code';
    $aVars['item']['{if $item.unit_price}{$item.unit_price}{else}{$item.amount}{/if}']  = 'Unit price';
    $aVars['item']['{if $item.discount_price}{$item.discount_price}{/if}']  = 'Discount price';
    
    $this->assign('vars', $aVars);
    
}

