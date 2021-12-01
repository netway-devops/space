<?php

hbm_create('Testdrive Domain Registrar', array(
    'description' => 'Testdrive Domain Registra module demo by netway',
    'version' => '1.0'
));

// TEST CONNECTION:
hbm_on_action('module.testconnection', function() {
    return true;
});

// SYNCHRONIZE:
hbm_on_action('domain.synchronize',function($details) {
    $return     = array('status' => 'Active');
    return $return;
});

//REGISTER:
hbm_on_action('domain.register', function($details) {
    return true;
});

hbm_on_action('domain.renew', function($details) {
    return true;
});

hbm_on_action('domain.getnameservers', function($details) {
    $return = array();
    return $return;
});

hbm_on_action('domain.updatenameservers', function($details) {
    return true;
});

hbm_on_action('domain.getcontacts', function($details) {
    $return = array();
    return $return;
});

hbm_on_action('domain.updatecontacts', function($details) {
    return true;
});
