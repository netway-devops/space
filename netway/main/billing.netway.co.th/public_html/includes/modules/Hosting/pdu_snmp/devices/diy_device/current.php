<?php

/**
 * Get current of port in PDU device.
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 max current:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Save current into $current variable as string. Set in [mA]
 * Ie:
 * $current = '0.121'; //Current now is 0.121 mA
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
$method = 'current';

require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';

$snmp = setup_pdu_connection($app);

$action_port = isset($port) ? $port :  $app['custom']['config'][$method]['port'];
$oid = prepare_oid($app['custom']['config'][$method]['oid'], $action_port);

$this->_log("INFO","Using OID: ".$oid);

$current = $snmp->get($oid);

$this->_log("INFO","Data returned by device: ".var_export($current,true));
if(!$current) {
    throw new Exception("Unable to fetch port's current from PDU");
}

$current = str_ireplace('INTEGER: ','',$current);

$unit = $app['custom']['config'][$method]['unit'];
switch ($unit) {
    case 'uA':
        $current /= 1000;
        break;
    case 'cA':
        $current *= 10;
        break;
    case 'A':
        $current *= 1000;
        break;
    case 'kA':
        $current *= 1000000;
        break;
}