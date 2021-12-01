<?php

class splitinvoicehandle_controller extends HBController {
    
    public $module;
    
    public function call_Daily()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        require_once(APPDIR . 'class.general.custom.php');
        //require_once(APPDIR . 'modules/Other/splitinvoicehandle/admin/class.splitinvoicehandle_controller.php');
        
        $result     = $db->query("
            SELECT cfv.client_id
            FROM hb_client_fields cf,
                hb_client_fields_values cfv
            WHERE cf.code = 'splitinvoice'
                AND cf.id = cfv.field_id
                AND cfv.value = 'Yes'
            ")->fetchAll();
        
        $result_    = $result;
        foreach ($result_ as $arr) {
            $clientId   = isset($arr['client_id']) ? $arr['client_id'] : 0;
            $result     = $db->query("
                SELECT COUNT( ii.invoice_id ) , ii.invoice_id
                FROM hb_invoice_items ii, hb_invoices i
                WHERE ii.invoice_id = i.id
                    AND i.client_id = '{$clientId}'
                    AND i.date = CURDATE()
                    AND i.status = 'Unpaid'
                GROUP BY ii.invoice_id
                HAVING COUNT( ii.invoice_id ) > 1
                ")->fetchAll();
            
            $result_2    = $result;
            foreach ($result_2 as $arr) {
                $invoiceId  = $arr['invoice_id'];
                
                $result     = $db->query("
                    SELECT *
                    FROM hb_invoice_items
                    WHERE invoice_id = '{$invoiceId}'
                    ORDER BY id ASC
                    LIMIT 1, 1000
                    ")->fetchAll();
                
                $result_3   = $result;
                foreach ($result_3 as $arr) {
                    $itemId     = isset($arr['id']) ? $arr['id'] : 0;
                    $result     = GeneralCustom::singleton()->adminUIActionRequest('?cmd=invoices&action=split&id='. $invoiceId 
                        .'&invoice_item_id[]='. $itemId, array());
                }
                
                
            }
        }
        return $message;
    }
    
    
    
}


