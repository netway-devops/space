<?php
include("../cpl.inc.php");
$cpl = new cPanelLicensing("__USERNAME__", "__PASSWORD__");


$oldip = "__SOURCEIP__";
$newip = "__DESTINATIONIP__";

$response = (array)$cpl->changeip( array(
    "oldip" => $oldip,
    "newip" => $newip
) );

print $response['@attributes']['reason'] . "\n";

?>
