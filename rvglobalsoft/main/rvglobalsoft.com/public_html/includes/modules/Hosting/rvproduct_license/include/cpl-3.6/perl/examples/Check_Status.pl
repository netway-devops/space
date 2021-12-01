#!/usr/bin/perl

use cPanelLicensing;

my $ip = '__IPTOCHEK__';
my $licenseManager = new cPanelLicensing(user => '__YOU@HOST.COM__',
                                         pass => '__YOURPASS__');

my $liscid_ref = $licenseManager->fetchLicenseRaw(ip => $ip);
if ($liscid_ref) {
    my $valid = $liscid_ref->{'valid'};
    my $company = $liscid_ref->{'company'};
    print "The license id for ip address: ${ip} is: ${liscid}\n";
    print "The valid of the license is :" . ($valid == 1 ? 'Active' : ($valid == 0 ? 'Never Activated' : 'Expired')) . "\n";
    print "The company holding the license is : " . $company . "\n";
} else {
    print "There is no active license for ip address: ${ip}\n";
}

