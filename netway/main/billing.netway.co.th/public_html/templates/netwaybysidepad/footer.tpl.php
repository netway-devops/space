<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aClient    = hbm_logged_client();
// --- hostbill helper ---

$this->assign('aClient', $aClient);

$isOnline = 0;
$result = $db->query("
                        SELECT count(*) as num
                        FROM hb_chat_staff2
                        WHERE status != 'Offline' 
                    ")->fetch();
                    
 if($result['num'] != 0){
     $isOnline = 1;
 }
 $this->assign('isOnline',$isOnline);
