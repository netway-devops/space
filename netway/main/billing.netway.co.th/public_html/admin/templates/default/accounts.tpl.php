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
require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'modules/Site/accounthandle/admin/class.accounthandle_controller.php');
require_once(APPDIR . 'modules/Site/fulfillmenthandle/admin/class.fulfillmenthandle_controller.php');
require_once(APPDIR . 'modules/Site/invoicehandle/model/class.invoicehandle_model.php');
require_once(APPDIR . 'modules/Site/addresshandle/admin/class.addresshandle_controller.php');

$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

// --- Get template variable ---
$aDetails   = $this->get_template_vars('details');
// --- Get template variable ---

$zat        = isset($_GET['zat']) ? $_GET['zat'] : 0;
$this->assign('zat', $zat);

$productId  = $aDetails['product_id'];
$accountId  = $aDetails['id'];

if ($accountId) {
    $result     = $db->query(" SELECT * FROM hb_accounts WHERE id = '{$accountId}' ")->fetch();
    $isValidRecurringAmount = isset($result['is_valid_recurring_amount']) ? $result['is_valid_recurring_amount'] : 0;
    $this->assign('isValidRecurringAmount', $isValidRecurringAmount);
    $this->assign('isValidRecurringShow', ((isset($_GET['isValidRecurringShow']) || $isValidRecurringAmount) ? 1 : 0));
    
    // --- ถ้า account active ให้ close fulfillment ticket ---
    fulfillmenthandle_controller::singleton()->accountActiveFulfillmentTicketClose($aDetails);
    
    // staff กด command
    fulfillmenthandle_controller::singleton()->accountFulfillmentProcess($aDetails);
    fulfillmenthandle_controller::singleton()->accountFulfillmentProcessSuccess($aDetails);
    $result     = fulfillmenthandle_controller::singleton()->accountFulfillmentTicket($aDetails);
    $this->assign('aFulfillmentTicket', $result);
}

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
if ($productId) {
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

/* --- แสดง notification contact --- */
if ($accountId) {
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
                AND (cp.privileges LIKE :keyword OR cp.privileges LIKE :keyword2 )
            ", array(
                ':clientId'     => $aDetails['client_id'],
                ':keyword'      => '%s:8:"services"%i:'. $accountId .'%s:6:"notify";i:1%',
                ':keyword2'     => '%s:8:"services"%i:'. $accountId .'%s:6:"notify";s:1:"1"%'
            ))->fetchAll();
    /* --- filter result ที่ไม่เกี่ยวข้องทิ้ง --- */
    if (count($result)) {
        foreach ($result as $k => $v) {
            $aPrivileges        = unserialize($v['privileges']);
            if (! isset($aPrivileges['services'][$accountId]['notify']) || ! $aPrivileges['services'][$accountId]['notify']) {
                unset($result[$k]);
            }
        }
    }
    $this->assign('aNotifiyPersons', $result);
}

/* --- ค้นหา account ที่หมดอายุจากการระบุวันที่ --- */
if (isset($_GET['expiryDateEnd'])) {
    $expiryDateStart    = GeneralCustom::singleton()->convertStrtotime($_GET['expiryDateStart']);
    $expiryDateEnd      = GeneralCustom::singleton()->convertStrtotime($_GET['expiryDateEnd']);
    $expiryDateStart    = $expiryDateStart ? $expiryDateStart : time();
    $expiryDateEnd      = $expiryDateEnd ? $expiryDateEnd : time();
    
    if ($expiryDateEnd) {
        
        $aAccountLists    = array();
        
        $result     = $db->query("
                SELECT 
                    a.*,
                    cd.firstname, cd.lastname,
                    p.name, p.type
                FROM 
                    hb_accounts a
                    LEFT JOIN
                        hb_products p ON p.id = a.product_id
                    LEFT JOIN
                        hb_client_details cd ON cd.id = a.client_id
                    LEFT JOIN
                        hb_invoice_items ii ON ii.item_id = a.id 
                            AND ii.type = 'Hosting'
                    LEFT JOIN
                        hb_invoices i ON i.id = ii.invoice_id 
                            AND i.status = 'Unpaid' 
                            AND ( i.duedate BETWEEN :expiryDateStart AND :expiryDateEnd )
                WHERE 
                    ( a.next_due BETWEEN :expiryDateStart AND :expiryDateEnd )
                    OR i.id IS NOT NULL
                ORDER BY 
                    a.next_due ASC
                ", array(
                    ':expiryDateStart'  => date('Y-m-d', $expiryDateStart),
                    ':expiryDateEnd'    => date('Y-m-d', $expiryDateEnd)
                ))->fetchAll();
       
       if (count($result)) {
           
           foreach ($result as $k => $v) {
               $v['currency_id']   = '0';
               array_push($aAccountLists, $v);
           }
           
           $this->assign('accounts', $aAccountLists);

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
            $this->assign('accounts', $aAccountLists);
       }

    }

    $this->assign('expiryDateStart', date('Y-m-d', $expiryDateStart));
    $this->assign('expiryDateEnd', date('Y-m-d', $expiryDateEnd));
}

/* --- ข้อมูล billing address --- */
if ($accountId) {
    $clientAddress      = '';
    $billingAddress     = '';
    $mailingAddress     = '';
    $billingContactId   = $aDetails['billing_contact_id'];
    $mailingContactId   = $aDetails['mailing_contact_id'];

    $isModuleBCSActive  = invoicehandle_model::singleton()->isModuleActive('billing_contact_select');
    
    if ($isModuleBCSActive) {
        $result     = invoicehandle_model::singleton()->getAccountContactId($accountId);
        $contactId  = isset($result['contact_id']) ? $result['contact_id'] : 0;
        if ($contactId) {
            $aContact       = addresshandle_controller::singleton()->getContactAddressFronContactId($contactId);
            $billingAddress = isset($aContact['billingAddress']) ? $aContact['billingAddress'] : '';
            $mailingAddress = isset($aContact['mailingAddress']) ? $aContact['mailingAddress'] : '';
            if (! isset($aContact['isChangeMailto']) || ! $aContact['isChangeMailto']) {
                $mailingAddress     = $billingContactId ? 'ใช้ข้อมูลเดียวกับ billing address' : '';
            }
        } else {
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
        }
    }
    
    
    $this->assign('clientAddress', $clientAddress);
    $this->assign('billingAddress', $billingAddress);
    $this->assign('mailingAddress', $mailingAddress);
}

if (isset($_GET['define'])) {
    
    if ($_GET['define'] == 'domainname' && $accountId) {
        $result     = $db->query("
                    SELECT a.client_id,p.id,conf.*
                    FROM hb_accounts a      
                    LEFT JOIN hb_config2accounts conf
                      ON conf.account_id = a.id 
                    LEFT JOIN hb_config_items_cat conCat 
                      ON conCat.id = conf.config_cat
                    LEFT JOIN hb_products p 
                      ON p.id = a.product_id
                    WHERE a.id = :accountId
                      AND p.category_id = 107
                      AND conCat.variable = 'domain_name'
                ", array(
                    ':accountId'  => $accountId     
                ))->fetch();
        
         if(isset($result['account_id'])){    
            $db->query("
                UPDATE
                    hb_accounts
                SET
                    domain = :data
                WHERE
                    id = :accountId
                AND client_id = :client
                AND (domain ='' OR domain ='--- undefine domainname ----' )  
                AND status != 'Terminated' 
                ", array(
                    ':accountId'    => $accountId,
                    ':data'         => $result['data'],
                    ':client'       => $result['client_id']
                ));
                
            echo '<script language="javascript">window.location="?cmd=accounts&action=edit&id='. $accountId .'";</script>';
            exit;
        }else{
            $db->query("
                UPDATE
                    hb_accounts
                SET
                    domain = '--- undefine domainname ----'
                WHERE
                    id = :accountId
                ", array(
                    ':accountId'    => $accountId
                ));
                
            echo '<script language="javascript">window.location="?cmd=accounts&action=edit&id='. $accountId .'";</script>';
            exit;
        }
    }
}


if (isset($_GET['save'])) {
    
    if ($_GET['save'] == 'checksave' && $accountId) {
        $result     = $db->query("
                    SELECT a.client_id,p.id,conf.*
                    FROM hb_accounts a      
                    LEFT JOIN hb_config2accounts conf
                      ON conf.account_id = a.id 
                    LEFT JOIN hb_config_items_cat conCat 
                      ON conCat.id = conf.config_cat
                    LEFT JOIN hb_products p 
                      ON p.id = a.product_id
                    WHERE a.id = :accountId
                      AND p.category_id = 107
                      AND conCat.variable = 'domain_name'
                ", array(
                    ':accountId'  => $accountId     
                ))->fetch();
        
         if(isset($result['account_id'])){    
            $db->query("
                UPDATE
                    hb_accounts
                SET
                    domain = :data
                WHERE
                    id = :accountId
                AND client_id = :client
                AND (domain ='' OR domain ='--- undefine domainname ----' )                
                AND status != 'Terminated' 
                ", array(
                    ':accountId'    => $accountId,
                    ':data'         => $result['data'],
                    ':client'       => $result['client_id']
                ));
            echo '<script language="javascript">window.location="?cmd=accounts&action=edit&id='. $accountId .'";</script>';
            exit;
        }
        
    }
}

/* --- ข้อมูลการ upgrade service --- */
if ($accountId) {
    $result     = $db->query("
            SELECT
                u.*
            FROM
                hb_upgrades u,
                hb_invoice_items ii,
                hb_invoices i
            WHERE
                u.account_id = :accountId
                AND u.rel_type = 'Hosting'
                AND u.id = ii.item_id
                AND ii.type = 'Upgrade'
                AND ii.invoice_id = i.id
                AND i.status = 'Unpaid'
            ", array(
                ':accountId'    => $accountId
            ))->fetch();
    
    if (isset($result['id']) && $result['id']) {
        $this->assign('isPendingUpgrade', 1);
        
        $oUpgrade       = (object) $result;
        
        $result         = $db->query("
                SELECT
                    ii.*,
                    i.date AS invoiceDate
                FROM
                    hb_invoice_items ii,
                    hb_invoices i
                WHERE
                    ii.invoice_id = i.id
                    AND i.status = 'Unpaid'
                    AND ((
                            ii.type = 'Hosting'
                            AND ii.item_id = :accountId
                        ) OR (
                            ii.type = 'Upgrade'
                            AND ii.item_id = :upgradeId
                        ))
                    
                ", array(
                    ':accountId'    => $accountId,
                    ':upgradeId'    => $oUpgrade->id
                ))->fetchAll();
        
        if (count($result)) {
            $upgradeMessage         = '';
            if (count($result) == 1 && $result[0]['type'] == 'Upgrade' && $result[0]['item_id'] == $oUpgrade->id) {
                $aInvoiceItem       = $result[0];
                
                $upgradeDay         = (strtotime($aDetails['next_due'])-strtotime($aInvoiceItem['invoiceDate']))/(60*60*24);
                $upgradePrice       = $oUpgrade->new_value - $aDetails['total'];
                $upgradeCycleDay    = GeneralCustom::singleton()->billingCycleUpgradeToDays(
                                        strtotime($aDetails['next_due']),
                                        $oUpgrade->new_billing);
                $upgradePricePerDay = $upgradePrice / $upgradeCycleDay;
                $upgradePriceTotal  = $upgradePricePerDay * $upgradeDay;
                
                $upgradeMessage     = '
                    <a href="?cmd=invoices&action=edit&id='. $aInvoiceItem['invoice_id'] .'" target="_blank">#
                    '. $aInvoiceItem['invoice_id'] .'</a> มีค่าส่วนต่าง '. $aInvoiceItem['amount'] .' บาท @
                    '. $aInvoiceItem['invoiceDate'] .' ก่อนครบรอบบิลปัจจุบัน<br />
                    โดยคำนวนจาก:<br />
                    '. $oUpgrade->new_value .' - '. $aDetails['total'] .' = '. $upgradePrice .' บาท<br />
                    '. $upgradePrice .' / '. $upgradeCycleDay .' days of '. $oUpgrade->new_billing .' =  
                    '. round($upgradePricePerDay, 2) .' บาท<br />
                    เป็นค่าส่วนต่าง:<br />
                    '. round($upgradePricePerDay, 2) .' x '. $upgradeDay .' = '. round($upgradePriceTotal, 2) .' บาท<br />
                    ';
                    
            } else {
                $aInvoiceItem       = $result;
                $dueTotal           = 0;
                $invoiceDate        = '';
                
                foreach ($aInvoiceItem as $arr) {
                    if ($arr['type'] == 'Upgrade' && $arr['item_id'] == $oUpgrade->id) {
                        $dueTotal       = $dueTotal + $arr['amount'];
                        $invoiceDate    = $arr['invoiceDate'];
                    }
                    if ($arr['type'] == 'Hosting' && $arr['item_id'] == $accountId) {
                        $dueTotal   = $dueTotal + $arr['amount'];
                    }
                }
                
                $thisDueTotal       = $dueTotal - $oUpgrade->new_value;
                
                $upgradePrice       = $oUpgrade->new_value - $aDetails['total'];
                $upgradeCycleDay    = GeneralCustom::singleton()->billingCycleUpgradeToDays(
                                        strtotime($aDetails['next_due']),
                                        $oUpgrade->new_billing);
                
                $upgradeDay         = strtotime('-'. $upgradeCycleDay .' days', strtotime($aDetails['next_due']));
                $upgradeDay         = ($upgradeDay - strtotime($invoiceDate))/(60*60*24);
                $upgradePricePerDay = $upgradePrice / $upgradeCycleDay;
                $upgradePriceTotal  = $upgradePricePerDay * $upgradeDay;
                
                $upgradeMessage     = '
                    <a href="?cmd=invoices&action=edit&id='. $aInvoiceItem[0]['invoice_id'] .'" target="_blank">#
                    '. $aInvoiceItem[0]['invoice_id'] .'</a> 
                    <a href="?cmd=invoices&action=edit&id='. $aInvoiceItem[1]['invoice_id'] .'" target="_blank">#
                    '. $aInvoiceItem[1]['invoice_id'] .'</a> 
                    มียอดรวมที่ต้องชำระ '. $dueTotal .' บาท
                    โดยจำแนกออกเป็น:<br />
                    ค่า package ใหม่ '. $oUpgrade->new_value .' เหลือค่าส่วนต่าง '. $thisDueTotal .' บาท
                    @'. $invoiceDate .' ก่อนครบรอบบิลปัจจุบัน<br />
                    โดยคำนวนจาก:<br />
                    '. $oUpgrade->new_value .' - '. $aDetails['total'] .' = '. $upgradePrice .' บาท<br />
                    '. $upgradePrice .' / '. $upgradeCycleDay .' days of '. $oUpgrade->new_billing .' =  
                    '. round($upgradePricePerDay, 2) .' บาท<br />
                    เป็นค่าส่วนต่าง:<br />
                    '. round($upgradePricePerDay, 2) .' x '. $upgradeDay .' = '. round($upgradePriceTotal, 2) .' บาท<br />
                    ';
                
            }
            $this->assign('upgradeMessage', $upgradeMessage);
        }
        
    }
}

// --- Fixbug ถ้าไมไ่ด้เลือก Dedicated IP ไม่ต้องให้แสดงใน invoice ต้องลย record นั้นออกเลย ---
if ($accountId) {
    $result     = accounthandle_controller::singleton()->manageConfig2Account($accountId);
    if ($result) {
        echo '<script language="javascript">window.location="?cmd=accounts&action=edit&id='. $accountId .'";</script>';
        exit;
    }
}

//$xxx    = $this->get_template_vars();
//echo '<pre>'.print_r($xxx,true).'</pre>';