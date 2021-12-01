
<?php

class accountcomponentpricehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * 
     * @return string
     */
    public function call_Hourly()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        require_once(APPDIR . 'class.config.custom.php');
        $nwAccountComponentPrice        = ConfigCustom::singleton()->getValue('nwAccountComponentPrice');
        
        $result     = $db->query("
            SELECT
                a.*
            FROM
                hb_accounts a
            WHERE
                a.id > :accountId
                AND a.billingcycle IN (
                    'Monthly','Quarterly','Semi-Annually','Annually',
                    'Biennially','Triennially'
                    )
            ORDER BY a.id ASC
            LIMIT 0, 100
            ", array(
                ':accountId'    => $nwAccountComponentPrice
            ))->fetchAll();
        
        if (! count($result)) {
            ConfigCustom::singleton()->setValue('nwAccountComponentPrice', 0);
            return $message;
        }
        
        $aAccounts  = $result;
        
        foreach ($aAccounts as $aAccount) {
            $accountId      = $aAccount['id'];
            $productId      = $aAccount['product_id'];
            $total          = $aAccount['total'];
            $nwAccountComponentPrice    = $accountId;
            $componentPrice = 0;
            $billingCycle   = $aAccount['billingcycle'];
            
            $result     = $db->query("
                SELECT
                    c2a.*,
                    c.m, c.q, c.s, c.a, c.b, c.t
                FROM
                    hb_config2accounts c2a,
                    hb_common c
                WHERE
                    c2a.config_id = c.id
                    AND c.rel = 'Config'
                    AND c2a.rel_type = 'Hosting'
                    AND c2a.account_id = :accountId
                ", array(
                    ':accountId'    => $accountId
                ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr) {
                    $prefix         = strtolower(substr($billingCycle,0,1));
                    $componentPrice = $componentPrice + ($arr['qty'] * $arr[$prefix]);
                }
            }
            
            //[TODO] สำหรับ SSL ปัญหาคือเขาซื้อ 4 ปี แต่ระบบ billing รองรับแค่ 3 ปี
            if ($billingCycle == 'Triennially') {
                $result     = $db->query("
                    SELECT
                        c.*
                    FROM
                        hb_products p,
                        hb_common c
                    WHERE
                        p.id = :productId
                        AND p.category_id = 23
                        AND c.id = p.id
                        AND c.rel = 'Product'
                        AND c.paytype = 'Regular'
                    ", array(
                        ':productId'    => $productId
                    ))->fetch();
                if (isset($result['id'])) {
                    $exPrice        = $total - $result['t'];
                    if ($exPrice > $result['a']) {
                        $componentPrice     = $exPrice;
                    }
                }
            }
            
            $db->query("
                UPDATE
                    hb_accounts
                SET
                    component_price = :componentPrice
                WHERE
                    id = :accountId
                ", array(
                    ':componentPrice'   => $componentPrice,
                    ':accountId'        => $accountId
                ));
            
        }
        
        ConfigCustom::singleton()->setValue('nwAccountComponentPrice', $nwAccountComponentPrice);
        
        return $message;
    }
    
}


