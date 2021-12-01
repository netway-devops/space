#!/usr/bin/perl

use lib qw (/home/managene/public_html/includes/modules/Domain/srsplus_domain/srsplus);
use DotSRS_Client;

&get_data;

$query{'TLD'} =~s/\.//;

my $srs_client = new DotSRS_Client;

$domain_ref = { 
    'DOMAIN'              => "$query{'DOMAIN'}",
    'TLD'                 => "$query{'TLD'}",
    'RESPONSIBLE PERSON'  => "$query{'REGISTRANT_CONTACT_ID'}",
    'TECHNICAL CONTACT'   => "$query{'TECHNICAL_CONTACT_ID'}",
    'BILLING CONTACT'     => "$query{'BILLING_CONTACT_ID'}",
    'ADMIN CONTACT'       => "$query{'ADMIN_CONTACT_ID'}",
};

$request_id = $srs_client->change_domain( 1, $domain_ref );

if( $request_id ){
    print "requestID = $request_id\n";
}
else{
    print "change_domain failed.\n";
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


