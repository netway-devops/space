<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aGateways          = $this->get_template_vars('gateways');
// --- Get template variable ---

$aGateway            = array();

if (is_array($aGateways) && count($aGateways)) {
    foreach ($aGateways as $k => $v) {
       if ( strtolower($v) == 'cash' || strtolower($v) == 'credit' ) {
           continue;
       }
       if ( preg_match('/^banktransfer/i', $v) && strtolower($v) != 'banktransfer' ) {
           continue;
       }
       $aGateway[$k]   = $v;
    }
}

$this->assign('gateways2', $aGateway);

/** 
 * ถ้า order นั้นมี renew domain จะไม่ให้ใช้ credit
 */
$isRenewDomain  = nwIsRenewDomainInCart();

$this->assign('isRenewDomain', $isRenewDomain);
if (isset($_SESSION['SSLITEM']['commonname'])) {
	if ($this->_tpl_vars['current_cat'] == 1) {
		$this->assign('SSLCommonName', $_SESSION['SSLITEM']['commonname']);
	} else {
		unset($_SESSION['SSLITEM']);
	}
}


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