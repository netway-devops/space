<?php
/****************************************************************
 * setup : เอาไว้ merge client id จาก hostbilll เข้า database ของ rvskin
 * 
 * 
 ***************************************************************/
class rv_partner_skin_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    public $connskin;
    public $aProductDedi = array(73,75);
    public $aProductVPS = array(74,76);
	public $test = false;
    public $aPrice = array(
        '73' => 1.5,
        '74' => 0.75,
        '75' => 2.5,
        '76' => 1.5
    );
    /**
     * Delete ticket ที่ถูก tag ว่าเป็น spam
     * @return string
     */

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
		'db43e07cb37e078c1274f03b8f3a9377'=>array('VPS'=>array('accid'=>'10977') ,''=>array('accid'=>'10978')),
		'7e047c62cde73592bbb6ef2849cfca0f'=>array('VPS'=>array('accid'=>'11079') ,''=>array('accid'=>'11080')),
		'01ce098d696ac63df8d8c2997931c2d7'=>array('VPS'=>array('accid'=>'11203') ,''=>array('accid'=>'11204')),
		'8490666ea178cfe94dbfd08ea1933600'=>array('VPS'=>array('accid'=>'11063') ,''=>array('accid'=>'11064')),
		'c5f65a620f404c3201335b47511df91f'=>array('VPS'=>array('accid'=>'10999') ,''=>array('accid'=>'11000')),
		'1c0f8b6baf1601b9703c097ede89e68d'=>array('VPS'=>array('accid'=>'11173') ,''=>array('accid'=>'11174')),
		'220ff7c61983923d7a3b162c7086f2e7'=>array('VPS'=>array('accid'=>'11167') ,''=>array('accid'=>'11168')),
		'f394c1e67980e86e561b709644cdb356'=>array('VPS'=>array('accid'=>'10941') ,''=>array('accid'=>'10942')),
		'338d8cf88f702071a1ee9c060966cdcd'=>array('VPS'=>array('accid'=>'11161') ,''=>array('accid'=>'11162')),
		'e01ab6fc0fcd2bc4f2662757e3adc415'=>array('VPS'=>array('accid'=>'10971') ,''=>array('accid'=>'10972')),
		'be9fb5610b55fa1fa75115ed6e63a6a9'=>array('VPS'=>array('accid'=>'11003') ,''=>array('accid'=>'11004')),
		'84f761d6547e29040d854042c24e2998'=>array('VPS'=>array('accid'=>'11061') ,''=>array('accid'=>'11062')),
		'edad19689b3fad7752a9cf0c970a20e8'=>array('VPS'=>array('accid'=>'10955') ,''=>array('accid'=>'10956')),
		'da179b9637aaf4c150c4fd51a25209bd'=>array('VPS'=>array('accid'=>'10981') ,''=>array('accid'=>'10982')),
		'7322f75cc7ba16db1799fd8d25dbcde4'=>array('VPS'=>array('accid'=>'11091') ,''=>array('accid'=>'11092')),
		'cd2960f439f5749a64b93a204d568254'=>array('VPS'=>array('accid'=>'10993') ,''=>array('accid'=>'10994')),
		'eecf882e56dc7c20fe25a879318a6154'=>array('VPS'=>array('accid'=>'10951') ,''=>array('accid'=>'10952')),
		'63767f72def97996e39427e7f0c466c5'=>array('VPS'=>array('accid'=>'11113') ,''=>array('accid'=>'11114')),
        );
        date_default_timezone_set('UTC');
		$startDate = time();
		
		$exp 	= mktime(23,59,59,date('n', $startDate)+1,7,date('y', $startDate)); 
		$eff = mktime(23,59,59,date('n', $startDate)+1,10,date('y', $startDate)); 
		 
		foreach($aAccountIsNull as $k => $v){
			foreach ($v as $k2=>$v2) {
				$sqlSetData = $db->query("
				UPDATE rvskin_license 
				SET hb_acc  = :accid, 
			    expire=:exp,
                effective_expiry=:eff
				WHERE user_id = :userid AND license_type = :licensetype AND  `hb_acc` IS NULL
				",array(
				':accid'=>$v2['accid'],
				':exp'=>$exp,
                ':eff'=>$eff,
                ':userid'=>$k,
                ':licensetype'=>$k2));
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
                    product_id in (73,74,75,76)
                    and status='Active'
                ", array())->fetchall();
               // var_dump($aGetAcc);
	    if (count($aGetAcc) == 0 )return 'NO DATA';
        foreach ($aGetAcc as $key => $adtl) {
            if (in_array($adtl['product_id'], $this->aProductDedi)) {
                $serverType = '';
            } else {
                $serverType = 'VPS';
            }
       
            $sql = "
                SELECT 
                    count( u.license_id ) AS numlicense
                FROM 
                    rvskin_license u
                WHERE 
                    u.license_type = :servertype
                    AND u.hb_acc = :editid
                GROUP BY 
                    u.hb_acc
                ";
               // echo $sql;
            $aData = $db->query($sql,array(
            		':servertype'	=> $serverType,
					':editid' 		=> $adtl['id']
					))->fetch();
            $aConf = array();
            if (isset($aData['numlicense'])) {
                $aConf['numlicense'] = $aData['numlicense'];
            } else {
                $aConf['numlicense'] = 0;
            }
            $params = array(
                'id' => $adtl['id']
            );
            $aConfig = $api->getAccountDetails($params);
            if (isset($aConfig['details']['custom'])) {
            	if (count($aConfig['details']['custom']) == 0 )return 'NO DATA';
                foreach($aConfig['details']['custom'] as $k => $v) {
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
            $aQtyPrice 				= $this->_getPriceQty($adtl['product_id'], $aConf);
            $aPost['qty'] 			= $aQtyPrice['q'];
            $aPost['firstprice'] 	= $aQtyPrice['p'];
            $aPost['totalprice'] 	= $aQtyPrice['p'];
            $aPost['accid'] 		= $adtl['id'];
            $aPost['product_id'] 	= $adtl['product_id'];
            $resUpdate = $this->_updateHostbill($aPost);
		}
        echo 'OK';
        return 'OK';
	}

    public function call_Monthly()
    {
        $message = '';
        $db         = hbm_db();
        $aGetAcc  = $db->query("
            SELECT 
                id
            FROM 
                hb_accounts
            WHERE 
                product_id in (73,74,75,76,88)
                and (billingcycle='Monthly' || billingcycle='Free')
                and status='Active'
            ", array())->fetchall();
		if (!$aGetAcc)return 'NO DATA';
		date_default_timezone_set('UTC');
		$startDate = time();
		
		$exp 	= mktime(23,59,59,date('n', $startDate)+1,7,date('y', $startDate)); 
		$eff = mktime(23,59,59,date('n', $startDate)+1,10,date('y', $startDate)); 
        foreach ($aGetAcc as $key => $adtl) {
            $sqlsk = "
            update 
                rvskin_license l
            SET
                l.expire=:exp,
                l.effective_expiry=:eff
            WHERE
               l.hb_acc=:adtlid";
            $res = $db->query($sqlsk,array(':exp'=>$exp,
                                           ':eff'=>$eff,
                                           ':adtlid'=>$adtl['id']));
		}
        $message = 'OK';
	    //echo 'OK';
        return $message;
    }
    
    /*
      public $aPrice = array(
        '73' => 1.5,
        '74' => 0.75,
        '75' => 2.5,
        '76' => 1.5
    );
     * */
    private function _getPriceQty($product_id,$aConfig)
    {
        $res['q'] = ($aConfig['numlicense'] > $aConfig['min_quantity']) 
                    ? $aConfig['numlicense'] 
                    : $aConfig['min_quantity'];
        if ($aConfig['price_is_fixed'] == 1) {
            $price_unit = $aConfig['price_for_fixed'];
        } else {
            $price_unit = $this->aPrice[$product_id];
        }
      //  echo '<br>q='.$res['q'].' * '.$price_unit;
        $res['p'] =  $res['q']  * $price_unit;
        return $res;
        
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
    }
    
    private function setup()
    {
        global $connskin;
        $sql = "
            SELECT
                s.user_snd,s.user_email,p.hostbill_client_id,p.*
            FROM
                partner_leased_price p, snd_user s
            where 
                p.user_id = s.user_snd
            order by
                p.user_id
        ";
        $aData = $connskin->query($sql)->fetchAll();
        $aList = array();
        foreach ($aData as $k=>$v) {
            $res = $this->getHostbillClientId($v['user_email']);
            $id = $v['user_snd'];
            if ($res) {
                $sql = "update partner_leased_price set hostbill_client_id=".$res." where user_id='" . $id ."'" ;
                $res_sqlup = $connskin->query($sql);
            }
           
        }
        return $aList;
    }
    
    private function getHostbillClientId($mail)
    {
        $db           = hbm_db();
        $getClientid  = $db->query("
            SELECT 
                id
            FROM 
                hb_client_access
            WHERE 
                email = :email
            ", array(
                ':email' => $mail
            ))->fetch();
        if (isset($getClientid['id']) && $getClientid['id'] != '') {
            return $getClientid['id']; 
        } else {
            return false;
        }

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
