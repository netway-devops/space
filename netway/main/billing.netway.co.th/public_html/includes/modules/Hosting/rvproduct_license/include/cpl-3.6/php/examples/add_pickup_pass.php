<?php

include("../cpl.inc.php");

$cpl = new cPanelLicensing("__USERNAME__", "__PASSWORD__");
$response = $cpl->addPickupPass(array("pickup" => "__PHRASE__"));

echo $response;

?>
