<?php
/**
 * HostBill will load this file when it will need to list available Ports in Switch over SNMP
 *
 * Load available ports into $ports array - HostBill will read from it.
 * I.e.:
 * $ports = array(
 *  "1" => "Port name #1",
 *  "2" => "Port name #2"
 * );
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

$wrapper = HBLoader::LoadComponent('Net/SNMP_wrapper2');
$snmp = $wrapper->connect($app['ip'], 161, $app['read'], 3, $app['security']);

$ports = array();

$tree = $snmp->walk('.1.3.6.1.2.1.2.2.1.2');
if(is_array($tree) && !empty ($tree)) {
    foreach($tree as $k=>$itm) {
        $ports[str_ireplace('IF-MIB::ifDescr.', '', $k)]=str_ireplace(array('STRING: ','"'), '', $itm);
    }
}
