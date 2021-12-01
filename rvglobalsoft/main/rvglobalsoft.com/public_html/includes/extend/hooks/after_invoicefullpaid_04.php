<?php 
/*
 * คิด Root Commission สำหรับ vpi for cpanel และ vpi for app
 * เมื่อ status เป็น Paid ทำการปรับค่า commission ให้ 
 */

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

$invoiceId      = $details['id'];

$aCommissionSummery = $db->query('
	SELECT		
	    owner_id, date, totel, payment_status
	FROM 
		hb_commission_summery
	WHERE
		invoice_id = :invoice_id
		AND product_cat = 2
', array(
    ':invoice_id' => $invoiceId
))->fetchAll();

if (count($aCommissionSummery)) {
	foreach ($aCommissionSummery as $k => $v) {
		if ($details["status"] == 'Paid') {
			$thisCommission = $v['totel'] * 0.05;
			$db->query('
				UPDATE hb_commission_summery
				SET commission = :commission
					, payment_status = :status
				WHERE
					invoice_id = :invoice_id
					AND owner_id = :owner_id
					AND date = :date
					AND product_cat = :product_cat
			', array(
				':invoice_id' => $invoiceId,
				':owner_id' => $v['owner_id'],
				':date' => $v['date'],
				':status' => $details["status"],
				':commission' => $thisCommission,
				':product_cat' => 2,
			));
			
			$aCommission = $db->query('
				SELECT 
					commission 
				FROM 
					hb_commission 
				WHERE 
					owner_id = :owner_id
			', array(
					':owner_id' => $v['owner_id'],
			))->fetchAll();
			
			if (count($aCommission)) {
				$db->query('
					UPDATE hb_commission 
					SET commission = :commission
					WHERE
						owner_id = :owner_id
				', array(
					':owner_id' => $v['owner_id'],
					':commission' => $aCommission[0]['commission'] + $thisCommission,
				));
			} else {
				$db->query('
					INSERT INTO
						hb_commission (owner_id, commission, withdrawn)
					VALUES
						(:owner_id, :commission, :withdrawn)
				', array(
					':owner_id' => $v['owner_id'],
					':commission' => $thisCommission,
					':withdrawn' => '0.00',
				));
			}
		} else {
			$db->query('
				UPDATE hb_commission_summery
				SET payment_status = :status
				WHERE
					invoice_id = :invoice_id
					AND owner_id = :owner_id
					AND date = :date
					AND product_cat = :product_cat
			', array(
				':invoice_id' => $invoiceId,
				':owner_id' => $v['owner_id'],
				':date' => $v['date'],
				':status' => $details["status"],
				':product_cat' => 2,
			));
		}
	}
}

