<?php
require_once(APPDIR .'class.cache.extend.php');
include_once(APPDIR . "libs/azureapi/AzureApi.php");
include_once(APPDIR . "libs/hbapiwrapper/hbApiWrapper.php");
include_once(APPDIR_MODULES . "Other/o365_management/include/class.common_hb_controller.php");

include_once(APPDIR_MODULES . "Hosting/o365/include/class.o365_license_offermatrix.php");

class o365_management_controller extends AzurePartnerCenterManagementCommonHBController {
    private static  $instance;
    private $aMSPartnerCenterData = array();
    private $aOfferNoneHbProduct = array();
    private $aProducts = array();
    private $aAccounts = array();

    private $leftMenus = array(
        array('id' => 'pricingandoffers', 'name' => 'Pricing and offers'),
        array('id' => 'viewHBProducts', 'name' => 'HB Products Mapping'),
        array('id' => 'viewHBAccounts', 'name' => 'HB Accounts Mapping'),
        array('id' => 'viewNoneHBProducts', 'name' => 'Can\'t mapping to HB Products'),
        array('id' => 'viewNoneHBAccounts', 'name' => 'Can\'t mapping to HB Accounts'),
    );

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

    public function beforeCall ($request)
    {
        try {
            $this->db = hbm_db();
            //$this->aProducts = $this->getHbO365Products();
            //$this->aHbO365Accounts = $this->getHbO365Accounts();
            
            $this->template->assign('aLeftMenus', $this->leftMenus);
            $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
            $this->template->assign('tplClientPath', MAINDIR . 'templates/');
            
            $string = file_get_contents(APPDIR_MODULES . "Other/o365_management/data/export_ms_partner_center_data.json");
            $this->aMSPartnerCenterData = json_decode($string, true);
            $this->template->assign('timestampLastUpdateData', $this->aMSPartnerCenterData['updayeAt']);
            $this->template->assign('totalCustomers', (int) $this->aMSPartnerCenterData['totalCustomers']);
            $this->template->assign('totalSubscription', (int) $this->aMSPartnerCenterData['totalSubscription']);
            $this->template->assign('aMSPartnerCenterData', $this->aMSPartnerCenterData);
            
            
            $this->oLicenseOfferMatrix = new o365LicenseOffermatrix();
            $this->aLicenseOfferMatrix = $this->oLicenseOfferMatrix->getByAllowedCountries(array('Thailand'));
            $this->template->assign('aLicenseOfferMatrix', $this->aLicenseOfferMatrix);
            $this->template->assign('msPricingOn', $this->oLicenseOfferMatrix->getConfig('pricingOn'));
            
            $aServersConf = $this->getServersConf();
            $this->template->assign('hasServersConf', count($aServersConf) > 0 ? true: false);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function _default ($request)
    {
        try {
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }


    public function viewHBProducts($request)
    {
        try {
            $this->aProducts = $this->getHbO365Products();
            $aHBProductsO365 = $this->getHbO365ProductsDetail();
            $this->template->assign('aHBProductsO365', $aHBProductsO365);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/view_hb_products.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function viewHBAccounts($request)
    {
        try {
            $aReports = $this->getReports();
            $aSubscriptionsHasHBAccount = $aReports['hbAccounts'];
            usort($aSubscriptionsHasHBAccount, function ($a, $b) { return ($a['accountInfo']['account_id'] < $b['accountInfo']['account_id']) ? -1 : 1; });
            $this->template->assign('aSubscriptionsHasHBAccount',  $aSubscriptionsHasHBAccount);
            $this->template->assign('totalAccounts',  count($aSubscriptionsHasHBAccount));
            //$this->template->assign('aDebug', $aSubscriptionsHasHBAccount);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/view_hb_accouints.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function viewNoneHBProducts($request)
    {
        try {
            $aOfferNoneHbProduct = $this->getOfferNoneHbProduct();
            usort($aOfferNoneHbProduct, function ($a, $b) { return strnatcmp($a['offerName'], $b['offerName']); });
            $this->template->assign('aOfferNoneHbProduct', $aOfferNoneHbProduct); 
            
            $aReports = $this->getReports();
            $this->template->assign('aSubscriptionsNoneHBProduct', $aReports['noneHBProducts']);
            
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/view_none_hb_products.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function viewNoneHBAccounts($request)
    {
        try {
            $aReports = $this->getReports();
            $aSubscriptionsNoneHBAccount = $aReports['noneHBAccounts'];
            usort($aSubscriptionsNoneHBAccount, function ($a, $b) { return strnatcmp($a['domain'], $b['domain']); });
            $this->template->assign('totalAccounts',  count($aSubscriptionsNoneHBAccount));
            $this->template->assign('aSubscriptionsNoneHBAccount', $aSubscriptionsNoneHBAccount);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/view_none_hb_accouints.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }


    public function getHbO365Products()
    {
        try {
            if (count($this->aProducts) >= 0) {
                $this->aProducts = $this->db->query("
                    SELECT
                        p.id AS product_id, p.name AS product_name, c.name AS product_cat
                    FROM
                        hb_modules_configuration AS mc,
                        hb_products AS p,
                        hb_products_modules AS pm,
                        hb_categories AS c
                    WHERE
                        mc.module = :moduleName
                        AND mc.id = pm.module
                        AND pm.product_id = p.id
                        AND p.category_id = c.id
                ", array(
                    ':moduleName'        => 'o365'
                ))->fetchAll();
            }
            return $this->aProducts;
        } catch (Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function getAccountConfig($accountID)
    {
        try {
            return $this->db->query("
                SELECT
                    f.name , f.variable , ac.data
                FROM 
                    hb_accounts acc
                INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
                INNER JOIN hb_products p ON (acc.product_id = p.id)
                WHERE 
                acc.id = :account_id
            ", array(
                ':account_id'	=>	$accountID
            ))->fetchAll();
        } catch (Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function getHbO365Accounts()
    {
        try {
            if (count($this->aAccounts) <= 0) {
                $aProducts = $this->getHbO365Products();
                $aPruductsID = array();
                $products = '0';
                foreach ($aProducts as $item) {
                    $products   .= '\',\''. $item['product_id'];
                }
                $aAccounts = $this->db->query("
                    SELECT
                        ac.id AS account_id, ac.product_id AS product_id, ac.domain AS domain, ac.billingcycle AS billingCycle, ac.status AS status
                    FROM
                        hb_products AS p,
                        hb_accounts as ac
                    WHERE
                        p.id IN ('{$products}')
                        AND p.id = ac.product_id
                        AND ac.status IN ('Active', 'Pending')
                    
                ")->fetchAll();
                foreach ($aAccounts as $index => $item) {
                    $aAccounts[$index]['configs'] = $this->getAccountConfig($item['account_id']);
                }
                $this->aAccounts = $aAccounts;
            }
            return $this->aAccounts;
        } catch (Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function getHbO365ProductsDetail($groupByMsOfferID=false)
    {
        try {
            if (count($this->aHBProductsO365) <= 0 || count($this->aGroupByMsOfferID) <= 0 ) {

                $aHBProductsO365 = array();
                $aGroupByMsOfferID = array();
                $_aHBProductsO365 = $this->getHbO365Products();

                foreach ($_aHBProductsO365 as $index => $item) {
                    $aProductDetails = array();
                    
                    $resultProductDetails =  $this->hbApi()->getProductDetails(array('id' => $item['product_id']));
                    $aProductDetails = array();
                    if (isset($resultProductDetails['product'])) {
                        $aProductDetails = $resultProductDetails['product'];
                    }

                    $resultProductConfigItemsCat = $this->hbApi()->getConfigItemsCatByProductID( $item['product_id']);
                    $aProductConfigItemsCat = array();
                    if (isset($resultProductConfigItemsCat['config_items_cat'])) {
                        $aProductConfigItemsCat = $resultProductConfigItemsCat['config_items_cat'];
                    }

                    $haveConfigMsID = false;
                    $haveConfigSubID = false;
                    foreach ($aProductConfigItemsCat as $value) {
                        if ($value['variable'] == 'microsoft_id') {
                            $haveConfigMsID = true;
                        }
                        if ($value['variable'] == 'subscription_id') {
                            $haveConfigSubID = true;
                        }
                    }
                    $configItemsWarningMsg = '';
                    if (!$haveConfigMsID || !$haveConfigSubID) {
                        if (!$haveConfigMsID) {
                            $configItemsWarningMsg .= 'Microsoft ID';
                            if (!$haveConfigSubID) {
                                $configItemsWarningMsg .= ', ';
                            }
                        }
                        if (!$haveConfigSubID) {
                            $configItemsWarningMsg .= 'Subscription ID';
                        }
                    }

                    if (count($aProductDetails) > 0) {
                        $aHBProductsO365[$item['product_id']] = $item;
                        $aHBProductsO365[$item['product_id']]['link2msOffer'] = (isset($aProductDetails['options']['ms_offer_id'])) 
                            ? true 
                            : false;

                        if (isset($aProductDetails['options']['ms_offer_id'])) {
                            $aHBProductsO365[$item['product_id']]['offerName'] = $this->oLicenseOfferMatrix->getOfferDetailsByDurableOfferID($aProductDetails['options']['ms_offer_id'])['Offer Display Name'];
                            $aHBProductsO365[$item['product_id']]['offerPriceDetails'] =  $this->oLicenseOfferMatrix->getPriceDetailsByDurableOfferID($aProductDetails['options']['ms_offer_id']);
                        }

                        
                        $aHBProductsO365[$item['product_id']]['options']  = $aProductDetails['options'];
                        $aHBProductsO365[$item['product_id']]['warning']  = $configItemsWarningMsg;
                        $ahbBillingCycle = $this->_getBillingCycle($aProductDetails);

                        $aHBProductsO365[$item['product_id']]['prices'] = array();
                        foreach ($ahbBillingCycle as $aValue) {
                             $aHBProductsO365[$item['product_id']]['prices'][strtolower($aValue['billing Type'])] = $aValue['price'];
                        }
                        
                        if ($aHBProductsO365[$item['product_id']]['link2msOffer']) {
                            $msOfferId = $aProductDetails['options']['ms_offer_id'];
                            if (empty($aGroupByMsOfferID[$msOfferId])) {
                                $aGroupByMsOfferID[$msOfferId] = array(
                                    'offerId' => $msOfferId,
                                    'hbProduct' => array()
                                );
                            }

                            foreach ($ahbBillingCycle as $aValue) {
                                $_hbBillingCycle = ucfirst(strtolower($aValue['billing Type']));

                                if (empty($aGroupByMsOfferID[$msOfferId]['hbProduct'][$_hbBillingCycle])) {
                                    $aGroupByMsOfferID[$msOfferId]['hbProduct'][$_hbBillingCycle] = array();
                                }
                                array_push($aGroupByMsOfferID[$msOfferId]['hbProduct'][$_hbBillingCycle], array(
                                    'id' => $item['product_id'],
                                    'product_name' => $item['product_name'],
                                    'product_cat' => $item['product_cat'],
                                    'billingCycle' => $aValue['billing Type'],
                                    'price' => $aValue['price']
                                ));
                            }
                        }
                    }
                }
                $this->aHBProductsO365 = $aHBProductsO365;
                $this->aGroupByMsOfferID = $aGroupByMsOfferID;

            }

            return ($groupByMsOfferID) 
                ? $this->aGroupByMsOfferID
                : $this->aHBProductsO365;
        } catch (Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    
    private function checkProductWithMsCycleType($offerId, $billingCycle)
    {
        $aHbO365ProductsGroupByMsOfferID = $this->getHbO365ProductsDetail(true);
        $result = false;
        $billingCycle = ucfirst(strtolower($billingCycle));
        if (isset($aHbO365ProductsGroupByMsOfferID[$offerId]['hbProduct'][$billingCycle])) {
            $result = true;
        } else {
            $aHbCycleSupport = $this->getHbBillingCycleySupport($billingCycle);
            foreach ($aHbCycleSupport as $value) {
                $hbBillingCycle = ucfirst(strtolower($value));
                if (isset($aHbO365ProductsGroupByMsOfferID[$offerId]['hbProduct'][$hbBillingCycle])) {
                    $result = true;
                    break;
                }
            }
        }
        return $result;
    }

    public function getOfferNoneHbProduct()
    {
        try {
            if (count($this->aOfferNoneHbProduct) <= 0 ) {
                $aOfferNoneHbProduct = array();
                //$aHbO365ProductsGroupByMsOfferID = $this->getHbO365ProductsDetail(true);     
                $aMsPartnerCenterData = $this->getExportMsPartnerCenterData();

                foreach ($aMsPartnerCenterData['customers'] as $customerID => $item) {
                    if (count($item['subsctiptions']) > 0) {
                        foreach ($item['subsctiptions'] as $subItem) {
                            $offerId = $subItem['offerId'];
                            $offerName = $subItem['offerName'];
                            if (trim($offerName) == '') {
                                continue;
                            }
                            $billingCycle = ucfirst(strtolower($subItem['billingCycle']));

                            if (!$this->checkProductWithMsCycleType($offerId, $billingCycle )) {
                                if (empty($aOfferNoneHbProduct[$offerId])) {
                                    $aOfferNoneHbProduct[$offerId] = array(
                                        'offerId' => $offerId,
                                        'offerName' => $offerName,
                                        'billingCycle' => array()
                                    );
                                }
                                if (empty($aOfferNoneHbProduct[$offerId]['billingCycle'][$billingCycle])) {
                                    $aOfferNoneHbProduct[$offerId]['billingCycle'][$billingCycle] = 1;
                                } else {
                                    $aOfferNoneHbProduct[$offerId]['billingCycle'][$billingCycle] += 1;
                                }
                            }
                        }
                    }
                }
                $this->aOfferNoneHbProduct = $aOfferNoneHbProduct;
            } 
            return $this->aOfferNoneHbProduct;
        } catch (Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function todoReports_act($request)
    {
        try {            
            $aReports = $this->getReports();
            $this->template->assign('aSubscriptionsNoneHBProduct', $aReports['noneHBProducts']);
            $this->template->assign('aSubscriptionsNoneHBAccount', $aReports['noneHBAccounts']);
            $this->template->assign('aSubscriptionsHasHBAccount',  $aReports['hbAccounts']);
            
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/reports.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }

    public function pricingandoffers($request)
    {
        try {
            $aOfferPricingList = array();            
            $aHBProductsGroupByMsOfferID = $this->getHbO365ProductsDetail(true);

            foreach ($this->aLicenseOfferMatrix as $key => $aValue) {
                $aPricing = $this->oLicenseOfferMatrix->getPriceDetailsByDurableOfferID($aValue['Durable Offer ID']);
                $aNewBillingFrequency = array();
                $aHBProductsPrice = array();
                if (isset($aHBProductsGroupByMsOfferID[trim(strtolower($aValue['Durable Offer ID']))])) {
                    $aHBProductsPrice = $aHBProductsGroupByMsOfferID[trim(strtolower($aValue['Durable Offer ID']))]['hbProduct'];
                }

                foreach ($aValue['Billing Frequency'] as $vIndex => $name) {
                    array_push($aNewBillingFrequency, array(
                        'Billing Cycle' => $name,
                        'HostbillProducts' => isset($aHBProductsPrice[$name]) ? $aHBProductsPrice[$name]: array()
                    ));
                    if (isset($aHBProductsPrice[$name])) {
                        unset($aHBProductsPrice[$name]);
                    }
                }

                if (count($aHBProductsPrice) > 0) {
                    foreach ($aHBProductsPrice as $key => $value) {
                        array_push($aNewBillingFrequency, array(
                            'Billing Cycle' => $key,
                            'HostbillProducts' => $value
                        ));
                    }
                }

                $aValue['Billing Frequency'] = $aNewBillingFrequency;
                $aValue['Pricing'] = $aPricing;
                array_push($aOfferPricingList, $aValue);
            }

            usort($aOfferPricingList, function ($a, $b) { return strnatcmp($a['Offer Display Name'], $b['Offer Display Name']); });
            $this->template->assign('aOfferPricingList', $aOfferPricingList);
            $this->template->assign('skipDisplayLateUpdateData', true);
            
            //$this->template->assign('aDebug', $aOfferPricingList);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/pricingandoffers.tpl',array(), true);
        } catch (Exception $error) {
            $this->addError($error->getMessage());
            return false;
        }
    }


    private function getHbBillingCycleySupport($msBillingCycle)
    {
        if (strtolower($msBillingCycle) == 'annually') {
            return  array('free', 'annually', 'biennially', 'triennial', 'quadrennially', 'quinquennially');
        } else if (strtolower($msBillingCycle) == 'monthly') {
            return array('free', 'weekly', 'daily', 'monthly', 'quarterly', 'semi-annually');
        } else {
            return  array('free');
        }
    }

    public function compareBillingCycle($hbBillingCycle, $msBillingCycle)
    {
        $hbBillingCycle = strtolower($hbBillingCycle);
        $msBillingCycle = strtolower($msBillingCycle);

        if ($msBillingCycle == 'none' && in_array($hbBillingCycle, $this->getHbBillingCycleySupport('none'))) {
            return true;
        } else if ($msBillingCycle == 'monthly' && in_array($hbBillingCycle, $this->getHbBillingCycleySupport('monthly'))) {
            return true;
        } else if ($msBillingCycle == 'annually' && in_array($hbBillingCycle, $this->getHbBillingCycleySupport('annually'))) {
            return true;
        } else {
            return false;
        }

    }

    public function getHbAccountWithMsData($offerId, $customerID, $domain, $subscriptionId, $billingCycle, $hbProductID)
    {
        $aHbO365Accounts = $this->getHbO365Accounts();
        $aHbO365ProductsDetail = $this->getHbO365ProductsDetail();
        $result = array();
        if (isset($aHbO365ProductsDetail[$hbProductID])) {
            $hbMsOfferIDConf = $aHbO365ProductsDetail[$hbProductID]['options']['ms_offer_id'];
            foreach ($aHbO365Accounts as $item) {
                if (trim($item['product_id']) != trim($hbProductID)) {
                    continue;
                } elseif (!$this->compareBillingCycle(trim($item['billingCycle']), trim($billingCycle))) {
                    continue;
                } else {


                /*if (trim($item['billingCycle']) != trim($billingCycle) || trim($item['product_id']) != trim($hbProductID)) {
                    continue;
                }*/

                $microsoftID = null;
                $hbSubscriptionID = null;
                $domain_in_config = null;
                $seatQuantity = '0';

                if (trim(strtolower($item['domain'])) == trim(strtolower($domain))) {
                    $domain_in_config = $domain;
                }
                
                foreach ($item['configs'] as $accConf) {
                    if (trim($accConf['variable']) == 'microsoft_id' && trim($accConf['data']) != '') {
                        $microsoftID = trim(strtolower($accConf['data']));
                        continue;
                    } else if (trim($accConf['variable']) == 'quantity' || trim($accConf['name']) == trim(strtolower('Seat Quantity'))) {
                        $seatQuantity = isset($accConf['qty'])
                                            ? (int) trim($accConf['qty']) 
                                            : isset($accConf['data']) 
                                                ? (int) trim($accConf['data'])
                                                : 0;
                        continue;
                    } else if (trim($accConf['variable']) == 'subscription_id' && trim($accConf['data']) != '') {
                        $hbSubscriptionID = trim($accConf['data']);
                        continue;
                    } else if (
                            is_null($domain_in_config) 
                            && (
                                trim(strtolower($accConf['name'])) == trim(strtolower('Domain Name'))
                                || trim($accConf['variable']) == 'domain_name'
                                && !empty($accConf['data'])
                            )
                        ) {

                        if (trim(strtolower($domain)) == trim(strtolower($accConf['data']))) {
                            $domain_in_config = trim($accConf['data']);
                        }
                        continue;
                    } else if (
                            is_null($domain_in_config) 
                            && (
                                preg_match('/Reseller Portal/', trim($accConf['name']), $match) 
                                && !empty(trim($accConf['data']))
                            )
                        ) {
                        if (trim(strtolower($domain)) == trim(strtolower($accConf['data']))) {
                            $domain_in_config = $accConf['data'];
                        }
                        continue;
                    }
                }

                $item['seatQuantity'] = $seatQuantity;
                $item['warning'] = '';

                if (( $microsoftID != null && trim(strtolower($microsoftID)) == trim(strtolower($customerID)))
                        && ($hbSubscriptionID != null && trim(strtolower($hbSubscriptionID)) == trim(strtolower($subscriptionId)))
                ) {
                    $result = $item;
                    break;
                } else if ($domain_in_config != null && trim(strtolower($domain_in_config)) == trim(strtolower($domain))) {
                    if (!$microsoftID && !$hbSubscriptionID) {
                        $item['warning'] .= 'ไม่ได้ผูก Microsoft ID and Subscription ID.';
                    } else if (!$hbSubscriptionID) {
                        $item['warning'] .= 'ไม่ได้ผูก Subscription ID.';
                    } else if (!$microsoftID) {
                        $item['warning'] .= 'ไม่ได้ผูก Microsoft ID.';
                    }
                    $result = $item;
                    break;
                }
            }
            }
        }
        return count($result) > 0 ? $result : null;
    }

    public function getReports()
    {
        try {
            $aReports = array(
                'noneHBProducts' => array(),
                'noneHBAccounts' => array(),
                'hbAccounts' => array()
            );
            $aMsPartnerCenterData = $this->getExportMsPartnerCenterData();
            $aOfferNoneHbProduct = $this->getOfferNoneHbProduct();
            $aHbO365ProductsGroupByMsOfferID = $this->getHbO365ProductsDetail(true);

            foreach ($aMsPartnerCenterData['customers'] as $cuntomerID => $msItem) {
                $domain = $msItem['domain'];
                $aSubsctiption = isset($msItem['subsctiptions']) ? $msItem['subsctiptions'] : array();


                foreach ($aSubsctiption as $subcItem) {
                    $offerId = $subcItem['offerId'];

                    $offerName = $this->oLicenseOfferMatrix->getOfferDetailsByDurableOfferID($offerId)['Offer Display Name'];

                    $billingCycle = ucfirst(strtolower($subcItem['billingCycle']));
                    $quantity = $subcItem['quantity'];
                    if (isset($aOfferNoneHbProduct[$offerId]['billingCycle'][$billingCycle])) {
                        array_push($aReports['noneHBProducts'], array(
                            'subsctiptions' => $subcItem['subscriptionId'],
                            'cuntomerID' => $cuntomerID,
                            'domain' => $domain,
                            'billingCycle' => $billingCycle,
                            'offerId' => $offerId,
                            'offerName' => $offerName,
                            'quantity' => $quantity,
                            'message' => 'ไม่มี Hostbill Product(s) ที่รองรับ Microsoft Offer: ' . $offerName . ' / '. $offerId,
                            'effectiveStartDate' => date("U",strtotime($subcItem['effectiveStartDate'])),
                            'commitmentEndDate' => date("U",strtotime($subcItem['commitmentEndDate']))
                        ));
                    } else {
                        
                        $hbProductID = isset($aHbO365ProductsGroupByMsOfferID[$offerId]['hbProduct'][trim($billingCycle)][0]['id']) 
                                        ? $aHbO365ProductsGroupByMsOfferID[$offerId]['hbProduct'][trim($billingCycle)][0]['id']
                                        : null;

                        $accountInfo = $this->getHbAccountWithMsData($offerId, $cuntomerID, $domain, $subcItem['subscriptionId'], $billingCycle, $hbProductID);
                                                              
                        if ($accountInfo == null) {
                            array_push($aReports['noneHBAccounts'],  array(
                                'subsctiptions' => $subcItem['subscriptionId'],
                                'cuntomerID' => $cuntomerID,
                                'domain' => $domain,
                                'billingCycle' => $billingCycle,
                                'offerId' => $offerId,
                                'offerName' => $offerName,
                                'hbProductID' => $hbProductID,
                                'quantity' => $quantity,
                                'message' => 'ไม่มี Hostbill account หรือไม่สามารถ link domain กันได้.',
                                'effectiveStartDate' => date("U",strtotime($subcItem['effectiveStartDate'])),
                                'commitmentEndDate' => date("U",strtotime($subcItem['commitmentEndDate']))
                            ));
                        } else {
                            array_push($aReports['hbAccounts'],  array(
                                'subsctiptions' => $subcItem['subscriptionId'],
                                'cuntomerID' => $cuntomerID,
                                'domain' => $domain,
                                'billingCycle' => $billingCycle,
                                'offerId' => $offerId,
                                'offerName' => $offerName,
                                'quantity' => $quantity,
                                'hbProductID' => $hbProductID,
                                'accountInfo' => $accountInfo,
                                'effectiveStartDate' => date("U",strtotime($subcItem['effectiveStartDate'])),
                                'commitmentEndDate' => date("U",strtotime($subcItem['commitmentEndDate']))
                            ));
                        }
                    }
                }
            }

            return $aReports;
        } catch (Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function getExportMsPartnerCenterData() 
    {
        return $this->aMSPartnerCenterData;
    }


    public function customers_mgr($request)
    {
        $aCustomers = array();
        try {
            $aConnectAzurePartnerCenter = $this->connectAzurePartnerCenter();
            foreach ($aConnectAzurePartnerCenter as $conn) {
                array_push($aCustomers, array(
                    'parner_info' => $conn->getPartnerUsagesummary(), 
                    'customers' => $conn->partnerApiGetCustomers()
                ));
            }
            $this->template->assign('aCustomers', $aCustomers);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/customers.tpl',array(), true);
        } catch (Exception $ex) {

            $this->addError($ex->getMessage());
            return false;
        }
    }

    public function invoices_mgr($request)
    {
        $aInvoices = array();
        try {
            $aServersConf = $this->_getServersConf();
            foreach ($aServersConf as $conf) {
                $oAzureApi = new AzureApi($this->azure_resource_url, $conf['host'],  $conf['ip'], $conf['password'], 60);
                array_push($aInvoices, array(
                    'connection' => array(
                        'tenant' => $conf['host'],
                        'app' => $conf['ip'],
                    ),
                    'partner_info' => $oAzureApi->getPartnerUsagesummary(), 
                    'invoices' => $oAzureApi->partnerApiGetInvoices()
                ));
            }
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
        $this->template->assign('aInvoices', $aInvoices);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/invoices.tpl',array(), true);
    }

    public function invoice_detail_mgr($request)
    {
        try {
            if (empty($request['invoice_id'])) {
                throw new Exception('Azure invoice id is empty!!');
            }
            $aServersConf = $this->_getServersConf();
            $oAzureApi = null;
            foreach ($aServersConf as $conf) {
                if ($conf['host'] == $request['tenant'] && $conf['ip'] == $request['app']) {
                    $oAzureApi = new AzureApi($this->azure_resource_url, $conf['host'],  $conf['ip'], $conf['password'], 60);
                    break;
                }
            }
            if (is_null($oAzureApi)) {
                throw new Exception('Hostbill app connection not match!!');
            }
            $this->template->assign('partner_name', $request['partner_name']);
            $this->template->assign('aRequest', $request);

            $aInvoiceDetail = $oAzureApi->partnerApiGetInvoiceDetail($request['invoice_id']);
            $this->template->assign('aSummary', array(
                'id' => $aInvoiceDetail['id'],
                'invoiceDate' => $aInvoiceDetail['invoiceDate'],
                'billingPeriodStartDate' => $aInvoiceDetail['billingPeriodStartDate'],
                'billingPeriodEndDate' => $aInvoiceDetail['billingPeriodEndDate'],
                'totalCharges' => $aInvoiceDetail['totalCharges'],
                'currencyCode' => $aInvoiceDetail['currencyCode'],
                'currencySymbol' => $aInvoiceDetail['currencySymbol'],
                'pdfDownloadLink' => $aInvoiceDetail['pdfDownloadLink'],
                'invoiceDetails' => $aInvoiceDetail['invoiceDetails'],
            ));
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/invoice_detail.tpl',array(), true);
    }

    public function invoice_customers_items_detail_mgr($request)
    {
        try {
            $aServersConf = $this->_getServersConf();
            $oAzureApi = null;
            foreach ($aServersConf as $conf) {
                if ($conf['host'] == $request['tenant'] && $conf['ip'] == $request['app']) {
                    $oAzureApi = new AzureApi($this->azure_resource_url, $conf['host'],  $conf['ip'], $conf['password'], 60);
                    break;
                }
            }
            if (is_null($oAzureApi)) {
                throw new Exception('Hostbill app connection not match!!');
            }
            
            $invoiceItemsDetailData = $oAzureApi->callPartnerApi($request['m'], urldecode($request['u']), array(), json_decode($request['h']));
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', json_decode($invoiceItemsDetailData, true));
            $this->json->show();
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
    }




    public function report_compare_data_mgr($request)
    {
        try {
            $_aHBProductsO365 = $this->db->query("
                SELECT
                    p.id AS product_id, p.name AS product_name, c.name AS product_cat
                FROM
                    hb_modules_configuration AS mc,
                    hb_products AS p,
                    hb_products_modules AS pm,
                    hb_categories AS c
                WHERE
                    mc.module = :moduleName
                    AND mc.id = pm.module
                    AND pm.product_id = p.id
                    AND p.category_id = c.id
            ", array(
				':moduleName'        => 'o365'
            ))->fetchAll();
            
            $aHBProductsO365 = array();
            $aGroupByMsOfferID = array();

            foreach ($_aHBProductsO365 as $index => $item) {
                $aProductDetails = array();
                
                $resultProductDetails =  $this->hbApi()->getProductDetails(array('id' => $item['product_id']));
                $aProductDetails = array();
                if (isset($resultProductDetails['product'])) {
                    $aProductDetails = $resultProductDetails['product'];
                }
                
                if (count($aProductDetails) > 0) {
                    $aHBProductsO365[$item['product_id']] = $item;
                    $aHBProductsO365[$item['product_id']]['link2msOffer'] = (isset($aProductDetails['options']['ms_offer_id'])) ? true : false;
                    $aHBProductsO365[$item['product_id']]['options']  = $aProductDetails['options'];
                    $aHBProductsO365[$item['product_id']]['hbBillingCycle']  = $this->c_baseUnitOfMeasureCode($aProductDetails['baseUnitOfMeasureCode']);

                    $ahbBillingCycle = $this->_getBillingCycle($aProductDetails);

                    switch ($aHBProductsO365[$item['product_id']]['hbBillingCycle']) {
                        case 'Annually': $aHBProductsO365[$item['product_id']]['price'] = $aProductDetails['a']; break;
                        case 'Monthly': $aHBProductsO365[$item['product_id']]['price'] = $aProductDetails['m']; break;
                    }
                    if (trim($aHBProductsO365[$item['product_id']]['hbBillingCycle']) == '') {
                        if ((int) $aProductDetails['a'] > 0) {
                            $aHBProductsO365[$item['product_id']]['price'] = $aProductDetails['a'];
                            $aHBProductsO365[$item['product_id']]['hbBillingCycle'] = 'Annually';
                        } else if ((int) $aProductDetails['m'] > 0) {
                            $aHBProductsO365[$item['product_id']]['price'] = $aProductDetails['m'];
                            $aHBProductsO365[$item['product_id']]['hbBillingCycle'] = 'Monthly';
                        }
                    }

                    if ($aHBProductsO365[$item['product_id']]['link2msOffer']) {
                        list($msOfferName, $msOfferId) = explode(' / ', $aProductDetails['options']['ms_offer_id'], 2);
                        if (!isset($aGroupByMsOfferID[$msOfferId])) {
                            $aGroupByMsOfferID[$msOfferId] = array(
                                'offerId' => $msOfferId,
                                'offerName' => $msOfferName,
                                'hbProduct' => array()
                            );

                        }

                        $_hbBillingCycle = $aHBProductsO365[$item['product_id']]['hbBillingCycle'];
                        if (!isset($aGroupByMsOfferID[$msOfferId][$_hbBillingCycle])) {
                            $aGroupByMsOfferID[$msOfferId]['hbProduct'][$_hbBillingCycle] = array();
                        }
                        array_push($aGroupByMsOfferID[$msOfferId]['hbProduct'][$_hbBillingCycle], array(
                            'id' => $item['product_id'],
                            'billingCycle' => $aHBProductsO365[$item['product_id']]['hbBillingCycle'],
                            'price' => $aHBProductsO365[$item['product_id']]['price']
                        ));
                    }
                }
            }

            $this->template->assign('aHBProductsO365', $aHBProductsO365);

            //$this->template->assign('aDebug', $aGroupByMsOfferID);

            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/report_compare_data.tpl',array(), true);
            //report_compare_data
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return false;
        }
    }

    private function c_baseUnitOfMeasureCode($baseUnitOfMeasureCode) {
        $result = $baseUnitOfMeasureCode;
        switch ($baseUnitOfMeasureCode) {
            case 'YEAR': $result = 'Annually'; break;
            case 'MONTH': $result = 'Monthly'; break;
            default: $result = '$baseUnitOfMeasureCode'; break;
        }
        return $result;
    }

    private function _getBillingCycle($productDetail)
    {
        $aBillingCycle = array();
        if (strtolower($productDetail['paytype']) == 'regular') {
            if ($productDetail['w'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Weekly', 'price' => $productDetail['w']));
            }
            if ($productDetail['d'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Daily', 'price' => $productDetail['d']));
            }
            if ($productDetail['m'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Monthly', 'price' => $productDetail['m']));
            }
            if ($productDetail['q'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Quarterly', 'price' => $productDetail['q']));
            }

            if ($productDetail['s'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Semi-Annually', 'price' => $productDetail['s']));
            }

            if ($productDetail['a'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Annually', 'price' => $productDetail['a']));
            }

            if ($productDetail['b'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Biennially', 'price' => $productDetail['b']));
            }

            if ($productDetail['t'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Triennial', 'price' => $productDetail['t']));
            }

            if ($productDetail['p4'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Quadrennially', 'price' => $productDetail['p4']));
            }

            if ($productDetail['p5'] > 0) {
                array_push($aBillingCycle, array('billing Type' => 'Quinquennially', 'price' => $productDetail['p5']));
            }
        } else if (strtolower($productDetail['paytype']) == 'free') {
            array_push($aBillingCycle, array('billing Type' => 'Free', 'price' => 0));
        }
        return $aBillingCycle;
    }

    public function addError($message) {
        $this->template->assign('message', $message);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/error.tpl',array(), true);
    }
}