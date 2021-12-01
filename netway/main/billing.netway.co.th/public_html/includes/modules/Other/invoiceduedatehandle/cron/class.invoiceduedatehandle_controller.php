
<?php

class invoiceduedatehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * 
     * @return string
     */
    public function call_Hourly()
    {
        $db             = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $message        = '';
        
        # กรณีที่มี 2 invoice item ให้ปรับ duedate มาอิงกับ due ที่จะถึงก่อน
        # เพื่อป้องกันเรื่องเลย due date
        
        $nwInvoiceDuedateHandle     = ConfigCustom::singleton()->getValue('nwInvoiceDuedateHandle');
        
        $result         = $db->query("
                SELECT ii.*
                FROM hb_invoice_items ii,
                    hb_invoices i
                WHERE ii.invoice_id = i.id
                    AND ii.invoice_id > :invoiceId
                    AND i.status = 'Unpaid'
                GROUP BY ii.invoice_id HAVING COUNT(ii.invoice_id) > 1
                ORDER BY ii.invoice_id ASC
                LIMIT 0, 10
                ", array(
                    ':invoiceId'    => $nwInvoiceDuedateHandle
                ))->fetchAll();
        
        if (! count($result)) {
            return $message;
        }
        
        $aInvoice       = array();
        
        foreach ($result as $arr) {
            if (! in_array($aInvoice, $arr['invoice_id'])) {
                array_push($aInvoice, $arr['invoice_id']);
            }
        }
        
        foreach ($aInvoice as $invoiceId) {
            $result     = $db->query("
                    SELECT i.*
                    FROM hb_invoices i
                    WHERE i.id = :invoiceId
                    ", array(
                        ':invoiceId'    => $invoiceId
                    ))->fetch();
            
            $invoiceDate    = isset($result['date']) ? strtotime($result['date']) : time();
            $duedate    = isset($result['duedate']) ? strtotime($result['duedate']) : time();
            $aDue       = array();
            
            $result     = $db->query("
                    SELECT ii.*
                    FROM hb_invoice_items ii
                    WHERE ii.invoice_id = :invoiceId
                    ", array(
                        ':invoiceId'    => $invoiceId
                    ))->fetchAll();
            
            if (count($result)) {
                
                foreach ($result as $arr) {
                    $desc       = $arr['description'];
                    
                    if (preg_match('/\<\!\-\-\(/', $desc)) {
                        continue;
                    }
                    
                    preg_match('/(\d{2}\s[a-zA-Z]{3}\s\d{4})\s\-/', $desc, $matches);
                    $due        = isset($matches[1]) ? $matches[1] : '';
                    
                    if ($due) {
                        $due    = self::_convertStrtotime($due);
                        array_push($aDue, $due);
                    }
                    
                }
                
            }
            
            if (count($aDue) < 2) {
                continue;
            }
            
            $newDue             = $duedate;
            foreach ($aDue as $due) {
                if ($newDue > $due) {
                    $newDue     = $due;
                }
            }
            
            if (! $newDue || (date('Y-m-d', $newDue) == date('Y-m-d', $duedate))) {
                continue;
            }
            
            if ($newDue < $invoiceDate) {
                $newDue         = $invoiceDate;
            }
            
            $db->query("
                UPDATE hb_invoices
                SET duedate = :duedate,
                    notes = CONCAT(notes, '\nOld Duedate: ', :oldDue)
                WHERE id = :invoiceId
                ", array(
                    ':invoiceId'    => $invoiceId,
                    ':duedate'      => date('Y-m-d', $newDue),
                    ':oldDue'       => date('Y-m-d', $duedate),
                ));
            
            $nwInvoiceDuedateHandle = $invoiceId;
        }
        
        ConfigCustom::singleton()->setValue('nwInvoiceDuedateHandle', $nwInvoiceDuedateHandle);
        
        return $message;
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $aMonth     = array(
            'jan' => '1',
            'feb' => '2',
            'mar' => '3',
            'apr' => '4',
            'may' => '5',
            'jun' => '6',
            'jul' => '7',
            'aug' => '8',
            'sep' => '9',
            'oct' => '10',
            'nov' => '11',
            'dec' => '12',
        );

        if (preg_match('/(\d{2})\s([a-zA-Z]{3})\s(\d{4})/', $str, $matches)) {
            $d  = isset($matches[1]) ? $matches[1] : 00;
            $m  = ( isset($matches[2]) && isset($aMonth[strtolower($matches[2])]) ) ? $aMonth[strtolower($matches[2])] : 00;
            $y  = isset($matches[3]) ? $matches[3] : 0000;
            return strtotime($y .'-'. $m .'-'. $d);
        }
        
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
}


