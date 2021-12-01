<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class apihandle_model {

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
    
    public function addInvoiceNote ($invoiceId, $data)
    {
        $note       = isset($data['note']) ? $data['note'] : '';
        $deal_id    = isset($data['dealId']) ? $data['dealId'] : '';
        if ($note == '') {
            return true;
        }

        $result     = $this->db->query("
            INSERT INTO hb_notes (
                `type`, `rel_id`, `admin_id`, `date`, `note`
            ) VALUES (
                'invoice', :invoiceId, '0', NOW(), :note
            )
            ", array(
                ':invoiceId'    => $invoiceId,
                ':note'     => $note,

            ));
        
        $this->db->query("
            UPDATE hb_invoices 
            SET deal_id = :dealId
            WHERE hb_invoices.id = :invoiceId
        ", array(
            ':invoiceId'   => $invoiceId,
            ':dealId'     => $deal_id

        ));
        
        return true;
    }
    
    public function updateDealtoInvoice($invoiceId, $deal_id)
    {

        if ($invoiceId == '') {
            return true;
        }


        $this->db->query("
            UPDATE hb_invoices 
            SET deal_id = :dealId
            WHERE hb_invoices.id = :invoiceId
        ", array(
            ':invoiceId'   => $invoiceId,
            ':dealId'     => $deal_id

        ));

        return true;
    }


    public function getClientAccessByEmail ($email)
    {
        $result     = $this->db->query("
            SELECT ca.*
            FROM hb_client_access ca
            WHERE ca.email = :email
            ", array(
                ':email'  => $email,
            ))->fetch();

        return $result;
    }
    
    public function getOrderDraftIdByEstimateId ($estimateId)
    {
        $result     = $this->db->query("
        SELECT * 
        FROM hb_order_drafts 
        WHERE estimate_id = :estimateId
            ", array(
                ':estimateId'  => $estimateId,
            ))->fetch();

        return $result;
    }

    public function updateDealIdByEstimateId ($data)//create deal when generate Estimate
    {
        
        $estimateId = isset($data['estimateId']) ? $data['estimateId'] :0;
        $dealId     = isset($data['dealId']) ? $data['dealId'] : '';
        if ($estimateId == 0) {
            return true;
        }

        $this->db->query("
        UPDATE hb_estimates 
        SET deal_id = :dealId
        WHERE id = :estimateId
        ", array(
            ':estimateId'   => $estimateId,
            ':dealId'     => $dealId

        ));
        
        return true;
        
    }

    public function getEstimateDetail ($invoiceId)
    {
        $result     = $this->db->query("
        SELECT * 
        FROM hb_estimates 
        WHERE invoice_id = :invoiceId
        ", array(
            ':invoiceId'  => $invoiceId,
        ))->fetch();

        return $result;
    }
    
}
