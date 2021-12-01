<?php
// $Id: mod_table.case.php 2 2006-02-09 06:37:38Z mfountain $
// +----------------------------------------------------------------------+
// | ModernBill [TM] .:. Client Billing System                            |
// +----------------------------------------------------------------------+
// | Copyright (c) 2001-2003 ModernGigabyte, LLC                          |
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

GLOBAL $https,$secure_url;

$args = array(array('column'        => 'config_type',
                    'required'      => 0,
                    'title'         => ID,
                    'type'          => 'HIDDEN'),

// --------------------------------------------------------------------------

              array('type'          => 'HEADERROW',
                    'title'         => PAYPALCONFIG),

             // Enable PayPal Payment Option
              array('column'        => 'config_1',
                    'required'      => 0,
                    'title'         => PAYPAL_1_TITLE,
                    'type'          => 'FUNCTION_CALL',
                    'function_call' => true_false_radio('config_1',$config_1),
                    'append'        => PAYPAL_1_APPEND),

             // Set Your PayPal ID
             array('column'         => 'config_3',
                    'required'      => 0,
                    'title'         => PAYPAL_3_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => PAYPAL_3_APPEND),


             // Set PayPal Currency Code
             array('column'         => 'config_11',
                    'required'      => 0,
                    'title'         => PAYPAL_11_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 5,
                    'maxlength'     => 3,
                    'default_value' => 'USD',
                    'append'        => PAYPAL_11_APPEND),

             // Set the PayPal Item Name
             array('column'         => 'config_8',
                    'required'      => 0,
                    'title'         => PAYPAL_8_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => PAYPAL_8_APPEND),
/*
		   // Set PayPal Payment URL
		   array('column'         => 'config_2',
				'required'      => 0,
				'title'         => PAYPAL_2_TITLE,
				'type'          => 'TEXT',
				'size'          => 40,
				'maxlength'     => 255,
				'append'        => PAYPAL_2_APPEND),
*/

		   // Set the PayPal Return URL
             array('column'         => 'config_4',
                    'required'      => 0,
                    'title'         => PAYPAL_4_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => PAYPAL_4_APPEND),

             // Set the PayPal Cancel URL
             array('column'         => 'config_5',
                    'required'      => 0,
                    'title'         => PAYPAL_5_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => PAYPAL_5_APPEND),

             // Set Your Logo Image to Display
             array('column'         => 'config_6',
                    'required'      => 0,
                    'title'         => PAYPAL_6_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => PAYPAL_6_APPEND),

             // Set Your Submit Image to Display
             array('column'         => 'config_7',
                    'required'      => 0,
                    'title'         => PAYPAL_7_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => PAYPAL_7_APPEND),

             // Set the PayPal Notify URL
             array('column'         => 'config_10',
                    'required'      => 0,
                    'title'         => PAYPAL_10_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 80,
                    'maxlength'     => 255,
                    'default_value' => $https.'://'.$secure_url.'include/misc/mod_paypal/paypal_return.inc.php',
                    'append'        => PAYPAL_10_APPEND),

// --------------------------------------------------------------------------

             array('type'           => 'HEADERROW',
                    'title'         => PAYPALSUBSCRIPTIONS),

             // Enable PayPal Subscriptions
             array('column'         => 'config_13',
                    'required'      => 0,
                    'title'         => PAYPAL_13_TITLE,
                    'type'          => 'FUNCTION_CALL',
                    'function_call' => true_false_radio('config_13',$config_13),
                    'append'        => '<br>'.PAYPAL_13_APPEND),

             // PayPal Subscription Priority
             array('column'         => 'config_18',
                    'required'      => 0,
                    'title'         => PAYPAL_18_TITLE,
                    'type'          => 'FUNCTION_CALL',
                    'function_call' => true_false_radio('config_18',$config_18),
                    'append'        => '<br>'.PAYPAL_18_APPEND),

/*
		   // Set PayPal Subscription Payment URL
		   array('column'         => 'config_12',
				'required'      => 0,
				'title'         => PAYPAL_12_TITLE,
				'type'          => 'TEXT',
				'size'          => 40,
				'maxlength'     => 255,
				'default_value' => 'https://www.paypal.com/cgi-bin/webscr?cmd=_xclick-subscriptions&',
				'append'        => '<br>'.PAYPAL_12_APPEND),
*/
             // Set PayPal Subscription Payment URL
             array('column'         => 'config_14',
                    'required'      => 0,
                    'title'         => PAYPAL_14_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => '<br>'.PAYPAL_14_APPEND),

             // Set PayPal Subscription Payment URL
             array('column'         => 'config_15',
                    'required'      => 0,
                    'title'         => PAYPAL_15_TITLE,
                    'type'          => 'TEXT',
                    'size'          => 40,
                    'maxlength'     => 255,
                    'append'        => '<br>'.PAYPAL_15_APPEND),

             // Enable Unsubscribe Link in Client Menu
             array('column'         => 'config_16',
                    'required'      => 0,
                    'title'         => PAYPAL_16_TITLE,
                    'type'          => 'FUNCTION_CALL',
                    'function_call' => true_false_radio('config_16',$config_16),
                    'append'        => '<br>'.PAYPAL_16_APPEND),

             array('type'           => 'HEADERROW',
                    'title'         => 'PayPal Internal Value'),

             // Set PayPal Billing Method
             array('column'         => 'config_9',
                    'required'      => 0,
                    'title'         => PAYPAL_9_TITLE,
                    'type'          => 'FUNCTION_CALL',
                    'function_call' => payment_select_box(($config_9!='')?$config_9:5,'config_9'),
                    'append'        => 'Set this to "PayPal" only.'),

             array('type'           => 'HEADERROW',
                    'title'         => 'PayPal Debugging'),

            // Enable PayPal Module Debug Option
              array('column'        => 'config_17',
                    'required'      => 0,
                    'title'         => PAYPAL_17_TITLE,
                    'type'          => 'FUNCTION_CALL',
                    'function_call' => true_false_radio('config_17',$config_17),
                    'append'        => PAYPAL_17_APPEND)

                    );
?>