<?php
class ipproductlicense_controller extends HBController {
    
    public function getIP ($request)
    {
        
        $db         = hbm_db();
        
        $expire         = '';
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        if ( ! $accountId) {
            return false;
        }
       
        $aChkProductLicense = $db->query("
                        SELECT a.id
                        FROM 
                            hb_accounts a,
                            hb_products p,
                            hb_categories c
                        WHERE 
                            a.product_id = p.id
                            AND p.category_id = c.id
                            AND a.id = :acc_id
                            AND (
                            	c.name like '%Licenses%'
                            	OR c.name like '%Free%'
                            )
                        ORDER BY a.id DESC
                        ", array(
                            ':acc_id'   => $accountId
                        ))->fetch();
        if (isset($aChkProductLicense['id'])) {
            $aGetIp       = $db->query("
                        SELECT ac.data
                        FROM 
                            hb_config2accounts ac,
                            hb_config_items_cat f
                        WHERE 
                            ac.config_cat = f.id
                            AND ac.account_id = :acc_id
                        ORDER BY ac.account_id DESC
                        ", array(
                           ':acc_id'   => $accountId
                        ))->fetch();
            return array(true, array(
                'ip'    => $aGetIp['data']
            ));
        } else {
            return array(false, array(
                'ip'    => ''
            ));
        
        }
        
       
    }
   
    
    
}
