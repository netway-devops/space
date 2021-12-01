<?php



require_once MAINDIR."includes/modules/Hosting/pdu_snmp/devices/ubiquiti_mfi/class.ubi_wrapper.php";
$r = new Ubi_wrapper($app['ip'],$app['read'],$app['write']);

$d=$r->get('/api/v1.0/list/sensors');
$json = json_decode($d,true);
if(!$d || !$json) {
    throw new Exception("Expected json return, got ".$d);
}
foreach($json['data'] as $sensor) {
    if($sensor['_id']==$port) {
        $current = $sensor['amps'] * 1000;
            break;
    }

}

