#!/usr/bin/perl

use lib qw (/home/managene/public_html/includes/modules/Domain/srsplus_domain/srsplus);
use DotSRS_Client;

&get_data;

my $srs_client = new DotSRS_Client;

$contact_ref = {
'TLD' => "$query{'TLD'}",
'CONTACTID' => "$query{'CONTACTID'}",
'FNAME' => "$query{'FNAME'}",
'LNAME' => "$query{'LNAME'}",
'ORGANIZATION' => "$query{'ORGANIZATION'}",
'EMAIL' => "$query{'EMAIL'}",
'ADDRESS1' => "$query{'ADDRESS1'}",
'ADDRESS2' => "$query{'ADDRESS2'}",
'CITY' => "$query{'CITY'}",
'PROVINCE' => "$query{'PROVINCE'}",
'POSTAL CODE' => "$query{'POSTAL_CODE'}",
'COUNTRY' => "$query{'COUNTRY'}",
'PHONE' => "$query{'PHONE'}"
};

($contact_id, $request_id) = $srs_client->edit_contact( 1, $contact_ref );

if ($contact_id) {
    print "\n";
    print "contactID=$contact_id\n";
    print "requestID=$request_id\n";
} else{
    # ‘error’ member of client has descriptive error string(s)
    print "Error(s) editing contact:\n";
    print $srs_client->{'error'};
    print "\n";
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

