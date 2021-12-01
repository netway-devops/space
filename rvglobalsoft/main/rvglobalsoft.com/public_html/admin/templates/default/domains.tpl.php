<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aDetails   = $this->get_template_vars('details');
$showRenew  = $this->get_template_vars('showrenew');
$aDomains   = $this->get_template_vars('domains');
// --- Get template variable ---

function nwGenerateCode($characters = 8) {
    /* list all possible characters, similar looking characters and vowels have been removed */
    if ($characters == 6) {
        $possible = 'abcdefghijklmnopqrstuvwxyz';
    } else {
        $possible = '0123456789abcdefghijklmnopqrstuvwxyz';
    }
    $code = '';
    $i = 0;
    while ($i < $characters) { 
        $code .= substr($possible, mt_rand(0, strlen($possible)-1), 1);
        $i++;
    }
    return $code;
}

/**
 * Domain user
 */

$domainId       = $aDetails['id'];

$regUsername    = '';
$regPassword    = '';

if (isset($aDetails['custom']) && count($aDetails['custom'])) {
    foreach ($aDetails['custom'] as $key => $aCustom) {
       if ( ! isset($aCustom['variable']) || ! $aCustom['variable']) {
           continue;
       }
       
       if ($aCustom['variable'] == 'reg_username') {
           $itemId      = $aCustom['items'][0]['id'];
           $username    = $aCustom['data'][$itemId];
           if ($username == '') {
              $regUsername    = nwGenerateCode(6);
              $db->query("
                UPDATE hb_config2accounts
                SET data = :regUsername
                WHERE rel_type = 'Domain'
                    AND account_id = :domainId
                    AND config_id = :configId
                ", array(
                    ':regUsername'  => $regUsername,
                    ':domainId'     => $domainId,
                    ':configId'     => $itemId
                ));
           }
       }
       
       if ($aCustom['variable'] == 'reg_password') {
           $itemId      = $aCustom['items'][0]['id'];
           $password    = $aCustom['data'][$itemId];
           if ($password == '') {
              $regPassword    = nwGenerateCode();
              $db->query("
                UPDATE hb_config2accounts
                SET data = :regPassword
                WHERE rel_type = 'Domain'
                    AND account_id = :domainId
                    AND config_id = :configId
                ", array(
                    ':regPassword'  => $regPassword,
                    ':domainId'     => $domainId,
                    ':configId'     => $itemId
                ));
           }
       }
       
    }
}

$this->assign('regUsername', $regUsername);
$this->assign('regPassword', $regPassword);

/**
 * Auto renew status
 */
$isAutoRenew    = 0;
$genInvoiceDate = 0;
$productId      = $aDetails['tld_id'];
$expires        = strtotime($aDetails['expires']);

$result     = $db->query("
          SELECT dp.not_renew
          FROM hb_domain_prices dp
          WHERE dp.product_id = :productId
          ", array(
               ':productId' => $productId
          ))->fetch();
if (isset($result['not_renew']) && ! $result['not_renew']) {
    $result     = $db->query("
              SELECT a.value
              FROM hb_automation_settings a
              WHERE a.item_id = :itemId
                AND a.setting = 'InvoiceGeneration'
                AND a.type = 'Domain'
              ", array(
                   ':itemId' => $productId
              ))->fetch();
   $genInvoice  = isset($result['value']) ? $result['value'] : 0;
   
   if ($expires && $genInvoice) {
       $genInvoiceDate      = strtotime('- ' . $genInvoice . ' day', $expires);
   }
   
   /*--- ดึงค่า next_due next_invoice มาใช้แทน การคำนวนจากวันที่ด้านบน ---*/
   $genInvoiceDate          = strtotime($aDetails['next_invoice']);
   
   
   if ($genInvoiceDate > time()) {
       $isAutoRenew         = ceil(($genInvoiceDate - time()) / (60*60*24));
   } else {
       $isAutoRenew         = -1;
   }
   
}

$this->assign('isAutoRenew', $isAutoRenew);
$this->assign('genInvoiceDate', date('Y-m-d', $genInvoiceDate));


/**
 * จะ renew ได้ต้องผ่าน provision ไปแล้ว 90 วัน
 */

$nwShortTermRenewal = ConfigCustom::singleton()->getValue('nwShortTermRenewal');
$this->assign('nwShortTermRenewal', $nwShortTermRenewal);

$isShortTermRenew   = false;
$orderId    = $aDetails['order_id'];
if ($showRenew || $aDetails['manual'] == 1) {
    
    $nwShortTermRenewalTime = strtotime('-' . $nwShortTermRenewal . ' day', time());

    if ($nwShortTermRenewalTime > 0) {
        
        $result     = GeneralCustom::singleton()->isDomainAllowRenewable($domainId, false);
        if (! $result) {
            $isShortTermRenew   = true;
        }
        
    }
    
}
$this->assign('isShortTermRenew', $isShortTermRenew);


/**
 * ถ้า expire ไม่เกิน 29 วัน ให้สามารถ sync domain ได้
 */

$isSyncableExpire   = false;
$isRenewableExpire  = true;
$expiredDay         = (time() - strtotime($aDetails['expires'])) / (60*60*24);
if ($aDetails['status'] == 'Expired') {
    if ($expiredDay < 29) {
        $isSyncableExpire   = true;
    } else {
        $isRenewableExpire  = false;
    }
}

$this->assign('isSyncableExpire', $isSyncableExpire);
$this->assign('isRenewableExpire', $isRenewableExpire);


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
 * มี invoice item  is_shipped ที่ต้องระบุว่าได้จัดส่งสินค้า แล้ว
 */
$aInvoiceItem   = array();
if ($aDetails['status'] == 'Active') {
    
    $result     = $db->query("
                SELECT 
                    ii.id, ii.invoice_id
                FROM 
                    hb_domains d,
                    hb_orders o,
                    hb_invoice_items ii
                WHERE 
                    d.id = :domainId
                    AND d.order_id = o.id
                    AND o.invoice_id = ii.invoice_id
                    AND ii.type = :domainType
                    AND ii.item_id = :domainId
                    AND ii.is_shipped = 0
                ", array(
                    ':domainId' => $domainId,
                    ':domainType' => 'Domain ' . $aDetails['type']
                ))->fetch();
    
    if (isset($result['id']) && $result['id']) {
        $aInvoiceItem   = $result;
    }
    
}
$this->assign('aInvoiceItem', $aInvoiceItem);

/* --- ค้นหา domain ที่หมดอายุจากการระบุวันที่ --- */
if (isset($_GET['expiryDateEnd'])) {
    $expiryDateStart    = GeneralCustom::singleton()->convertStrtotime($_GET['expiryDateStart']);
    $expiryDateEnd      = GeneralCustom::singleton()->convertStrtotime($_GET['expiryDateEnd']);
    $expiryDateStart    = $expiryDateStart ? $expiryDateStart : time();
    $expiryDateEnd      = $expiryDateEnd ? $expiryDateEnd : time();
    
    if ($expiryDateEnd) {
        
        $aDomainLists    = array();
        
        $result     = $db->query("
                SELECT 
                    d.*,
                    d.client_id AS cid,
                    cd.firstname, cd.lastname,
                    mc.module
                FROM 
                    hb_domains d
                    LEFT JOIN
                        hb_modules_configuration mc ON mc.id = d.reg_module
                    LEFT JOIN
                        hb_client_details cd ON cd.id = d.client_id
                WHERE 
                    d.expires BETWEEN :expiryDateStart AND :expiryDateEnd
                ORDER BY 
                    d.expires ASC
                ", array(
                    ':expiryDateStart'  => date('Y-m-d', $expiryDateStart),
                    ':expiryDateEnd'    => date('Y-m-d', $expiryDateEnd)
                ))->fetchAll();
       
       if (count($result)) {
           
           
           foreach ($result as $k => $v) {
               $v['currency_id']   = '0';
               array_push($aDomainLists, $v);
           }
           
           $this->assign('domains', $aDomainLists);

            /*--- Pagination ---*/
            $total          = count($result);
            $limit          = $total;
            $offset         = 0;
            $sorterpage     = 1;
            $totalpages     = ceil($total / $limit);
            $this->assign('perpage', $limit);
            $this->assign('totalpages', $totalpages);
            $this->assign('sorterrecords', $total);
            $this->assign('sorterpage', $sorterpage);
            $this->assign('sorterlow', ($offset+1));
            $this->assign('sorterhigh', (($offset+$limit) > $total) ? $total : ($offset+$limit));
            /*--- Pagination ---*/
           
       } else {
            $this->assign('domains', $aDomainLists);
       }

    }

    $this->assign('expiryDateStart', date('Y-m-d', $expiryDateStart));
    $this->assign('expiryDateEnd', date('Y-m-d', $expiryDateEnd));
}

// echo '<pre>'.print_r($aDomains, true).'</pre>';
