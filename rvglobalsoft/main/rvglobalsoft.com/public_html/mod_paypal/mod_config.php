<?php
// $Id: mod_config.php 2 2006-02-09 06:37:38Z mfountain $
// +----------------------------------------------------------------------+
// | ModernBill [TM] .:. Client Billing System                            |
// +----------------------------------------------------------------------+
// | Copyright (c) 2001-2004 ModernGigabyte, LLC                          |
// +----------------------------------------------------------------------+
// | This source file is subject to the ModernBill End User License       |
// | Agreement (EULA), that is bundled with this package in the file      |
// | LICENSE, and is available at through the world-wide-web at           |
// | http://www.modernbill.com/extranet/LICENSE.txt                       |
// | If you did not receive a copy of the ModernBill license and are      |
// | unable to obtain it through the world-wide-web, please send a note   |
// | to license@modernbill.com so we can email you a copy immediately.    |
// +----------------------------------------------------------------------+
// | Authors: ModernGigabyte, LLC <info@moderngigabyte.com>               |
// | Support: http://www.modernsupport.com/modernbill/                    |
// +----------------------------------------------------------------------+
// | ModernGigabyte and ModernBill are trademarks of ModernGigabyte, LLC. |
// +----------------------------------------------------------------------+
//
// +----------------------------------------------------------------------+
// | Define the master configuration array for this module. (DO NOT EDIT) |
// +----------------------------------------------------------------------+
$_GATEWAYS['mod_paypal'] = array(

// +----------------------------------------------------------------------+
// | Assign the configuration settings, one per element of the            |
// | configuration array. This data may be sourced from the config table  |
// | in the database or manually set. (OK TO EDIT)                        |
// +----------------------------------------------------------------------+
'mod_enabled' 	        => $this_mod_paypal_config['config_1'], // required
'paypal_enabled'        => $this_mod_paypal_config['config_1'],
'payment_url'           => 'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick&', //$this_mod_paypal_config['config_2'],
'business'              => $this_mod_paypal_config['config_3'],
'return'                => $this_mod_paypal_config['config_4'],
'cancel_return'         => $this_mod_paypal_config['config_5'],
'image_url'             => $this_mod_paypal_config['config_6'],
'submit_image'          => $this_mod_paypal_config['config_7'],
'pp_item_name'          => $this_mod_paypal_config['config_8'],
'x_Description'         => $this_mod_paypal_config['config_8'], // must set x_Description
'paypal_id'             => $this_mod_paypal_config['config_9'],
'notify_url'            => $this_mod_paypal_config['config_10'],
'currency_code'         => $this_mod_paypal_config['config_11'],
'sub_url'               => 'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick-subscriptions&', //$this_mod_paypal_config['config_12'],
'sub_enabled'           => $this_mod_paypal_config['config_13'],
'sub_pay_image'         => $this_mod_paypal_config['config_14'],
'sub_cancel_image'      => $this_mod_paypal_config['config_15'],
'sub_cancel_enabled'    => $this_mod_paypal_config['config_16'],
'paypal_debug'          => $this_mod_paypal_config['config_17'],
'subscription_priority' => $this_mod_paypal_config['config_18'],

'pp_undefined_quantity' => '1',
'pp_add'                => '1',
'pp_no_note'            => '1',
'pp_no_shipping'        => '1',

// +----------------------------------------------------------------------+
// | Define the module status & version info. (DO NOT EDIT)               |
// +----------------------------------------------------------------------+
'mod_name'    => 'PayPal',
'mod_type'    => 'gateway', // gateway, server, registrar, other
'mod_locale'  => 'INTL',
'mod_status'  => 'stable', // stable, testing, buggy, development
'vt_enabled'  => FALSE, // virtual terminal enabled
'mod_version' => '2.1.21', // current version # for this module
'min_version' => '4.4.0' // minimum version # for ModernBill
);

// +----------------------------------------------------------------------+
// | Extract configuration array for this module. (DO NOT EDIT)           |
// +----------------------------------------------------------------------+
extract($_GATEWAYS['mod_paypal']);

//if ($mod_enabled) {
    $_SELECTS['gateway_types']['mod_paypal'] = $mod_name;
    $_SELECTS['payment_types'][5] = PAYPAL;   $payment_types[5] = PAYPAL;
    $_SELECTS['billing_types'][5] = PAYPAL;   $billing_types[5] = PAYPAL;
//}
?>
