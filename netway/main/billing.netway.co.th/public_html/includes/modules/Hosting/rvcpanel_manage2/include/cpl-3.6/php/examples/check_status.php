<?php
include("../cpl.inc.php");
$cpl = new cPanelLicensing("__USERNAME__", "__PASSWORD__");

$ip = "__IP__";

$status = (array)$cpl->fetchLicenseRaw(array(
    "ip" => $ip
    )
);

print "The license id for the ip is: ". $status["@attributes"]["licenseid"] . "\n";
print "The status of the license is: ";
if ($status["@attributes"]["valid"] > 0) {
    print "Active";
} else {
    print "Inactive";
}
print "\n";
print "The company holding the license is: " . $status["@attributes"]["company"] . "\n";

?>
