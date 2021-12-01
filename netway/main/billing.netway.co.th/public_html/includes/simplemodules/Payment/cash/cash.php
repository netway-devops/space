<?php
hbm_create('Cash', array(
    'description' => 'ชำระด้วย เงินสด',
    'version' => '1.0'
));

hbm_add_config_option('info', array('type' => 'textarea'));

hbm_on_action('module.testconnection',function() { 
    return true;
});

hbm_on_action('payment.displayform', function ($details) {
    
});
