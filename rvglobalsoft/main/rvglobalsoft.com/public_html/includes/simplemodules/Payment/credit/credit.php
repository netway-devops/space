<?php
hbm_create('Credit', array(
    'description' => 'ให้ Credit',
    'version' => '1.0'
));

hbm_on_action('module.testconnection',function() { 
    return true;
});
