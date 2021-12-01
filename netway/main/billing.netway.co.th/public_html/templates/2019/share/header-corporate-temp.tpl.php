<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aClient    = hbm_logged_client();

$clientEmail    = $aClient['email'];

$this->assign('clientEmail', $clientEmail);

if(isset($_SESSION['SSO_profilepicture']) && $_SESSION['SSO_profilepicture'] != ''){
    $this->assign('clientAvatar', $_SESSION['SSO_profilepicture']);
}else{
    
    $email = $clientEmail;
    $default = "https://netway.co.th/templates/netwaybysidepad/images/blank-profile-picture.png";
    $size = 120;
    
    $grav_url = "https://www.gravatar.com/avatar/" . md5( strtolower( trim( $email ) ) ) . "?d=" . urlencode( $default ) . "&s=" . $size;
    
    $this->assign('clientAvatar', $grav_url);
}

