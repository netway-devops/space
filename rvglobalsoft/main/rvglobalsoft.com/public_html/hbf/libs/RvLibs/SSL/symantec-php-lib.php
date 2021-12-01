<?php

/*

Symantec, GeoTrust and Thawte API Library

This library has been written by Tobias Zatti

Contact: tobias_zatti@symantec.com



File name: symantec_api.php

*/



/**

 * Class SymAPI

 *

 * @version   1.2

 * @date	  2015-05-04 (May 4th)

 * @author    Tobias Zatti <tobias_zatti@symantec.com>

 * @copyright Symantec Corp. 2013-2015



 CHANGELOG:

 1.2:

 - Added new API functions released with 2015-4:

   QUERY:

   		- GetModifiedOrderSummary

   		- GetModifiedPreAuthOrderSummary

 - Added "setApiVersion" command to set the ApiVersion command for the RequestHeader.

   By default, the ApiVersion field is set to null.

 1.1.1:

 - Added Prototype Environment URLs and "Prototype" parameter for "UseTestMode()" function

 1.1:

 - Changed default SSL Method to TLSv1.0

 - Added new API functions released world-wide in February 2015 including

   QUERY:

       - GetPreAuthOrdersByDateRange

       - GetPreAuthOrderByPartnerOrderID

   ORDER:

       - OrderPreAuthentication

       - ValidatePreAuthenticationData

 1.0.7:

 - Added "isJapanese()" function which determines whether an order is defined as Japanese.

   This is important due to recent pricing changes for Japanese customers.

 1.0.6:

 - Merged older versions with different new features.

 1.0.5:

 - Added "setOrderAPIURL()" and "setQueryAPIURL()" functions to change

   the locations of the according WSDL files.

 1.0.4:

 - Added forced SSLv3 connection for SoapClient to fix a bug introduced

   with newer OpenSSL versions.



 1.0.3:

 - Added "isVerboseMode()" function

 - Added "lastQuery" function



 1.0.2:

 - Minor changes for verbose mode



 */

// API type

define ( "ORDER",			"order");

define ( "QUERY",			"query");



class SymAPI {

    /**

     * Class version

     *

     * @access public

     * @var string

     */

	public $version	= '1.1';

	/**

	 * URL to WSDL-File for prototype order API

	 *

	 * @access public

	 * @var string

	 */

	public $url_orderAPI_prototype	= "https://dev-verisign-api.bbtest.net/webtrust/order.jws?WSDL";

	/**

	 * URL to WSDL-File for prototype query API

	 *

	 * @access public

	 * @var string

	 */

	public $url_queryAPI_prototype	= "https://dev-verisign-api.bbtest.net/webtrust/query.jws?WSDL";

	/**

     * URL to WSDL-File for test order API

     *

     * @access public

     * @var string

     */

	public $url_orderAPI_demo	= 'https://test-api.geotrust.com/webtrust/order.jws?WSDL';

	/**

     * URI for test order API

     *

     * @access public

     * @var string

     */

	public $uri_orderAPI_demo	= 'https://test-api.geotrust.com/webtrust/order';

	/**

     * URL to WSDL-File for productive order API

     *

     * @access public

     * @var string

     */

	public $url_orderAPI	= 'https://api.geotrust.com/webtrust/order.jws?WSDL';

	/**

     * URI for productive order API

     *

     * @access public

     * @var string

     */

	public $uri_orderAPI	= 'https://api.geotrust.com/webtrust/order';

	/**

     * URL to WSDL-File for test query API

     *

     * @access public

     * @var string

     */

	public $url_queryAPI_demo	= 'https://test-api.geotrust.com/webtrust/query.jws?WSDL';

	/**

     * URI for test query API

     *

     * @access public

     * @var string

     */

	public $uri_queryAPI_demo	= 'https://test-api.geotrust.com/webtrust/query';

	/**

     * URL to WSDL-File for productive query API

     *

     * @access public

     * @var string

     */

	public $url_queryAPI	= 'https://api.geotrust.com/webtrust/query.jws?WSDL';

	/**

     * URI for productive query API

     *

     * @access public

     * @var string

     */

	public $uri_queryAPI	= 'https://api.geotrust.com/webtrust/query';



	/**

     * Your Symantec Partner Code

     *

     * @access private

     * @var string

     */

	private $partnerCode;

	/**

     * Your API Username

     *

     * @access private

     * @var string

     */

	private $userName;

	/**

     * Your Password

     *

     * @access private

     * @var string

     */

	private $userPassword;

	/**

     * Defines whether we run in productive or test mode.

	 * For security reasons, the default setting is true,

	 * which means we run in test mode. Set to false to change

	 * to productive mode.

     *

     * @access private

     * @var bool

     */

	private $useTestAPI;

	/**

     * Prints status and debug messages

     *

     * @access private

     * @var bool

     */

	private $verbose;

	private $rvsslLog;



	/**

	* The Constructor

	**/

	function __construct () {

		$this->init();

	}

	/**

     * Initializes the object and/or resets all values to default

     *

     * @access public

     * @return nothing

     */

	function init() {

		if ($this->verbose) {

			echo "<br />Resetting to default..";

		}

	//  Set all values to their default

		$this->partnerCode 		= '';

		$this->userName			= '';

		$this->userPassword		= '';

		$this->verbose			= false;

		$this->modules			= array();

        $this->lastQuery        = null;

        $this->mainContractID	= null;

        $this->JPNContractID	= null;

        $this->apiVersion 		= null;

		$this->ssl_options		= array (

									'use_ssl' => true,

									'_ssl_method' => "SOAP_SSL_METHOD_TLS",

									'ssl_method' => "SOAP_SSL_METHOD_TLS",

									'ciphers'	=> 'SHA1'

								);

		$this->setTestMode(true);

	}

	/**

	* Enables/Disables verbose mode

	* Verbose mode prints status, error and debug messages.

	*

	* @param bool

	*/

	function setVerboseMode ($bool) {

		$this->verbose = $bool;

	}



	/**

    * Returns true or false depending on verbose mode

    * being active or not.

    * Helps developers to add their verbose messages

    * to their own code.

    **/

    function isVerboseMode() {

        return $this->verbose;

    }



    /**

    * Returns the last query that has been sent through the API.

    * This is useful for backlogging.

    **/

    function getLastQuery() {

        return $this->lastQuery;

    }



    /**

    * Sets the ApiVersion that will be sent in the RequestHeader.

    * By default, the ApiVersion field is not set. (= set to null)

    * Possible values:

    * -> "2015-1"

    * -> "2014-1"

    **/

    function setApiVersion($version) {

    	$this->apiVersion = $version;

    }



	/**

	* Changes from test API to productive API or vice versa.

	* Setting this value to false means using the productive API

	* @param bool

	*/

	function setTestMode ($bool, $prototype=false) {

		$this->useTestAPI = $bool;

		$this->usePrototypeAPI = $prototype;

		if ($this->verbose) {

			$this->logger("<br />Running in ");

			if ($bool) {

				if ($prototype) {

					echo "<b>Prototype Mode.</b>";

				} else {

					echo "<b>Test Mode.</b>";

				}

			} else {

				echo "<b>Productive Mode.</b>";

			}

			echo "<br />";

		}

	}



	/**

	* Sets user credentials

	* @param string: Partner Code

	* @param string: Username

	* @param string: User Password

	* @access public

	*/

	function setCredentials($partnerCode, $userName, $userPass) {

	  $this->partnerCode = $partnerCode;

	  $this->userName = $userName;

	  $this->userPassword = $userPass;

	}



	/*

	Changes the URL for the order API for the currently set mode.

	*/

	function setOrderAPIURL($url) {

		if ($this->useTestAPI) {

			if ($this->usePrototypeAPI) {

				$this->url_orderAPI_prototype = $url;

				$this->logger("Changed PROTOTYPE URL for order API to: $url");

			} else {

				$this->url_orderAPI_demo = $url;

				$this->logger("Changed DEMO URL for order API to: $url");

			}



		} else {

			$this->url_orderAPI = $url;

			$this->logger("Changed PRODUCTION URL for order API to: $url");

		}

	}



	/*

	Changes the URL for the query API for the currently set mode.

	*/

	function setQueryAPIURL($url) {

		if ($this->useTestAPI) {

			if ($this->usePrototypeAPI) {

				$this->url_queryAPI_prototype = $url;

				$this->logger("Changed PROTOTYPE URL for query API to: $url");

			} else {

				$this->url_queryAPI_demo = $url;

				$this->logger("Changed DEMO URL for query API to: $url");

			}



		} else {

			$this->url_queryAPI = $url;

			$this->logger("Changed PRODUCTION URL for query API to: $url");

		}

	}



	/**

	* Changes the Contract ID for the main contract

	**/

	function setMainContractID($id) {

		$this->mainContractID = $id;

	}



	/**

	* Changes the Contract ID for the Japanese contract

	**/

	function setJPNContractID($id) {

		$this->JPNContractID = $id;

	}



	/**

	* Checks if the given product is a DV product

	* Returns True or False

	**/

	private function isDVOrder($product) {

		/**

		* This is the list of all DV products we currently have.

		* If the given ProductCode is in this list, we will return true.**/

		$dv_products = array(

			"SSL123",

			"QUICKSSL",

			"QUICKSSLPREMIUM",

			"RAPIDSSL",

			"FREESSL"

		);

		return in_array(strtoupper($product), $dv_products);

	}



	/**

	* Checks whether an order is Japanese by definition of the

	* Japanese price alignment.

	*

	* Input requires the product code.

	* CSR and Organization Country are both optional, but required based

	* on the product type.

	* For DV products, the CSR is required.

	* For OV and EV products, the organization country is required.

	*

	* This function returns an error code if the required parameter

	* is not given.

	*

	* Return Values:

	*  		  1: The order is Japanese

	*         0: The order is not Japanese

	*     -1000: Unknown product code

	*     -2000: CSR required but not given

	*     -2001: CSR does not contain Common Name (CN) field or is invalid

	*     -3000: Organization Country required but not given

	*

	* NOTE: When checking the result through an if-statement, DO NOT CHECK

	* FOR "true" OR "false" but 1 or 0.

	* For some reason, PHP handles negative numbers as "true"

	**/

	function isJapanese($productCode, $csr = "", $organizationCountry = "", $billingCountry = "") {

		// Check whether this product code is a DV product

		$type = $this->isDVOrder($productCode);



		// Is the billing contact from Japan?

		if (strtoupper($billingCountry) == "JP") {

			return 1;

		}

		// Case: Order is DV order

		if ($type) {

			// Check whether the CSR is given and set

			if ($csr != '' and $csr != null) {

				// Fetch the Common Name (CN) field

				$cn = $this->getCommonName($csr);

				// Check whether the CSR contained a CN field

				if ( $cn != '' and $cn != null) {

					if (preg_match("/.*\.jp\z/", $cn)) {

						return 1;

					} else {

						return 0;

					}

				} else {

					// Invalid or nonexistent CN field in CSR

					return -2001;

				}

			} else {

				// No CSR given

				return -2000;

			}

		} else {

			// Check whether the org country is given and set

			if ($organizationCountry != "" and $organizationCountry != null) {

				if (strtoupper($organizationCountry) == "JP") {

					return 1;

				} else {

					return 0;

				}

			} else {

				// No Organization Country given

				return -3000;

			}

		}

	}



	/**

	* Returns the contractID that should be used for an order

	* based on whether an order is defined as Japanese or not.

	*

	* In case of errors while determining whether an order is

	* Japanese, the main contract will be set, since error

	* handling from the API side will take care of this anyway.

	**/

	function chooseContractID($isJapanese) {

		if ($isJapanese == 1) {

			return $this->JPNContractID;

		} else {

			return $this->mainContractID;

		}

	}



	/**

	* Returns the CN (Common name) field from a CSR

	**/

	function getCommonName($csr) {

		$r = openssl_csr_get_subject($csr);

		return $r["CN"];

	}

	/**

	* Sets the WSDL locations to offline files.

	* This solves a problem with a bug in PHP SoapClient

	* with newer OpenSSL versions.

	* Use this method when you get a "Can't connect to WSDL" error.

	*/

	function enableOfflineWSDL($queryLocation = "query.jws.xml", $orderLocation = "order.jws.xml") {

		if ( $this->useTestAPI ) {

			if ($this->isVerboseMode()) {

				print "WSDL Location for TEST environment WSDLs have been set to \"$queryLocation\" and \"$orderLocation\"";

			}

			$this->url_orderAPI_demo = $orderLocation;

			$this->url_queryAPI_demo = $queryLocation;

		} else {

			if ($this->isVerboseMode()) {

				print "WSDL Location for PRODUCTIVE environment WSDLs have been set to \"$queryLocation\" and \"$orderLocation\"";

			}

			$this->url_orderAPI 	 = $orderLocation;

			$this->url_queryAPI 	 = $queryLocation;

		}

	}



	/**

	* Sets the WSDL locations back to their default URL.

	*/

	function disableOfflineWSDL() {

		if ($this->isVerboseMode()) {

				print "ALL WSDL locations for both TEST and PRODUCTIVE environment have been reset to default";

			}

		$this->url_orderAPI_demo 		= 'https://test-api.geotrust.com/webtrust/order.jws?WSDL';

		$this->url_queryAPI_demo 		= 'https://test-api.geotrust.com/webtrust/query.jws?WSDL';

		$this->url_orderAPI 	 		= 'https://api.geotrust.com/webtrust/order.jws?WSDL';

		$this->url_queryAPI 	 		= 'https://api.geotrust.com/webtrust/query.jws?WSDL';

		$this->url_orderAPI_prototype 	= 'https://dev-verisign-api.bbtest.net/webtrust/order.jws?WSDL';

		$this->url_queryAPI_prototype 	= 'https://dev-verisign-api.bbtest.net/webtrust/query.jws?WSDL';

	}



	/**

	* Returns the URL to the correct API

	*

	* @param constant (ORDER | QUERY )

	* @return string | -1 on incorrect parameter

	* @access private

	*/

	private function getAPIURL ($type) {

		switch ($type) {

			case ORDER:

				if ( $this->useTestAPI ) {

					if ( $this->usePrototypeAPI ) {

						return $this->url_orderAPI_prototype;

					}

					return $this->url_orderAPI_demo;

				} else {

					return $this->url_orderAPI;

				}

				break;

			case QUERY:

				if ( $this->useTestAPI ) {

					if ( $this->usePrototypeAPI ) {

						return $this->url_queryAPI_prototype;

					}

					return $this->url_queryAPI_demo;

				} else {

					return $this->url_queryAPI;

				}

				break;

			default:

				// Invalid type

				return -1;

		}

	}



	/**

	* Removes the ReplayToken element from the order options array

	* to prevent duplicate posting, which would cause errors.

	*

	* @param constant (ORDER | QUERY )

	* @return string | -1 on incorrect parameter

	* @access private

	*/

	private function removeReplayToken (&$options) {

		if ( isset($options['ReplayToken']) ) {

			unset($options['ReplayToken']);

		}

	}

	/**

	* Creates the RequestHeader needed for queries and orders

	* It uses the credentials that can are set in the setCredentials

	* function.

	*

	* @return array

	* @access private

	*/

	private function createRequestHeader ($options) {

		$replayToken = 0;

		if (isset($options['ReplayToken'])) {

			$replayToken = $options['ReplayToken'];

		}



		$header = array();

		if ($replayToken == 0) {

			$header = array (

			'PartnerCode' => $this->partnerCode,

			'AuthToken' => array (

				'UserName' => $this->userName,

				'Password' => $this->userPassword

			)

		);

		} else {

			$header = array (

			'PartnerCode' => $this->partnerCode,

			'AuthToken' => array (

				'UserName' => $this->userName,

				'Password' => $this->userPassword

			),

			'UseReplayToken' => true,

			'ReplayToken'	 => $replayToken

		);

		}

		// Add the ApiVersion parameter to the header if set

		if (isset($options['ApiVersion'])) {

			$header['ApiVersion'] = $options['ApiVersion'];

		}

		$this->logger("<h3>Header</h3>");

		$this->logger_r($header);

		return $header;

	}



	/**

	* Sends a SOAP request to the server with the given parameters.

	*

	* @param array

	* @return array

	* @access private

	*/

	function sendSOAP ($function, $params) {

		$this->logger ("<h3>Request</h3>");

		$this->logger_r ($params);

        $this->lastQuery = $params;

		return array();
		
		try {
			$start = microtime(true);

			ini_set('soap.wsdl_cache_enabled',0);
			ini_set('soap.wsdl_cache_ttl',0);

			$this->rvsslLogger("\n\nCALL ({$function}) : " . print_r($params, 1));

			$results = $this->soap->$function ($params);

			$results = $this->reArrangeError(json_decode(json_encode($results), 1));

			$this->rvsslLogger("RESPONSE : " . print_r($results, 1) . "\n\n");

			$end = microtime(true);

			$this->rvsslLogger("EXECUTE TIME : " . number_format(($end - $start), 2) . " sec \n\n");

			if($this->verbose){

				$this->logger ("<h3>Response</h3>");

				$this->logger_r($results);

			}

			return $results;

		} catch (SoapFault $soapFault) {
			//var_dump($soapFault);

			require_once(HBFDIR_LIBS  . 'RvLibs/SSL/PHPMailer-master/class.phpmailer.php');

			$subject = 'RVSSL CRON ERROR : SOAPFAULT';
			$mail = new PHPMailerNew();
			$mail->From = 'no-reply@rvglobalsoft.com';
			$mail->FromName = 'RVglobalsoft : symantec-php-lib.php';
			$mail->AddAddress('natdanai@netway.co.th');
			$mail->Subject = $subject;
			$mail->Body = "<pre>" . print_r($soapFault, 1) . "</pre>";
			$mail->ISHTML(true);
			$mail->Send();

			throw new Exception(print_r($soapFault, 1));

			return $soapFault;

		}

	}



	/**

	* Prints the given string with time stamp for debugging reasons.

	* Only prints if verbose mode is on or when the force parameter is set.

	**/

	function logger ($string, $force = false) {

		if ( $this->verbose OR $force ) {

			try {

				$date = new DateTime();

				print "<br />[" . date('Y-m-d H:i:s', $date->getTimestamp()) . "] $string";

			} catch (Exception $e) {

				print "<br />$string";

			}



		}

	}



	/**

	* Prints the given string with time stamp for debugging reasons, using PHP's print_r function.

	* Only prints if verbose mode is on or when the force parameter is set.

	**/

	function logger_r (array $string, $force = false) {

		if ( $this->verbose OR $force ) {

			try {

				$date = new DateTime();

				print "<pre>";

				print "<br />[" . date('Y-m-d H:i:s', $date->getTimestamp()) . "]";

				print_r ($string);

				print "</pre>";

			} catch (Exception $e) {

				print "<pre>";

				print_r ($string);

				print "</pre>";

			}



		}

	}



/** HELPER FUNCTIONS **

* These functions are made to help the user creating arrays with

* the correct parameter names for the API, so the user doesn't

* have to care about syntax.

*/



	/**

	* Creates an array with the correct key names as they are required by the SOAP API.

	* You can use this function for Admin-, Billing- and Tech Contact.

	*

	* @param firstName: string - Contact person's First (given) name - middle names can also be entered here

	* @param lastName: string- Contact person's Last (family) name

	* @param phone: string - Contact's phone number

	* @param email: string - Contact's email address

	* @param countryCode: string - Contact's country code, example: 'DE' for Germany, 'US' for United States

	* @param region: string - Contact's region - It is from the Address structure. This is the region of the address such as state or province. If this is a U.S. state, it must have a valid two-character abbreviation.

	* @param city: string - Contact's city name

	* @param addressLine1: string - First address line

	* @param addressLine2: string - Second address line for longer addresses

	* @param postalCode: string - Contact's postal code

	* @param fax: string - Contact's fax number

	* @param title: string - Contact's title in the company

	* @param organizationName - This is the name of the organization applying for the product. This applies to Organization Vetted products and SSL123.

	* @return array

	* @access public

	*/

	function createContact ($firstName = "", $lastName = "", $phone = "", $email = "", $countryCode = "",

							$region = "", $postalCode = "", $city = "", $addressLine1 = "", $addressLine2 = "",

							$fax = "", $title = "", $organizationName = "", $altPhone = "") {



		$addrArray = array();



		if ($firstName != '' or $firstName != null)

			$addrArray['FirstName'] = $firstName;

		if ($lastName != '' or $lastName != null)

			$addrArray['LastName'] = $lastName;

		if ($countryCode != '' or $countryCode != null )

			$addrArray['Country'] = $countryCode;

		if ($region != '' or $region != null)

			$addrArray['Region'] = $region;

		if ($city != '' or $city != null)

			$addrArray['City'] = $city;

		if ($addressLine1 != '' or $addressLine1 != null)

			$addrArray['AddressLine1'] = $addressLine1;

		if ($addressLine2 != '' or $addressLine2 != null)

			$addrArray['AddressLine2'] = $addressLine2;

		if ($postalCode != '' or $postalCode != null)

			$addrArray['PostalCode'] = $postalCode;

		if ($fax != '' or $fax != null)

			$addrArray['Fax'] = $fax;

		if ($phone != '' or $phone != null)

			$addrArray['Phone'] = $phone;

		if ($altPhone != '' or $altPhone != null)

			$addrArray['AltPhone'] = $altPhone;

		if ($email != '' or $email != null)

			$addrArray['Email'] = $email;

		if ($title != '' or $title != null)

			$addrArray['Title'] = $title;

		if ($organizationName != '' or $organizationName != null)

			$addrArray['OrganizationName'] = $organizationName;



		return $addrArray;

	}



	/**

	* Creates an array with the correct key names as they are required by the SOAP API.

	* You can use this function for an Organization Address.

	*

	* @param countryCode: string - Contact's country code, example: 'DE' for Germany, 'US' for United States

	* @param region: string - Contact's region - It is from the Address structure. This is the region of the address such as state or province. If this is a U.S. state, it must have a valid two-character abbreviation.

	* @param city: string - Contact's city name

	* @param addressLine1: string - First address line

	* @param addressLine2: string - Second address line for longer addresses

	* @param addressLine3: string - Third address line for very long addresses

	* @param postalCode: string - The postal code

	* @param phone: string - The company phone number

	* @param fax: string - The company fax number

	* @return array

	* @access public

	*/

	function createOrganizationAddress ($countryCode = "", $region = "", $city = "", $addressLine1 = "", $addressLine2 = "",

										$addressLine3 = "", $postalCode = "", $phone = "", $fax = "") {

		$addrArray = array();



		if ($countryCode != '' or $countryCode != null )

			$addrArray['Country'] = $countryCode;

		if ($region != '' or $region != null)

			$addrArray['Region'] = $region;

		if ($city != '' or $city != null)

			$addrArray['City'] = $city;

		if ($addressLine1 != '' or $addressLine1 != null)

			$addrArray['AddressLine1'] = $addressLine1;

		if ($addressLine2 != '' or $addressLine2 != null)

			$addrArray['AddressLine2'] = $addressLine2;

		if ($addressLine3 != '' or $addressLine3 != null)

			$addrArray['AddressLine3'] = $addressLine3;

		if ($postalCode != '' or $postalCode != null)

			$addrArray['PostalCode'] = $postalCode;

		if ($fax != '' or $fax != null)

			$addrArray['Fax'] = $fax;

		if ($phone != '' or $phone != null)

			$addrArray['Phone'] = $phone;

		return $addrArray;

	}



	/**

	* Creates an array with the correct key names as they are required by the SOAP API.

	* You can use this function for organization information.

	*

	* @param orgName: string - Name of the organization.

	* @param orgAddress: array - Use the createOrganizationAddress() function to create this array.

	* @return array

	* @access public

	*/

	function createOrganizationInfo ( $orgName, $orgAddress ) {

		$orgArray = array();

		$orgArray['OrganizationName'] = $orgName;

		$orgArray['OrganizationAddress'] = $orgAddress;

		return $orgArray;

	}





/* ** SOAP API Functions **

* Starting here, each function has the same name as an

* according function on the API.

* All functions return an array with the result parameters

* PLEASE NOTE THAT ALL PARAMETER NAMES ARE CASE-SENSITIVE!

*/

#######################

# QUERY API FUNCTIONS #

#######################



	/**

	* Returns the "Input" parameter as "helloResult" parameter.

	* This is mainly useful to test the connection to the API

	* and to see how responses are formatted.

	*

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function hello($params) {

		if ( func_num_args() != 1 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		return $this->sendSOAP('hello', $params);



	}



	/**

	* Returns detailed order information for the order matching the PartnerOrderID.

	* The PartnerOrderID can optionally be supplied during a QuickInvite or

	* QuickOrder command. If the PartnerOrderID is not supplied, GeoTrust

	* automatically generates a PartnerOrderID for an order after it is successfully

	* submitted. A PartnerOrderID must be unique and cannot be reused.

	*

	* NOTE: This operation currently returns only orders. It does not return invitations

	* that have not been converted into orders (the results of a QuickInvite).

	*

	* **Required Parameters**

	* PartnerOrderID : string

	*

	* **Optional Parameters**

	* ReturnProductDetail : bool

	* ReturnContacts : bool

	* ReturnCertificateInfo : bool

	* ReturnFulfillment : bool

	* ReturnCACerts : bool

	* ReturnPKCS7Cert : bool

	* ReturnOrderAttributes : bool

	* ReturnAuthenticationComments : bool

	* ReturnAuthenticationStatuses : bool

	* ReturnTrustServicesSummary : bool

	* ReturnTrustServicesDetails : bool

	* ReturnVulnerabilityScanSummary : bool

	* ReturnVulnerabilityScanDetails : bool

	* ReturnFileAuthDVSummary : bool

	* ReturnDNSAuthDVSummary : bool

	*

	* @param string - PartnerOrderID

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function GetOrderByPartnerOrderID ($partnerOrderID, $options = array()) {

		if ( func_num_args() < 1 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}

		// Create the QueryRequestHeader parameter

		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);



		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'PartnerOrderID' => $partnerOrderID,

				'OrderQueryOptions' => $options

			)

		);

		return $this->sendSOAP('GetOrderByPartnerOrderID', $params);

	}



	/**

	* Returns the processing status of the order.

	*

	* @param string - PartnerOrderID

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function CheckStatus($partnerOrderID, $options) {

		if ( func_num_args() != 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}

		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'PartnerOrderID' => $partnerOrderID

			)

		);

		return $this->sendSOAP('CheckStatus', $params);

	}



	/**

	* Returns the fulfillment of an order.

	*

	* @param string - PartnerOrderID

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function GetFulfillment($partnerOrderID, $options = array()) {

		if ( func_num_args() < 1 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'PartnerOrderID' => $partnerOrderID,

			)

		);



		/* Before merging, we need to remove 'ReplayToken' in case it exists

		*	to prevent duplicate entries.

		* 	We need to merge the optional parameters with the rest of the request

		* 	because we can't put an array in the upper function. */

		$this->removeReplayToken($options);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('GetFulfillment', $params);

	}



	/**

	* Returns order detail records for all orders whose status was modified

	* in the specified date range.

	* This operation should ideally be run on a periodic basis (e.g. every 10

	* or 15 minutes) so that order status can be keupt up to date in a partner's

	* system. If no orders have changed status, a return count of zero is returned.

	*

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function GetModifiedOrders($fromDate, $toDate, $options = array()) {

		if ( func_num_args() < 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'FromDate' 	=> $fromDate,

				'ToDate'	=> $toDate,

				'OrderQueryOptions' => $options

			)

		);

		return $this->sendSOAP('GetModifiedOrders', $params);

	}



	/**

	* A lightweight version of GetModifiedOrders.

	* Returns simplified order details (partner order ID, GeoTrust order ID,

	* last modified date, partner code, and order state) for all modified orders

	* in the specified date range. The operation returns a ModifiedPartnerOrder

	* object that contains summary information for each of the partner's orders.

	* If the partner is a master reseller, an array containing ModifiedPartnerOrder

	* objects for each sub-reseller will be returned. If the information returned

	* by this operation is sufficient, consider using it instead of the more

	* expensive ModifiedPartnerOrder operation.

	* Ideally, this operation should run on a periodic basis (e.g., every 10 or 15 minutes)

	* so that order status can be kept up to date in a partner’s system. If no orders have

	* changed status, a return count of zero is returned.

	*

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @return array of strings

	* @access public

	*/

	function GetModifiedOrderSummary($fromDate, $toDate) {

		if ( func_num_args() != 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'FromDate' 	=> $fromDate,

				'ToDate'	=> $toDate,

			)

		);

		return $this->sendSOAP('GetModifiedOrderSummary', $params);

	}



	/**

	* Same as GetModifiedOrderSummary, but for PreAuth orders.

	*

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @return array of strings

	* @access public

	*/

	function GetModifiedPreAuthOrderSummary($fromDate, $toDate) {

		if ( func_num_args() != 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader(array());

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'FromDate' 	=> $fromDate,

				'ToDate'	=> $toDate,

			)

		);

		return $this->sendSOAP('GetModifiedPreAuthOrderSummary', $params);

	}



	/**

	* Returns the complete list of valid approver email messages for a specified domain.

	* This list contains three "types" of email addresses.

	*

	* @param string - domain (example: 'yahoo.com')

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function GetQuickApproverList($domain, $options = array()) {

		if ( func_num_args() < 1 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'Domain'		=> $domain

			)

		);

		return $this->sendSOAP('GetQuickApproverList', $params);

	}



	/**

	* Returns order detail records for all orders whose status was modified

	* in the specified date range.

	* This operation should ideally be run on a periodic basis (e.g. every 10

	* or 15 minutes) so that order status can be keupt up to date in a partner's

	* system. If no orders have changed status, a return count of zero is returned.

	*

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @param string - Timestamp in 'YYYY-MM-DDTHH:MM:SS' format. (24 hours)

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function GetOrdersByDateRange($fromDate, $toDate, $options = array(), $dnSearchString = '', $dnComponents = '') {

		if ( func_num_args() < 3 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'FromDate' 	=> $fromDate,

				'ToDate'	=> $toDate,

				'OrderQueryOptions' => $options

			)

		);

		if($dnSearchString != '')
			$params['Request']['DNSearchString'] = $dnSearchString;

		if($dnComponents != '')
			$params['Request']['DNComponents'] = $dnComponents;

		return $this->sendSOAP('GetOrdersByDateRange', $params);

	}



	/**

	* The GetUserAgreement operation allows partners to request the appropriate user agreement

	* for a particular product.

	*

	* Possible values for 'AgreementType' are 'ORDERING' and 'VULNERABILITY'.

	* @param string - ProductCode

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function GetUserAgreement($productCode, $options = array()) {

		if ( func_num_args() < 1 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'UserAgreementProductCode' => $productCode

			)

		);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('GetUserAgreement', $params);

	}



	/**

	* Parses a CSR and returns its' content.

	*

	* Possible values for 'AgreementType' are 'ORDERING' and 'VULNERABILITY'.

	* @param string - CSR

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function ParseCSR($CSR, $options = array()) {

		if ( func_num_args() < 1 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'Request' => array (

				'QueryRequestHeader' => $header,

				'CSR'	=> $CSR

			)

		);

		return $this->sendSOAP('ParseCSR', $params);

	}

	/*

	* Returns a list of PreAuth orders within a given date range.

	* If no "toDate" is specificed, the current timestamp will be used.

	*

	*/

   	function GetPreAuthOrdersByDateRange ($fromDate, $toDate, $organizationInfo, $options=array()) {

		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);

		$this->removeReplayToken($options);



		$params = array (

			'AuthQueryRequest' => array (

				'QueryRequestHeader' => $header,

				'QueryParameters' => array(

					'OrganizationInfo' => $organizationInfo,

					'FromDate' 	=> $fromDate,

					'ToDate'	=> $toDate,

				)

			)

		);

		return $this->sendSOAP('GetPreAuthOrdersByDateRange', $params);

	}

   	/*

   	* TODO

   	*

   	*/

   	function GetPreAuthOrderByPartnerOrderID ($partnerOrderID, $options = array()) {

		// Create the QueryRequestHeader parameter

		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(QUERY), $this->ssl_options);



		$this->removeReplayToken($options);



		$params = array (

			'AuthQueryRequest' => array (

				'QueryRequestHeader' => $header,

				'PartnerOrderID' => $partnerOrderID

			)

		);

		return $this->sendSOAP('GetPreAuthOrderByPartnerOrderID', $params);

	}

#######################

# ORDER API FUNCTIONS #

#######################



	/**

	* The QuickOrder command allows partners to perform all the actions that requestors would

	* typically perform using our Web forms to place an order with one API operation call.

	* This includes submitting the full order information, such as technical contact,

	* administrative contact, and CSR, as well as approver email address (if applicable).

	* Our system validates that the approver email address matches the set of approver email

	* addresses that would have been presented to the requestor. Orders can only be successfully

	* placed if there is a match between the addresses.

	*

	* @param array - OrderParameters: ValidityPeriod, CSR, WebServerType

	* @param array - OrganizationInfo: OrganizationName, OrganizationAddress (array), ...

	* @param array - AdminContact: FirstName, LastName, Phone, Email, Title, ...

	* @param array - TechContact: FirstName, LastName, Phone, Email, Title, ...

	* @param array - BillingContact: FirstName, LastName, Phone, Email, Title, ...

	* @param string - ApproverEmail: required for TrueBusinessID with EV. If you have another

	*					product, you can put an empty string here.

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function QuickOrder($productCode, $orderParameters, $organizationInfo, $adminContact, $techContact, $billingContact, $approverEmail, $options = array()) {

		if ( func_num_args() < 7 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);

		// The ProductCode and (the optional parameter) PartnerOrderID need to be in the header.

		$header['ProductCode'] = $productCode;



		// Passing a PartnerOrderID here is optional.

		if ( isset($options['PartnerOrderID']))

			$header['PartnerOrderID'] = $options['PartnerOrderID'];



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'OrderParameters'	=> $orderParameters,

				'OrganizationInfo'	=> $organizationInfo,

				'AdminContact'		=> $adminContact,

				'TechContact'		=> $techContact,

				'BillingContact'	=> $billingContact,

				'ApproverEmail'		=> $approverEmail

			)

		);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('QuickOrder', $params);

	}



	/**

	* QuickInvite is a mechanism that allows partners to invite a third party to complete an order. With QuickInvite, partners can pre-fill a subset of order data. Upon receiving a submission, our system sends an email to the requestor inviting the requestor to complete the order. The information provided by the partner is protected and cannot be edited by the requestor. From this point, the order process proceeds in the same manner as a typical Domain Vetted, Organization Vetted, or Domain and Organization Vetted order. Section 5.3.1 contains a complete profile of the fields used in the QuickInvite command for all product categories.

	*

	* @param array - OrderParameters: ValidityPeriod, CSR, WebServerType

	* @param array - OrganizationInfo: OrganizationName, OrganizationAddress (array), ...

	* @param array - AdminContact: FirstName, LastName, Phone, Email, Title, ...

	* @param array - TechContact: FirstName, LastName, Phone, Email, Title, ...

	* @param array - BillingContact: FirstName, LastName, Phone, Email, Title, ...

	* @param string - ApproverEmail: required for TrueBusinessID with EV. If you have another

	*					product, you can put an empty string here.

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function QuickInvite($productCode, $orderParameters, $organizationInfo, $adminContact, $techContact, $billingContact, $approverEmail, $options = array()) {

		if ( func_num_args() < 7 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);

		// The ProductCode and (the optional parameter) PartnerOrderID need to be in the header.

		$header['ProductCode'] = $productCode;



		// Passing a PartnerOrderID here is optional.

		if ( isset($options['PartnerOrderID']))

			$header['PartnerOrderID'] = $options['PartnerOrderID'];



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'OrderParameters'	=> $orderParameters,

				'OrganizationInfo'	=> $organizationInfo,

				'AdminContact'		=> $adminContact,

				'TechContact'		=> $techContact,

				'BillingContact'	=> $billingContact,

				'ApproverEmail'		=> $approverEmail

			)

		);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('QuickInvite', $params);

	}



	/**

	* The Reissue operation allows partners to initiate the reissue of an order so that customers

	* do not need to visit the GeoTrust website to initiate a reissue. Partners are expected to

	* properly validate the authority of customers to initiate certificate reissues prior to using

	* the API command to help assure that only an authorized person initiates the reissue.

	*

	* @param string

	* @param string reissue email

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function Reissue($partnerOrderID, $reissueEmail, $options = array(), $orderChanges = array()) {

		if ( func_num_args() < 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);



		// PartnerOrderID is a required parameter

		$header['PartnerOrderID'] = $partnerOrderID;



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'OrderParameters'	=> $options,

				'OrderChanges' => $orderChanges,

				'ReissueEmail'		=> $reissueEmail

			)

		);

		if(count($orderChanges) == 0){
			unset($params['Request']['OrderChanges']);
		}

		return $this->sendSOAP('Reissue', $params);

	}



	/**

	* Lets you modify your order. This function only works in the test environment

	* and is to help you simulate a fully processed order.

	*

	* Possible "ModifyOrderOperation" Values: (See API Section 5.3.4.12)

    *        APPROVE, RESELLER_APPROVE, RESELLER_DISAPPROVE, APPROVE_ESSL,

    *        REJECT, CANCEL, UPDATE_POST_STATUS, DEACTIVATE, REQUEST_ON_DEMAND_SCAN,

    *        UPDATE_SEAL_PREFERENCES, REQUEST_VULNERABILITY SCAN

	*

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function ModifyOrder($partnerOrderID, $orderOperation, $options = array()) {

		if ( func_num_args() < 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);

		// We need the PartnerOrderID in the header.

		$header['PartnerOrderID'] = $partnerOrderID;



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'ModifyOrderOperation' => $orderOperation

			)

		);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('ModifyOrder', $params);

	}



	/**

	* The ChangeApproverEmail operation allows partners to change the domain approver email for orders where the domain approval

	* process has not been completed. This operation applies to all GeoTrust and Thawte domain validated and organization and domain

	* validated certificates.

	*

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function ChangeApproverEmail($partnerOrderID, $approverEmail, $options = array()) {

		if ( func_num_args() < 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		// We need the PartnerOrderID in the header.

		$header['PartnerOrderID'] = $partnerOrderID;



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'ApproverEmail' => $approverEmail

			)

		);

		return $this->sendSOAP('ChangeApproverEmail', $params);

	}



	/**

	* Allows partners to validate a number of order fields in one API message. This allows partners to perform

	* validation prior to submitting an order, which provides a better UI experience for users.

	* If any of the fields are invalid, an error will be returned listing all the errors. If there are no errors,

	* the operation will provide responses for many of the values and include additional information.

	* Optionally, the ValidateOrderParameters operation can also be invoked, specifying only the CSR to exclusively test validity of the CSR.

	*

	* @param string Product code

	* @param array of key => value pairs: order parameters

	* @param array of key => value pairs: further optional parameters (add ReplayToken here)

	* @return array of strings

	* @access public

	*/

	function ValidateOrderParameters($productCode, $orderParams, $options = array()) {

		if ( func_num_args() < 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);

		// The ProductCode and (the optional parameter) PartnerOrderID need to be in the header.

		$header['ProductCode'] = $productCode;



		// Passing a PartnerOrderID here is optional.

		if ( isset($options['PartnerOrderID']))

			$header['PartnerOrderID'] = $options['PartnerOrderID'];



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'OrderParameters'	 => $orderParams

			)

		);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('ValidateOrderParameters', $params);

	}



	/**

	* The ResendEmail operation allows partners to resend various email messages sent by GeoTrust

	* in the course of processing orders. Certain email types may not apply for a particular order.

	*

	* @param string: ProductCode

	* @param string: PartnerOrderID

	* @param string: Possible values: InviteEmail, ApproverEmail, PickUpEmail, FulfillmentEmail, PhoneAuthEmail

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function ResendEmail($productCode, $partnerOrderID, $resendMailType, $options = array()) {

		if ( func_num_args() < 3 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);

		// The ProductCode and (the optional parameter) PartnerOrderID need to be in the header.

		$header['ProductCode'] = $productCode;

		$header['PartnerOrderID'] = $partnerOrderID;



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'ResendEmailType'	 => $resendMailType

			)

		);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('ResendEmail', $params);

	}







	/**

	* GeoTrust SSL revoke

	* The following revoke functionality is currently available for GeoTrust certificates only.

	* One of two reasons must be cited when submitting a GeoTrust revocation request via the API.

	*

	* - 'cessation of service' – this revocation request is used when a partner wants to ensure

	* 	non-use of a certificate the end customer has stopped paying for. In this instance,

	*	Symantec verifies the certificate is still live on a server prior to revoking the certificate.

	*

	* - 'key Compromise' – this reason is cited when the certificates private key has been compromised.

	*	Symantec immediately revokes the certificate on approval when this reason is cited in the request.

	*

	* In each case, the request must be confirmed via a link sent in an email to the technical contact.

	*

	* @param string: Certificate

	* @param string: Reason why you are revoking

	* @param array of key => value pairs

	* @return array of strings

	* @access public

	*/

	function Revoke($certificate, $revokeReason, $options = array()) {

		if ( func_num_args() < 2 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);



		$params = array (

			'Request' => array (

				'OrderRequestHeader' => $header,

				'Certificate'	 => $certificate,

				'RevokeReason'	 => $revokeReason

			)

		);

		$params['Request'] = array_merge($params['Request'], $options);

		return $this->sendSOAP('Revoke', $params);

	}



	/*

	* Returns all Replay Tokens you have used so far.

	* @return array of strings

	* @access public

	*/

	function ShowReplayTokens() {

		$options = array();

		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);



		$params = array ('PartnerCode' => $this->partnerCode);

		return $this->sendSOAP('ShowReplayTokens', $params);

	}

   	/*

   	* The OrderPreAuthentication operation allows the submission of Symantec Ready

	* Issuance orders. It requires an organization and optionally a domain name and

	* contact pair.

   	*

   	*/

    function OrderPreAuthentication ($productCode, $orderParameters, $authData, $billingContact, $options) {

		if ( func_num_args() != 5 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);

		// The ProductCode and (the optional parameter) PartnerOrderID need to be in the header.

		$header['ProductCode'] = $productCode;



		// Passing a PartnerOrderID here is optional.

		if ( isset($options['PartnerOrderID']))

			$header['PartnerOrderID'] = $options['PartnerOrderID'];



		$params = array (

			'AuthOrderRequest' => array (

				'OrderRequestHeader' => $header,

				'OrderParameters'	=> $orderParameters,

				'AuthData'			=> $authData,

				'BillingContact'	=> $billingContact,

			)

		);

		$params['AuthOrderRequest'] = array_merge($params['AuthOrderRequest'], $options);

		return $this->sendSOAP('OrderPreAuthentication', $params);



    }

    /*

    * TODO

    *

    */

    function ValidatePreAuthenticationData ($productCode, $authData, $options) {

		if ( func_num_args() != 3 ) {

			return __FUNCTION__ . ": Wrong number of arguments.";

		}



		$header = $this->createRequestHeader($options);

		$this->soap = new SoapClient($this->getAPIURL(ORDER), $this->ssl_options);

		$this->removeReplayToken($options);

		// The ProductCode and (the optional parameter) PartnerOrderID need to be in the header.

		$header['ProductCode'] = $productCode;



		// Passing a PartnerOrderID here is optional.

		if ( isset($options['PartnerOrderID']))

			$header['PartnerOrderID'] = $options['PartnerOrderID'];



		$params = array (

			'ValidateAuthDataRequest' => array (

				'ValidateRequestHeader' => $header,

				'AuthData'	 => $authData

			)

		);

		$params['ValidateAuthDataRequest'] = array_merge($params['ValidateAuthDataRequest'], $options);

		return $this->sendSOAP('ValidatePreAuthenticationData', $params);

    }

    function rvsslLog($boolean)
    {
    	$this->rvsslLog = $boolean;
    }

    function rvsslLogger($content)
    {
    	if($this->rvsslLog){
    		$logPath = '/home/rvglobal/public_html/ssl.log';
    		if(is_array($content) || is_object($content)){
    			file_put_contents($logPath, "\n\n=========Array========\n\n", FILE_APPEND);
    			file_put_contents($logPath, print_r($content, 1), FILE_APPEND);
    			file_put_contents($logPath, "\n\n=======END-Array======\n\n", FILE_APPEND);
    		} else {
    			file_put_contents($logPath, $content, FILE_APPEND);
    		}
    	}
    }

    function getInfo()
    {
    	$data = array(
    			'partner_code' => $this->partnerCode
    			, 'username' => $this->userName
    			, 'mode' => ($this->useTestAPI) ? 'test' : 'real'
    			, 'contractId' => $this->mainContractID
    	);
    	return $data;
    }

	function rvsslOrderLogger($domain, $hashing)
    {
    	$logPath = '/home/rvglobal/public_html/ssl-order.log';
    	if(file_exists($logPath)){
    		file_put_contents($logPath, "{$domain} ====> {$hashing}\n", FILE_APPEND);
    	}
    }

    function reArrangeError($data)
    {
    	foreach($data as $fnResult => $val){
    		if(is_array($val) && isset($val['OrderResponseHeader']['Errors']['Error']['ErrorCode'])){
    			$error = $val['OrderResponseHeader']['Errors']['Error'];
    			unset($data[$fnResult]['OrderResponseHeader']['Errors']['Error']);
    			$data[$fnResult]['OrderResponseHeader']['Errors']['Error'][0] = $error;
    		} else if(is_array($val) && isset($val['QueryResponseHeader']['Errors']['Error']['ErrorCode'])){
    			$error = $val['QueryResponseHeader']['Errors']['Error'];
    			unset($data[$fnResult]['QueryResponseHeader']['Errors']['Error']);
    			$data[$fnResult]['QueryResponseHeader']['Errors']['Error'][0] = $error;
    		}
    	}
    	return $data;
    }

}

?>
