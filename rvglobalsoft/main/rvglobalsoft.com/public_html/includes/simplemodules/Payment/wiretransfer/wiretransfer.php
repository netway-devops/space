<?php
hbm_create('Wire Transfer', array(
    'description' => 'Wire Transfer',
    'version' => '1.0'
));

hbm_add_config_option('info', array('type' => 'textarea'));
hbm_add_config_option('Bank Name');

hbm_on_action('module.testconnection',function() { 
    return true;
});

hbm_on_action('payment.displayform', function ($details) {
    
});
