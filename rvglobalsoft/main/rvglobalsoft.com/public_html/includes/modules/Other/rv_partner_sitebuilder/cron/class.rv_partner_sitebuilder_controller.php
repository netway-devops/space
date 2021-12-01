<?php
/****************************************************************
 * _mergeUser : เอาไว้ merge client id จาก hostbilll เข้า database ของ rvsitebuilder
 * 
 * 
 ***************************************************************/
class rv_partner_sitebuilder_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    public $aProductDedi = array(77,79);
    public $aProductVPS = array(78,80);
    public $test = false;
    //จำนวน license และราคาขั้นต่ำ
    public $aPrice = array(
        'dedi' => array(
            '20' => 4.9,
            '50' => 4.75,
            '200' => 4.0,
            '300' => 3.5
        ),
       
        'vps' => array (
            '40' => 3.15,
            '50' => 3.13,
            '200' => 2.75,
            '300' => 2.5,
        ),
        'noc' => array (
            '20'  => 8,
            '100' => 7.67,
            '200' => 7.34,
            '300' => 7.01,
            '400' => 6.68,
            '500' => 6.35,
            '600' => 6.0,

        )    
        
);
    /**
     * Delete ticket ที่ถูก tag ว่าเป็น spam
     * @return string
     */

    private function __($out) 
    {
        return  $out ."<br />";
    }
    
    
    /**
	 * 1. นับจำนวน license ใช้เพื่อ ออกบิล
	 * 2. ใช้ update hb_acc ที่ยังไม่ได้ใส่ค่า เพราะ add license มาจาก api
	 */
    public function call_EveryRun()
    {
        $message = '';
        $db         = hbm_db();
        $api = new ApiWrapper();
		/*
		 $aAccountIsNull = array(
			'cc0a2aac8df35176225f88bac577442e'=>array('9'=>array('accid'=>'3570') ,'11'=>array('accid'=>'3571')),
			'7ab942fd52dd0e08682978e6f8949581'=>array('9'=>array('accid'=>'3592') ,'11'=>array('accid'=>'3593')),
			'7e047c62cde73592bbb6ef2849cfca0f'=>array('9'=>array('accid'=>'3548') ,'11'=>array('accid'=>'3549')),
			'c5f65a620f404c3201335b47511df91f'=>array('9'=>array('accid'=>'3554') ,'11'=>array('accid'=>'3555')),
			'f394c1e67980e86e561b709644cdb356'=>array('9'=>array('accid'=>'3532') ,'11'=>array('accid'=>'3533')),
			'edad19689b3fad7752a9cf0c970a20e8'=>array('9'=>array('accid'=>'3552') ,'11'=>array('accid'=>'3553')),
			'7322f75cc7ba16db1799fd8d25dbcde4'=>array('9'=>array('accid'=>'11350') ,'11'=>array('accid'=>'11349')),
			'01ce098d696ac63df8d8c2997931c2d7'=>array('9'=>array('accid'=>'3544') ,'11'=>array('accid'=>'3545')),
			'37275a58331e9134af7beac30404f568'=>array('9'=>array('accid'=>'3542') ,'11'=>array('accid'=>'3543')),
			'eecf882e56dc7c20fe25a879318a6154'=>array('9'=>array('accid'=>'3546') ,'11'=>array('accid'=>'3547')),
			'9f968f73a2a19c08472378761292d6a3'=>array('9'=>array('accid'=>'3580') ,'11'=>array('accid'=>'3581')),
			'db43e07cb37e078c1274f03b8f3a9377'=>array('9'=>array('accid'=>'3576') ,'11'=>array('accid'=>'3577')),
			'ebe286eddcc091227b379317a6f9c7ae'=>array('9'=>array('accid'=>'3560') ,'11'=>array('accid'=>'3561')),
			'eaf76c1a3fd046e821a41d2aaf7a81ec'=>array('9'=>array('accid'=>'3536') ,'11'=>array('accid'=>'3537')),
		
        );
        date_default_timezone_set('UTC');
		$startDate = time();
		
		$exp 		= mktime(23,59,59,date('n', $startDate)+1,7,date('y', $startDate)); 
		$eff 		= mktime(23,59,59,date('n', $startDate)+1,10,date('y', $startDate)); 
		foreach($aAccountIsNull as $k => $v){
			foreach ($v as $k2=>$v2) {
				$sqlSetData = $db->query("
				UPDATE rvsitebuilder_license 
				SET hb_acc  = :accid ,
				expire=:exp,
				effective_expiry=:eff
				WHERE rvskin_user_snd = :userid AND license_type = :licensetype AND  `hb_acc` =0
				",array(':accid'=>$v2['accid'],':exp' => $exp,':eff' => $eff,':userid'=>$k,':licensetype'=>$k2));
				//$resUpdateHbAcc = $db->query($sqlSetData);
			}
		}
		*/
        	//=== 1. นับจำนวน license ใช้เพื่อ ออกบิล
        $aGetAcc  = $db->query("
                SELECT 
                    id,product_id
                FROM 
                    hb_accounts
                WHERE
                    product_id in (77,78,79,80,159)
                    AND status='Active'
                    
                ", array())->fetchall();
		if (count($aGetAcc) == 0 )return 'NO DATA';
		foreach ($aGetAcc as $key => $adtl) {
            
                if (in_array($adtl['product_id'], $this->aProductDedi)) {
                    $serverType = 9;
                } elseif(in_array($adtl['product_id'], $this->aProductVPS))  {
                    $serverType = 11;
                }else{
                    $serverType = 0;
                }

                $sql = "
                    SELECT 
                        count( u.license_id ) AS numlicense
                    FROM 
                        rvsitebuilder_license u
                    WHERE 
                            u.hb_acc = :hb_acc
                    ";
                if($serverType){
                        $sql .= "
                             AND  u.license_type = '{$serverType}'
                             ";
                }
                $sql .= "GROUP BY u.hb_acc";
                      

                $aData = $db->query($sql,array(
                    ':hb_acc' => $adtl['id']
                ))->fetch();
                
                $aConf = array();
                if (isset($aData['numlicense'])) {
                    $aConf['numlicense'] = $aData['numlicense'];
                } else {
                    $aConf['numlicense'] = 0;
                }
                $params = array(
                    'id'=>$adtl['id']
                );
                $aConfig = $api->getAccountDetails($params);
                    
                // echo '<pre>';print_r($aConfig);
                if(isset($aConfig['details']['custom'])){
                    if (count($aConfig['details']['custom']) == 0 )return 'NO DATA';
                    foreach($aConfig['details']['custom'] as $k => $v){
                        if ($v['variable'] == 'min_quantity') {
                            $aConf['min_quantity'] = $v['qty'];
                        }
                        if ($v['variable'] == 'price_is_fixed') {
                            $aConf['price_is_fixed'] = $v['qty'];
                        }
                        if ($v['variable'] == 'price_for_fixed') {
                            $aConf['price_for_fixed'] = $v['data'][$k];
                        }
                    }
                }
                 //echo 'serverType ='.$serverType;
                $aQtyPrice 				= $this->_getPriceQty($serverType,$aConf, $adtl['id']);
                $aPost['qty'] 			= $aQtyPrice['q'];
                $aPost['firstprice'] 	= $aQtyPrice['p'];
                $aPost['totalprice'] 	= $aQtyPrice['p'];
                $aPost['accid'] 		= $adtl['id'];
                $aPost['product_id'] 	= $adtl['product_id'];
                $resUpdate 				= $this->_updateHostbill($aPost); 
        
            
        }
        echo 'OK';
        
        return 'OK'; 
    }

    /*********************************************
     * 9 : DEDICATED
     * 11 : VPS
     *********************************************/
    private function _getPriceQty($itype,$aVar, $accountId = 0){
        $res = array();
        $price_unit = 0;
        if ($itype == 9) {
            $res['q'] = ($aVar['numlicense'] > $aVar['min_quantity']) 
                    ? $aVar['numlicense'] 
                    : $aVar['min_quantity'];
            if ($aVar['price_is_fixed'] == 1) {
                $price_unit = $aVar['price_for_fixed'];
            } else {

                if ($res['q'] <= 20) {
                    $price_unit = $this->aPrice['dedi']['20'];
                } elseif ($res['q'] > 20 && $res['q'] < 300) {
                    $price_unit = (1000 - $res['q']) / 200;  
                } elseif ($res['q'] >= 300 ) {
                    $price_unit = $this->aPrice['dedi']['300'];
                }
                
            }
        } elseif ($itype == 11) {
            $res['q'] = ($aVar['numlicense'] > $aVar['vps']) 
                    ? $aVar['numlicense'] 
                    : $aVar['vps'];
            if ($aVar['price_is_fixed'] == 1) {
                $price_unit = $aVar['price_for_fixed'];
            } else {
                if ($res['q'] <= 40) {
                    $price_unit = $this->aPrice['vps']['40'];
                } elseif ($res['q'] > 40 && $res['q'] < 300) {
                 	$price_unit = 0.75 + ((1000 - $res['q']) / 400); 
                } elseif ($res['q'] >= 300 ) {
                    $price_unit = $this->aPrice['vps']['300'];
                } 
            }
        }else{
            $res['q'] = ($aVar['numlicense'] > $aVar['min_quantity'])
                    ? $aVar['numlicense'] 
                    : $aVar['min_quantity'];
            if ($aVar['price_is_fixed'] == 1) {
                $price_unit = $aVar['price_for_fixed'];
            } else {
                if ($res['q'] < 100 ) {
                    $price_unit = $this->aPrice['noc']['20'];
                }elseif ( $res['q'] < 200) {
                    $price_unit = $this->aPrice['noc']['100'];
                } elseif ( $res['q'] < 300) {
                    $price_unit = $this->aPrice['noc']['200'];
                } elseif ($res['q'] < 400) {
                    $price_unit = $this->aPrice['noc']['300'];
                } elseif ($res['q'] < 500) {
                    $price_unit = $this->aPrice['noc']['400'];
                } elseif ($res['q'] < 600) {
                    $price_unit = $this->aPrice['noc']['500'];
                } else{
                    $price_unit = $this->aPrice['noc']['600'];
                }   

            }
        }
        $res['p'] =  $res['q']  * $price_unit;
        echo  print_r($res,true);
        return $res;
    }
    
    //=== api เวลา add license บางทีเรียกไปที่ url เดิม ทำให้ exp เป็ฯวันที่ 14 เดือนหน้า แล้วค่า exp eff ก็ไม่ update
    //TODO: ย้าย table แล้วจะลบออก
    public function call_daily()
    {
       	$message 	= '';
      	$db         = hbm_db();
		$aGetAcc  	= $db->query("
		    SELECT 
		        id
		    FROM 
		        hb_accounts
		    WHERE 
		        product_id in (77,78,79,80)
		        and status='Active'
		    ", array())->fetchall();
		if (!$aGetAcc) return 'NO DATA';
		date_default_timezone_set('UTC');
		$startDate = time();
		
		$exp 		= mktime(23,59,59,date('n', $startDate)+1,7,date('y', $startDate)); 
		$eff 		= mktime(23,59,59,date('n', $startDate)+1,10,date('y', $startDate)); 
        foreach ($aGetAcc as $key => $adtl) {
            $sqlsb = "
            update 
                rvsitebuilder_license 
            SET
                expire=:exp,effective_expiry=:eff where hb_acc=:adtlid";
            $res = $db->query($sqlsb, array(':exp' => $exp,':eff' => $eff,':adtlid' => $adtl['id']));
        }
        $message = 'OK';
        echo $message;
        return $message;
    }

    private function _updateHostbill($aData)
    {
        $db         = hbm_db();
        $res        = $db->query("
            UPDATE
                 hb_accounts acc, hb_config_items_cat hc, hb_config2accounts hca
            SET
                hca.qty=:qty,
                hca.data=:qty,
                acc.firstpayment = :firstprice,
                acc.total = :totalprice
               
            WHERE
                acc.product_id = hc.product_id
                AND hc.id = hca.config_cat
                AND acc.id  = hca.account_id
                AND hc.variable = 'quantity'
                AND acc.id =:accid
                AND acc.product_id =:product_id
            ",array(
                ':qty' => $aData['qty'],
                ':firstprice' => $aData['firstprice'],
                ':totalprice' => $aData['totalprice'],
                ':accid' => $aData['accid'],
                ':product_id' => $aData['product_id'],
            ));
         if ($res){
            return 'update acc_id='.$aData['accid'];
         } else {
            return 'Error update acc_id='.$aData['accid'];
         } 
         return $res;

    }

    
    private function sendMailToMgr($aParam)
    {
        $frmMail = 'admin@rvglobalsoft.com';
        $subject    = 'test';
        $message    = "\n" . 'test' ;
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: ' . $frmMail . "\r\n" .
                'Reply-To: ' . $frmMail . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        if (@mail('paisarn@netway.co.th', $subject, $message, $header)) {
            return true;
        } else {
            return false;
        }
    }
    
}
