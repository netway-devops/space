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
$aDetails       = $this->get_template_vars('details');
$aDetailsFields = $this->get_template_vars('details_fields');
// --- Get template variable ---

/* --- Hosting event เกิดอะไรขึ้นกับ share hosting account นี้บ้าง --- */
$result         = $db->query("
        SELECT 
            COUNT(ae.id) AS total, ae.type
        FROM
            hb_accounts_event ae
        WHERE
            ae.account_id = :accountId
        GROUP BY ae.type
        ", array(
            ':accountId'    => $aDetails['id']
        ))->fetchAll();

$aAccountEvent  = array();
if (count($result)) {
    foreach ($result as $arr) {
        $aAccountEvent[$arr['type']]    = $arr['total'];
    }
}
$aAccountEvent['DiskSpace']     = isset($aAccountEvent['Disk Space']) ? $aAccountEvent['Disk Space'] : 0;
$aAccountEvent['Banwidth']      = isset($aAccountEvent['Banwidth']) ? $aAccountEvent['Banwidth'] : 0;
$aAccountEvent['Spam']          = isset($aAccountEvent['Spam']) ? $aAccountEvent['Spam'] : 0;
$aAccountEvent['Overload']      = isset($aAccountEvent['Overload']) ? $aAccountEvent['Overload'] : 0;
$aAccountEvent['Other']         = $aAccountEvent['Spam'] + $aAccountEvent['Overload'];
$this->assign('aAccountEvent', $aAccountEvent);

/* --- บาง product มีการเปลี่ยนค่า component form ทำให้ไม่แสดง Hostname ใน account detail --- */
$aDetailsFields_        = $aDetailsFields;
if (is_array($aDetailsFields_) && count($aDetailsFields_)) {
    $isDomain           = false;
    foreach ($aDetailsFields_ as $arr) {
        if (isset($arr['name']) && $arr['name'] == 'domain') {
            $isDomain   = true;
            break;
        }
    }
    if (! $isDomain) {
        $aDetailsFields['option_domain']    = array(
            'name'          => 'domain',
            'value'         => ($aDetails['domain'] ? $aDetails['domain'] : ''),
            'type'          => 'input',
            'default'       => ''
            );
        $this->assign('details_fields', $aDetailsFields);
    }
}

// หา product id ที่เป็น o365
$o365Id         = $db->query("
        SELECT 
            id
        FROM
            hb_products p
        WHERE
            p.category_id = 54
        ")->fetchAll();
		
foreach($o365Id as $id){
	$aO365Id[]	=	$id['id'];
}

 $this->assign('aO365Id', $aO365Id);
//echo '<pre>$aDetails'. print_r($aDetails, true) .'</pre>';