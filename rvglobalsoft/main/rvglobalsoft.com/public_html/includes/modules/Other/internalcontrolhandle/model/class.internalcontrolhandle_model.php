<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class internalcontrolhandle_model {

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
    
    public function getNextError ($date, $limit = 1)
    {
        $datePast   = date('Y-m-d H:i:s', strtotime('-1 hour'));
        
        $result     = $this->db->query("
            SELECT el.*, elh.admin_email
            FROM hb_error_log el
                LEFT JOIN hb_error_log_handle elh
                ON elh.date = el.date
            WHERE el.date > '{$date}'
                AND el.date < '{$datePast}'
            ORDER BY el.date ASC
            LIMIT {$limit}
            ")->fetchAll();
        
        return $result;
    }
    
    public function deleteError ($data)
    {
        $result     = $this->db->query("
            DELETE FROM hb_error_log WHERE `date` < '{$data}'
            ");
        $result     = $this->db->query("
            DELETE FROM hb_error_log_handle WHERE `date` < '{$data}'
            ");
        
    }
    
}
