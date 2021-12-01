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

if ($details["status"] == 'Paid') {
	
	$invoiceId      = $details['id'];
	$aSSLOrderInfo  = $db->query('
		SELECT
			a.id AS account_id, a.total AS total, oc.cp_user_id AS cpuser_id, oc.owner_id AS usr_id, rc.owner_id AS owner_id, rc.cpserver_id AS cpserver_id
		FROM
			hb_invoice_items AS ii
			, hb_accounts AS a
			, hb_products AS p
			, hb_ssl_order_cpuser AS oc
			, hb_res_cpservers AS rc
			, hb_oauth_cpuser AS oac
		WHERE
			ii.invoice_id = :invoice_id
			AND ii.item_id = a.id
			AND a.product_id = p.id
			AND p.category_id = 1
			AND a.order_id = oc.hb_order_id
			AND oc.owner_id = rc.usr_id
			AND oc.cp_user_id = oac.cpuser_id
			AND oac.domainname = rc.hostname

		', array(
			':invoice_id' => $invoiceId,
	))->fetchAll();
		
	if (count($aSSLOrderInfo) > 0) {
		$aReports = array();
		$user_id = '';
		foreach ($aSSLOrderInfo as $k => $v) {
			if ($v['usr_id'] == $v['owner_id']) {
				/// ถ้าซื้อเองไม่มี commission
				continue;
			}
			$user_id = $v['usr_id'];
			if (empty($aReports[$v['owner_id']])) {
				$aReports[$v['owner_id']] = array();
			}

			if (empty($aReports[$v['owner_id']][$v['cpserver_id']])) {
				$aReports[$v['owner_id']][$v['cpserver_id']] = array(
						'users' => array(),
						'total' => 0
				);
			}

			$aReports[$v['owner_id']][$v['cpserver_id']]['users'][$v['cpuser_id']] = $v['cpuser_id'];
			$aReports[$v['owner_id']][$v['cpserver_id']]['total'] = $aReports[$v['owner_id']][$v['cpserver_id']]['total'] + $v['total'];
			
		}

		if (count($aReports) > 0) {
			foreach ($aReports as $owner_id => $v) {
				$summery = 0;
				foreach ($v as $server_id => $aData) {
					$activeCustomers = count($aData['users']);
					$totel = $aData['total'];
					$db->query('
						INSERT INTO
							hb_commission_history
							(invoice_id, product_cat, owner_id, usr_id, cpserver_id, active_customers, resold_acct, totel)
						VALUES
							(:invoice_id, :product_cat, :owner_id, :usr_id, :cpserver_id, :active_customers, :resold_acct, :totel)
					', array(
						':invoice_id' => $invoiceId,
						':product_cat' => 1,
						':owner_id' => $owner_id,
						':usr_id' => $user_id,
						':cpserver_id' => $server_id,
						':active_customers' => $activeCustomers,
						':resold_acct' => $activeCustomers,
						':totel' => $totel,
					));
				}
				$date = date("m/Y", time());
				$db->query('
					INSERT INTO
						hb_commission_summery (invoice_id, owner_id, date, product_cat, totel, commission, payment_status)
					VALUES
						(:invoice_id, :owner_id, :date, :product_cat, :totel, "0.0", :payment_status)
				', array(
					':invoice_id' => $invoiceId,
					':owner_id' => $owner_id,
					':date' => $date,
					':product_cat' => 1,
					':totel' => $totel,
					':payment_status' => 'UnPaid',
				));
			}
		}
	}

	$aCommissionSummery = $db->query('
		SELECT
			owner_id, date, totel, payment_status
		FROM
			hb_commission_summery
		WHERE
			invoice_id = :invoice_id
			AND product_cat = 1
	', array(
		':invoice_id' => $invoiceId
	))->fetchAll();


	if (count($aCommissionSummery) > 0) {
		foreach ($aCommissionSummery as $k => $v) {
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
				':product_cat' => 1,
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

			if (count($aCommission) > 0) {
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
		}
	}
}
