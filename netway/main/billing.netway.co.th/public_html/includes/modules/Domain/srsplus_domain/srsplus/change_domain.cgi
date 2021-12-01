#!/usr/bin/perl

use lib qw (/home/managene/public_html/includes/modules/Domain/srsplus_domain/srsplus);
use DotSRS_Client;

&get_data;

#$query{'extension'} =~s/\.//;

my $srs_client = new DotSRS_Client;

$domain_ref = {
    'DOMAIN' => "$query{'DOMAIN'}",
    'TLD' => "$query{'TLD'}",
    'RESPONSIBLE PERSON' => $query{'RESPONSIBLE_PERSON'},
    'TECHNICAL CONTACT' => $query{'TECHNICAL_CONTACT'},
    'DNS SERVER NAME 1' => "$query{'DNS_SERVER_NAME_1'}",
    'DNS SERVER NAME 2' => "$query{'DNS_SERVER_NAME_2'}",
    'DNS SERVER NAME 3' => "$query{'DNS_SERVER_NAME_3'}",
    'DNS SERVER NAME 4' => "$query{'DNS_SERVER_NAME_4'}",
};

$request_id = $srs_client->change_domain( 1, $domain_ref );

if( $request_id ){
    print "requestID = $request_id\n";
}
else{
    print "register_domain failed.\n";
}

foreach $key (keys %{ $ref }) {
    print "$key : ", $ref->{$key},"\n";
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

