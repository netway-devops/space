<?php
include("../cpl.inc.php");
$cpl = new cPanelLicensing("__USERNAME__", "__PASSWORD__");

$ip = "__IP__";

$lisc = (array)$cpl->fetchLicenseId( array( "ip" => $ip ) );
$liscid = $lisc["@attributes"]["licenseid"];

if ( $liscid > 0 ) {
    $expire = (array)$cpl->expireLicense(array(
        liscid => $liscid,
        reason => "Automagic Expiration",
        expcode => "normal"
        )
    );
    print $expire["@attributes"]["result"] . "\n";
} else {
    print "There is no valid license for $ip\n";
}

?>
