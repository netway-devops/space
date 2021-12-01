<?php


/**
 * Setup SNMP object with app connection details
 * @param $app
 * @return \SNMP
 */
function setup_pdu_connection($app) {

    $version = \SNMP::VERSION_1;
    if ($app['custom']['snmp'] === 'v2c')
        $version = \SNMP::VERSION_2c;
    elseif ($app['custom']['snmp'] === 'v3')
        $version = \SNMP::VERSION_3;


    $snmpport = $app['snmpport'] ? : 161;
    $ip = explode(':', $app['ip']);
    if (isset($ip[1]))
        $snmpport = $ip[1];

    $hostname = "{$ip[0]}:{$snmpport}";

    $read = $app['read'];
    if (empty($read))
        $read = '';


    $snmp = new \SNMP($version, $hostname, $read);

    if ($version === \SNMP::VERSION_3) {
        $v3 = $app['custom']['v3'];
        $snmp->setSecurity($v3['sec_level'], $v3['auth_protocol'], $v3['auth_passphrase'], $v3['priv_protocol'], $v3['priv_passphrase'], $v3['contextName'], $v3['contextEngineID']);
    }

    return $snmp;

}

/**
 * Prepare OID
 * @param string $oid
 * @param string $port
 * @return string
 * @throws Exception
 */
function prepare_oid($oid,$port = '') {
    $oid = ltrim($oid,'.');
    if (empty($oid)) {
        throw new Exception("OID is missing or in wrong format");
    } elseif(is_numeric($oid[0])) {
        $oid = '.'.$oid;
    }

    $oid = Template::showFromSource($oid, array('port' => $port));

    return $oid;
}