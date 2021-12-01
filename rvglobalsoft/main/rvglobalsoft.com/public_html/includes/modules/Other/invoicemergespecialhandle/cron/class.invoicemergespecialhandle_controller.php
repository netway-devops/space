<?php

class invoicemergespecialhandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function call_EveryRun()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        return $message;
    }
    
    public function call_Monthly()
    {
        $db         = hbm_db();
        
        $message    = '';
        
        $this->_forEnduranceIntGroup();
        
        return $message;
    }
    
    private function _forEnduranceIntGroup ()
    {
        $db         = hbm_db();
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl . '/api.php');
        
        /**
        วิธี 
        สร้าง client ap-endurance@endurance.com 
        สร้าง contact  darren.costa@endurance.com parent ap-endurance@endurance.com  ให้รับ invoice ap-endurance@endurance.com 
        วันที่ 8 ของทุกเดือน คัดลอก invoice item ที่ unpaid ของทั้ง 3 account ไปสร้างเป็น invoice ของ ap-endurance@endurance.com โดยสร้างเป็น invoice ใหม่ ตั้ง due เป็น 30 ของเดือน
         */
        
        //[XXX] 
        $aClient    = array('4626', '4611', '4596', '4615', '4605');
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE client_id IN (". implode(',', $aClient).")
                AND status = 'Unpaid'
                AND date LIKE '". date('Y-m-') ."%'
            ")->fetchAll();
        
        $aInvoice   = array();
        $notes      = '';
        foreach ($result as $arr) {
            $invoiceId      = $arr['id'];
            $notes          .= $arr['notes'];
            $arr['desc']    = 'Invoice #'. $invoiceId;
            $arr['items']   = array();
            $aInvoice[$invoiceId]   = $arr;
            
            $result2    = $db->query("
                SELECT *
                FROM hb_invoice_items
                WHERE invoice_id = '{$invoiceId}'
                ")->fetchAll();
            foreach ($result2 as $arr) {
                $itemId = $arr['id'];
                $aInvoice[$invoiceId]['desc']   .= "\n". $arr['description'];
                $aInvoice[$invoiceId]['items'][$itemId] = $arr;
            }
        }
        
        if (! count($aInvoice)) {
            return true;
        }
        
        //[XXX] 12855 ap-endurance@endurance.com
        $clientId   = 12855;
        
        $aParam     = array(
           'call'   => 'addInvoice',
           'client_id'  => $clientId
        );
        $result     = $apiCustom->request($aParam);
        $invoiceId  = isset($result['invoice_id']) ? $result['invoice_id'] : 0;
        // [FIX BUG] API ของ Hostbill ไม่ส่ง $result มาให้
        if (! $invoiceId) {
            $result     = $db->query("
                SELECT MAX(id) AS invoice_id
                FROM hb_invoices
                WHERE client_id = '{$clientId}'
                    AND status = 'Draft'
                ")->fetch();
            $invoiceId  = isset($result['invoice_id']) ? $result['invoice_id'] : 0;
        }
        
        if (! $invoiceId) {
            return true;
        }
        
        foreach ($aInvoice as $arr) {
            $desc       = $arr['desc'];
            $price      = $arr['total'];
            $qty        = 1;
            $tax        = 0;
            $aParam     = array(
               'call'   => 'addInvoiceItem',
               'id'     => $invoiceId,
               'line'   => $desc,
               'price'  => $price,
               'qty'    => $qty,
               'tax'    => $tax
            );
            $result     = $apiCustom->request($aParam);
        }
        
        $aParam     = array(
           'call'   => 'convertInvoice',
           'id'     => $invoiceId
        );
        $result     = $apiCustom->request($aParam);
        
        $duedate    = date('Y-m-30',time());
        $db->query("
            UPDATE hb_invoices
            SET duedate = :duedate,
                notes = :notes
            WHERE id = :id
            ", array(
                ':duedate'  => $duedate,
                ':notes'    => $notes,
                ':id'   => $invoiceId,
            ));
        
        $aParam     = array(
           'call'   => 'setInvoiceStatus',
           'id'     => $invoiceId,
           'status' => 'Unpaid'
        );
        $result     = $apiCustom->request($aParam);
        
        $aParam     = array(
           'call'   => 'sendInvoice',
           'id'     => $invoiceId
        );
        $result     = $apiCustom->request($aParam);
        
        return true;
    }
    
}
