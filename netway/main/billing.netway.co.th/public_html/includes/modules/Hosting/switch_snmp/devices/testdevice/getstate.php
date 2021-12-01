<?php

/**
 * Get current state of port in Switch
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
 * $app['ip'] - holds Switch ip address
 * $app['read'] - holds SNMP read community, default "public"
 * $app['write'] - holds SNMP write community, default "private"
 *
 *
 * If you wish to return error, throw new Exception.
 * like: throw new Exception('Something unexpected happen');
 */

$t = HBConfig::getConfig('HBTempatesC').DS.'testdeviceportss.json';
if(!file_exists($t)) {
    $state = true;

} else {
    $ports = json_decode(file_get_contents($t),true);
    $state= $ports[$port];

}