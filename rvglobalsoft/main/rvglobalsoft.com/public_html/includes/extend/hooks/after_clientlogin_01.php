<?php

/**
 * Client with ID=$details just logged in
 * Following variable is available to use in this file:  $details Client id in HostBill
 */

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

/**
 * ไปบันทึก session ให้ client ใน hostbill และ ipboard เพื่อทำ single sing on
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
    
    $aClient        = hbm_logged_client();
    $sessId         = $aClient['s_id'];
    
    /* --- update session ให้ตรงกับ forum --- */
    $result         = $db->query("
                SELECT
                    cs.*
                FROM
                    hb_client_sso cs
                WHERE
                    cs.client_id = :clientId
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();
    
    if (isset($result['id'])) {
        $db->query("
            UPDATE
                hb_client_sso
            SET
                ipboard_sso = :sessionId
            WHERE
                client_id = :clientId
            ", array(
                ':sessionId'    => $sessId,
                ':clientId'     => $clientId
            ));
    } else {
        $db->query("
            INSERT INTO hb_client_sso (
                id, client_id, ipboard_sso
            ) VALUES (
                '', :clientId, :sessionId
            )
            ", array(
                ':sessionId'    => $sessId,
                ':clientId'     => $clientId
            ));
    }
}


/* [XXX] --- ยกเลิก --- */
if (isset($result['id']) && isset($_POST['ipbsson']) && $_POST['ipbsson'] && $clientId == 6996) {
    $aConfig    = unserialize($result['config']);
    
    $result     = $db->query("
            SELECT
                ca.email
            FROM
                hb_client_access ca
            WHERE
                ca.id = :clientId
            ", array(
                ':clientId'     => $clientId
            ))->fetch();
    
    $email      = isset($result['email']) ? $result['email'] : '';
    
    /* --- เชื่อมต่อฐานข้อมูล forum --- */
    $con        = @mysql_connect(
                    $aConfig['DB Hostname']['value'],
                    $aConfig['DB User']['value'],
                    $aConfig['DB Password']['value']
                    );
    
    if ($con) {
        $dbSelected     = @mysql_select_db($aConfig['DB Name']['value'], $con);
        
        if ($dbSelected) {
            
            //$db->query("INSERT INTO hb_error_log VALUES('', NOW(), 'dbSelected', 'Other')");
            
            /* --- ตรวจสอบ forum member --- */
            $result         = mysql_query("
                        SELECT 
                            m.member_id 
                        FROM 
                            ibf_members m
                        WHERE
                            m.email = '{$email}'
                        ");
            $row            = mysql_fetch_assoc($result);
            $memberId       = isset($row['member_id']) ? $row['member_id'] : 0;
            
            $sessId         = $_POST['ipbsson'];
            
            if ($memberId) {
                mysql_query("
                    REPLACE INTO ibf_members_sso (
                        member_id, session_id
                    ) VALUES (
                        '{$memberId}', '{$sessId}'
                    )
                    ");
            } else {
                
                $result     = $db->query("
                        SELECT
                            cd.*
                        FROM
                            hb_client_details cd
                        WHERE
                            cd.id = :clientId
                        ", array(
                            ':clientId'     => $clientId
                        ))->fetch();
                
                $aClient    = isset($result['id']) ? $result : array();
                
                $url        = $aConfig['IPBoard Url']['value'] .'/sson.php';
                $aParam     = array(
                    'email'         => $email,
                    'name'          => $aClient['firstname'] .' '. $aClient['lastname'],
                    'members_display_name'      => $aClient['firstname'],
                    'sson'           => $sessId
                );
                
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_HEADER, false);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_TIMEOUT, 60);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, false);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $aParam);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_exec($ch);
                
            }
            
            /* --- update session ให้ตรงกับ forum --- */
            $result         = $db->query("
                        SELECT
                            cs.*
                        FROM
                            hb_client_sso cs
                        WHERE
                            cs.client_id = :clientId
                        ", array(
                            ':clientId'     => $clientId
                        ))->fetch();
            
            if (isset($result['id'])) {
                $db->query("
                    UPDATE
                        hb_client_sso
                    SET
                        ipboard_sso = :sessionId
                    WHERE
                        client_id = :clientId
                    ", array(
                        ':sessionId'    => $sessId,
                        ':clientId'     => $clientId
                    ));
            } else {
                $db->query("
                    INSERT INTO hb_client_sso (
                        id, client_id, ipboard_sso
                    ) VALUES (
                        '', :clientId, :sessionId
                    )
                    ", array(
                        ':sessionId'    => $sessId,
                        ':clientId'     => $clientId
                    ));
            }
            
        }
    }
    
    
}
