<?php
require('includes/hostbill.php');

// --- hostbill helper ---
$client     = hbm_logged_client();
$db         = hbm_db();
$api        = new ApiWrapper();
// --- hostbill helper ---

$oClient    = (object) $client;
$aError     = array();
$oData      = isset($_POST) ? (object) $_POST : new stdClass();

// --- after form submit ---
if (isset($_POST) && isset($oData->fullname) && isset($oData->amount)) {
        
    if (! isset($oData->fullname) || $oData->fullname == '') {
        $aError['fullname']     = 'ชื่อผู้ติดต่อ';
    }
    if (! isset($oData->phone) || $oData->phone == '') {
        $aError['phone']     = 'เบอร์โทรศีพท์';
    }
    if (! isset($oData->payday) || $oData->payday == '') {
        $aError['payday']    = 'วันที่ชำระเงิน';
    }
    if (! isset($oData->payment) || $oData->payment == '') {
        $aError['payment']    = 'วิธีการชำระ';
    }
    if (! isset($oData->amount) || $oData->amount == '') {
        $aError['amount']     = 'จำนวนเงินที่ชำระค่าบริการ';
    }
    if (! isset($oData->email) || $oData->email == '') {
        $aError['email']     = 'E-mail address';
    }
    if (( ! isset($oClient->id) || ! $oClient->id) 
        && ( ! isset($_SESSION['hb_captcha']) || ! isset($oData->securecode) || $oData->securecode == '' 
            || ($oData->securecode != $_SESSION['hb_captcha']) )) {
        $aError['securecode'] = 'รหัสยืนยันไม่ถูกต้อง';
    }
    
    if ( ! count($aError)) {
        
        $_SESSION['hb_captcha'] = '';
        
        if (preg_match('/^Domain\sRegistrations/i', $oData->service)) {
            $result     = $db->query("
                SELECT id
                FROM hb_domains
                WHERE name = :name
                    AND type = 'Renew'
                ", array(
                    ':name'     => trim($oData->domainname)
                ))->fetch();
            if (isset($result['id'])) {
                $oData->service = 'Domain Renew';
            }
        }
        
        $subject    = 'แจ้งยืนยันการชำระเงิน ' . $oData->fullname;
        $message    = "\n". 'รายละเอียด'
                . "\n" . '============================================================'
                . "\n" . 'บริการที่ชำระ:    ' . $oData->service
                . "\n" . 'ชื่อโดเมน:       ' . $oData->domainname
                . "\n" . 'เลขที่สั่งซื้อ:      ' . $oData->invoiceno 
                       . ' '. (isset($oData->invoicenos) ? implode(',', $oData->invoicenos) : '')
                . "\n" . 'จำนวนเงินที่ชำระค่าบริการ:    ' . $oData->amount . ' บาท'
                . "\n" . 'วิธีการชำระ:     ' . $oData->payment
                . "\n" . 'วันที่ชำระเงิน:    ' . $oData->payday . ' ' . $oData->paytime . ' น.'
                . "\n"
                . "\n" . 'ชื่อผู้ติดต่อ:       ' . $oData->fullname
                . "\n" . 'E-mail:        ' . $oData->email
                . "\n" . 'ชื่อบริษัท:        ' . $oData->company
                . "\n" . 'เบอร์โทรศีพท์:    ' . $oData->phone
                . "\n" . 'หมายเหตุ:       '
                . "\n" . $oData->comment
                . "\n"
                . "\n" . '============================================================'
                . "\n" . 'Reference: http://www.netway.co.th/confirm-payment.php' 
                ;
                
        require_once(APPDIR . 'class.config.custom.php');
        $nwBillingDepartmentId = ConfigCustom::singleton()->getValue('nwBillingDepartmentId');
        
        $params = array(
            'name'      => $oData->fullname,
            'subject'   => $subject,
            'body'      => $message,
            'email'     => $oData->email,
            
            'dept_id'   => $nwBillingDepartmentId,
            'client_id'     => isset($oClient->id) ? $oClient->id : 0
        
        );
        //$return = $api->addTicket($params);
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: ' . $oData->email . "\r\n" .
                'Reply-To: ' . $oData->email . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        $mailto     = 'payment@netway.co.th';
        if (@mail($mailto, $subject, $message, $header)) {
            $_SESSION['notification']   = array('type' => 'success', 'message' => 'ส่งข้อมูลแจ้งยืนยันการชำระเงินเรียบร้อยแล้ว');
            header('location:confirm-payment.php');exit;
        } else {
            $_SESSION['notification']   = array('type' => 'error', 'message' => 'เกิดข้อผิดพลาดระหว่างบันทึกข้อมูล');
        }
        
    }
    
}
// --- after form submit ---

$aConfiguration     = $db->query("
                        SELECT c.value
                        FROM hb_configuration c
                        WHERE c.setting = 'InvoicePrefix'
                        ")->fetch();
$invoicePrefix      = $aConfiguration['value'];

$aServices  = $db->query("
                SELECT c.id, c.name
                FROM hb_categories c
                WHERE c.visible = 1
                ORDER BY c.sort_order ASC
                ")->fetchAll();

$aInvoices  = array();

if (isset($oClient->id) && $oClient->id) {
    
    if (! isset($oData->fullname)) {
        $oData->fullname    = $oClient->firstname . ' ' . $oClient->lastname;
    }
    if (! isset($oData->phone)) {
        $oData->phone       = $oClient->phonenumber;
    }
    if (! isset($oData->company)) {
        $oData->company     = $oClient->companyname;
    }
    if (! isset($oData->email)) {
        $oData->email       = $oClient->email;
    }
    
    $aInvoices  = $db->query("
                    SELECT inv.id, inv.date, inv.total, UNIX_TIMESTAMP(inv.date) AS date2
                    FROM hb_invoices inv
                    WHERE inv.client_id = :clientId
                        AND inv.status = 'Unpaid'
                    ORDER BY inv.id ASC
                    ", array(
                        ':clientId'    => $oClient->id
                    ))->fetchAll();
    
    if (count($aInvoices)) {
        foreach ($aInvoices as $k => $aData) {
            $y      = date('Y', $aData['date2']);
            $m      = date('m', $aData['date2']);
            eval(' $mask = "'.$invoicePrefix.'"; ');
            $aInvoices[$k]['mask']          = $mask . $aData['id'];
            $aInvoices[$k]['totalFormat']   = number_format($aData['total'], 2, '.', ',');
            
        }
    }

}

//echo '<pre>'.print_r($_SESSION,true).'</pre>';

hbm_render_page(
    'confirmpayment.tpl',
    array(
        'oClient'       => $oClient,
        'aServices'     => $aServices,
        'stamp'         => time(),
        'oData'         => $oData,
        'aError'        => $aError,
        'aInvoices'     => $aInvoices
    ),
    _t('confirmPaymentTitle')
);