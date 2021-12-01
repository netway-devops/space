<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aCategories    = $this->get_template_vars('categories');
// --- Get template variable ---

$aProducts      = array();

if (count($aCategories)) {
    $aCats      = array();
    
    foreach ($aCategories as $arr) {
        array_push($aCats, $arr['id']);
    }
    
    $result     = $db->query("
            SELECT
                p.*
            FROM
                hb_products p
            WHERE
                1
            ORDER BY p.sort_order ASC
            ")->fetchAll();
    if (count($result)) {
        foreach ($result as $aData) {
            $catId          = $aData['category_id'];
            $id             = $aData['id'];
            $aProducts[$catId][$id]['name']     = $aData['name'];
        }
    }
    
    $this->assign('aProducts', $aProducts);
}

$aProducts   = $this->get_template_vars('products');
foreach($aProducts as $k => $aProduct){
    $result_d[$k]['active']   = $db->query("
                                                select count(status) as activeAcc 
                                                from hb_domains 
                                                where tld_id = {$k}
                                                AND status = 'Active'
                                                ")->fetch();
    
    $result_d[$k]['pending']   = $db->query("
                                                select count(status) as pendingAcc 
                                                from hb_domains 
                                                where tld_id = {$k}
                                                AND status = 'Pending'
                                                ")->fetch();
    $result_d[$k]['pendingTransfer']   = $db->query("
                                                select count(status) as pendingTransferAcc 
                                                from hb_domains 
                                                where tld_id = {$k}
                                                AND status = 'Pending Transfer'
                                                ")->fetch();
                                                
    $result_d[$k]['expired']   = $db->query("
                                                select count(status) as expiredAcc 
                                                from hb_domains 
                                                where tld_id = {$k}
                                                AND status = 'Expired'
                                                ")->fetch(); 
                                                
    $result_d[$k]['cancelled']   = $db->query("
                                                select count(status) as cancelledAcc 
                                                from hb_domains 
                                                where tld_id = {$k}
                                                AND status = 'Cancelled'
                                                ")->fetch();                                                                                             
}

$this->assign('aProductsStatus_d', $result_d);

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
