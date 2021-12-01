<?php
include("../cpl.inc.php");
$cpl = new cPanelLicensing("__USERNAME__", "__PASSWORD__");
$ip = "__IP__";
$lisc = (array) $cpl->fetchLicenseId(array("ip" => $ip));
$id = $lisc['licenseid'];
$id = is_array($id) ? $id[0] : $id;
if ($id) {
    print "The license id for $ip is $id\n";
}
else {
    print "No valid license exists for $ip\n";
}
?>

