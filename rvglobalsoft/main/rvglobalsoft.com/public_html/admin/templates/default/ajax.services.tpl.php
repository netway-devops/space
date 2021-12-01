<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

$db         = hbm_db();
$aProducts   = $this->get_template_vars('products');
foreach($aProducts as $k => $aProduct){
    $result[$k]['active']   = $db->query("
                                                select count(status) as activeAcc 
                                                from hb_accounts 
                                                where product_id = {$k}
                                                AND status = 'Active'
                                                ")->fetch();
    
    $result[$k]['pending']   = $db->query("
                                                select count(status) as pendingAcc 
                                                from hb_accounts 
                                                where product_id = {$k}
                                                AND status = 'Pending'
                                                ")->fetch();
    
    $result[$k]['suspended']   = $db->query("
                                                select count(status) as suspendedAcc 
                                                from hb_accounts 
                                                where product_id = {$k}
                                                AND status = 'Suspended'
                                                ")->fetch();  
                                                
    $result[$k]['terminated']   = $db->query("
                                                select count(status) as terminatedAcc 
                                                from hb_accounts 
                                                where product_id = {$k}
                                                AND status = 'Terminated'
                                                ")->fetch(); 
                                                
    $result[$k]['cancelled']   = $db->query("
                                                select count(status) as cancelledAcc 
                                                from hb_accounts 
                                                where product_id = {$k}
                                                AND status = 'Cancelled'
                                                ")->fetch();                                              
                                                
}


$this->assign('aProductsStatus', $result);
