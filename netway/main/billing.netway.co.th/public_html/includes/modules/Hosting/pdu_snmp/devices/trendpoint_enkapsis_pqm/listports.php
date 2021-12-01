<?php
/**
 * HostBill will load this file when it will need to list available Ports in PDU.
 *
 * Load available ports into $ports array - HostBill will read from it.
 * I.e.:
 * $ports = array(
 *  "0" => "Port name #0",
 *  "1" => "Port name #1"
 * );
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

$ports = array();

/**
 * We're using helper here, but you can use default snmp functions for php
 * http://www.php.net/manual/en/ref.snmp.php
 */

$snmp = HBLoader::LoadComponent('Net/SNMP_wrapper');
$snmp->Connect($app['ip'],161,$app['read']);


$addressbit = 'SNMPv2-SMI::enterprises.10381.1.3.1.3.2.1.8.';
$tree = $snmp->Get('.1.3.6.1.4.1.10381.1.3.1.1.1.0');
if(!$tree) {
    throw new Exception("Unable to fetch number of device ports");
}

$tree = preg_replace("/[^0-9]/","",$tree);
$ports=[];
for($i=1;$i<=$tree;$i++) {
    $ports[$i]="C".$i;
}
