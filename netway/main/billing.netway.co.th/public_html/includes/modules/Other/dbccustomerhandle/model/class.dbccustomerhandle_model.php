<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class dbccustomerhandle_model {

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
    
    public function getByClientId ($clientId)
    {
        $result     = $this->db->query("
            SELECT c.*
            FROM dbc_customer c
            WHERE c.client_id = '{$clientId}'
            ")->fetch();
        
        return $result;
    }
    
    public function getByCustomerNo ($customerNo)
    {
        $result     = $this->db->query("
            SELECT c.*
            FROM dbc_customer c
            WHERE c.customer_no = '{$customerNo}'
            ")->fetch();
        
        return $result;
    }
    
    public function update ($clientId, $data)
    {
        $this->db->query("
            UPDATE dbc_customer
            SET update_at = NOW()
            ". (isset($data['sync_at']) ? " , sync_at = '". $data['sync_at'] ."' " : "") ."
            ". (isset($data['sync_by']) ? " , sync_by = '". $data['sync_by'] ."' " : "") ."
            WHERE client_id = '{$clientId}'
            ");
    }
    
    public function connectCustomer ($data)
    {
        $clientId       = $data['clientId'];
        $customerNo     = $data['customerNo'];
        
        $result         = $this->getByClientId($clientId);
        if (isset($result['id'])) {
            return true;
        }
        
        $this->db->query("
            INSERT INTO dbc_customer (
            client_id, customer_no
            ) VALUES (
            :client_id, :customer_no
            )
            ", array(
                ':client_id'    => $clientId,
                ':customer_no'  => $customerNo,
            ));
        
        
        return true;
    }
    
}
