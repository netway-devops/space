<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.config.custom.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aCartContents      = $this->get_template_vars('cart_contents');
$aFields            = $this->get_template_vars('fields');
$aContacts          = $this->get_template_vars('contacts');
//echo '<pre>'.print_r($aCartContents,true).'</pre>';
// --- Get template variable ---

$isDomainContactForm    = true;
$this->assign('isDomainContactForm', $isDomainContactForm);

$configBusinessName     = ConfigCustom::singleton()->getValue('BusinessName');
$this->assign('configBusinessName', $configBusinessName);

$nwTechnicalContact     = ConfigCustom::singleton()->getValue('nwTechnicalContact');
$this->assign('nwTechnicalContact', $nwTechnicalContact);

/* --- domain $aCartContents[2] ---*/
if (isset($aCartContents[2]) && count($aCartContents[2])) {
    foreach ($aCartContents[2] as $k => $aDomain) {
        
        /* --- preset --- */
        if (! isset($aDomain['extended']) || ! $aDomain['extended']) {
            if (is_array($aContacts) && count($aContacts)) {
                $aCartContents[2][$k]['extended']   = array(
                    'registrant'    => $aContacts[(count($aContacts)-1)]['id']
                );
            } else {
                $aCartContents[2][$k]['extended']   = array(
                    'registrant'    => array('country' => 'TH')
                );
            }
        }
        /* --- preset --- */
        
        if (! isset($aFields['contacts'])) {
            $aFields['contacts']    = array();
            $registrantContact      = md5(serialize($aCartContents[2][$k]['extended']['registrant']));
            
            $adminContact           = isset($aCartContents[2][$k]['extended']['admin']) 
                                        ? md5(serialize($aCartContents[2][$k]['extended']['admin'])) : '';
            if ($adminContact && $adminContact != $registrantContact) {
                $aFields['contacts']['admin']    = $aCartContents[2][$k]['extended']['admin'];
            }
            
            $billingContact         = isset($aCartContents[2][$k]['extended']['billing']) 
                                        ? md5(serialize($aCartContents[2][$k]['extended']['billing'])) : '';
            if ($billingContact && $billingContact != $registrantContact) {
                $aFields['contacts']['billing']    = $aCartContents[2][$k]['extended']['billing'];
            }
            
        }
        
    }
}


$this->assign('cart_contents', $aCartContents);
$this->assign('fields', $aFields);

