<?php
include("../cpl.inc.php");
$cpl = new cPanelLicensing("__USERNAME__", "__PASSWORD__");

$ip = "__IP__";

$lisc = (array)$cpl->fetchLicenseID( array("ip" => $ip) );

$id = $lisc['@attributes']['licenseid'];

if ( $id > 0 ) {
    $result = (array)$cpl->reactivateLicense( array( 'liscid' => $id, reactivateok => 1 ) );
} else {
    print "no expired license exists for $ip\n";
}

if ($result['@attributes']['status']) {
    print "the liscense for $ip has been reactivated\n";
} else {
    print "Failed to reactivate license!\n";
}

?>
