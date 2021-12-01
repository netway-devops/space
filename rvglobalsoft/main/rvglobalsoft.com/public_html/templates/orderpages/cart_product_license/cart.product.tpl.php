<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/productlicensehandle/user/class.productlicensehandle_controller.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$step       = $this->get_template_vars('step');
$product    = isset($_GET['product']) ? $_GET['product'] : ''; 
// --- Get template variable ---

if (! $product) {
    $product    = productlicensehandle_controller::singleton()->currentProduct(array());
}

$this->assign('product', $product);

$aProducts   = productlicensehandle_controller::singleton()->listProduct(array());
$this->assign('aProducts', $aProducts);

/* --- find product name --- */
foreach ($aProducts as $k => $arr) {
    foreach ($arr as $k2 => $arr2) {
        if ($k2 == $product) {
            $this->assign('productName', $arr2['name']);
            break 2;
        }
    }
}

/* --- addtional product --- */
if (isset($aProducts[$product]['additional']) && count($aProducts[$product]['additional'])) {
    $aAdditional    = array();
    $aAdditionals   = $aProducts['Additional Product'];
    foreach ($aProducts[$product]['additional'] as $v) {
        $aAdditional[$v]    = $aAdditionals[$v];
    }
    
    $this->assign('aAdditional', $aAdditional);
}

/* --- control panel product --- */
if (isset($aProducts[$product]['controlpanel']) && count($aProducts[$product]['controlpanel'])) {
    $aControlPanel    = array();
    $aAdditionals   = $aProducts['Control Panel'];
    foreach ($aProducts[$product]['controlpanel'] as $v) {
        $aControlPanel[$v]    = $aAdditionals[$v];
    }
    
    $this->assign('aControlPanel', $aControlPanel);
}

// echo '<pre>'. print_r($_SESSION, true) .'</pre>';exit;


