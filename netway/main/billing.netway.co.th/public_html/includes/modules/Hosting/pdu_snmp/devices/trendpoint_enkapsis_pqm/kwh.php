<?php

/**
 * Get current acumulated kWh of a port
 * This is used by power meter billing
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So look for port 3 accumulated kWh:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
 * Load current state into $kwh variable.
 * like: $kwh = 1120;
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

$state = $snmp->Get('.1.3.6.1.4.1.10381.1.3.1.3.2.1.8.'.$port);
if(!$state) {
    throw new Exception("Unable to fetch kWh of this port/device");
}

$kwh=0;
$kwh = preg_replace("/[^0-9]/","",$state) * 0.001;
