<?php
class rv_partner_sitebuilder extends OtherModule {
    
    protected $modname = 'Cron Update Partner Rvsitebuilder';
    protected $description = '
    Cron Update Partner Rvsitebuilder<br />
    - volume pricing<br />
    - quantity
    ';
    // Configuration

    public function getLicenseSB($clientid){
             $db         = hbm_db();
             $sql_get_product = "
              SELECT 
                *
              FROM
                hb_accounts
              WHERE 
                client_id =:clientid
                AND product_id in (77,78,79,80,159)
             ";
           //  echo $clientid;
            // echo $sql_get_product;
            $aData = $db->query($sql_get_product,array(
            		':clientid' => $clientid
            		))->fetchall();
            $aAccid = array();
            foreach ($aData as $k => $v) {
                array_push($aAccid, $v['id']);
            }

            if (count($aAccid) > 0){ 
                $aListLicense = $this->getListLicense($aAccid, $clientid);
            }
        return $aListLicense;
    
    }

    public function getListLicense($aAcc,$clientid)
    {
        $aAcc 	= join(',', $aAcc);
        $db		= hbm_db();
       
        $sql = "
            SELECT 
                u.license_id,u.primary_ip,u.secondary_ip, FROM_UNIXTIME(u.expire,'%Y-%m-%d') as exp,u.active,u.license_type,u.hb_acc, a.product_id
            FROM 
                rvsitebuilder_license u,
                hb_accounts a
            WHERE 
               u.hb_acc in (" . $aAcc . ")
               AND a.id = u.hb_acc
        ";
        $aData = $db->query($sql,array())->fetchall();
        return $aData;
    }

}



























