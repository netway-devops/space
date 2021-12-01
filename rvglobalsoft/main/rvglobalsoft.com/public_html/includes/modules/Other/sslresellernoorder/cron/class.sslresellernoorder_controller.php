<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
* function call_Hourly() will be executed by HostBill every hour
* function call_Daily() will be executed by HostBill once a day
* function call_Weekly() will be executed by HostBill once a week
* function call_Monthly() will be executed by HostBill once a month
*/
class sslresellernoorder_controller extends HBController {

	public $module;
	public $connsk;
	public $connsb;

	function call_Daily(){
		$db = hbm_db();
		$to = '937.115829@dropbox.pipedrive.com';

		$user_id_list = $db->query('
				SELECT
					hrr.user_id
					, hcd.firstname
					, hcd.lastname
					, hca.email
					, hcd.companyname
					, hcd.phonenumber
				FROM
					hb_res_registry AS hrr
					, hb_client_details AS hcd
					, hb_client_access AS hca
				WHERE
					hrr.req_key = "billing_type"
					AND hrr.req_value = "WHMCS"
					AND hrr.user_id = hca.id
					AND hrr.user_id = hcd.id
		')->fetchAll();

		foreach ($user_id_list as $value) {
// 			if($value['user_id'] != '9819') continue;
			$orderCount = array();
			$orderCount = $db->query('
					SELECT
						o.id
					FROM
						hb_orders AS o
						, hb_accounts AS a
						, hb_ssl AS s
						, hb_products AS p
					WHERE
						o.notes = "order from WHMCS"
						AND o.client_id = :usrId
						AND o.id = a.order_id
						AND a.product_id = p.id
						AND p.name = s.ssl_name
					', array(
						':usrId' => $value['user_id']
					)
			)->fetchAll();

			$billAdded = $db->query('
					SELECT
						req_value AS time_added
					FROM
						hb_res_registry
					WHERE
						user_id = :usrId
						AND req_key = "billing_added"
					', array(
						':usrId' => $value['user_id']
					)
			)->fetch();

			$now = strtotime('now');
			$min = 60*60*24*7;
			$max = $min + 86400;
			$target = $min/86400;
			$timeAdd = $billAdded['time_added'];
			$dateCal = $now - $timeAdd;

			if(sizeof($orderCount) == 0 && $dateCal >= $min && $dateCal <= $max){
				require_once(HBFDIR_LIBS  . 'RvLibs/SSL/PHPMailer-master/class.phpmailer.php');

				$domainName = $db->query('
						SELECT
							req_value AS domain
						FROM
							hb_res_registry
						WHERE
							user_id = :usrId
							AND req_key = "billing_url"
						', array(
							':usrId' => $value['user_id']
						)
				)->fetch();

				$title = "Reseller - {$domainName['domain']} never order on WHMCS for {$target} ";
				$title .= ($target > 1) ? 'days' : 'day';

				$content = array(
						'item_type' => 'deal',
						'stage_id' => '38',
						'title' => $title,
						'organization' => $value['companyname'],
						'currency' => '฿',
						'owner' => 'sirishom@rvglobalsoft.com',
						'visible_to' => '3',
						'person' => array(
								'name' => $value['firstname'] . ' ' . $value['lastname'],
								'email' => $value['email'],
								'organization' => $value['companyname'],
								'phone' => $value['phonenumber']
						)

				);

				$mail = new PHPMailer();
				$mail->From = 'rvsslteam@rvglobalsoft.com';                       // Sender Email
				$mail->FromName = 'RVSSL Team';                                   // Sender Name
				$mail->AddAddress($to);                                         // To
				$mail->Subject = 'Pipedrive deal create';                                  	// Subject
				$mail->Body = json_encode($content);
				$mail->Send();
			}
		}
	}
}