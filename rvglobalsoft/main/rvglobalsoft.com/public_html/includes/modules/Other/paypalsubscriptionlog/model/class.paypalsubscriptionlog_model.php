<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class paypalsubscriptionlog_model {

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
        $this->db   = hbm_db();
        
    }

    public function listPendingGatewayLog ($id)
    {
        $result    =   $this->db->query("
            SELECT * 
            FROM `hb_gateway_log` 
            WHERE `output` LIKE '%subscr_payment%'
                AND module = 11
                AND id > :id
            ORDER BY id ASC
            LIMIT 10
            " , array(
                ':id'   =>  $id
            ))->fetchAll();
            
        $result     = count($result) ? $result : array();

        return $result;
    }
    
    public function getSubscriptionlogByGatewayId ($id)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_paypal_subscription_log
            WHERE gateway_log_id = :id
            ", array(
                ':id'   => $id
            ))->fetch();
        
        $result     = isset($result['id']) ? $result : array();

        return $result;
    }

    public function listPendingCreditLog ()
    {
        $result    =   $this->db->query("
            SELECT * 
            FROM hb_client_credit_log
            WHERE 1
            ORDER BY id DESC
            LIMIT 5
            ")->fetchAll();
            
        $result     = count($result) ? $result : array();

        return $result;
    }
    
    public function updateSubscriptionByCreditLog ($data)
    {
        $logId      = $data['id'];
        $transactionId  = $data['transaction_id'];

        $result     = $this->db->query("
            SELECT *
            FROM hb_paypal_subscription_log
            WHERE transaction_id = :transaction_id
            ", array(
                ':transaction_id'   => $transactionId
            ))->fetch();
        
        $id         = isset($result['id']) ? $result['id'] : 0;
        if (! $id) {
            return false;
        }

        $this->db->query("
            UPDATE hb_paypal_subscription_log
            SET client_credit_log_id = :client_credit_log_id
            WHERE id = :id
            ", array(
                ':client_credit_log_id'     => $logId,
                ':id'   => $id
            ));
        
        return true;
    }

    public function listPendingTransactionLog ()
    {
        $result    =   $this->db->query("
            SELECT * 
            FROM hb_transactions
            WHERE 1
            ORDER BY id DESC
            LIMIT 5
            ")->fetchAll();
            
        $result     = count($result) ? $result : array();

        return $result;
    }
    
    public function updateSubscriptionByTransactionLog ($data)
    {
        $logId      = $data['id'];
        $transactionId  = $data['trans_id'];

        $result     = $this->db->query("
            SELECT *
            FROM hb_paypal_subscription_log
            WHERE transaction_id = :transaction_id
            ", array(
                ':transaction_id'   => $transactionId
            ))->fetch();
        
        $id         = isset($result['id']) ? $result['id'] : 0;
        if (! $id) {
            return false;
        }

        $this->db->query("
            UPDATE hb_paypal_subscription_log
            SET transaction_log_id = :transaction_log_id
            WHERE id = :id
            ", array(
                ':transaction_log_id'   => $logId,
                ':id'   => $id
            ));
        
        return true;
    }
    
    public function getPaypalTransactionById ($id)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_transactions
            WHERE trans_id = :trans_id
                AND module = '11'
            ", array(
                ':trans_id'   => $id
            ))->fetch();
        
        $result     = isset($result['id']) ? $result : array();

        return $result;
    }
    
    public function getPaypalCreditLogById ($id)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_client_credit_log
            WHERE transaction_id = :transaction_id
            ", array(
                ':transaction_id'   => $id
            ))->fetch();
        
        $result     = isset($result['id']) ? $result : array();

        return $result;
    }
    
    public function updateSubscriptionlog ($gatewayLogId, $data)
    {
        
        $this->db->query("
            UPDATE hb_paypal_subscription_log
            SET `date` = :date, 
                gateway_log_id = :gateway_log_id, 
                transaction_id = :transaction_id, 
                email = :email, 
                amount = :amount, 
                invoice_id = :invoice_id, 
                invoice_hb = :invoice_hb, 
                credit_log_hb = :credit_log_hb, 
                sync_date = NOW()
            WHERE gateway_log_id = :gateway_log_id
            " , array(
                ':date'             =>  $data['date'],
                ':gateway_log_id'   =>  $data['gateway_log_id'],
                ':transaction_id'   =>  $data['transaction_id'],
                ':email'            =>  $data['email'],
                ':amount'           =>  $data['amount'],
                ':invoice_id'       => $data['invoice_id'],
                ':invoice_hb'       => $data['invoice_hb'],
                ':credit_log_hb'    => $data['credit_log_hb'],
                ':gateway_log_id'   => $gatewayLogId
            ));
        
    }

    public function addSubscriptionlog ($data)
    {
        
        $this->db->query("
            INSERT INTO hb_paypal_subscription_log (
                id, `date`, gateway_log_id, transaction_id, email, amount, invoice_id, sync_date
            ) VALUES (
                null, :date, :gateway_log_id, :transaction_id, :email, :amount, :invoice_id, NOW()
            )
            " , array(
                ':date'             =>  $data['date'],
                ':gateway_log_id'   =>  $data['gateway_log_id'],
                ':transaction_id'   =>  $data['transaction_id'],
                ':email'            =>  $data['email'],
                ':amount'           =>  $data['amount'],
                ':invoice_id'       =>  $data['invoice_id'],
            ));
        
    }
    
}
