<?php

/**
 * Cycle power of port in PDU device.
 *
 * Under $state; HostBill will load state we need to set port into.
 * if($state) {
 *    //power ON
 * } else {
 *    //power OFF
 * }
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So cycle power of port 3:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
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

$method = 'power';

require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';
$app['read'] = $app['write'];
$snmp = setup_pdu_connection($app);

$action_port = isset($port) ? $port :  $app['custom']['config'][$method]['port'];
$oid = prepare_oid($app['custom']['config'][$method]['oid'], $action_port);

$this->_log("INFO","Using OID: ".$oid);



$on = (int) $app['custom']['config'][$method]['value']['ON'];
$off = (int) $app['custom']['config'][$method]['value']['OFF'];

if ($state) {
    $return = $snmp->set($oid, 'i', $on);
} else {
    $return = $snmp->set($oid, 'i', $off);
}

$this->_log("INFO","Data returned by device: ".var_export($return,true));
if (!$return)
    throw new Exception('Unable to set new power state');