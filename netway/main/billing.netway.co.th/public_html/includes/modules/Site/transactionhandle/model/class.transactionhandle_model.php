<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class transactionhandle_model {

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
    
    public function updateLatestTransactionDescription ($notic)
    {
        $this->db->query("
            UPDATE hb_transactions
            SET description = CONCAT(:notic, description)
            ORDER BY id DESC
            LIMIT 1
            ", array(
                ':notic'            => $notic
            ));
    }
    
    public function updateLatestTransactionCodeMessage ($pre, $feeCode, $feeMessage)
    {
        $this->db->query("
            UPDATE hb_transactions
            SET 
                `fee` = {$pre}`fee`,
                fee_code    = :feeCode,
                fee_message = :feeMessage
            ORDER BY id DESC
            LIMIT 1
            ", array(
                ':feeCode'            => $feeCode,
                ':feeMessage'         => $feeMessage,
            ));
    }
    
    public function updateLatestTransactionId ($transId)
    {
    }
    
    
}
