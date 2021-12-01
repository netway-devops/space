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
    $aVars['item']['{if $item.unit_price!=0.00}{$item.unit_price}{else}{$item.amount}{/if}']  = 'Unit price';
    $aVars['item']['{if $item.quantity_text}{$item.quantity_text}{else}{$item.qty}{/if}']  = 'Quantity text';
    $aVars['item']['{if $item.discount_price}{$item.discount_price}{else}0.00{/if}']  = 'Discount price';
    
    $aVars['invoice']['{$invoice.tax_wh_3}']  = 'Tax withholding 3 percent';
    $aVars['invoice']['{$invoice.total_wh_3}']  = 'Total withholding 3 percent';
    $aVars['invoice']['{$invoice.tax_wh_1}']  = 'Tax withholding 1 percent';
    $aVars['invoice']['{$invoice.total_wh_1}']  = 'Total withholding 1 percent';
    $aVars['invoice']['{$invoice.tax_wh_15}']  = 'Tax withholding 1.5 percent';
    $aVars['invoice']['{$invoice.total_wh_15}']  = 'Total withholding 1.5 percent';
    
    $aVars['invoice']['{if $invoice.billing_contact_id}{$invoice.billing_address|nl2br}{/if}']  = 'Billing address';
    $aVars['invoice']['{if $invoice.billing_taxid}{$invoice.billing_taxid|nl2br}{/if}']  = 'เลขประจำตัวผู้เสียภาษี';
    
    $this->assign('vars', $aVars);
    
}

