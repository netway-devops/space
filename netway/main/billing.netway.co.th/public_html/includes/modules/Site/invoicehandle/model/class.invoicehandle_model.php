<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class invoicehandle_model {

    private static  $instance;
    private $db;

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }

    private function __construct ()
    {
        $this->db       = hbm_db();

    }

    public function changeStaffOwner ($data)
    {
        $this->db->query("
            UPDATE hb_invoices
            SET staff_owner_id = :staff_owner_id
            WHERE id = :id
            ", array(
                ':staff_owner_id'   => $data['staff_owner_id'],
                ':id'       => $data['id'],
            ));

    }

    public function listInvoiceItemOnlyByInvoiceId ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT
                ii.id, ii.invoice_id, ii.type, ii.item_id, ii.description
            FROM
                hb_invoice_items ii
            WHERE
                ii.invoice_id = :invoice_id
            ", array(
                ':invoice_id'  => $invoiceId
            ))->fetchAll();

        return $result;
    }

    public function listInvoiceItemByInvoiceId ($invoiceId)
    {
        $result     = $this->db->query("
            SELECT
                ii.id, ii.invoice_id, ii.type, ii.item_id, ii.description
            FROM
                hb_invoice_items ii
            WHERE
                ii.invoice_id = :invoice_id
            ", array(
                ':invoice_id'  => $invoiceId
            ))->fetchAll();

        $aItems     = array();
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $id         = $arr['id'];
                $itemId     = $arr['item_id'];
                $type       = $arr['type'];
                $isActive   = 0;

                if ($type == 'Hosting') {
                    $result     = $this->db->query("
                        SELECT
                            a.id, a.status
                        FROM
                            hb_accounts a
                        WHERE
                            a.id = :id
                            AND a.status != 'Pending'
                        ", array(
                            ':id'   => $itemId
                        ))->fetch();
                    if (isset($result['id']) && $result['id']) {
                        $isActive   = 1;
                    }
                }

                if ($type == 'Addon') {
                    $result     = $this->db->query("
                        SELECT
                            aa.id, aa.status
                        FROM
                            hb_accounts_addons aa
                        WHERE
                            aa.id = :id
                            AND aa.status != 'Pending'
                        ", array(
                            ':id'   => $itemId
                        ))->fetch();
                    if (isset($result['id']) && $result['id']) {
                        $isActive   = 1;
                    }
                }

                $arr['isActive']    = $isActive;
                $aItems[$id]        = $arr;
            }
        }

        return $aItems;
    }

    public function updateInvoiceItemDescription ($itemId, $desc)
    {
        $this->db->query("
            UPDATE hb_invoice_items
            SET description = :description
            WHERE id = :id
            ", array(
                ':description'  => $desc,
                ':id'           => $itemId
            ));

    }
    public function updateEstimateItemDescription ($itemId, $desc)
    {
        $this->db->query("
            UPDATE hb_estimate_items
            SET description = :description
            WHERE id = :id
            ", array(
                ':description'  => $desc,
                ':id'           => $itemId
            ));

    }

    public function getInvoiceById ($invoiceId)
    {
        $result         = $this->db->query("
            SELECT
                i.*
            FROM
                hb_invoices i
            WHERE
                i.id = :id
            ", array(
                ':id'        => $invoiceId
            ))->fetch();

        $result     = count($result) ? $result : array();


        return $result;
    }
    public function getInvoiceItemsStatusNotPaidByInvoiceId ($invoiceId)
    {
        $result         = $this->db->query("
            SELECT ii.*,
                i.client_id
            FROM hb_invoices i,
                hb_invoice_items ii
            WHERE i.id = :invoiceId
                AND i.id = ii.invoice_id
                AND i.status = 'Unpaid'
            ORDER BY ii.id ASC # ต้องเรียงด้วย ii.id ASC
            ", array(
                ':invoiceId'    => $invoiceId
            ))->fetchAll();

        $result     = count($result) ? $result : array();


        return $result;
    }

    public function updateInvoiceWithHoldingTax ($invoiceId, $data)
    {
        $this->db->query("
            UPDATE hb_invoices
            SET tax_wh_3 = :tax_wh_3,
                total_wh_3 = :total_wh_3,
                tax_wh_1 = :tax_wh_1,
                total_wh_1 = :total_wh_1,
                tax_wh_15 = :tax_wh_15,
                total_wh_15 = :total_wh_15,
                is_tax_wh_15 = :is_tax_wh_15,
                paid_id = :paidId,
                tax = :tax,
                `total` = :total
            WHERE
                id = :invoiceId
            ", array(
                ':tax_wh_3'         => $data['tax_wh_3'],
                ':total_wh_3'       => $data['total_wh_3'],
                ':tax_wh_1'         => $data['tax_wh_1'],
                ':total_wh_1'       => $data['total_wh_1'],
                ':tax_wh_15'        => $data['tax_wh_15'],
                ':total_wh_15'      => $data['total_wh_15'],
                ':is_tax_wh_15'     => $data['isTax15'],
                ':paidId'           => $data['paidId'],
                ':invoiceId'        => $invoiceId,
                ':tax'              => $data['tax'],
                ':total'            => $data['total']
            ));
    }

    public function setTaxProformaInvoiceItem ($invoiceId)
    {
        $this->db->query("
            UPDATE hb_invoice_items
            SET taxed = '1',
                tax_rate = '7'
            WHERE invoice_id = :invoice_id
            ", array(
                ':invoice_id'   => $invoiceId
            ));

    }

    public function getClientDetailByClientId ($clientId)
    {
        $result         = $this->db->query("
            SELECT
                cd.*
            FROM
                hb_client_details cd
            WHERE
                cd.id = :id
            ", array(
            ':id'     => $clientId
            ))->fetch();

        $result     = count($result) ? $result : array();

        return $result;
    }

    public function getClientTaxIDByClientId ($clientId)
    {
        $result         = $this->db->query("
            SELECT
                cfv.value
            FROM
                hb_client_fields cf,
                hb_client_fields_values cfv
            WHERE
                cfv.field_id = cf.id
                AND cf.code = 'taxid'
                AND cfv.client_id = :client_id
            ", array(
            ':client_id'     => $clientId
            ))->fetch();

        $result     = count($result) ? $result : array();

        return $result;
    }

    public function updateInvoiceBillingAddress ($invoiceId, $data)
    {
        $this->db->query("
            UPDATE hb_invoices
            SET billing_contact_id = :billingContactId,
                billing_address = :billingAddress,
                billing_taxid = :billingTaxId,
                mailing_contact_id = :mailingContactId,
                mailing_address = :mailingAddress
            WHERE
                id = :invoiceId
            ", array(
                ':billingContactId'     => $data['billingContactId'],
                ':billingAddress'       => $data['billingAddress'],
                ':billingTaxId'         => $data['billingTaxId'],
                ':mailingContactId'     => $data['mailingContactId'],
                ':mailingAddress'       => $data['mailingAddress'],
                ':invoiceId'            => $invoiceId
            ));

    }

    public function updateInvoiceNumber ($invoiceId, $invoiceNumber)
    {
        $canCreateSOD = 1;
        if (empty($invoiceNumber)) {
            $canCreateSOD = 0;
        }
        $this->db->query("
            UPDATE
                hb_invoices
            SET
                invoice_number = :invoiceNumber,
                create_sod_status = :canCreateSOD
            WHERE
                id = :invoiceId
            ", array(
                ':invoiceNumber'    => $invoiceNumber,
                ':invoiceId'        => $invoiceId,
                ':canCreateSOD' => $canCreateSOD
            ));
    }

    public function updateInvoicePaidId ($invoiceId, $paidId)
    {
        $this->db->query("
            UPDATE
                    hb_invoices
                SET
                    paid_id = :paidId
                WHERE
                    id = :invoiceId
            ", array(
                ':paidId'           => $paidId,
                ':invoiceId'        => $invoiceId,
            ));

    }

    public function updateInvoiceItemDiscount ($invoiceId, $invoiceItemId, $data)
    {
        $this->db->query("
            UPDATE hb_invoice_items
            SET amount = amount - ( :discount_price - discount_price )
            WHERE id = :invoiceItemId
            ", array(
                ':discount_price'   => $data['discountPrice'],
                ':invoiceItemId'    => $invoiceItemId
            ));

        $this->db->query("
            UPDATE hb_invoice_items
            SET discount_price = :discount_price
            WHERE id = :invoiceItemId
            ", array(
                ':discount_price'   => $data['discountPrice'],
                ':invoiceItemId'    => $invoiceItemId
            ));

        $this->db->query("
            UPDATE hb_invoice_items
            SET tax  = IF( taxed, (amount * tax_rate / 100 ), 0)
            WHERE id = :invoiceItemId
            ", array(
                ':invoiceItemId'    => $invoiceItemId
            ));

        $result     = $this->db->query("
        SELECT SUM(amount) AS total
        FROM hb_invoice_items
        WHERE invoice_id = :invoice_id
        ", array(
            ':invoice_id'    => $invoiceId
        ))->fetch();
        $total      = $result['total'];

        $this->db->query("
            UPDATE hb_invoices
            SET subtotal  = :subtotal
            WHERE id = :id
            ", array(
                ':subtotal'     => $total,
                ':id'           => $invoiceId
            ));

    }



    public function updateEstimateItemDiscount ($estimateItemId, $data)
    {

        $this->db->query("
            UPDATE hb_estimate_items
            SET amount = amount - ( :discount_price - discount_price )
            WHERE id = :estimateItemId
            ", array(
                ':discount_price'   => $data['discountPrice'],
                ':estimateItemId'   => $estimateItemId
            ));

        $this->db->query("
            UPDATE hb_estimate_items
            SET discount_price = :discount_price
            WHERE id = :estimateItemId
            ", array(
                ':discount_price'   => $data['discountPrice'],
                ':estimateItemId'    => $estimateItemId
            ));


        $this->db->query("
            UPDATE hb_estimate_items
            SET tax  = IF( taxed, (amount * tax_rate / 100 ), 0)
            WHERE id = :estimateItemId
            ", array(
                ':estimateItemId'    => $estimateItemId
            ));

    }


    public function updateInvoiceItemUnitPrice ($invoiceItemId, $data)
    {
        $this->db->query("
            UPDATE hb_invoice_items
            SET unit_price = :unit_price
            WHERE id = :invoiceItemId
            ", array(
                ':unit_price'   => $data['unitPrice'],
                ':invoiceItemId'    => $invoiceItemId
            ));

        $this->db->query("
            UPDATE hb_invoice_items
            SET amount = ( unit_price * quantity ) - discount_price
            WHERE id = :invoiceItemId
            ", array(
                ':invoiceItemId'    => $invoiceItemId

            ));

    }
    public function updateEstimateItemUnitPrice ($invoiceItemId, $unitPrice)
    {
        $this->db->query("
            UPDATE hb_estimate_items
            SET unit_price = :unit_price
            WHERE id = :estimateItemId
            ", array(
                ':unit_price'     => $unitPrice,
                ':estimateItemId' => $invoiceItemId
            ));

        $this->db->query("
            UPDATE hb_estimate_items
            SET amount = ( unit_price * quantity ) - discount_price
            WHERE id = :estimateItemId
            ", array(
                ':estimateItemId'    => $invoiceItemId

            ));

    }


    public function getInvoiceItemByInvoiceItemId ($invoiceItemId)
    {
        $result         = $this->db->query("
            SELECT
                ii.*
            FROM
                hb_invoice_items ii
            WHERE
                ii.id = :itemId
            ", array(
                ':itemId'   => $invoiceItemId

            ))->fetch();

        $result     = count($result) ? $result : array();

        return $result;
    }


    public function updateInvoiceItemQuantity ($invoiceItemId, $data)
    {
        $this->db->query("
            UPDATE
                hb_invoice_items
            SET
                quantity = :quantityValue,
                quantity_text = :quantityText
            WHERE
                id = :itemId
            ", array(
                ':itemId'           => $invoiceItemId,
                ':quantityValue'    => $data['quantityValue'],
                ':quantityText'     => $data['quantityText']
            ));

        $this->db->query("
            UPDATE hb_invoice_items
            SET amount = ( unit_price * quantity ) - discount_price
            WHERE id = :invoiceItemId
            ", array(
                ':invoiceItemId'    => $invoiceItemId
            ));

    }

    public function updateInvoiceItemQuantityText ($invoiceItemId, $quantityText)
    {
        $this->db->query("
            UPDATE
                hb_invoice_items
            SET
                quantity_text = :quantityText
            WHERE
                id = :itemId
            ", array(
                ':itemId'           => $invoiceItemId,
                ':quantityText'     => $quantityText
            ));
    }

    public function updateEstimateItemQuantity ($invoiceItemId, $quantityValue)
    {
        $this->db->query("
            UPDATE
                hb_estimate_items
            SET
                quantity = :quantity
            WHERE
                id = :itemId
            ", array(
                ':quantity'    => $quantityValue,
                ':itemId'      => $invoiceItemId
            ));
            $this->db->query("
            UPDATE hb_estimate_items
            SET amount = ( unit_price * quantity ) - discount_price
            WHERE id = :itemId
            ", array(
                ':itemId'    => $invoiceItemId
            ));

    }
    public function updateEstimateItemQuantityText ($invoiceItemId, $quantityText)
    {
        $this->db->query("
            UPDATE
                hb_estimate_items
            SET
                quantity_text = :quantityText
            WHERE
                id = :itemId
            ", array(
                ':itemId'      => $invoiceItemId,
                ':quantityText'    => $quantityText

            ));
    }

    public function isProformaPaid ($invoiceId)
    {
        $result         = $this->db->query("
            SELECT
                i.id
            FROM
                hb_invoice_items ii,
                hb_invoices i
            WHERE
                ii.item_id = :invoiceId
                AND ii.type = 'Invoice'
                AND ii.invoice_id = i.id
                AND i.status = 'Paid'
            ", array(
                ':invoiceId'        => $invoiceId
            ))->fetch();

        $result     = (isset($result['id']) && $result['id']) ? 1 : 0;

        return $result;
    }

    public function isProformaChildVat ($invoiceId)
    {
        $result         = $this->db->query("
            SELECT
                i.id
            FROM
                hb_invoice_items ii,
                hb_invoices ix,
                hb_invoices i
            WHERE
                i.id = :invoiceId
                AND i.status = 'Paid'
                AND ii.invoice_id = i.id
                AND ii.type = 'Invoice'
                AND ii.item_id = ix.id
                AND ix.tax > 0
            ", array(
                ':invoiceId'        => $invoiceId,
            ))->fetch();

        $result     = (isset($result['id']) && $result['id']) ? 1 : 0;

        return $result;
    }

    public function getEstimateItemyByEstimateId ($estimateId)
    {
        $result         = $this->db->query("
            SELECT *
            FROM hb_estimate_items
            WHERE estimate_id =  :estimate_id
            ORDER BY id  ASC
            ", array(
            ':estimate_id'     => $estimateId
            ))->fetchAll();

        $result     = count($result) ? $result : array();

        return $result;
    }

    public function getOrderDraftItemByEstimateId ($estimateId)
    {
        $result         = $this->db->query("
            SELECT *
            FROM hb_order_drafts_items odi,
            hb_order_drafts od
            WHERE odi.draft_id = od.id
            AND od.estimate_id = :estimate_id
            AND odi.item_type IN ('domains','services')
            ORDER BY FIELD (odi.item_type,'domains','services')
            ,odi.item_id ASC

            ", array(
            ':estimate_id'     => $estimateId
            ))->fetchAll();

        $result     = count($result) ? $result : array();

        return $result;

    }

    public function getOrderDraftAddonItemByEstimateId ($estimateId)
    {
        $result         = $this->db->query("
            SELECT *
            FROM hb_order_drafts_items odi,
            hb_order_drafts od
            WHERE odi.draft_id = od.id
            AND od.estimate_id = :estimate_id
            AND odi.item_type = 'addons'
            ORDER BY odi.item_id ASC

            ", array(
            ':estimate_id'     => $estimateId
            ))->fetchAll();

        $result     = count($result) ? $result : array();
        $aAddon     = array();
        foreach ($result as $arr) {
            $aSetting   = json_decode($arr['settings'], true);
            if (count($aSetting)) {
                $aSetting_  = $aSetting;
                foreach ($aSetting_ as $arr2) {
                    if ($arr2['qty']) {
                        $arr2['item_type']  = 'addons';
                        $arr2['product_id']  = $arr2['id'];
                        $arr2['cycle']  = $arr2['recurring'];
                        $arr2['settings']   = json_encode($arr2);
                        array_push($aAddon, $arr2);
                    }
                }
            }
        }

        return $aAddon;

    }


    public function getAccountAddonPrice ($addonId)
    {
        $result         = $this->db->query("

            SELECT
                c.*,
                aa.billingcycle, aa.addon_id
            FROM
                hb_accounts_addons aa,
                hb_common c
            WHERE
                aa.id = :addonId
                AND aa.addon_id = c.id
                AND c.rel = 'Addon'
                AND c.paytype = 'Regular'
            ", array(
                ':addonId'     => $addonId
            ))->fetch();

        if (! count($result)) {
            return $result;
        }

        return $result;
    }

    public function getFieldUpgradeByItemId ($itemId)
    {
        $result         = $this->db->query("
            SELECT *
            FROM hb_config_upgrades
            WHERE id = :itemId
            ", array(
            ':itemId'     => $itemId
            ))->fetch();

        $result  = count($result) ? $result : array();
        return $result;
    }

    public function getVariableUpgradeByConfigcat ($catId)
    {
        $result         = $this->db->query("
            SELECT *
            FROM hb_config_items_cat
            WHERE id = :catId
            ", array(
            ':catId'     => $catId
            ))->fetch();

        $result  = count($result) ? $result : array();
        return $result;
    }

    public function getCustomData ($request)
    {

        $item_type ='';

        if($request['item_type']=='domains'){
            $item_type = 'dom_customfields' ;
        }
        else if($request['item_type']=='services'){
            $item_type = 'customfields' ;
        }

        $result         = $this->db->query("
            SELECT *
            FROM hb_order_drafts_items odi
            WHERE odi.draft_id  = :draftId
            AND  odi.item_type = :type
            AND  odi.item_id   = :itemId
            ", array(
                ':draftId'  => $request['draft_id'],
                ':itemId'   => $request['item_id'],
                ':type'     => $item_type

            ))->fetch();

        $result     = count($result) ? $result : array();

        return $result;

    }
    public function getDomainPriceByProductID ($productId)
    {
        $result         = $this->db->query("
        SELECT *
        FROM hb_domain_periods dp
        WHERE dp.product_id   = :productId
        ORDER BY dp.period ASC
        ", array(
            ':productId'  => $productId
        ))->fetchAll();
    $result     = count($result) ? $result : array();
    $aPriod = array();
        foreach($result as $arr){
            $aPriod[$arr['period']]  = $arr;
        }

    return $aPriod;
    }

    public function updateEstimateItem ($request)
    {

        $this->db->query("
        UPDATE hb_estimate_items
        SET amount          = :amount,
            unit_price      = :unitPrice,
            quantity        = :quantity,
            quantity_text   = :quantity_text,
            discount_price  = :discount_price
        WHERE id = :id
        AND estimate_id =:estimate_id
        ", array(
            ':amount'          => $request['amount'],
            ':unitPrice'       => $request['unitPrice'],
            ':quantity'        => $request['quantity'],
            ':quantity_text'   => $request['quantityText'],
            ':discount_price'  => $request['discountPrice'],
            ':id'              => $request['itemId'],
            ':estimate_id'     => $request['estimateId']
        ));
    }
    public function updateEstimateItemProductAddons ($request)
    {

        $this->db->query("
        UPDATE hb_estimate_items
        SET amount       = :amount,
            qty          = :qty
        WHERE id = :id
        AND estimate_id =:estimate_id
        ", array(
            ':amount'       => $request['amount'],
            ':qty'          => $request['qty'],
            ':id'           => $request['itemId'],
            ':estimate_id'  => $request['estimateId']
        ));
    }

    public function getProductPriceByProductID($productId)
    {
        $result    = $this->db->query("
            SELECT *
            FROM hb_common c
            WHERE c.id = :productId
            AND (c.paytype LIKE '%Regular' OR c.paytype ='Once')
            ", array(
                ':productId'  => $productId
            ))->fetch();
        $result     = count($result) ? $result : array();
        return $result;
    }

    public function getComponentPriceByProductID($aItemId)
    {

       $result    = $this->db->query("
            SELECT *
            FROM hb_common c
            WHERE c.id IN (".implode(',', $aItemId) .")
            AND c.paytype = 'Regular'
            "
            )->fetchAll();

        $result     = count($result) ? $result : array();

        $aResult = array();
        foreach($result as $arr){
            $aResult[$arr['id']]  = $arr;
        }
        return $aResult;
    }
    public function getUpgradePriceByConfigItemId($aItemId)
    {

       $result    = $this->db->query("
            SELECT *
            FROM hb_common c
            WHERE c.id IN (".implode(',', $aItemId) .")
            AND c.paytype = 'Regular'
            "
            )->fetchAll();

        $result     = count($result) ? $result : array();

        $aResult = array();
        foreach($result as $arr){
            $aResult[$arr['id']]  = $arr;
        }
        return $aResult;
    }

    public function getDomainDataByDomainId ($domainId)
    {
        $result    = $this->db->query("
                SELECT d.id, d.tld_id AS product_id, d.period
                FROM hb_domains d
                WHERE d.id = :domainId
                ", array(
                    ':domainId'     => $domainId
                ))->fetch();
        $aResult    = isset($result['id']) ? $result : array();

        $result    = $this->db->query("
                SELECT c.*,
                    cat.variable, cat.product_id
                FROM hb_config2accounts c
                JOIN hb_config_items cit
                    ON (c.config_id = cit.id)
                JOIN hb_config_items_cat cat
                    ON (cat.id = cit.category_id)
                WHERE c.rel_type = 'Domain'
                AND c.account_id = :domainId
                AND cat.variable != ''
                ", array(
                    ':domainId'     => $domainId
                ))->fetchAll();

        $result     = count($result) ? $result : array();

        foreach($result as $arr){
            $key    = $arr['variable'];
            $aResult[$key]  = $arr;
        }

        return $aResult;
    }


    public function getConfigCat ($aCatId)
    {
        $result    = $this->db->query("
            SELECT *
            FROM hb_config_items_cat
            WHERE id IN (".implode(',', $aCatId) .")
            "
            )->fetchAll();

        $result     = count($result) ? $result : array();

        $aResult = array();
        foreach($result as $arr){
            $arr['aConfig'] = unserialize($arr['config']);
            $aResult[$arr['id']]  =  $arr;

        }
        return $aResult;
     }

     public function getProductUpgradeByAccountId($accountId)
    {

        $result    = $this->db->query("
            SELECT
                c2a.*,
                cic.name, cic.config,
                c.m, c.q, c.s, c.a, c.b, c.t,cic.variable
            FROM
                hb_config2accounts c2a,
                hb_config_items_cat cic,
                hb_common c
            WHERE
                c2a.account_id = :accountId
                AND c2a.rel_type = 'Hosting'
                AND c2a.config_cat = cic.id
                AND c2a.config_id = c.id
                AND c.rel = 'Config'
                AND c.paytype = 'Regular'
            ", array(
                ':accountId'    => $accountId
            ))->fetchAll();



        $result     = count($result) ? $result : array();
        $aRegulars      = array();
            foreach($result as $arr){
                $arr['aConfig'] = unserialize($arr['config']);
                $aRegulars[$arr['config_id']]  =  $arr;
            }
        return $aRegulars;
    }

     public function getComponentPriceByAccountId($accountId)
    {


        $result    = $this->db->query("
            SELECT
                c2a.*,
                cic.name, cic.config,cic.variable,
                c.m, c.q, c.s, c.a, c.b, c.t
            FROM
                hb_config2accounts c2a,
                hb_config_items_cat cic,
                hb_common c
            WHERE
                c2a.account_id = :accountId
                AND c2a.rel_type = 'Hosting'
                AND c2a.config_cat = cic.id
                AND c2a.config_id = c.id
                AND c.rel = 'Config'
                AND c.paytype = 'Regular'
                AND(cic.variable LIKE '%selection%' OR cic.variable != '')
            ", array(
                ':accountId'    => $accountId
            ))->fetchAll();



        $result     = count($result) ? $result : array();
        $aRegulars      = array();
            foreach($result as $arr){
                $arr['aConfig'] = unserialize($arr['config']);
                $aRegulars[$arr['config_id']]  =  $arr;
            }
        return $aRegulars;
    }

    public function getProductCategoryIdByitemId ($itemId)
    {
        $result   = $this->db->query("
                    SELECT a.*,p.category_id
                    FROM hb_accounts a,hb_products p
                    WHERE a.product_id = p.id
                    AND a.id = :accountId
                    ", array(
                        ':accountId'     => $itemId
                    ))->fetch();

        $result     = count($result) ? $result : array();

        return $result;
    }

    public function getAccountPrice ($accountId)
    {
        $result         = $this->db->query("
            SELECT
                c.*,
                a.billingcycle, a.product_id
            FROM
                hb_accounts a,
                hb_common c
            WHERE
                a.id = :accountId
                AND a.product_id = c.id
                AND c.rel = 'Product'
                AND c.paytype IN ( 'Regular', 'Bundle','Once','SSLRegular' )
            ", array(
                ':accountId'     => $accountId
            ))->fetch();

        $result     = count($result) ? $result : array();

        return $result;
    }

    public function listEsitmateAmountByInvoiceId ($invoiceId)
    {
        $result         = $this->db->query("
            SELECT e.id,ei.*
            FROM hb_estimates e ,
                hb_estimate_items ei
            WHERE e.id = ei.estimate_id
            AND  invoice_id = :invoice_id
            ORDER BY ei.id ASC
            ", array(
                ':invoice_id'     => $invoiceId
            ))->fetchAll();

        $result     = count($result) ? $result : array();
        return $result;
    }


    public function getEstimateByEstimateId($estimateId){


        $result  = $this->db->query("
                SELECT *
                FROM hb_estimates
                WHERE id = :id
            ", array(
                ':id'     => $estimateId
            ))->fetch();

        $result     = count($result) ? $result : array();
        return $result;
    }
    public function isDraftEstimateByEstimateId($estimateId){


        $result  = $this->db->query("
                SELECT *
                FROM hb_estimates
                WHERE id = :id
                AND status = 'Draft'
            ", array(
                ':id'     => $estimateId
            ))->fetch();

        $result     = count($result) ? $result : array();
        return $result;
    }

    public function getEstimateByInvoiceId($invoiceId)
    {
        $result         = $this->db->query("
            SELECT *
            FROM hb_estimates
            WHERE invoice_id = :invoice_id
            ", array(
                ':invoice_id'     => $invoiceId
            ))->fetch();

        $result     = count($result) ? $result : array();
        return $result;
    }
    public function updateInvoiceAfterConvertFromEstimate($estimateId,$invoiceId)
{
        $this->db->query("
            UPDATE hb_invoices
                SET estimate_id = :estimate_id
            WHERE id = :id
            ", array(
                ':estimate_id'  => $estimateId,
                ':id'           => $invoiceId

        ));

        $result  = $this->db->query("
            SELECT SUM(amount) AS total
            FROM hb_invoice_items
            WHERE invoice_id = :invoice_id
            ", array(
                ':invoice_id'    => $invoiceId
        ))->fetch();
        $total      = $result['total'];

        $this->db->query("
            UPDATE hb_invoices
            SET subtotal  = :subtotal
            WHERE id = :id
            ", array(
                ':subtotal'     => $total,
                ':id'           => $invoiceId
        ));
    }

    public function getInvoiceHostingRenew ($invoiceId,$itemId){
        $result = $this->db->query("
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

        $result    =  count($result) ? $result : array();
        return $result;

    }

    /*public function updateInvoiceTypeRenew($invoiceId)
    {
        $this->db->query("
            UPDATE hb_invoices
            SET is_skip_deal  = 1
            WHERE id = :id
            ", array(
                ':id' => $invoiceId
        ));
    }*/

    public function addSimNumber ($invoiceId)
    {
        $simNumber  = 'SIM'. date('ym') .'-XXXX';
        $this->db->query("
            UPDATE hb_invoices
            SET sim_number  = :sim_number
            WHERE id = :id
            ", array(
                ':sim_number' => $simNumber,
                ':id' => $invoiceId
        ));
    }

    public function updateSimNumber ($invoiceId, $simNumber)
    {
        $this->db->query("
            UPDATE hb_invoices
            SET  sim_number  = :sim_number
            WHERE id = :id
            ", array(
                ':sim_number' => $simNumber,
                ':id' => $invoiceId
        ));
    }

    public function isModuleActive ($module)
    {
        $result     = $this->db->query("
            SELECT mc.id
            FROM hb_modules_configuration mc
            WHERE mc.active = 1
                AND mc.module = :module
            ", array(
                ':module' => $module
            ))->fetch();

        $result    =  (isset($result['id']) && $result['id']) ? true : false;
        return $result;
    }

    public function getAccountContactId ($accountId)
    {
        $result     = $this->db->query("
            SELECT bc.*
            FROM hb_billing_contacts bc
            WHERE bc.account_id = :account_id
            ", array(
                ':account_id' => $accountId
            ))->fetch();

        $result    =  isset($result['contact_id']) ? $result : array();
        return $result;
    }

    public function updateEstimateBillingAddress ($estimateId)
    {
        $result     = $this->db->query("
            SELECT od.*
            FROM hb_order_drafts od
            WHERE od.estimate_id = :estimate_id
            ", array(
                ':estimate_id' => $estimateId
            ))->fetch();

        $billingContactId   = isset($result['billing_contact_id']) ? $result['billing_contact_id'] : 0;
        $billingAddress     = isset($result['billing_address']) ? $result['billing_address'] : '';

        $this->db->query("
            UPDATE hb_estimates
            SET  billing_contact_id  = :billing_contact_id,
                billing_address = :billing_address
            WHERE id = :id
            ", array(
                ':billing_contact_id'   => $billingContactId,
                ':billing_address'      => $billingAddress,
                ':id'   => $estimateId
        ));
    }

    public function updateMetadata ($invoiceId, $aMeta)
    {
        $this->db->query("
            UPDATE hb_invoices
            SET  metadata  = :metadata
            WHERE id = :id
            ", array(
                ':metadata' => serialize($aMeta),
                ':id' => $invoiceId
        ));
    }




}