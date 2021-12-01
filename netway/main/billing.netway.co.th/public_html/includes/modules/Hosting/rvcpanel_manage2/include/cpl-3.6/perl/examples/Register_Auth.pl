#!/usr/bin/perl

=head1 DESCRIPTION

Registers a given user with manage2 using a pickup password. Once its
used on the device, it no longer will be valid. It will save the key to
a file called manage2key.

This is a command line script that is run without arguments and will
prompt you for a pass phrase, on stdin.

=cut

use strict;
use warnings;
use cPanelLicensing;

my $user = prompt("Manage2 username: ");
my $pickup = prompt("Pickup passphrase: ");
my $service = prompt("Service name: ");

my $cpl = cPanelLicensing->unauthNew;
my $result = $cpl->registerAuth(
    user => $user, pickup => $pickup, service => $service);

my $key_file = "manage2key";
print "your key is:\n$response->{key}\n";
open my $fh, ">", $key_file or die "Can't open $key_file for writing: $!";
print $fh "$user\n$response->{key}\n";
close $fh;
print "saved key to $key_file";

sub prompt {
    my ($mesg) = @_;
    print STDERR $mesg;
    my $response = <STDIN>;
    chomp $response;
    $response;
}
