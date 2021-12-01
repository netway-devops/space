<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class clienthandle_model {

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
    
    public function getClientById ($clientId)
    {
        $result         = $this->db->query("
            SELECT
                ca.email, ca.status, ca.group_id, cd.*
            FROM
                hb_client_access ca,
                hb_client_details cd
            WHERE
                ca.id = :id
                AND ca.id = cd.id
            ", array(
                ':id'   => $clientId
            ))->fetch();
        
        $result     = count($result) ? $result : array();

        return $result;
    }
    
    public function getCustomField ($code)
    {
        $result         = $this->db->query("
            SELECT
                cf.*
            FROM
                hb_client_fields cf
            WHERE
                cf.code = :code
            ", array(
                ':code'   => $code
            ))->fetch();
        
        $result     = count($result) ? $result : array();

        return $result;
    }
    
}