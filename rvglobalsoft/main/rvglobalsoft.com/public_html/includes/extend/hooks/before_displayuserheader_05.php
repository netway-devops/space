<?php

 

/**
 * comment
 * comment
 */

 

require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');

 

// --- hostbill helper ---
$db = hbm_db();
// --- hostbill helper ---

 


$aClient    = hbm_logged_client();

if ($aClient['email'] == 'prasit.webexperts.co.th@gmail.com') {
    //echo '<pre>'. print_r($_SESSION, true) .'</pre>';
}

// https://rvglobalsoft.com/clientarea?signup_for=rvsitebuildercms
//Frist Login/Signup to set session
if (isset($_SERVER['REQUEST_URI']) && preg_match('/signup\_for\=/', $_SERVER['REQUEST_URI'])) {
    $aRequest   = parse_url($_SERVER['REQUEST_URI']);
    if (isset($aRequest['query'])) {
        parse_str($aRequest['query'], $aRequest);
    }
    if (isset($aRequest['signup_for'])) {
        $_SESSION['signup_for'] = $aRequest['signup_for'];
        $_SESSION['AppSettings']['signup_for'] = $aRequest['signup_for'];
    }
}

if (isset($_SESSION['signup_for'])) {
    //echo '<pre>'. print_r($_SESSION, true) .'</pre>';
}

//Frist Login and Signup/Login to rvsb reseller website
if (isset($_SESSION['signup_for']) && isset($aClient['id']) && $aClient['id']) {
    // Log your user in.
    $key        = 'WOMzbRM0ywPqRfHZ6vu51GKGMh8AphwoFB0EzaeiKLsymHrqR8';
    $now        = time();
    $token      = array(
    'jti'   => md5($now . rand()),
    'iat'   => $now,
    'firstname'  => $aClient['firstname'],
    'lastname'   => $aClient['lastname'],
    'email' => $aClient['email']
    );
    
    $jwt        = JWT::encode($token, $key);
    $location   = 'https://dev.rvsitebuilder.com/login/provider/sso?token='.$jwt;
    unset($_SESSION['signup_for']);
    echo '<script language="JavaScript">setTimeout(function () {window.location.href=\''. $location .'\';}, 100);</script>';
    exit;
}