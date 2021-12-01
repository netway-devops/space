<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class accountaddonhandle_model {

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
    
    public function getInvoiceItemFromAccountAddonOrder ($addonId)
    {
        $result     = $this->db->query("
            SELECT 
                ii.id
            FROM 
                hb_accounts_addons aa,
                hb_orders o,
                hb_invoice_items ii
            WHERE 
                aa.id = :addonId
                AND aa.order_id = o.id
                AND o.invoice_id = ii.invoice_id
                AND ii.type = 'Addon'
                AND ii.item_id = :addonId
                AND ii.is_shipped = 0
            ", array(
                ':addonId'  => $addonId
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
