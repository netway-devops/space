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
// --- Get template variable ---

// /www2.rvskin.com/public_html/app/Controller/HomeController.php
$f_chlog = @file("/home/rvglobal/public_html/rvchangelog/whmcs_resellerbilling_changelog.txt");
$aLog = array();
for($i=0;$i<count($f_chlog);$i++){
    array_push($aLog,$f_chlog[$i]);
}
$this->assign('aLog',$aLog);

//$this->assign('isAjaxLogin', $isAjaxLogin);
