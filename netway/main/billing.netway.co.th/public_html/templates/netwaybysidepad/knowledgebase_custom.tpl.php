<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---
$result = $db->query("
                        SELECT kn.id, kn.is_active , kn.cat_id
                        FROM hb_knowledgebase kn
                    ")->fetchAll();
 foreach($result as $data){
     $aData[$data['id']] = $data['is_active'];
     $aCat[$data['id']] = $data['cat_id'];
 }
 $this->assign('aIsactive',$aData);
 $this->assign('aCats',$aCat);
