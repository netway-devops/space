<?php

/**
 * Get current acumulated kWh of a port
 * This is used by power meter billing
 *
 * This is "fake" kwh readout, it uses avg amperage stored in db trough \power_collector module
 *
 * For instance: $port = '3';
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

$method = 'kwh';

require_once MAINDIR.'includes/modules/Hosting/pdu_snmp/devices/diy_device/_common.php';
$action_port = isset($port) ? $port :  $app['custom']['config'][$method]['port'];
$oid = prepare_oid($app['custom']['config'][$method]['oid'], $action_port);

if (empty($oid)) {
    $power = ModuleFactory::singleton()->getModuleByFname('class.power_collector.php');
    if(!$power) {
        throw new Exception("Power_Collector module is not active");
    }
    $date_to = date('Y-m-d H:i:s');
    $date_from = date('Y-m-d H:i:s',strtotime($date_to.' - 1 hour'));
    $kwh = $power->getPower($app['id'],$port,$date_from,$date_to);
} else {


    $snmp = setup_pdu_connection($app);

    $this->_log("INFO","Using OID: ".$oid);

    $kwh = $snmp->get($oid);

    $this->_log("INFO","Data returned by device: ".var_export($kwh,true));

    if(!$kwh)
        throw new Exception("Unable to fetch port accumulated from PDU");

    $kwh = str_ireplace('INTEGER: ','',$kwh);

    $unit = $app['custom']['config'][$method]['unit'];
    switch ($unit) {
        case 'Wh':
            $kwh /= 1000;
            break;
        case 'kWh':
            $kwh *= 1;
            break;
        case 'MWh':
            $kwh *= 1000;
            break;
    }

}