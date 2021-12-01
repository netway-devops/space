<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
 * function call_Hourly() will be executed by HostBill every hour
 * function call_Daily() will be executed by HostBill once a day
 * function call_Weekly() will be executed by HostBill once a week
 * function call_Monthly() will be executed by HostBill once a month
 */
class sslmailtononecsr_controller extends HBController {

    public $module;
    public $connsk;
    public $connsb;

    function call_Daily(){
        require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
        $oAuth =& RvLibs_SSL_PHPLibs::singleton();

        $db         = hbm_db();
        $sslEmailList = $db->query("
                SELECT
        			hso.order_id
        			, hso.date_created
                    , hca.email
                FROM
        			hb_client_access AS hca
                    , hb_ssl_order AS hso
                    , hb_orders AS ho
                    , hb_invoices AS hi
        			, hb_accounts AS ha
                WHERE
                    hso.csr = ''
                    AND ho.id = hso.order_id
                    AND ho.invoice_id = hi.id
                    AND hi.status = 'Paid'
        			AND hca.id = hso.usr_id
        			AND ha.order_id = ho.id
        			AND ha.status != 'Terminated'
        			ORDER BY hso.date_created ASC

        ")->fetchAll();

        $emailList = array();
        foreach($sslEmailList as $k => $v){
        	$now = strtotime('now');
        	$interval = $now-$v['date_created'];
        	$interval = ceil($interval/(60*60*24));
        	$intervalMod = ($interval%7);
        	if($interval > 1 && $intervalMod == 0){
//         		$emailList[$v['email']] = '';
        		$emailList[$v['order_id']] = '';
        		if(sizeof($emailList) == 100){
        			break;
        		}
        	}
        }

        if(sizeof($emailList) >	0){
        	foreach($emailList as $k => $v){
//         		$oAuth->sendMailSubmitCSR($k);
        		$response = $oAuth->sendMailNew($k, 'notificateCSR');
        		if($response === false){
        			break;
        		}
        	}
        }
    }




}
