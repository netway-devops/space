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


require_once MAINDIR."includes/modules/Hosting/pdu_snmp/devices/ubiquiti_mfi/class.ubi_wrapper.php";
$r = new Ubi_wrapper($app['ip'],$app['read'],$app['write']);

$d=$r->get('/api/v1.0/list/sensors');
$json = json_decode($d,true);
if(!$d || !$json) {
    throw new Exception("Expected json return, got ".$d);
}
foreach($json['data'] as $sensor) {
    if(stripos($sensor['model'],'Ubiquiti mFi-CS')!==false) {
        $ports[$sensor["_id"]]=$sensor["label"];
    }
}

