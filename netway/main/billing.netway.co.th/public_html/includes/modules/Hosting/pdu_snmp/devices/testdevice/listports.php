<?php
/**
 * This is just test device, do not use it for production
 */

$dev = new \Hosting\PDU_SNMP\Devices\TestDevice\TestDevice();
$ports = $dev->listPorts();