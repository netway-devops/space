<?php

require_once dirname(__DIR__) . '/model/class.transactionhandle_model.php';

class transactionhandle_controller extends HBController {
    
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
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
    }
    
    public function _default ($request)
    {
        $this->template->assign('request', $request);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl', array(), true);
    }
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
    
    public function listRelateInvoice ($request)
    {
        $transaction    = isset($request['transaction']) ? $request['transaction'] : '';
        $aTransaction   = explode("\n", $transaction);
        
        $aTransactions  = transactionhandle_model::singleton()->listTransaction($aTransaction);
        $aDatas         = array();

        foreach ($aTransactions as $transId => $aTran) {
            $invoiceId      = $aTran['invoice_id'];
            $transDate      = $aTran['date'];
            $tid            = $aTran['id'];
            $result         = array();

            $aAccountId     = transactionhandle_model::singleton()->getInvoiceItemAccountId($invoiceId);
            if (count($aAccountId)) {
                array_push($aAccountId, 'x');
                $result     = transactionhandle_model::singleton()->getInvoiceBeforeTransaction($transDate, $aAccountId);
            } else {
                $result     = transactionhandle_model::singleton()->getInvoiceDescription($invoiceId);
            }

            $result['transId']  = $transId;
            $aDatas[$tid]       = $result;

        }

        //echo '<pre>'.print_r($aTransactions, true).'</pre>';

        $this->template->assign('aDatas', $aDatas);
        $this->template->assign('transaction', $transaction);
        
        $this->_default($request);
    }
    
    public $aEventCode  = array(
        'T0000'     => 'General: received payment ',
        'T0002'     => 'Subscription payment.',
        'T0007'     => 'Website payments standard payment.',
        'T0200'     => 'General currency conversion.',
        'T0400'     => 'General withdrawal from PayPal account.',
        'T1106'     => 'Payment reversal, initiated by PayPal.',
        'T1107'     => 'Payment refund, initiated by merchant.',
        'T1110'     => 'Hold for dispute investigation ',
        'T1201'     => 'Chargeback',
    );

    public function listRelateData ($request)
    {
        $transaction    = isset($request['transaction']) ? $request['transaction'] : '';
        $aTransactions  = explode("\n", $transaction);

        $aDatas         = array();

        foreach ($aTransactions as $transId) {
            $transId        = trim($transId);
            $aReferences    = transactionhandle_model::singleton()->listPaypalReference($transId);
            if (! count($aReferences)) {
                continue;
            }

            $clientId   = 0;
            $email      = '';
            $aData      = array();
            foreach ($aReferences as $aReference) {
                $tranId     = $aReference['transaction_id'];
                $subject    = $aReference['transaction_subject'];
                preg_match('/Invoice\s(\d+)/i', $subject, $match);
                $invoiceId  = isset($match[1]) ? $match[1] : 0;

                if ($invoiceId && ! $clientId) {
                    $clientId   = transactionhandle_model::singleton()->getClientIdFromInvoice($invoiceId);
                }
                
                if (! $clientId) {
                    $aInfo      = unserialize($aReference['transaction_info']);
                    if (isset($aInfo['payer_info']['email_address'])) {
                        $email      = $aInfo['payer_info']['email_address'];
                        $aClient    = transactionhandle_model::singleton()->getClientByEmail($email);
                        $clientId   = ( isset($aClient['id']) && $aClient['id'] ) ? $aClient['id'] : $clientId;
                    }
                }

                $aTransaction   = transactionhandle_model::singleton()->getTransactionByTransId($tranId);
                $clientId       = ( isset($aTransaction['client_id']) && $aTransaction['client_id'] ) ? $aTransaction['client_id'] : $clientId;
                $invoiceId       = ( isset($aTransaction['invoice_id']) && $aTransaction['invoice_id'] ) ? $aTransaction['invoice_id'] : $invoiceId;

                $aReference['tid']          = ( isset($aTransaction['id']) && $aTransaction['id'] ) ? $aTransaction['id'] : 0;
                $aReference['client_id']    = $clientId;
                $aClient        = transactionhandle_model::singleton()->getClientById($clientId);
                $email          = ( isset($aClient['email']) && $aClient['email'] ) ? $aClient['email'] : $email;
                
                $aReference['email']        = $email;
                
                $startDate  = $aReference['transaction_initiation_date'];
                //$endDate    = isset($aReference['end_date']) ? $aReference['end_date'] : 0 ;
                $endDate    = date('Y-m-d H:i:s', strtotime('+15 minute',strtotime($startDate)));
                $creditRangeDate   = $startDate .' - '. $endDate;

                $aClientCredits = transactionhandle_model::singleton()->listRelateClientCreditLog($clientId, $startDate, $endDate);
                $aCredits       = transactionhandle_model::singleton()->listRelateClientCreditLog(0, $startDate, $endDate);
                
                $endDate    = date('Y-m-d H:i:s', strtotime('-25 day',strtotime($startDate)));
                $aClientInvoices    = transactionhandle_model::singleton()->listRelateClientInvoice($clientId, $startDate, $endDate, $invoiceId);
                $invoiceRangeDate   = $endDate .' - '. $startDate;

                $aData_     = array(
                    'aReference'        => $aReference,
                    'aClientCredits'    => $aClientCredits,
                    'aCredits'          => $aCredits,
                    'aClientInvoices'   => $aClientInvoices,
                    'creditRangeDate'   => $creditRangeDate,
                    'invoiceRangeDate'  => $invoiceRangeDate,
                );

                array_push($aData, $aData_);

            }

            $aDatas[$transId]   = $aData;
        
        }

        //echo '<pre>'.print_r($aDatas, true).'</pre>';

        $this->template->assign('aRelateDatas', $aDatas);
        $this->template->assign('aEventCode', $this->aEventCode);
        $this->template->assign('transaction', $transaction);
        
        $this->_default($request);
    }

    public function listActivityData ($request)
    {
        $transaction    = isset($request['transaction']) ? $request['transaction'] : '';
        $aTransactions  = explode("\n", $transaction);

        $aDatas         = array();

        foreach ($aTransactions as $transId) {
            $transId        = trim($transId);
            $aReferences    = transactionhandle_model::singleton()->listPaypalReference($transId);
            if (! count($aReferences)) {
                continue;
            }

            $clientId   = 0;
            $email      = '';
            $aData      = array();
            foreach ($aReferences as $aReference) {
                $tranId     = $aReference['transaction_id'];
                $subject    = $aReference['transaction_subject'];
                preg_match('/Invoice\s(\d+)/i', $subject, $match);
                $invoiceId  = isset($match[1]) ? $match[1] : 0;

                if ($invoiceId && ! $clientId) {
                    $clientId   = transactionhandle_model::singleton()->getClientIdFromInvoice($invoiceId);
                }
                
                if (! $clientId) {
                    $aInfo      = unserialize($aReference['transaction_info']);
                    if (isset($aInfo['payer_info']['email_address'])) {
                        $email      = $aInfo['payer_info']['email_address'];
                        $aClient    = transactionhandle_model::singleton()->getClientByEmail($email);
                        $clientId   = ( isset($aClient['id']) && $aClient['id'] ) ? $aClient['id'] : $clientId;
                    }
                }

                $aTransaction   = transactionhandle_model::singleton()->getTransactionByTransId($tranId);
                $clientId       = ( isset($aTransaction['client_id']) && $aTransaction['client_id'] ) ? $aTransaction['client_id'] : $clientId;
                $invoiceId       = ( isset($aTransaction['invoice_id']) && $aTransaction['invoice_id'] ) ? $aTransaction['invoice_id'] : $invoiceId;

                $aReference['tid']          = ( isset($aTransaction['id']) && $aTransaction['id'] ) ? $aTransaction['id'] : 0;
                $aReference['client_id']    = $clientId;
                if ($clientId && ! $email) {
                    $aClient        = transactionhandle_model::singleton()->getClientById($clientId);
                    $email          = ( isset($aClient['email']) && $aClient['email'] ) ? $aClient['email'] : $email;
                }
                $aReference['email']        = $email;
                
                $startDate  = $aReference['transaction_initiation_date'];
                $endDate    = isset($aReference['end_date']) ? $aReference['end_date'] : date('Y-m-d') ;

                $aCredits   = transactionhandle_model::singleton()->listRelateClientCreditLog($clientId, $startDate, $endDate);
                $aInvoices  = transactionhandle_model::singleton()->listRelateClientInvoice($clientId, $endDate, $startDate, 0, 'ASC', 1000);
                
                $aActivity  = array();

                foreach ($aCredits as $arr) {
                    $date   = strtotime($arr['date']);
                    $aActivity[$date]   = $arr;
                }

                foreach ($aInvoices as $arrs) {
                    foreach ($arrs as $arr) {
                        $date   = strtotime($arr['date']);
                        $aActivity[$date]   = $arr;
                    }
                }
                
                ksort($aActivity);

                $aData_     = array(
                    'aReference'        => $aReference,
                    'aActivity'         => $aActivity,
                );

                array_push($aData, $aData_);

            }

            $aDatas[$transId]   = $aData;
        
        }

        //echo '<pre>'.print_r($aDatas, true).'</pre>';

        $this->template->assign('aActivityDatas', $aDatas);
        $this->template->assign('aEventCode', $this->aEventCode);
        $this->template->assign('transaction', $transaction);
        
        $this->_default($request);
    }
    

    
}