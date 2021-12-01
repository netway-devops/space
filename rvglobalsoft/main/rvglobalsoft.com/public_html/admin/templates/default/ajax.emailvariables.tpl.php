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
$aVariables     = $this->get_template_vars('variables');
// --- Get template variable ---

if (count($aVariables)) {
    $tmp        = $aVariables;
    foreach ($tmp as $k => $v) {
        if (is_array($v) && count($v)) {
            $aVariables[$k]     = array();
            foreach ($v as $k2 => $v2) {
                
                    $aVariables[$k][$k2]    = $v2;
                
            }
            //echo '<pre>'.print_r($k2, true).'</pre>';
        }
    }
    $this->assign('variables', $aVariables);
}
