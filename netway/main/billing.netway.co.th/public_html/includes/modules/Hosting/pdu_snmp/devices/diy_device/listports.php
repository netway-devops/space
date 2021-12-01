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


$method = 'listports';
require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';

$snmp = setup_pdu_connection($app);

$ports = [];

$oid = prepare_oid($app['custom']['config'][$method]['oid']);

$tree = [];
$snmp->oid_output_format = SNMP_OID_OUTPUT_NUMERIC;

$this->_log("INFO","Using OID: ".$oid);
$tree = $snmp->walk($oid,true);


$this->_log("INFO","Got tree: ".var_export($tree,true));




if(is_array($tree) && !empty ($tree)) {
    foreach($tree as $k=>$itm) {
        if(stripos($itm,'STRING:')!==false) {
            //lets assume, we have outlet name hold as string

            $x=str_ireplace(array('STRING: ','"'), '', $itm);
            if($x) {
                $ports[$k]=$x;
            }
        }

    }
}
