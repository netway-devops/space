<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.billing_address.php
 * Type:     function
 * Name:     billing_address
 * Purpose:  format billing addrress
 * -------------------------------------------------------------
 */
function smarty_modifier_billing_address($clientId)
{
    require_once(APPDIR . 'modules/Site/addresshandle/admin/class.addresshandle_controller.php');

    $aContact       = addresshandle_controller::singleton()->getContactAddressFronContactId($clientId);
    $billingAddress = isset($aContact['billingAddress']) ? $aContact['billingAddress'] ."\n" : '';
    $billingAddress = nl2br($billingAddress);

    return $billingAddress;
}