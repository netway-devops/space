<?php

require_once APPDIR . 'class.config.custom.php';
require_once(APPDIR_MODULES . 'Other/paypalsubscriptionlog/model/class.paypalsubscriptionlog_model.php');

class paypalsubscriptionlog_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * @return string
     */
     
    public function call_EveryRun() 
    {
        $db         = hbm_db();
        $message    = '';

        $lastPaypalSubscriptionLogID    = ConfigCustom::singleton()->getValue('lastPaypalSubscriptionLogID');
        
        $results    = paypalsubscriptionlog_model::singleton()->listPendingGatewayLog($lastPaypalSubscriptionLogID);

        foreach ($results as $value){
            $lastPaypalSubscriptionLogID    =   $value['id'];
            $date               =   $value['date'];
            $output             =   $value['output'];
            $transaction_id     =   $this->outputLine($output,16);
            $email              =   $this->outputLine($output,15);
            $amount             =   $this->outputLine($output,8);
            $invoice            =   $this->outputLine($output,21);

            $hbInvoiceId    = 0;
            $hbCreditLogId  = 0;

            $result         = paypalsubscriptionlog_model::singleton()->getPaypalTransactionById($transaction_id);
            $hbInvoiceId    = isset($result['invoice_id']) ? $result['invoice_id'] : 0;
            
            if (! $hbInvoiceId) {
                $result         = paypalsubscriptionlog_model::singleton()->getPaypalCreditLogById($transaction_id);
                $hbCreditLogId  = isset($result['id']) ? $result['id'] : 0;
                if (! $hbInvoiceId) {
                $hbInvoiceId    = isset($result['invoice_id']) ? $result['invoice_id'] : 0;
                }
            }
            
            $aData      = array(
                'date'              => $date,
                'gateway_log_id'    => $lastPaypalSubscriptionLogID,
                'transaction_id'    => $transaction_id,
                'email'             => $email,
                'amount'            => $amount,
                'invoice_id'        => $invoice,
                'invoice_hb'        => $hbInvoiceId,
                'credit_log_hb'     => $hbCreditLogId,
            );

            $result     = paypalsubscriptionlog_model::singleton()->getSubscriptionlogByGatewayId($lastPaypalSubscriptionLogID);

            if (isset($result['id'])) {
                paypalsubscriptionlog_model::singleton()->updateSubscriptionlog($lastPaypalSubscriptionLogID, $aData);
            } else {
                paypalsubscriptionlog_model::singleton()->addSubscriptionlog($aData);
            }
            
        }
        
        ConfigCustom::singleton()->setValue('lastPaypalSubscriptionLogID', $lastPaypalSubscriptionLogID);

        $results    = paypalsubscriptionlog_model::singleton()->listPendingCreditLog();
        foreach ($results as $aLog){
            $result         = paypalsubscriptionlog_model::singleton()->updateSubscriptionByCreditLog($aLog);
        }
        $results    = paypalsubscriptionlog_model::singleton()->listPendingTransactionLog();
        foreach ($results as $aLog){
            $result         = paypalsubscriptionlog_model::singleton()->updateSubscriptionByTransactionLog($aLog);
        }

        return $message;
    }
    
    private function outputLine( $str , $line )
    {
        
        $x      =   explode("\n",$str);
        $aLine  =   array();
        
        foreach($x as $linevalue){
            $aLine[]    =   $linevalue;
        }
        
        $response   =   substr($aLine[$line - 1], strpos($aLine[$line - 1], '=>') + 3);
        
        return trim($response);
    }
    
}


