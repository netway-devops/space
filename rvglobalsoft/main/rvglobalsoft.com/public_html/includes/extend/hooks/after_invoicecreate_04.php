<?php

/*
 * คิด Root Commission สำหรับ vpi for cpanel และ vpi for app
 */
define('RVGLOBALSOFT_VIP_FOR_CPANEL_ID', 60);
define('RVGLOBALSOFT_VIP_FOR_APP_ID', 61);
$vip_for_cp = RVGLOBALSOFT_VIP_FOR_CPANEL_ID;
$vip_for_app = RVGLOBALSOFT_VIP_FOR_APP_ID;


// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

$invoiceId          = $details;
/// เอา invoice id ไปหา account id ที่ product id เป็น vpi for cpanel และ vpi for app
//$aVipInfo = getVpiInfoByinvoiceId($invoiceId);
$aVipInfo = $db->query('
        SELECT
            va.vip_acct_id AS vip_acct_id, ac.id AS account_id, va.cpuser_id AS cpuser_id
            , va.appsuser_id AS appsuser_id, oc.usr_id AS usr_id, rc.owner_id AS owner_id
            , rc.cpserver_id AS cpserver_id
        FROM
            hb_invoice_items AS ii
            , hb_accounts AS ac
            , hb_vip_info_cp_apps AS via
            , hb_vip_acct AS va
            , hb_oauth_cpuser AS oc
            , hb_res_cpservers AS rc
        WHERE
            ii.invoice_id = :invoice_id
            AND ii.item_id = ac.id
            AND (ac.product_id = :vip_for_cp OR ac.product_id = :vip_for_app)
            AND ac.id = via.account_id
            AND via.vip_info_cp_apps_id = va.vip_info_cp_apps_id
            AND va.vip_acct_status = :status
            AND va.cp_apps_service_status = :status
            AND va.cpuser_id = oc.cpuser_id
            AND oc.usr_id = rc.usr_id
    ', array(
            ':invoice_id' => $invoiceId,
            ':vip_for_cp' => $vip_for_cp,
            ':vip_for_app' => $vip_for_app,
            ':status' => 'ENABLED',
    ))->fetchAll();
    
    
if (count($aVipInfo) > 0) {
	$aReports = array();
	$user_id = '';
	foreach ($aVipInfo as $k => $v) {
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
				'resold_acct' => 0		
			);
		}
		
		$aReports[$v['owner_id']][$v['cpserver_id']]['users'][$v['cpuser_id']] = $v['cpuser_id'];
		$aReports[$v['owner_id']][$v['cpserver_id']]['resold_acct'] = $aReports[$v['owner_id']][$v['cpserver_id']]['resold_acct'] +1;
		
	}
	if (count($aReports) > 0) {
		foreach ($aReports as $owner_id => $v) {
			$summery = 0;
			foreach ($v as $server_id => $aData) {
				$activeCustomers = count($aData['users']);
				$resold_acct = $aData['resold_acct'];
				$totel = $resold_acct *2;
				$summery = $summery + $totel;
				$db->query('
					INSERT INTO
						hb_commission_history 
						(invoice_id, product_cat, owner_id, usr_id, cpserver_id, active_customers, resold_acct, totel)
					VALUES
						(:invoice_id, :product_cat, :owner_id, :usr_id, :cpserver_id, :active_customers, :resold_acct, :totel)
				', array(
					':invoice_id' => $invoiceId,
					':product_cat' => 2,
					':owner_id' => $owner_id,
					':usr_id' => $user_id,
					':cpserver_id' => $server_id,
					':active_customers' => $activeCustomers,
					':resold_acct' => $resold_acct,
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
                    ':product_cat' => 2,
                    ':totel' => $summery,
                    ':payment_status' => 'UnPaid',
            ));
     		//updateVIPCommissionSummery($invoiceId, $owner_id, $summery);
		}
	}
}