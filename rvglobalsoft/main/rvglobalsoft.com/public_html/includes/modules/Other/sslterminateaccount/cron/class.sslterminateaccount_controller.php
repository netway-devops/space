<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
* function call_Hourly() will be executed by HostBill every hour
* function call_Daily() will be executed by HostBill once a day
* function call_Weekly() will be executed by HostBill once a week
* function call_Monthly() will be executed by HostBill once a month
*/
class sslterminateaccount_controller extends HBController {

	public $module;
	public $connsk;
	public $connsb;

	function call_Daily()
	{
		$terminateCount = 0;
		$db = hbm_db();
		$nowDate = date("Y-m-d");
		$getAccountList = $db->query("
			SELECT
				a.id as account_id
				, a.order_id
				, a.next_due
				, a.product_id
			FROM
				hb_accounts AS a
				, hb_products AS p
				, hb_categories AS c
			WHERE
				a.status = 'Active'
				AND a.product_id = p.id
				AND p.category_id = c.id
				AND c.name = 'SSL'
				AND a.next_due < '{$nowDate}'
		")->fetchAll();
		if(count($getAccountList) > 0){
			require_once APPDIR . 'class.api.custom.php';
			if(file_exists(HBFDIR_LIBS . 'RvLibs/SSL/developer.php')) {
				$api  = ApiCustom::singleton('http://hostbill.rvglobalsoft.net/7944web/api.php');
			} else {
				$api  = ApiCustom::singleton('https://rvglobalsoft.com/7944web/api.php');
			}
			foreach($getAccountList as $eAcct){
				$chkAutomation = $db->query("
					SELECT
						aus.value
					FROM
						hb_automation_settings AS aus
					WHERE
						aus.item_id = :pid
						AND aus.type = 'Hosting'
						AND aus.setting = 'EnableAutoTermination'
				", array(":pid" => $eAcct["product_id"]))->fetch();
				if($chkAutomation["value"] == "on"){
					$getAutomation = $db->query("
						SELECT
							aus.value
						FROM
							hb_automation_settings AS aus
						WHERE
							aus.item_id = :pid
							AND aus.type = 'Hosting'
							AND aus.setting = 'AutoTerminationPeriod'
					", array(":pid" => $eAcct["product_id"]))->fetch();
					if($getAutomation["value"] >= 0){
						$dateText = "+" . $getAutomation["value"] . " day";
					} else if($getAutomation["value"] < 0){
						$dateText = "-" . $getAutomation["value"] . " day";
					} else {
						$dateText = "now";
					}

					$dueDate = strtotime($eAcct["next_due"]);
					$terminateDate = strtotime(date("Y-m-d", strtotime($dateText)));
					if($dueDate > 0 && $dueDate < $terminateDate){
						$tParams = array("call" => "accountTerminate", "id" => $eAcct["account_id"]);
						$terminator = $api->request($tParams);
						if($terminator["success"]){
							$terminateCount++;
						}
					}
				}
			}
		}
		echo "Accounts terminated: " . $terminateCount . "\n";
	}
}