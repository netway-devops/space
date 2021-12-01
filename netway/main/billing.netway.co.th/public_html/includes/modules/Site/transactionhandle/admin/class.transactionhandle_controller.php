<?php
use GuzzleHttp\Client;

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
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }

    public function hookAfterTransactionAdd ($data)
    {

        /**
         * ถ้าเลือกชำระเงินเป็น BankTransfer แล้วลูกค้าจ่ายเป็น Cheque
         * จะทำการบันทึกข้อมูลเกี่ยวกับ Cheque ลง description ของ transaction นั้นด้วย
         */
         $this->_AfterTransactionAdd_updateCheque($data);

        /**
         * ทำการบันทึกว่าถ้ามีค่าธรรมเนียมในการ add payment ให้บันทึกด้วยว่าเกี่ยวกับอะไร
         * โดยจะแยกค่าเป็น code:message บันทึกกันคนละ field
         */
         $this->_AfterTransactionAdd_updateCodeMessage($data);

        /* --- แก้ปัญหาตอน add transaction แล้ว trans_id ถูก gen ใหม่แทนที่จะใช้ค่าที่กรอก --- */
        $this->_AfterTransactionAdd_updateTransactionId($data);

    }

    public function _AfterTransactionAdd_updateCheque ($data)
    {
        if (isset($_POST['newpayment']['is_cheque']) && $_POST['newpayment']['is_cheque']) {
    
            $notic      = 'ลูกค้าจ่ายด้วย Cheque ของธนาคาร: ' . $_POST['newpayment']['cheque_bank']
                        . ' หมายเลขเช็ค: ' . $_POST['newpayment']['cheque_no']
                        . "\n";
            transactionhandle_model::singleton()->updateLatestTransactionDescription($notic);            
        }
    }

    public function _AfterTransactionAdd_updateCodeMessage ($data)
    {
        if (isset($_POST['newpayment']['feeType']) && $_POST['newpayment']['feeType'] && $_POST['newpayment']['fee'] > 0) {
    
            $aFee       = @explode(':', $_POST['newpayment']['feeType']);
            $feeCode    = $aFee[0];
            $feeMessage = $aFee[1];
            
            if ($feeCode == 'B01') {
                $pre = '-';
            } else {
                $pre = '';
            }
            
            transactionhandle_model::singleton()->updateLatestTransactionCodeMessage($pre, $feeCode, $feeMessage);            
        }
    }

    public function _AfterTransactionAdd_updateTransactionId ($data)
    {
        if (isset($_POST['trans_id']) && $_POST['trans_id']) {
    
            $transId    = $_POST['trans_id'];
            transactionhandle_model::singleton()->updateLatestTransactionId($transId);            
        }
    }

}