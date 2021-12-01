#!/usr/bin/perl

use lib qw (/home/managene/public_html/includes/modules/Domain/srsplus_domain/srsplus);
use DotSRS_Client;

&get_data;

# $query{'extension'} =~s/\.//;

$domain_ref = {
'DOMAIN' => "$query{'DOMAIN'}",
'TLD' => "$query{'TLD'}",
'TERM YEARS' => $query{'TERM_YEARS'},
'PRICE' => $query{'PRICE'}
};

my $srs_client = new DotSRS_Client;

($request_id,$ref) = $srs_client->renew_domain( 1, $domain_ref );

if( $request_id ){
    print "requestID = $request_id\n";
    foreach $key (keys %{ $ref }) {
        print "$key : ", $ref->{$key},"\n";
    }
}
else{
    print "renew_domain failed.\n";
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

