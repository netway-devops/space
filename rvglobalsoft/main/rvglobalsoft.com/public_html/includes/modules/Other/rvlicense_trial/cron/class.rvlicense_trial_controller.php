<?php
/*
 * function call_EveryRun() will be executed by HostBill every 5 minutes
 * function call_Hourly() will be executed by HostBill every hour
 * function call_Daily() will be executed by HostBill once a day
 * function call_Weekly() will be executed by HostBill once a week
 * function call_Monthly() will be executed by HostBill once a month
 */
class rvlicense_trial_controller extends HBController {

    public $module;
    public $connsk;
    public $connsb;

    function call_Daily(){
    	$db = hbm_db();
    	$now = strtotime('now');
    	$db->query("DELETE FROM rvsitebuilder_license_trial WHERE exprie < '{$now}'");
    	$db->query("DELETE FROM rvskin_license_trial WHERE exprie < '{$now}'");
    }

}


