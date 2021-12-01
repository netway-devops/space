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
$aInvoice           = $this->get_template_vars('invoice');
$aInvoices          = $this->get_template_vars('invoices');
$perpage            = $this->get_template_vars('perpage');
$action             = $this->get_template_vars('action');
$clientId           = $this->get_template_vars('client_id');
// --- Get template variable ---

$oInvoice         = (object) $aInvoice;

require_once(APPDIR . 'class.config.custom.php');
$nwTaxNumber    = ConfigCustom::singleton()->getValue('nwTaxNumber');

$this->assign('nwTaxNumber', $nwTaxNumber);



if ( isset($oInvoice->client) ) {

    $oInvoiceClient   = (object) $oInvoice->client;

    $params       = array(
              'id'      => $oInvoice->client_id
              );
    $clientAddress    = '';
    $clientAddress    = '';
    $invoiceAddress   = $oInvoiceClient->firstname . "\n" . $oInvoiceClient->lastname . "\n" . $oInvoiceClient->address1 . "\n" . $oInvoiceClient->city . "\n" . $oInvoiceClient->postcode;
    $result       = $api->getClientDetails($params);

    if ($result['success'] == true && isset($result['client']) ) {
        $oClient          = (object) $result['client'];
        $clientAddress    = $oClient->firstname . "\n" . $oClient->lastname . "\n" . $oClient->address1 . "\n" . $oClient->city . "\n" . $oClient->postcode;
    }
    if ($invoiceAddress == $clientAddress) {
        $invoiceAddress   = 'ใช้ข้อมูลเดียวกับ client address';
    }
    if (isset($oInvoiceClient->mailingaddress) && $oInvoiceClient->mailingaddress) {
        $mailingAddress   = $oInvoiceClient->mailingaddress;
    } else {
        $mailingAddress   = 'ใช้ข้อมูลเดียวกับ client address';
    }

    $this->assign('invoiceAddress', $invoiceAddress);
    $this->assign('clientAddress', $clientAddress);
    $this->assign('mailingAddress', $mailingAddress);

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

/* --- ดู is_shipped status --- */
$aInvoiceItems  = array();
if ( isset($oInvoice->items) && count($oInvoice->items) ) {
    $aItemId    = array();
    foreach ($oInvoice->items as $k => $aItem) {
        array_push($aItemId, $aItem['id']);
    }
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


/* --- Invoice ที่เป็น Pro Forma ให้แสดง detail ด้วยเพื่อเข้าถึงได้ง่ายขึ้น --- */
if (isset($aInvoice['id']) && count($aInvoice['items'])) {
    $aInvoiceDescriptions   = array();
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

        }
    }

    $this->assign('aInvoiceDescriptions', $aInvoiceDescriptions);

}

$sslInvoice = $db->query("
		SELECT
			DISTINCT ii.invoice_id
		FROM
			hb_orders AS o
			, hb_accounts AS a
			, hb_invoice_items AS ii
			, hb_products AS p
			, hb_categories AS c
		WHERE
			o.invoice_id = :invoiceId
			AND o.id = a.order_id
			AND ii.item_id = a.id
			AND ii.invoice_id != o.invoice_id
			AND a.product_id = p.id
			AND p.category_id = c.id
			AND c.name = 'SSL'
", array(':invoiceId' => $aInvoices[0]['id']))->fetchAll();

if($sslInvoice){
	foreach($sslInvoice as $inv){
		$invoiceDetail = $db->query("SELECT * FROM hb_invoices WHERE id = {$inv['invoice_id']}")->fetch();
		if($invoiceDetail){
			$clientDetail = $db->query("SELECT firstname, lastname FROM hb_client_details WHERE id = {$invoiceDetail['client_id']}")->fetch();
			$moduleDetail = $db->query("SELECT module FROM hb_modules_configuration WHERE id = {$invoiceDetail['payment_module']}")->fetch();
			$aInvoices[] = array(
					'id' => $inv['invoice_id']
					, 'locked' => $invoiceDetail['locked']
					, 'currency_id' => $invoiceDetail['currency_id']
					, 'date' => $invoiceDetail['date']
					, 'duedate' => $invoiceDetail['duedate']
					, 'datepaid' => $invoiceDetail['datepaid']
					, 'subtotal2' => $invoiceDetail['subtotal']
					, 'credit' => $invoiceDetail['credit']
					, 'total' => $invoiceDetail['total']
					, 'paid_id' => $invoiceDetail['paid_id']
					, 'status' => $invoiceDetail['status']
					, 'firstname' => $clientDetail['firstname']
					, 'client_id' => $invoiceDetail['client_id']
					, 'lastname' => $clientDetail['lastname']
					, 'module' => $moduleDetail['module']
					, 'recid' => $invoiceDetail['recurring_id']
			);
		}
	}
	$this->assign('invoices', $aInvoices);
}



//echo '<pre>'.print_r($clientId,true).'</pre>';