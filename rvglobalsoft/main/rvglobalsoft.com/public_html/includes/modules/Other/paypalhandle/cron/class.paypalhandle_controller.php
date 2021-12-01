<?php

require_once APPDIR . 'class.config.custom.php';
require_once(APPDIR_MODULES . 'Other/paypalhandle/model/class.paypalhandle_model.php');
require_once(APPDIR_MODULES . 'Other/paypalhandle/library/class.paypalhandle_library.php');

class paypalhandle_controller extends HBController {
    
    public $module;
    
    public function call_Hourly() 
    {
        $message    = '';

        $message    .= $this->_getTransaction();
        $message    .= $this->_setSubscrSBPayment();
        $message    .= $this->_addMissingHostbillTransaction();
        $message    .= $this->_updatePaypalTransactionVerify();

        $message    .= $this->_findTerminateAccountForSuspendSubscription();
        
        return $message;
    }

    private function _setSubscrSBPayment ()
    {
        $db         = hbm_db();

        $message    = '';

        $result     = paypalhandle_model::singleton()->getPendingSync_subscr_sb_payment();
        if (! count ($result)) {
            return $message;
        }

        foreach ($result as $aLog) {
            $is_subscr_sb_payment   = 0;
            if (preg_match('/subscr\_sb\_payment/i', $aLog['output'])) {
                $is_subscr_sb_payment   = 1;
            }
            paypalhandle_model::singleton()->setPendingSync_subscr_sb_payment($aLog['id'], $is_subscr_sb_payment);
        }

        return $message;
    }

    private function _addMissingHostbillTransaction ()
    {
        $db         = hbm_db();

        $message    = '';

        $result     = paypalhandle_model::singleton()->getMissingTransaction();
        if (! count ($result)) {
            return $message;
        }

        foreach ($result as $arr) {
            $transactionId      = $arr['transaction_id'];
            $isNetway       = ($arr['paypal_account'] == 'payment@rvglobalsoft.com') ? 1 : 0;
            $aData          = isset($arr['transaction_info']) ? unserialize($arr['transaction_info']) : array();
            $description    = print_r($aData, true);
            
            $invoiceId  = 0;
            if (isset($aData['transaction_info']['transaction_subject'])) {
                $str    = $aData['transaction_info']['transaction_subject'];
                preg_match('/(\d+)/', $str, $match);
                if (isset($match[1])) {
                    $invoiceId  = $match[1];
                }
            }

            if (! $invoiceId) {
                if (isset($aData['cart_info']['item_details'][0]['item_code'])) {
                    $invoiceId  = $aData['cart_info']['item_details'][0]['item_code'];
                }
            }

            $aData      = array(
                'invoice_id'    => $invoiceId,
                'module'        => 11,
                'date'          => $arr['transaction_initiation_date'],
                'description'   => $description,
                'in'    => $arr['transaction_amount'],
                'fee'   => ($arr['fee_amount'] < 0 ? -$arr['fee_amount'] : $arr['fee_amount']),
                'trans_id'      => $transactionId,
                'is_netway'     => $isNetway,
            );
            paypalhandle_model::singleton()->addMissingTransaction($aData);

            //echo '<pre>'. print_r($aData, true) .'</pre>';
        }

        return $message;
    }
    
    private function _getTransaction ()
    {
        $db         = hbm_db();

        $message    = '';
        $aConfig    = $this->module->configuration;
        
        $lastPaypalSubscriptionLogCheckDate     = ConfigCustom::singleton()->getValue('lastPaypalSubscriptionLogCheckDate');
        $pastTime   = $lastPaypalSubscriptionLogCheckDate ? $lastPaypalSubscriptionLogCheckDate : '-5 day';
        $aParam     = array(
            'pastTime'  => $pastTime
        );
        //echo '<pre>'. print_r($aParam, true) .'</pre>';
        $aAccount   = array(
            'account'       => $aConfig['PAYPAL_ACCOUNT']['value'],
            'clientId'      => $aConfig['PAYPAL_CLIENT_ID']['value'],
            'clientSecret'  => $aConfig['PAYPAL_CLIENT_SECRET']['value'],
        );
        $result     = paypalhandle_library::singleton($aConfig)->getLatestTransaction($aAccount, $aParam);
        
        if (count($result)) {
            foreach ($result as $arr) {
                $lastPaypalSubscriptionLogCheckDate     = isset($arr['transaction_info']['transaction_initiation_date']) ? date('Y-m-d H:i:s', strtotime($arr['transaction_info']['transaction_initiation_date'])) : $lastPaypalSubscriptionLogCheckDate;
            }
            ConfigCustom::singleton()->setValue('lastPaypalSubscriptionLogCheckDate', $lastPaypalSubscriptionLogCheckDate);
        } else {
            $lastPaypalSubscriptionLogCheckDate = '-5 day';//date('Y-m-d', strtotime('+10 day', strtotime($lastPaypalSubscriptionLogCheckDate)));
            ConfigCustom::singleton()->setValue('lastPaypalSubscriptionLogCheckDate', $lastPaypalSubscriptionLogCheckDate);
            $message = $lastPaypalSubscriptionLogCheckDate;
            return $message;
        }

        //echo '<pre>'. print_r($lastPaypalSubscriptionLogCheckDate, true) .'</pre>';
        //echo '<pre>'. print_r($result, true) .'</pre>';

        $message    .= $this->_addTransaction($result, $aConfig['PAYPAL_ACCOUNT']['value']);

        $aAccount   = array(
            'account'       => $aConfig['PAYPAL_ACCOUNT_2']['value'],
            'clientId'      => $aConfig['PAYPAL_CLIENT_ID_2']['value'],
            'clientSecret'  => $aConfig['PAYPAL_CLIENT_SECRET_2']['value'],
        );
        $result     = paypalhandle_library::singleton($aConfig)->getLatestTransaction($aAccount, $aParam);
        $message    .= $this->_addTransaction($result, $aConfig['PAYPAL_ACCOUNT_2']['value']);

        //echo '<pre>'. print_r($result, true) .'</pre>';

        return $message;
    }
    
    private function _addTransaction ($aTrasaction, $paypalAccount = '')
    {
        $message    = '';
        if (! count($aTrasaction)) {
            return $message;
        }

        foreach ($aTrasaction as $arr) {
            if (! isset($arr['transaction_info'])) {
                continue;
            }
            $aInfo      = $arr['transaction_info'];
            $aPayer     = isset($arr['payer_info']) ? $arr['payer_info'] : array();
            $aCart      = isset($arr['cart_info']) ? $arr['cart_info'] : array();

            $transactionId  = $aInfo['transaction_id'];
            
            $result     = paypalhandle_model::singleton()->getTransactionById($transactionId);
            if (isset($result['transaction_id'])) {
                //paypalhandle_model::singleton()->updateTransaction($transactionId, $aInfo);

                paypalhandle_model::singleton()->updateTransactionInfo($transactionId, $arr);

                continue;
            }

            $aInfo['paypal_account']    = $paypalAccount;
            paypalhandle_model::singleton()->addTransaction($aInfo);
            $message    .= ' get transaction:'. $transactionId .' ';
        }

        return $message;
    }

    private function _updatePaypalTransactionVerify ()
    {
        $message    = '';

        $result     = paypalhandle_model::singleton()->getPendingVerification();
        if (! count ($result)) {
            return $message;
        }

        $result_    = $result;
        foreach ($result_ as $arr) {

            $transactionId  = $arr['transaction_id'];
            
            $result     = paypalhandle_model::singleton()->getHostbillTransactionId($transactionId);
            if (isset($result['trans_id']) && $result['trans_id']) {
                $transactionLogId   = $result['id'];
                $aParam     = array(
                    'field' => 'transaction_log_id',
                    'value' => $transactionLogId
                );
                paypalhandle_model::singleton()->setPaypalTransaction($transactionId, $aParam);
            }

            $result     = paypalhandle_model::singleton()->getHostbillClientCreditLogId($transactionId);

            if (isset($result['transaction_id']) && $result['transaction_id']) {
                $clientCreditLogId  = $result['id'];    
                $aParam     = array(
                    'field' => 'client_credit_log_id',
                    'value' => $clientCreditLogId
                );
                paypalhandle_model::singleton()->setPaypalTransaction($transactionId, $aParam);
                
            }

        }

        return $message;
    }

    public function _findTerminateAccountForSuspendSubscription ()
    {
        $message    = '';
        $aConfig    = $this->module->configuration;

        // หา account ที่พึ่ง terminate
        $aTerminates    = paypalhandle_model::singleton()->findLatestTerminateAccount();
        if (! count ($aTerminates)) {
            return $message;
        }

        foreach ($aTerminates as $aTerminate) {
            $accountId  = 27282;//$aTerminate['account_id'];

            // ยังไม่ได้ทำ SuspendSubscriptionLog 
            $result     = paypalhandle_model::singleton()->findSuspendSubscriptionLog($accountId);
            if (isset($result['id'])) {
                continue;
            }

            // เพิ่ม SuspendSubscriptionLog เข้า account เพื่อนำไปแสดงที่ widget
            $result     = paypalhandle_model::singleton()->findLatestPaidInvoiceFromAccountId($accountId);
            paypalhandle_model::singleton()->addPendingPaypalSuspendSubscriptionLog($accountId, $result);
            
        }

        return $message;
    }
    
}


