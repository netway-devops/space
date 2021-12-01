<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class invoicehandle_model {

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
    
    public function getItemAccountByInvoiceId ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT ii.id, ii.amount,
                a.product_id
            FROM hb_invoice_items ii,
                hb_accounts a
            WHERE ii.invoice_id = '{$invoiceId}'
                AND ii.type = 'Hosting'
                AND ii.item_id = a.id
            ")->fetchAll();
        
        $result     = count($result) ? $result : array();
        
        return $result;
    }
    
    public function getById ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT i.*
            FROM hb_invoices i
            WHERE i.id = '{$invoiceId}'
            ")->fetch();
        
        $result     = isset($result['id']) ? $result : array();
        
        return $result;
    }
    
    public function getByIdWithPayment ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT i.*,
                mc.config AS mc_config
            FROM hb_invoices i,
                hb_modules_configuration mc
            WHERE i.id = '{$invoiceId}'
                AND i.payment_module = mc.id
            ")->fetch();
        
        $result     = isset($result['id']) ? $result : array();
        
        return $result;
    }
    
    public function setIsPayToNetway ($invoiceId)
    {
        $this->db->query("
            UPDATE hb_invoices
            SET is_netway = '1'
            WHERE id = '{$invoiceId}'
                AND status = 'Paid'
            ");
        
    }
    
    public function getItemWithTrialAccountByInvoiceId ($invoiceId)
    {
        $aTrialProductId     = array(162);

        $result     = $this->db->query("
            SELECT ii.*, a.next_due, a.next_invoice
            FROM hb_invoice_items ii,
                hb_accounts a
            WHERE ii.invoice_id = '{$invoiceId}'
                AND a.status = 'Pending'
                AND ii.type = 'Hosting'
                AND ii.item_id = a.id
                AND a.product_id IN (". implode(',', $aTrialProductId) .")
            ")->fetchAll();
        
        $result     = count($result) ? $result : array();
        
        return $result;
    }

    public function updateItemDescIncludeTrial ($data)
    {
        $this->db->query("
            UPDATE hb_invoice_items
            SET description = :description
            WHERE id = :id
            ", array(
                ':id'   => $data['id'],
                ':description'  => $data['description'],

            ));
    }
    
    public function getAccountById ($accountId)
    {
        $result     = $this->db->query("
            SELECT a.*
            FROM hb_accounts a
            WHERE a.id = '{$accountId}'
            ")->fetch();
        
        $result     = isset($result['id']) ? $result : array();
        
        return $result;
    }
    
    public function getUpgradeById ($id)
    {
        $result     = $this->db->query("
            SELECT u.*
            FROM hb_upgrades u
            WHERE u.id = '{$id}'
            ")->fetch();
        
        $result     = isset($result['id']) ? $result : array();
        
        return $result;
    }

    
    
    
}
