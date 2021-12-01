<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

$aEmails         = $this->get_template_vars('emails');

foreach($aEmails as $email){
    $isRead     = $db->query("
                    SELECT ccl.id, ccl.is_read
                    FROM hb_client_credit_log ccl
                    WHERE ccl.id = :id
                    ",array(
                    ':id'    => $email['id']
            ))->fetch();
    $aRead[$email['id']]    =  $isRead;                   
}

$this->assign('aRead', $aRead);

/*มีการคลิ๊กมาจาก staff home*/
if(isset($_GET['markasread']) && $_GET['markasread'] == '1'){

            $db->query("
                    UPDATE 
                        hb_client_credit_log
                    SET 
                        is_read = 1
                    WHERE 
                        is_read = 0
                    ");              
}

