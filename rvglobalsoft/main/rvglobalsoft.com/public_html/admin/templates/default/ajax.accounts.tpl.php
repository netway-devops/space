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

// --- Get template variable ---
$aAccounts          = $this->get_template_vars('accounts');
$aAccountAddons     = $this->get_template_vars('account_addons');
// --- Get template variable ---
if (is_array($aAccounts) && count($aAccounts)) {

    foreach ($aAccounts as $k => $aAccount) {

        $post = array(
            'call'      => 'module',
            'module'    => 'billingcycle',
            'fn'        => 'getAccountExpiryDate',
            'accountId' => $aAccount['id'],
            'nextDue'   => $aAccount['next_due']
        );
        $result = $apiCustom->request($post);

        if (isset($result['error'])) {
              $aAccounts[$k]['error']      = implode(' ', $result['error']);
        } elseif (isset($result['expire'])) {
              $aAccounts[$k]['expire']     = $result['expire'];
              $aAccounts[$k]['color']      = $result['color'];
        }

        $postIp = array(
            'call'      => 'module',
            'module'    => 'ipproductlicense',
            'fn'        => 'getIP',
            'accountId' => $aAccount['id']
        );
        $resultIp = $apiCustom->request($postIp);
        if (isset($resultIp['ip'])) {
              $aAccounts[$k]['ip']      = $resultIp['ip'];
        }

        $getSSLWhmcsOrder = $db->query("SELECT so.comment AS ssl_comment FROM hb_accounts AS a, hb_ssl_order AS so WHERE a.id = {$aAccount['id']} AND a.order_id = so.order_id")->fetch();
        if($getSSLWhmcsOrder && $getSSLWhmcsOrder['ssl_comment'] == 'order from WHMCS'){
        	$aAccounts[$k]['whmcs_order'] = true;
        }

    }
}

$this->assign('aAccounts', $aAccounts);


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

