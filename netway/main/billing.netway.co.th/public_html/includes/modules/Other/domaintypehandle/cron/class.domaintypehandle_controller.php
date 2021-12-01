<?php

class domaintypehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    
    public function call_Hourly ()
    {
        
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT 
                d.id, d.name, d.date_created, d.period, d.expires
            FROM hb_invoice_items ii,
                hb_invoices i,
                hb_domains d
            WHERE ii.type LIKE 'Domain%'
                AND ii.invoice_id = i.id
                AND i.duedate > NOW()
                AND i.date > DATE_SUB(NOW(), INTERVAL 3 HOUR)
                AND ii.item_id = d.id
                AND d.status = 'Active'
                AND d.type = 'Register'
            ")->fetchAll();
        
        $message    = '';
        
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr_) {
                $db->query("
                    UPDATE hb_domains
                    SET type = 'Renew'
                    WHERE id = :id
                    ", array(
                        ':id'   => $arr_['id']
                    ));
                $message    .= $arr_['id'] .':'. $arr_['name'] .',';
            }
        }
        
        return $message;
    }
    
}
