<?php

# link error log with agent

// --- hostbill helper ---
$db         = hbm_db();
$aAdmin     = hbm_logged_admin();
// --- hostbill helper ---

$adminEmail = isset($aAdmin['email']) ? $aAdmin['email'] : '';

if (isset($_SESSION['aUserRuntime'])) {
    
    $time       = time();
    $pastTime   = $time - (60*5);
    $currentDate    = date('Y-m-d H:i:s', $time);
    $pastDate       = date('Y-m-d H:i:s', $pastTime);
    
    $result     = $db->query("
        SELECT el.date
        FROM hb_error_log el
            LEFT JOIN hb_error_log_handle elh
            ON elh.date = el.date
        WHERE elh.date IS NULL
            AND ( el.date  BETWEEN '{$pastDate}' AND '{$currentDate}' )
        ")->fetchAll();
    
    foreach ($result as $arr) {
        $date   = $arr['date'];
        
        if (in_array($date, $_SESSION['aUserRuntime'])) {
            $result2    = $db->query("
                SELECT `date`
                FROM hb_error_log_handle
                WHERE `date` = '{$date}'
                ")->fetch();
            if (! isset($result2['date'])) {
                $db->query("
                    INSERT INTO hb_error_log_handle (
                    `date`, admin_email
                    ) VALUES (
                    :date, :admin_email
                    )
                    ", array(
                        ':date' => $date,
                        ':admin_email'  => $adminEmail
                    ));
                
            }
        }
        
    }

}