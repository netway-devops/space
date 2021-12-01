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
// --- Get template variable ---


$currentSlug    = $aCategories[$currentCat]['slug'];
$this->assign('currentSlug', $currentSlug);

// --- reset a cart ---
if ($step < 3) {
    $_SESSION['aCart']      = array();
}

//echo '<pre>'. print_r($_GET, true) .'</pre>';