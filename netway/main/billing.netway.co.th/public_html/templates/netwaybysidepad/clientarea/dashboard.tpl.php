<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/invoicehandle/user/class.invoicehandle_controller.php');
require_once(APPDIR . 'modules/Other/google_authenticator_for_client/user/class.google_authenticator_for_client_controller.php');
//require_once(APPDIR . 'modules/Site/zendeskhandle/user/class.zendeskhandle_controller.php');
require_once(APPDIR . 'modules/Site/domainhandle/user/class.domainhandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$aClient    = hbm_logged_client();
// --- hostbill helper ---


// --- Get template variable ---
$aDueInvoice        = $this->get_template_vars('dueinvoices');
$caUrl              = $this->get_template_vars('ca_url');
$admin              = hbm_logged_admin();
$oAdmin             = isset($admin['id']) ? (object) $admin : null;
$mydomains          = $this->get_template_vars('mydomains');
// --- Get template variable ---

$this->assign('oAdmin', $oAdmin);

/* --- คืนค่า invoice ที่ตั้งค่าเป็น - ก่อนรวม inoivce กลับมาเหมือนเดิม --- */
invoicehandle_controller::restoreInvoice(array());

$aCompoundInvoice       = array();
$aMainCompoundInvoice   = array();

/* --- list service เพื่อให้เข้าถึงข้อมูลได้มากขึ้น --- */
if (count($aDueInvoice)) {
    
    $aInvoiceIds        = array();
    foreach ($aDueInvoice as $v) {
        array_push($aInvoiceIds, $v['id']);
    }
    
    $aInvoiceDescriptions   = array();
    
    $result         = $db->query("
                SELECT 
                    ii.id, ii.invoice_id, ii.description
                FROM 
                    hb_invoice_items ii
                WHERE 
                    ii.invoice_id IN (". implode(',', $aInvoiceIds) .")
                ORDER BY ii.invoice_id ASC
                ")->fetchAll();
                
    if (count($result)) {
        foreach ($result as $v) {
            if (preg_match('/^Invoice\s?\#\s?([0-9]+)/', $v['description'], $matches)) {
                $v['description']   = preg_replace('/'. $matches[1] .'/', 
                    '<a href="'. $caUrl .'clientarea/invoice/'. $matches[1] .'/" target="_blank">'. $matches[1] .'</a>', 
                    $v['description']);
                    
                array_push($aCompoundInvoice, $matches[1]);
                array_push($aMainCompoundInvoice, $v['invoice_id']);
            }
            $aInvoiceDescriptions[$v['invoice_id']]   .= '<br />'. $v['description'];
        }
    }
    $this->assign('aInvoiceDescriptions', $aInvoiceDescriptions);
}

$this->assign('aCompoundInvoice', $aCompoundInvoice);
$this->assign('aMainCompoundInvoice', $aMainCompoundInvoice);

$isGoogleAuthActive = google_authenticator_for_client_controller::singleton()->isActive();
if ($aClient['email'] == 'prasit.webexperts.co.th@gmail.com') {
    $isGoogleAuthActive = 1;
} else {
    $isGoogleAuthActive = 0;
}
$this->assign('isGoogleAuthActive', $isGoogleAuthActive);
$clientSetGoogleAuth    = '';
if ($isGoogleAuthActive) {
    $clientSetGoogleAuth    = google_authenticator_for_client_controller::singleton()->getClientSetGoogleAuth();
}
$this->assign('clientSetGoogleAuth', $clientSetGoogleAuth);
$googleQRCodeUrl        = '';
if (! $clientSetGoogleAuth) {
    $googleQRCodeUrl        = google_authenticator_for_client_controller::singleton()->getGoogleAuthenticatorCode();
}
$this->assign('googleQRCodeUrl', $googleQRCodeUrl);

$result     = array();//zendeskhandle_controller::singleton()->searchTicket(array());
$this->assign('openedtickets', $result);

require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');

$key        = 'OhqTggPCAOmEw1QoTtRghLlwRW942C3rpphtT2cH4gJUbWKm';
$subdomain  = 'pdi-netway';
$now        = time();
$token      = array(
    'jti'   => md5($now . rand()),
    'iat'   => $now,
    'name'  => $aClient['firstname'] .' '. $aClient['lastname'] .' '. $aClient['compannyname'],
    'email' => $aClient['email']
);

$jwt        = JWT::encode($token, $key);
$location   = 'https://' . $subdomain . '.zendesk.com/access/jwt?jwt=' . $jwt;

$this->assign('zendeskSSOUrl', $location);

$mydomains  = domainhandle_controller::singleton()->totalDomain(array());
$this->assign('mydomains', $mydomains);


$key        = 'PXYryXljB9Xrdiue0WTjJMeOgBPSNrw4DEoPNEGIOfEBLHGK';
$now        = time();
$token      = array(
                    'jti'   => md5($now . rand()),
                    'iat'   => $now,
                    'firstname'  => $aClient['firstname'],
                    'lastname'   => $aClient['lastname'],
                    'email' => $aClient['email'],
                    'avatar'=> isset($_SESSION['SSO_profilepicture']) ? $_SESSION['SSO_profilepicture'] : 'https://netway.co.th/templates/netwaybysidepad/images/blank-profile-picture.png'
                );

$jwt        = JWT::encode($token, $key);
$locationtodotsite   = 'http://netway.site/login/provider/sso?token='.$jwt;

$this->assign('gotodotsite', $locationtodotsite);
