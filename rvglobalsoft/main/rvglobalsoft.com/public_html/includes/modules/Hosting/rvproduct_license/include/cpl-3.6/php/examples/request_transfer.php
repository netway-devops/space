<?php
include("cpl.inc.php");
$cpl = new cPanelLicensing("__USERNAME__", "__PASSWORD__");

$ip = "__IP_TO_TRANSFER__";

$group = $cpl->findKey("__GROUP_NAME__", $cpl->fetchGroups() );
$package = $cpl->findKey("__PACKAGE_NAME__", $cpl->fetchPackages() );

$result = (array)$cpl->requestTransfer( array(
    "ip" => $ip,
    "groupid" => $group,
    "packageid" => $package
    )
);

print $result["@attributes"]['reason'] . "\n";
?>
