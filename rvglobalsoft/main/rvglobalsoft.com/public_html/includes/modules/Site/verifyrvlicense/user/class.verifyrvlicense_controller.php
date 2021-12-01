<?php
class verifyrvlicense_controller extends HBController {

    private static  $instance;

    public function _default ($request)
    {
    }

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function verify_license_rvskin($ip)
    {
        // หา ip
        $db     = hbm_db();
        $result  = $db->query("
                    SELECT
                        a.id as accid,
                        p.name as proname,
                        rl.active as status,
                        rl.expire as expdate,
                        rl.main_ip as mip,
                        rl.second_ip as sip,
                        ca.email as email,
                        p.category_id as cid,
                        a.next_due as duedate
                    FROM
                        rvskin_license rl
                        LEFT JOIN hb_accounts a ON (rl.hb_acc = a.id)
                        LEFT JOIN hb_products p ON (a.product_id = p.id)
                        LEFT JOIN hb_client_access ca ON (a.client_id = ca.id)
                    WHERE
                        rl.second_ip=:ip
                    AND p.id NOT IN('165','166','167','168')
                    ORDER BY
                        rl.expire DESC
                    ", array(
                        ':ip' => $ip
                    ))->fetchAll();
        if (sizeof($result)<=0){
            $result  = $db->query("
                    SELECT
                        rlt.exprie as expdate,
                        rlt.main_ip as mip,
                        rlt.second_ip as sip
                    FROM
                        rvskin_license_trial rlt
                    WHERE
                    	rlt.second_ip =:ip
                    ORDER BY
                        rlt.exprie DESC
                    ", array(
                    ':ip' => $ip
                    ))->fetchAll();


            if (sizeof($result)<=0){
                $result  = $db->query("
                SELECT
                    acc.id as accid,
                    p.name as proname,
                    acc.status as status,
                    acc.next_due as expdate,
                    ca.email as email,
                    acc.billingcycle as billing,
                    p.category_id as cid,
                    ac.data as mip
                FROM
                    hb_accounts acc
                    INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                    INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
                    INNER JOIN hb_products p ON ( acc.product_id = p.id )
                    INNER JOIN hb_client_access ca ON (acc.client_id = ca.id)
                WHERE
                    f.variable = 'ip'
                    AND p.name LIKE '%RVSkin%'
                    AND ac.data = :ip
                	AND acc.status != 'Terminated'
                ORDER BY
                    acc.next_due DESC
                ", array(
                            ':ip' => $ip
                        ))->fetchAll();
                for($i=0;$i<sizeof($result);$i++){
//                          $result[$i]['expdate'] = $this->subExpDate($result[$i]['expdate'],$result[$i]['billing']);
                         $result[$i]['expdate'] = strtotime($result[$i]['expdate']);
                         $result[$i]['duedate'] = date('Y-m-d',$result[$i]['expdate']);
                }

            }
            else{
            	$i	=	0;
            	foreach($result as $aData){
            		$result[$i]['status']	=	'yes';
            		$result[$i]['proname']	=	'Trial';
            		$i++;
            	}
            }
        }

        //OLD ==============================================================
        for($i=0;$i<sizeof($result);$i++){
        	$result[$i]['expdate'] = date("F j, Y - H:i:s",$result[$i]['expdate']);
        	if(isset($result[$i]["accid"])){
	        	$acctId = $db->query("SELECT next_due FROM hb_accounts WHERE id = {$result[$i]['accid']}")->fetch();
	        	$result[$i]['duedate'] = date("F j, Y - H:i:s",strtotime($acctId['next_due']));
        	}
        }
        //OLD ==============================================================
        //NEW ==============================================================
//         require_once(APPDIR . 'modules/Other/billingcycle/api/class.billingcycle_controller.php');
//         for($i=0;$i<sizeof($result);$i++){
//         	$rvskinExpire = false;
//         	$aData = array('accountId' => $result[$i]['accid'], 'nextDue' => date('d/m/Y', strtotime(explode(' - ', $result[$i]['duedate'])[0])));
//         	$rvskinExpire = billingcycle_controller::getAccountExpiryDate($aData);
//         	if($rvskinExpire){
//         		$exDue = explode('/', $rvskinExpire[1]['expire']);
//         		$newDue = $exDue[1] . '/' . $exDue[0] . '/' . $exDue[2];
//         		$result[$i]['expdate'] = date('F j, Y - H:i:s', strtotime($newDue));
//         	} else {
//         		$result[$i]['expdate'] = date("F j, Y - H:i:s",$result[$i]['expdate']);
//         	}
//             $result[$i]['duedate'] = date("F j, Y - H:i:s",strtotime($result[$i]['duedate']));
//         }
        //NEW ==============================================================
        return $result;
    }
    public function verify_license_rvsitebuilder($request)
    {
        $ip         = $request;
        if (isset($request['ip'])) {
            $ip     = $request['ip'];
        }
        $return     = '';
        if (isset($request['return'])) {
            $return = $request['return'];
        }

        $db = hbm_db();
        $result  = $db->query("
                    SELECT
                        a.id as accid,
                        p.name as proname,
                        rl.active as status,
                        rl.expire as expdate,
                        rl.primary_ip as mip,
                        rl.secondary_ip as sip,
                        ca.email as email,
                        p.category_id as cid
                    FROM
                        rvsitebuilder_license rl
                        LEFT JOIN hb_accounts a ON (rl.hb_acc = a.id)
                        LEFT JOIN hb_products p ON (a.product_id = p.id)
                        LEFT JOIN hb_client_access ca ON (a.client_id = ca.id)
                    WHERE
                        rl.secondary_ip=:ip
                    AND rl.active = 1
                    AND p.id NOT IN('165','166','167','168')
                    ORDER BY
                        rl.expire DESC
                    ", array(
                    ':ip' => $ip
                    ))->fetchAll();
        if (sizeof($result)<=0){
            $result  = $db->query("
                    SELECT
                        rlt.exprie as expdate,
                        rlt.main_ip as mip,
                        rlt.second_ip as sip
                    FROM
                        rvsitebuilder_license_trial rlt
                    WHERE
                    	rlt.second_ip =:ip
                    ORDER BY
                        rlt.exprie DESC
                    ", array(
                    ':ip' => $ip
                    ))->fetchAll();


            if (sizeof($result)<=0){

                 $result  = $db->query("
                SELECT
                    acc.id as accid,
                    p.name as proname,
                    acc.status as status,
                    acc.next_due as expdate,
                    ca.email as email,
                    acc.billingcycle as billing,
                    p.category_id as cid,
                    ac.data as mip
                FROM
                    hb_accounts acc
                    INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                    INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
                    INNER JOIN hb_products p ON ( acc.product_id = p.id )
                    INNER JOIN hb_client_access ca ON (acc.client_id = ca.id)
                WHERE
                    f.variable = 'ip'
                    AND p.name LIKE '%RVSite%'
                    AND ac.data = :ip
                ORDER BY
                        acc.next_due DESC
                LIMIT 1
                ", array(
                            ':ip' => $ip
                        ))->fetchAll();


                for($i=0;$i<sizeof($result);$i++){
                     //$result[$i]['expdate'] = $this->subExpDate($result[$i]['expdate'],$result[$i]['billing']);
                     $result[$i]['expdate'] = strtotime($result[$i]['expdate']);
                     $result[$i]['duedate'] = date('Y-m-d',$result[$i]['expdate']);
                     
                     
                     
                }

            }
            else{
            	$i	=	0;
            	foreach($result as $aData){
            		$result[$i]['status']	=	'1';
            		$result[$i]['proname']	=	'Trial';
            		$i++;
            	}
            }
        }

        for($i=0;$i<sizeof($result);$i++){
            $result[$i]['expdate'] = date("F j, Y - H:i:s",$result[$i]['expdate']);
        }
        //echo print_r($result,true);
        
        if ($return == 'json') {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
            exit;
        }
        
        return $result;


    }


    public function subExpDate($date,$billingcycle){
        $str = "";
        if($billingcycle == 'Monthly')
            $str = "-1 month";
        else if($billingcycle == 'Quarterly')
            $str = "-3 month";
        else if($billingcycle == 'Semi-Annually')
            $str = "-6 month";
        else if($billingcycle == 'Annually')
            $str = "-1 year";
        else if($billingcycle == 'Biennially')
            $str = "-2 year";
        else if($billingcycle == 'Triennially')
            $str = "-3 year";
        return strtotime($date.$str);
    }
}