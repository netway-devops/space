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
                if (preg_match('/dateformat\:\$date\_format/', $k2)) {
                    $k2     = preg_replace('/dateformat\:\$date\_format/', 'date_format:\'%d %b %Y\'', $k2);
                    $aVariables[$k][$k2]    = $v2;
                } else {
                    $aVariables[$k][$k2]    = $v2;
                }
            }
            //echo '<pre>'.print_r($v2, true).'</pre>';
        }
    }
    
    // Fix Domain IDN (Puttipong Pengprakhon)
    if (isset($aVariables['service']['domainidn']) && $aVariables['service']['domainidn'] != '') {
    } else {
        // Ref: http://wiki.hostbillapp.com/index.php?title=Forms:_Accessing_Forms_elements_in_email_templates
        $aVariables['service']['domainidn'] = 'Domain Name IDN';
    }
    
    // ใช้ไม่ได้แล้วเพราะ hostbill validate variable
    //$this->assign('variables', $aVariables);
}
