<?php
/**
 * edit description upgrade order
 */

 // --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$invoiceId          = $details;
$result         = $db->query("
        SELECT
            id,item_id,description
        FROM
            hb_invoice_items
        WHERE
            invoice_id = :invoiceId
            AND type = 'FieldUpgrade'
        ", array(
            ':invoiceId'        => $invoiceId
        ))->fetchAll();
        
    
foreach ($result as $key) {
	$result2         = $db->query("
        SELECT
            p.name as name,
            cu.old_qty as oldqty,
            cu.new_qty as newqty,
            a.next_due as due
        FROM
            hb_config_upgrades cu,
            hb_accounts a,
            hb_products p
        WHERE
            cu.id = :configId
            AND cu.account_id = a.id
            AND a.product_id = p.id
        ", array(
            ':configId'        => $key['item_id']
        ))->fetchAll();
   
    $qty      = $result2[0]['newqty']-$result2[0]['oldqty'];
    $newDesc  = $result2[0]['name'];
    $newDesc .= "<br>".substr($key['description'], 0, -1);
    $newDesc .= "<br>Add ".$qty." account(s). Price is calculated from ";
    $newDesc .= date("d/m/Y")." to ". date("d/m/Y", strtotime($result2[0]['due']));
    
    
    
    $db->query("
        UPDATE `hb_invoice_items` 
        SET `description`=:desc 
        WHERE id = :id
        ",array(':desc' => $newDesc,
                ':id'   => $key['id']));
    
}

?>