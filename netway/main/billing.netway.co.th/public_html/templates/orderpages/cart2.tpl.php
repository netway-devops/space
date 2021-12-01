<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'punycode.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aClient    = hbm_logged_client();
$aAdmin     = hbm_logged_admin();
// --- hostbill helper ---


// --- Get template variable ---
$aCartContents      = $this->get_template_vars('cart_contents');
$aFields            = $this->get_template_vars('fields');
$aContacts          = $this->get_template_vars('contacts');
$aDomains           = $this->get_template_vars('domain');
$aContents          = $this->get_template_vars('contents');
//echo '<pre>'.print_r($aCartContents,true).'</pre>';
// --- Get template variable ---


if (isset($aAdmin['email']) && $aAdmin['email'] == 'prasit@netway.co.th') {

}

$isDomainContactForm    = true;
$this->assign('isDomainContactForm', $isDomainContactForm);

$configBusinessName     = ConfigCustom::singleton()->getValue('BusinessName');
$this->assign('configBusinessName', $configBusinessName);

$nwTechnicalContact     = ConfigCustom::singleton()->getValue('nwTechnicalContact');
$this->assign('nwTechnicalContact', $nwTechnicalContact);

$this->assign('rvcustomtemplate', APPDIR_MODULES . 'Other/netway_common/templates/domain/user/cart2.tpl');

if (isset($aCartContents[0]) && count($aCartContents[0])) {
    $this->assign('isOrderAccount', 1);
}

/* --- domain $aCartContents[2] ---*/
if (isset($aCartContents[2]) && count($aCartContents[2])) {
    foreach ($aCartContents[2] as $k => $aDomain) {
        
        /* --- preset --- */
        if (! isset($aDomain['extended']) || ! $aDomain['extended']) {
            if (is_array($aContacts) && count($aContacts)) {
                $aCartContents[2][$k]['extended']   = array(
                    'registrant'    => $aContacts[(count($aContacts)-1)]['id']
                );
            } else {
                $aCartContents[2][$k]['extended']   = array(
                    'registrant'    => array('country' => 'TH')
                );
            }
        }
        /* --- preset --- */
        
        if (! isset($aFields['contacts'])) {
            $aFields['contacts']    = array();
            $registrantContact      = md5(serialize($aCartContents[2][$k]['extended']['registrant']));
            
            $adminContact           = isset($aCartContents[2][$k]['extended']['admin']) 
                                        ? md5(serialize($aCartContents[2][$k]['extended']['admin'])) : '';
            if ($adminContact && $adminContact != $registrantContact) {
                $aFields['contacts']['admin']    = $aCartContents[2][$k]['extended']['admin'];
            }
            
            $billingContact         = isset($aCartContents[2][$k]['extended']['billing']) 
                                        ? md5(serialize($aCartContents[2][$k]['extended']['billing'])) : '';
            if ($billingContact && $billingContact != $registrantContact) {
                $aFields['contacts']['billing']    = $aCartContents[2][$k]['extended']['billing'];
            }
            
        }
        
    }
}


$this->assign('cart_contents', $aCartContents);
$this->assign('fields', $aFields);


/* --- แสดงส่วนลด --- */
if (count($aDomains)) {
    $aDomain_tmp        = $aDomains;
    
    foreach ($aDomain_tmp as $k => $aDom) {
        $aPeriods   = $aDom['product']['periods'];
        $action     = $aDom['action']; // register renew transfer
        
        if (isset($aPeriods) && count($aPeriods)) {
            $basePrice  = 0;
            
            foreach ($aPeriods as $k2 => $aPeri) {
                if ($aPeri['period'] == 1) {
                    $basePrice  = $aPeri[$action];
                    $aDomains[$k]['product']['periods'][$k2]['price']       = $basePrice;
                } else {
                    $discount   = ($basePrice * $aPeri['period']) - $aPeri[$action];
                    if ($discount > 0) {
                        $aDomains[$k]['product']['periods'][$k2]['netprice']    = $aPeri[$action];
                    } else {
                        $aDomains[$k]['product']['periods'][$k2]['price']       = $aPeri[$action];
                    }
                    $aDomains[$k]['product']['periods'][$k2]['discount']    = $discount;
                }
            }
            
        }
    }
    
    $this->assign('aDomains', $aDomains);
}

/* --- แสดงรายชื่อ product ที่เกี่ยวข้องกับ domain --- */
$nwDomainOnestepRecommend   = ConfigCustom::singleton()->getValue('nwDomainOnestepRecommend');
$aRecommend                 = explode(',', $nwDomainOnestepRecommend);

if (count($aRecommend)) {
    
    $result         = $db->query("
                SELECT
                    p.id, p.name, p.description,
                    c.m, c.a
                FROM
                    hb_products p
                    LEFT JOIN hb_common c 
                        ON c.id = p.id
                        AND c.rel = 'Product'
                        AND c.paytype = 'Regular'
                WHERE
                    p.id IN (". implode(',', $aRecommend).")
                ORDER BY p.category_id ASC, p.sort_order ASC
                ")->fetchAll(); // , find_in_set(p.id, '". implode(',', $aRecommend)."')
    $result_tmp     = $result;
    $aProductCompare        = array();
    foreach ($result_tmp as $arr) {
        $aProductCompare[$arr['id']]    = $arr;
    }
    $this->assign('aProductCompare', $aProductCompare);
    
    $aProductRecommend      = array();
    $recommend              = '';
    $aCompare               = array();
    foreach ($result_tmp as $k => $arr) {
        if (preg_match('/Linux/i', $arr['name']) && $recommend != 'Linux') {
            array_push($aProductRecommend, array(
                'name'      => 'Linux'
                ));
            $recommend      = 'Linux';
        }
        if (preg_match('/Windows/i', $arr['name']) && $recommend != 'Windows') {
            $aList          = array();
            if (count($aCompare)) {
                foreach ($aCompare as $k1) {
                    array_push($aList, $aProductCompare[$k1]);
                }
            }
            array_push($aProductRecommend, array(
                'name'      => 'compare',
                'ids'       => $aCompare,
                'lists'     => $aList
                ));
            $aCompare       = array();
            
            array_push($aProductRecommend, array(
                'name'      => 'Windows'
                ));
            $recommend      = 'Windows';
        }
        
        array_push($aProductRecommend, $arr);
        array_push($aCompare, $arr['id']);
        
    }

    $aList          = array();
    if (count($aCompare)) {
        foreach ($aCompare as $k1) {
            array_push($aList, $aProductCompare[$k1]);
        }
    }
    array_push($aProductRecommend, array(
        'name'      => 'compare',
        'ids'       => $aCompare,
        'lists'     => $aList
        ));

    $idx                = count ($aProductRecommend);
    $aProductRecommend[$idx]['name']        = 'Google Apps';
    $idx++;
    $aProductRecommend[$idx]['id']          = 'GApps';
    $aProductRecommend[$idx]['name']        = 'Free Google Apps 1 month';
    $aProductRecommend[$idx]['m']           = 0;
    $aProductRecommend[$idx]['a']           = 0;

    $this->assign('aProductRecommend', $aProductRecommend);
    
    /* --- google apps is checked --- */
    if (isset($_SESSION['Cart'][0])) {
        foreach ($_SESSION['Cart'][0] as $k => $arr) {
            if ($arr['withGoogelApps']) {
                $this->assign('withGoogelApps', 1);
                break;
            }
        }
    }
    
}

/* --- เลือก product ให้เลย --- */
$this->assign('currentAccountSelected', (isset($_SESSION['Cart'][1]['id']) ? $_SESSION['Cart'][1]['id'] : 0));

if (count($aContacts)) {
    $aIsDomainContact   = GeneralCustom::singleton()->listDomainContactId($aContacts);
    $this->assign('aIsDomainContact', $aIsDomainContact);
}

/* --- ถ้ามีการสั่งซื้อ IDN Domain ให้ไส่ภาษาไทยใน custum field --- */
$aIDNAutofill           = array();
if (isset($aCartContents[2]) && count($aCartContents[2])) {
    
    foreach ($aCartContents[2] as $k => $arr) {
        if (! preg_match('/^xn\-\-/', $arr['name'])) {
            continue;
        }
        
        $result         = $db->query("
                SELECT
                    cic.id
                FROM
                    hb_config_items_cat cic
                WHERE
                    cic.product_id = :productId
                    AND cic.variable = 'domainidn'
                ", array(
                    ':productId'    => $arr['tld_id']
                ))->fetch();
        
        if (isset($result['id'])) {
            $aIDNAutofill[$result['id'] .'_1']     = Punycode::decode($arr['sld']) . $arr['tld'];
        }
        
    }
}
$this->assign('aIDNAutofill', $aIDNAutofill);

// หา product o365
$o365         = $db->query("
        SELECT 
            *
        FROM
            hb_products p
        WHERE
            p.category_id = 54
            AND p.id IN (677 , 682 , 684 , 696 , 707 , 708 , 709 , 710 , 712 , 714 , 724)
            AND p.visible = 1
        ORDER BY p.id
        ")->fetchAll();

 $this->assign('aO365', $o365);

//echo '<pre>'. print_r($aCartContents, true) .'</pre>';