<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.invoice_total.php
 * Type:     function
 * Name:     invoice_total
 * Purpose:  invoice total
 * -------------------------------------------------------------
 */
function smarty_function_invoice_total ($params, $template) {
    if(isset($template->_tpl_vars['invoice']['id'])){
        return '';
    }
}
