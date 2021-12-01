<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class paypalhandle_model {

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
    
    public function getTransactionById ($id)
    {
        $datePast   = date('Y-m-d H:i:s', strtotime('-1 hour'));
        
        $result     = $this->db->query("
            SELECT *
            FROM hb_paypal_transaction 
            WHERE transaction_id = '{$id}'
            ")->fetch();
        $result     = isset($result['transaction_id']) ? $result :array();
        
        return $result;
    }
    
    public function getHostbillTransactionId ($id)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_transactions 
            WHERE trans_id = '{$id}'
            ")->fetch();
        $result     = isset($result['id']) ? $result :array();
        
        return $result;
    }
    
    public function getHostbillClientCreditLogId ($id)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_client_credit_log 
            WHERE transaction_id = '{$id}'
            ")->fetch();
        $result     = isset($result['id']) ? $result :array();
        
        return $result;
    }
    
    public function skipTransactionById ($id)
    {
        $this->db->query("
            UPDATE hb_paypal_transaction
            SET is_skip_verify = 1
            WHERE transaction_id = '{$id}'
            ");
    }
    
    public function addTransaction ($data)
    {
        
        $this->db->query("
            INSERT INTO hb_paypal_transaction (
            transaction_id, paypal_account_id, paypal_reference_id, paypal_reference_id_type,
            transaction_event_code, transaction_initiation_date, transaction_updated_date,
            transaction_amount, fee_amount, transaction_status, transaction_subject,
            paypal_account
            ) VALUES (
            :transaction_id, :paypal_account_id, :paypal_reference_id, :paypal_reference_id_type,
            :transaction_event_code, :transaction_initiation_date, :transaction_updated_date,
            :transaction_amount, :fee_amount, :transaction_status, :transaction_subject,
            :paypal_account
            )
            ", array(
                ':transaction_id'       => ($data['transaction_id']?$data['transaction_id']:''),
                ':paypal_account_id'    => ($data['paypal_account_id']?$data['paypal_account_id']:''),
                ':paypal_reference_id'  => ($data['paypal_reference_id']?$data['paypal_reference_id']:''),
                ':paypal_reference_id_type' => ($data['paypal_reference_id_type']?$data['paypal_reference_id_type']:''),
                ':transaction_event_code'   => ($data['transaction_event_code']?$data['transaction_event_code']:''),
                ':transaction_initiation_date'  => ($data['transaction_initiation_date']?$data['transaction_initiation_date']:''),
                ':transaction_updated_date'     => ($data['transaction_updated_date']?$data['transaction_updated_date']:''),
                ':transaction_amount'   => ($data['transaction_amount']['value']?$data['transaction_amount']['value']:''),
                ':fee_amount'           => ($data['fee_amount']['value']?$data['fee_amount']['value']:''),
                ':transaction_status'   => ($data['transaction_status']?$data['transaction_status']:''),
                ':transaction_subject'  => ($data['transaction_subject']?$data['transaction_subject']:''),
                ':paypal_account'       => ($data['paypal_account']?$data['paypal_account']:''),
            ));
        
    }
    
    public function updateTransaction ($transactionId, $data)
    {
        
        $this->db->query("
            UPDATE 
                hb_paypal_transaction
            SET
                paypal_account_id = :paypal_account_id,
                paypal_reference_id = :paypal_reference_id,
                paypal_reference_id_type = :paypal_reference_id_type,
                transaction_event_code = :transaction_event_code,
                transaction_initiation_date = :transaction_initiation_date,
                transaction_updated_date = :transaction_updated_date,
                transaction_amount = :transaction_amount,
                fee_amount = :fee_amount,
                transaction_status = :transaction_status,
                transaction_subject = :transaction_subject,
                paypal_account = :paypal_account
            WHERE 
                transaction_id = :transaction_id
            ", array(
                ':transaction_id'       => $transactionId,
                ':paypal_account_id'    => ($data['paypal_account_id']?$data['paypal_account_id']:''),
                ':paypal_reference_id'  => ($data['paypal_reference_id']?$data['paypal_reference_id']:''),
                ':paypal_reference_id_type' => ($data['paypal_reference_id_type']?$data['paypal_reference_id_type']:''),
                ':transaction_event_code'   => ($data['transaction_event_code']?$data['transaction_event_code']:''),
                ':transaction_initiation_date'  => ($data['transaction_initiation_date']?$data['transaction_initiation_date']:''),
                ':transaction_updated_date'     => ($data['transaction_updated_date']?$data['transaction_updated_date']:''),
                ':transaction_amount'   => ($data['transaction_amount']['value']?$data['transaction_amount']['value']:''),
                ':fee_amount'           => ($data['fee_amount']['value']?$data['fee_amount']['value']:''),
                ':transaction_status'   => ($data['transaction_status']?$data['transaction_status']:''),
                ':transaction_subject'  => ($data['transaction_subject']?$data['transaction_subject']:''),
                ':paypal_account'       => ($data['paypal_account']?$data['paypal_account']:''),
            ));
        
    }
    
    public function updateTransactionInfo ($transactionId, $data)
    {
        $data   = serialize($data);

        $this->db->query("
            UPDATE 
                hb_paypal_transaction
            SET
                transaction_info = :transaction_info
            WHERE 
                transaction_id = :transaction_id
            ", array(
                ':transaction_id'       => $transactionId,
                ':transaction_info'    => $data,
            ));
        
    }
    
    public function getPendingSync_subscr_sb_payment ()
    {
        $result     = $this->db->query("
            SELECT gl.*
            FROM hb_gateway_log gl
                LEFT JOIN hb_gateway_log_ext gle
                    ON gle.id = gl.id
            WHERE ( gle.id IS NULL
                OR gle.is_subscr_sb_payment_sync = 0
                )
            ORDER BY gl.id DESC
            LIMIT 10
            ")->fetchAll();
        
        $result     = count($result) ? $result :array();

        return $result;
    }
    
    public function setPendingSync_subscr_sb_payment ($id, $is_subscr_sb_payment)
    {
        $result     = $this->db->query("
            SELECT *
            FROM hb_gateway_log_ext 
            WHERE id = '{$id}'
            ")->fetch();
        if (! isset($result['id'])) {
            $this->db->query("
                INSERT INTO hb_gateway_log_ext (
                    id
                ) VALUES (
                    '{$id}'
                )
                ");
        }

        $this->db->query("
            UPDATE hb_gateway_log_ext
            SET is_subscr_sb_payment_sync = 1,
                is_subscr_sb_payment = '{$is_subscr_sb_payment}'
            WHERE id = '{$id}'
            ");
    }
    
    public function getMissingTransaction ()
    {
        $result     = $this->db->query("
            SELECT pt.*
            FROM hb_paypal_transaction pt
                LEFT JOIN hb_transactions t
                    ON t.trans_id = pt.transaction_id
            WHERE t.trans_id IS NULL
                AND pt.transaction_initiation_date > DATE_SUB(NOW(), INTERVAL 10 DAY) 
            LIMIT 1
            ")->fetchAll();
        
        $result     = count($result) ? $result :array();

        return $result;
    }
    
    public function addMissingTransaction ($data)
    {
        
        $this->db->query("
            INSERT INTO hb_transactions (
                invoice_id, module, `date`, `description`,
                `in`, `fee`, trans_id,
                is_netway, `type`, `status`
            ) VALUES (
                :invoice_id, :module, :date, :description,
                :in, :fee, :trans_id,
                :is_netway, 'invoice', :status
            )
            ", array(
                ':invoice_id'   => ($data['invoice_id'] ? $data['invoice_id']:''),
                ':module'       => ($data['module'] ? $data['module']:''),
                ':date'         => ($data['date'] ? $data['date']:''),
                ':description'  => ($data['description'] ? $data['description']:''),
                ':in'           => ($data['in'] ? $data['in']:''),
                ':fee'          => ($data['fee'] ? $data['fee']:''),
                ':trans_id'     => ($data['trans_id'] ? $data['trans_id']:''),
                ':is_netway'    => ($data['is_netway'] ? $data['is_netway']:''),
                ':status'       => 'Processing',
            ));
    }
    
    public function setPaypalTransaction ($transactionId, $data)
    {
        if (! $transactionId || ! isset($data['field'])) {
            return true;
        }

        $this->db->query("
            UPDATE 
                hb_paypal_transaction
            SET
                ". $data['field'] ." = '". $data['value'] ."'
            WHERE 
                transaction_id = :transaction_id
            ", array(
                ':transaction_id'   => $transactionId
            ));
        
    }
    
    public function getPendingVerification ()
    {
        $result     = $this->db->query("
            SELECT 
                pt.transaction_id, 
                pt.transaction_initiation_date
            FROM 
                hb_paypal_transaction pt
            WHERE 
                pt.transaction_initiation_date >= CURDATE() - INTERVAL 6 MONTH
                AND pt.is_skip_verify = 0
                AND pt.client_credit_log_id = 0
                AND pt.transaction_log_id = 0
            ORDER BY  pt.transaction_initiation_date DESC
            LIMIT 10
            ")->fetchAll();
        
        $result     = count($result) ? $result :array();

        return $result;
    }

    public function findLatestTerminateAccount ()
    {
        $result     = $this->db->query("
            SELECT al.*
            FROM hb_account_logs al
            WHERE al.event = 'AccountTerminate'
                AND al.date > DATE_SUB(now(), INTERVAL 3 HOUR)
            ")->fetchAll();
        
        $result     = count($result) ? $result :array();

        return $result;
    }

    public function findSuspendSubscriptionLog ($accountId)
    {
        $result     = $this->db->query("
            SELECT al.*
            FROM hb_account_logs al
            WHERE al.event = 'SuspendPaypalSubscription'
                AND al.account_id = :account_id
            ", array(
                ':account_id'   => $accountId
            ))->fetch();
        
        $result     = count($result) ? $result :array();

        return $result;
    }

    public function findLatestPaidInvoiceFromAccountId ($accountId)
    {
        $result     = $this->db->query("
            SELECT i.id, t.id AS tid, t.trans_id
            FROM hb_invoice_items ii,
                hb_invoices i,
                hb_transactions t
            WHERE ii.type = 'Hosting'
                AND ii.item_id = :item_id
                AND ii.invoice_id = i.id
                AND i.status = 'Paid'
                AND i.id = t.invoice_id
            ORDER BY i.duedate DESC 
            LIMIT 1
            ", array(
                ':item_id'  => $accountId
            ))->fetch();
        
        $result     = count($result) ? $result :array();

        $invoiceId      = (isset($result['id']) && $result['id']) ? $result['id'] : 0;
        $tid            = (isset($result['tid']) && $result['tid']) ? $result['tid'] : 0;
        $transId        = (isset($result['trans_id']) && $result['trans_id']) ? $result['trans_id'] : '';

        $result     = $this->db->query("
            SELECT pt.*
            FROM hb_paypal_transaction pt
            WHERE pt.transaction_id = :transaction_id
                AND pt.transaction_id !=  ''
            ", array(
                ':transaction_id'   => $transId
            ))->fetch();
        
        
        $referenceId    = (isset($result['paypal_reference_id']) && $result['paypal_reference_id']) ? $result['paypal_reference_id'] : '';
        $paypalAccount    = (isset($result['paypal_account']) && $result['paypal_account']) ? $result['paypal_account'] : '';
        
        $result['id']   = $invoiceId;
        $result['tid']  = $tid;
        $result['trans_id']     = $transId;
        $result['paypal_reference_id']  = $referenceId;
        $result['paypal_account']       = $paypalAccount;

        return $result;
    }
    
    public function addPendingPaypalSuspendSubscriptionLog ($accountId, $aData)
    {
        $change     = array(
            'data'          => array(
                array( 'name'  => 'invoice_id', 'from'  => '', 'to' => $aData['id'] ),
                array( 'name'  => 'tid', 'from'  => '', 'to' => $aData['tid'] ),
                array( 'name'  => 'trans_id', 'from'  => '', 'to' => $aData['trans_id'] ),
                array( 'name'  => 'paypal_reference_id', 'from'  => '', 'to' => $aData['paypal_reference_id'] ),
                array( 'name'  => 'paypal_account', 'from'  => '', 'to' => $aData['paypal_account'] ),
            ),
            'serialized'    => 1,
        );
        $change     = serialize($change);

        $this->db->query("
            INSERT INTO hb_account_logs (
                `date`, account_id, admin_login, module, `action`, `change`, result, event
            ) VALUES (
                NOW(), :account_id, 'Automation', 'paypalhandle', 'Suspend Paypal Subscription', :change, '0', 'SuspendPaypalSubscription'
            )
            ", array(
                ':account_id'   => $accountId,
                ':change'       => $change,
            ));
    }
    
    public function suspendsubscriptionChecked ($accountLogId)
    {
        $this->db->query("
            UPDATE  hb_account_logs
            SET result = '1'
            WHERE 
                id = :id
            ", array(
                ':id'   => $accountLogId
            ));
        
    }
    

    
}
