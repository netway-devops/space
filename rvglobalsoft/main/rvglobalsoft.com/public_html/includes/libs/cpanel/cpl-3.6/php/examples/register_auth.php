<?php

include("cpl.inc.php");

$cpl = new cPanelLicensing("", "");
$response = $cpl->registerAuth(array(
    "user" => "__USERNAME__",
    "pickup" => "__PHRASE__",
    "service" => "__SERVICE__"));

echo $response;

?>
