#!/usr/bin/perl

package cPanelLicensing;

our $VERSION = 3.6;

use strict;
use Socket         ();
use Data::Dumper   ();
use Carp           ();
use LWP::UserAgent ();
use Net::SSLeay    ();
use URI            ();

our $manage2_url = "https://manage2.cpanel.net";
our $manage2_domain = "manage2.cpanel.net:443";
our $manage2_realm = "cPanel Licensing System";

# Arguments to new can include:
#    - user => $user
#    - pass => $pass
#    - key  => $key (alias for pass when pass is a key)
#    - file => $file (contains a username and [usually] a key)
sub new {
    my ( $self, %OPTS ) = @_;

    $self = bless {};
    $self->{"ua"} = LWP::UserAgent->new(
        agent => "cPanel Licensing Agent (perl) $VERSION");

    my @PARSERS = (
        [ 'XML::Simple', 'xml' ],
        [ 'JSON::Syck',  'json' ],
        [ 'YAML::Syck',  'yaml' ],
        [ 'YAML',        'yaml' ],
        [ 'JSON',        'json' ],
        [ 'JSON::XS',    'json' ],

    );

    foreach my $parser (@PARSERS) {
        my $parser_module = $parser->[0];
        my $parser_key    = $parser->[1];
        eval " require $parser_module; ";
        if ( !$@ ) {
            $self->{'parser_key'}    = $parser_key;
            $self->{'parser_module'} = $parser_module;
            last;
        }
    }
    if ($@) {
        Carp::confess(
            "Unable to find a module capable of parsing the api response.");
    }

    if (!$OPTS{"do_not_authenticate"}) {
        $self->authenticate(%OPTS);
    }

    return ($self);
}

# unauthenticated new
sub unauthNew {
    new(@_, do_not_authenticate => 1);
}

# Fills in LWP user agent's credentials with user and pass from the
# constructors arguments. Or from a file, if provided.
sub authenticate {
    my ($self, %args) = @_;
    my $user = $args{"user"};
    my $pass = $args{"key"} || $args{"pass"};
    my $file = $args{"file"};
    if (defined $file) {
        open my $fh, $file or die "Unable to open $file: $!";
        $user = <$fh>;
        chomp $user;
        $pass = do {local $/; <$fh>};
        chomp $pass;
        close $fh;
    }
    if (!defined $user || $user eq "") {
        Carp::confess("Manage username not set.");
    }
    if (!defined $pass || $pass eq "") {
        Carp::confess("Manage password not set.");
    }
    $self->{"ua"}->credentials($manage2_domain, $manage2_realm, $user, $pass);
}

sub reactivateLicense {
    my ($self, %opts) = @_;
    my $licref = $self->_HashReq(
          "$manage2_url/XMLlicenseReActivate.cgi",
          %opts,
          output => $self->{"parser_key"});
    return ($licref->{"licenseid"});
}

sub expireLicense {
    my ( $self, %OPTS ) = @_;

    my (%FORM);

    $FORM{'liscid'} = $OPTS{'liscid'};
    $FORM{'reason'} = $OPTS{'reason'};
    $FORM{'expcode'} = $OPTS{'expcode'};
    $FORM{'output'} = $self->{'parser_key'};

    my $response =
        $self->{'ua'}->post("$manage2_url/XMLlicenseExpire.cgi", \%FORM);

    my ($resultref);
    if ( $response->is_success ) {
        $resultref = $self->parseResponse( $response->content );
    }
    else {
        Carp::confess( $response->status_line );
    }

    if ( int( $$resultref{'status'} ) != 1 ) {
        Carp::confess( "Failed to expire license: "
              . $$resultref{'reason'} . "\n"
              . Data::Dumper::Dumper($resultref) );
    }

    return ( $$resultref{'result'} );
}

sub extend_onetime_updates {
    my ( $self, %OPTS ) = @_;

    my %FORM;
    $FORM{'ip'}     = Socket::inet_ntoa( Socket::inet_aton( $OPTS{'ip'} ) );

    my $response =
        $self->{'ua'}->post("$manage2_url/XMLonetimeext.cgi", \%FORM);

    my ($resultref);
    if ( $response->is_success ) {
        $resultref = $self->parseResponse( $response->content );
    }
    else {
        Carp::confess( $response->status_line );
    }

    return ( $resultref->{'status'}, $resultref->{'reason'} );
}


sub changeip {
    my ( $self, %OPTS ) = @_;

    my %FORM;
    $FORM{'output'} = $self->{'parser_key'};
    $FORM{'oldip'}  = Socket::inet_ntoa( Socket::inet_aton( $OPTS{'oldip'} ) );
    $FORM{'newip'}  = Socket::inet_ntoa( Socket::inet_aton( $OPTS{'newip'} ) );
    $FORM{'packageid'} = $OPTS{'packageid'};

    my $response =
        $self->{'ua'}->post("$manage2_url/XMLtransfer.cgi", \%FORM);

    my ($resultref);
    if ( $response->is_success ) {
        $resultref = $self->parseResponse( $response->content );
    }
    else {
        Carp::confess( $response->status_line );
    }

    return ( $resultref->{'status'}, $resultref->{'reason'} );
}


sub requestTransfer {
    my ( $self, %OPTS ) = @_;

    my %FORM;
    if ( int( $OPTS{'groupid'} ) == 0 ) {
        Carp::confess('Group Id is not valid');
    }
    $FORM{'groupid'} = int( $OPTS{'groupid'} );
    if ( int( $OPTS{'packageid'} ) == 0 ) {
        Carp::confess('Package Id is not valid');
    }
    $FORM{'packageid'} = int( $OPTS{'packageid'} );
    if ( $OPTS{'ip'} eq '' ) {
        Carp::confess('Ip Address is not valid');
    }
    $FORM{'output'} = $self->{'parser_key'};
    $FORM{'ip'}     = Socket::inet_ntoa( Socket::inet_aton( $OPTS{'ip'} ) );

    my $response =
        $self->{'ua'}->post("$manage2_url/XMLtransferRequest.cgi", \%FORM);

    my ($resultref);
    if ( $response->is_success ) {
        $resultref = $self->parseResponse( $response->content );
    }
    else {
        Carp::confess( $response->status_line );
    }

    return ( $resultref->{'status'}, $resultref->{'reason'} );
}

sub activateLicense {
    my ( $self, %OPTS ) = @_;

    my (%FORM);
    $FORM{'output'} = $self->{'parser_key'};

    $FORM{'legal'} = 1;    #customer is responsible for verifing this
    if ( int( $OPTS{'groupid'} ) == 0 ) {
        Carp::confess('Group Id is not valid');
    }
    $FORM{'groupid'} = int( $OPTS{'groupid'} );
    if ( int( $OPTS{'packageid'} ) == 0 ) {
        Carp::confess('Package Id is not valid');
    }
    $FORM{'packageid'} = int( $OPTS{'packageid'} );
    $FORM{'force'}     = int( $OPTS{'force'} );
    $FORM{'reactivateok'} = int ($OPTS{'reactivateok'});
    $FORM{'noattr'} = 1;

    if ( $OPTS{'ip'} eq '' ) {
        Carp::confess('Ip Address is not valid');
    }
    $FORM{'ip'} = Socket::inet_ntoa( Socket::inet_aton( $OPTS{'ip'} ) );

    my $response =
        $self->{'ua'}->post("$manage2_url/XMLlicenseAdd.cgi", \%FORM);

    my ($resultref);
    if ( $response->is_success ) {
        $resultref = $self->parseResponse( $response->content );
    }
    else {
        Carp::confess( $response->status_line );
    }

    if ($resultref->{'status'} != 1) {
        my $reason = delete $resultref->{reason};
        die "Failed to add license:\n$reason\n" .
            Data::Dumper::Dumper($resultref);
    }

    return ( $$resultref{'licenseid'} );
}

sub findKey {
    my ( $self, $searchkey, $href ) = @_;
        my $regex;

        if ( $searchkey ) {
            eval {
                local $SIG{'__DIE__'} = sub { return };
                $regex = qr/^$searchkey$/i;
            };
        }

        if ( !$regex ) {
            Carp::confess("Regular Expression generation failure");
            return;
        } else {
            foreach my $key ( keys %{ $href } ) {
                if ($href->{$key} =~ $regex) {
                    return $key
                }
            }
        }
    Carp::confess( "Key ${searchkey} not found in hash:\n" . Data::Dumper::Dumper($href) );
}

sub fetchGroups {
    my $self = shift;
    my $groupsref = $self->_HashReq(
          "$manage2_url/XMLgroupInfo.cgi",
          output => $self->{"parser_key"});

    _stripType( $$groupsref{'groups'} );

    return ( %{ $$groupsref{'groups'} } );
}

sub fetchLicenseRiskData {
    my ( $self, %OPTS ) = @_;

    my $ip = $OPTS{'ip'};
    my $licref = $self->_HashReq(
        "$manage2_url/XMLsecverify.cgi",
        ip => $ip,
        output => $self->{"parser_key"});

    return ($licref);
}

sub fetchLicenseRaw {
    my ($self, %opts) = @_;
    %opts = (all => 1, %opts);
    my $lic = $self->_HashReq(
        "$manage2_url/XMLRawlookup.cgi",
        %opts,
        output => $self->{"parser_key"});
    return ($lic);
}

sub fetchLicenseId {
    my ($self, %opts) = @_;
    %opts = (all => 1, %opts);
    my $lic = $self->_HashReq(
        "$manage2_url/XMLlookup.cgi",
        %opts,
        output => $self->{"parser_key"});
    return $lic->{"licenseid"};
}

sub fetchPackages {
    my $self = shift;
    my $packagesref = $self->_HashReq(
        "$manage2_url/XMLpackageInfo.cgi",
        output => $self->{"parser_key"});

    _stripType( $$packagesref{'packages'} );

    return ( %{ $$packagesref{'packages'} } );
}

sub fetchLicenses {
    my $self = shift;
    my $licensesref = $self->_HashReq(
        "$manage2_url/XMLlicenseInfo.cgi",
        output => $self->{"parser_key"});

    _stripType( $$licensesref{'licenses'} );

    return ( %{ $$licensesref{'licenses'} } );
}

sub fetchExpiredLicenses {
    my $self = shift;
    my $licensesref = $self->_HashReq(
        "$manage2_url/XMLlicenseInfo.cgi",
        expired => 1,
        output => $self->{"parser_key"});

    _stripType( $$licensesref{'licenses'} );

    return ( %{ $$licensesref{'licenses'} } );
}

sub _stripType {
    my ($href) = @_;

    #strips of the first letter of the ID (ie P1213 becomes 1213)
    foreach my $key ( keys %{$href} ) {

        $$href{ substr( $key, 1 ) } = $$href{$key};
        delete $$href{$key};
    }

}

sub _HashReq {
    my ($self, $url_str, %params) = @_;
    my $url = URI->new($url_str);
    $url->query_form($url->query_form, %params);
    my $response = $self->{'ua'}->get($url);
    my ($sref);
    if ( $response->is_success ) {
        $sref = $self->parseResponse( $response->content );

        if ( int( $$sref{'status'} ) != 1 ) {
            die "$sref->{reason}\n";
            #Carp::confess( "Failed to process request: "
            #      . $$sref{'reason'} . "\n"
            #      . Data::Dumper::Dumper($sref) );
        }

    }
    else {
        die $response->status_line, "\n";
        #Carp::confess( $response->status_line );
    }

    return ($sref);
}

sub parseResponse {
    my ( $self, $content ) = @_;
    my $ref;

    if ( $self->{'parser_module'} eq 'JSON::Syck' ) {
        eval { $ref = JSON::Syck::Load($content); };
    }
    elsif ( $self->{'parser_module'} eq 'JSON' ) {
        eval { $ref = JSON::from_json($content); };
    }
    elsif ( $self->{'parser_module'} eq 'JSON::XS' ) {
        eval { $ref = JSON::XS::decode_json($content); };
    }
    elsif ( $self->{'parser_module'} eq 'YAML' ) {
        eval { $ref = YAML::Load($content); };
    }
    elsif ( $self->{'parser_module'} eq 'YAML::Syck' ) {
        eval { $ref = YAML::Syck::Load($content); };
    }
    elsif ( $self->{'parser_module'} eq 'XML::Simple' ) {
        eval { $ref = XML::Simple::XMLin($content); };
    }

    if ( !$ref ) {
        Carp::confess(
"Unable to parse $self->{'parser_key'}: eval_error: $@ content: $content."
        );
    }
    return $ref;
}

sub addPickupPass {
    my ($self, %opts) = @_;
    $self->_HashReq(
        "$manage2_url/XMLaddPickupPass.cgi",
        pickup => $opts{pickup},
        output => $self->{"parser_key"},
    );
}

sub registerAuth {
    my ($self, %opts) = @_;
    my $response = $self->_HashReq(
        "$manage2_url/XMLregisterAuth.cgi",
        user => $opts{user},
        pickup => $opts{pickup},
        service => $opts{service},
        output => $self->{"parser_key"},
    );
    if (!$response->{"key"}) {
        die "Registration did not return a key.";
    }
    $self->authenticate(user => $opts{user}, pass => $response->{"key"});
    $response;
}

1;
