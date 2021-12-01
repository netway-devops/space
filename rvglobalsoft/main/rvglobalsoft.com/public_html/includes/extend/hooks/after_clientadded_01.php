<?php

/**
 * New client has been registered in database,
 * Following variable is available to use in this file:  $details contains informations that were stored.
 * Some of keys available (note: if you have custom registration fields they may differ):
 * $details['id']; // new client ID
 * $details['type']; // Personal or Organization account
 * $details['companyname']; // Supplied company name
 * $details['firstname']; //
 * $details['lastname']; //
 * $details['password']; //
 * $details['password2']; //
 * $details['email']; //
 * $details['address1']; //
 * $details['address2']; //
 * $details['city']; //
 * $details['state']; //
 * $details['postcode']; //
 * $details['country']; //
 * $details['phonenumber']; //
 */

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

    if(isset($details['partner']) && $details['partner'] == 'minimum invoice'){
        if($details['minimuminvoice'] == ''){
            
            $db->query("
                UPDATE
                    hb_client_fields_values cfv,
                    hb_client_fields cf
                SET
                    cfv.`value` = '100'
                WHERE
                    cf.id = cfv.field_id
                    AND cf.code = 'minimuminvoice'
                ");
        }
    }
?>