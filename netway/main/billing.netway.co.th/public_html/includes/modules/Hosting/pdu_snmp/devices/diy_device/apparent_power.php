<?php

/**
 * Get Apparent Power  of port in PDU device.
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 max current:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Save Apparent Power  into $apparent_power variable as string. Set in [VA]
 * Ie:
 * $apparent_power = '121'; //Apparent Power  now is 121 VA
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

$method = 'apparent_power';

require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';

$snmp = setup_pdu_connection($app);

$action_port = isset($port) ? $port :  $app['custom']['config'][$method]['port'];
$oid = prepare_oid($app['custom']['config'][$method]['oid'], $action_port);

$this->_log("INFO","Using OID: ".$oid);

$apparent_power  = $snmp->get($oid);

$this->_log("INFO","Data returned by device: ".var_export($current,true));
if(!$apparent_power)
    throw new Exception("Unable to fetch  port's active power PDU");

$apparent_power = str_ireplace('INTEGER: ','',$apparent_power);



$unit = $app['custom']['config'][$method]['unit'];
switch ($unit) {
    case 'mVA':
        $apparent_power /= 1000;
        break;
    case 'cVA':
        $apparent_power /= 100;
        break;
    case 'kVA':
        $apparent_power *= 1000;
        break;
}