<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class accounthandle_model {

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
    
    public function getInvoiceItemFromAccountOrder ($accountId)
    {
        $result     = $this->db->query("
            SELECT 
                ii.id
            FROM 
                hb_accounts a,
                hb_orders o,
                hb_invoice_items ii
            WHERE 
                a.id = :accountId
                AND a.order_id = o.id
                AND o.invoice_id = ii.invoice_id
                AND ii.type = 'Hosting'
                AND ii.item_id = :accountId
                AND ii.is_shipped = 0
            ", array(
                ':accountId'  => $accountId
            ))->fetch();

        $result     = count($result) ? $result : array();
        return $result;
    }
    
    public function setInvoiceItenIsShip ($invoiceItemId)
    {
        $this->db->query("
            UPDATE hb_invoice_items 
            SET is_shipped = 1
            WHERE id = :invoiceItemId
            ", array(
                ':invoiceItemId'    => $invoiceItemId
            ));
    }
    
    
}
