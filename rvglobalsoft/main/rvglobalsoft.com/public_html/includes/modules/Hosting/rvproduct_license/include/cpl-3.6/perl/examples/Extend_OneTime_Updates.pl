#!/usr/bin/perl

use cPanelLicensing;

my $ip = '__IPTOEXTENDUPDATES__';

my $licenseManager = new cPanelLicensing(user => '__YOU@HOST.COM__',
                                        pass => '__YOURPASS__');

#status = -1, invalid data
#status = 0 , request failed
#status = 1 , request accepted

my ( $status, $reason ) =
  $licenseManager->extend_onetime_updates( ip => $ip );
# This will bill your account.

print $reason;
