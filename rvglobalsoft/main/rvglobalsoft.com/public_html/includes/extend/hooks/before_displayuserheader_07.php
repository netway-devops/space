<?php

require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');

// --- hostbill helper ---
$db = hbm_db();
// --- hostbill helper ---


$aClient    = hbm_logged_client();

if ($aClient['email'] == 'prasit.webexperts.co.th@gmail.com') {
}

$make   = isset($_GET['make']) ? $_GET['make'] : '';
$upgradetarget  = isset($_GET['upgradetarget']) ? $_GET['upgradetarget'] : '';
$isRVSitebuilderDevLicense  = preg_match('/rvsitebuilder\-developer\-license/i', $_SERVER['REQUEST_URI']) ? 1 : 0;

if ($make == 'upgrades' && $upgradetarget == 'service' && $isRVSitebuilderDevLicense) {
    
    $key = "6H6LwKTbudkPw9X7lG59KDijZIfBXSehHvvCrlEscaQHOo4nVSZFmQJbVNeTjGZJ";
    $now        = time();
    $token      = array(
        'jti'   => md5($now . rand()),
        'iat'   => $now,
        'name'  => $aClient['firstname'] .' '. $aClient['lastname'] .' '. $aClient['compannyname'],
        'email' => $aClient['email']
    );
    
    $jwt        = JWT::encode($token, $key);
    $location   = 'https://dev.rvsitebuilder.com/devportal/sso/login?token=' . $jwt;

    header('Location: '. $location);
    exit;

}
