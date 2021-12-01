<?php

/**
 * Get Active Power  of port in PDU device.
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 max current:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Save Active Power  into $active_power variable as string. Set in [W]
 * Ie:
 * $active_power = '121'; //Active Power  now is 121 W
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

$method = 'active_power';

require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';

$snmp = setup_pdu_connection($app);

$action_port = isset($port) ? $port :  $app['custom']['config'][$method]['port'];
$oid = prepare_oid($app['custom']['config'][$method]['oid'], $action_port);

$this->_log("INFO","Using OID: ".$oid);

$active_power  = $snmp->get($oid);

$this->_log("INFO","Data returned by device: ".var_export($active_power,true));

if(!$active_power)
    throw new Exception("Unable to fetch  port's active power PDU");

$active_power = str_ireplace('INTEGER: ','',$active_power);

$unit = $app['custom']['config'][$method]['unit'];
switch ($unit) {
    case 'mW':
        $active_power /= 1000;
        break;
    case "cW":
        $active_power /= 100;
        break;
    case 'kW':
        $active_power *= 1000;
        break;
}
