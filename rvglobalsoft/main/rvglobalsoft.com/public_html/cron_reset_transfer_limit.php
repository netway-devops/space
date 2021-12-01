<?php
require('includes/hostbill.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---
$query = sprintf("
            UPDATE
                %s     
            SET 
                icount = %s,
                date_update = %s
            "
            , 'hb_transfer_limit'
            , 0
            , time()
            );
if ($db->query($query)) { 
    sendMailToMgr(array('res'=>'ok'));
} else {
    sendMailToMgr(array('res'=>'Error'));
} 

function sendMailToMgr($aParam)
    {
        $frmMail = 'admin@rvglobalsoft.com';
        
        $subject    = 'mail จาก cron reset Limited transfer Year::'.$aParam['res'];
        $message    = "\n" . 'รายละเอียด' ;
        $mailto = 'paisarn@netway.co.th';
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: ' . $frmMail . "\r\n" .
                'Reply-To: ' . $frmMail . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        if (@mail($mailto, $subject, $message, $header)) {
            return true;
        } else {
            return false;
        }
    }

