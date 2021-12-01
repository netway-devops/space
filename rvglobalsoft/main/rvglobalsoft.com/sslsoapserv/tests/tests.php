<?php
require_once '../../RVSymantecApi.php';

$test_mode = 1;
if ($test_mode == 1) {
    //$o_symantec = RVSymantecApi::connect('4668249TES89180', 'rvtestapi', 'netwaY_12', true);
    $o_symantec = RVSymantecApi::connect('4600590NOT94031', 'librarytest', '1libraryTest$', true);
    $partnerOrderID = 'ahc823jsdfkapsdofk30test';
} else {
    $o_symantec = RVSymantecApi::connect('3624834WEB13231', 'webexperts-api', '^^RV$ssl$95^^', false);
    $partnerOrderID = '';
}

$o_symantec->setDebug();

$fromData   = '2002-05-30T09:00:00';
$toDate     = '2002-05-30T09:30:10';


$a_method = array('hello' ,'GetUserAgreement', 'GetUserAgreement2', 'GetOrderByPartnerOrderID', 'CheckStatus'
    , 'GetFulfillment', 'GetModifiedOrders', 'GetQuickApproverList', 'GetOrdersByDateRange', 'ParseCSR'
	, 'ValidateOrderParameters', 'QuickOrder', 'QuickInvite', 'ChangeApproverEmail', 'ModifyOrder'
	, 'Reissue', 'ResendEmail', 'Revoke'
);

foreach ($a_method as $func) {
	echo "<h3>Method: <i>{$func}</i></h3>";
	$response = $func($o_symantec);

	$color = ' BORDERCOLOR=RED';
	if (isset($response->status) && $response->status == 1) {
		$color = ' BORDERCOLOR=GREEN';
	}

	echo "<table border='1' style='font-size:80%;'{$color}><tr><td><pre>";
	print_r($response);
    echo "</pre></td></tr></table><br />\n";
	print '<hr color="green">';
}


function hello($o_symantec)
{
    // HELLO
    return $o_symantec->hello('Hi, I\'m RV Global Soft.');
}

function GetUserAgreement($o_symantec)
{
    // GET USER AGREEMENT
    return $o_symantec->GetUserAgreement('SecureSiteEV', array('AgreementType' => 'VULNERABILITY'));
}

function GetUserAgreement2($o_symantec)
{
    // GET USER AGREEMENT
	// ALTERNATIVE:
    return $o_symantec->GetUserAgreement('TrueBizID', array('AgreementType' => 'ORDERING'));
}

function GetOrderByPartnerOrderID($o_symantec)
{
    // GET ORDER BY PARTNER ORDER ID
	$partnerOrderID = $GLOBALS['partnerOrderID'];
    return $o_symantec->GetOrderByPartnerOrderID($partnerOrderID, array('ReturnProductDetail' => True));
}

function CheckStatus($o_symantec)
{
    // CHECK STATUS
	$partnerOrderID = $GLOBALS['partnerOrderID'];
    return $o_symantec->CheckStatus($partnerOrderID, array());
}

function GetFulfillment($o_symantec)
{
	// GET FULFILLMENT
	$partnerOrderID = $GLOBALS['partnerOrderID'];
    return $o_symantec->GetFulfillment($partnerOrderID, array('ReturnCACerts' => True));
}

function GetModifiedOrders($o_symantec)
{
	// GET MODIFIED ORDERS
    return $o_symantec->GetModifiedOrders(
        '2013-07-01T13:00:00',
        '2013-10-17T20:00:00',
        array('ReturnCACerts' => true, 'ReplayToken' => '23423asdf', 'ReturnProductDetail' => true)
    );
}

function GetQuickApproverList($o_symantec)
{
	// GET QUICK APPROVER LIST
    return $o_symantec->GetQuickApproverList('yahoo.com', array('ReturnCACerts' => true, 'ReturnProductDetail' => true));
}

function GetOrdersByDateRange($o_symantec)
{
	// GET ORDERS BY DATE RANGE
    return $o_symantec->GetOrdersByDateRange(
        '2013-10-20T13:00:00', '2013-10-24T20:00:00',
        array('ReturnCACerts' => true, 'ReturnProductDetail' => true)
    );
}

function ParseCSR($o_symantec)
{
	// PARSE CSR
    $csr = '-----BEGIN CERTIFICATE REQUEST-----
MIIC1TCCAb0CADCBkDELMAkGA1UEBhMCREUxIjAgBgNVBAMTGXRoaXNpc25vdGF2
YWxpZGQwbWFpbi5jb20xFDASBgNVBAcTC011c3RlcnN0YWR0MRYwFAYDVQQKEw1U
ZXN0aW5nIENvcnAuMRswGQYDVQQIFBJCYWRlbi0gV/xydHRlbWJlcmcxEjAQBgNV
BAsTCU1hcmtldGluZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALNP
Fel49+0npNS0cWrRH9ycAlU2M8P0ib3Uufzq0klIqpHROjeBfjuBp3SFh1c9Z4gy
+HnQnrQCgjYI4Rye42O4FLoruwfX5W5O96nHhY+rYSVsTkCU1aJ0b1TyHNwsLvfh
n96M16TQAbTWEUESRLwBIQr5q7g5LZUEJNPnaW0WJTJGgZkdl4E2qH2UHqT9O2sV
SqGlbUJ2gOEMHx2nX0dwnwoqHzBtxHgR0ryUV8g/W9PKRZ+w2Py3710/mWDCb24w
YtBYphfXs5VgPGh50RVRX/x0PY9FoEfjU7ygDZQzFF/aBODTdxkmSqmP5cRfN3Pi
EC8j3sY1PvDEiSHr+QsCAwEAAaAAMA0GCSqGSIb3DQEBBAUAA4IBAQCkk9ioe77k
gBrtS25LhEOPz5VHlAm94iTYwr/PwdBMI94f8HbfRD82n+9HTux7ezgwq+UVwvIZ
vaLbUJOC/P9XLayfmx+kjbBkFcxe7Y5hhehqtp1hXV0wZgzMx3yJLU5t+i/AIw0P
L9DZ8n1sep9Vi6AEOVmTRt9aYRyWam1VLHdJq2H2dQMW4Tu0fph6X458MJmtLpdB
yveA8IoW+lWOdVOcO/Te8XddV/Rmlg3j7jL2FdDHsws8EpWHZYbKm5iayf9VA02W
4wBaazBvuxbG2aCxOW4yf1HNIDwdvLofHlRoKzSg6+eAypd0SUo8QDct+HTLO908
48ckunPOscW1
-----END CERTIFICATE REQUEST-----';

    return $o_symantec->ParseCSR($csr, array());
}

function ValidateOrderParameters($o_symantec)
{
	// VALIDATE ORDER PARAMETERS
	$csr = '-----BEGIN NEW CERTIFICATE REQUEST----- MIIC8jCCAdoCAQAwga4xCzAJBgNVBAYTAlVTMR8wHQYDVQQKDBZjaG93ZGFzdGFn ZTFRbHNVdzZCZGJ1MRQwEgYDVQQLDAtFbmdpbmVlcmluZzEPMA0GA1UEBwwGQm9z dG9uMQswCQYDVQQIDAJNQTEjMCEGCSqGSIb3DQEJARYUYXBpdGVzdEBnZW90cnVz dC5jb20xJTAjBgNVBAMMHHd3dy5ndHFhc3RhZ2UxUHJWaDg5cFA5ay5jb20wggEi MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWovy9p8peIiuLJ1Nszj0srjpF bi2zGlYYo8++e2Aiq7o29IzA01krGgmdJWlHs/B791+x38IX9Ioy+/OwbF0/LzOd ABr5DUNSW2VBZad94vb2bmp0gLnDnF8LEgwiQNszhRpX3yTtR92Thc5i85m/3dko V7k4W5X3aQPfm7IkOLh/b4zWAzDzZ549W4VI18nXCbe1pY6uIkHRN32f8tiQRnwI EU0Q6m4VTMl8rf2cXw1cCcBXYUJGUe54O9v+Jn+qDnakvU0F9Hl1zBKGxCG8PcHt MAlNE33SFtQQmbsywhV/tYtIuxwUseYl1j/0vkoiHX6SujzxkaTWSxXMAS1XAgMB AAEwDQYJKoZIhvcNAQEFBQADggEBAFJ/eOJjxf1iYC3yJW5gt8lf/lIDaCUfU//1 Z9i3fLqdM+t/883/7OlE+ikElZUnvUktDoZ3HgH0IkvWFI5JjKYYcau39xOUgGRZ eRXDvpQLyjeCH4IWM+tlxxMigc8ptihF0uHdMkVRXA+Np8XgCnw5lQ+PoQhV8YpE NL2upnldeFvr50CxxBxz22PZ43fm+0YDwCvTg2u1EUAqCNu6J/w1iZBgT2khDR5Q rhlY6qsT4M1bpTXBBPtRi1do3a6q/yxWchFCVGWzXotzAuVbOF76qsdLE70faCzH WlCDe2xVlKiWtQedBO/geUfq9zhf8fsNWJ+1WGucdj4O2sj1pwI=-----END NEW CERTIFICATE REQUEST-----';
	return $o_symantec->ValidateOrderParameters(
	    'QuickSSLPremium'
		, array('ValidityPeriod' => 12, 'CSR' => $csr, 'DomainName' => 'www.gtqastage1PrVh89pP9k.com')
	    , array()
	);
}

function QuickOrder($o_symantec)
{
    $productCode = 'QuickSSLPremium';
    $csr = '-----BEGIN CERTIFICATE REQUEST-----
MIIC1TCCAb0CADCBkDELMAkGA1UEBhMCREUxIjAgBgNVBAMTGXRoaXNpc25vdGF2
YWxpZGQwbWFpbi5jb20xFDASBgNVBAcTC011c3RlcnN0YWR0MRYwFAYDVQQKEw1U
ZXN0aW5nIENvcnAuMRswGQYDVQQIFBJCYWRlbi0gV/xydHRlbWJlcmcxEjAQBgNV
BAsTCU1hcmtldGluZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALNP
Fel49+0npNS0cWrRH9ycAlU2M8P0ib3Uufzq0klIqpHROjeBfjuBp3SFh1c9Z4gy
+HnQnrQCgjYI4Rye42O4FLoruwfX5W5O96nHhY+rYSVsTkCU1aJ0b1TyHNwsLvfh
n96M16TQAbTWEUESRLwBIQr5q7g5LZUEJNPnaW0WJTJGgZkdl4E2qH2UHqT9O2sV
SqGlbUJ2gOEMHx2nX0dwnwoqHzBtxHgR0ryUV8g/W9PKRZ+w2Py3710/mWDCb24w
YtBYphfXs5VgPGh50RVRX/x0PY9FoEfjU7ygDZQzFF/aBODTdxkmSqmP5cRfN3Pi
EC8j3sY1PvDEiSHr+QsCAwEAAaAAMA0GCSqGSIb3DQEBBAUAA4IBAQCkk9ioe77k
gBrtS25LhEOPz5VHlAm94iTYwr/PwdBMI94f8HbfRD82n+9HTux7ezgwq+UVwvIZ
vaLbUJOC/P9XLayfmx+kjbBkFcxe7Y5hhehqtp1hXV0wZgzMx3yJLU5t+i/AIw0P
L9DZ8n1sep9Vi6AEOVmTRt9aYRyWam1VLHdJq2H2dQMW4Tu0fph6X458MJmtLpdB
yveA8IoW+lWOdVOcO/Te8XddV/Rmlg3j7jL2FdDHsws8EpWHZYbKm5iayf9VA02W
4wBaazBvuxbG2aCxOW4yf1HNIDwdvLofHlRoKzSg6+eAypd0SUo8QDct+HTLO908
48ckunPOscW1
-----END CERTIFICATE REQUEST-----';
    /*$orderParameters = array(
        //'Method'    => '', // Optional
        'ContractID' => 'BLK868912', // Optional
        'ValidityPeriod' => 12,
        'ServerCount' => 1, // Optional for all Geotrust SSL certs
        'CSR' => $csr,
        'DomainName' => 'www.dogilike.com', // Not suppoted fot Org Validated certs
        'WebServerType' => 'Other', // Optional for True BusinessID and True BusinessID with EV
        //'WildCard'  => '', // Optional
        //'CUIndicator' => '', // Optional
        //'CUCertificate' => '', // Optional
        //'DiscountType' => '', // Optional, Required for Midterm Upgrades
        //'DNSNames' => '', // Optional, Refer to table 11
        //'RenewalIndicator' => '', // Optional
        //'RenewalBehavior' => '', // Optional
        //'SpecialInstructions' => '', // Optional
        //'EmailLanguageCode' => '', // Optional
        //'ReissuanceInsuranceIndictor' => '', // Optional
        //'InstallationSupportIndicator' => '', // Optional
        //'OriginalPartnerOrderID' => '', // Optional, Required for ASL, midterm upgrades and HourlyUsage orders
        //'CertificateType' => '', // Not supported for Org validated certs
        //'ApprovalIngicator' => '', // Optional, False will not disapprove the order
        //'UsageFromDate' => '', // Optional

    );*/

    $orderParameters = array( 'ValidityPeriod' => 12, 'CSR' => $csr, 'WebServerType' => 'iis');


    /*$organizationInfo = array(
        'OrganizationName' => 'Dek-D Interactive co., ltd',
        //'DUNS'                  => '', // Optional
        //'Division'              => '', // Optional
        //'IncorporatingAgency'   => '', // Optional
        ///'RegistratingNumber'    => '', // Optional
        //'JurisdictionCity'      => '', // Optional
        //'JurisdictionRegion'    => '', // Optional
        //'JurisdictionCountry'   => '', // Optional
        'OrganizationAddress'   => array(
            'AddressLine1'          => '723 Supakarn bld., Room 3C02 and 3B12, 3rd floor Charoennakorn rd, Klongtonsai',
            //'AddressLine2'          => '', // Optional
            //'AddressLine3'          => '', // Optional
            'City'                  => 'Klongsarn',
            'Region'                => 'Bangkok',
            'PostalCode'            => '10600',
            'Country'               => 'TH',
            'Phone'                 => '+66813392925',
            //'Fax'                   => '', // Optional
        ),
    );*/

    $organizationInfo = array(
        'OrganizationName' => 'Test Corp',
        //'DUNS'                  => '', // Optional
        //'Division'              => '', // Optional
        //'IncorporatingAgency'   => '', // Optional
        ///'RegistratingNumber'    => '', // Optional
        //'JurisdictionCity'      => '', // Optional
        //'JurisdictionRegion'    => '', // Optional
        //'JurisdictionCountry'   => '', // Optional
        'OrganizationAddress'   => array(
            'AddressLine1'          => 'Musterstrasse 56',
            'AddressLine2'          => '', // Optional
            'AddressLine3'          => '', // Optional
            'City'                  => 'Musterstadt',
            'Region'                => 'Baden-Wuerttemberg',
            'PostalCode'            => '12345',
            'Country'               => 'DE',
            'Phone'                 => '0123/456321',
            //'Fax'                   => '', // Optional
        ),
    );

    $adminContact = array(
        'FirstName'         => 'John',
        'LastName'          => 'Jackson',
        'Phone'             => '+44565489654',
        //'Fax'               => '', // Optional
        'Email'             => 'john@example.com',
        'Title'             => 'John',
        //'OrganizationName'  => '', // Optional, Required for Symantec SSL
        'AddressLine1'      => '', // Optional, Required for Symantec SSL
        //'AddressLine2'      => '', // Optional
        'City'              => '', // Optional, Required for Symantec SSL
        'Region'            => '', // Optional, Required for Symantec SSL
        'PostalCode'        => '', // Optional, Required for Symantec SSL
        'Country'           => '', // Optional, Required for Symantec SSL
    );

    $techContact = array(
        'FirstName'         => 'John',
        'LastName'          => 'Jackson',
        'Phone'             => '+44565489654',
        //'Fax'               => '', // Optional
        'Email'             => 'john@example.com',
        'Title'             => 'John',
        //'OrganizationName'  => '', // Optional, Required for Symantec SSL
        'AddressLine1'      => '', // Optional, Required for Symantec SSL
        //'AddressLine2'      => '', // Optional
        'City'              => '', // Optional, Required for Symantec SSL
        'Region'            => '', // Optional, Required for Symantec SSL
        'PostalCode'        => '', // Optional, Required for Symantec SSL
        'Country'           => '', // Optional, Required for Symantec SSL
    );
    $billingContact = array(
        'FirstName'         => 'Jack', // Optional
        'LastName'          => 'Johnson', // Optional
        'Phone'             => '+445654896544', // Optional
        //'Fax'               => '', // Optional
        'Email'             => 'accounting@example.com', // Optional
        'Title'             => 'Jack', // Optional
        //'OrganizationName'  => '', // Optional
        //'AddressLine1'      => '', // Optional
        //'AddressLine2'      => '', // Optional
        //'City'              => '', // Optional
        //'Region'            => '', // Optional
        //'PostalCode'        => '', // Optional
        //'Country'           => '', // Optional
    );
    $approverEmail = 'hostmaster@thisisnotavalidd0main.com';
    $options = array(
    		'PartnerOrderID' => 'RV123456789_' . rand(1000,9999)
    );
    return $o_symantec->QuickOrder($productCode, $orderParameters, $organizationInfo, $adminContact, $techContact, $billingContact, $approverEmail, $options);
}

function QuickInvite($o_symantec)
{
	// QUICK INVITE
	$productCode = 'QuickSSLPremium';
	$csr = '-----BEGIN NEW CERTIFICATE REQUEST----- MIIC8jCCAdoCAQAwga4xCzAJBgNVBAYTAlVTMR8wHQYDVQQKDBZjaG93ZGFzdGFn ZTFRbHNVdzZCZGJ1MRQwEgYDVQQLDAtFbmdpbmVlcmluZzEPMA0GA1UEBwwGQm9z dG9uMQswCQYDVQQIDAJNQTEjMCEGCSqGSIb3DQEJARYUYXBpdGVzdEBnZW90cnVz dC5jb20xJTAjBgNVBAMMHHd3dy5ndHFhc3RhZ2UxUHJWaDg5cFA5ay5jb20wggEi MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWovy9p8peIiuLJ1Nszj0srjpF bi2zGlYYo8++e2Aiq7o29IzA01krGgmdJWlHs/B791+x38IX9Ioy+/OwbF0/LzOd ABr5DUNSW2VBZad94vb2bmp0gLnDnF8LEgwiQNszhRpX3yTtR92Thc5i85m/3dko V7k4W5X3aQPfm7IkOLh/b4zWAzDzZ549W4VI18nXCbe1pY6uIkHRN32f8tiQRnwI EU0Q6m4VTMl8rf2cXw1cCcBXYUJGUe54O9v+Jn+qDnakvU0F9Hl1zBKGxCG8PcHt MAlNE33SFtQQmbsywhV/tYtIuxwUseYl1j/0vkoiHX6SujzxkaTWSxXMAS1XAgMB AAEwDQYJKoZIhvcNAQEFBQADggEBAFJ/eOJjxf1iYC3yJW5gt8lf/lIDaCUfU//1 Z9i3fLqdM+t/883/7OlE+ikElZUnvUktDoZ3HgH0IkvWFI5JjKYYcau39xOUgGRZ eRXDvpQLyjeCH4IWM+tlxxMigc8ptihF0uHdMkVRXA+Np8XgCnw5lQ+PoQhV8YpE NL2upnldeFvr50CxxBxz22PZ43fm+0YDwCvTg2u1EUAqCNu6J/w1iZBgT2khDR5Q rhlY6qsT4M1bpTXBBPtRi1do3a6q/yxWchFCVGWzXotzAuVbOF76qsdLE70faCzH WlCDe2xVlKiWtQedBO/geUfq9zhf8fsNWJ+1WGucdj4O2sj1pwI=-----END NEW CERTIFICATE REQUEST-----';
	$orderParameters = array( 'ValidityPeriod' => 12, 'CSR' => $csr, 'WebServerType' => 'iis');

	$organizationInfo = array ('OrganizationAddress' => array(
			'Country'        => 'DE',
			'Region'         => 'Baden-Württemberg',
			'City'           => 'Musterstadt',
			'AddressLine1'   => 'Musterstrasse 56',
			'PostalCode'     => '112233',
			'Phone'          => '0123/345934'
	), 'OrganizationName' => 'Testing Corp.');

	$adminContact = array (
			'FirstName'  => 'John',
			'LastName'   => 'Jackson',
			'Phone'      => '+464567456845',
			'Email'      => 'john@example.com'
	);

	$techContact = array (
			'FirstName'  => 'Jack',
			'LastName'   => 'Johnson',
			'Phone'      => '+464567456845',
			'Email'      => 'jack@example.com'
	);

	$billingContact = array(
			'FirstName'  => 'John',
			'LastName'   => 'Jackson',
			'Phone'      => '+464567456845',
			'Email'      => 'accounting@example.com'
	);

	$approverEmail = 'hostmaster@gtqastage1PrVh89pP9k.com';
	$options       = array();

    return $o_symantec->QuickInvite($productCode, $orderParameters, $organizationInfo, $adminContact, $techContact, $billingContact, $approverEmail, $options);
}

function ChangeApproverEmail($o_symantec)
{
	// CHANGE APPROVER EMAIL
	$partnerOrderID    = 'RV123456789_1312';
	$approverEmail     = 'tobias_zatti@symantec.com';
	$options           = array();

    return $o_symantec->ChangeApproverEmail($partnerOrderID, $approverEmail, $options);

}

function ModifyOrder($o_symantec)
{
	$partnerOrderID    = 'RV123456789_1312';
	$approverEmail     = 'APPROVE';
	$options           = array();

	return $o_symantec->ModifyOrder($partnerOrderID, $approverEmail, $options);
}

function Reissue($o_symantec)
{
	$csr = '-----BEGIN NEW CERTIFICATE REQUEST----- MIIC8jCCAdoCAQAwga4xCzAJBgNVBAYTAlVTMR8wHQYDVQQKDBZjaG93ZGFzdGFn ZTFRbHNVdzZCZGJ1MRQwEgYDVQQLDAtFbmdpbmVlcmluZzEPMA0GA1UEBwwGQm9z dG9uMQswCQYDVQQIDAJNQTEjMCEGCSqGSIb3DQEJARYUYXBpdGVzdEBnZW90cnVz dC5jb20xJTAjBgNVBAMMHHd3dy5ndHFhc3RhZ2UxUHJWaDg5cFA5ay5jb20wggEi MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCWovy9p8peIiuLJ1Nszj0srjpF bi2zGlYYo8++e2Aiq7o29IzA01krGgmdJWlHs/B791+x38IX9Ioy+/OwbF0/LzOd ABr5DUNSW2VBZad94vb2bmp0gLnDnF8LEgwiQNszhRpX3yTtR92Thc5i85m/3dko V7k4W5X3aQPfm7IkOLh/b4zWAzDzZ549W4VI18nXCbe1pY6uIkHRN32f8tiQRnwI EU0Q6m4VTMl8rf2cXw1cCcBXYUJGUe54O9v+Jn+qDnakvU0F9Hl1zBKGxCG8PcHt MAlNE33SFtQQmbsywhV/tYtIuxwUseYl1j/0vkoiHX6SujzxkaTWSxXMAS1XAgMB AAEwDQYJKoZIhvcNAQEFBQADggEBAFJ/eOJjxf1iYC3yJW5gt8lf/lIDaCUfU//1 Z9i3fLqdM+t/883/7OlE+ikElZUnvUktDoZ3HgH0IkvWFI5JjKYYcau39xOUgGRZ eRXDvpQLyjeCH4IWM+tlxxMigc8ptihF0uHdMkVRXA+Np8XgCnw5lQ+PoQhV8YpE NL2upnldeFvr50CxxBxz22PZ43fm+0YDwCvTg2u1EUAqCNu6J/w1iZBgT2khDR5Q rhlY6qsT4M1bpTXBBPtRi1do3a6q/yxWchFCVGWzXotzAuVbOF76qsdLE70faCzH WlCDe2xVlKiWtQedBO/geUfq9zhf8fsNWJ+1WGucdj4O2sj1pwI=-----END NEW CERTIFICATE REQUEST-----';

	$partnerOrderID    = 'RV123456789_1312';
	$reissueEmail      = 'hostmaster@gtqastage1prvh89pp9k.com';
	$options           = array('CSR' => $csr);

    return $o_symantec->Reissue($partnerOrderID, $reissueEmail, $options);
}

function ResendEmail($o_symantec)
{
	$productCode = 'QuickSSLPremium';
	$partnerOrderID = 'RV123456789_1312';
	$resendMailType = 'FulfillmentEmail';
	$options = array();
	return $o_symantec->ResendEmail($productCode, $partnerOrderID, $resendMailType, $options);
}

function Revoke($o_symantec)
{
	$certificate = '-----BEGIN CERTIFICATE-----
MIIEezCCA2OgAwIBAgIDAx0qMA0GCSqGSIb3DQEBBQUAME8xCzAJBgNVBAYTAlVT
MRUwEwYDVQQKEwxHZW9UcnVzdCBJbmMxKTAnBgNVBAMTIEdlb1RydXN0IFByZS1Q
cm9kdWN0aW9uIFNVQiBDQSAzMB4XDTEzMDYyMDA2MDEzNloXDTEzMDYyODIyNTU1
OVowgbMxEzARBgNVBAsTCkdUNjI4MDc0NDMxMTAvBgNVBAsTKFNlZSB3d3cuZ2Vv
dHJ1c3QuY29tL3Jlc291cmNlcy9jcHMgKGMpMTMxNzA1BgNVBAsTLkRvbWFpbiBD
b250cm9sIFZhbGlkYXRlZCAtIFF1aWNrU1NMKFIpIFByZW1pdW0xMDAuBgNVBAMT
J3N1YnpoNWsxc25tdTIuZ3RxYXByZXByb2RhOWVjeW82Z25kLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAM07OeaUVr2Hy/gTgl7Z+dCgkNO6K0jz
rRv7B6Ile1sdEq6uphBw8ZIPFfB9dOgfOpM+uoVDzoP1z0VtP03S940yEt5AhcEf
kJ/+8Qg7z3cANd1Y7zz5E/ntAn4ZeTyVtEowzcUlsVF5XosSqDTK3qtnjk0yr+AG
vTdv+qnFtZkJDDuCT6+dlolIZ+B4yumy5V63wQLs9JDCAiPTVXJU/pYMdVchJV6q
m5traF6BFp1VdaX0msiOOYKHC1nFY6j2HqMn5Fpq4dFQLa5WYy0TZuvenzWJu8Hu
hD2wZFQ8ZXiMJBiWeKwYTUKIGK9X46DctLl0Evcqt42e0FGS72LtIrECAwEAAaOB
+jCB9zAfBgNVHSMEGDAWgBRlda4iaOfdlCsTaNUsGCuGGFWgxTAOBgNVHQ8BAf8E
BAMCBaAwMgYDVR0RBCswKYInc3Viemg1azFzbm11Mi5ndHFhcHJlcHJvZGE5ZWN5
bzZnbmQuY29tMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly90ZXN0LWNybC5nZW90
cnVzdC5jb20vY3Jscy9wcmVwcm9kc3ViY2EzLmNybDAMBgNVHRMBAf8EAjAAMB0G
A1UdDgQWBBTbPVn8I+eeUlxIJ6jrbC6krG6u2TAdBgNVHSUEFjAUBggrBgEFBQcD
AQYIKwYBBQUHAwIwDQYJKoZIhvcNAQEFBQADggEBAKHbjyAs9aNnc10KsyUnLYvN
0sYupq5thFdPgBJRsnTxZLB+kPHF+KSL723SGX1X54sK5HSIUeWtcvBk9pSfMzgA
CQ39iT2RwgAh80xBtbHFIOlR31I7nH/MzWX9Rkc2lmkrRARCNhW9qfR+xkfAEDlQ
+q2EYifLjO64GVIubVHaTTAXhVqsRRAqJVU0RefSYKZ7qtKAy3NTkTxlufIHzq+d
JyqAaEdN+m7mHe/3N/CjUzH4KLPFXE1HiDt84knQx1rFv0sw1aYd6bP6B5qADVdN
bwXcnhZdOzLAxel128BEurW2whhg9sEAM4ZtDg8aWcwOG7PgWgwiVn7Yga0Y9S8=
-----END CERTIFICATE-----';
	$revokeReason = 'This is a test.';
	$options = array();
	return $o_symantec->Revoke($certificate, $revokeReason, $options);
}