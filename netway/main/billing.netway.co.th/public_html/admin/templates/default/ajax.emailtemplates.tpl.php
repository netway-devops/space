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
$aEmail     = $this->get_template_vars('email');
// --- Get template variable ---

$isMultilanguage    = is_array($aEmail['language_id']) ? 1 : 0;
$this->assign('isMultilanguage', $isMultilanguage);

//echo '<pre>'.print_r($aEmail,true).'</pre>';
