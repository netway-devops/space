<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/accounthandle/admin/class.accounthandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Custom helper ---
require_once(APPDIR . 'class.api.custom.php');
$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

// --- Get template variable ---
$aAccounts          = $this->get_template_vars('accounts');
$aAccountAddons     = $this->get_template_vars('account_addons');
// --- Get template variable ---


if (isset($_GET['list']) && $_GET['list'] == 'all_suspended') {
    $aOrder         = isset($_GET['orderby']) ? explode('|', $_GET['orderby']) : array('expiry_date','ASC');
    $aOrder[0]      = ($aOrder[0] == 'status') ? 'expiry_date' : $aOrder[0];
    $orderby        = $aOrder[0];
    $order          = $aOrder[1];
    $limit          = 25;
    $offset         = isset($_GET['page']) ? ($_GET['page'] - 1) * $limit : 0;
    if (isset($_POST['page'])) {
        $offset     = $_POST['page'] * $limit;
    }
    $aAccounts      = accounthandle_controller::singleton()->listAccountSuspended($orderby, $order, $offset, $limit);
    $this->assign('accounts', $aAccounts);
}

$aExpAccounts      = accounthandle_controller::singleton()->listAccountExpiryDate($aAccounts);
$this->assign('aExpAccounts', $aExpAccounts);

/**
 * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
 */
if (is_array($aAccountAddons) && count($aAccountAddons)) {
    foreach ($aAccountAddons as $aAddon) {
        $accountAddonId     = $aAddon['id'];
        
        if ($aAddon['status'] == 'Active') {
            
            $result     = $db->query("
                        SELECT 
                            ii.id, ii.is_shipped
                        FROM 
                            hb_accounts_addons aa,
                            hb_invoice_items ii
                        WHERE 
                            aa.id = :accountAddonId
                            AND aa.id = ii.item_id
                            AND ii.type = 'Addon'
                        ORDER BY ii.id DESC 
                        LIMIT 1
                        ", array(
                            ':accountAddonId' => $accountAddonId
                        ))->fetch();
            
            if (isset($result['id']) && $result['id'] && ! $result['is_shipped']) {
                $db->query("
                    UPDATE hb_invoice_items 
                    SET is_shipped = 1
                    WHERE id = :invoiceItemId
                ", array(
                    ':invoiceItemId'    => $result['id']
                ));
            }
            
        }
        
    }
}


/* --- เพิ่ม การแสดงผลค่า Internal netway และ hypervisor --- */
$aAccounts      = accounthandle_controller::singleton()->internalNetwayHypervisor($aAccounts);
$this->assign('aAccounts', $aAccounts);

if (count($aAccounts)) {
    $products   = '0';
    foreach ($aAccounts as $arr) {
        $products   .= '\',\''. $arr['product_id'];
    }
    $aCategory  = array();
    $result     = $db->query("
        SELECT p.id, c.name
        FROM hb_products p,
            hb_categories c
        WHERE p.id IN ('{$products}')
            AND p.category_id = c.id
        ")->fetchAll();
    foreach ($result as $arr) {
        $aCategory[$arr['id']]  = $arr['name'];
    }
    foreach ($aAccounts as $k => $arr) {
        $aAccounts[$k]['productCategory']  = $aCategory[$arr['product_id']];
    }
}
$this->assign('aAccounts', $aAccounts);

//echo '<pre>'. print_r($aAccounts, true) .'</pre>';