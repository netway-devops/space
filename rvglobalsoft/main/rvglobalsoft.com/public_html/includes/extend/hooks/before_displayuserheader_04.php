<?php

/**
 * This event is called when clientarea header is rendered -
 * use this to inject your custom scripts/meta tags etc.
 */

require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---

// --- ใช้ค่า cookie เดียวกันเพื่อใช้ในการ trac ลูกค้า ---

$aAdmin     = hbm_logged_admin();
$aClient    = hbm_logged_client();
$isAllow    = (isset($aAdmin['id']) && $aAdmin['id']) ? 0 : 1;
if (isset($aAdmin['email']) && $aAdmin['email'] == 'sirishom@rvglobalsoft.com') {
    $isAllow    = 1;
}

if ($aClient['email'] == 'prasit.webexperts.co.th@gmail.com') {
    $requertUri     = $_SERVER['REQUEST_URI'];
    parse_str($requertUri, $aGet);
    if (isset($aGet['return_to']) && preg_match('/support\.rvglobalsoft\.com/i', $aGet['return_to'])) {
        $_SESSION['returnTo']   = $aGet['return_to'];
        $_SESSION['zendesklogin']   = 0;
    }
}

if ( isset($aClient['id']) 
    && ( ! isset($_SESSION['zendesklogin']) || $_SESSION['zendesklogin'] != $aClient['id'] )
    && $isAllow
    ) {

    $returnTo   = (isset($_SESSION['returnTo']) && $_SESSION['returnTo']) ? $_SESSION['returnTo'] : 'https://rvglobalsoft.com/clientarea';
    $returnTo   = urlencode($returnTo);
    if ($aClient['email'] == 'prasit.webexperts.co.th@gmail.com') {
        //echo '<pre>'. print_r($_SESSION, true) .'</pre>';
        //exit;
    }
    $_SESSION['zendesklogin']   = $aClient['id'];
    unset($_SESSION['returnTo']);
    // Log your user in.
    $key        = 'IvI4DEfUL6MYxb9ewOtuTKgcCBoaSZwDmHCivdzij35buyzT';
    $subdomain  = 'rvglobalsoft';
    $now        = time();
    $token      = array(
        'jti'   => md5($now . rand()),
        'iat'   => $now,
        'name'  => $aClient['firstname'] .' '. $aClient['lastname'] .' '. $aClient['compannyname'],
        'email' => $aClient['email']
    );
    
    $jwt        = JWT::encode($token, $key);
    $location   = 'https://' . $subdomain . '.zendesk.com/access/jwt?jwt=' . $jwt
                .= '&return_to='. $returnTo;
    
    echo '<script language="JavaScript">setTimeout(function () {window.location.href=\''. $location .'\';}, 100);</script>';
    exit;
}

// echo '<pre>'. print_r($aClient, true) .'</pre>';
