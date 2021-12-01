<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : null;
// --- hostbill helper ---


// --- Get template variable ---
$aSubmit        = $this->get_template_vars('submit');
$aPrivilages    = $this->get_template_vars('privilages');
$aDomains       = $this->get_template_vars('domains');
$aServices      = $this->get_template_vars('services');
// --- Get template variable ---

$this->assign('oClient', $oClient);

if (count($aServices)) {
    $aServiceCategory       = array();
    
    foreach ($aServices as $k => $arr) {
        if (! isset($aServiceCategory[$arr['catname']])) {
            $aServiceCategory[$arr['catname']]  = array();
        }
        $aServiceCategory[$arr['catname']][$arr['id']]  = $k;
        
    }
    
    $this->assign('aServiceCategory', $aServiceCategory);
}

//echo '<pre>'.print_r($aDomains, true).'</pre>';