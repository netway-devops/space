#!/usr/bin/perl

use cPanelLicensing;

my $ip = '__IPTOCHEK__';

my $licenseManager = new cPanelLicensing(
    user => '__YOU@HOST.COM__',
    pass => '__YOURPASS__'
);

#
# This is only useful to cPanel Distributors
#

my $risk_ref = $licenseManager->fetchLicenseRiskData( ip => $ip );
if ($risk_ref) {
    my $aggregate   = $risk_ref->{'riskscore.aggregate.score'};
    my $directorder = $risk_ref->{'riskscore.directorder.score'};
    my $main        = $risk_ref->{'riskscore.main.score'};
    print "Risk Scores for $ip:\n";
    print "aggregate : $aggregate\n";
    print "directorder : $directorder\n";
    print "main : $main\n";
}
else {
    print "There is no risk data for $ip\n";
}
