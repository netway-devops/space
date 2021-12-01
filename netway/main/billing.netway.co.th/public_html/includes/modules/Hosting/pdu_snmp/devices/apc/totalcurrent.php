<?php

/**
 * Get total momentary current of entire PDU
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3'; - ignored!
 * So look for port 3 max current:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Save maximum current into $totalcurrent variable as string. Set in [mA]
 * Ie:
 * $totalcurrent = '0.121'; //Maximum current now is 0.121 mA
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

$totalcurrent = $snmp->Get('.1.3.6.1.4.1.318.1.1.12.2.3.1.1.2.1');
if(!$totalcurrent) {
    throw new Exception("Unable to fetch PDU total current usage");
}


$totalcurrent = str_ireplace('Gauge32: ','',$totalcurrent);



$totalcurrent = number_format($totalcurrent,2); //A * 10
$totalcurrent*=100;

