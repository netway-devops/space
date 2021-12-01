<?php

require_once(APPDIR .'class.cache.extend.php');
require_once(APPDIR_MODULES . 'Other/paypalsubscriptionlog/model/class.paypalsubscriptionlog_model.php');

class paypalsubscriptionlog_controller extends HBController {
    
    
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
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function download ($request)
    {
        $db         = hbm_db();

        $result     = paypalsubscriptionlog_model::singleton()->latest();
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function verify ($request)
    {
        $db         = hbm_db();
        $transactionId      = (isset($request['transactionId'])) ? $request['transactionId'] : '';
        
        $db->query("
            UPDATE hb_paypal_subscription_log
            SET is_manual_verify = 1
            WHERE transaction_id = :transaction_id
            ", array(
                ':transaction_id'   => $transactionId
            ));
        
        header('location:?cmd=paypalsubscriptionlog&action=detail&transactionId='. $transactionId);
        exit;
    }
    
    public function detail ($request)
    {
        $db         = hbm_db();
        
        $transactionId  = (isset($request['transactionId'])) ? $request['transactionId'] : '';
        $isPreVerify    = (isset($request['verify'])) ? $request['verify'] : 0;
        
        $result     = $db->query("
            SELECT *
            FROM hb_transactions
            WHERE trans_id = '{$transactionId}'
            ")->fetch();
        
        $aTran      = $result;
        
        $result     = $db->query("
            SELECT *
            FROM hb_paypal_subscription_log
            WHERE transaction_id = '{$transactionId}'
            ")->fetch();
        
        $aTranLog   = $result;
        
        $invoiceId  = $aTran['invoice_id'];
        
        $result     = $db->query("
            SELECT *
            FROM hb_transactions
            WHERE invoice_id = '{$invoiceId}'
            ")->fetchAll();
        
        $aTransactions  = $result;
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE id = '{$invoiceId}'
            ")->fetch();
        
        $aInvoice   = $result;
        
        $result     = $db->query("
            SELECT *
            FROM hb_invoice_items
            WHERE invoice_id = '{$invoiceId}'
            ")->fetchAll();
        
        $aItems     = $result;
        
        $aItemId    = array();
        $isCredit   = 0;
        foreach ($aItems as $arr) {
            if ($arr['type'] == 'Credit') {
                $isCredit   = 1;
            }
            if ($arr['type'] != 'Hosting') {
                continue;
            }
            array_push($aItemId, $arr['item_id']);
        }
        array_push($aItemId, -1);
        
        if ($aTranLog['invoice_id']) {
            
            $result     = $db->query("
                SELECT *
                FROM hb_transactions
                WHERE invoice_id = '". $aTranLog['invoice_id'] ."'
                ")->fetchAll();
            
            $aTransactions2 = $result;
            
            $result     = $db->query("
                SELECT *
                FROM hb_invoices
                WHERE id = '". $aTranLog['invoice_id'] ."'
                ")->fetch();
            
            $aInvoice2  = $result;
            
            $result     = $db->query("
                SELECT *
                FROM hb_invoice_items
                WHERE invoice_id = '". $aTranLog['invoice_id'] ."'
                ")->fetchAll();
            
            $aItems2    = $result;
            
            foreach ($aItems2 as $arr) {
                if ($arr['type'] != 'Hosting') {
                    continue;
                }
                array_push($aItemId, $arr['item_id']);
            }
            
        }
        
        $result     = $db->query("
            SELECT a.*, p.name
            FROM hb_accounts a,
                hb_products p
            WHERE a.id IN (". implode(',', $aItemId) .")
                AND a.product_id = p.id
            ")->fetchAll();
        
        $aAccounts  = $result;
        
        $result     = $db->query("
            SELECT ii.*
            FROM hb_invoice_items ii,
                hb_invoices i
            WHERE ii.item_id IN (". implode(',', $aItemId) .")
                AND ii.invoice_id = i.id
                AND ii.type = 'Hosting'
            ORDER BY i.id DESC
            LIMIT 10
            ")->fetchAll();
        
        $aAccountInvs   = array();
        $aInvoiceId     = array();
        foreach ($result as $arr) {
            if (! isset($isSingleInvoice)) {
                $isSingleInvoice    = $arr['invoice_id'];
            }
            if ($isSingleInvoice != $arr['invoice_id']) {
                $isSingleInvoice    = 0;
            }
            array_push($aInvoiceId, $arr['invoice_id']);
        }
        
        $isVerify   = 0;
        if (isset($isSingleInvoice) && $isSingleInvoice) {
            $isVerify   = 1;
        }
        
        array_push($aInvoiceId, -1);
        
        foreach ($aInvoiceId as $invId) {
            $result     = $db->query("
                SELECT *
                FROM hb_invoices
                WHERE id = '{$invId}'
                ")->fetch();
            
            $aInv       = $result;
            
            $result     = $db->query("
                SELECT *
                FROM hb_invoice_items
                WHERE invoice_id = '{$invId}'
                ")->fetchAll();
            
            $aInvItems  = $result;
            
            foreach ($result as $arr) {
                $accId  = $arr['item_id'];
                $aAccountInvs[$accId][$invId]['aInv']       = $aInv;
                $aAccountInvs[$accId][$invId]['aInvItems']  = $aInvItems;
            }
        }
        
        if (count($aTransactions) == 1) {
            $isVerify   = 1;
        }
        
        $result     = $db->query("
            SELECT ccl.*, cd.firstname, cd.lastname
            FROM hb_client_credit_log ccl,
                hb_client_details cd
            WHERE ccl.transaction_id = '{$transactionId}'
                AND ccl.client_id = cd.id
            ")->fetch();
        
        $aCredit    = $result;
        
        $result     = $db->query("
            SELECT ccl.*, cd.firstname, cd.lastname
            FROM hb_client_credit_log ccl,
                hb_client_details cd
            WHERE ccl.invoice_id = '{$invoiceId}'
                AND ccl.client_id = cd.id
            ")->fetch();
        
        $aCredit2   = $result;
        
        
        if ($isCredit) {
            // เป็น add fund ไม่ต้องตรวจสอบ แล้ว
            // $isVerify   = 0;
        }
        
        if ($isVerify) {
            $db->query("
                UPDATE hb_paypal_subscription_log
                SET is_manual_verify = 1
                WHERE transaction_id = '{$transactionId}'
                ");
            $aTranLog['is_manual_verify']   = 1;
        }
        
        if ($isPreVerify) {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', json_encode($aTranLog));
            $this->json->show();
        }
        
        $this->template->assign('transactionId', $transactionId);
        $this->template->assign('aTran', $aTran);
        $this->template->assign('aTranLog', $aTranLog);
        $this->template->assign('aInvoice', $aInvoice);
        $this->template->assign('aItems', $aItems);
        $this->template->assign('aAccounts', $aAccounts);
        $this->template->assign('aTransactions', $aTransactions);
        $this->template->assign('aAccountInvs', $aAccountInvs);
        $this->template->assign('aCredit', $aCredit);
        
        $this->template->assign('aInvoice2', $aInvoice2);
        $this->template->assign('aItems2', $aItems2);
        $this->template->assign('aTransactions2', $aTransactions2);
        $this->template->assign('aCredit2', $aCredit2);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/detail.tpl',array(), true);
    }
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}