#!/usr/bin/perl
use cPanelLicensing;

my $user = '__YOU@HOST__';
my $pass = '__YOUR_PASS__';
my $pickup_pass = '__A_NEW_PICKUP_PASSPHRASE__';

my $cpl = cPanelLicensing->new(user => $user, pass => $pass);
my $response = $cpl->addPickupPass(pickup => $pickup_pass);
print $response->{reason}, "\n";

