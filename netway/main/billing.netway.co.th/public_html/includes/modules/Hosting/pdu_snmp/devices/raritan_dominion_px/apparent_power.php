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

$snmp = HBLoader::LoadComponent('Net/SNMP_wrapper');
$snmp->Connect($app['ip'],161,$app['read']);

$apparent_power = $snmp->Get('.1.3.6.1.4.1.13742.4.1.2.2.1.8.'.$port);
if(!$apparent_power) {
    throw new Exception("Unable to fetch maximum port's current from PDU");
}


$apparent_power = str_ireplace('Gauge32: ','',$apparent_power);

