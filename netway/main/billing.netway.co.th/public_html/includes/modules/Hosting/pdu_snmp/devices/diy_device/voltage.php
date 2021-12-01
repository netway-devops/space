<?php

/**
 * Get voltage of port in PDU device.
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 max current:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Save voltage into $voltage variable as string. Set in [mV]
 * Ie:
 * $voltage = '121'; //Maximum current now is 121 mV
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

$method = 'voltage';

require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';

$snmp = setup_pdu_connection($app);

$action_port = $app['custom']['config'][$method]['port'];
$oid = prepare_oid($app['custom']['config'][$method]['oid'], $action_port);

$voltage = $snmp->get($oid);

$this->_log("INFO","Data returned by device: ".var_export($voltage,true));

if(!$voltage)
    throw new Exception("Unable to fetch voltage from PDU");

$voltage = str_ireplace('INTEGER: ','',$voltage);

$unit = $app['custom']['config'][$method]['unit'];
switch ($unit) {
    case 'uV':
        $voltage /= 1000;
        break;
    case 'cV':
        $voltage *= 10;
        break;
    case 'V':
        $voltage *= 1000;
        break;
    case 'kV':
        $voltage *= 1000000;
        break;
    case 'MV':
        $voltage *= 1000000000;
}