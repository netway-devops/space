<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Custom helper ---
require_once(APPDIR . 'class.api.custom.php');
require_once(APPDIR . 'modules/Site/accounthandle/admin/class.accounthandle_controller.php');

$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

// --- Get template variable ---
$aDetails   = $this->get_template_vars('details');
// --- Get template variable ---

$productId  = $aDetails['product_id'];
$accountId  = $aDetails['id'];

if ( isset($aDetails['id']) && $aDetails['id'] ) {

        $post = array(
            'call'      => 'module',
            'module'    => 'billingcycle',
            'fn'        => 'getAccountExpiryDate',
            'accountId' => $aDetails['id'],
            'nextDue'   => $aDetails['next_due']
        );
        $result = $apiCustom->request($post);
        
        if (isset($result['error'])) {
              $aDetails['error']      = implode(' ', $result['error']);
        } elseif (isset($result['expire'])) {
              $aDetails['expire']     = $result['expire'];
              $aDetails['color']      = $result['color'];
        }
}

$this->assign('aDetails', $aDetails);

/**
 * Provisioning privilege
 */

$categoryId = 0;
$result     = $db->query("
            SELECT p.category_id
            FROM hb_products p
            WHERE p.id = :productId
            ", array(
               ':productId' => $productId
            ))->fetch();
if (isset($result['category_id']) && $result['category_id']) {
    $categoryId     = $result['category_id'];
}
$this->assign('provisionPrivilege', 'provision' . $categoryId);



/**
 * Update invoice item  is_shipped ว่าได้จัดส่งสินค้า แล้ว
 */
if ($aDetails['status'] == 'Active') {
    
    
    $result     = $db->query("
                SELECT 
                    ii.id, ii.is_shipped
                FROM 
                    hb_accounts a,
                    hb_invoice_items ii
                WHERE 
                    a.id = :accountId
                    AND a.id = ii.item_id
                    AND ii.type = 'Hosting'
                ORDER BY ii.id DESC 
                LIMIT 1
                ", array(
                    ':accountId' => $accountId
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

if (preg_match('/transfer/i', $aDetails['status'])) {
    $allowtransfer      = 1;
    $this->assign('allowtransfer', $allowtransfer);
}

// --- Fixbug ถ้าไมไ่ด้เลือก Dedicated IP ไม่ต้องให้แสดงใน invoice ต้องลย record นั้นออกเลย ---
if ($accountId) {
    $result     = accounthandle_controller::singleton()->manageConfig2Account($accountId);
    if ($result) {
        echo '<script language="javascript">window.location="?cmd=accounts&action=edit&id='. $accountId .'";</script>';
        exit;
    }
}
//echo '<pre>'.print_r($result,true).'</pre>';