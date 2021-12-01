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
$aSubmit           = $this->get_template_vars('submit');
// --- Get template variable ---

$mailingAddress    = preg_match('/ชื่อผู้รับ\:(.*)ที่อยู่\:(.*)จังหวัด\:(.*)รหัสไปรษณีย์\:(.*)/ism', $aSubmit['mailingaddress'], $matches);
$this->assign('isMailingAddress',  (isset($matches[0]) && trim($matches[0])) ? true : false);
$this->assign('mAddrPerson',       isset($matches[1]) ? trim($matches[1]) : '');
$this->assign('mAddrAddress',      isset($matches[2]) ? trim($matches[2]) : '');
$this->assign('mAddrProvince',     isset($matches[3]) ? trim($matches[3]) : '');
$this->assign('mAddrZipcode',      isset($matches[4]) ? trim($matches[4]) : '');

/* --- set company type เป็น default --- */
if ( !isset($aSubmit['type'])) {
    $aSubmit['type']    = 'Company';
    $this->assign('submit', $aSubmit);
}