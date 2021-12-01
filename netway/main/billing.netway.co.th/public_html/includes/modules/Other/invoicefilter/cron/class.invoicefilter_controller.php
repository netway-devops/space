<?php

class invoicefilter_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function _cancel_call_EveryRun()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

        require_once(APPDIR . 'class.config.custom.php');
        
        $message        = '';
        return $message;

        // [TODO] กำลังถูกยกเลิกให้ไปใช้ "Collections" ที่เป็นของ Hostbill แทน "PaymentInprogress" ที่สร้างขึ้นมาเอง

        $nwInvoicePaymentInprogressCheckDate    = ConfigCustom::singleton()->getValue('nwInvoicePaymentInprogressCheckDate');
        $nwInvoicePaymentInprogressCheckDate    = $nwInvoicePaymentInprogressCheckDate ? $nwInvoicePaymentInprogressCheckDate : '2019-12-01';

        $result         = $db->query("
            SELECT invoice_id, created_at
            FROM hb_invoices_log
            WHERE created_at >= '{$nwInvoicePaymentInprogressCheckDate}'
            ORDER BY created_at ASC
            LIMIT 25
            ")->fetchAll();
        
        $result_        = $result;
        $aInvoiceId     = array();
        if (count($result_)) {
            foreach ($result_ as $aLog) {
                $nwInvoicePaymentInprogressCheckDate    = $aLog['created_at'];
                $invoiceId      = $aLog['invoice_id'];
                if (! in_array($invoiceId, $aInvoiceId)) {
                    array_push($aInvoiceId, $invoiceId);
                }
            }
        }
        if (count($aInvoiceId)) {
            foreach ($aInvoiceId as $invoiceId) {
                $result     = $db->query("
                    SELECT id
                    FROM hb_invoices
                    WHERE id = '{$invoiceId}'
                        AND status = 'PaymentInprogress'
                    ")->fetch();
                
                $isInprogress   = isset($result['id']) ? 1 : 0;

                $result         = $db->query("
                SELECT *
                FROM hb_invoice_items
                WHERE invoice_id = '{$invoiceId}'
                ")->fetchAll();
                
                if (count($result)) {
                    foreach ($result as $arr) {
                        $type   = $arr['type'];
                        $id     = $arr['item_id'];

                        if ($type == 'Hosting') {
                            $db->query("
                                UPDATE hb_accounts
                                SET is_payment_inprogress = '{$isInprogress}'
                                WHERE id = '{$id}'
                                ");
                        }
                        if (preg_match('/domain/i', $type)) {
                            $db->query("
                                UPDATE hb_domains
                                SET is_payment_inprogress = '{$isInprogress}'
                                WHERE id = '{$id}'
                                ");
                        }

                        $message    .= "\n" .' invoiceId = '. $invoiceId .' is_payment_inprogress = '. $isInprogress;

                    }
                }

            }
        }

        ConfigCustom::singleton()->setValue('nwInvoicePaymentInprogressCheckDate', $nwInvoicePaymentInprogressCheckDate);

        if (isset($aAdmin['id'])) {
            echo $message;
        }
        return $message;
    }
    
}


