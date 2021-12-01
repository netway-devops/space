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
/*$result = $db->query("
                        SELECT count(*) as num
                        FROM hb_chat_staff2
                        WHERE status != 'Offline' 
                    ")->fetch();
                    
 if($result['num'] != 0){
     $isOnline = 1;
 }
 $this->assign('isOnline',$isOnline);
*/

if($aClient['email'] != ''){
    //จุดนี้ควรทำการ cache $emailSignature
    $emailSignature =  hash_hmac('sha256', $aClient['email'], CUSTOMER_VERIFIED_KEY);
    $this->assign('emailSignature', $emailSignature);
}

if ($_SESSION['logoutClient']=='logout' ) {
    $logoutClient = $_SESSION['logoutClient'];
    $this->assign('logoutClient', $logoutClient);
}