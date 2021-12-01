<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class dnssechandle_model {

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
    
    public function getAccountById ($accountId) 
    {
        $result         = $this->db->query("
            SELECT a.*
            FROM hb_accounts a
            WHERE a.id = :id
            ", array(
                ':id'   => $accountId
            ))->fetch();
        
        $result         = isset($result['id']) ? $result : array();
        
        return $result;
    }
    
    public function getDomainById ($domainId) 
    {
        $result         = $this->db->query("
            SELECT d.*
            FROM hb_domains d
            WHERE d.id = :id
            ", array(
                ':id'   => $domainId
            ))->fetch();
        
        $result         = isset($result['id']) ? $result : array();
        
        return $result;
    }
    
    public function updateAccountExtraDetail ($accountId, $data) 
    {
        $data   = serialize($data);

        $this->db->query("
            UPDATE hb_accounts
            SET extra_details = :extra_details
            WHERE id = :id
            ", array(
                ':extra_details'    => $data,
                ':id'   => $accountId
            ));
        
    }
    
    public function getProductDNSSEC () 
    {
        $result         = $this->db->query("
            SELECT p.*
            FROM hb_products p
            WHERE p.name LIKE '%dnssec%'
            ")->fetch();
        
        $result         = isset($result['id']) ? $result : array();
        
        return $result;
    }
    
    public function getDSNSECAccountByDomain ($domain, $clientId, $productId) 
    {
        $result         = $this->db->query("
            SELECT a.*
            FROM hb_accounts a
            WHERE a.domain = '{$domain}'
                AND a.client_id = '{$clientId}'
                AND a.product_id = '{$productId}'
            ")->fetch();
        
        $result         = isset($result['id']) ? $result : array();
        
        return $result;
    }
    
    public function getCategoryByProductId ($productId) 
    {
        $result         = $this->db->query("
            SELECT c.*
            FROM hb_categories c,
                hb_products p
            WHERE p.id = '{$productId}'
                AND p.category_id = c.id
            ")->fetch();
        
        $result         = isset($result['id']) ? $result : array();
        
        return $result;
    }

    
}
