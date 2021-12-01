<?php
class rv_partner_skin extends OtherModule {
    
    protected $modname = 'Cron Update Partner Rvskin';
    protected $description = '
    Cron Update Partner Rvskin<br />
    - volume pricing<br />
    - quantity
    ';
    
    public function getLicenseSK($clientid)
    {
       
         $db         = hbm_db();
         $sql_get_product = "
          SELECT 
            *
          FROM
            hb_accounts
          WHERE 
            client_id =:clientid
            AND product_id in (73,74,75,76)
         ";
         //echo $sql_get_product;
        $aData = $db->query($sql_get_product,array(
        	':clientid' => $clientid
        ))->fetchall();
        $aAccid = array();
        foreach ($aData as $k=>$v){
            array_push($aAccid,$v['id']);
        }
        if (count($aAccid) > 0){ 
        	$aListLicense = $this->getListLicense($aAccid,$clientid);
        }
    	return $aListLicense;
    }
	
    public function getListLicense($aAcc,$clientid)
    {
        $aAcc 		= join(',',$aAcc);
        $db         = hbm_db();
        
		$sql = "
            SELECT 
                u.license_id,u.main_ip,u.second_ip, FROM_UNIXTIME(u.expire,'%Y-%m-%d') as exp,u.active,u.license_type,u.hb_acc   
            FROM 
                rvskin_license u
            WHERE 
                u.hb_acc in (".$aAcc.")
        ";
         
        $aData = $db->query($sql,array())->fetchall();
        return $aData;
	}

}



























