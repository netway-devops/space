<?php

/**
 * Client with ID=$details just logged out
 * Following variable is available to use in this file:  $details client id in HostBill
 */

 
// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---


/**
 * ไปลบ session ให้ client ใน hostbill และ ipboard เพื่อยกเลิก single sing on
 */

$clientId       = $details;

/* --- ตรวจสอบ module active --- */
$result         = $db->query("
            SELECT
                mc.*
            FROM
                hb_modules_configuration mc
            WHERE
                mc.module = 'ipboardsso'
                AND mc.active = '1'
            ")->fetch();

if (isset($result['id'])) {

    $db->query("
        UPDATE
            hb_client_sso
        SET
            ipboard_sso = ''
        WHERE
            client_id = :clientId
        ", array(
            ':clientId'     => $clientId
        ));    

}
