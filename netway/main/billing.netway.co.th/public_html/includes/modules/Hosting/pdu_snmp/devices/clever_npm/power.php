<?php

/**
 * Cycle power of port in PDU device.
 *
 * Under $state; HostBill will load state we need to set port into.
 * if($state) {
 *    //power ON
 * } else {
 *    //power OFF
 * }
 *
 * Under $port variable HostBill will load port in question.
 * For instance: $port = '3';
 * So cycle power of port 3:
 * OID: .1.3.6.1.4.1.34097.3.1.1.7.3
 *
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
$session = new Requests_Session(stristr($app['ip'], 'http') ? $app['ip'] : "http://{$app['ip']}/",["Connection"=>"keep-alive"]);

$session->useragent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.143 Safari/537.36 FirePHP/4Chrome';
$response = $session->get('login?id1='.$app['custom']['username'].'&id2=' . $app['custom']['password'].'&');
if(stripos($response->body,'failed')!==false) {
    throw new Exception("Login failed");
} elseif($response->status_code!=302 && stripos($response->body, 'status.html')===false) {
    throw new Exception("Wrong status code, expected redirect, got: ".$response->status_code);
}

//power port
$port-=1;
try {

    if ($state) {
        $response = $session->get('operatoutput?id1=0&id2='.$port.'&id3=0',["Accept"=>"text/plain, */*; q=0.01",'X-Requested-With'=>'XMLHttpRequest']);
    } else {
        $response = $session->get('operatoutput?id1=0&id2='.$port.'&id3=1&',["Accept"=>"text/plain, */*; q=0.01",'X-Requested-With'=>'XMLHttpRequest']);
    }

} catch(Exception $e) {
    //most likely empty reply from server, ignore
}
$return =1;