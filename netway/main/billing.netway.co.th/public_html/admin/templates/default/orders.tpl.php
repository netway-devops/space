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
$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

$aDetails   = $this->get_template_vars('details');

/**
 * Provisioning
 */

$aProvisioning  = array('domains', 'hosting');

foreach ($aProvisioning as $provisionType) {
    if (isset($aDetails[$provisionType]) && count($aDetails[$provisionType])) {
        $aItems   = $aDetails[$provisionType];
        foreach ($aItems as $i => $aItem) {
            $categoryId = 0;
            $productId  = 0;
            if ($provisionType == 'domains') {
                $result     = $db->query("
                            SELECT d.tld_id
                            FROM hb_domains d
                            WHERE d.id = :domainId
                            ", array(
                               ':domainId' => $aItem['id']
                            ))->fetch();
                if (isset($result['tld_id']) && $result['tld_id']) {
                    $productId  = $result['tld_id'];
                }
            } else {
                $productId  = $aItem['product_id'];
            }
            
            if ( ! $productId) {
                continue;
            }
            
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
            
            $aDetails[$provisionType][$i]['provisionPrivilege']  = 'provision' . $categoryId;
        }
    }
}

$this->assign('aDetails', $aDetails);

/* --- Version: 27-06-2014 Bugs Fixed 
 * [Orders] If admin choose not to send invoice on order creation, it is sent 5min after using cron
 * 
 --- */
if (isset($aDetails['invoice_id']) && $aDetails['invoice_id']) {
    $db->query("
        UPDATE hb_invoices 
        SET flags = '0' 
        WHERE id = :invoiceId
        ", array(
            ':invoiceId'    => $aDetails['invoice_id']
        ));
}

