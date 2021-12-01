<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}
// --- Get template variable ---
$widget       = $this->get_template_vars('widget');
// --- Get template variable ---
if($widget['name']){
    $descriptionFunctionName = 'desc_'.$widget['name'].'_widget';
    $this->assign('descFunctionName', $descriptionFunctionName);
}