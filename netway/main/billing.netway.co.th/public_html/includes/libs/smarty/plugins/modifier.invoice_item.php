<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.invoice_item.php
 * Type:     function
 * Name:     invoice_item
 * Purpose:  add invoice item description
 * -------------------------------------------------------------
 */
function smarty_modifier_invoice_item($string, $field = 'description')
{
    $db         = hbm_db();
    
    preg_match('/Invoice\s(\d+)/', $string, $match);
    
    if (! isset($match[1])) {
        return $string;
    }
    
    $invoiceId  = $match[1];
    
    $result     = $db->query("
            SELECT * 
            FROM hb_invoice_items 
            WHERE type = 'Invoice'
                AND item_id = :itemId
            ", array(
                ':itemId'  => $invoiceId
            ))->fetch();
    
    if (! isset($result['id'])) {
        return $string;
    }
    
    $string     = isset($result[$field]) ? $result[$field] : $string;
    
    return $string;
}