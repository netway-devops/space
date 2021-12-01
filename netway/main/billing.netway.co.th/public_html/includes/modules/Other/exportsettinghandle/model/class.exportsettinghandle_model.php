<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class exportsettinghandle_model {

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
    
    public function getAllProduct ()
    {
        $result     = $this->db->query("
            SELECT p.id, CONCAT(c.name, ' ', p.name) AS name
            FROM hb_products p,
                hb_categories c
            WHERE p.category_id = c.id
            ORDER BY c.sort_order ASC, p.sort_order
            ")->fetchAll();
        
        return $result;
    }
    
}
