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
    
    public function listTransaction ($aTransaction) 
    {
        if (! count($aTransaction)) {
            return array();
        }
        
        $sql        = "
            SELECT t.*
            FROM hb_transactions t
            WHERE t.trans_id = 'x'
            ";
        
        foreach ($aTransaction as $v) {
            $v      = trim($v);
            $sql    .= "
                OR t.trans_id = '{$v}'
                ";
        }

        //echo '<pre>'.print_r($sql, true).'</pre>';
        $result     = $this->db->query($sql)->fetchAll();
        //echo '<pre>'.print_r($result, true).'</pre>';

        $aData      = array();
        if (count($result)) {
            foreach ($result as $arr) {
                $transId    = $arr['trans_id'];
                $aData[$transId]    = $arr;
            }
        }

        return $aData;
    }

    public function getInvoiceItemAccountId ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT ii.*
            FROM hb_invoice_items ii
            WHERE ii.type = 'Hosting'
                AND ii.invoice_id = :invoice_id
            ", array(
                ':invoice_id'   => $invoiceId
            ))->fetchAll();
            
        $aData      = array();
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aData, $arr['item_id']);
            }
        }
        
        return $aData;
    }

    public function getInvoiceBeforeTransaction ($transDate, $aAccountId)
    {
        $result     = $this->db->query("
            SELECT i.*, ii.description
            FROM hb_invoice_items ii,
                hb_invoices i
            WHERE i.id = ii.invoice_id
                AND ii.type = 'Hosting'
                AND ii.item_id IN ('". implode("','", $aAccountId) ."')
                AND i.duedate < :duedate
            ORDER BY i.duedate DESC
            ", array(
                ':duedate'   => $transDate
            ))->fetch();
        
        $aData      = count($result) ? $result : array();

        return $aData;
    }

    public function getInvoiceDescription ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT i.*, ii.description
            FROM hb_invoice_items ii,
                hb_invoices i
            WHERE i.id = ii.invoice_id
                AND i.id = :invoice_id
            ", array(
                ':invoice_id'   => $invoiceId
            ))->fetch();
        
        $aData      = count($result) ? $result : array();

        return $aData;
    }

    public function listPaypalReference ($transId)
    {
        $aData      = array();

        $result     = $this->db->query("
            SELECT pt.*
            FROM hb_paypal_transaction pt
            WHERE pt.transaction_id = :transaction_id
            ", array(
                ':transaction_id'   => $transId
            ))->fetch();
        
        if (! count($result)) {
            return $aData;
        }

        $referenceId    = $result['paypal_reference_id'];

        if (! $referenceId) {
            return $aData;
        }

        $result     = $this->db->query("
            SELECT pt.*
            FROM hb_paypal_transaction pt
            WHERE pt.paypal_reference_id = :paypal_reference_id
            ORDER BY pt.transaction_initiation_date ASC
            ", array(
                ':paypal_reference_id'   => $referenceId
            ))->fetchAll();

        $aData      = count($result) ? $result : array();
        $aData_     = $aData;
        foreach ($aData_ as  $k => $arr) {
            if (! $k) {
                continue;
            }
            $aData[$k-1]['end_date']    = $arr['transaction_initiation_date'];
        }

        return $aData;
    }

    public function listRelateClientCreditLog ($clientId, $startDate, $endDate)
    {
        $sql    = "
            SELECT ccl.*
            FROM hb_client_credit_log ccl
            WHERE ( ccl.date BETWEEN '{$startDate}' AND '{$endDate}' )
            ";
        if ($clientId) {
            $sql    .= "
                AND ccl.client_id = '{$clientId}'
                ";
        } else {
            $sql    .= "
                AND ccl.client_id != '{$clientId}'
                ";
        }
        $sql    .= "
            ORDER BY  ccl.date ASC
            ";

        $result     = $this->db->query($sql)->fetchAll();
        
        $aData      = count($result) ? $result : array();

        return $aData;
    }

    public function getClientIdFromInvoice ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT i.*
            FROM hb_invoices i
            WHERE i.id = :id
            ", array(
                ':id'   => $invoiceId
            ))->fetch();
        
        $clientId      = count($result) ? $result['client_id'] : 0;

        return $clientId;
    }

    public function getClientByEmail ($email)
    {
        $result     = $this->db->query("
            SELECT ca.*
            FROM hb_client_access ca
            WHERE ca.email = :email
            ", array(
                ':email'    => $email
            ))->fetch();
        
        $result      = count($result) ? $result : array();

        return $result;
    }

    public function getClientById ($id)
    {
        $result     = $this->db->query("
            SELECT ca.*
            FROM hb_client_access ca
            WHERE ca.id = :id
            ", array(
                ':id'   => $id
            ))->fetch();
        
        $result      = count($result) ? $result : array();

        return $result;
    }

    public function getTransactionByTransId ($transId)
    {
        $result     = $this->db->query("
            SELECT t.*
            FROM hb_transactions t
            WHERE t.trans_id = :trans_id
            ", array(
                ':trans_id'    => $transId
            ))->fetch();
        
        $result     = count($result) ? $result : 0;

        return $result;
    }

    public function listRelateClientInvoice ($clientId, $startDate, $endDate, $invoiceId, $order = 'DESC', $limit = 2)
    {
        $aData      = array();
        $aAccountId = array('x');

        if ($invoiceId) {
            $result     = $this->getInvoiceById($invoiceId);
            foreach ($result as $arr) {
                if ($arr['type'] == 'Hosting') {
                    array_push($aAccountId, $arr['item_id']);
                }
            }
            $aData[$invoiceId]  = $result;
        }

        $sql    = "
            SELECT ii.*
            FROM hb_invoice_items ii, 
                hb_invoices i
            WHERE ii.invoice_id = i.id
                AND ( i.date BETWEEN '{$endDate}' AND '{$startDate}' )
            ";
        if (count($aAccountId) > 1) {
            $sql    .= "
                AND ii.type = 'Hosting'
                AND ii.item_id IN ('". implode('','', $aAccountId) ."')
                ";
        }
        if ($clientId) {
            $sql    .= "
                AND i.client_id = '{$clientId}'
                ";
        } else {
            $sql    .= "
                AND i.client_id != '{$clientId}'
                ";
        }
        $sql    .= "
            ORDER BY  i.date {$order}
            LIMIT {$limit}
            ";
        
        $result     = $this->db->query($sql)->fetchAll();
        $result      = count($result) ? $result : array();
        foreach ($result as $arr) {
            $invoiceId  = $arr['invoice_id'];
            if (! isset($aData[$invoiceId])) {
                $aData[$invoiceId]      = $this->getInvoiceById($invoiceId);
            }
        }

        return $aData;
    }

    public function getInvoiceById ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT ii.invoice_id, ii.description, i.id, i.date, i.subtotal, i.grandtotal
            FROM hb_invoice_items ii, 
                hb_invoices i
            WHERE ii.invoice_id = :id
                AND ii.invoice_id = i.id
            ", array(
                ':id'   => $invoiceId
            ))->fetchAll();

        $result     = count($result) ? $result : array();

        return $result;
    }

    
    
    
    
}
