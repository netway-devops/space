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
function smarty_modifier_desItem($string,$invoiceItemId=0,$itemType="",$itemId=0)
{
    $db         = hbm_db();

    if ($itemType != 'Invoice') {
        return $string;
    }

    $result  = $db->query("
        SELECT  description
        FROM hb_invoice_items 
        WHERE  id   = :id
        ", array(
            ':id'      => $invoiceItemId
    ))->fetch();  

    $string = isset($result['description'])?$result['description']:$string;

    if (strlen($string) > 30) {

        return $string;  
    }

    $description ='Invoice '.$itemId."\r\n";

    $result     = $db->query("
                    SELECT id, invoice_id, type, item_id, description
                    FROM hb_invoice_items 
                    WHERE invoice_id = :invoiceId
                    ", array(
                        ':invoiceId' => $itemId
                    ))->fetchAll();  

    foreach ($result  as $item) {                
        $description .= "\r\n";  
        $description .= isset($item['description']) ? $item['description']: ''; 
    }

        $db->query("
            UPDATE hb_invoice_items
            SET description = :description
            WHERE id  = :id
            ", array(
                ':description' => $description,
                ':id'         => $invoiceItemId
        ));
        
    $string = nl2br($description);
    return  $string;
}
