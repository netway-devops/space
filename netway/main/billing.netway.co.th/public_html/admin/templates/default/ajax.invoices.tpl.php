<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.api.custom.php');
require_once(APPDIR . 'class.discount.custom.php');
require_once(APPDIR . 'modules/Site/invoicehandle/admin/class.invoicehandle_controller.php');
require_once(APPDIR . 'modules/Site/invoicehandle/model/class.invoicehandle_model.php');
require_once(APPDIR . 'modules/Other/domainexpirehandle/admin/class.domainexpirehandle_controller.php');
require_once(APPDIR . 'modules/Site/fulfillmenthandle/admin/class.fulfillmenthandle_controller.php');
require_once(APPDIR . 'modules/Site/addresshandle/admin/class.addresshandle_controller.php');
require_once(APPDIR . 'modules/Site/clienthandle/admin/class.clienthandle_controller.php');



// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aAdmin     = hbm_logged_admin();
$this->assign('Admin', $aAdmin);

// --- hostbill helper ---

// --- Custom helper ---
$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

// --- Get template variable ---

$aInvoice           = $this->get_template_vars('invoice');
$aInvoices          = $this->get_template_vars('invoices');
$perpage            = $this->get_template_vars('perpage');
$action             = $this->get_template_vars('action');
$clientId           = $this->get_template_vars('client_id');
$balance            = $this->get_template_vars('balance');
// --- Get template variable ---

if ($aInvoice['taxrate'] && isset($aInvoice['taxes'][0])) {
    $aInvoice['taxes'][7]   = $aInvoice['taxes'][0];
    $aInvoice['taxes'][7]['subtotal']       = $aInvoice['subtotal'];
    $aInvoice['taxes'][7]['name']           = '7 %';
    $aInvoice['taxes'][7]['rate']           = 7;
    $aInvoice['taxes'][7]['total']          = ($aInvoice['subtotal'] + ($aInvoice['subtotal'] * 7 / 100));
    $aInvoice['taxes'][7]['tax']            = ($aInvoice['subtotal'] * 7 / 100);
}
$this->assign('invoice', $aInvoice);
$this->assign('aInvoice', $aInvoice);
//echo '<pre>'.print_r($aInvoice, true).'</pre>';

$oInvoice           = (object) $aInvoice;

if (isset($oInvoice->id)) {
    $aDiscountInfo  = invoicehandle_controller::singleton()->getInvoiceItemDiscount($oInvoice->id);
    $this->assign('aDiscountInfo', $aDiscountInfo);
    
    if ($oInvoice->status == 'Paid' && date('Y-m-d', strtotime($oInvoice->datepaid)) == date('Y-m-d')) {
        if (count($oInvoice->items)) {
            foreach ($oInvoice->items as $arr) {
                if (preg_match('/hosting/i', $arr['type'])) {
                    fulfillmenthandle_controller::singleton()->accountFulfillmentProcess(array('id'=>$arr['item_id']));
                }
                if (preg_match('/domain/i', $arr['type'])) {
                    fulfillmenthandle_controller::singleton()->domainFulfillmentProcess(array('id'=>$arr['item_id']));
                }
            }
        }
    }
    
}

$nwSODNumber    = ConfigCustom::singleton()->getValue('nwSODNumber');

$this->assign('nwSODNumber', $nwSODNumber);

if ($oInvoice->client_id < 0) {
    
    if (isset($_GET['fixerror']) && $_GET['fixerror'] == 'clientId') {
        $db->query("
            UPDATE
                hb_invoices
            SET
                client_id = -client_id
            WHERE
                id = :invoiceId
                AND client_id < 0
            LIMIT 1
            ", array(
                ':invoiceId'    => $oInvoice->id
            ));
            
        echo '
            <script language="javascript">
            window.location = "index.php?cmd=invoices&action=edit&id='. $oInvoice->id .'";
            </script>
            ';
        exit;
        
    }
    
    $this->assign('isErrorInvoiceClientId', 1);
}

if ( isset($aInvoice['client']) ) {
    
    $clientAddress    = '';
    $contactId          = (isset($aInvoice['contact_id']) && $aInvoice['contact_id']) ? $aInvoice['contact_id'] : $aInvoice['client_id'];

    $params     = array(
              'id'      => $contactId
              );
    $result     = $api->getClientDetails($params);
    
    if ($result['success'] == true && isset($result['client']) ) {
        $aClient        = $result['client'];
        
        // /includes/modules/Site/addresshandle/admin/class.addresshandle_controller.php
        if ($aClient['company']) {
            $clientAddress    .= $aClient['companyname'] . "\n";
        }
        $clientAddress  .= $aClient['firstname'] . ' ' . $aClient['lastname'] . "\n"
                        .  $aClient['address1'] . ' ' . $aClient['address2'] . "\n"
                        .  $aClient['city'] . ' ' . $aClient['state'] . "\n"
                        .  $aClient['postcode'];
    }

    $billingContactId       = $aInvoice['billing_contact_id'];
    $mailingContactId       = $aInvoice['mailing_contact_id'];
    $billingAddress         = $aInvoice['billing_address'];  
    $mailingAddress         = $aInvoice['mailing_address'];

    $aBillingContact        = array();
    if ($billingContactId) {
        $aBillingContact    = addresshandle_controller::singleton()->getContactAddressFronContactId($billingContactId);
        if ($mailingContactId == $billingContactId) {
            if (! isset($aBillingContact['isChangeMailto']) || ! $aBillingContact['isChangeMailto']) {
                $mailingAddress     = 'ใช้ข้อมูลเดียวกับ billing address';
            }
        }
    }

    if (isset($aInvoice['metadata']['billingCheque'])) {
        foreach ($aInvoice['metadata']['billingCheque'] as $k => $v) {
            $aBillingContact[$k]    = $v;
        }
    }
    
    $aCreditTerm    = clienthandle_controller::singleton()->getCustomFieldOption('creditterm');
    $this->assign('aCreditTerm', $aCreditTerm);

    $this->assign('clientAddress', $clientAddress);
    $this->assign('billingAddress', $billingAddress);
    $this->assign('mailingAddress', $mailingAddress);
    $this->assign('aBillingContact', $aBillingContact);

    /**
    * เพิ่มการแสดงรายละเอียดของ transaction
    */
    $aTrans            = array();
    $aTransactions     = $this->get_template_vars('transactions');
    if (count($aTransactions)) {
       foreach ($aTransactions as $aData) {
           $transId    = $aData['id'];
           $result     = $db->query("
                      SELECT t.*
                      FROM hb_transactions t
                      WHERE t.id = :id
                      ", array(
                           ':id' => $transId
                      ))->fetch();
           $aTrans[$transId]  = isset($result['id']) ? $result : array();
       }
    }
    $this->assign('aTrans', $aTrans);

}

/* --- ดู is_shipped status --- */
$aInvoiceItems  = array();
if ( isset($oInvoice->items) && count($oInvoice->items) ) {
    $aItemId    = array();
    foreach ($oInvoice->items as $k => $aItem) {
        array_push($aItemId, $aItem['id']);
    }
    if(count($aItemId)){
        $result     = $db->query("
                SELECT ii.*
                FROM hb_invoice_items ii
                WHERE ii.id IN (". implode(',', $aItemId) .")
                ")->fetchAll();
        if (count($result)) {
            foreach ($result as $v) {
                $aInvoiceItems[$v['id']]   = $v;
            }
        }
    }
}
$this->assign('aInvoiceItems', $aInvoiceItems);


/* --- สามารถ filter invoice ของ client ได้ --- */
if ($action == 'clientinvoices' && $clientId) {

    $result     = $db->query("
            SELECT
                i.status, COUNT(i.status) AS total
            FROM
                hb_invoices i
            WHERE
                i.client_id = :clientId
            GROUP BY
                i.status
            ", array(
                ':clientId'     => $clientId
            ))->fetchAll();
    if (count($result)) {
        $allTotal       = 0;
        foreach ($result as $v) {
            $allTotal   = $allTotal + $v['total'];
        }
        $this->assign('aTotal', $result);
        $this->assign('allTotal', $allTotal);
        
    }
    
    $_POST['status']             = isset($_GET['status']) ? $_GET['status'] : $_POST['status'];
    $_GET['listExt']             = isset($_POST['listExt']) ? $_POST['listExt'] : $_GET['listExt'];
    $_POST['timePeriod']         = isset($_POST['timePeriod']) ? $_POST['timePeriod'] : $_GET['timePeriod'];
    $_POST['page']               = isset($_GET['page']) ? $_GET['page'] : $_POST['page'];

}

/* --- Invoice custom lists filter --- */

if (isset($_GET['listExt']) && $_GET['listExt']) {
    
    $page               = isset($_POST['page']) ? $_POST['page'] : 0;
    $status             = isset($_POST['status']) ? $_POST['status'] : '';
    $statusExt          = isset($_GET['statusExt']) ? $_GET['statusExt'] : (isset($_POST['statusExt']) ? $_POST['statusExt'] : '');
    $timePeriod         = isset($_POST['timePeriod']) ? $_POST['timePeriod'] : $_GET['timePeriod'];
    
    $aInvoices          = array();
    
    $totalpages         = 0;
    $sorterrecords      = 0;
    $sorterpage         = $page + 1;
    $sorterlow          = 0;
    $sorterhigh         = 0;
    
    $invoiceFilterName      = $_GET['listExt'];
    
    if ($invoiceFilterName == 'invoiceNumber') {
        $perpage        = 100000;
    }
    
    $aParam     = array(
        'call'      => 'module',
        'module'    => 'invoicefilter',
        'fn'        => $invoiceFilterName,
        'clientId'  => $clientId,
        'status'    => $status,
        'statusExt' => $statusExt,
        'timePeriod'=> $timePeriod,
        'limit'     => $perpage,
        'offset'    => ($page * $perpage)
    );
    $result = $apiCustom->request($aParam);
    
    if ($result['success'] && count($result['aInvoices'])) {
        
        $aInvoiceIds    = $result['aInvoices'];
        $totalpages     = ceil($result['total'] / $perpage);
        $sorterrecords  = $result['total'];
        $sorterlow      = ($page * $perpage) + 1;
        $sorterhigh     = (($sorterlow + $perpage -1) > $sorterrecords) ? $sorterrecords : ($sorterlow + $perpage -1);
        
        $result     = $db->query("
                  SELECT 
                    i.id, i.locked, i.currency_id, i.date, i.duedate, i.datepaid, i.total,
                    i.credit, i.subtotal AS subtotal2, i.paid_id, i.status, i.client_id,
                    '0' AS recid,
                    mc.module,
                    cd.firstname, cd.lastname
                  FROM 
                    hb_invoices i
                    LEFT JOIN hb_modules_configuration  mc
                        ON mc.id = i.payment_module
                    LEFT JOIN hb_client_details  cd
                        ON cd.id = i.client_id
                  WHERE 
                    i.id IN (". implode(',', $result['aInvoices']) .")
                  ORDER BY FIELD(i.id, ". implode(',', $result['aInvoices']) .")
                  ")->fetchAll();
        if (count($result)) {
            $aInvoices = $result;
        }
        
    }
    
    //echo '<pre>'.print_r($result,true).'</pre>';
    
    $this->assign('invoices', $aInvoices);
    $this->assign('totalpages', $totalpages);
    $this->assign('sorterrecords', $sorterrecords);
    $this->assign('sorterpage', $sorterpage);
    $this->assign('sorterlow', $sorterlow);
    $this->assign('sorterhigh', $sorterhigh);
    
    $this->assign('reassignSorterrecords', $sorterrecords);
    
}
$this->assign('listExt', isset($_GET['listExt']) ? $_GET['listExt'] : '');
$this->assign('status', isset($_GET['status']) ? $_GET['status'] : '');


/* --- ใบกำกับภาษี --- */
$aInvoiceDetails    = array();
if (count($aInvoices)) {
    
    $aInvoiceIds    = array();
    foreach ($aInvoices as $v) {
        array_push($aInvoiceIds, $v['id']);
    }
    
    if (count($aInvoiceIds)) {
           $result     = $db->query("
                      SELECT i.*
                      FROM hb_invoices i
                      WHERE i.id IN (". implode(',', $aInvoiceIds) .")
                      ")->fetchAll();
           if (count($result)) {
               foreach ($result as $v) {
                   $aInvoiceDetails[$v['id']]   = $v;
               }
           }
    }
    
}
$this->assign('aInvoiceDetails', $aInvoiceDetails);

/* --- list service เพื่อให้เข้าถึงข้อมูลได้มากขึ้น --- */
if (count($aInvoices)) {
    $aInvoiceServices   = array();
    $result     = $db->query("
              SELECT ii.id, ii.invoice_id, ii.description
              FROM hb_invoice_items ii
              WHERE ii.invoice_id IN (". implode(',', $aInvoiceIds) .")
              ORDER BY ii.invoice_id ASC
              ")->fetchAll();
    if (count($result)) {
        foreach ($result as $v) {
            $aInvoiceServices[$v['invoice_id']]   .= '<br />'. $v['description'];
        }
    }
    $this->assign('aInvoiceServices', $aInvoiceServices);
}

/* --- แจ้งเตือนถ้ายังไม่เคยส่ง invoice reminder ถึงลูกค้า --- */
if (count($aInvoices)) {
    $aInvoiceNotify     = array();
    foreach ($aInvoices as $v) {
        if ($v['date'] == $v['duedate']
            || strtotime($v['date']) < strtotime('-3 day')
            || $v['status'] != 'Unpaid'
            ) {
            continue;
        }
        /*
        $result     = $db->query("
                  SELECT el.id
                  FROM hb_email_log el
                  WHERE DATE(el.date) = '". $v['date'] ."'
                    AND el.subject LIKE '%". $v['id'] ."%'
                  ")->fetch();
        if (! isset($result['id'])) {
            $aInvoiceNotify[$v['id']]   = 1;
        }
        */
    }
    $this->assign('aInvoiceNotify', $aInvoiceNotify);
}


/* --- Invoice ที่เป็น Pro Forma ให้แสดง detail ด้วยเพื่อเข้าถึงได้ง่ายขึ้น --- */
if (isset($aInvoice['id']) && count($aInvoice['items'])) {
    $aInvoiceDescriptions   = array();
    
    /**
     * proforma invoice จะต้อง ตรวจสอบเพิ่มว่า order นั้นจะต้องไม่ถูก cancel invoice นั้นต้องไม่ถูก cancel
     * includes/modules/Other/domainexpirehandle/cron/class.domainexpirehandle_controller.php
     */
    $isOrderDomainCancel    = domainexpirehandle_controller::validateOrderDomainCancel(array(
                        'invoiceId'     => $aInvoice['id']
                    ));
    
    foreach ($aInvoice['items'] as $aItem) {
        if ($aItem['type'] == 'Invoice' && $aItem['item_id']) {
            
            $result     = $db->query("
                    SELECT ii.id, ii.invoice_id, ii.description
                    FROM hb_invoice_items ii
                    WHERE ii.invoice_id = :invoiceId
                    ORDER BY ii.invoice_id ASC
                ", array(
                    ':invoiceId'    => $aItem['item_id']
                ))->fetchAll();
            if (count($result)) {
                foreach ($result as $v) {
                    $aInvoiceDescriptions[$aItem['id']]   .= '<br />'. $v['description'];
                }
            }
            
            if (! $isOrderDomainCancel) {
                $isOrderDomainCancel    = domainexpirehandle_controller::validateOrderDomainCancel(array(
                                    'invoiceId'     => $aItem['item_id']
                                ));
            }
            
        }
    }
    
    $this->assign('aInvoiceDescriptions', $aInvoiceDescriptions);
    $this->assign('isOrderDomainCancel', $isOrderDomainCancel);
}


/* --- เพื่มบันทึก การจัดส่งเอกสาร --- */
$result     = $db->query("
        SELECT 
            im.*
        FROM
            hb_invoice_mails im
        WHERE
            im.invoice_id = :invoiceId
        ", array(
            ':invoiceId'    => $oInvoice->id
        ))->fetch();
if (isset($result['id'])) {
    $this->assign('aInvoiceMail', $result);
}

/* --- ถ้าการชำระเงินมีเรื่องของ หักภาษี ณ ที่จ่าย ให้บอกได้ว่าได้รับใบหักภาษี ณ ที่จ่ายแล้ว --- */
$result     = $db->query("
        SELECT 
            COUNT(*) AS total
        FROM
            hb_transactions t
        WHERE
            t.invoice_id = :invoiceId
            AND t.fee_code IN ('V01', 'V03','V015')
        ", array(
            ':invoiceId'    => $oInvoice->id
        ))->fetch();
$isWithHoldingTax       =(isset($result['total']) && $result['total']) ? true : false;
$this->assign('isWithHoldingTax', $isWithHoldingTax);

/* --- ตรวจสอบว่าเป็น proforma invoice หรือเปล่า --- */
if (count($aInvoice['items'])) {
    foreach ($aInvoice['items'] as $k => $arr) {
        if ($arr['type'] == 'Invoice') {
            $this->assign('isProformaInvoice', 1);
            break;
        }
        else if($arr['type'] != 'Invoice' && $aInvoice['status'] != 'Paid'){
            $this->assign('isInvoice', 1);
            break;
        }   
    }
}

/* --- เพิ่ม field quantity เข้ามาใหม่ต้องทำการตรวจสอบว่ามีการตั้งค่าหรือยัง --- */

if (isset($oInvoice->id)) {
    $result         = invoicehandle_controller::updateQuantity(array('invoiceId' => $oInvoice->id, 'return' => true));
    if ($result) {
        echo '
            <script language="javascript">
            window.location = "index.php?cmd=invoices&action=edit&id='. $oInvoice->id .'";
            </script>
            ';
        exit;
    }
}

/*เพิ่มการแสดงผลระยะสัญญาใน invoice  (dd/mm/yyyy - dd/mm/yyyy)*/
if (isset($oInvoice->id)) {
    $result = invoicehandle_controller::durationOfContract($aInvoice);
    if ($result) {
        echo '
            <script language="javascript">
            window.location = "index.php?cmd=invoices&action=edit&id='. $oInvoice->id .'";
            </script>
            ';
        exit;
    }
}

if (isset($aInvoice['id'])) {
    $result     = invoicehandle_controller::getInvoiceOwner($aInvoice['id']);
    $this->assign('aStaffOwners', $result);
}

// --- เตือนให้เจ้าหน้าที่ตวจสอบเกี่ยวกับ invoice balance ที่น้อยกว่า 0 ---
if (isset($aInvoice['id'])) {
    $isShowBalanceNotification  = 0;
    if ($balance < 0 && $aInvoice['status'] == 'Paid' && (strtotime($aInvoice['datepaid']) + 600) > time()) {
        $isShowBalanceNotification  = 1;
    }
    $this->assign('isShowBalanceNotification', $isShowBalanceNotification);
}

$invalidItemUpgradeId     = 0;
$aInvalidItem   = array();
$aUpgrades  = array();
if ($aInvoice['status'] == 'Paid' && count($aInvoice['items'])) {
    $itemId = 0;
    foreach ($aInvoice['items'] as $aItem) {
        $desc   = $aItem['description'];
        if (preg_match('/Upgrade Quantity/', $desc) && ! $aItem['item_id']) {
            $itemId = $aItem['id'];
            $invalidItemUpgradeId   = $itemId;
            $aInvalidItem   = $aItem;
            $aRequest       = array(
                'clientId'  => $aInvoice['client_id'],
                'desc'      => $desc,
            );
            $aUpgrades     = invoicehandle_controller::singleton()->getRelateAccount($aRequest);
            break;
        }
    }
}

if (isset($oInvoice->id)) {
    $isEstimate  = invoicehandle_model::singleton()->getEstimateByInvoiceId($aInvoice['id']);
    if ($isEstimate['id']) {
        if (!$aInvoice['estimate_id']) {
            invoicehandle_controller::singleton()->updateInvoiceDetailByInvoiceId($aInvoice['id']);       
            echo '<script>document.location = "?cmd=invoices&action=edit&id='. $aInvoice['id'] .'&reload=1&isEstimate=0";</script>';
            exit;
        }
    }
}


$this->assign('invalidItemUpgradeId', $invalidItemUpgradeId);
$this->assign('aInvalidItem', $aInvalidItem);
$this->assign('aUpgrades', $aUpgrades);
