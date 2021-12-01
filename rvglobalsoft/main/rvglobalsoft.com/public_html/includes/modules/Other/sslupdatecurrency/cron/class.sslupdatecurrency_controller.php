<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
* function call_Hourly() will be executed by HostBill every hour
* function call_Daily() will be executed by HostBill once a day
* function call_Weekly() will be executed by HostBill once a week
* function call_Monthly() will be executed by HostBill once a month
*/
class sslupdatecurrency_controller extends HBController {

	public $module;
	public $connsk;
	public $connsb;

	function call_Daily(){
		$db = hbm_db();
		$hb_currency = $db->query("SELECT * FROM hb_rvg_currencies ORDER BY code", array())->fetchAll();

		$google = array();
		$hb = array();
		foreach($hb_currency as $eachCur){
			$cn = curl_init();
			curl_setopt($cn, CURLOPT_URL, "https://www.google.com/finance/converter?a=1&from=USD&to={$eachCur['code']}");
			curl_setopt($cn, CURLOPT_RETURNTRANSFER, 1);
			$output = curl_exec($cn);
			curl_close($cn);

			preg_match_all('/<span class=bld>([^<]*) [A-Z]*<\/span>/', $output, $output);
			$google[$eachCur['code']] = number_format($output[1][0], 5, '.', '');
			if($google[$eachCur['code']] == ""){
				$cn = curl_init();
				curl_setopt($cn, CURLOPT_URL, "http://free.currencyconverterapi.com/api/v3/convert?q=USD_{$eachCur['code']}&compact=y");
				curl_setopt($cn, CURLOPT_RETURNTRANSFER, 1);
				$output = curl_exec($cn);
				curl_close($cn);

				$output = json_decode($output, 1);

				$google[$eachCur['code']] = number_format($output["{$eachCur["code"]}_USD"]["val"], 5, '.', '');


			}
			$hb[$eachCur['code']] = $eachCur['rate'];
		}

		$diffData = array_diff($google, $hb);

		foreach($diffData as $code => $rate){
			$db->query("
					UPDATE
						hb_rvg_currencies
					SET
						rate = :rate
					WHERE
						code = :code
			", array(
					":rate" => $rate
					, ":code" => $code
			));
			echo "UPDATE[$code] = {$hb[$code]} to {$google[$code]}\n";
		}

		echo "TOTAL : " . count($diffData);

	}
}