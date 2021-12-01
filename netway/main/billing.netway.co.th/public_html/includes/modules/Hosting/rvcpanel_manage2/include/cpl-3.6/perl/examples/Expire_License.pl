#!/usr/bin/perl

use cPanelLicensing;

my $ip = '__IPTOEXPIRE__';

my $licenseManager = new cPanelLicensing(
    user => '__YOU@HOST.COM__',
    pass => '__YOURPASS__'
);

my $liscid = $licenseManager->fetchLicenseId( 'ip' => $ip );
if ( $liscid > 0 ) {
    my $result = $licenseManager->expireLicense(
        'liscid'  => $liscid,
        'reason'  => 'Automatic Removal',
        'expcode' => 'normal'
    );

    print "$result\n";
}
else {
    print "There is no active license for ip address: ${ip}\n";
}
