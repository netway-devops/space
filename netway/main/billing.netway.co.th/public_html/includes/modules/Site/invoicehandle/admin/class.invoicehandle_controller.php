<?php
//use GuzzleHttp\Client;
require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');
use GuzzleHttp\Client;
use GuzzleHttp\Psr7;
use GuzzleHttp\Exception\RequestException;

require_once (APPDIR_MODULES . '/Site/addresshandle/admin/class.addresshandle_controller.php');
require_once dirname(__DIR__) . '/model/class.invoicehandle_model.php';

class invoicehandle_controller extends HBController {

    private static  $instance;

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }

    public function _default ($request)
    {
        $db     = hbm_db();
    }

    public function changeStaffOwner ($request)
    {
        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $staffOwnerId   = isset($request['staffOwnerId']) ? $request['staffOwnerId'] : 0;
        $aData      = array(
            'staff_owner_id'    => $staffOwnerId,
            'id'    => $invoiceId,
        );
        invoicehandle_model::singleton()->changeStaffOwner($aData);

        $result     = array();
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }

    public function verifyDeleteInvoice ($request)
    {
        $db     = hbm_db();

        $invoiceId  = isset($request['id']) ? $request['id'] : 0;
        $status     = isset($request['status']) ? $request['status'] : '';

        if ($status == 'Paid') {
            return false;
        }

        $result     = $db->query("
            SELECT o.id
            FROM hb_orders o
            WHERE o.invoice_id = :invoice_id
            ", array(
                ':invoice_id'   => $invoiceId
            ))->fetch();

        if (! isset($result['id'])) {
            return true;
        }

        $orderId    = $result['id'];

        $result     = $db->query("
            SELECT a.id
            FROM hb_accounts a
            WHERE a.order_id = :order_id
            ", array(
                ':order_id'     => $orderId
            ))->fetch();

        if (isset($result['id'])) {
            return false;
        }

        $result     = $db->query("
            SELECT d.id
            FROM hb_domains d
            WHERE d.order_id = :order_id
            ", array(
                ':order_id'     => $orderId
            ))->fetch();

        if (isset($result['id'])) {
            return false;
        }

        $result     = $db->query("
            SELECT aa.id
            FROM hb_accounts_addons aa
            WHERE aa.order_id = :order_id
            ", array(
                ':order_id'     => $orderId
            ))->fetch();

        if (isset($result['id'])) {
            return false;
        }

        return true;
    }

    public function addItemManual ($request)
    {
        $db     = hbm_db();

        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---

        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $aItem      = isset($request['item']['n']) ? $request['item']['n'] : array();
        $isEstimate = isset($request['isEstimate']) ? $request['isEstimate'] : 0;

        if ($isEstimate) {
            $result = array(
                'info'  => 'Action not support estimate item.',
            );
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
            exit;
        }

        $result     = 0;

        if ($invoiceId) {

            $aParam         = array(
                'call'      => 'addInvoiceItem',
                'id'        => $invoiceId,
                'line'      => (isset($aItem['description']) ? $aItem['description'] : '-'),
                'price'     => (isset($aItem['amount']) ? $aItem['amount'] : 0),
                'qty'      => (isset($aItem['qty']) ? $aItem['qty'] : 0),
                'tax'      => (isset($aItem['taxed']) ? $aItem['taxed'] : 0)
            );
            $result         = $apiCustom->request($aParam);

        }


        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }

    public function detail ($request)
    {
        $db     = hbm_db();

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;

        require_once(APPDIR . 'class.discount.custom.php');

        //self::updateInvoiceItemDiscount($invoiceId);

        $result     = $db->query("
            SELECT ii.*,
                i.client_id
            FROM hb_invoices i,
                hb_invoice_items ii
            WHERE i.id = :invoiceId
                AND i.id = ii.invoice_id
            ORDER BY ii.id ASC # ต้องเรียงด้วย ii.id ASC
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();

        $aItems     = count($result) ? $result : array();
        echo '<table border="1" bgcolor="white">';
        for ($i = 0; $i < count($aItems); $i++) {
            echo '<tr valign="top">';
            $aItem      = $aItems[$i];

            // invoice item บางตัวไม่ต้องเอามาคิดส่วนลด เดี๋ยวจะผิดพลาด
            if ($aItem['type'] == 'Invoice' || $aItem['type'] == 'Credit' || $aItem['type'] == 'Discount') {
                continue;
            }

            // หาส่วนลดตามรอบบิล
            $itemType       = $aItem['type'];

            switch ($itemType) {
                case 'Hosting'      : {
                    // product with quantity google apps o365
                    $result         = DiscountCustom::singleton()->accountQuantityPresent($aItem['item_id']);

                    if (isset($result['id'])) {
                        break;
                    }

                    }
                case 'Hosting'      : {

                    $result         = DiscountCustom::singleton()->getAccountPrice($aItem['item_id']);
                    echo '<td><pre>'. print_r($result, true) .'</pre></td>';

                    $bc             = isset($result['billingcycle']) ? $result['billingcycle'] : '';
                    $bc             = $bc ? strtolower(substr($bc, 0, 1)) : '';
                    $unitPrice      = isset($result['unitPrice']) ? $result['unitPrice'] : 0;

                    $qt             = $bc .'Quantity';
                    $quantity       = isset($result[$qt]) ? $result[$qt] : 0;
                    $qtext          = $bc .'QuantityText';
                    $quantityText   = isset($result[$qtext]) ? $result[$qtext] : '';
                    $dc             = $bc .'Discount';
                    $discount       = (isset($result[$dc]) && $result[$dc] > 0) ? $result[$dc] : 0;
                    echo '<td><pre>
    discount_price_cycle = '. $discount .',
    unit_price = '. $unitPrice .',
    quantity = '. $quantity .',
    quantity_text = '. $quantityText .'
                        </pre></td>';


                }
                case 'Hosting'      : {
                    // VPS Dedicated

                    $result     = DiscountCustom::singleton()->getAccountConfigRegularPrice($aItem['item_id']);
                    echo '<td><pre>'. print_r($result, true) .'</pre></td>';

                    if (count($result)) {
                        echo '<td><table border="1">';
                        $result_    = $result;
                        foreach ($result_ as $arr) {
                            echo '<tr valign="top">';

                            echo '<td><pre>'. print_r($arr, true) .'</pre></td>';
                            $result         = DiscountCustom::singleton()->_getProductDiscount($arr);
                            echo '<td><pre>'. print_r($result, true) .'</pre></td>';

                            $comPrice       = isset($result['unitPrice']) ? $result['unitPrice'] : 0;
                            $comDiscount    = isset($result[$dc]) ? $result[$dc] : 0;
                            $unitPrice      = $unitPrice + $comPrice;
                            $discount       = $discount + $comDiscount;

                            echo '</tr>';
                        }
                        echo '</table></td>';
                    }

                    echo '<td><pre>
    discount_price_cycle = '. $discount .',
    unit_price = '. $unitPrice .'
                        </pre></td>';

                    break;
                }
                default : {}
            }


            // เอา discount record ลบออกจาก amount record ปัจจุบัน
            if (count($aNext) && $aNext['type'] == 'Discount' ) {


                echo '<td><pre>
    amount = amount - '. (-$aNext['amount']) .'
                    </pre></td>';
            }

            // special discount
            echo '<td><pre>
                    discount_price_special = (unit_price * quantity) - amount
                    - discount_price_cycle
                    - discount_price_coupon
                    - discount_price_group_product
                    - discount_price_group_global
                </pre></td>';


            // total discount

            echo '<td><pre>
                    discount_price = discount_price_cycle
                    + discount_price_coupon
                    + discount_price_group_product
                    + discount_price_group_global
                    + discount_price_special
                </pre></td>';

            echo '</tr>';
        }
        echo '</table>';
        exit;
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/detail.tpl', array(), true);
    }

    /**
     * บาง item ไม่ต้องหา quantity
     */
    public function _isValidInvoiceItemType ($request)
    {
        $type       = isset($request['type']) ? $request['type'] : '';

        if (! $type) {
            return false;
        }
        if ($type == 'Invoice') {
            return false;
        }

        return true;
    }

    public function addtaxinvoice ($request)
    {
        $db     = hbm_db();

        $invoiceId  = isset($request['id']) ? $request['id'] : 0;
        if (! $invoiceId) {
            return false;
        }

        $invoiceNumber  = self::buildTaxNumberFormat();
        invoicehandle_model::singleton()->updateInvoiceNumber($invoiceId, $invoiceNumber);

        echo '<!-- {"ERROR":[],"INFO":["Added invoice number:'. $invoiceNumber .' to invoice:'. $invoiceId .'"]'
            . ',"HTML":"'. $invoiceNumber .'"'
            . ',"STACK":0} -->';
        exit;
    }

    public function updatetaxinvoice ($request)
    {
        $db     = hbm_db();

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $invoiceNumber  = isset($request['invoiceNumber']) ? $request['invoiceNumber'] : 0;
        if (! $invoiceId) {
            return false;
        }

        invoicehandle_model::singleton()->updateInvoiceNumber($invoiceId, $invoiceNumber);

        echo '<!-- {"ERROR":[]'
            . ',"INFO":["Update invoice number:'. $invoiceNumber .' to invoice:'. $invoiceId .'"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function createSalesOrder($request)
    {
        $invoiceId      = isset($request['id']) ? $request['id'] : null;
        if (is_null($invoiceId)) {
            return false;
        } else {
            require_once(APPDIR_MODULES . 'Other/dbc_integration/webhook/class.dbc_integration_webhook.php');
            $aResult = dbc_integration_webhook::singleton()->postCreateSalesOrderOnDBC($invoiceId);
            $db     = hbm_db();
            if (isset($aResult['status']) && $aResult['status'] == 'ok') {
                $db->query("
                    UPDATE
                        hb_invoices
                    SET
                        create_sod_status = 2
                    WHERE
                        id = :invoice_id
                ", array(
                    ':invoice_id' =>  $invoiceId
                ));
                echo '<!-- {"ERROR":[]'
                    . ',"INFO":["Call DBC Integration to created Sales Order for invoice ID: '. $invoiceId .' has successfully."]'
                    . ',"STACK":0} -->';
            } else {
                echo '<!-- {"ERROR":[]'
                    . ',"INFO":["Call DBC Integration to created Sales Order for invoice ID: '. $invoiceId .' has problem."]'
                    . ',"STACK":0} -->';
            }
        }
        exit;
    }

    /*
     * [TODO] function นี้ถูก access จากที่อื่นแบบ เรียก function โดยตรง ระวังเรื่อง this
     * /includes/extend/hooks/after_invoicefullpaid_01.php
     */
    public function buildTaxNumberFormat ($id=null)
    {
        $db     = hbm_db();

        require_once(APPDIR . 'class.config.custom.php');
        $nwSODNumberYear   = ConfigCustom::singleton()->getValue('nwSODNumberYear');
        $thisYear = date('y');

        if ( $thisYear != $nwSODNumberYear) {
            ConfigCustom::singleton()->setValue('nwSODNumberYear', $thisYear);
            $SOCount = 1;
        } else {
            $lastSOCount = ConfigCustom::singleton()->getValue('nwSODNumber');
            $SOCount = $lastSOCount + 1;
        }

        ConfigCustom::singleton()->setValue('nwSODNumber', $SOCount);

        return sprintf("SOD%s%s", $thisYear, str_pad($SOCount, 5, '0', STR_PAD_LEFT));
    }

    public function changeTaxWithholding ($request)
    {
        $db     = hbm_db();
        $aData  = array();

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $rate           = isset($request['rate']) ? $request['rate'] : 0;
        $isTax15        = ($rate == 1.5) ? 1 : 0;
        $isEstimate     = isset($request['isEstimate']) ? $request['isEstimate'] : 0;

        if ($isEstimate) {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $aData);
            $this->json->show();
        }

        $db->query("
        UPDATE hb_invoices
        SET
            is_tax_wh_15 = :is_tax_wh_15
        WHERE
            id = :invoiceId
        ", array(
            ':is_tax_wh_15'      => $isTax15,
            ':invoiceId'        => $invoiceId,
        ));

        $request['isReturn']    = 1;
        $this->updateTaxWithholding($request);


        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $aData);
        $this->json->show();
    }

    /**
     * บันทึกการ ภาษีหัก ณ ที่จ่ายใหม่ เมื่อ invoice item มีการเปลี่ยนแปลง
     */
    public function updateTaxWithholding ($request)
    {
        $db     = hbm_db();

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $isReturn       = isset($request['isReturn']) ? $request['isReturn'] : 0;
        $isEstimate     = isset($request['isEstimate']) ? $request['isEstimate'] : 0;

        if ($isEstimate) {
            $this->recalculateEstimate($request);
           return true;
        }

        if (! $invoiceId) {
            return false;
        }


        $result         = $db->query("
                    SELECT
                        i.*
                    FROM
                        hb_invoices i
                    WHERE
                        i.id = :invoiceId
                    ", array(
                        ':invoiceId'        => $invoiceId
                    ))->fetch();


        if (isset($result['id'])) {

            if ($result['status'] != 'Unpaid') {
                return false;
            }

            $tax            = ($result['subtotal'] * $result['taxrate']) / 100;
            $tax            = round($tax, 2);
            $total          = $result['subtotal'] + $tax;

            $tax_wh_3       = ($result['subtotal'] * 3) / 100;
            $tax_wh_3       = round($tax_wh_3, 2);
            $total_wh_3     = $total - $tax_wh_3;
            $total_wh_3     = round($total_wh_3, 2);
            $tax_wh_1       = ($result['subtotal'] * 1) / 100;
            $tax_wh_1       = round($tax_wh_1, 2);
            $total_wh_1     = $total - $tax_wh_1;
            $total_wh_1     = round($total_wh_1, 2);
            $tax_wh_15      = ($result['subtotal'] * 1.5) / 100;
            $tax_wh_15      = round($tax_wh_15, 2);
            $total_wh_15    = $total - $tax_wh_15;
            $total_wh_15    = round($total_wh_15, 2);

            $db->query("
                UPDATE hb_invoices
                SET tax_wh_3 = :tax_wh_3,
                    total_wh_3 = :total_wh_3,
                    tax_wh_1 = :tax_wh_1,
                    total_wh_1 = :total_wh_1,
                    tax_wh_15 = :tax_wh_15,
                    total_wh_15 = :total_wh_15,
                    tax = :tax,
                    `total` = :total,
                    `grandtotal` = :total
                WHERE
                    id = :invoiceId
                ", array(
                    ':tax_wh_3'         => $tax_wh_3,
                    ':total_wh_3'       => $total_wh_3,
                    ':tax_wh_1'         => $tax_wh_1,
                    ':total_wh_1'       => $total_wh_1,
                    ':tax_wh_15'        => $tax_wh_15,
                    ':total_wh_15'      => $total_wh_15,
                    ':invoiceId'        => $invoiceId,
                    ':tax'              => $tax,
                    ':total'            => $total
                ));

        }

        $this->backupInvoice($invoiceId);

        $request['isReturn']    = 1;
        $this->recalculateProforma($request);

        if ($isReturn) {
            return true;
        }

        return true;

    }

    /* --- แสดงรายการ invoice ที่ยังค้างชำระ แบบ print view --- */
    public function listUnpaid ($request)
    {
        $db         = hbm_db();

        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        if (! $clientId) {
            return false;
        }

        $result         = $db->query("
                    SELECT
                        cd.*
                    FROM
                        hb_client_details cd
                    WHERE
                        cd.id = :clientId
                    ", array(
                        ':clientId'     => $clientId
                    ))->fetch();
        $this->template->assign('oClient', (object) $result);

        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---

        $aParam     = array(
            'call'      => 'module',
            'module'    => 'invoicefilter',
            'fn'        => 'clientInvoice',
            'clientId'  => $clientId,
            'status'    => 'Unpaid',
            'limit'     => time(),
            'offset'    => 0
        );
        $result = $apiCustom->request($aParam);

        if (! $result['success'] || ! count($result['aInvoices'])) {
            return false;
        }

        $aInvoices  = array();

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
                  ORDER BY i.date DESC
                  ")->fetchAll();

        if (count($result)) {
            $aInvoices      = $result;

            foreach ($result as $k => $v) {
                $aInvoices[$k]['invoiceNo']           = 'Q-'. substr($v['date'], 0, -2) .$v['id'];
            }
        }

        $this->template->assign('aInvoices', $aInvoices);

        $aInvoiceIds    = array();
        foreach ($aInvoices as $v) {
            array_push($aInvoiceIds, $v['id']);
        }

        /* --- list service เพื่อให้เข้าถึงข้อมูลได้มากขึ้น --- */
        if (count($aInvoices)) {
            $aInvoiceServices   = array();
            $result     = $db->query("
                      SELECT ii.id, ii.invoice_id, ii.description, ii.qty, ii.amount
                      FROM hb_invoice_items ii
                      WHERE ii.invoice_id IN (". implode(',', $aInvoiceIds) .")
                      ORDER BY ii.invoice_id ASC
                      ")->fetchAll();
            if (count($result)) {
                foreach ($result as $v) {
                    $aInvoiceServices[$v['invoice_id']][$v['id']]   = $v;
                }
            }
            $this->template->assign('aInvoiceServices', $aInvoiceServices);
        }

        //echo '<pre>'. print_r($aInvoices, true) .'</pre>';

        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/listUnpaid.tpl', array(), true);
    }

    /* --- เอาราคาก่อน vat มาตั้งเป็น Unit price สำหรับ Pro forma invoice --- */
    public function recalculateProforma ($request)
    {
        $db             = hbm_db();

        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $isReturn       = isset($request['isReturn']) ? $request['isReturn'] : 0;

        $result         = $db->query("
                SELECT
                    ii.id AS itemId, ii.amount AS itemAmount, i.taxrate AS itemTaxRate,
                    i.*
                FROM
                    hb_invoice_items ii,
                    hb_invoices i
                WHERE
                    ii.invoice_id = :invoiceId
                    AND ii.type = 'Invoice'
                    AND ii.item_id = i.id
                ", array(
                    ':invoiceId'        => $invoiceId
                ))->fetchAll();

        $subtotal       = 0;
        $tax            = 0;
        $total          = 0;

        if (count($result)) {
            foreach ($result as $aItem) {

                $subtotal       = $subtotal + $aItem['subtotal'];
                $taxAmount      = $aItem['tax'];
                $taxAmount      = round($taxAmount, 2);

                $db->query("
                    UPDATE
                        hb_invoice_items
                    SET
                        amount = :amount,
                        unit_price = :amount,
                        discount_price  = 0,
                        qty = 1,
                        taxed = 1,
                        tax = :tax,
                        tax_rate =:tax_rate
                    WHERE
                        id = :itemId
                    AND invoice_id = :invoiceId
                    ", array(
                        ':amount'   => $aItem['subtotal'],
                        ':tax'      => $taxAmount,
                        ':itemId'   => $aItem['itemId'],
                        ':tax_rate' => $aItem['itemTaxRate'],
                        ':invoiceId' => $invoiceId
                    ));
            }

            $result         = $db->query("
                SELECT
                    ii.*
                FROM
                    hb_invoice_items ii
                WHERE
                    ii.invoice_id = :invoiceId
                    AND ii.type = 'Other'
                ", array(
                    ':invoiceId'        => $invoiceId
                ))->fetchAll();
            if (count($result)) {
                foreach ($result as $aItem) {
                    $subtotal       = $subtotal + $aItem['amount'];
                }
            }
            $result         = $db->query("
                SELECT
                    i.*
                FROM
                    hb_invoices i
                WHERE
                    i.id = :invoiceId
                ", array(
                    ':invoiceId'        => $invoiceId
                ))->fetch();

            $tax            = ($subtotal * ($result['taxrate'] ? $result['taxrate'] : 0)) / 100;
            $tax            = round($tax, 2);
            $total          = $result['subtotal'] + $tax;
            $tax_wh_3       = ($subtotal * 3) / 100;
            $tax_wh_3       = round($tax_wh_3, 2);
            $total_wh_3     = $total - $tax_wh_3;
            $total_wh_3     = round($total_wh_3, 2);
            $tax_wh_1       = ($subtotal * 1) / 100;
            $tax_wh_1       = round($tax_wh_1, 2);
            $total_wh_1     = $total - $tax_wh_1;
            $total_wh_1     = round($total_wh_1, 2);
            $tax_wh_15      = ($subtotal * 1.5) / 100;
            $tax_wh_15      = round($tax_wh_15, 2);
            $total_wh_15    = $total - $tax_wh_15;
            $total_wh_15    = round($total_wh_15, 2);

            $db->query("
                    UPDATE
                        hb_invoices
                    SET
                        subtotal = :subtotal,
                        tax = :tax,
                        total = :total,
                        grandtotal = :total,
                        tax_wh_3   = :tax_wh_3,
                        total_wh_3 = :total_wh_3,
                        tax_wh_1   = :tax_wh_1,
                        total_wh_1 = :total_wh_1,
                        tax_wh_15  = :tax_wh_15,
                        total_wh_15 = :total_wh_15
                    WHERE
                        id = :invoiceId
                    ", array(
                        ':subtotal'         => $subtotal,
                        ':tax'              => $tax,
                        ':total'            => $total,
                        ':tax_wh_3'         => $tax_wh_3,
                        ':total_wh_3'       => $total_wh_3,
                        ':tax_wh_1'         => $tax_wh_1,
                        ':total_wh_1'       => $total_wh_1,
                        ':tax_wh_15'        => $tax_wh_15,
                        ':total_wh_15'      => $total_wh_15,
                        ':invoiceId'        => $invoiceId
                    ));

        }

        if ($isReturn) {
            return true;
        }

        // ส่งไป recalculate ด้วย javascript
        header('location: '. $adminUrl .'/index.php?cmd=invoices&action=edit&id='. $invoiceId);
        exit;
    }


    public function recalculateEstimate ($request)
    {
        $db             = hbm_db();

        $estimateId     = isset($request['invoiceId']) ? $request['invoiceId'] : 0;

        $result         = $db->query("
                SELECT *
                FROM hb_estimates e,
                    hb_estimate_items ei
                WHERE e.id = ei.estimate_id
                AND e.id = :estimateId
                AND e.status = 'Draft'
                ", array(
                    ':estimateId'        => $estimateId
                ))->fetchAll();

        if(!count($result)){
            return true;
        }

        $subtotal       = 0;
        $tax            = 0;
        $total          = 0;


        foreach ($result as $aItem) {
            $subtotal       = $subtotal + $aItem['amount'];
            $tax            = $tax + ($aItem['taxed'] ? $aItem['tax'] : 0);
        }

        $total          = $subtotal + $tax;

        $db->query("
        UPDATE
            hb_estimates
        SET
            subtotal = :subtotal,
            tax = :tax,
            total = :total
        WHERE
            id = :estimateId
        ", array(
            ':subtotal'         => $subtotal,
            ':tax'              => $tax,
            ':total'            => $total,
            ':estimateId'        => $estimateId
        ));

        return true;
    }



    public function changeQuantity ($request)
    {

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $invoiceItemId  = isset($request['invoiceItemId']) ? $request['invoiceItemId'] : 0;
        $quantityValue  = isset($request['quantityValue']) ? $request['quantityValue'] : 0;
        $isEstimate     = isset($request['isEstimate']) ? $request['isEstimate'] : 0;

        if ($isEstimate) {
            invoicehandle_model::singleton()->updateEstimateItemQuantity($invoiceItemId, $quantityValue);
            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }

        if ($this->isCompleteInvoice($invoiceId)) {
            // [ใช้ไม่ได้ error] $this->addInfo('Cannot update completed invoice.');
            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }

        $result     = invoicehandle_model::singleton()->getInvoiceItemByInvoiceItemId($invoiceItemId);

        if (! isset($result['id'])) {
            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }

        $quantityText   = preg_replace('/\d{1,}/', $quantityValue, $result['quantity_text']);
        $quantityText   = $quantityText ? $quantityText : $quantityValue;

        $aData      = array(
            'quantityValue'     => $quantityValue,
            'quantityText'      => $quantityText,
        );
        invoicehandle_model::singleton()->updateInvoiceItemQuantity($invoiceItemId, $aData);

        $result     = array();
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }

    public function changeQuantityUnit ($request)
    {

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $invoiceItemId  = isset($request['invoiceItemId']) ? $request['invoiceItemId'] : 0;
        $quantityText   = isset($request['quantityText'])  ? $request['quantityText']  : 0;
        $isEstimate     = isset($request['isEstimate']) ? $request['isEstimate'] : 0;

        if ($isEstimate) {
            invoicehandle_model::singleton()->updateEstimateItemQuantityText($invoiceItemId, $quantityText);
            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }

        if ($this->isCompleteInvoice($invoiceId)) {
            // [ใช้ไม่ได้ error] $this->addInfo('Cannot update completed invoice.');
            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }

        $result     = invoicehandle_model::singleton()->getInvoiceItemByInvoiceItemId($invoiceItemId);

        if (! isset($result['id'])) {
            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }


        invoicehandle_model::singleton()->updateInvoiceItemQuantityText($invoiceItemId, $quantityText);

        $result     = array();
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
    }

    public function updateQuantity ($request)
    {
        $db             = hbm_db();

        require_once(APPDIR . 'class.discount.custom.php');

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $isReturn       = isset($request['return']) ? $request['return'] : false;

        $result         = $db->query("
                SELECT
                    ii.*
                FROM
                    hb_invoice_items ii
                WHERE
                    ii.invoice_id = :invoiceId
                ", array(
                    ':invoiceId'    => $invoiceId
                ))->fetchAll();

        $isUpdated      = true;
        $aInvoiceItems  = array();

        if (count($result)) {
            foreach ($result as $arr) {
                // ข้าม invoice item ประเภทที่ไม่มี quantity
                $isValid        = invoicehandle_controller::_isValidInvoiceItemType(array('type' => $arr['type']));
                if (! $isValid) {
                    continue;
                }

                $itemId     = $arr['id'];
                $aInvoiceItems[$itemId]     = $arr;

                if (! intval($arr['quantity'])) {
                    $isUpdated      = false;
                    break;
                }

            }
        }

        if ($isUpdated && $isReturn) {
            /* --- ไม่มีการ update --- */
            return false;
        }

        if (! count($aInvoiceItems)) {
            return false;
        }

        foreach ($aInvoiceItems as $arr) {
            if (intval($arr['quantity'])) {
                //continue;
            }

            $itemId         = $arr['id'];
            $serviceId      = $arr['item_id'];
            $itemAmount     = $arr['amount'];
            $itemQty        = $arr['qty'];
            $itemType       = $arr['type'];

            $quantity       = 0;
            $quantityText   = '';
            $unitPrice      = 0;
            $discount       = 0;

            /*
             '','Addon','Other','Upgrade','Invoice','Config','Credit',
             'FieldUpgrade','Field','Discount','Support','RefundedItem'
             */
            switch ($itemType) {
                case 'Domain Register'  :
                case 'Domain Renew'     :
                case 'Domain Transfer'  : {
                    $result         = $db->query("
                            SELECT
                                d.*
                            FROM
                                hb_domains d
                            WHERE
                                d.id = :domainId
                            ", array(
                                ':domainId'     => $serviceId
                            ))->fetch();

                    if (! isset($result['id'])) {
                        break;
                    }

                    $quantity       = $result['period'];
                    $quantityText   = 'YEAR';
                    $isPrivate      = $result['idprotection'];

                    /* --- หาราคา 1 ปี --- */
                    $result         = $db->query("
                            SELECT
                                d.id, dp.*
                            FROM
                                hb_domains d,
                                hb_domain_periods dp
                            WHERE
                                d.id = :domainId
                                AND d.tld_id = dp.product_id
                                AND dp.period = 1
                            ", array(
                                ':domainId'     => $serviceId
                            ))->fetch();

                    if (! isset($result['id'])) {
                        break;
                    }

                    $domType    = strtolower(substr($itemType,7));
                    $unitPrice  = $result[$domType];
                    if ($isPrivate) {
                        $unitPrice  = $unitPrice * 2;
                    }

                    break;
                }
                case 'Hosting'          : {

                    /* --- รองรับ เฉพาะ product เช่น google app --- */

                    $aQuantityPresent   = DiscountCustom::singleton()->accountQuantityPresent($serviceId);

                    /* --- product อื่นๆ --- */

                    $result         = DiscountCustom::singleton()->getAccountPrice($serviceId);

                    $basePrice      = isset($result['unitPrice']) ? $result['unitPrice'] : '';
                    $unitPrice      = $basePrice;
                    $billingCycle   = isset($result['billingcycle']) ? $result['billingcycle'] : '';
                    $bc             = strtolower(substr($billingCycle, 0, 1));
                    $xQuantity      = $bc . 'Quantity';
                    $quantity       = isset($result[$xQuantity]) ? $result[$xQuantity] : 0;
                    $xQuantityText  = $bc . 'QuantityText';
                    $quantityText   = isset($result[$xQuantityText]) ? $result[$xQuantityText] : '';

                    if (isset($aQuantityPresent['id'])) {
                        $quantity       = isset($aQuantityPresent['quantity']) ? $aQuantityPresent['quantity'] : 1;
                        $quantityText   =  isset($result[$xQuantity]) ? 'Seat(s)/ '.$result[$xQuantity].$result[$xQuantityText] : $xQuantityText;
                        $unitPrice      = ($itemAmount * $itemQty) / $quantity;
                        break;
                    }
                    /* --- component form resource --- */
                    $aResources         = DiscountCustom::singleton()->getAccountConfigResourcePrice($serviceId);

                    if (count($aResources)) {
                        foreach ($aResources as $configId => $aConfig) {

                            $c2aQty     = $aConfig['qty'];

                            $result     = DiscountCustom::singleton()->getResourceTieredDiscount($configId, $c2aQty, $bc);
                            if ($result['unitPrice'] && $c2aQty) {
                                $unitPrice              = $unitPrice + ($result['unitPrice'] * $c2aQty / $quantity);
                            }

                        }
                    }

                    /* --- component form regular --- */
                    $aRegulars          = DiscountCustom::singleton()->getAccountConfigRegularPrice($serviceId);

                    if (count($aRegulars)) {
                        foreach ($aRegulars as $configId => $aConfig) {

                            $result     = DiscountCustom::singleton()->getRegularDiscount($aConfig, $bc);

                            if (isset($result['unitPrice']) && $result['unitPrice']) {
                                $unitPrice              = $unitPrice + $result['unitPrice'];
                            }

                        }
                    }

                    break;
                }
                case 'Addon'          : {
                    $result         = DiscountCustom::singleton()->getAccountAddonPrice($serviceId);

                    $basePrice      = isset($result['unitPrice']) ? $result['unitPrice'] : '';
                    $unitPrice      = $basePrice;
                    $billingCycle   = isset($result['billingcycle']) ? $result['billingcycle'] : '';
                    $bc             = strtolower(substr($billingCycle, 0, 1));
                    $xQuantity      = $bc . 'Quantity';
                    $quantity       = isset($result[$xQuantity]) ? $result[$xQuantity] : 0;
                    $xQuantityText  = $bc . 'QuantityText';
                    $quantityText   = isset($result[$xQuantityText]) ? $result[$xQuantityText] : '';
                    $dc             = $bc .'Discount';
                    $discount       = (isset($result[$dc]) && $result[$dc] > 0) ? $result[$dc] : 0;

                    break;
                }
            }

            $unitPrice      = $unitPrice ? $unitPrice : $itemAmount;
            $quantity       = $quantity ? $quantity : $itemQty;

            $discount       = ($unitPrice * $quantity) - ($itemAmount * $itemQty);

            /* --- ถ้า discount ติดลบ แสดงว่า unit price ต้องเพิ่ม customfield เข้ามา --- */

            if ($discount < 0) {
                $unitPrice  = $unitPrice + ($discount/$quantity);
                $discount   = 0;
            }


            $db->query("
                UPDATE
                    hb_invoice_items
                SET
                    unit_price = :unitPrice,
                    discount_price = :discountPrice,
                    quantity = :quantity,
                    quantity_text = :quantityText
                WHERE
                    id = :itemId
                ", array(
                    ':itemId'       => $itemId,
                    ':unitPrice'    => $unitPrice,
                    ':discountPrice'=> $discount,
                    ':quantity'     => $quantity,
                    ':quantityText' => $quantityText
                ));

        }

        if ($isReturn) {
            return true;
        }


    }

    public function getInvoiceOwner ($invoiceId)
    {
        $db         = hbm_db();
        $aResults   = array();
        $aResult    = array('id' => 0, 'type' => 'Renew', 'owner' => ' --- ');

        $result     = $db->query("
            SELECT ii.*
            FROM hb_invoice_items ii
            WHERE ii.invoice_id = :invoiceId
                AND ii.type = 'Invoice'
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();
        if (count($result)) {
            foreach ($result as $arr) {
                $aResults[$arr['item_id']]  = $aResult;
                $aResults[$arr['item_id']]['id']    = $arr['item_id'];
            }
        } else {
            $result     = $db->query("
                SELECT i.*
                FROM hb_invoices i
                WHERE i.id = :id
                ", array(
                    ':id'   => $invoiceId
                ))->fetch();
            if (isset($result['id'])) {
                $aResults[$result['id']]    = $aResult;
                $aResults[$result['id']]['id']      = $result['id'];
            }
        }

        foreach ($aResults as $invoiceId => $arr) {
            $result     = $db->query("
                SELECT i.id, ii.type, ad.firstname, ad.lastname,
                    o.invoice_id
                FROM hb_invoices i
                    LEFT JOIN hb_admin_details ad
                        ON ad.id = i.staff_owner_id
                    LEFT JOIN hb_invoice_items ii
                        ON ii.invoice_id = i.id
                    LEFT JOIN hb_orders o
                        ON o.invoice_id = i.id
                WHERE i.id = :invoiceId
                ", array(
                    ':invoiceId'    => $invoiceId
                ))->fetch();

            $result     = $db->query("
                SELECT i.id, ad.firstname, ad.lastname
                FROM hb_invoices i,
                    hb_admin_details ad
                WHERE i.id = :invoiceId
                    AND i.staff_owner_id = ad.id
                ", array(
                    ':invoiceId'    => $invoiceId
                ))->fetch();

            $aResults[$invoiceId]   = $aResult;
            $aResults[$invoiceId]['id']     = $invoiceId;

            if (isset($result['firstname']) && $result['firstname']) {
                $aResults[$invoiceId]['owner']  = $result['firstname'] .' '. $result['lastname'];
            }

            $result     = $db->query("
                SELECT ii.*
                FROM hb_invoice_items ii
                WHERE ii.invoice_id = :invoiceId
                ", array(
                    ':invoiceId'    => $invoiceId
                ))->fetchAll();

            if (count($result)) {
                $result_    = $result;
                foreach ($result_ as $arr) {
                    $type       = $arr['type'];
                    $itemId     = $arr['item_id'];

                    if ($type == 'Domain Renew') {
                        $aResults[$invoiceId]['type']   = 'Renew';
                        break;
                    }
                    if (preg_match('/^Domain/i', $type)) {
                        $aResults[$invoiceId]['type']   = 'New';
                    }
                    if (preg_match('/Upgrade/i', $type)) {
                        $aResults[$invoiceId]['type']   = 'New';
                    }
                    if ($type == 'Hosting') {
                        $result     = $db->query("
                            SELECT a.*
                            FROM hb_accounts a,
                                hb_orders o
                            WHERE a.id = :id
                                AND a.order_id = o.id
                                AND o.invoice_id = :invoice_id
                            ", array(
                                ':id'   => $itemId,
                                ':invoice_id'   => $invoiceId,
                            ))->fetch();
                        if (isset($result['id'])) {
                            $aResults[$invoiceId]['type']   = 'New';
                        }
                    }

                }
            }

        }

        return $aResults;
    }

    /*เพิ่มการแสดงผลระยะสัญญาใน invoice  (dd/mm/yyyy - dd/mm/yyyy)*/
     public function durationOfContract($request)
     {

        $aInvoice       = isset($request['items']) ? $request['items'] : array();
        $db             = hbm_db();

        if (! count($aInvoice)) {
            return false;
        }

        $isUpdate       = false;

        foreach ($aInvoice as $item) {
            if(preg_match("/(0[1-9]|[1-2][0-9]|3[0-1])\/(0[1-9]|1[0-2])\/[0-9]{4}/",$item['description'])){
                continue;
            }else{
                $result         = $db->query("
                                        SELECT
                                            ii.*,
                                            d.expires, d.period, d.idprotection, d.status
                                        FROM
                                            hb_invoice_items ii,
                                            hb_domains d
                                        WHERE
                                            ii.item_id = :itemId
                                            AND ii.invoice_id = :invoiceId
                                            AND ii.type LIKE 'Domain%'
                                            AND ii.item_id = d.id
                                        ", array(
                                            ':itemId'       => $item['item_id'],
                                            ':invoiceId'    => $item['invoice_id']
                                        ))->fetchAll();

                $aInvoiceItems       = $result;

                if (! count($aInvoiceItems)) {
                    continue;
                }

                foreach ($aInvoiceItems as $aItem) {

                    $description    = $aItem['description'];
                    $period         = $aItem['period'];
                    $startDate      = ($aItem['expires'] == '0000-00-00') ? time() : strtotime($aItem['expires']);
                    $endDate        = mktime(0,0,0,date('n', $startDate),date('j', $startDate),date('Y', $startDate)+$period);

                    $aPending       = array('Pending','Pending Registration','Pending Transfer');
                    if ($aItem['type'] == 'Domain Renew' && !in_array($aItem['status'],$aPending)) {
                        if($aItem['idprotection'] === 3){//ค่า idprotection ผิด ต้องดึงมาจาก form
                            $description    .= '<br> + privateDomain:  ('. date('d/m/Y', $startDate) .' - '. date('d/m/Y', $endDate) .')';
                        }
                        else{
                            $description    .= ' ('. date('d/m/Y', $startDate) .' - '. date('d/m/Y', $endDate) .')';
                        }
                    } else {
                            $description    .= ' <!--('. date('d/m/Y', $startDate) .' - '. date('d/m/Y', $endDate) .')-->';
                    }

                    $db->query("
                            UPDATE
                                hb_invoice_items
                            SET
                                description = :description
                            WHERE
                                id = :itemId
                            ", array(
                                ':description'  => $description,
                                ':itemId'       => $aItem['id']
                            ));
                      $isUpdate     = true;
                }

            }

        }

        return $isUpdate;
    }

	public function ajaxFilterInvoiceByClientId($request){

		$db         = hbm_db();

        $keyword    = isset($request['data']) ? $request['data'] : '';
		$client_id	= isset($request['client_id']) ? $request['client_id'] : '';

        $result     = $db->query("
                	SELECT
                			inv.id, inv.locked, inv.currency_id, inv.date, inv.duedate, inv.datepaid, (inv.subtotal + inv.tax + inv.tax2) as subtotal2,
                			inv.credit, inv.total, inv.paid_id,inv.status, cd.firstname, inv.client_id, cd.lastname, mods.modname as module, 0 as recid
                	FROM
                		hb_invoices inv
                			LEFT JOIN
                				hb_client_details cd  ON (inv.client_id=cd.id)
	               			LEFT JOIN
	               				hb_modules_configuration mods ON (inv.payment_module=mods.id)
	                		LEFT JOIN
	                			hb_invoice_items item ON item.invoice_id = inv.id
                	WHERE
                		inv.status != 'Recurring'
                		AND inv.client_id=:client_id
                		AND inv.id LIKE :keyword
                		GROUP BY inv.id  ORDER BY inv.`id` DESC
                ", array(
                    ':keyword'  		=> '%'. $keyword .'%' ,
                    ':client_id'		=>	$client_id
                ))->fetchAll();
        $data	= $result;
        foreach($result as $key => $invoice){

        	$result2	= $db->query("
        						SELECT
        							id,description
        						FROM
        							hb_invoice_items
        						WHERE
        							invoice_id = :invoiceId
        					", array(
        						':invoiceId'		=>	$invoice['id']
        					))->fetchAll();
        	$countRow = 0;
        	$num	= count($result2);
        	foreach($result2 as $desc){
        		$countRow++;
        		$data[$key]['desc'] .= $desc['description'];
        		if($num-1 > $countRow){
        			$data[$key]['desc']	.= ' + ';
        		}
        	}

        }

		$resHtml = '';
		if(count($data) > 0){
			$resHtml = ' <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
						 <thead>
							<tr>
								<th>Invoice #</th>
								<th>ใบกำกับภาษี</th>
								<th>Invoice Date</th>
								<th>Due Date</th>
								<th>Total</th>
								<th>Payment Method</th>
								<th>Status</th>
								<th width="20"/>
							  </tr>
						 </thead>';
			$resHtml .= "<tbody>";
			foreach($data as $invoice){

				$resHtml .= "<tr>";
				$resHtml .= "<td rowspan=\"2\" nowrap><a href=\"?cmd=invoices&action=edit&id={$invoice['id']}\" target=\"_blank\">{$invoice['id']}</a></td>";
				$resHtml .= "<td></td>";
				$invoiceDate	= date('d M Y' , strtotime($invoice['date']));
				$resHtml .= "<td>{$invoiceDate}";
				$invoiceduedate	= date('d M Y' , strtotime($invoice['duedate']));
				$resHtml .= "<td>{$invoiceduedate}";
				$total	= number_format($invoice['total'], 2, '.', ',');
				$resHtml .= "<td>{$total} บาท</td>";
				$resHtml .= "<td>{$invoice['module']}</td>";
				$resHtml .= "<td><span class=\"{$invoice['status']}\">{$invoice['status']}</span></td>";
				$resHtml .= "<td><a href=\"?cmd=invoices&action=edit&id={$invoice['id']}\"  class=\"editbtn\" target=\"_blank\">Edit</a></td>";
				$resHtml .= "</tr>";
				$resHtml .= "<tr><td colspan=\"7\">{$invoice['desc']}</td></tr>";

			}
			$resHtml .= "</tbody></table>";
		}else{
			$resHtml .= '<center><h3><font color=red>Nothing to display.</font><h3></center>';
		}

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $resHtml);
        $this->json->show();

    }
    public function updateInvoiceDetailByInvoiceId($invoiceId)
    {
        $db         = hbm_db();

        require_once(APPDIR . 'class.discount.custom.php');

        $invoiceId  = isset($invoiceId['id']) ? $invoiceId['id'] : $invoiceId;
        $aInvoiceitems  = invoicehandle_model::singleton()->getInvoiceItemsStatusNotPaidByInvoiceId($invoiceId);

        $aEstimateItems = invoicehandle_model::singleton()->listEsitmateAmountByInvoiceId($invoiceId);

        $isConvertFromEstimate = count($aEstimateItems);



        if (! count($aInvoiceitems)) {
            return false;
        }

         // ดูว่าแต่ละ item เป็นการลดประเภทใหน
         $aItems     = $aInvoiceitems;
         for ($i = 0; $i < count($aItems); $i++) {

            $aItem              = $aItems[$i];
            $aEstimateItem      = (isset($aEstimateItems[$i])) ? $aEstimateItems[$i] : array() ;
            $estimateAmount     = (isset($aEstimateItem['amount'])) ?$aEstimateItem['amount'] : 0 ;
            $estimateDiscount   = (isset($aEstimateItem['discount_price'])) ?$aEstimateItem['discount_price'] : 0 ;
            $estimateUnitPrice  = (isset($aEstimateItem['unit_price'])) ?$aEstimateItem['unit_price'] : 0 ;

            // invoice item บางตัวไม่ต้องเอามาคิดส่วนลด เดี๋ยวจะผิดพลาด
            if ($aItem['type'] == 'Invoice' || $aItem['type'] == 'Credit' || $aItem['type'] == 'Discount') {
                continue;
            }

            // หาส่วนลดตามรอบบิล
            $itemType       = $aItem['type'];
            switch ($itemType) {
                case 'Domain Register'  :
                case 'Domain Renew'     :
                case 'Domain Transfer'  : {

                    $domType        = strtolower(substr($itemType,7)); //register, transfer

                    $aResultDomain =  invoicehandle_model::singleton()->getDomainDataByDomainId($aItem['item_id']);


                    $isPrivateDomain = ( isset($aResultDomain['idprotection']['data']) && $aResultDomain['idprotection']['data']) ? 1 : 0;


                    $aParam         = array(
                        'productId'  => $aResultDomain['product_id'],
                        'period'     => $aResultDomain['period'],
                        'domainType' => $domType
                    );

                    $domainData = $this->calculateDomainItemData ($aParam,$isPrivateDomain);

                    $quantity       = (isset($domainData['quantity'])) ? $domainData['quantity'] : 1;
                    $quantityText   = (isset($domainData['quantityText']) ) ? $domainData['quantityText'] :'';
                    $discount       = (isset($domainData['discountPrice']) ) ? $domainData['discountPrice'] :$aItem['discount_price'];
                    $newUnitPrice   = (isset($domainData['unitPrice'])) ? $domainData['unitPrice'] : $aItem['unit_price'] ;
                    $newAmount      = (isset($domainData['amount'])) ? $domainData['amount'] : $aItem['amount'] ;

                    if($isConvertFromEstimate){
                        $discount  = $estimateDiscount;
                        $newAmount = $estimateAmount;
                        $newUnitPrice = $estimateUnitPrice;
                    }

                    $db->query("
                        UPDATE hb_invoice_items
                        SET discount_price = :discount,
                            unit_price = :unitPrice,
                            quantity = :quantity,
                            quantity_text = :quantityText,
                            amount = :newAmount
                        WHERE id = :id
                        ", array(
                            ':discount'     => $discount,
                            ':unitPrice'    => $newUnitPrice,
                            ':quantity'     => $quantity,
                            ':quantityText' => $quantityText,
                            ':id'           => $aItem['id'],
                            ':newAmount'    => $newAmount,
                        ));

                    break;
                }
                case 'Hosting' : {//hosting
                    $resultQuantity  = DiscountCustom::singleton()->accountQuantityPresent($aItem['item_id']);
                    

                    $aPriceCycle   = invoicehandle_model::singleton()->getAccountPrice($aItem['item_id']);


                    $productData   = $this->productDiscountItem($aPriceCycle);

                    $newAmount = $aItem['amount'] ;
                    $quantityBillingCycle  = 1;

                    $bc     = isset($aPriceCycle['billingcycle']) ? $aPriceCycle['billingcycle'] : '';
                    $bc     = $bc ? strtolower(substr($bc, 0, 1)) : '';// m q s a b t
                    if($aPriceCycle['billingcycle'] == 'Quadrennially'){ //4ปี
                        $bc  ='p4';
                    }
                    if($aPriceCycle['billingcycle'] == 'Quinquennially'){ // 5ปี
                        $bc ='p5';
                    }
                    $qt             = $bc .'Quantity';
                    $qtext          = $bc .'QuantityText';
                    $unitPrice      = isset($productData['unitPrice']) ? $productData['unitPrice'] : 0;
                    $quantity       = isset($productData[$qt]) ? $productData[$qt] : 1;
                    $quantityText   = isset($productData[$qtext]) ? $productData[$qtext] : 'Time';
                    
                   //quantity form
                    if (isset($resultQuantity['id']) && ($resultQuantity['variable'] == 'quantity' || preg_match("/quantity\-/", $resultQuantity['variable']))) {                
                        $quantityBillingCycle   = $quantity ;
                        $quantity               = isset($resultQuantity['quantity']) ? $resultQuantity['quantity'] : 0;
                        $quantityText           = isset($productData[$qtext]) ? 'Seat(s)/ '.$productData[$qt].$productData[$qtext] : 'Seat(s)/ '.$quantityText;
                    }


                    //component  etc. +ram +disk !quantity form
                    else {
                        $aComponents  = invoicehandle_model::singleton()->getComponentPriceByAccountId($aItem['item_id']);
                        
                        $aComponent   = $aComponents;

                        foreach ($aComponent as $arr) {

                            $aPrice   =  $this->productDiscountItem($arr);
                            $unitPriceComponent    = isset($aPrice['unitPrice']) ? $aPrice['unitPrice'] : 0;
                            $quantityComponent     = (isset($arr['qty']) && $arr['qty']) ? $arr['qty'] : 0;

                            if(isset($arr['aConfig']['initialval'])  && $arr['aConfig']['initialval']
                                && (isset($arr['aConfig']['dontchargedefault'])  && $arr['aConfig']['dontchargedefault'] ) 
                                && $quantityComponent) {

                                    $quantityComponent = $quantityComponent - $arr['aConfig']['initialval'];
                            }

                            $unitPriceComponent     = $unitPriceComponent * $quantityComponent;   

                            $unitPrice      = $unitPrice + $unitPriceComponent;
                        }


                    }

                    $discountPrice =  ($unitPrice * $quantity*$quantityBillingCycle) - $newAmount;


                    if($isConvertFromEstimate){
                        $discountPrice  = $estimateDiscount;
                        $newAmount      = $estimateAmount;
                        $unitPrice      = $estimateUnitPrice;
                    }
                    
                    $db->query("
                            UPDATE hb_invoice_items
                            SET discount_price = :discount,
                                unit_price = :unitPrice,
                                quantity = :quantity,
                                quantity_text = :quantityText,
                                amount  =:amount
                            WHERE id = :id
                            ", array(
                                ':discount'     => $discountPrice,
                                ':unitPrice'    => $unitPrice,
                                ':quantity'     => $quantity,
                                ':quantityText' => $quantityText,
                                ':amount'       => $newAmount,
                                ':id'           => $aItem['id']

                            ));

                    break;
                }
                case 'Addon'      : {

                    $aPriceCycle    = invoicehandle_model::singleton()->getAccountAddonPrice($aItem['item_id']);
                    $productData   = $this->productDiscountItem($aPriceCycle);

                    $newAmount = $aItem['amount'] ;

                    $bc     = isset($aPriceCycle['billingcycle']) ? $aPriceCycle['billingcycle'] : '';
                    $bc     = $bc ? strtolower(substr($bc, 0, 1)) : '';// m q s a b t
                    if($aPriceCycle['billingcycle'] == 'Quadrennially'){ //4ปี
                        $bc  ='p4';
                    }
                    if($aPriceCycle['billingcycle'] == 'Quinquennially'){ // 5ปี
                        $bc ='p5';
                    }
                    $qt             = $bc .'Quantity';
                    $qtext          = $bc .'QuantityText';

                    $unitPrice      = isset($productData['unitPrice']) ? $productData['unitPrice'] : 0;
                    $quantity       = isset($productData[$qt]) ? $productData[$qt] : 1;
                    $quantityText   = isset($productData[$qtext]) ? $productData[$qtext] : '';
                    $discountPrice  = ($unitPrice*$quantity)-$newAmount;

                    if($isConvertFromEstimate){
                        $discountPrice  = $estimateDiscount;
                        $newAmount      = $estimateAmount;
                        $unitPrice      = $estimateUnitPrice;
                    }

                    $db->query("
                            UPDATE hb_invoice_items
                            SET discount_price = :discount,
                                unit_price = :unitPrice,
                                quantity = :quantity,
                                quantity_text = :quantityText,
                                amount  =:amount
                            WHERE id = :id
                            ", array(
                                ':discount'     => $discountPrice,
                                ':unitPrice'    => $unitPrice,
                                ':quantity'     => $quantity,
                                ':quantityText' => $quantityText,
                                ':amount'       => $newAmount,
                                ':id'           => $aItem['id']

                            ));

                    break;
                }
                case 'FieldUpgrade' : {
                    if($aItem['amount'] == 0.00){
                        $db->query("
                            UPDATE hb_invoice_items
                            SET invoice_id = '-{$invoiceId}'
                            WHERE id = :id
                            ", array(
                                ':id'  => $aItem['id']
                       ));
                    }
                    $resultFieldUpgrade = invoicehandle_model::singleton()->getFieldUpgradeByItemId($aItem['item_id']);
                    $aPriceCycle   = invoicehandle_model::singleton()->getAccountPrice($resultFieldUpgrade['account_id']);
                    $productData   = $this->productDiscountItem($aPriceCycle);

                    $bc     = isset($aPriceCycle['billingcycle']) ? $aPriceCycle['billingcycle'] : '';
                    $bc     = $bc ? strtolower(substr($bc, 0, 1)) : '';// m q s a b t
                    if($aPriceCycle['billingcycle'] == 'Quadrennially'){ //4ปี
                        $bc  ='p4';
                    }
                    if($aPriceCycle['billingcycle'] == 'Quinquennially'){ // 5ปี
                        $bc ='p5';
                    }
                    $qt             = $bc .'Quantity';
                    $qtext          = $bc .'QuantityText';
                    $newAmount      = $aItem['amount'] ;
                    $unitPrice      = $newAmount;
                    $quantity       = isset($resultFieldUpgrade['new_qty']) ? $resultFieldUpgrade['new_qty']-$resultFieldUpgrade['old_qty'] : 0;
                    $quantityText   = 'Time';

                    if(isset($resultFieldUpgrade['config_cat']) && $resultFieldUpgrade['config_cat']){
                    $isUpgradeQuantity = invoicehandle_model::singleton()->getVariableUpgradeByConfigcat($resultFieldUpgrade['config_cat']);
                        if(isset($isUpgradeQuantity['variable']) && $isUpgradeQuantity['variable'] =='quantity'){
                            $quantityText   = isset($isUpgradeQuantity['variable'])? 'Seat(s)/ Time': $quantityText;
                            $unitPrice      = $newAmount/$quantity;
                            $unitPrice      = round($unitPrice,2);
                            $checkNewAmount = $unitPrice * $quantity ;
                            if($checkNewAmount != $newAmount){
                                $newAmount = $checkNewAmount;
                            }
                        }
                    }
                     $discountPrice  = ($unitPrice*$quantity)-$newAmount;



                    $db->query("
                            UPDATE hb_invoice_items
                            SET discount_price = :discount,
                                unit_price = :unitPrice,
                                quantity = :quantity,
                                quantity_text = :quantityText,
                                amount  =:amount
                            WHERE id = :id
                            ", array(
                                ':discount'     => $discountPrice,
                                ':unitPrice'    => $unitPrice,
                                ':quantity'     => $quantity,
                                ':quantityText' => $quantityText,
                                ':amount'       => $newAmount,
                                ':id'           => $aItem['id']

                            ));

                    $db->query("
                        UPDATE hb_invoices
                        SET subtotal  = :subtotal
                        WHERE id = :id
                        ", array(
                            ':subtotal' => $newAmount,
                            ':id'       => $invoiceId
                        ));
                    $aParam     = array(
                        'invoiceId'     => $invoiceId,
                        'isReturn'      => 1
                    );
                 $this->updateTaxWithholding($aParam);
                    break;
                }
                default : {}
            }

        }

        if($isConvertFromEstimate){  //update Invoice after convert from estimate
            $estimateId =  $aEstimateItems[0]['estimate_id'];
            invoicehandle_model::singleton()->updateInvoiceAfterConvertFromEstimate($estimateId,$invoiceId);
        }


    }

    public function updateInvoiceItemDiscount ($invoiceId)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();

        require_once(APPDIR . 'class.discount.custom.php');

        $invoiceId  = isset($invoiceId['id']) ? $invoiceId['id'] : $invoiceId;

        $result     = $db->query("
            SELECT id
            FROM hb_orders
            WHERE invoice_id = '{$invoiceId}'
            ")->fetch();
        $isNewOrder = (isset($result['id']) && $result['id']) ? 1 : 0;

        $aVVPSProduct   = array();
        $result     = $db->query("
            SELECT id
            FROM hb_products
            WHERE category_id IN (24,40,83,98,84,99)
            ")->fetchAll();
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aVVPSProduct, $arr['id']);
            }
        }

        $result     = $db->query("
            SELECT ii.*,
                i.client_id
            FROM hb_invoices i,
                hb_invoice_items ii
            WHERE i.id = :invoiceId
                AND i.id = ii.invoice_id
            ORDER BY ii.id ASC # ต้องเรียงด้วย ii.id ASC
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();

        if (! count($result)) {
            return false;
        }

        // ดูว่าแต่ละ item เป็นการลดประเภทใหน
        $aItems     = $result;

        for ($i = 0; $i < count($aItems); $i++) {

            $aItem      = $aItems[$i];

            // invoice item บางตัวไม่ต้องเอามาคิดส่วนลด เดี๋ยวจะผิดพลาด
            if ($aItem['type'] == 'Invoice' || $aItem['type'] == 'Credit' || $aItem['type'] == 'Discount') {
                continue;
            }

            $next       = $i + 1;
            $aNext      = isset($aItems[$next]) ? $aItems[$next] : array();

            if (count($aNext) && $aNext['type'] == 'Discount' ) {

                if ($aNext['item_id']) {
                    // coupon discount

                    $result     = $db->query("
                        SELECT c.*
                        FROM hb_coupons c
                        WHERE c.id = :couponId
                        ", array(
                            ':couponId' => $aNext['item_id']
                        ))->fetch();

                    $code       = isset($result['code']) ? $result['code'] : '';

                    $db->query("
                        UPDATE hb_invoice_items
                        SET discount_price_coupon_name = :name,
                            discount_price_coupon = :discount,
                            discount_price_group_product = '',
                            discount_price_group_global = '',
                            discount_price_group_name = ''
                        WHERE id = :id
                        ", array(
                            ':name'     => $code,
                            ':discount' => -($aNext['amount']),
                            ':id'       => $aItem['id'],
                        ));

                } else {
                    // group discount มีทั้ง product หรือ glboal อย่างใดอย่างหนึ่ง

                    $result     = $db->query("
                        SELECT ca.id, ca.group_id,
                            cg.name AS gname, cg.discount AS gdiscount
                        FROM hb_client_access ca,
                            hb_client_group cg
                        WHERE ca.id = :clientId
                            AND ca.group_id = cg.id
                        ", array(
                            ':clientId' => $aNext['client_id']
                        ))->fetch();

                    if (isset($result['id'])) {
                        $groupId        = $result['group_id'];
                        $groupName      = $result['gname'];
                        $groupDiscount  = $result['gdiscount'] + 0; // เป็น %
                        $productId      = 0;

                        if (preg_match('/domain/i', $aItem['type'])) {
                            $result     = $db->query("
                                SELECT d.tld_id
                                FROM hb_domains d
                                WHERE d.id = :domainId
                                ", array(
                                    ':domainId' => $aItem['item_id']
                                ))->fetch();

                            $productId  = isset($result['tld_id']) ? $result['tld_id'] : 0;

                        } else if ($aItem['type'] == 'Hosting') {
                            $result     = $db->query("
                                SELECT a.product_id
                                FROM hb_accounts a
                                WHERE a.id = :accountId
                                ", array(
                                    ':accountId'    => $aItem['item_id']
                                ))->fetch();

                            $productId  = isset($result['product_id']) ? $result['product_id'] : 0;

                        }

                        // หา product discount ของ group
                        $result     = $db->query("
                            SELECT cgd.*
                            FROM hb_client_group_discount cgd
                            WHERE cgd.group_id = :groupId
                                AND cgd.rel_id = :productId
                                AND cgd.rel = 'Product'
                            ", array(
                                ':groupId'      => $groupId,
                                ':productId'    => $productId
                            ))->fetch();

                        if (isset($result['group_id'])) {

                            $db->query("
                                UPDATE hb_invoice_items
                                SET discount_price_group_product = :discount,
                                    discount_price_group_global = ''
                                WHERE id = :id
                                ", array(
                                    ':discount' => (-$aNext['amount']),
                                    ':id'       => $aItem['id']
                                ));

                        } else if ($groupDiscount) {

                            $db->query("
                                UPDATE hb_invoice_items
                                SET discount_price_group_global = :discount,
                                    discount_price_group_product = ''
                                WHERE id = :id
                                ", array(
                                    ':discount' => (-($aNext['amount'])),
                                    ':id'       => $aItem['id']
                                ));

                        }

                        $db->query("
                            UPDATE hb_invoice_items
                            SET discount_price_group_name = :groupName,
                                discount_price_coupon_name = '',
                                discount_price_coupon = ''
                            WHERE id = :id
                            ", array(
                                ':groupName'=> $groupName,
                                ':id'       => $aItem['id']
                            ));

                    }

                }

            }

            // หาส่วนลดตามรอบบิล
            $itemType       = $aItem['type'];
            switch ($itemType) {
                case 'Domain Register'  :
                case 'Domain Renew'     :
                case 'Domain Transfer'  : {
                    $result         = DiscountCustom::singleton()->getDoaminPriceWithBase($aItem['item_id']);

                    if (! count($result)) {
                        break;
                    }

                    $domType        = strtolower(substr($itemType,7));
                    $unitPrice      = $result[0][$domType];
                    $sellPrice      = (isset($result[1])) ? $result[1][$domType] : $result[0][$domType];
                    $isPrivate      = $result[0]['idprotection'];

                    if (isset($aAdmin['id']) && $aAdmin['id'] && $itemType != 'Domain Renew') {
                        $isPrivate  = 0;
                    }

                    $quantity       = (isset($result[1])) ? $result[1]['period'] : 1;

                    $discount       = ($unitPrice * $quantity) - $sellPrice;
                    $newUnitPrice   = ($isPrivate) ? $unitPrice * 2 : $unitPrice;
                    $privatePrice   = ($isPrivate) ? ($unitPrice * $quantity) : 0;

                    $newAmount      = $newUnitPrice + $privatePrice;

                    $db->query("
                        UPDATE hb_invoice_items
                        SET discount_price_cycle = :discount,
                            unit_price = :unitPrice,
                            quantity = :quantity,
                            quantity_text = :quantityText,
                            amount = :newAmount
                        WHERE id = :id
                        ", array(
                            ':discount'     => $discount,
                            ':unitPrice'    => $newUnitPrice,
                            ':quantity'     => $quantity,
                            ':quantityText' => 'Year',
                            ':id'       => $aItem['id'],
                            ':newAmount'    => $newAmount,
                        ));

                    break;
                }
                case 'Hosting'      : {
                    // product with quantity google apps o365
                    $result         = DiscountCustom::singleton()->accountQuantityPresent($aItem['item_id']);
                    // echo '<pre> $arr '. print_r($result, true) .' </pre>';
                    if (isset($result['id'])) {
                        $configId       = $result['id'];
                        $bc             = isset($result['billingcycle']) ? $result['billingcycle'] : '';
                        $bc             = $bc ? strtolower(substr($bc, 0, 1)) : '';
                        $quantity       = isset($result['quantity']) ? $result['quantity'] : 1;
                        $quantityText   = $quantity;



                        $unitPrice      = 0;
                        $discount       = 0;

                        //$result     = DiscountCustom::singleton()->getAccountConfigResourcePrice($aItem['item_id']);
                        $result     = DiscountCustom::singleton()->getAccountConfigRegularPrice($aItem['item_id']);
                        $cid        = 0;
                        foreach ($result as $arr) {
                            if ($configId == $arr['config_cat']) {
                                $cid    = $arr['config_id'];
                                break;
                            }
                        }

                        $unitPrice      = isset($result[$cid][$bc]) ? $result[$cid][$bc] : 0;

                        $db->query("
                            UPDATE hb_invoice_items
                            SET discount_price_cycle = :discount,
                                unit_price = :unitPrice,
                                quantity = :quantity,
                                quantity_text = :quantityText
                            WHERE id = :id
                            ", array(
                                ':discount'     => $discount,
                                ':unitPrice'    => $unitPrice,
                                ':quantity'     => $quantity,
                                ':quantityText' => $quantityText,
                                ':id'       => $aItem['id']
                            ));

                        break;
                    }

                    }
                case 'Hosting'      : {

                    $result         = DiscountCustom::singleton()->getAccountPrice($aItem['item_id']);

                    $bc             = isset($result['billingcycle']) ? $result['billingcycle'] : '';
                    $bc             = $bc ? strtolower(substr($bc, 0, 1)) : '';
                    $unitPrice      = isset($result['unitPrice']) ? $result['unitPrice'] : 0;

                    $qt             = $bc .'Quantity';
                    $quantity       = isset($result[$qt]) ? $result[$qt] : 0;
                    $qtext          = $bc .'QuantityText';
                    $quantityText   = isset($result[$qtext]) ? $result[$qtext] : '';
                    $dc             = $bc .'Discount';
                    $discount       = (isset($result[$dc]) && $result[$dc] > 0) ? $result[$dc] : 0;

                    $db->query("
                        UPDATE hb_invoice_items
                        SET discount_price_cycle = :discount,
                            unit_price = :unitPrice,
                            quantity = :quantity,
                            quantity_text = :quantityText
                        WHERE id = :id
                        ", array(
                            ':discount'     => $discount,
                            ':unitPrice'    => $unitPrice,
                            ':quantity'     => $quantity,
                            ':quantityText' => $quantityText,
                            ':id'       => $aItem['id']
                        ));

                }
                case 'Hosting'      : {
                    // VPS Dedicated
                    $result     = $db->query("
                        SELECT product_id
                        FROM hb_accounts
                        WHERE id = '". $aItem['item_id'] ."'
                        ")->fetch();
                    $productId  = (isset($result['product_id'])&& $result['product_id']) ? $result['product_id'] : 0;

                    $result     = DiscountCustom::singleton()->getAccountConfigRegularPrice($aItem['item_id']);

                    if (count($result)) {
                        $result_    = $result;
                        foreach ($result_ as $arr) {
                            //echo '<pre> $arr '. print_r($arr, true) .' </pre>';
                            $result         = DiscountCustom::singleton()->_getProductDiscount($arr);
                            //echo '<pre> $result '. print_r($result, true) .' </pre>';
                            if (isset($result['aConfig']['dontchargedefault']) && $result['aConfig']['dontchargedefault']) {
                                $result['qty']  = $result['qty'] - $result['aConfig']['initialval'];
                            }
                            //echo '<pre> qty '. print_r($result['qty'], true) .' </pre>';
                            $comPrice       = isset($result['unitPrice']) ? $result['unitPrice'] * $result['qty'] : 0;
                            $comDiscount    = isset($result[$dc]) ? $result[$dc] * $result['qty'] : 0;
                            $unitPrice      = $unitPrice + $comPrice;
                            $discount       = $discount + $comDiscount;

                            //echo '<pre> $comPrice '. print_r($comPrice, true) .' $comDiscount '. print_r($comDiscount, true) .' </pre>';

                        }

                        //echo '<pre> $unitPrice '. print_r($unitPrice, true) .' $discount '. print_r($discount, true) .' </pre>';

                        // แก้ไขปัญหาว่ามีการไปแก้ไขราคาทำให้ส่วนลดติดลบ ซึ่งส่วนลดไม่ควรติดลบ
                        if ($quantity == 1 && $unitPrice < $aItem['amount']) {
                            $unitPrice      = $aItem['amount'];
                        }

                        // ไม่ต้องคิกเรื่องส่วนลดสำหรับ VPS
                        /*
                        if (! $isNewOrder && in_array($productId, $aVVPSProduct)) {
                            $unitPrice      = $aItem['amount'] / $quantity;
                            $discount       = 0;
                        }
                        */

                        $db->query("
                            UPDATE hb_invoice_items
                            SET discount_price_cycle = :discount,
                                unit_price = :unitPrice
                            WHERE id = :id
                            ", array(
                                ':discount'     => $discount,
                                ':unitPrice'    => $unitPrice,
                                ':id'       => $aItem['id']
                            ));

                    }

                    break;
                }
                case 'Addon'      : {

                    $result         = DiscountCustom::singleton()->getAccountAddonPrice($aItem['item_id']);

                    $bc             = isset($result['billingcycle']) ? $result['billingcycle'] : '';
                    $bc             = $bc ? strtolower(substr($bc, 0, 1)) : '';
                    $unitPrice      = isset($result['unitPrice']) ? $result['unitPrice'] : 0;
                    $qt             = $bc .'Quantity';
                    $quantity       = isset($result[$qt]) ? $result[$qt] : 0;
                    $qtext          = $bc .'QuantityText';
                    $quantityText   = isset($result[$qtext]) ? $result[$qtext] : '';
                    $dc             = $bc .'Discount';
                    $discount       = (isset($result[$dc]) && $result[$dc] > 0) ? $result[$dc] : 0;

                    $db->query("
                        UPDATE hb_invoice_items
                        SET discount_price_cycle = :discount,
                            unit_price = :unitPrice,
                            quantity = :quantity,
                            quantity_text = :quantityText
                        WHERE id = :id
                        ", array(
                            ':discount'     => $discount,
                            ':unitPrice'    => $unitPrice,
                            ':quantity'     => $quantity,
                            ':quantityText' => $quantityText,
                            ':id'       => $aItem['id']
                        ));

                    break;
                }
                default : {}
            }

            // เอา discount record ลบออกจาก amount record ปัจจุบัน
            if (count($aNext) && $aNext['type'] == 'Discount' ) {
                $db->query("
                    UPDATE hb_invoice_items
                    SET amount = amount - ". (-$aNext['amount']) ."
                    WHERE id = :id
                    ", array(
                        ':id'       => $aItem['id']
                    ));
            }

            // special discount
            $db->query("
                UPDATE hb_invoice_items
                SET discount_price_special = (unit_price * quantity) - amount
                    - discount_price_cycle
                    - discount_price_coupon
                    - discount_price_group_product
                    - discount_price_group_global
                WHERE id = :id
                ", array(
                    ':id'       => $aItem['id']
                ));

            // total discount
            $db->query("
                UPDATE hb_invoice_items
                SET discount_price = discount_price_cycle
                    + discount_price_coupon
                    + discount_price_group_product
                    + discount_price_group_global
                    + discount_price_special
                WHERE id = :id
                ", array(
                    ':id'       => $aItem['id']
                ));

        }

        // เอา record discount ออก
        $db->query("
            UPDATE hb_invoice_items
            SET invoice_id = -invoice_id
            WHERE invoice_id = :invoiceId
                AND type = 'Discount'
            ", array(
                ':invoiceId'    => $invoiceId
            ));

        return $aDiscount;
    }

    public function getInvoiceItemDiscount ($invoiceId)
    {
        $db         = hbm_db();

        $aDiscount  = array();

        $result     = $db->query("
            SELECT ii.*
            FROM hb_invoice_items ii
            WHERE ii.invoice_id = :invoiceId
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();

        if (count($result)) {
            foreach ($result as $arr) {
                $aDiscount[$arr['id']]  = $arr;
            }
        }

        return $aDiscount;
    }

    public function recalculateDiscount ($request)
    {
        $db         = hbm_db();

        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();

        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;

        self::updateInvoiceItemDiscount($invoiceId);

        // ส่งไป recalculate ด้วย javascript
        header('location: '. $adminUrl .'/index.php?cmd=invoices&action=edit&id='. $invoiceId);
        exit;
    }

    public function updateIsQuotation ($request)
    {
        $db         = hbm_db();
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $value      = isset($request['value']) ? $request['value'] : 0;

        $db->query("
            UPDATE hb_invoices
            SET is_quotation = :value
            WHERE id = :id
            ", array(
                ':id'   => $invoiceId,
                ':value'    => $value
            ));

        echo '<!-- {"ERROR":[]'
            . ',"INFO":["Set invoice #'. $invoiceId .' qiotation success"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function updateIsStatement ($request)
    {
        $db         = hbm_db();
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $value      = isset($request['value']) ? $request['value'] : 0;

        $db->query("
            UPDATE hb_invoices
            SET is_quotation = :value
            WHERE id = :id
            ", array(
                ':id'   => $invoiceId,
                ':value'    => $value
            ));

        echo '<!-- {"ERROR":[]'
            . ',"INFO":["Set invoice #'. $invoiceId .' qiotation success"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function updateStatus ($request)
    {
        $db         = hbm_db();
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $value      = isset($request['value']) ? $request['value'] : 0;

        if ($value) {
            $db->query("
                UPDATE hb_invoices
                SET status = :value
                WHERE id = :id
                ", array(
                    ':id'   => $invoiceId,
                    ':value'    => $value
                ));
        }

        echo '<!-- {"ERROR":[]'
            . ',"INFO":["Set invoice #'. $invoiceId .' status to '. $value .' success"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function updatePONumber ($request)
    {
        $db         = hbm_db();
        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $value      = isset($request['value']) ? $request['value'] : 0;

        $db->query("
            UPDATE hb_invoices
            SET po_number = :value
            WHERE id = :id
            ", array(
                ':id'   => $invoiceId,
                ':value'    => $value
            ));

        echo '<!-- {"ERROR":[]'
            . ',"INFO":["Set invoice #'. $invoiceId .' PO Number success"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function getAddress ($invoiceId)
    {
        $db         = hbm_db();
        $billingContactId   = 0;
        $mailingContactId   = 0;
        $contactId          = 0;

        $isModuleBCSActive  = invoicehandle_model::singleton()->isModuleActive('billing_contact_select');

        $result         = $db->query("
                    SELECT
                        a.id, a.client_id, a.billing_contact_id, a.mailing_contact_id
                    FROM
                        hb_invoice_items ii,
                        hb_accounts a
                    WHERE
                        ii.invoice_id = :invoiceId
                        AND ii.type = 'Hosting'
                        AND ii.item_id = a.id
                    ", array(
                        ':invoiceId'        => $invoiceId
                    ))->fetch();

        if (isset($result['id'])) {
            $accountId      = $result['id'];
            if ($isModuleBCSActive) {
                $aBillingContact    = invoicehandle_model::singleton()->getAccountContactId($accountId);
                $contactId          = isset($aBillingContact['contact_id']) ? $aBillingContact['contact_id'] : 0;
            }
            $billingContactId   = $result['billing_contact_id'] ? $result['billing_contact_id'] : $result['client_id'];
            $mailingContactId   = $result['mailing_contact_id'] ? $result['mailing_contact_id'] : $result['client_id'];
        } else  {
            $result         = $db->query("
                        SELECT
                            d.id, d.client_id, d.billing_contact_id, d.mailing_contact_id
                        FROM
                            hb_invoice_items ii,
                            hb_domains d
                        WHERE
                            ii.invoice_id = :invoiceId
                            AND ii.type LIKE 'Domain%'
                            AND ii.item_id = d.id
                        ", array(
                            ':invoiceId'        => $invoiceId
                        ))->fetch();

            if (isset($result['id'])) {
                $billingContactId   = $result['billing_contact_id'] ? $result['billing_contact_id'] : $result['client_id'];
                $mailingContactId   = $result['mailing_contact_id'] ? $result['mailing_contact_id'] : $result['client_id'];
            }
        }

        $aAddress   = array(
            'contactId'             => $contactId,
            'billingContactId'      => $billingContactId,
            'mailingContactId'      => $mailingContactId
        );

        return $aAddress;
    }

    public function backupInvoice ($invoiceId)
    {
        $db         = hbm_db();

        $field      = '`id`,`paid_id`,`invoice_number`,`recurring_id`,`status`,`client_id`,`contact_id`,`date`,`duedate`,`paybefore`,`datepaid`,`subtotal`,`credit`,`tax`,`taxrate`,`tax2`,`taxrate2`,`taxexempt`,`total`,`payment_module`,`currency_id`,`rate`,`rate2`,`rate3`,`notes`,`locked`,`metadata`,`promotion_code`,`tax_wh_3`,`total_wh_3`,`tax_wh_1`,`total_wh_1`,`billing_contact_id`,`billing_address`,`billing_taxid`,`mailing_contact_id`,`mailing_address`,`is_wh_tax_receipt`,`flags`,`sortid`,`staff_owner_id`,`is_quotation`,`is_gtag`,`fixed_credit`,`po_number`';
        $db->query("
            REPLACE INTO hb_invoices_archive ( {$field} )
            SELECT {$field}
            FROM hb_invoices
            WHERE id = '{$invoiceId}'
            ");

        $field      = '`id`,`invoice_id`,`type`,`item_id`,`description`,`amount`,`taxed`,`qty`,`is_shipped`,`unit_price`,`discount_price`,`quantity`,`quantity_text`,`discount_price_cycle`,`discount_price_coupon`,`discount_price_coupon_name`,`discount_price_group_product`,`discount_price_group_global`,`discount_price_group_name`,`discount_price_special`';
        $result     = $db->query("
            SELECT id
            FROM hb_invoice_items
            WHERE invoice_id = '{$invoiceId}'
            ")->fetchAll();

        if (count($result)) {
            foreach ($result as $arr) {
                $id     = $arr['id'];
                $db->query("
                    REPLACE INTO hb_invoice_items_archive ( {$field} )
                    SELECT {$field}
                    FROM hb_invoice_items
                    WHERE id = '{$id}'
                    ");
            }
        }

    }

    public function fixupgrade ($request)
    {
        $db         = hbm_db();
        $aAdmin     = hbm_logged_admin();

        $invoiceId  = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $itemId     = isset($request['itemId']) ? $request['itemId'] : 0;
        $accountId  = isset($request['accountId']) ? $request['accountId'] : 0;

        $continue   = 1;

        $result     = $db->query("
            SELECT *
            FROM hb_invoices
            WHERE id = '{$invoiceId}'
            ")->fetch();

        $clientId   = isset($result['client_id']) ? $result['client_id'] : 0;

        $result     = $db->query("
            SELECT *
            FROM hb_accounts
            WHERE id = '{$accountId}'
            ")->fetch();

        $aAccount   = $result;
        $billingcycle   = $aAccount['billingcycle'];
        $productId      = $aAccount['product_id'];

        $result     = $db->query("
            SELECT *
            FROM hb_config_items_cat
            WHERE product_id = '{$productId}'
                AND variable = 'quantity'
            ")->fetch();

        $catId      = isset($result['id']) ? $result['id'] : 0;

        $result     = $db->query("
            SELECT *
            FROM hb_config_items
            WHERE category_id = '{$catId}'
            ")->fetch();

        $configId   = isset($result['id']) ? $result['id'] : 0;

        $result     = $db->query("
            SELECT *
            FROM hb_config2accounts
            WHERE rel_type = 'Hosting'
                AND account_id = '{$accountId}'
                AND config_cat = '{$catId}'
                AND config_id = '{$configId}'
            ")->fetch();

        $qty    = isset($result['qty']) ? $result['qty'] : 0;

        if (! $clientId || ! $invoiceId || ! $itemId || ! $accountId || ! $productId || ! $catId || ! $configId || ! $qty) {
            echo '<p align="center">ข้อมูลไม่ครบ</p>';
            $continue   = 0;
        }

        $result     = $db->query("
            SELECT *
            FROM hb_orders
            WHERE invoice_id = '{$invoiceId}'
            ")->fetch();

        if (isset($result['id'])) {
            echo '<p align="center">มี Order สำหรับ Invoice นี้อยู่แล้ว</p>';
            $continue   = 0;
        }

        if ($continue) {
            $number     = time();

            $db->query("
                INSERT INTO hb_orders (
                number, client_id, invoice_id, date_created, status
                ) VALUES (
                :number, :client_id, :invoice_id, NOW(), 'Active'
                )
                ", array(
                    ':number'       => $number,
                    ':client_id'    => $clientId,
                    ':invoice_id'   => $invoiceId,
                ));

            $result     = $db->query("
                SELECT *
                FROM hb_orders
                WHERE number = '{$number}'
                ")->fetch();

            $orderId    = isset($result['id']) ? $result['id'] : 0;

            $db->query("
                INSERT INTO hb_config_upgrades (
                rel_type, account_id, order_id, config_cat, old_config_id, new_config_id,
                old_qty, new_qty, status
                ) VALUES (
                'Hosting', :account_id, :order_id, :config_cat, :old_config_id, :new_config_id,
                :old_qty, :new_qty, 'Upgraded'
                )
                ", array(
                    ':account_id'   => $accountId,
                    ':order_id'    => $orderId,
                    ':config_cat'   => $catId,
                    ':old_config_id'   => $configId,
                    ':new_config_id'   => $configId,
                    ':old_qty'   => $qty,
                    ':new_qty'   => $qty,
                ));

            $result     = $db->query("
                SELECT *
                FROM hb_config_upgrades
                WHERE account_id = '{$accountId}'
                    AND rel_type = 'Hosting'
                    AND order_id = '{$orderId}'
                    AND config_cat = '{$catId}'
                ")->fetch();

            $upgradeId  = isset($result['id']) ? $result['id'] : 0;

            $db->query("
                INSERT INTO hb_upgrades (
                rel_type, account_id, client_id, order_id, product_id, old_product_id, status, new_billing
                ) VALUES (
                'Hosting', :account_id, :client_id, :order_id, :product_id, :old_product_id, 'Upgraded', :new_billing
                )
                ", array(
                    ':account_id'       => $accountId,
                    ':client_id'        => $clientId,
                    ':order_id'         => $orderId,
                    ':product_id'       => $productId,
                    ':old_product_id'   => $productId,
                    ':new_billing'      => $billingcycle,
                ));

            $db->query("
                UPDATE hb_invoice_items
                SET `type` = 'FieldUpgrade',
                    item_id = '{$upgradeId}'
                WHERE id = '{$itemId}'
                ");

            $change = array(
                'serialized'    => '',
                'data'  => 'Manual create order upgrade #'. $orderId
            );
            $change = serialize($change);

            $db->query("
                INSERT INTO hb_account_logs (
                `date`, account_id, admin_login, module, manual, action, result, `change`
                ) VALUES (
                NOW(), :account_id, :admin_login, '-', 1, 'FieldUpgrade', 1, :change
                )
                ", array(
                    ':account_id'   => $accountId,
                    ':admin_login'  => $aAdmin['email'],
                    ':change'       => $change,
                ));

        }

        echo '<p align="center"><a href="?cmd=invoices&action=edit&id='. $invoiceId .'">กลับไปที่หน้า Invoice #'. $invoiceId .'</a><p>';
        exit;
    }

    public function getRelateAccount ($request)
    {
        $db         = hbm_db();

        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        $desc       = isset($request['desc']) ? $request['desc'] : '';
        $aAccount   = array();

        $result     = $db->query("
            SELECT a.*,
                p.name AS product
            FROM hb_accounts a,
                hb_products p
            WHERE a.client_id = '{$clientId}'
                AND a.status = 'Active'
                AND a.product_id = p.id
            ")->fetchAll();

        if (count($result)) {
            foreach ($result as $arr) {
                if ($arr['domain'] && strstr($desc, $arr['domain'])) {
                    $accountId  = $arr['id'];
                    $aAccount[$accountId]   = $arr;
                }
            }
        }

        return $aAccount;
    }

    public function is_connect_sale_invoice_dbc($request){

    	$db     = hbm_db();
    	$invoiceId  = isset($request['id']) ? $request['id'] : 0;

    	$result		=	$db->query("
	    							SELECT
	    								id , invoice_id , sale_invoice_no, is_connect, update_time
	    							FROM
	    								hb_invoice_import_dbc
	    							WHERE
	    								invoice_id = :invoice_id
	    						" , array(
    		    								':invoice_id'		=>	$invoiceId
    		    						))->fetchAll();
    	return $result[0];
    }

    public function connect_sale_invoice_dbc($request){

    	$db         	=	hbm_db();
    	$invoiceID		=	isset($request['invoiceId']) ? $request['invoiceId'] : 0;
    	$saleinvoiceID	=	isset($request['saleinvoiceid']) ? $request['saleinvoiceid'] : '0';
    	$connected		=	0;
    	$msg			=	'';

    	$result		=	$db->query("
    							SELECT
    								id , invoice_id
    							FROM
    								hb_invoice_import_dbc
    							WHERE
    								sale_invoice_no = :sale_invoice_no
    						" , array(
    	    								':sale_invoice_no'		=>	$saleinvoiceID
    	    						))->fetchAll();
    	if(count($result)){
    		$msg	=	'มีการผูก Sale Invoice หมายเลขนี้กับ Invoice: ' . $result[0]['invoice_id'].' ไปแล้ว';
    	}else{

	    	$response		=	$this->dbcconnect(
	    							array(
	    								'method'			=>	'GET',
	    								'service'			=>	'salesInvoices'
	    							)
	    						);
	    	$response		=	json_decode($response);
	    	$match			=	0;
	    	$aSaleinvoice	=	array();

	    	foreach($response->value as $saleinvoice){
	    		if($saleinvoice->number == $saleinvoiceID){
	    			$aSaleinvoice	=	$saleinvoice;
	    			$match			=	1;
	    			break;
	    		}
	    	}

	    	if($match){

	    		$result		=	$db->query("
	    							SELECT
	    								id , invoice_id
	    							FROM
	    								hb_invoice_import_dbc
	    							WHERE
	    								invoice_id = :invoice_id
	    						" , array(
	    								':invoice_id'		=>	$invoiceID
	    						))->fetchAll();
	    		if(count($result)){
	    			$db->query("
	    						UPDATE
	    							hb_invoice_import_dbc
	    						SET sale_invoice_no = :sale_invoice_no
	    							, sale_invoice_id = :sale_invoice_id
	    							, update_time = NOW()
	    							, is_connect = 1
	    						WHERE
	    					    	invoice_id = :invoice_id
	    					",array(
	    							':invoice_id'   		=> $invoiceID,
	    							':sale_invoice_no'  	=> $saleinvoiceID,
	    							':sale_invoice_id'      => $aSaleinvoice->id
	    					));
	    			$connected	=	1;
	    		}else{
	    			$db->query("
	                INSERT INTO hb_invoice_import_dbc (
	                id, invoice_id, sale_invoice_no, is_connect, sale_invoice_id, update_time
	                ) VALUES (
	                null , :invoice_id , :sale_invoice_no , 1 , :sale_invoice_id , NOW()
	                )
	                ", array(
	                    ':invoice_id'   		=> $invoiceID,
	                    ':sale_invoice_no'  	=> $saleinvoiceID,
	                    ':sale_invoice_id'      => $aSaleinvoice->id
	                ));
	    			$connected	=	1;
	    		}
	    		$msg	=	'Connect success.';
	    	}else{
	    		$msg	=	'ไม่มีหมายเลข Sale Invoice นี้ในระบบ';
	    	}
    	}

    	$this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', array('connected'	=>	$connected , 'msg'	=>	$msg));
        $this->json->show();

    }

    public function set_sale_invoice_items_dbc($request){

        $db             =   hbm_db();
        $invoiceID      =   isset($request['invoice_id']) ? $request['invoice_id'] : 0;
        $saleinvoiceID  =   isset($request['sale_invoice_no']) ? $request['sale_invoice_no'] : '0';
        $resultItem     =   array();

        $item    =   $db->query("
                      SELECT it.invoice_id,it.item_id,im.sale_invoice_no,dbcp.product_id,
                             dbcp.product_name,a.domain,dbcp.dbc_no,dbcp.dbc_item_id,dbcp.dbc_description,
                             it.unit_price,it.quantity,unit.code,it.discount_price,
                             a.date_created,a.next_due
                      FROM hb_invoice_items it
                      LEFT JOIN hb_invoice_import_dbc im
                          ON it.invoice_id = im.invoice_id ,
                                hb_accounts a,
                                hb_products p ,
                                dbc_product dbcp ,
                                dbc_product_unit unit
                      WHERE it.invoice_id = :invoice_id
                        AND it.item_id = a.id
                        AND p.id = a.product_id
                        AND dbcp.product_id = p.id
                        AND dbcp.dbc_item_id = unit.dbc_item_id
                    " , array(
                             ':invoice_id'       =>  $invoiceID

                      ))->fetchAll();

               $item[0]['date_created']=  date('d M Y',strtotime($item[0]['date_created']));
               $item[0]['next_due']    =  date('d M Y',strtotime($item[0]['next_due']));

        return $item;

    }

      public function get_sale_invoice_items_dbc($request){

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $request);
        $this->json->show();

    }


    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }

    public function afterCall ($request)
    {

    }

    public function dbcconnect($request){

    	require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');

    	$dbcconfig		=	$this->dbc_api_config();
    	$client 		=	new Client(array('base_uri' => $dbcconfig['url']));
    	$response 		=	$client->request(
    							$request['method'],
    							$request['service'],
    							array('auth' => $dbcconfig['auth'])
    						);
    	$body 			=	$response->getBody()->getContents();

    	return $body;

    }

    private function dbc_api_config(){

    	$username	=	'User1';
    	$password	=	'P@ssw0rd';
    	$companyId	=	'9b03d002-5096-4e6b-af11-f84d6c41e601'; //TEST

    	return array(
    				'url'				=>	'http://203.78.107.93:7048/NETWAYBC130/api/beta/companies('.$companyId.')/',
    				'auth'				=>  array($username, $password, 'ntlm')
    			);
    }

    public function importCsv ()
    {
        $db         = hbm_db();

        $aField     = array();
        $aDatas     = array();
        $i          = 0;
        if (($handle = fopen( __DIR__ ."/deals-open.csv", "r")) !== FALSE) {
            while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
                //echo '<pre>'. print_r($data, true) .'</pre>';
                $i++;
                foreach ($data as $index => $value) {
                    if (! isset($aField[$index])) {
                        if (preg_match('/\-\sID/i', $value)) {
                            $value  = 'dealId';
                        }
                        if (preg_match('/\-\sEmail/i', $value)) {
                            $value  = 'email';
                        }
                        if (preg_match('/\-\sT\sin\sTiming/i', $value)) {
                            $value  = 'T';
                        }
                        if (preg_match('/\-\sOrder\stype/i', $value)) {
                            $value  = 'orderType';
                        }
                        if (preg_match('/\-\sLost\sreason/i', $value)) {
                            $value  = 'lostReason';
                        }
                        if (preg_match('/\-\sINVOICE\sID/i', $value)) {
                            $value  = 'invoiceId';
                        }
                        if (preg_match('/\-\sA\sin\sAuthority/i', $value)) {
                            $value  = 'A';
                        }
                        if (preg_match('/\-\sB\sin\sBANT/i', $value)) {
                            $value  = 'B';
                        }
                        if (preg_match('/\-\sBU/i', $value)) {
                            $value  = 'BU';
                        }
                        if (preg_match('/\-\sContact\sperson/i', $value)) {
                            $value  = 'contactPerson';
                        }
                        if (preg_match('/\-\sMarketing\sChannel$/i', $value)) {
                            $value  = 'marketingChannel';
                        }
                        if (preg_match('/\-\sOwner/i', $value)) {
                            $value  = 'owner';
                        }
                        if (preg_match('/\-\sStatus/i', $value)) {
                            $value  = 'status';
                        }
                        if (preg_match('/\-\sDeal\screated/i', $value)) {
                            $value  = 'dealCreate';
                        }
                        if (preg_match('/\-\sStage/i', $value)) {
                            $value  = 'stage';
                        }
                        if (preg_match('/\-\sValue/i', $value)) {
                            $value  = 'value';
                        }
                        if (preg_match('/\-\sTitle/i', $value)) {
                            $value  = 'title';
                        }

                        $aField[$index] = $value;
                    }

                }

                if ($i > 1) {
                    $aData  = array();
                    foreach ($aField as $k => $v) {
                        if (isset($data[$k])) {
                            $aData[$v]  = $data[$k];
                        }
                    }
                    $aData['title'] = preg_replace('/\'/', ' ', $aData['title']);
                    $aDatas[]   = $aData;
                }
            }
            fclose($handle);
        }

        foreach ($aDatas as $arr) {
            $dealId = $arr['dealId'];
            $data   = serialize($arr);
            $sql    = "
                INSERT IGNORE INTO pipedrive_csv (
                    deal_id, data
                ) VALUES (
                    '{$dealId}', '{$data}'
                )
                ";
            echo '<pre>'. $sql .'</pre>';
            $db->query($sql);


            $result = $db->query("
                SELECT *
                FROM pipedrive_csv
                WHERE task_id = '-'
                    AND deal_id = '{$dealId}'
                ")->fetch();
            if (isset($result['deal_id'])) {
                echo '<pre>'. print_r($arr, true) .'</pre>';
            }

        }

        echo '<pre>'. print_r($aDatas, true) .'</pre>';
        exit;

    }

    public function createTask ()
    {
        $db         = hbm_db();
        $result     = $db->query("
            SELECT COUNT(*) AS total
            FROM pipedrive_csv
            WHERE task_id = ''
            ")->fetch();

        echo '<pre>'. print_r($result, true) .'</pre>';

        $result     = $db->query("
            SELECT *
            FROM pipedrive_csv
            WHERE task_id = ''
            ")->fetch();

        if (! isset($result['deal_id'])) {
            echo 'Done';
            exit;
        }

        $dealIdIndex    = $result['deal_id'];

    	require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');

        $aData      = unserialize($result['data']);

        $listId     = '18438618'; // new
        if ($aData['orderType'] == 'Renew') {
            $listId = '18438623'; // renew
        }

        $name       = $aData['title'];
        if (strlen($name) > 200) {
            $name   = substr($name, 0, 200);
        }
        $name   = explode("\n", $name);
        $name   = implode(" ", $name);
        $name   = nl2br($name);
        $aData['title']     = explode("\n", $aData['title']);
        $aData['title']     = implode(" ", $aData['title']);
        $aData['title']     = nl2br($aData['title']);

        $aUser  = array(
            'Jatturaput Nilumprachart'  => 615432,
            'Jiraphan Palachewa'  => 3757002,
            'Jutiphorn Damsong'  => 623068,
            'Passaraporn Ritthidech'  => 615435,
            'Patcharapan Puipocksin'  => 615493,
            'Petcharat@netway.co.th'  => 3841535,
            'Phanarat Khansanour'  => 3821601,
            'Prapatsorn Tamthura'  => 696587,
            'Thamonkan'  => 3841534,
            'Toungthong Phulek'  => 3784141,
            'Vanvipa Piriyothinkul'  => 3830567,
        );
        $assigneeId = isset($aUser[$aData['owner']]) ? $aUser[$aData['owner']] : 0;
        $dealId     = $aData['dealId'];
        $status     = 'Open';
        if ($aData['status'] == 'Won' || $aData['status'] == 'Lost') {
            $status = $aData['status'];
        }
        $createDate = strtotime($aData['dealCreate']) * 1000;
        $invoiceId  = $aData['invoiceId'];
        $value      = $aData['value'];
        $description    = '\n\n\n ============================== \n';
        foreach ($aData as $k => $v) {
            $description    .= ' '. $k .' = '. $v .' \n';
        }
        $jsonData   = '{
            "name" : "'. $name .'",
            "description" : "'. $description .'",
            "assignees": [ '. $assigneeId .' ],
            "tags": [ "pipedrive", "deal'. $dealId .'" ],
            "status": "'. $status .'",
            "start_date": "'. $createDate .'",
            "custom_fields": [
              {
                "id": "99acaec1-e64b-48f2-82a9-5f7599facbe6",
                "value": "https://netway.co.th/7944web/index.php?cmd=invoices&action=edit&id='. $invoiceId .'"
              },
              {
                "id": "6e56a315-5652-43d5-bb35-94336e2aef51",
                "value": "'. $invoiceId .'"
              },
              {
                "id": "4008f30c-30ad-49ba-8547-421dc2dceb24",
                "value": "'. $value .'"
              }
            ]
        }';


/*

{
  "name": "New Task Name",
  "description": "New Task Description",
  "assignees": [
    183
  ],
  "tags": [
    "tag name 1"
  ],
  "status": "Open",
  "priority": 3,
  "due_date": 1508369194377,
  "due_date_time": false,
  "time_estimate": 8640000,
  "start_date": 1567780450202,
  "start_date_time": false,
  "notify_all": true,
  "parent": null,
  "links_to": null,
  "check_required_custom_fields": true,
  "custom_fields": [
    {
      "id": "0a52c486-5f05-403b-b4fd-c512ff05131c",
      "value": 23
    },
    {
      "id": "03efda77-c7a0-42d3-8afd-fd546353c2f5",
      "value": "Text field input"
    }
  ]
}

*/

echo '<pre>'. print_r($result, true) .'</pre>';
echo '<pre>'. print_r($dealId, true) .'</pre>';
echo '<pre>'. print_r($jsonData, true) .'</pre>';

        $taskId     = '-';
        if ($dealId) {
            $client 		=	new Client(array('base_uri' => 'https://api.clickup.com/api/v2/list/'. $listId .'/task/',
                'headers'   => array(
                    'Content-Type'  => 'application/json',
                    'Authorization' => 'pk_615427_18AAW4MQGE5THMH9JR5RNQISQVZVNDXQ',
                )
            ));
            $response   = $client->request('POST', '', array('body' => $jsonData) );
            $result     = json_decode($response->getBody()->getContents(), true);


            if (isset($result['id']) && $result['id']) {
                $taskId = $result['id'];
            }

        }

        $db->query("
            UPDATE pipedrive_csv
            SET task_id = '{$taskId}'
            WHERE deal_id = '{$dealIdIndex}'
            ");

        echo '<pre>'. print_r($result, true) .'</pre>';
        echo '<script>setTimeout(function () { document.location="http://hostbill.netway.co.th/7944web/index.php?cmd=invoicehandle&action=createTask"; }, 1000);</script>';
        exit;
    }

    public function addTaskComment ($request)
    {
        $db         = hbm_db();

        $result     = $db->query("
            SELECT COUNT(*) AS total
            FROM pipedrive_csv
            WHERE is_add_comment = 0
                AND task_id != '-'
            ")->fetch();

        echo '<pre>'. print_r($result, true) .'</pre>';

        $result     = $db->query("
            SELECT *
            FROM pipedrive_csv
            WHERE is_add_comment = 0
                AND task_id != '-'
            ")->fetch();

        if (! isset($result['deal_id'])) {
            echo 'Done';
            exit;
        }

        echo '<pre>'. print_r($result, true) .'</pre>';

        $dealId     = $result['deal_id'];
        $taskId     = $result['task_id'];
        $index      = $result['deal_index2'];

    	require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');

        $comment    = '';

        $result     = $db->query("
            SELECT *
            FROM pipedrive_note
            WHERE deal_index = '{$titlemd5}'
            ")->fetchAll();

        foreach ($result as $arr) {
            echo '<pre>'. $arr['ID'] .'</pre>';
            $comment    .= "\n Note : \n" . $arr['Content'];
        }

        echo 'pipedrive_note <hr />';
        echo '<pre>'. count($result) .'</pre>';

        $result     = $db->query("
            SELECT *
            FROM pipedrive_activity
            WHERE deal_index2 = '{$index}'
            ")->fetchAll();

        echo 'pipedrive_activity <hr />';
        echo '<pre>'. count($result) .'</pre>';

        foreach ($result as $arr) {
            echo '<pre>'. $arr['ID'] .'</pre>';
            $comment    .=  "\n Activity : " . $arr['data'];
        }

        if ($comment) {

            $comment    = "\n เป็นข้อมูลที่ได้จากไฟล์ export จาก Pipedrive ซึ่งไม่มี Key เชื่อมไปยัง Deal ที่ถูกต้อง ใช้วิธีการค้นหา log ที่เกี่ยวข้องจากชื่อ Deal ข้อมูลอาจจะผิดพลาดได้ : \n" . $comment;

            $file   = fopen(__DIR__.'/pipedrive_note.txt', 'w');
            fwrite($file, $comment);
            fclose($file);

            $client 		=	new Client(array('base_uri' => 'https://api.clickup.com/api/v2/task/'. $taskId .'/attachment',
                'headers'   => array(
                    'Content-Type'  => 'multipart/form-data',
                    'Authorization' => 'pk_615427_18AAW4MQGE5THMH9JR5RNQISQVZVNDXQ',
                )
            ));
            $response   = $client->request('POST', '', array(
                'multipart' => array(
                    array(
                        'name'      => 'attachment',
                        'contents'  => fopen(__DIR__.'/pipedrive_note.txt', 'r'),
                        'filename'  => 'pipedrive_deal_'. $dealId .'_note.txt'
                    )
                )
            ) );
            $result     = json_decode($response->getBody()->getContents(), true);

            echo '<pre>'. print_r($result, true) .'</pre>';

        }

        $db->query("
            UPDATE pipedrive_csv
            SET is_add_comment = 1
            WHERE task_id = '{$taskId}'
            ");


        echo '<script>setTimeout(function () { document.location="http://hostbill.netway.co.th/7944web/index.php?cmd=invoicehandle&action=addTaskComment"; }, 5000);</script>';
        exit;
    }

    public function importActivity ($request)
    {
        $db         = hbm_db();

        $aDatas     = array();
        $index      = $request['index'] ? $request['index'] : 0;
        $limit      = 0;

        $file       = __DIR__ ."/activities-169712-439.csv";
        $data       = file($file);
        $aCsv       = array();
        $str        = '';
        foreach ($data as $v) {
            if (preg_match('/^\"/', $v)) {
                if ($str) {
                    $aCsv[] = $str;
                }
                $str    = $v;
            } else {
                $str    .= ' ' . $v;
            }
        }

        $csv    = array_map('str_getcsv', $aCsv);
        array_walk($csv, function(&$a) use ($csv) {
            $a = array_combine($csv[0], $a);
        });
        array_shift($csv); # remove column header
        echo '<pre> $total = '. count($csv) .'</pre>';

        for ($i = $index; $i < count($csv); $i++) {
            $data   = $csv[$i];

            $db->query("
            INSERT IGNORE INTO pipedrive_activity (
                ID, Deal, Content, deal_index
            ) VALUES (
                :ID, :Deal, :Content, :deal_index
            )
            ", array(
                ':ID' => $data['ID'],
                ':Deal' => $data['Deal'],
                ':Content' => print_r($data, true),
                ':deal_index' => md5($data['Deal']),
            ));

            $db->query("
                UPDATE pipedrive_activity
                SET data = :data
                WHERE ID = :ID
                ", array(
                    ':data' => implode(' , ', $data),
                    ':ID'   => $data['ID']
                ));

            array_push($aDatas, $data);

            $limit++;
            if ($limit > 500) {
                break;
            }

        }

        $index      = $i + 1;

        echo '<pre> $index = '. $index .'</pre>';
        echo '<pre style="padding:20px;">'. print_r($aDatas, true) .'</pre>';
        if (! $limit) {
            exit;
        }
        echo '<script>setTimeout(function () { document.location="index.php?cmd=invoicehandle&action=importActivity&index='. $index .'"; }, 1000);</script>';
        exit;

    }

    public function importNote ($request)
    {
        $db         = hbm_db();

        $aDatas     = array();
        $index      = $request['index'] ? $request['index'] : 0;
        $limit      = 0;

        $file       = __DIR__ ."/notes-169712-434.csv";
        $data       = file($file);
        $aCsv       = array();
        $str        = '';
        foreach ($data as $v) {
            if (preg_match('/^\"/', $v)) {
                if ($str) {
                    $aCsv[] = $str;
                }
                $str    = $v;
            } else {
                $str    .= ' ' . $v;
            }
        }

        $csv    = array_map('str_getcsv', $aCsv);
        array_walk($csv, function(&$a) use ($csv) {
            $a = array_combine($csv[0], $a);
        });
        array_shift($csv); # remove column header
        echo '<pre> $total = '. count($csv) .'</pre>';

        for ($i = $index; $i < count($csv); $i++) {
            $data   = $csv[$i];

            $db->query("
            INSERT IGNORE INTO pipedrive_note (
                ID, Deal, Content, deal_index
            ) VALUES (
                :ID, :Deal, :Content, :deal_index
            )
            ", array(
                ':ID' => $data['ID'],
                ':Deal' => $data['Deal title'],
                ':Content' => print_r($data, true),
                ':deal_index' => md5($data['Deal title']),
            ));

            array_push($aDatas, $data);

            $limit++;
            if ($limit > 500) {
                break;
            }

        }

        $index      = $i + 1;

        echo '<pre> $index = '. $index .'</pre>';
        echo '<pre style="padding:20px;">'. print_r($aDatas, true) .'</pre>';
        if (! $limit) {
            exit;
        }
        echo '<script>setTimeout(function () { document.location="index.php?cmd=invoicehandle&action=importNote&index='. $index .'"; }, 1000);</script>';
        exit;

    }

    public function importActivityUpdateDeal ($request)
    {
        $db         = hbm_db();

        $result     = $db->query("
            SELECT COUNT(*) AS total
            FROM pipedrive_activity
            WHERE deal_index2 = ''
            ")->fetch();

        echo '<pre>'. print_r($result, true) .'</pre>';

        $results     = $db->query("
            SELECT *
            FROM pipedrive_activity
            WHERE deal_index2 = ''
            LIMIT 100
            ")->fetchAll();
        if (! count($results)) {
            echo '<pre>DONE</pre>';
            exit;
        }

        foreach ($results as $result) {
            $id         = $result['ID'];
            $title      = preg_replace('/(\s+|\n+)/', '', $result['Deal']);
            $md5Title   = md5($title);

            $db->query("
                UPDATE pipedrive_activity
                SET deal_index2 = '{$md5Title}'
                WHERE ID = '{$id}'
                ");
        }

        echo '<script>setTimeout(function () { document.location="index.php?cmd=invoicehandle&action=importActivityUpdateDeal"; }, 500);</script>';
        exit;
    }

    public function importNoteUpdateDeal ($request)
    {
        $db         = hbm_db();

        $result     = $db->query("
            SELECT COUNT(*) AS total
            FROM pipedrive_note
            WHERE deal_index2 = ''
            ")->fetch();

        echo '<pre>'. print_r($result, true) .'</pre>';

        $results     = $db->query("
            SELECT *
            FROM pipedrive_note
            WHERE deal_index2 = ''
            LIMIT 100
            ")->fetchAll();
        if (! count($results)) {
            echo '<pre>DONE</pre>';
            exit;
        }

        foreach ($results as $result) {
            $id         = $result['ID'];
            $title      = preg_replace('/(\s+|\n+)/', '', $result['Deal']);
            $md5Title   = md5($title);

            $db->query("
                UPDATE pipedrive_note
                SET deal_index2 = '{$md5Title}'
                WHERE ID = '{$id}'
                ");
        }

        echo '<script>setTimeout(function () { document.location="index.php?cmd=invoicehandle&action=importNoteUpdateDeal"; }, 500);</script>';
        exit;
    }

    public function importCsvUpdateDeal ()
    {
        $db         = hbm_db();

        $result     = $db->query("
            SELECT COUNT(*) AS total
            FROM pipedrive_csv
            WHERE deal_index2 = ''
            ")->fetch();

        echo '<pre>'. print_r($result, true) .'</pre>';

        $results     = $db->query("
            SELECT *
            FROM pipedrive_csv
            WHERE deal_index2 = ''
            LIMIT 50
            ")->fetchAll();
        if (! count($results)) {
            echo '<pre>DONE</pre>';
            exit;
        }

        foreach ($results as $result) {
            $id         = $result['deal_id'];
            $aData      = unserialize($result['data']);
            $title      = isset($aData['title']) ? $aData['title'] : '';
            $title      = preg_replace('/(\s+|\n+)/', '', $title);
            $md5Title   = md5($title);

            $db->query("
                UPDATE pipedrive_csv
                SET deal_index2 = '{$md5Title}'
                WHERE deal_id = '{$id}'
                ");
        }

        echo '<script>setTimeout(function () { document.location="index.php?cmd=invoicehandle&action=importCsvUpdateDeal"; }, 500);</script>';
        exit;
    }

    public function hookAfterInvoiceCreate ($invoiceId)
    {
        $aInvoice   = invoicehandle_model::singleton()->getInvoiceById($invoiceId);
        $aItems     = invoicehandle_model::singleton()->listInvoiceItemByInvoiceId($invoiceId);
        $isInvoiceItem  = $this->_checkInvoiceItemTypeInvoice($aItems);

         //update invoice type renew skip create deal on clickup
        /*$isInvoiceRenew = $this->_checkInvoiceItemTypeRenew ($aItems);
        if($isInvoiceRenew == 1){
            invoicehandle_model::singleton()->updateInvoiceTypeRenew($invoiceId);
        }*/

        // แปลงระยะสัญญาเป็น (21 Jan 2021 - 20 Jan 2021)
        $this->_afterInvoiceCreate_changeTermFormat($aItems);

        $aItems     = invoicehandle_model::singleton()->listInvoiceItemByInvoiceId($invoiceId);

        // แสดง / ซ่อน ระยะสัญญา
        $this->_afterInvoiceCreate_hideTerm($aItems);


        /**
         * บันทึก promotion code ถ้ามีการใช้งาน
         * [FIXME] Invoice ที่ถูก create จะยังไม่ถูกเชื่อมกับ Order อย่า link hb_invoices กับ hb_orders
         * [XXX] ถ้ามีคนถามว่าทำไมไม่เอาราคา 1 ปี  - ราคา 3 ปี ถ้ายังมากกว่าราคาที่ขาย แสดงว่านั่นคือ promotion discount หรือ group discount
         *          ให้บอกว่าเพราะมี custom field ที่เราเข้าถึงราคาลำบาก
         * [TODO] ต้องแก้ไข
    */

        $this->updateInvoiceDetailByInvoiceId($invoiceId);

          //$this->updateInvoiceItemDiscount($invoiceId);

        /**
         * คำนวนหายอดหักภาษี ณ ที่จ่าย 3 เปอร์เซ็นต์ 1 เปอร์เซ็นต์
         * 2019-01-22 paid_id ไม่มีค่าทำให้ออก invoice แล้วชื่อไฟล์เพี้ยน
         */
        $this->_afterInvoiceCreate_updateWithHoldingTax($aInvoice);

        if ($isInvoiceItem) {
            invoicehandle_model::singleton()->setTaxProformaInvoiceItem($invoiceId);
            $aParam     = array(
                'invoiceId'     => $invoiceId,
                'isReturn'      => 1
            );
            $this->updateTaxWithholding($aParam);
        }

        /**
         * ตั้งค่า billing address + mailing address ให้ invoice เลยโดยดูจาก account + domain
         */
        $this->_updateInvoiceBillingAddress($aInvoice, $aItems);

        //เพิ่มfunction เเจ้งเตือน error เข้า log  กรณีผลลัพธ์ Line total  ไม่เท่ากับการคำนวณ  (initprice * quantity )-discount  --> main log file != level



    }
    public function hookAfterEstimateCreate ($estimateId)
    {
        $estimateId = isset($estimateId['id'])?$estimateId['id'] :0;

        $aEstimateItems = invoicehandle_model::singleton()->getEstimateItemyByEstimateId($estimateId);
        $aDraftItems = invoicehandle_model::singleton()->getOrderDraftItemByEstimateId($estimateId);
        $aAddonItems = invoicehandle_model::singleton()->getOrderDraftAddonItemByEstimateId($estimateId);
        // ซ่อน ระยะสัญญา
        $this->_afterEstimateCreate_hideTerm($aEstimateItems);

        if (count($aAddonItems)) {
            foreach ($aAddonItems as $arr) {
                array_push($aDraftItems, $arr);
            }
        }

        for($i= 0;$i < count($aEstimateItems); $i++){

            $aEstimateItem       = $aEstimateItems[$i];
            $aDraftItem  = $aDraftItems[$i];


            $aCustomData = invoicehandle_model::singleton()->getCustomData($aDraftItem);
            $aCustomData = (isset($aCustomData)) ? json_decode($aCustomData['settings'],true):array();
            $this->_updateEstimateItemDetail($aEstimateItem,$aDraftItem,$aCustomData);

        }
        $this->_updateEstimateDetail($estimateId);
    }

    private function _updateEstimateDetail ($estimateId)
    {
        invoicehandle_model::singleton()->updateEstimateBillingAddress($estimateId);
    }

    private function _updateEstimateItemDetail ($aEstimateItems,$aDraftItem,$aCustomData)
    {

        $type =  $aDraftItem['item_type'];
        $settingData        = json_decode($aDraftItem['settings'],true);
        $productId          = $settingData['product_id'];
        $estimateItemId     = $aEstimateItems['id'];
        $estimateId         = $aEstimateItems['estimate_id'];
        $quantityBillingCycle  = 1;

            if($type == 'domains'){
                $period     = $settingData['period'];
                $domainType = strtolower($settingData['action']);

                $value = $aParam         = array(
                    'productId'  => $productId,
                    'period'     => $period,
                    'domainType'     => $domainType
                );

                $isPrivateDomain = $this->_getIdProtectionDomain($aCustomData);

                $domainItemData = $this->calculateDomainItemData ($value,$isPrivateDomain);

                    $aParam         = array(
                        'amount'         => $domainItemData['amount'],
                        'unitPrice'      => $domainItemData['unitPrice'],
                        'quantity'       => $domainItemData['quantity'],
                        'quantityText'   => $domainItemData['quantityText'],
                        'discountPrice'  => $domainItemData['discountPrice'],
                        'itemId'         => $estimateItemId,
                        'estimateId'     => $estimateId

                    );

            }
            else if($type == 'services'){
                $amount        = $aEstimateItems['amount'];
                $productCycle  = $settingData['cycle'];

                $aProductPrice = invoicehandle_model::singleton()->getProductPriceByProductID($productId);

                $productData   = $this->productDiscountItem($aProductPrice);

                $bc             = $productCycle;
                $qt             = $bc .'Quantity';
                $qtext          = $bc .'QuantityText';
                $unitPrice      = isset($productData['unitPrice']) ? $productData['unitPrice'] : 0;
                $quantity       = isset($productData[$qt]) ? $productData[$qt] : 1;
                $quantityText   = isset($productData[$qtext]) ? $productData[$qtext] : 'Time';


                $aProductQuantity   = $this->_getProductDetail($aCustomData);

                
                if(isset($aProductQuantity['val']) && $aProductQuantity['val']){ // Quantity

                    $quantityBillingCycle  = $quantity ;
                    $quantity              = $aProductQuantity['val'];
                    $quantityText          = 'Seat(s)/ '.$productData[$qt].$quantityText;

                    if (isset($settingData['account_id']) && $settingData['account_id'] ) { //upgrade
                        $oldQtyUpgrade   = 0;
                        $newQtyUpgrade   = 0;
                        $aProductUpgrade = invoicehandle_model::singleton()->getProductUpgradeByAccountId($settingData['account_id']);

                        foreach($aProductUpgrade as $upgrade){
                            $oldQtyUpgrade = isset($upgrade['qty']) ? $upgrade['qty'] : 0;

                            $newQtyUpgrade  = $aProductQuantity['qty'] ;
                            $unitPrice      = $amount;
                            $quantity       = $newQtyUpgrade - $oldQtyUpgrade;
                            $quantityText   = 'Time';

                            if(isset($upgrade['variable']) && ($upgrade['variable'] =='quantity'|| preg_match("/quantity\-/", $upgrade['variable']))){
                                $unitPrice      = $amount/$quantity;
                                $unitPrice      = round($unitPrice, 2);
                                $quantityText   ='Seat(s)/ Time';
                                $checkAmount    = $unitPrice * $quantity ;
                                if($amount != $checkAmount ){
                                    $amount = $unitPrice * $quantity;
                                }
                            }
                        }
                    } else {

                    }

                }else {
                    if ( isset($settingData['account_id']) && $settingData['account_id'] ) { //upgrade !Quantity
                        $unitPrice      = $amount;
                        $quantityText   ='Time';

                    }else {//ProductComponent Not Quantity Form
                        
                        $aComponents    = $this->_getProductComponent($aCustomData);

                            foreach ($aComponents as $aComponent) {
                                foreach ($aComponent as $arr) {

                                    $aPrice     = $arr['aPrice'];
                                    $unitPriceComponent      = isset($aPrice['unitPrice']) ? $aPrice['unitPrice'] : 0;

                                    $quantityComponent       = (isset($arr['val']) && $arr['val']) ? $arr['val'] : $arr['qty'];

                                    if(isset($arr['aConfig']['initialval'])  && $arr['aConfig']['initialval']
                                        && (isset($arr['aConfig']['dontchargedefault'])  && $arr['aConfig']['dontchargedefault'] ) ) {
                                        $quantityComponent = $quantityComponent - $arr['aConfig']['initialval'];
                                    }
                       
                                    $unitPriceComponent     = $unitPriceComponent * $quantityComponent;

                                    $unitPrice      = $unitPrice + $unitPriceComponent;

                                }
                            }
                    }
                }
                

                $discountPrice =  ($unitPrice * $quantity * $quantityBillingCycle) - $amount;


                $aParam         = array(
                    'amount'         => $amount,
                    'unitPrice'      => $unitPrice,
                    'quantity'       => $quantity,
                    'quantityText'   => $quantityText,
                    'discountPrice'  => $discountPrice,
                    'itemId'         => $estimateItemId,
                    'estimateId'     => $estimateId

                );
                
            }
            else if($type == 'addons'){

                $baseAmount        = $aEstimateItems['amount']/ $aEstimateItems['qty'];

                $aParam         = array(
                    'amount'        => $baseAmount,
                    'qty'           => 1 ,
                    'itemId'        => $estimateItemId,
                    'estimateId'    => $estimateId
                );
                invoicehandle_model::singleton()->updateEstimateItemProductAddons($aParam);
                $this->recalculateEstimate($estimateId);

                $amount        = $aEstimateItems['amount'];
                $productCycle  = $settingData['cycle'];

                $aProductPrice = invoicehandle_model::singleton()->getProductPriceByProductID($productId);

                $productData   = $this->productDiscountItem($aProductPrice);

                $bc             = $productCycle;
                $qt             = $bc .'Quantity';
                $qtext          = $bc .'QuantityText';

                $unitPrice      = isset($productData['unitPrice']) ? $productData['unitPrice'] : 0;
                $quantity       = isset($productData[$qt]) ? $productData[$qt] : 1;
                $quantityText   = isset($productData[$qtext]) ? $productData[$qtext] : '';

                $discountPrice =  ($unitPrice * $quantity) - $amount;


                $aParam         = array(
                    'amount'         => $amount,
                    'unitPrice'      => $unitPrice,
                    'quantity'       => $quantity,
                    'quantityText'   => $quantityText,
                    'discountPrice'  => $discountPrice,
                    'itemId'         => $estimateItemId,
                    'estimateId'     => $estimateId

                );
            }

            invoicehandle_model::singleton()->updateEstimateItem($aParam);

    }

    public function calculateDomainItemData ($request,$isPrivateDomain)
    {

            $productId   = (isset($request['productId'])) ? $request['productId'] : 0;
            $period      = (isset($request['period']))    ? $request['period'] : 0;
            $domainType  = (isset($request['domainType'])) ? $request['domainType'] : 'register' ;

            $aDomainPrice = invoicehandle_model::singleton()->getDomainPriceByProductID($productId);

            $quantity      =  $period;
            $quantityText  =  'YEAR';
            $unitPrice     =  $aDomainPrice[1][$domainType];//register , transfer 1 = ราคาที่ 1 ปี

            $amount        =  $aDomainPrice[$quantity][$domainType];

            if($isPrivateDomain == 1){

                $unitPrice     = $unitPrice*2;
                $amount = $amount*2;
            }

            $discountPrice =  ($unitPrice * $quantity) - $amount;

            $result        = array(
                'amount'         => $amount,
                'unitPrice'      => $unitPrice,
                'quantity'       => $quantity,
                'quantityText'   => $quantityText,
                'discountPrice'  => $discountPrice,

            );

            return $result;
    }

    public function _getIdProtectionDomain ($customData)
    {
        foreach($customData as $item => $custom){
            foreach($custom as $arr){

               if($arr['variable'] == 'idprotection' && $arr['val'])  {
                   return $arr['val'];
               }

            }

        }
        return 0;

    }
    private function _getProductDetail ($customData)
    {
        foreach($customData as $item => $custom){
            foreach($custom as $arr){
                if(($arr['variable'] == 'quantity' || preg_match("/quantity\-/", $arr['variable'])) && $arr['val'] >=1 )  {
                    return $arr;
                }

            }
        }
        return array();
    }

    private function _getProductComponent ($aCustomData)
    {
        $aCustomDatas   = array();
        $aItem  = array();

        $aConfigCat = array();



        foreach($aCustomData as $groupId => $aCustom){
            foreach($aCustom as $itemId => $arr){
                array_push($aItem, $itemId);
            }
            array_push($aConfigCat, $groupId);
        }

        $aComponentPrice    = array();
        if (count($aItem)) {
            $aComponentPrice    = invoicehandle_model::singleton()->getComponentPriceByProductID($aItem);
        }

        //echo '<pre> $aComponentPrice $aComponentPrice '. print_r($aCustomData, true) .'</pre>';
        if (count($aConfigCat)) {
            $aConfigCats        = invoicehandle_model::singleton()->getConfigCat($aConfigCat);
        }
        foreach($aCustomData as $groupId => $aCustom){
            foreach($aCustom as $itemId => $arr){


                if(! isset($arr['qty']) || ! $arr['qty'] ) { //ใช้ได้แค่ qty
                    continue;
                }

                if (! isset($aComponentPrice[$itemId])) {
                    continue;
                }

               $aPrice     = $this->productDiscountItem($aComponentPrice[$itemId]);
                
                $arr['aPrice']   = $aPrice;

                $aConfig    = isset($aConfigCats[$groupId]) ? $aConfigCats[$groupId]['aConfig'] : array();
                $arr['aConfig']   = $aConfig;


                $aCustomDatas[$groupId][$itemId]    = $arr;

            }
        }

        return $aCustomDatas;
    }

    public function productDiscountItem ($request){

        $unitPrice   = 0;
        $aPrice  = array();
        if ( isset($request['m']) && $request['m'] > 0) {
            $unitPrice      = $request['m'];
            $aPrice['mQuantity']        = 1;
            $aPrice['mQuantityText']    = 'MONTH';
            if ( isset($request['q']) && $request['q'] > 0) {
                $aPrice['qQuantity']    = 3;
                $aPrice['qQuantityText']= 'MONTH';
                $aPrice['qDiscount']    = ($unitPrice * 3) - $request['q'];
            }
            if ( isset($request['s']) && $request['s'] > 0) {
                $aPrice['sQuantity']    = 6;
                $aPrice['sQuantityText']= 'MONTH';
                $aPrice['sDiscount']    = ($unitPrice * 6) - $request['s'];
            }
            if ( isset($request['a']) && $request['a'] > 0) {
                $aPrice['aQuantity']    = 12;
                $aPrice['aQuantityText']= 'MONTH';
                $aPrice['aDiscount']    = ($unitPrice * 12) - $request['a'];
            }
            if ( isset($request['b']) && $request['b'] > 0) {
                $aPrice['bQuantity']    = 24;
                $aPrice['bQuantityText']= 'MONTH';
                $aPrice['bDiscount']    = ($unitPrice * 24) - $request['b'];
            }
            if ( isset($request['t']) && $request['t'] > 0) {
                $aPrice['tQuantity']    = 36;
                $aPrice['tQuantityText']= 'MONTH';
                $aPrice['tDiscount']    = ($unitPrice * 36) - $request['t'];
            }

        } elseif ( isset($request['a']) && $request['a'] > 0) {
            $unitPrice      = $request['a'];
            $aPrice['aQuantity']        = 1;
            $aPrice['aQuantityText']    = 'YEAR';

            if ( isset($request['b']) && $request['b'] > 0) {
                $aPrice['bQuantity']    = 2;
                $aPrice['bQuantityText']= 'YEAR';
                $aPrice['bDiscount']    = ($unitPrice * 2) - $request['b'];
            }
            if ( isset($request['t']) && $request['t'] > 0) {
                $aPrice['tQuantity']    = 3;
                $aPrice['tQuantityText']= 'YEAR';
                $aPrice['tDiscount']    = ($unitPrice * 3) - $request['t'];
            }
            if ( isset($request['p4']) && $request['p4'] > 0) {
                $aPrice['p4Quantity']    = 4;
                $aPrice['p4QuantityText']= 'YEAR';
                $aPrice['p4Discount']    = ($unitPrice * 4) - $request['p4'];
            }
            if ( isset($request['p5']) && $request['p5'] > 0) {
                $aPrice['p5Quantity']    = 5;
                $aPrice['p5QuantityText']= 'YEAR';
                $aPrice['p5Discount']    = ($unitPrice * 5) - $request['p5'];
            }

        }

        $aPrice['unitPrice']        = $unitPrice;

        return $aPrice;
    }

    //  เปลี่ยน format ให้ตรงกับ DBC
    private function _afterInvoiceCreate_changeTermFormat ($aItems)
    {
        if (! count($aItems)) {
            return true;
        }

        foreach ($aItems as $aItem) {
            $itemId = $aItem['id'];
            $desc   = $aItem['description'];



            // ลบเวลาออกจาก invoice description  23:59:59
            $desc   = preg_replace('/\s\d{2}\:\d{2}\:\d{2}/', '', $desc);

            if (! $this->_afterInvoiceCreate_isTermPresent($desc)) {
                continue;
            }

            preg_match_all('/\d{2}\/\d{2}\/\d{4}/', $desc, $matches);

            for ($i = 0; $i <= 1; $i++) {
                if (isset($matches[0][$i])) {
                    $date   = $matches[0][$i];
                    $date   = explode('/', $date);
                    $date   = $date[2] .'-'. $date[1] .'-'. $date[0];
                    $date   = strtotime($date);
                    $date   = date('d M Y', $date);
                    $desc   = str_replace($matches[0][$i], $date, $desc);
                }
            }

            invoicehandle_model::singleton()->updateInvoiceItemDescription($itemId, $desc);
        }
    }

    // ซ่อนเวลาเออกจาก description
    private function _afterInvoiceCreate_hideTerm ($aItems)
    {
        if (! count($aItems)) {
            return true;
        }

        // DD/MM/YYYY (22/01/2021)
        // Domain Registration: test-new-hostbill-01.com Period: 1 Year/s <!--(21/01/2021 - 21/01/2022)-->
        // Linux Hosting - Economy plan test-new-hostbill-01.com (21/01/2021 - 20/07/2021)

        foreach ($aItems as $aItem) {
            $itemId = $aItem['id'];
            $type   = $aItem['type'];
            $desc   = $aItem['description'];
            $isActive       = $aItem['isActive'];

            $hideTerm   = 0;
            if ($type == 'Domain Register') {
                $hideTerm = 1;
            }
            if ($type == 'Domain Transfer') {
                $hideTerm = 1;
            }
            if ($type == 'Hosting' &&  ! $isActive) {
                $hideTerm = 1;
            }
            if ($type == 'Addon' &&  ! $isActive) {
                $hideTerm = 1;
            }

            if (! $hideTerm) {
                continue;
            }

            if ($this->_afterInvoiceCreate_isShowTerm($desc)) {
                $desc   = $this->_afterInvoiceCreate_hideTermDesc($desc);
                invoicehandle_model::singleton()->updateInvoiceItemDescription($itemId, $desc);
            }
        }

    }
    private function _afterEstimateCreate_hideTerm ($aItems)
    {
        if (! count($aItems)) {
            return true;
        }

        // DD/MM/YYYY (22/01/2021)
        // Domain Registration: test-new-hostbill-01.com Period: 1 Year/s <!--(21/01/2021 - 21/01/2022)-->
        // Linux Hosting - Economy plan test-new-hostbill-01.com (21/01/2021 - 20/07/2021)

        foreach ($aItems as $aItem) {
            $itemId = $aItem['id'];
            $type   = $aItem['type'];
            $desc   = $aItem['description'];

            if ($type == '' || $type == 'Other') {
                $desc   = $this->_afterEstimateCreate_hideTermDesc($desc);
                invoicehandle_model::singleton()->updateEstimateItemDescription($itemId, $desc);
            }
            else{
                continue;
            }

        }

    }
    private function _afterEstimateCreate_hideTermDesc ($desc)
    {
        if( preg_match("/\([0-9].*?\)/", $desc,$match)){
            $hiddenDate = '<!--'.$match[0].'-->';
            $desc   = preg_replace('/\([0-9].*?\)/', $hiddenDate, $desc);
        }
        return $desc;
    }

    private function _afterInvoiceCreate_hideTermDesc ($desc)
    {
        $desc   = preg_replace('/\s(\(\d{2}\s[a-zA-Z]{3}\s\d{4}\s\-\s\d{2}\s[a-zA-Z]{3}\s\d{4}\))/', ' <!--$1-->', $desc);
        return $desc;
    }

    private function _afterInvoiceCreate_isTermPresent ($desc)
    {
        return preg_match('/\(\d{2}\/\d{2}\/\d{4}\s\-\s\d{2}\/\d{2}\/\d{4}\)/', $desc);
    }

    private function _afterInvoiceCreate_isShowTerm ($desc)
    {
        return preg_match('/\s\(\d{2}\s[a-zA-Z]{3}\s\d{4}\s\-\s\d{2}\s[a-zA-Z]{3}\s\d{4}\)/', $desc);
    }

    private function _afterInvoiceCreate_updateWithHoldingTax ($aInvoice)
    {
        if (! isset($aInvoice['id'])) {
            return true;
        }

        $result         = $aInvoice;
        $invoiceId      = $result['id'];

        $tax            = ($result['subtotal'] * $result['taxrate']) / 100;
        $tax            = round($tax, 2);
        $total          = $result['subtotal'] + $tax;
        $duedate        = $result['duedate'];

        $tax_wh_3       = ($result['subtotal'] * 3) / 100;
        $tax_wh_3       = round($tax_wh_3, 2);
        $total_wh_3     = $total - $tax_wh_3;
        $total_wh_3     = round($total_wh_3, 2);
        $tax_wh_1       = ($result['subtotal'] * 1) / 100;
        $tax_wh_1       = round($tax_wh_1, 2);
        $total_wh_1     = $total - $tax_wh_1;
        $total_wh_1     = round($total_wh_1, 2);
        $tax_wh_15      = ($result['subtotal'] * 1.5) / 100;
        $tax_wh_15      = round($tax_wh_15, 2);
        $total_wh_15    = $total - $tax_wh_15;
        $total_wh_15    = round($total_wh_15, 2);

        $paidId         = $result['paid_id'] ? $result['paid_id'] : $invoiceId;

        $isTax15        = 1;
        if (strtotime($duedate) >= strtotime('2020-10-01')) {
            $isTax15    = 0;
        }

        $aData      = array(
            'tax_wh_3'         => $tax_wh_3,
            'total_wh_3'       => $total_wh_3,
            'tax_wh_1'         => $tax_wh_1,
            'total_wh_1'       => $total_wh_1,
            'tax_wh_15'        => $tax_wh_15,
            'total_wh_15'      => $total_wh_15,
            'is_tax_wh_15'     => $isTax15,
            'paidId'           => $paidId,
            'invoiceId'        => $invoiceId,
            'tax'              => $tax,
            'total'            => $total
        );
        invoicehandle_model::singleton()->updateInvoiceWithHoldingTax($invoiceId, $aData);



    }

    private function _checkInvoiceItemTypeInvoice ($aItems)
    {
        $isInvoice      = 0;
        if (! count($aItems)) {
            return $isInvoice;
        }
        foreach ($aItems as $arr) {
            if ($arr['type'] == 'Invoice') {
                $isInvoice      = 1;
                return $isInvoice;
            }
        }

        return $isInvoice;
    }

    private function _checkInvoiceItemTypeRenew ($aItems)
    {
        $isRenew = 0;
        if (! count($aItems)) {
        return $isRenew;
        }
        require_once(APPDIR . 'class.config.custom.php');
        $productSkip   = ConfigCustom::singleton()->getValue('nwSkipRenewDealFromCategory');
        $productSkip   = explode(',', $productSkip);

        foreach ($aItems as $arr) {

            $catId = invoicehandle_model::singleton()->getProductCategoryIdByitemId($arr['item_id']);
            //product domain
            if ($arr['type'] == 'Domain Renew') {
                $isRenew = 1;
            }
             //product Hosting
            else if($arr['type'] != 'Domain Renew'){
               $renewHosting  = invoicehandle_model::singleton()->getInvoiceHostingRenew($arr['invoice_id'],$arr['item_id']);

               if ( in_array($catId['category_id'],$productSkip) && !isset($renewHosting['id']) ) {
                    $isRenew = 1;
                }
                else {
                    $isRenew = 0;
                }
            }
        }

        return $isRenew;
    }

    private function _updateInvoiceBillingAddress ($aInvoice, $aItems)
    {
        if (! isset($aInvoice['id'])) {
            return true;
        }

        $invoiceId      = $aInvoice['id'];

        $result     = invoicehandle_model::singleton()->getInvoiceById($invoiceId);
        $aMetadata  = isset($result['metadata']) ? unserialize($result['metadata']) : array();

        $isModuleBCSActive  = invoicehandle_model::singleton()->isModuleActive('billing_contact_select');

        $contactId      = ($isModuleBCSActive && isset($aInvoice['contact_id']) && $aInvoice['contact_id']) ? $aInvoice['contact_id'] : 0;
        $aContact       = addresshandle_controller::singleton()->getContactAddressFronContactId($contactId);
        $billingContactId   = isset($aContact['billingContactId']) ? $aContact['billingContactId'] : 0;
        $mailingContactId   = isset($aContact['mailingContactId']) ? $aContact['mailingContactId'] : 0;

        // ถ้าไม่มี contact_id ไปหาจาก service
        if ($contactId == 0) {
            $result         = invoicehandle_model::singleton()->getEstimateByInvoiceId($invoiceId);
            $contactId      = (isset($result['billing_contact_id']) && $result['billing_contact_id']) ? $result['billing_contact_id'] : 0;
            $result         = $this->getAddress($invoiceId);
            $contactId      = isset($result['contactId']) ? $result['contactId'] : 0;
            if ($contactId) {
                $aContact   =   addresshandle_controller::singleton()->getContactAddressFronContactId($contactId);
                $billingContactId   = isset($aContact['billingContactId']) ? $aContact['billingContactId'] : 0;
                $mailingContactId   = isset($aContact['mailingContactId']) ? $aContact['mailingContactId'] : 0;
            } else {
                $billingContactId   = isset($result['billingContactId']) ? $result['billingContactId'] : 0;
                $mailingContactId   = isset($result['mailingContactId']) ? $result['mailingContactId'] : 0;
            }
        }

        // ถ้าไม่มี contact_id ไปหาจาก invoice item
        if ( $contactId == 0 && $billingContactId == 0 ){
            foreach($aItems as $arr) {
                $result     = $this->getAddress($arr['invoice_id']);
                $contactId      = isset($result['contactId']) ? $result['contactId'] : 0;
                if ($contactId) {
                    $aContact   =   addresshandle_controller::singleton()->getContactAddressFronContactId($contactId);
                    $billingContactId   = isset($aContact['billingContactId']) ? $aContact['billingContactId'] : 0;
                    $mailingContactId   = isset($aContact['mailingContactId']) ? $aContact['mailingContactId'] : 0;
                } else {
                    $billingContactId   = isset($result['billingContactId']) ? $result['billingContactId'] : 0;
                    $mailingContactId   = isset($result['mailingContactId']) ? $result['mailingContactId'] : 0;
                }

                if ($billingContactId) {
                    break;
                }
            }
        }

        if (! $billingContactId) {
            return true;
        }

        $billingAddress     = isset($aContact['billingAddress']) ? $aContact['billingAddress'] : '';

        if (! $billingAddress) {
            $aContact   =   addresshandle_controller::singleton()->getContactAddressFronContactId($billingContactId);
        }

        $billingAddress     = isset($aContact['billingAddress']) ? $aContact['billingAddress'] : '';
        $billingTaxId       = isset($aContact['billingTaxId']) ? $aContact['billingTaxId'] : '';
        $isReceiveTaxInvoice    = isset($aContact['isReceiveTaxInvoice']) ? $aContact['isReceiveTaxInvoice'] : '';
        $companyName        = isset($aContact['companyName']) ? $aContact['companyName'] : '';

        if (! $mailingContactId) {
            $mailingContactId   = $billingContactId;
        }

        if ($mailingContactId != $billingContactId) {
            $aContact   =   addresshandle_controller::singleton()->getContactAddressFronContactId($mailingContactId);
        }

        $mailingAddress     = isset($aContact['mailingAddress']) ? $aContact['mailingAddress'] : '';
        $mailtoPerson       = isset($aContact['mailtoPerson']) ? $aContact['mailtoPerson'] : '';
        $mailingAddress     = ($mailtoPerson ? $mailtoPerson ."\n" : '') . $mailingAddress;

        // รอดูก่อนว่าต้องเอาออกใหม
        /*
        if (! $isReceiveTaxInvoice) {
            $billingAddress = '';
            $mailingAddress = '';
        }
        */

        $aData      = array(
            'billingContactId'     => $billingContactId,
            'billingAddress'       => $billingAddress,
            'billingTaxId'         => $billingTaxId,
            'mailingContactId'     => $mailingContactId,
            'mailingAddress'       => $mailingAddress,
            'invoiceId'            => $invoiceId
        );
        invoicehandle_model::singleton()->updateInvoiceBillingAddress($invoiceId, $aData);

    }

    public function hookAfterInvoiceFullpaid ($invoiceId)
    {
        $aInvoice   = invoicehandle_model::singleton()->getInvoiceById($invoiceId);
        $aItems     = invoicehandle_model::singleton()->listInvoiceItemByInvoiceId($invoiceId);

        /**
         * ออกหมายเลขใบกำกับภาษีให้ invoice นั้นทันทีเมื่อ invoice paid
         */
        $this->_afterInvoiceFullpaid_setTaxNumber($invoiceId, $aInvoice, $aItems);

    }

    private function _afterInvoiceFullpaid_setTaxNumber ($invoiceId, $aInvoice, $aItems)
    {
        require_once(APPDIR . 'class.config.custom.php');
        $nwTaxNumber    = ConfigCustom::singleton()->getValue('nwTaxNumber');

        /* --- 2013-11-28 ถ้าเป็น Pro Forma invoice ไม่ต้องออกใบกำกับภาษีให้ Invoice ลูก --- */

        $isProformaPaid = invoicehandle_model::singleton()->isProformaPaid($invoiceId);
        /* --- 2014-03-31 proforma ไมีมึ vat ต้องให้ออกใบกำกับภาษีได้ --- */
        $isProformaChildVat = invoicehandle_model::singleton()->isProformaChildVat($invoiceId);

        if ((floatval($aInvoice['tax']) > 0 || $isProformaChildVat) && $aInvoice['invoice_number'] == '' && ! $isProformaPaid) {

            $invoiceNumber  = invoicehandle_controller::buildTaxNumberFormat();

            invoicehandle_model::singleton()->updateInvoiceNumber($invoiceId, $invoiceNumber);
        }

        /* --- pro forma invoice เมื่อเป็น paid แล้วต้องการให้ปลี่ยนจาก Q เป็น I ด้วย --- */
        if ($aInvoice['status'] == 'Paid' && $aInvoice['paid_id'] == '') {
            $InvoiceNumerationPaid      = ConfigCustom::singleton()->getValue('InvoiceNumerationPaid');
            $InvoiceNumerationFormat    = ConfigCustom::singleton()->getValue('InvoiceNumerationFormat');

            $y      = date('Y');
            $m      = date('m');
            $number = $InvoiceNumerationPaid;
            eval('$paidId   = "'. $InvoiceNumerationFormat .'";');
            invoicehandle_model::singleton()->updateInvoicePaidId($invoiceId, $paidId);

            ConfigCustom::singleton()->setValue('InvoiceNumerationPaid', ($InvoiceNumerationPaid+1));
        }

    }

    public function hookAfterInvoiceUpdateTotal ($invoiceId)
    {
        $aInvoice   = invoicehandle_model::singleton()->getInvoiceById($invoiceId);
        $aItems     = invoicehandle_model::singleton()->listInvoiceItemByInvoiceId($invoiceId);
        $aParam = array(
            'invoiceId'     => $aInvoice['id'],
        );
        $this->updateTaxWithholding($aParam);

        $this->_afterInvoiceUpdateTotal_generatePromptpayQr($invoiceId, $aInvoice, $aItems);

    }

    private function _afterInvoiceUpdateTotal_generatePromptpayQr ($invoiceId, $aInvoice, $aItems)
    {
        require APPDIR_LIBS . 'php-promptpay-qr-master/vendor/autoload.php';
        require_once APPDIR_LIBS . 'php-promptpay-qr-master/src/PromptPay.php';

        $PromptPay = new KS\PromptPay();

        $savePath = MAINDIR . '/promptpayQr/' . 'iv_' . $invoiceId . '.png';
        $target = '0135539003143';
        $amount = $aInvoice['total'];
        $PromptPay->generateQrCode($savePath, $target, $amount);
    }


    public function changeInvoiceItemDiscount ($request)
    {
        $invoiceId         = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $invoiceItemId      = isset($request['invoiceItemId']) ? $request['invoiceItemId'] : 0;
        $discountPrice      = isset($request['discountPrice']) ? $request['discountPrice'] : 0;
        $isEstimate         = isset($request['isEstimate']) ? $request['isEstimate'] : 0;

        $aData      = array(
            'discountPrice'     => $discountPrice
        );

        if ($isEstimate == 1) {
            $result = invoicehandle_model::singleton()->getEstimateByEstimateId($invoiceId);
           if(isset($result['status']) && $result['status']=='Draft'){
                invoicehandle_model::singleton()->updateEstimateItemDiscount($invoiceItemId, $aData);
            }
            else{
                //$this->addInfo('Cannot update completed Estimate.');
            }
            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data',2);
            $this->json->show();
        }

        if ($this->isCompleteInvoice($invoiceId)) {
            $result     = array(
                'error' => 'Cannot update completed invoice.'
            );
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }

        invoicehandle_model::singleton()->updateInvoiceItemDiscount($invoiceId, $invoiceItemId, $aData);

        $result     = array();
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data',1);
        $this->json->show();
    }

    public function changeInvoiceItemUnitPrice ($request)
    {
        $invoiceId         = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $invoiceItemId      = isset($request['invoiceItemId']) ? $request['invoiceItemId'] : 0;
        $unitPrice          = isset($request['unitPrice']) ? $request['unitPrice'] : 0;
        $isEstimate         = isset($request['isEstimate']) ? $request['isEstimate'] : 0;

        if ($isEstimate) {
            invoicehandle_model::singleton()->updateEstimateItemUnitPrice($invoiceItemId, $unitPrice);

            $result     = array();
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', 1);
            $this->json->show();
        }

        if ($this->isCompleteInvoice($invoiceId)) {
            $result     = array(
                'info'  => 'Cannot update completed invoice.'
            );
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', $result);
            $this->json->show();
        }

        $aData      = array(
            'unitPrice'     => $unitPrice,
        );
        invoicehandle_model::singleton()->updateInvoiceItemUnitPrice($invoiceItemId, $aData);

        $result     = array();
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', 2);
        $this->json->show();
    }

    public function isCompleteInvoice ($invoiceId)
    {
        $aInvoice   = invoicehandle_model::singleton()->getInvoiceById($invoiceId);
        if (isset($aInvoice['status']) && $aInvoice['status'] == 'Unpaid') {
            return false;
        }

        return true;
    }

    public function createDealManualAfterInvoiceCreate ($request)
    {
        $url        = 'https://prod-15.southeastasia.logic.azure.com:443/workflows/66fa6a66f8ac4fbfb426358af741bbac/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=A9-xIu-sARfZHhJO9JNgiDR-SOdyyOuQ2mGp7G1aQ1o';
        $client = new Client(array(
            'base_uri'  => $url,
            'headers'   => array(
                'accept'    => 'application/json',
            ),
        ));

        $result     = array();
        try {

            if ($request['method'] == 'POST') {
                $response   = $client->request('POST','', array('json' => $request['invoiceId']) );
            }
            $code       = $response->getStatusCode();
            if ($code == 200) {
                $result     = json_decode($response->getBody(), true);
            }

        } catch (RequestException $e) {
            $e->getRequest();
            if ($e->hasResponse()) {
                $response   = $e->getResponse();
                $result     = json_decode($response->getBody(), true);
            }
        }

        return $result;
    }
    public function createDealManualAfterEstimateCreate ($request)
    {
        $url        = 'https://prod-04.southeastasia.logic.azure.com:443/workflows/f6e0c16150494aef8969783a81fc4b6b/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=SO8nKl98fm7inPoQTyfM98NZuH7vagEqllNh_0h4adM';
        $client = new Client(array(
            'base_uri'  => $url,
            'headers'   => array(
                'accept'    => 'application/json',
            ),
        ));

        $result     = array();
        try {

            if ($request['method'] == 'POST') {
                $response   = $client->request('POST','', array('json' => $request['estimateId']) );
            }
            $code       = $response->getStatusCode();
            if ($code == 200) {
                $result     = json_decode($response->getBody(), true);
            }

        } catch (RequestException $e) {
            $e->getRequest();
            if ($e->hasResponse()) {
                $response   = $e->getResponse();
                $result     = json_decode($response->getBody(), true);
            }
        }

        return $result;
    }

    public function addsiminvoice ($request)
    {
        $invoiceId  = isset($request['id']) ? $request['id'] : 0;

        invoicehandle_model::singleton()->addSimNumber($invoiceId);

        $result     = array(
            'info'  => 'เพิ่ม SIM number เข้า invoice แล้ว'
        );
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
        exit;
    }

    public function updatesiminvoice ($request)
    {
        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $simNumber      = isset($request['simNumber']) ? $request['simNumber'] : '';

        invoicehandle_model::singleton()->updateSimNumber($invoiceId, $simNumber);

        $result     = array(
            'info'  => 'แก้ไข SIM number ของ invoice แล้ว'
        );
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
        exit;
    }

    public function updateBillingCheque ($request)
    {
        $api        = new ApiWrapper();

        $invoiceId      = isset($request['invoiceId']) ? $request['invoiceId'] : 0;
        $aBillingCheque = array();
        if (isset($request['data'])) {
            parse_str($request['data'], $aData);
            $aBillingCheque     = isset($aData['billigCheque']) ? $aData['billigCheque'] : array();
        }

        $params     = array(
           'id' => $invoiceId
        );
        $result     = $api->getInvoiceDetails($params);
        $aInvoice   = isset($result['invoice']) ? $result['invoice'] : array();
        $aMeta      = isset($aInvoice['metadata']) ? $aInvoice['metadata'] : array();
        $aMeta['billingCheque'] = $aBillingCheque;

        //invoicehandle_model::singleton()->updateMetadata($invoiceId, $aMeta);

        $result     = array(
            'info'  => 'แก้ไขข้อมูลวางบิลรับเช็คแล้ว'
        );
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('data', $result);
        $this->json->show();
        exit;
    }

}