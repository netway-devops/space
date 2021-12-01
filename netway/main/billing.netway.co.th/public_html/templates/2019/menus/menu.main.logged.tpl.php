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

require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');
$return_to  = 'https://support.netway.co.th/hc/th/requests';
$key        = 'PXYryXljB9Xrdiue0WTjJMeOgBPSNrw4DEoPNEGIOfEBLHGK';
$subdomain  = 'pdi-netway';
$now        = time();
$token      = array(
    'jti'   => md5($now . rand()),
    'iat'   => $now,
    'name'  => $aClient['firstname'] .' '. $aClient['lastname'] .' '. $aClient['compannyname'],
    'email' => $aClient['email']
);

$jwt        = JWT::encode($token, $key);
$location   = 'https://' . $subdomain . '.zendesk.com/access/jwt?jwt=' . $jwt.'&return_to='.$return_to;

$this->assign('zendeskSSOUrl', $location);