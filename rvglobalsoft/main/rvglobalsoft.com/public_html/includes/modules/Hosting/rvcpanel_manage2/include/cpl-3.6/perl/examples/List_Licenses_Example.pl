#!/usr/bin/perl

use cPanelLicensing;

my $licenseManager = new cPanelLicensing(user => '__YOU@HOST.COM__',
                                        pass => '__YOURPASS__');

my (%GROUPS) = $licenseManager->fetchGroups();
my (%PACKAGES) = $licenseManager->fetchPackages();
my (%LICENSES) = $licenseManager->fetchLicenses();

format STDOUT =
@>>>>>>> @<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<< @<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<
$liscid, $ip, $hostname, $group, $package, $adddate
.

my $i = 10;
foreach $liscid (keys %LICENSES) {
    if ($i % 10 == 0) {
        print "LISCID   IPADDR           HOSTNAME               GROUP            PACKAGE      ADDDATE\n";
    }
    $i++;

#    $LICENSES{$liscid} = {
#          'distro' => 'Distro',
#          'version' => 'cPanel Version',
#          'ip' => 'License Ip Address',
#          'hostname' => 'Hostname',
#          'package' => 'Numeric Package Id',
#          'os' => 'Operating System',
#          'envtype' => 'Environment type (vps?)',
#          'groupid' => 'Numeric Group Id',
#          'osver' => 'Kernel/OS Version',
#          'adddate' => 'Date License was added (Unixtime)'
#        };

    $ip = $LICENSES{$liscid}{ip};
    $hostname = $LICENSES{$liscid}{hostname};
    $group = $GROUPS{$LICENSES{$liscid}{groupid}};
    $package = $PACKAGES{$LICENSES{$liscid}{packageid}};
    $adddate = localtime($LICENSES{$liscid}{adddate});
    write;
}


