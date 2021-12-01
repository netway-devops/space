#!/usr/bin/perl

use cPanelLicensing;

my $oldip = '__SOURCEIPTOTRANSFER__';
my $newip = '__TARGETIPTOTRANSFER__';

my $licenseManager = new cPanelLicensing(
    user => '__YOU@HOST.COM__',
    pass => '__YOURPASS__'
);

#status = -1, invalid data
#status = 0 , request failed
#status = 1 , request accepted

my ( $status, $reason ) =
  $licenseManager->changeip( oldip => $oldip, newip => $newip );

print $reason;
