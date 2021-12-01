<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$step           = $this->get_template_vars('step');
$currentCat     = $this->get_template_vars('current_cat');
$aCategories    = $this->get_template_vars('categories');
$product        = isset($_GET['product']) ? $_GET['product'] : ''; 
$info           = isset($_GET['info']) ? $_GET['info'] : '';
// --- Get template variable ---


$currentSlug    = $aCategories[$currentCat]['slug'];
$this->assign('currentSlug', $currentSlug);
$this->assign('product', $product);
$this->assign('info', $info);

//echo '<pre>'. print_r($_GET, true) .'</pre>';