<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.config.custom.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = (object) $client;
// --- hostbill helper ---

$this->assign('client', $client);
// --- Get template variable ---
$aGateways          = $this->get_template_vars('gateways');
// --- Get template variable ---

$aGateway            = array();

if (is_array($aGateways) && count($aGateways)) {
    foreach ($aGateways as $k => $v) {
       if ( strtolower($v) == 'cash' ) {
           continue;
       }
       if ( preg_match('/^banktransfer/i', $v) && strtolower($v) != 'banktransfer' ) {
           continue;
       }
       $aGateway[$k]   = $v;
    }
}
$this->assign('gateways2', $aGateway);

/* --- ถ้า order นั้นมี renew domain จะไม่ให้ใช้ credit --- */
$isRenewDomain  = nwIsRenewDomainInCart();

$this->assign('isRenewDomain', $isRenewDomain);

$cartItems      = isset($_SESSION['AppSettings']['Cart']) ? count($_SESSION['AppSettings']['Cart']) : 0;
$this->assign('cartItems', $cartItems);

//echo '<pre>'.print_r($_SESSION['AppSettings'], true).'</pre>';

/* --- FUNCTION --- */

function nwIsRenewDomainInCart ()
{
    $aCarts  = $_SESSION['Cart'];
    foreach ($aCarts as $aCart) {
        if(nwIsRenewDomainInCart_ext($aCart)) {
            return true;
        }
    }
    
    return false;
}

function nwIsRenewDomainInCart_ext ($aCarts)
{
    if (is_array($aCarts)) {
        if (isset($aCarts['domain_id']) && $aCarts['domain_id'] 
            && isset($aCarts['action']) && $aCarts['action'] == 'renew' ) {
            return true;
        }
        
        foreach ($aCarts as $aCart) {
            return nwIsRenewDomainInCart_ext($aCart);
        }
    }
}
