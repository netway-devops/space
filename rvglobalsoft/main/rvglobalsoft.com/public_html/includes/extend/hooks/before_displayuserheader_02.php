<?php 
#@LICENSE@#

// --- hostbill helper ---
$db         = hbm_db();
$db->query("SELECT '". __FILE__ ."' ");
// --- hostbill helper ---

$aAdmin     = hbm_logged_admin();
$aClient    = hbm_logged_client();


if (isset($aClient['id']) && $aClient['email'] == 'prasit.webexperts.co.th@gmail.com') {

    if (isset($_SESSION['authLoginRedirect'])) {
        $url    = $_SESSION['authLoginRedirect'];
        unset($_SESSION['authLoginRedirect']);
        header('location:'. $url);
        exit;
    }

    $referer        = $_SERVER['HTTP_REFERER'];
    $destination    = $_SERVER['REQUEST_URI'];
    
    if ( preg_match('/dev\.rvsitebuilder\.com/i', $referer)
        && preg_match('/action=services/i', $destination)
        && preg_match('/cid=11/i', $destination)
        ) {
            $_SESSION['authLoginRedirect']  = $destination;
    }
    
    //echo '<pre>'. print_r($_SERVER, true) .'</pre>';
    //exit;
}