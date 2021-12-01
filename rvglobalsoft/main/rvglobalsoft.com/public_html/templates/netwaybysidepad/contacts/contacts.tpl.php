<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aClient    = hbm_logged_client();
// --- hostbill helper ---


// --- Get template variable ---
$aProfiles          = $this->get_template_vars('profiles');
// --- Get template variable ---

if (! count($aProfiles)) {
    $result     = $db->query("
        SELECT ca.email, ca.lastlogin, cd.*
        FROM hb_client_details cd,
            hb_client_access ca
        WHERE cd.id = ca.id
            AND cd.parent_id = :id
        ", array(
            ':id'   => $aClient['id']
        ))->fetchAll();
    $aProfiles  = $result;
    $this->assign('profiles', $aProfiles);
}

//echo '<pre>'.print_r($oClient, true).'</pre>';