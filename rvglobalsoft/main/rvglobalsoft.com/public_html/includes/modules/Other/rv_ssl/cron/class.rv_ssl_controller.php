<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
 * function call_Hourly() will be executed by HostBill every hour
 * function call_Daily() will be executed by HostBill once a day
 * function call_Weekly() will be executed by HostBill once a week
 * function call_Monthly() will be executed by HostBill once a month
 */
class rv_ssl_controller extends HBController {

    public $module;
    public $connsk;
    public $connsb;

    function call_EveryRun(){
        
        $message    = '';
        return $message;
        
        // เหมือนข้างล่างจะสร้างปัญหา
        
        require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
        $oAuth =& RvLibs_SSL_PHPLibs::singleton();

        $apiCustom  = $oAuth->generateAPICustom();

        $db         = hbm_db();
        $limit = $db->query("SELECT value FROM hb_ssl_other_settings WHERE name = 'cron_update_status'")->fetch();
        $limit = $limit['value'];

        $sslOrderList = $db->query("
        		SELECT
        			hso.order_id
        			, ha.id AS account_id,
                    ha.status AS account_status,
                    hso.symantec_status,
                    hso.is_renewal
        		FROM
        			hb_ssl_order AS hso
        			, hb_accounts AS ha
        			, hb_invoices AS hi
        			, hb_orders AS ho
        		WHERE
        			ha.order_id = hso.order_id
        			AND ha.status != 'Terminated'
        			AND ha.status != 'Cancelled'
        			AND ho.id = ha.order_id
        			AND ho.invoice_id = hi.id
        			AND hi.status = 'Paid'
        			AND hso.partner_order_id != ''
        			AND (
        					(
        						hso.cron_update = 1
        					) OR (
        						hso.csr != ''
        						AND ho.id = ha.order_id
        						AND ho.invoice_id = hi.id
        						AND hso.authority_orderid = ''
        					)
        			)
        		ORDER BY hso.last_updated
        		LIMIT 0, {$limit}
        ")->fetchAll();
        
        $condition = "name = 'Module - SSL : Status Updater, every run' OR name = 'Module - RV SSL Management, every run'";
        $cronTask = $db->query("SELECT metadata FROM hb_cron_tasks WHERE {$condition}")->fetch();
        $metadata = json_decode($cronTask['metadata'], 1);

        foreach($sslOrderList as $k => $v){
        	$cParams = array(
        			'call' => 'accountCreate',
        			'id' => $v['account_id']
        	);
        	$runtime = strtotime('now');
        	$createOutput = $apiCustom->request($cParams);
        	$status = false;

        	if($createOutput['success'] || isset($createOutput['currentlist'])) {
        		$status = true;
        		echo 'Create account id : ' . $v['account_id'] . ' successful.' . "\n";
        	} else {
        		$errorMsg = 'Create account id : ' . $v['account_id'] . ' unsuccessful.' . "\n";
        		$errorMsg .= json_encode($createOutput) . "\n";
        		echo $errorMsg;
        	}

        	$metadata[$v['account_id']] = array('id' => $v['account_id'], 'status' => $status, 'lastrun' => $runtime);
        }

        $metadataEncode = json_encode($metadata);
        $db->query("UPDATE hb_cron_tasks SET metadata = '{$metadataEncode}' WHERE {$condition}");
    }
}
