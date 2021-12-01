<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
//$aSubmit          = $this->get_template_vars('submit');
$isAjaxLogin        = isset($_GET['isAjaxLogin']) ? $_GET['isAjaxLogin'] : '';
$isReloadContent    = isset($_GET['isReloadContent']) ? $_GET['isReloadContent'] : '';
// --- Get template variable ---



$this->assign('isAjaxLogin', $isAjaxLogin);
$this->assign('isReloadContent', $isReloadContent);
