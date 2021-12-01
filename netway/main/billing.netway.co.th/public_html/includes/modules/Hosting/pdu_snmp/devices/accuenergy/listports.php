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


require_once HBFDIR_LIBS . DS . 'resty' . DS . 'class.resty.php';

$r = new Resty();
$r->setBaseURL(stristr($app['ip'], 'http') ? $app['ip'] : "http://{$app['ip']}/");
$r->useCurl(true);

$page = $r->get('/basic.cgi?sid=0.'.microtime(true));
if($page['body']) {
    $items = explode("\n",$page['body']);
    if($items) {
        $ports[0]=1;
    }
} else {
    throw new Exception("Unable to access /basic.cgi on this device. Currently it should enable login-less access to work");
}
