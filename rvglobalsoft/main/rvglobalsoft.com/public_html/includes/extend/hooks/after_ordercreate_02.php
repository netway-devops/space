<?php

/**
 * New order has been placed
 * Following variable is available to use in this file:  $details is ID property in hb_orders table
 * update card holder ของ client (TB: client_billing)
 */


// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$orderId    = $details;
if ( isset ($_POST['cc']['cardholder']) ) { 
    $aOrder     = $db->query("
                SELECT o.client_id
                FROM hb_orders o
                WHERE o.id = :orderId
                ", array(
                    ':orderId' => $orderId
                ))->fetch();
    if (isset($aOrder['client_id']) && $aOrder['client_id']) {
        $clientId   = $aOrder['client_id'];
        $cardholder = $_POST['cc']['cardholder'];
        $cardcvv = $_POST['cc']['cvv'];
        $db = hbm_db();
            
            // Update hb_coupons
            $query = sprintf("
                                    UPDATE 
                                        %s
                                    SET
                                        cardholder='%s',
                                        cardcvv='%s'
                                    WHERE
                                        client_id='%s'
                                    "
                                    , "hb_client_billing"
                                    , $cardholder
                                    , $cardcvv
                                    , $clientId
                     );       
            $db->query($query);
        /*$db->query("
            UPDATE hb_client_billing 
            SET cardholder = :cardholder
            WHERE client_id = :clientId
        ", array(
            ':credit'       => $cardholder,
            ':clientId'     => $clientId
        ));*/
    
    }
}