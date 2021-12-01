<?php

require_once(APPDIR .'class.cache.extend.php');

class qrcodepaymenthandle_controller extends HBController {

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function beforeCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('aAdmin', $aAdmin);
        $aClient         = hbm_logged_client();
        $this->template->assign('aAdmin', $aAdmin);
        
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
    
    public function _default ($request)
    {
        $db             = hbm_db();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/user/default.tpl',array(), true);
    }
    
    public function testnotification ($request)
    {
        return $this->notification($request);
    }    
    public function notification ($request)
    {
        $db             = hbm_db();
        
        $input          = file_get_contents('php://input');
        $request        = json_decode($input, true);
        
        $invoice        = isset($request['billPaymentRef1']) ? $request['billPaymentRef1'] : '';
        $customer       = isset($request['billPaymentRef2']) ? $request['billPaymentRef2'] : '';
        $amount         = isset($request['amount']) ? $request['amount'] : 0;
        $date           = isset($request['transactionDateandTime']) ? strtotime($request['transactionDateandTime']) : time();
        $transactionId  = isset($request['transactionId']) ? $request['transactionId'] : '';
        
        $isValid        = 1;
        if (! preg_match('/^inv/i', $invoice) || ! preg_match('/^cid/i', $customer) || ! $transactionId) {
            $isValid    = 0;
        }
        
        $invoiceId      = substr($invoice, 3) + 0;
        $customerId     = substr($customer, 3) + 0;
        
        if ($isValid) {
            $result         = $db->query("
                SELECT *
                FROM hb_invoices
                WHERE id = '{$invoiceId}'
                    AND client_id = '{$customerId}'
                    AND status = 'Unpaid'
                ")->fetch();
            if (! isset($result['id'])) {
                $isValid    = 0;
            }
        }
        
        $result     = array();
        if ($isValid) {
        
            /* Use this method to access HostBill api from HostBill modules */
            $api     = new ApiWrapper();
            $params  = array(
                'id'        => $invoiceId,
                'amount'    => $amount,
                'paymentmodule' => 184,
                'fee'   => 0,
                'date'  => date('Y-m-d H:i:s', $date),
                'transnumber'   => $transactionId
            );
            $result = $api->addInvoicePayment($params);
        
        }
        
        $result = array(
            'result'    => $result,
            'request'   => $request,
        );
        
        $db->query("
            INSERT INTO hb_webhook_logs (
            webhook_id, status, `log`, created_at
            ) VALUES (
            '0', '0', '". serialize($result) ."', NOW()
            )
            ");
        
        $resCode    = '00';
        $resDesc    = 'success';
        $transactionId  = isset($request['transactionId']) ? $request['transactionId'] : '';
        $confirmId  = time();
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('resCode', $resCode);
        $this->json->assign('resDesc', $resDesc);
        $this->json->assign('transactionId', $transactionId);
        $this->json->assign('confirmId', $confirmId);
        $this->json->show();
    }
    
    
}