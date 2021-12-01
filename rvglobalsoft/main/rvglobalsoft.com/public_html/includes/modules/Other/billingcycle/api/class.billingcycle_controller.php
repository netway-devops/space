<?php

class billingcycle_controller extends HBController {
    
    public function getAccountExpiryDate ($request)
    {
        
        $db         = hbm_db();
        
        $expire         = '';
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $nextDue        = isset($request['nextDue']) ? strtotime($request['nextDue']) : 0;
        
        if ( ! $accountId) {
            return false;
        }
        
        $aInvoice       = $db->query("
                        SELECT ii.description
                        FROM 
                            hb_invoices i,
                            hb_invoice_items ii
                        WHERE 
                            i.id = ii.invoice_id
                            AND i.status = 'Paid'
                            AND ii.type = 'Hosting'
                            AND ii.item_id = :itemId
                        ORDER BY i.id DESC
                        ", array(
                            ':itemId'   => $accountId
                        ))->fetch();
        
        $color      = '';
        
        if (isset($aInvoice['description'])) {
            preg_match('/-\s*(\d{1,2}\/\d{1,2}\/\d{4})/', $aInvoice['description'], $matches);
            $expire     = isset($matches[1]) ? $matches[1] : '';
            if ($expire) {
                $stmpExpire     = self::_convertStrtotime($expire);
                $color          = ($stmpExpire != $nextDue) ? 'red' : '';
            }
        }
        
        return array(true, array(
            'expire'    => $expire,
            'color'     => $color
        ));
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
    
}
