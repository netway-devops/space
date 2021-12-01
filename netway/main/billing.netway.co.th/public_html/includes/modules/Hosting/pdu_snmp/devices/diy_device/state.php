<?php

/**
 * Get current state of port in PDU device.
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 state:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Load current state into $state variable.
 * Where:
 * $state = true; means port is ON
 * $state = false; means port is OFF
 *
 * Connection details loaded from related App are available in $app array.
 * $app['ip'] - holds PDU ip address
 * $app['read'] - holds SNMP read community, default "public"
 * $app['write'] - holds SNMP write community, default "private"
 *
 *
 * If you wish to return error, throw new Exception.
 * like: throw new Exception('Something unexpected happen');
 */
$method = 'state';

require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';

$snmp = setup_pdu_connection($app);

$action_port = isset($port) ? $port : $app['custom']['config'][$method]['port'];
$oid = prepare_oid($app['custom']['config'][$method]['oid'], $action_port);

$this->_log("INFO","Using OID: ".$oid);

$state = $snmp->get($oid);

$this->_log("INFO","Data returned by device: ".var_export($state,true));

if(!$state) {
    throw new Exception("Unable to fetch current port state from PDU");
}
$state = str_ireplace('INTEGER: ','',$state);
$on = $app['custom']['config'][$method]['value']['ON'];
$off = $app['custom']['config'][$method]['value']['OFF'];

if (empty($on)) {
    $state = false;
} else {
    switch($state) {
        case $on:
            return true;
            break;
        case $off;
            return false;
            break;
        default:
            throw new Exception("Unknown port state");
            break;
    }
}

