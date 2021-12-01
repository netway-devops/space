<?php

/**
 * Invoice has been fully paid
 * Following variable is available to use in this file:  $details This array of invoice details contains following keys:
 * $details["id"]; // Invoice id
 * $details["status"]; //Current invoice status
 * $details["client_id"]; //Owner of invoice
 * $details["date"]; //Invoice generation date
 * $details["subtotal"]; //Subtotal
 * $details["credit"]; //Credit applied to invoice
 * $details["tax"]; //Tax applied to invoice
 * $details["total"]; //Invoice total
 * $details["payment_module"]; //ID of gateway used with invoice
 * $details["currency_id"]; //ID of invoice currency, default =0
 * $details["notes"]; //Invoice notes
 * $details["items"]; // Invoice items are listed under this key, sample item:
 * $details["items"][0]["type"]; //Item type (ie. Hosting, Domain)
 * $details["items"][0]["item_id"]; //Item id, for type=Hosting this relates to hb_accounts.id field
 * $details["items"][0]["description"]; //Item line text
 * $details["items"][0]["amount"]; //Item price
 * $details["items"][0]["taxed"]; //Is item taxed? 1/0
 * $details["items"][0]["qty"]; //Item quantitiy
 */

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---



/*$result         = $db->query("
	SELECT 
		a.product_id
	FROM 
		hb_accounts a
	WHERE 
		a.id = :id
		
	", array(
 		':id' => $details["items"][0]["item_id"]
	)
);

$product_id = $result['product_id'];
*/
if(substr($details['items'][0]['description'],0,79) == 'Upgrade:RV2Factor: 2-factor Authentication for WHM (Free 1 account for 30 days)'){
 
    $accID = $details["items"][0]["item_id"];
    $qty   = $details["items"][0]["qty"];
    $invoiceID = $details["id"];
    $res  =    $db->query("
            SELECT
                new_value,new_billing
            FROM
                hb_upgrades 
            WHERE account_id = :accid
                  AND order_id = :inv
                  AND product_id = 59  
            ", array(
                ':accid' => $accID,
                ':inv'   => '999'.$invoiceID
            ))->fetch();
            
    $reTotal = $res['new_value']*$qty;
    $cycle   = $res['new_billing'];
    
    $nextacc;
    if($cycle == 'Monthly'){
            $today  = $details["date"];
            $nextM  = date('Y-m-07',strtotime($today.'+1 month'));
            $difference = round(abs(strtotime($nextM)-strtotime($today))/86400);
            $dayo   = date('d');
            if($dayo<=20 && $dayo>=7){
                $nextacc = $nextM;
            }
           
            else{
               if($dayo>=1 && $dayo<=6){
                   
                    $nextacc = date('Y-m-07',strtotime($today.'+1 month'));
                }
                else{
                    
                    $nextacc = date('Y-m-07',strtotime($today.'+2 month'));
                } 
            }
    }
    else{
        $dayo   = date('d');
        
        if($dayo>=1 && $dayo<=6){
            $nextacc     = date('Y-m-07');
        }else{
            $nextacc     = date('Y-m-07',strtotime('+1 year')); 
        }
         
    }
    
    $db->query("
		UPDATE hb_vip_info SET `quantity`= :quantity, `quantity_at_symantec`= :quantity WHERE `account_id`=:account_id
	", array(':account_id'      => $accID, ':quantity'   => $qty));
    
    require_once APPDIR.'modules/Site/order2factorhb/user/class.order2factorhb_controller.php';
    
    order2factorhb_controller::singleton()->setUpgradePaid($accID,$reTotal,$cycle,$nextacc,$qty,$invoiceID);
} 
/*elseif ($product_id == '59') {
	$accID = $details["items"][0]["item_id"];
	$qty   = $details["items"][0]["qty"];
	$db->query("
		UPDATE hb_vip_info SET `quantity`= :quantity WHERE `account_id`=:account_id
	", array(':account_id'      => $accID, ':quantity'   => $qty));
}*/

?>