<?php

require_once(APPDIR .'class.cache.extend.php');


require_once(APPDIR . 'modules/Other/paypalhandle/model/class.paypalhandle_model.php');
require_once(APPDIR . 'modules/Other/paypalhandle/library/class.paypalhandle_library.php');


class paypalhandle_controller extends HBController {
    
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
        
        $aAccessToken   = array();
        $aConfig        = $this->module->configuration;

        $aAccount   = array(
            'account'       => $aConfig['PAYPAL_ACCOUNT']['value'],
            'clientId'      => $aConfig['PAYPAL_CLIENT_ID']['value'],
            'clientSecret'  => $aConfig['PAYPAL_CLIENT_SECRET']['value'],
        );
        $result     = paypalhandle_library::singleton($aConfig)->getAccesstoken($aAccount['clientId'], $aAccount['clientSecret']);

        $aAccessToken[] = array(
            'account'   => $aAccount['account'],
            'token'     => $result,
        );

        $aAccount   = array(
            'account'       => $aConfig['PAYPAL_ACCOUNT_2']['value'],
            'clientId'      => $aConfig['PAYPAL_CLIENT_ID_2']['value'],
            'clientSecret'  => $aConfig['PAYPAL_CLIENT_SECRET_2']['value'],
        );
        $result     = paypalhandle_library::singleton($aConfig)->getAccesstoken($aAccount['clientId'], $aAccount['clientSecret']);

        $aAccessToken[] = array(
            'account'   => $aAccount['account'],
            'token'     => $result,
        );
        
        $this->template->assign('aAccessToken', $aAccessToken);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function skipVerify ($request)
    {
        $db         = hbm_db();
        
        $transactionId      = isset($request['transactionId']) ? $request['transactionId'] : '';
        
        $result     = paypalhandle_model::singleton()->skipTransactionById($transactionId);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function suspendsubscription ($request)
    {
        $accountLogId       = isset($request['accountLogId']) ? $request['accountLogId'] : 0;
        
        $result     = paypalhandle_model::singleton()->suspendsubscriptionChecked($accountLogId);
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($request));
        $this->json->show();
    }
    
    public function reCheck ($request)
    {
        $aReturn    = array();
        $aReturn['message'] = ' <br />';

        $transactionId      = isset($request['transactionId']) ? trim($request['transactionId']) : '';
        $skip       = isset($request['skip']) ? trim($request['skip']) : 0;

        $result     = paypalhandle_model::singleton()->getTransactionById($transactionId);

        if (! isset($result['transaction_id']) || ! $result['transaction_id']) {
            $aReturn['message'] .= ' ไม่พบข้อมูล <br />';
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', json_encode($aReturn));
            $this->json->show();
        }

        if ($skip) {
            $aReturn['message'] .= ' ไม่ตรวจสอบ <br />';
            $aParam     = array(
                'field' => 'is_skip_verify',
                'value' => 1
            );
            paypalhandle_model::singleton()->setPaypalTransaction($transactionId, $aParam);
        }

        $result     = paypalhandle_model::singleton()->getHostbillTransactionId($transactionId);

        if (isset($result['trans_id']) && $result['trans_id']) {
            $transactionLogId   = $result['id'];

            $aReturn['message'] .= ' พบ transaction #<a href="?cmd=transactions&action=edit&id='. $result['trans_id'] .'" 
                target="_blank">'. $result['trans_id'] .'</a> ' ;
            if ($result['invoice_id']) {
                $aReturn['message'] .= ' เชื่อมกับ invoice #<a href="?cmd=invoices&action=edit&id='. $result['invoice_id'] .'" 
                    target="_blank">'. $result['invoice_id'] .'</a> ' ;
            } else {
                $aReturn['message'] .= '  ไม่มีการเชื่อมกับ invoice ' ;
            }
            $aReturn['message'] .= ' <br />';

            $aParam     = array(
                'field' => 'transaction_log_id',
                'value' => $transactionLogId
            );
            paypalhandle_model::singleton()->setPaypalTransaction($transactionId, $aParam);
            
        }

        $result     = paypalhandle_model::singleton()->getHostbillClientCreditLogId($transactionId);

        if (isset($result['transaction_id']) && $result['transaction_id']) {
            $clientCreditLogId  = $result['id'];
            
            $aReturn['message'] .= ' พบ client credit #<a href="?cmd=clientcredit&filter[client_id]='. $result['client_id'] .'" 
                target="_blank">'. $result['client_id'] .'</a> ' ;
            if ($result['invoice_id']) {
                $aReturn['message'] .= ' เชื่อมกับ invoice #<a href="?cmd=invoices&action=edit&id='. $result['invoice_id'] .'" 
                    target="_blank">'. $result['invoice_id'] .'</a> ' ;
            } else {
                $aReturn['message'] .= '  ไม่มีการเชื่อมกับ invoice ' ;
            }
            $aReturn['message'] .= ' <br />';

            $aParam     = array(
                'field' => 'client_credit_log_id',
                'value' => $clientCreditLogId
            );
            paypalhandle_model::singleton()->setPaypalTransaction($transactionId, $aParam);
            
        }

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', json_encode($aReturn));
        $this->json->show();
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}