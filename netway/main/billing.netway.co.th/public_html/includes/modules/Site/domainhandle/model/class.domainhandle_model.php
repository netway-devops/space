<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class domainhandle_model {

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
    
    public function getInvoiceItemFromDomainOrder ($domainId, $type)
    {
        $result     = $this->db->query("
            SELECT 
                ii.id
            FROM 
                hb_domains d,
                hb_orders o,
                hb_invoice_items ii
            WHERE 
                d.id = :domainId
                AND d.order_id = o.id
                AND o.invoice_id = ii.invoice_id
                AND ii.type = :item_type
                AND ii.item_id = :domainId
                AND ii.is_shipped = 0
            ", array(
                ':domainId'  => $domainId,
                ':item_type' => $type
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

    public function isClientDomain ($clientId, $domainId, $domainName)
    {
        $result     = $this->db->query("
            SELECT id
            FROM hb_domains
            WHERE id = :id
                AND client_id = :client_id
                AND name = :name
                AND status = 'Active'
            ", array(
                ':id'           => $domainId,
                ':client_id'    => $clientId,
                ':name'         => $domainName
            ))->fetch();
        
        $result     = isset($result['id']) ? true : false;
        
        return $result;
    }
    
    public function addDomainForwarding ($aData)
    {
        
        $this->db->query("
            REPLACE INTO tb_domain_forwarding (
                domain, tld, urlforwarding, cloak, googlecode
            ) VALUES (
                :domain, :tld, :urlforwarding, :cloak, :googlecode
            )
            ", array(
                ':domain'   => $aData['domain'],
                ':tld'      => $aData['tld'],
                ':urlforwarding'    => $aData['urlforwarding'],
                ':cloak'    => $aData['cloak'],
                ':googlecode'       => $aData['googlecode'],
            ));
        
    }
    
    public function deleteDomainForwarding ($aData)
    {
        $this->db->query("
            DELETE FROM tb_domain_forwarding 
            WHERE domain = :domain
                AND tld = :tld
            ", array(
                ':domain'   => $aData['domain'],
                ':tld'      => $aData['tld'],
            ));
        
    }

    
    
    
    
}
