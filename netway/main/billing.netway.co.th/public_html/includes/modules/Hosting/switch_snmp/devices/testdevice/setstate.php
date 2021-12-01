<?php

/**
 * Set switch port state
 *
 * Under $state; HostBill will load state we need to set port into.
 * if($state) {
 *    //link it UP
 * } else {
 *    //link it DOWN
 * }
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So cycle power of port 3:
 * OID: .1.3.6.1.2.1.2.2.1.7.3
 *
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
$ports1 = array(
    'a1'=>true,
    'a2'=>true,
    'a3'=>true,
    'a4'=>true,
    'a5'=>true,
    'a6'=>true,
    'a7'=>true
);
$t = HBConfig::getConfig('HBTempatesC').DS.'testdeviceportss.json';
if(!file_exists($t)) {

    $ports1[$port]=$state;
    file_put_contents($t, json_encode($ports1));
    $return = true;
} else {
    $ports = json_decode(file_get_contents($t),true);
    $ports[$port]=$state;
    file_put_contents($t, json_encode($ports));
    $return = true;
}