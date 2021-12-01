#!/usr/bin/perl

use lib qw (/home/managene/public_html/includes/modules/Domain/srsplus_domain/srsplus);
use DotSRS_Client;

&get_data;

#$query{'extension'} =~s/\.//;

my $srs_client = new DotSRS_Client;

$ns_ref = { 'DNS SERVER NAME' => "$query{'DNS_SERVER_NAME'}" };

$ref = $srs_client->get_nameserver_info( 1, $ns_ref );

if( $ref ){
    foreach $key (keys %{ $ref }) {
        print "$key : ", $ref->{$key},"\n";
    }
}
else{
    die "nameserver_info failed\n";
}

exit;

sub get_data {
    if (length ($ENV{'QUERY_STRING'}) > 0){
       my $buffer = $ENV{'QUERY_STRING'};
         my @pairs = split(/&/, $buffer);
         foreach (@pairs){
             my  ($name, $value) = split(/=/, $_);
              $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
              $query{$name} = $value; 
              }
         }
}

