<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

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