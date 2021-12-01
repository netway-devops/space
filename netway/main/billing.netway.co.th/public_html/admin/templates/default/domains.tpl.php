<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR_MODULES . 'Site/domainhandle/admin/class.domainhandle_controller.php');
require_once(APPDIR . 'modules/Site/fulfillmenthandle/admin/class.fulfillmenthandle_controller.php');
require_once(APPDIR . 'modules/Site/invoicehandle/model/class.invoicehandle_model.php');
require_once(APPDIR . 'modules/Site/addresshandle/admin/class.addresshandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aDetails   = $this->get_template_vars('details');
$showRenew  = $this->get_template_vars('showrenew');
$aDomains   = $this->get_template_vars('domains');
// --- Get template variable ---

$zat        = isset($_GET['zat']) ? $_GET['zat'] : 0;
$this->assign('zat', $zat);

/* -- verify rv custom template domain forwarding details*/
$this->assign('rvdomainforwardingdetails', APPDIR_MODULES . 'Other/netway_common/templates/domain/admin/domainforwardingdetails.tpl');

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
if ($domainId) {
    
    // --- ถ้า domain active ให้ close fulfillment ticket ---
    fulfillmenthandle_controller::singleton()->domainActiveFulfillmentTicketClose($aDetails);
    
    // staff กด command
    fulfillmenthandle_controller::singleton()->domainFulfillmentProcess($aDetails);
    fulfillmenthandle_controller::singleton()->domainFulfillmentProcessSuccess($aDetails);
    $result     = fulfillmenthandle_controller::singleton()->domainFulfillmentTicket($aDetails);
    $this->assign('aFulfillmentTicket', $result);
}

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



/* --- แสดง notification contact --- */
$result     = $db->query("
        SELECT
            ca.id, ca.email,
            cd.firstname, cd.lastname, cd.phonenumber, cd.notes,
            cp.privileges
        FROM
            hb_client_privileges cp,
            hb_client_details cd,
            hb_client_access ca
        WHERE
            cp.client_id = cd.id
            AND cd.id = ca.id
            AND cd.parent_id = :clientId
            AND ( cp.privileges LIKE :keyword OR cp.privileges LIKE :keyword2)
        ", array(
            ':clientId'     => $aDetails['client_id'],
            ':keyword'      => '%s:7:"domains"%i:'. $domainId .'%s:6:"notify";i:1%',
            ':keyword2'     => '%s:7:"domains"%i:'. $domainId .'%s:6:"notify";s:1:"1"%'
        ))->fetchAll();
/* --- filter result ที่ไม่เกี่ยวข้องทิ้ง --- */
if (count($result)) {
    foreach ($result as $k => $v) {
        $aPrivileges        = unserialize($v['privileges']);
        if (! isset($aPrivileges['domains'][$domainId]['notify']) || ! $aPrivileges['domains'][$domainId]['notify']) {
            unset($result[$k]);
        }
    }
}
$this->assign('aNotifiyPersons', $result);


/* --- ข้อมูล billing address --- */
if ($domainId) {
    $clientAddress      = '';
    $billingAddress     = '';
    $mailingAddress     = '';
    $billingContactId   = $aDetails['billing_contact_id'];
    $mailingContactId   = $aDetails['mailing_contact_id'];

    $aContact       = addresshandle_controller::singleton()->getContactAddressFronContactId($billingContactId);
    $billingAddress = isset($aContact['billingAddress']) ? $aContact['billingAddress'] : '';
    $mailingAddress = isset($aContact['mailingAddress']) ? $aContact['mailingAddress'] : '';
    if (! isset($aContact['isChangeMailto']) || ! $aContact['isChangeMailto']) {
        $mailingAddress     = $billingContactId ? 'ใช้ข้อมูลเดียวกับ billing address' : '';
    }
    if ($mailingContactId != $billingContactId) {
        $aContact       = addresshandle_controller::singleton()->getContactAddressFronContactId($mailingContactId);
        $mailingAddress = isset($aContact['mailingAddress']) ? $aContact['mailingAddress'] : '';
    }
    
    $this->assign('clientAddress', $clientAddress);
    $this->assign('billingAddress', $billingAddress);
    $this->assign('mailingAddress', $mailingAddress);
}

/* --- โดเมนถูกตั้ง auto renew หรือเปล่า --- */
$result         = $db->query("
        SELECT
            dr.id
        FROM
            hb_domain_renew dr
        WHERE
            dr.id = :domainId
            AND dr.is_auto_renew = 1
        ", array(
            ':domainId'     => $domainId
        ))->fetch();
$isDomainAutoRenewByRegistrar   = isset($result['id']) ? 1 : 0;
$this->assign('isDomainAutoRenewByRegistrar', $isDomainAutoRenewByRegistrar);

/**ตรวจสอบว่า nameserver อยู่ที่เราหรือเปล่า**/
$chNameServer = 0;
foreach($aDetails['nameservers'] as $nameServer){
	if($nameServer == '') continue;
	if (preg_match('/ns1.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns2.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns3.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns4.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns1.thaidomainname.com/i', $nameServer)
                           || preg_match('/ns2.thaidomainname.com/i', $nameServer)
                           || preg_match('/ns.thaidns.net/i', $nameServer)
                           || preg_match('/ns1.thaidns.net/i', $nameServer)
                           || preg_match('/ns1.netway.co.th/i', $nameServer)
                           || preg_match('/ns2.netway.co.th/i', $nameServer)
                           || preg_match('/ns1.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns2.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns3.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns4.netwaygroup.com/i', $nameServer)
                           || preg_match('/ns3.netway.co.th/i', $nameServer)
                           || preg_match('/ns9.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns10.siaminterhost.com/i', $nameServer)
                           || preg_match('/ns1.hostingfree.in.th/i', $nameServer)
                           || preg_match('/ns2.hostingfree.in.th/i', $nameServer)
                           || preg_match('/ns3.thaihostunlimited.com/i', $nameServer)
                           || preg_match('/ns4.thaihostunlimited.com/i', $nameServer)
                       ) {
                       	 $chNameServer = 1;
                       }else{
                       	 $chNameServer = 0;
                       }
}

$this->assign('chNameServer', $chNameServer);

// --- ถ้าไม่มี date create แล้ว status = Active ให้ update ให้ด้วย ---
if ($domainId) {
    domainhandle_controller::updateDateCreated($aDetails);
}

//echo '<pre>'.print_r($aDetails, true).'</pre>';exit;
