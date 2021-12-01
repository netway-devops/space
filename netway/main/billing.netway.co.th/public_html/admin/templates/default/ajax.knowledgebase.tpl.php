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
$aCategories = $this->get_template_vars('categories');
// --- Get template variable ---

$result = $db->query("
                        SELECT kn.id, kn.is_active
                        FROM hb_knowledgebase kn
                    ")->fetchAll();
 foreach($result as $data){
     $aData[$data['id']] = $data['is_active'];
 }
 $this->assign('aIsactive',$aData);

if (count($aCategories)) {
    // echo '<pre>'.print_r($aCategories, true).'</pre>';
}
