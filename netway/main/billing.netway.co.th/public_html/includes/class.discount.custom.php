<?php

/**
 * [XXX]
 * @author prasit
 *
 */

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class DiscountCustom {

    private static  $instance;
    private $aDiscounts = array();

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

    }

    /**
     * สร้างข้อมูลส่วนลด
     * @param $aProducts
     * @return unknown_type
     */
    public function getInfo ($aProducts, $type = '')
    {
        $this->aDiscounts   = $aProducts;

        switch ($type) {
            case 'product'     :{
                    $this->aDiscounts   = self::_getProductDiscount($aProducts);
                }
                break;
            case 'custom'     :{
                    foreach ($aProducts as $k => $aProduct) {
                        $aItems     = $aProduct['items'];

                        foreach ($aItems as $k2 => $aItem) {

                            /* --- การจะแสดงส่วนลดสำหรับ custom field เหมาะกับ Tiered, Stairstep --- */
                            $this->aDiscounts[$k]['items'][$k2]     = self::_getResourceDiscount($aItem);
                            if (isset($this->aDiscounts[$k]['items'][$k2]['discount'])
                                && ! isset($this->aDiscounts[$k]['discount'])) {
                                $this->aDiscounts[$k]['discount']   = $this->aDiscounts[$k]['items'][$k2]['discount'];
                            }

                        }

                    }
                }
                break;
            default             :{
                foreach ($aProducts as $k => $aProduct) {
                    $this->aDiscounts[$k]   = self::_getProductDiscount($aProduct);
                }
            }
        }

        return $this->aDiscounts;
    }

    /**
     * หาส่วนลดโดเมน
     * @param unknown_type $aPrice
     * @param unknown_type $type
     * @return unknown_type
     */
    public function getDomainDiscount ($aPrice, $type)
    {
        if (! is_array($aPrice) || count($aPrice) != 2) {
            return 0;
        }

        $price      = $aPrice[0][$type] * $aPrice[1]['period'];
        $discount   = $price - $aPrice[1][$type];

        if ($discount > 0) {
            return $discount;
        } else {
            return 0;
        }
    }

    /**
     * หาส่วนลด account
     * @param unknown_type $aPrice
     * @return unknown_type
     */
    public function getAccountDiscount ($aPrice, $billingCycle)
    {
        if (! is_array($aPrice) || ! count($aPrice) || ! $billingCycle) {
            return 0;
        }

        $xDiscount  = strtolower(substr($billingCycle, 0, 1)) . 'Discount';
        $aPrice     = self::_getProductDiscount($aPrice);

        if (isset($aPrice[$xDiscount]) && $aPrice[$xDiscount] > 0) {
            return $aPrice[$xDiscount];
        } else {
            return 0;
        }
    }

    /**
     * หาส่วนลด account
     * @param unknown_type $aPrice
     * @return unknown_type
     */
    public function getAddonDiscount ($aPrice, $billingCycle)
    {
         if (! is_array($aPrice) || ! count($aPrice) || ! $billingCycle) {
            return 0;
        }

        $xDiscount  = strtolower(substr($billingCycle, 0, 1)) . 'Discount';
        $aPrice     = self::_getProductDiscount($aPrice);

        if (isset($aPrice[$xDiscount]) && $aPrice[$xDiscount] > 0) {
            return $aPrice[$xDiscount];
        } else {
            return 0;
        }
    }

    /**
     * หาส่วนลด resource แบบ tiered price
     * @param unknown_type $aPrice
     * @param unknown_type $billingCycle
     * @return number|number|number|number
     */
    public function getResourceTieredDiscount ($configId, $c2aQty, $bc)
    {
        $db             = hbm_db();

        /* --- ส่วนลดใช้ได้กับ tiered --- */
        $result         = self::getResourceTieredPrice ($configId, $c2aQty);

        $aPrice         = array(
            'unitPrice'     => 0,
            'discountPrice' => 0
            );

        if (! is_array($result) || count($result) != 2 || ! $bc) {
            return $aPrice;
        }

        if (! isset($result[0][$bc]) || ! isset($result[1][$bc]) ) {
            return $aPrice;
        }

        $unitPrice  = $result[0][$bc];
        $discount   = $result[0][$bc] - $result[1][$bc];

        if ($discount > 0) {
            $aPrice         = array(
                'unitPrice'     => $unitPrice,
                'discountPrice' => $discount
                );
            return $aPrice;
        } else {
            return $aPrice;
        }
    }

    public function getResourceTieredPrice ($configId, $c2aQty)
    {
        $db             = hbm_db();

        /* --- ส่วนลดใช้ได้กับ tiered --- */
        $result         = $db->query("
                SELECT
                    c.*
                FROM
                    hb_config_resources cr,
                    hb_common c
                WHERE
                    cr.item_id = :configId
                    AND (
                        cr.qty = 1
                        OR (
                            cr.qty <= :c2aQty
                            AND cr.qty_max >= :c2aQty
                        )
                    )
                    AND cr.id = c.id
                    AND c.rel = 'FResource'
                    AND c.paytype = 'tiered'

                ORDER BY cr.qty ASC
                ", array(
                    ':configId'     => $configId,
                    ':c2aQty'       => $c2aQty
                ))->fetchAll();

        $result     = count($result) ? $result : array();

        return $result;
    }


    public function getConfigRegularPrice ($configId)
    {
        $db             = hbm_db();

        /* --- ส่วนลดใช้ได้กับ tiered --- */
        $result         = $db->query("
                SELECT
                    c.*
                FROM
                    hb_common c
                WHERE
                    c.id = :configId
                    AND c.rel = 'Config'
                    AND c.paytype = 'Regular'

                ", array(
                    ':configId'     => $configId
                ))->fetchAll();

        $result     = count($result) ? $result : array();

        return $result;
    }

    /**
     * หาส่วนลดสำหรับ regular price
     */
    public function getRegularDiscount ($aConfig, $bc)
    {
        $unitPrice      = 0;
        $discount       = 0;

        if ( isset($aConfig['m']) && $aConfig['m'] > 0) {
            $unitPrice      = $aConfig['m'];
            if ($bc == 'q' && (isset($aConfig['q']) && $aConfig['q'] > 0)) {
                $discount   = ($unitPrice * 3) - $aConfig['q'];
            }
            if ($bc == 's' && (isset($aConfig['s']) && $aConfig['s'] > 0)) {
                $discount   = ($unitPrice * 6) - $aConfig['s'];
            }
            if ($bc == 'a' && (isset($aConfig['a']) && $aConfig['a'] > 0)) {
                $discount   = ($unitPrice * 12) - $aConfig['a'];
            }
            if ($bc == 'b' && (isset($aConfig['b']) && $aConfig['b'] > 0)) {
                $discount   = ($unitPrice * 24) - $aConfig['b'];
            }
            if ($bc == 't' && (isset($aConfig['t']) && $aConfig['t'] > 0)) {
                $discount   = ($unitPrice * 36) - $aConfig['t'];
            }
        } elseif ( isset($aConfig['a']) && $aConfig['a'] > 0) {
            $unitPrice      = $aConfig['a'];
            if ($bc == 'b' && (isset($aConfig['b']) && $aConfig['b'] > 0)) {
                $discount   = ($unitPrice * 24) - $aConfig['b'];
            }
            if ($bc == 't' && (isset($aConfig['t']) && $aConfig['t'] > 0)) {
                $discount   = ($unitPrice * 36) - $aConfig['t'];
            }
        }

        $qty            = $aConfig['qty'];

        if (isset($aConfig['aConfig']['dontchargedefault']) && $aConfig['aConfig']['dontchargedefault']) {
            $qty        = $qty - $aConfig['aConfig']['initialval'];
        }

        $unitPrice      = $unitPrice * $qty;
        $discount       = $discount * $qty;

        $aPrice         = array(
            'unitPrice'     => $unitPrice,
            'discountPrice' => $discount
            );
        return $aPrice;
    }

    public function _getProductDiscount ($aPrice)
    {
        $unitPrice          = 0;

        /* --- hosting --- */
        if ( isset($aPrice['m']) && $aPrice['m'] > 0) {
            $unitPrice      = $aPrice['m'];
            $aPrice['mQuantity']        = 1;
            $aPrice['mQuantityText']    = 'MONTH';

            if ( isset($aPrice['q']) && $aPrice['q'] > 0) {
                $aPrice['qQuantity']    = 3;
                $aPrice['qQuantityText']= 'MONTH';
                $aPrice['qDiscount']    = ($unitPrice * 3) - $aPrice['q'];
            }
            if ( isset($aPrice['s']) && $aPrice['s'] > 0) {
                $aPrice['sQuantity']    = 6;
                $aPrice['sQuantityText']= 'MONTH';
                $aPrice['sDiscount']    = ($unitPrice * 6) - $aPrice['s'];
            }
            if ( isset($aPrice['a']) && $aPrice['a'] > 0) {
                $aPrice['aQuantity']    = 12;
                $aPrice['aQuantityText']= 'MONTH';
                $aPrice['aDiscount']    = ($unitPrice * 12) - $aPrice['a'];
            }
            if ( isset($aPrice['b']) && $aPrice['b'] > 0) {
                $aPrice['bQuantity']    = 24;
                $aPrice['bQuantityText']= 'MONTH';
                $aPrice['bDiscount']    = ($unitPrice * 24) - $aPrice['b'];
            }
            if ( isset($aPrice['t']) && $aPrice['t'] > 0) {
                $aPrice['tQuantity']    = 36;
                $aPrice['tQuantityText']= 'MONTH';
                $aPrice['tDiscount']    = ($unitPrice * 36) - $aPrice['t'];
            }

        } elseif ( isset($aPrice['a']) && $aPrice['a'] > 0) {
            $unitPrice      = $aPrice['a'];
            $aPrice['aQuantity']        = 1;
            $aPrice['aQuantityText']    = 'YEAR';

            if ( isset($aPrice['b']) && $aPrice['b'] > 0) {
                $aPrice['bQuantity']    = 2;
                $aPrice['bQuantityText']= 'YEAR';
                $aPrice['bDiscount']    = ($unitPrice * 2) - $aPrice['b'];
            }
            if ( isset($aPrice['t']) && $aPrice['t'] > 0) {
                $aPrice['tQuantity']    = 3;
                $aPrice['tQuantityText']= 'YEAR';
                $aPrice['tDiscount']    = ($unitPrice * 3) - $aPrice['t'];
            }

        }

        $aPrice['unitPrice']        = $unitPrice;

        return $aPrice;
    }

    private function _getResourceDiscount ($aItem)
    {
        if ( ! is_array($aItem['prices']) ) {
            return $aItem;
        }

        $info       = '';
        $type       = $aItem['recurring'];
        $basePrice  = $aItem['prices'][0][$type];

        for ($i = 1; $i < count($aItem['prices']); $i++) {
            $aPrice     = $aItem['prices'][$i];

            if ( isset($aPrice[$type]) && $aPrice[$type] > 0) {

                $qty        = $aPrice['qty'];
                $price      = $aPrice[$type];
                $discount   = $basePrice - $aPrice[$type];
                if ($aPrice['paytype'] == 'stairstep') {
                    $discount   = ($basePrice*($i+1)) - $aPrice[$type];
                }

                $info       .= ' สั่งซื้อตั้งแต่ '. $qty .' qty ขึ้นไป';
                if ($discount > 0) {
                    $info   .= ' ได้รับส่วนลด '. number_format($discount) .' บาท'
                        . ( ($aPrice['paytype'] == 'tiered') ? ' / qty' : '')
                        . ' เหลือ'
                        ;
                } else {
                    $info   .= ' ราคา';
                }
                $info       .= ' '. number_format($price) .' บาท'
                    . ( ($aPrice['paytype'] == 'tiered') ? ' / qty' : '')
                    . '<br />'
                    ;

            }
        }

        $aItem['discount']  = $info;

        return $aItem;
    }

    public function getDomainPrivatePrice ($doaminId)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    c.a
                FROM
                    hb_domains d,
                    hb_products p,
                    hb_config_items_cat cic,
                    hb_config_items ci,
                    hb_common c
                WHERE
                    d.id = :domainId
                    AND d.tld_id = p.id
                    AND p.id = cic.product_id
                    AND cic.type = 8
                    AND cic.id = ci.category_id
                    AND ci.id = c.id
                    AND c.rel = 'Config'
                    AND c.paytype = 'Regular'
                ", array(
                    ':domainId'     => $doaminId
                ))->fetch();

        return isset($result['a']) ? $result['a'] : 0;
    }

    public function addDomainDiscountNote ($domainId, $discountNote)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    n.id
                FROM
                    hb_notes n
                WHERE
                    n.rel_id = :domainId
                    AND n.type = 'domain'
                    AND n.is_discount_note = '1'
                    AND n.rel_id_ext = '0'
                ", array(
                    ':domainId'     => $domainId
                ))->fetch();

        if (! isset($result['id']) && $discountNote) {
            $db->query("
                INSERT INTO hb_notes (
                    `date`, type, rel_id, admin_id, note, is_discount_note
                ) VALUES (
                    :addDate, 'domain', :domainId, '1', :note, '1'
                )
                ", array(
                    ':addDate'      => date('Y-m-d H:i:s'),
                    ':domainId'     => $domainId,
                    ':note'         => $discountNote
                ));
        }

    }

    /**
     * หาราคาโดเมนกับราคาเริ่มต้น 1 ปี
     * */
    public function getDoaminPriceWithBase ($domainId)
    {
        $db             = hbm_db();

        $result         = $db->query("
                SELECT
                    d.id, d.idprotection, dp.*
                FROM
                    hb_domains d,
                    hb_domain_periods dp
                WHERE
                    d.id = :domainId
                    AND d.tld_id = dp.product_id
                    AND (
                        d.period = dp.period
                        OR dp.period = 1
                    )
                ORDER BY dp.period ASC
                ", array(
                    ':domainId'     => $domainId
                ))->fetchAll();

        return $result;
    }

    public function getDomainDiscountPromotion ($domainId, $promotionCode, $aPromotion, $aCycles,
                        $sellPrice,
                        $isPrivate,
                        $privatePrice,
                        $quantity)
    {
        $db             = hbm_db();

        $promotionDiscount  = 0;

        if (! $promotionCode || ! $aPromotion['value']
            || $aPromotion['domains'] == '' || $aPromotion['applyto'] == 'setupfee') {
            return $promotionDiscount;
        }

        $result         = $db->query("
                SELECT
                    p.name,
                    dp.*
                FROM
                    hb_domains d,
                    hb_products p,
                    hb_domain_periods dp
                WHERE
                    d.id = :domainId
                    AND d.tld_id = p.id
                    AND d.tld_id = dp.product_id
                    AND d.period = dp.period
                ", array(
                    ':domainId'     => $domainId
                ))->fetch();

        $domTld     = (isset($result['name']) && $result['name']) ? $result['name'] : '';
        $domPeriod  = (isset($result['period']) && $result['period']) ? $result['period'] : 0;

        if (! $domTld) {
            return $promotionDiscount;
        }

        $aTlds      = explode('|', $aPromotion['domains']);

        /* --- promotion ครอบคลุม product --- */
        if ($aPromotion['domains'] != 'all' && ! in_array($domTld, $aTlds)) {
            return $promotionDiscount;
        }

        /* --- promotion ครอบคลุม cycle --- */
        if ($aPromotion['cycles'] != 'all' && ! in_array('tld'. $domPeriod, $aCycles)) {
            return $promotionDiscount;
        }

        if ($aPromotion['type'] == 'fixed') {
            $promotionDiscount  = $aPromotion['value'];

        } else if ($aPromotion['type'] == 'percent') {
            if ($isPrivate) {
                $sellPrice      = $sellPrice + ($privatePrice * $quantity);
            }
            $promotionDiscount  = $sellPrice * ($aPromotion['value'] / 100);

        }

        return $promotionDiscount;
    }

    public function accountQuantityPresent ($serviceId)
    {
        $db             = hbm_db();

        $aQuantity      = array();

        $result         = $db->query("
            SELECT
                cic.*,
                a.billingcycle
            FROM
                hb_accounts a,
                hb_config_items_cat cic
            WHERE
                a.id = :accountId
                AND a.product_id = cic.product_id
                AND cic.variable LIKE '%quantity%'

            ", array(
                ':accountId'    => $serviceId
            ))->fetch();

        if (isset($result['id'])) {
            $aQuantity      = $result;
            $configCatId    = $aQuantity['id'];

            $result         = $db->query("
                    SELECT
                        c2a.*
                    FROM
                        hb_config2accounts c2a
                    WHERE
                        c2a.account_id = :accountId
                        AND c2a.config_cat = :categoryId
                        AND c2a.rel_type = 'Hosting'
                    ", array(
                        ':accountId'    => $serviceId,
                        ':categoryId'   => $configCatId
                    ))->fetch();

            $aQuantity['quantity']  = isset($result['qty']) ? $result['qty'] : 0;

        }

        return $aQuantity;
    }

    public function getAccountPrice ($accountId)
    {
        $db             = hbm_db();

        $result         = $db->query("
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
                AND c.paytype IN ( 'Regular', 'Bundle' )
            ", array(
                ':accountId'     => $accountId
            ))->fetch();

        if (! count($result)) {
            return $result;
        }

        $result         = self::_getProductDiscount($result);

        return $result;
    }

    public function getAccountAddonPrice ($addonId)
    {
        $db             = hbm_db();

        $result         = $db->query("
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

        $result         = self::_getProductDiscount($result);

        return $result;
    }

    public function getAccountConfigResourcePrice ($accountId)
    {
        $db             = hbm_db();

        $aResources     = array();

        /* --- qty เป็นลักษณะของการให้ล่วนสดได้ --- */
        $result     = $db->query("
            SELECT
                c2a.*,
                cic.name
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
                AND c.paytype = 'Resources'
            ", array(
                ':accountId'    => $accountId
            ))->fetchAll();

        if (! count($result)) {
            return $aResources;
        }

        foreach ($result as $v) {
            $aResources[$v['config_id']]    = $v;
        }

        return $aResources;
    }

    public function getAccountConfigRegularPrice ($accountId)
    {
        $db             = hbm_db();

        $aRegulars      = array();

        $result     = $db->query("
            SELECT
                c2a.*,
                cic.name, cic.config,
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
            ", array(
                ':accountId'    => $accountId
            ))->fetchAll();

        if (! count($result)) {
            return $aRegulars;
        }

        foreach ($result as $v) {
            if (isset($v['config'])) {
                $v['aConfig']   = unserialize($v['config']);
            }
            $aRegulars[$v['config_id']]     = $v;
        }

        return $aRegulars;
    }

    public function getAccountDiscountPromotion ($accountId, $promotionCode, $aPromotion, $productId,
        $billingCycle,
        $aCycles,
        $unitPrice,
        $priceSetup
        )
    {
        $db             = hbm_db();

        $promotionDiscount  = 0;

        if (! $promotionCode || ! $aPromotion['value'] || ! $aPromotion['products']) {
            return $promotionDiscount;
        }

        $aProducts      = explode('|', $aPromotion['products']);

        /* --- promotion ครอบคลุม product --- */
        if ($aPromotion['products'] != 'all' && ! in_array($productId, $aProducts)) {
            return $promotionDiscount;
        }

        // [XXX]  Promotion ครอบคลุมเฉพาะ recuring (ไม่น่าจะรวม free once)
        /* --- promotion ครอบคลุม cycle --- */
        if ($billingCycle == 'Free' || $billingCycle == 'One Time' || $billingCycle == ''
            || ($aPromotion['cycles'] != 'all' && ! in_array($billingCycle, $aCycles))) {
            return $promotionDiscount;
        }

        if ($aPromotion['applyto'] == 'price') {
            $productPrice   = $unitPrice;
        } else if ($aPromotion['applyto'] == 'setupfee') {
            $productPrice   = $priceSetup;
        } else{
            $productPrice   = $unitPrice + $priceSetup;
        }

        if ($aPromotion['type'] == 'fixed') {
            $promotionDiscount  = ($aPromotion['value'] > $productPrice) ? $productPrice : $aPromotion['value'];

        } else if ($aPromotion['type'] == 'percent') {
            $promotionDiscount  = $productPrice * ($aPromotion['value'] / 100);

        }

        return $promotionDiscount;
    }

    public function addAccountDiscountNote ($accountId, $discountNote)
    {
        $db             = hbm_db();

        $result     = $db->query("
            SELECT
                n.id
            FROM
                hb_notes n
            WHERE
                n.rel_id = :accountId
                AND n.type = 'account'
                AND n.is_discount_note = '1'
                AND n.rel_id_ext = '0'
            ", array(
                ':accountId'     => $accountId
            ))->fetch();
        if (! isset($result['id']) && $discountNote) {
            $db->query("
                INSERT INTO hb_notes (
                    `date`, type, rel_id, admin_id, note, is_discount_note
                ) VALUES (
                    :addDate, 'account', :accountId, '1', :note, '1'
                )
                ", array(
                    ':addDate'      => date('Y-m-d H:i:s'),
                    ':accountId'    => $accountId,
                    ':note'         => $discountNote
                ));
        }

    }

}