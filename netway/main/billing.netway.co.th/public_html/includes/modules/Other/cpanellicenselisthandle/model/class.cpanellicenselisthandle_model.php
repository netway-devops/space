<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class cpanellicenselisthandle_model {

    private static  $instance;
    private $db;
     
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    private function __construct () 
    {
        $this->db       = hbm_db();
        
    }

    public function listCpanelOSServerID ()
    {
        $result     = $this->db->query("
            SELECT DISTINCT(a.AccountId) AS ID, a.AccountId, a.Domain, a.Product, a.Item, a.ItemGroup, a.ipid,
                INET6_NTOA(ipam.ipaddress) AS IPAM_IP, b.Data AS Hostbill_IP
            FROM
                (
                SELECT a.id AS AccountId, a.domain AS Domain, p.name AS Product,
                    ci.name AS Item, cic.name AS ItemGroup,
                    ia.ip_id AS ipid
                FROM hb_accounts a
                    LEFT JOIN hb_ipam_assign ia
                        ON ia.item_type = 'account'
                        AND ia.ip_type = 'ip'
                        AND ia.item_id = a.id,
                    hb_products p,
                    hb_config2accounts c2a,
                    hb_config_items ci,
                    hb_config_items_cat cic
                WHERE a.id = c2a.account_id
                    AND a.status IN ('Active','Suspended')
                    AND a.product_id = p.id
                    AND c2a.config_id = ci.id
                    AND c2a.config_cat = cic.id
                    AND (cic.variable = 'os' OR cic.variable = 'cp')
                    AND ci.category_id = cic.id
                    AND ci.name LIKE '%cpanel%'
                ) a
                LEFT JOIN hb_ipam ipam
                    ON ipam.id = a.ipid
                LEFT JOIN 
                    (
                    SELECT a.id AS AccountId, c2a.data AS Data
                    FROM hb_accounts a,
                        hb_config2accounts c2a,
                        hb_config_items_cat cic
                    WHERE a.id = c2a.account_id
                        AND a.status IN ('Active','Suspended')
                        AND c2a.config_cat = cic.id
                        AND (cic.variable = 'ip')
                    ) b
                    ON b.AccountId = a.AccountId
            UNION (
                SELECT DISTINCT(a.id) AS ID, a.id AS AccountId, a.domain AS Domain, p.name AS Product,
                    ci.name AS Item, cic.name AS ItemGroup,
                    '-' AS ipid,
                    '-' AS IPAM_IP, c2a.data AS Hostbill_IP
                FROM hb_accounts a,
                    hb_products p,
                    hb_config2accounts c2a,
                    hb_config_items ci,
                    hb_config_items_cat cic
                WHERE a.server_id = 356
                    AND a.status IN ('Active','Suspended')
                    AND a.product_id = p.id
                    AND a.id = c2a.account_id
                    AND c2a.config_id = ci.id
                    AND c2a.config_cat = cic.id
                    AND (cic.variable = 'ip')
            )
            ")->fetchAll();
        
        $result = count($result) ? $result : array();

        return $result;
    }


    

}
