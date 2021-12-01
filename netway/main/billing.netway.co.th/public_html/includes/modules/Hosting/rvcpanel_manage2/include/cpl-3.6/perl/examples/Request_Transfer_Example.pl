#!/usr/bin/perl

use cPanelLicensing;

my $ip = '__IPTOTRANSFER__';

my $licenseManager = new cPanelLicensing(user => '__YOU@HOST.COM__',
                    pass => '__YOURPASS__');

my (%LICENSES) = $licenseManager->fetchLicenses();

my (%GROUPS) = $licenseManager->fetchGroups();
my (%PACKAGES) = $licenseManager->fetchPackages();

my $groupid = $licenseManager->findKey('__GROUPNAME__',\%GROUPS);
my $packageid = $licenseManager->findKey('__PACKAGENAME__',\%PACKAGES);

#status = -1, invalid data
#status = 0 , request failed
#status = 1 , request accepted

my ($status,$reason) = $licenseManager->requestTransfer(ip => $ip,
                groupid => $groupid,
                packageid => $packageid);

print $reason;
