<?php
hbm_create('BankTransfer TMB', array(
    'description' => 'โอนเงินผ่านธนาคาร ทหารไทย',
    'version' => '1.0'
));

hbm_add_config_option('info', array('type' => 'textarea'));
hbm_add_config_option('Bank Name');
hbm_add_config_option('Bank Short Name');
hbm_add_config_option('Bank Branch');
hbm_add_config_option('Bank Account Type');
hbm_add_config_option('Bank Account Name');
hbm_add_config_option('Bank Account Number');

hbm_on_action('module.testconnection',function() { 
    return true;
});

hbm_on_action('payment.displayform', function ($details) {
    
});
