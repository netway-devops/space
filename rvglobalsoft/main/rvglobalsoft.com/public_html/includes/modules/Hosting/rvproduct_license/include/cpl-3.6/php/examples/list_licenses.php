<?php

include("../cpl.inc.php");

$cpl = new cPanelLicensing("__USERNAME","__PASSWORD__");

$licenses = $cpl->fetchLicenses();

foreach ( $licenses->licenses as $lisc ) {
    $lisc = (array)$lisc;
    print "\nLicense IP: " . $lisc['@attributes']['ip'] . "\n";
    print "        ID: " . $lisc['@attributes']['name'] . "\n";
    print "   groupid: " . $lisc['@attributes']['groupid'] . "\n";
    print " packageid: " . $lisc['@attributes']['packageid'] . "\n";
    print "   adddate: " . $lisc['@attributes']['adddate'] . "\n";
}

?>
