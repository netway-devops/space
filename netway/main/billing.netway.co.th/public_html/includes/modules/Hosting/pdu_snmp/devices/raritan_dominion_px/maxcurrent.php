<?php

/**
 * Get maximum current of port in PDU device.
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 max current:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Save maximum current into $maxcurrent variable as string. Set in [mA]
 * Ie:
 * $maxcurrent = '0.121'; //Maximum current now is 0.121 mA
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

$snmp = HBLoader::LoadComponent('Net/SNMP_wrapper');
$snmp->Connect($app['ip'],161,$app['read']);

$maxcurrent = $snmp->Get('.1.3.6.1.4.1.13742.4.1.2.2.1.5.'.$port);
if(!$maxcurrent) {
    throw new Exception("Unable to fetch maximum port's current from PDU");
}


$maxcurrent = str_ireplace('Gauge32: ','',$maxcurrent);

