<?php
class AzureApi {
    protected $resource_url;
    protected $tenant_id;
    protected $app_id;
    protected $app_secret;
    protected $timeout;

    private $_token = array();

    private $aDebugMsg = array();

    function __construct($resource_url, $tenant_id, $app_id, $app_secret, $timeout=30) 
    {
        $this->resource_url = $resource_url;
        $this->tenant_id = $tenant_id;
        $this->app_id = $app_id;
        $this->app_secret = $app_secret;
        $this->timeout = $timeout;
        if (isset($_SESSION['AZURE_ACCESS_TOKEN'])) {
            $this->_token = $_SESSION['AZURE_ACCESS_TOKEN'];
        }
        $this->_login();
    }

    private function get_access_token() 
    {
        return $this->_token['access_token'];
    }

    public function has_access_token() 
    {
        return isset($this->_token['access_token']) ? true : false;
    }

    public function access_token_is_active() 
    {
        if ($this->has_access_token() && isset($this->_token['expires_on']) &&  $this->_token['expires_on'] > time()) {
            return true;
        } else {
            return false;
        }
    }

    public function set_timeout($timeout) 
    {
        $this->timeout = $timeout;
    }

    private function _login()
    {
        try {
            $response = $this->_call(
                'POST', 
                'https://login.microsoftonline.com/' . $this->tenant_id . '/oauth2/token',
                array(
                    'grant_type' => 'client_credentials',
                    'client_id' => $this->app_id,
                    'client_secret' => $this->app_secret,
                    'resource' => 'https://graph.windows.net',
                    'response_type' => 'token'
                ),
                array(
                    'cache-control' => 'no-cache',
                    'Accept' => 'application/json',
                    'Content-Type' => 'application/x-www-form-urlencoded'
                )
            );
            $aResponse =json_decode($response, true);
            $this->_token = array();
            if (isset($aResponse['access_token'])) {
                $this->_token['expires_on'] = time() + ((intval($aResponse['expires_in']) - 10) * 1000);
                $this->_token['access_token'] = $aResponse['access_token'];
                $_SESSION['AZURE_ACCESS_TOKEN'] = $this->_token;
            } else {
                unset($_SESSION['AZURE_ACCESS_TOKEN']);
                throw new Exception('Cannot authentication to microsoftonline!!');
            }
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }


    private function _call($method, $url, $params=array(), $headers = array()) 
    {
        try {
            $curl = curl_init();
            $_opt_array = array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => $this->timeout,
                CURLOPT_CUSTOMREQUEST => strtoupper($method),
                CURLOPT_HTTPHEADER => $this->_buildHeadersData($headers)
            );
            if (is_array($params)) {
                if (count($params) > 1) {
                    $_opt_array[CURLOPT_POSTFIELDS] = $this->_buildPostData($params);
                } else {
                    $_opt_array[CURLOPT_POSTFIELDS] = '';
                }
            } else {
                $_opt_array[CURLOPT_POSTFIELDS] = $params;
            }
            curl_setopt_array($curl, $_opt_array);
            if (strtoupper($method) == 'HEAD') {
                curl_setopt($curl, CURLOPT_NOBODY, true);
            } 
            $response = curl_exec($curl);
            $err = curl_error($curl);
            $aHeaderResponse = curl_getinfo($curl);
            curl_close($curl);
            if ($err) {
                throw new Exception("cURL Error: " . $err);
            } else {
                if (strtoupper($method) == 'HEAD') {
                    return $aHeaderResponse;
                } else {
                    return $response;
                }
            }
        } catch (Exception $ex) {
            throw new Exception($ex);
        }
    }

    private function _buildPostData($params) 
    {
        $_params = array();
        foreach( $params as $key => $vaule) {
            if ($key == 'resource') {
                array_push($_params, $key . '=' . urlencode($vaule));
            } else {
                array_push($_params, $key . '=' . $vaule);
            }
        }
        return join("&", $_params);
    }

    private function _buildHeadersData($headers)
    {
        $_headers = array();
        foreach( $headers as $key => $vaule) {
            array_push($_headers, $key . ': ' . $vaule);
        }
        return $_headers;
    }

    public function callPartnerApi($method, $url, $params=array()) 
    {
        try {
            if ($this->access_token_is_active() == false) {
                $this->_login();
            }
            $aHeaders = array(
                'Accept' => 'application/json',
                'Authorization' => 'Bearer ' . $this->get_access_token(),
                'X-Locale' => 'en-US',
                'Content-Type' => 'application/json'
            );

            $aResults = null;
            $doLoop = false;
            do {
                $_url = 'https://api.partnercenter.microsoft.com/v1' . $url;

                $response = $this->_call(
                    $method, 
                    $_url,
                    json_encode($params),
                    $aHeaders
                );
                $aResponse = json_decode($response , true);

                if (isset($aResponse['code']) && isset($aResponse['description'])) {
                    throw new Exception('Microsoft Partner Center API response error. (code: ' . $aResponse['code'] . ') ' . $aResponse['description']);
                } 
                if ($aResults == null) {
                    $aResults = $aResponse;
                } else {
                    $aResults = array_merge_recursive($aResults, $aResponse);
                }
                if (isset($aResponse['links']['next'])) {
                    $method = $aResponse['links']['next']['method'];
                    $url = $aResponse['links']['next']['uri'];
                    foreach ($aResponse['links']['next']['headers'] as $index => $aValue) {
                        $aHeaders[$aValue['key']] = $aValue['value'];
                    }
                    $doLoop = true;
                } else {
                    $doLoop = false;
                }
            } while ($doLoop);
            return json_encode($aResults);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    public function getPartnerUsagesummary() 
    {
        try {
            $usagesummaryData = $this->callPartnerApi('GET', '/usagesummary');
            return json_decode($usagesummaryData , true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Get customers of an indirect reseller
     * @link https://docs.microsoft.com/en-us/partner-center/develop/get-customers-of-an-indirect-reseller
     * @param $filter Array ; array("Field" => "${FieldName}", "Value" => "${Value}", "Operator" => "${Operator}")
     * 
     * @link Operator: https://docs.microsoft.com/en-us/dotnet/api/microsoft.store.partnercenter.models.query.fieldfilteroperation?view=partnercenter-dotnet-latest
     */
    public function partnerApiGetCustomers($filter=null) 
    {
        try {
            $url = '/customers';
            if ($filter != null) {
                $url .= '?filter=' . json_encode($filter);
            }
            $usagesummaryData = $this->callPartnerApi('GET', $url);
            return json_decode($usagesummaryData , true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    public function partnerApiGetInvoices() 
    {
        try {
            $usagesummaryData = $this->callPartnerApi('GET', '/invoices');
            return json_decode($usagesummaryData , true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    public function partnerApiGetInvoiceDetail($invoice_id)
    {
        try {
            $invoiceDetailData = $this->callPartnerApi('GET', '/invoices/'.strtolower(trim($invoice_id)));
            return json_decode($invoiceDetailData , true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    public function partnerApiGetCustomerInfoID($customer_id)
    {
        try {
            $subscriptionsData = $this->callPartnerApi('GET', '/customers/' . strtolower(trim($customer_id)));
            return json_decode($subscriptionsData , true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    public function partnerApiGetSubscriptionsByCustomerID($customer_id)
    {
        try {
            $subscriptionsData = $this->callPartnerApi('GET', '/customers/' . strtolower(trim($customer_id)) . '/subscriptions');
            return json_decode($subscriptionsData, true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Create a customer using Partner Center APIs
     * @link https://docs.microsoft.com/en-us/partner-center/develop/create-a-customer
     * @param $domain <string>
     * @param $aBillingProfile <array>
     * @param $aDefaultAddress <array>
     * 
     * @return <array>
     */
    
    public function partnerApiCreateCustomer($domain, $aBillingProfile=array(), $aDefaultAddress=array())
    {
        try {
            $aAllowBillingProfileOpt = array('Culture', 'Email', 'Language', 'CompanyName');
            $aAllowDefaultAddressOpt = array('FirstName', 'LastName', 'AddressLine1', 'City', 'State', 'PostalCode', 'Country');


            $aBillingProfiles = array(
                'Culture' => isset($aBillingProfile['Culture']) ? $aBillingProfile['Culture'] : "en-US",
                'Email' => $aBillingProfile['Email'],
                'Language' => isset($aBillingProfile['Language']) ? $aBillingProfile['Language'] : "en",
                'CompanyName' => isset($aBillingProfile['CompanyName']) ? $aBillingProfile['CompanyName']: "",
                'DefaultAddress' => array(
                    'FirstName' => $aDefaultAddress['FirstName'],
                    'LastName' => $aDefaultAddress['LastName'],
                    'AddressLine1' => $aDefaultAddress['AddressLine1'],
                    'City' => $aDefaultAddress['City'],
                    'State' => $aDefaultAddress['State'],
                    'PostalCode' => $aDefaultAddress['PostalCode'],
                    'Country' => $aDefaultAddress['Country'],
                    'PhoneNumber' => isset($aDefaultAddress['PhoneNumber']) ? $aDefaultAddress['PhoneNumber'] : ""
                )
            );
            $aSendParams = array(
                'CompanyProfile' => array(
                    'Domain' => $domain
                ),
                'BillingProfile' => $aBillingProfiles
            );
            return json_decode($this->callPartnerApi('POST', '/customers', $aSendParams), true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Get an order by ID
     * @link https://docs.microsoft.com/en-us/partner-center/develop/get-an-order-by-id
     */
    public function partnerApiGetAnOrder($customerID, $orderID)
    {
        try {
            $orderData = $this->callPartnerApi('GET', '/customers/' . strtolower(trim($customer_id)) . '/orders/' . strtolower(trim($orderID)));
            return json_decode($orderData, true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Create an order for a customer using Partner Center APIs
     * 
     * @link https://docs.microsoft.com/en-us/partner-center/develop/create-an-order
     */
    public function partnerApiCreateAnOrder($customerID, $offerId, $quantity, $billingCycle)
    {
        try {
            $aSendParams = array(
                'BillingCycle' => $billingCycle,
                "CurrencyCode" => "USD",
                'LineItems' => array(
                    array(
                        'LineItemNumber' => 0,
                        'OfferId' =>  $offerId,
                        'Quantity' => $quantity
                    )
                )
            );
            return json_decode($this->callPartnerApi('POST', '/customers/' . strtolower(trim($customerID)) . '/orders', $aSendParams), true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Verify domain availability
     * If the domain exists, it isn't available for use and a response status code 200 OK is returned. 
     * If the domain isn't found, it's available for use and a response status code 404 Not Found is returned.
     * 
     * @link https://docs.microsoft.com/en-us/partner-center/develop/verify-domain-availability
     * @param $domain <string>
     * 
     * @return <array> ; curl header
     */
    public function partnerApiVerifyDomainAvailability($domain)
    {
        try {
            $response = $this->callPartnerApi('HEAD', '/domains/' . $domain);
            return $response;
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Suspend a subscription
     * Suspends a Subscription resource that matches the customer and subscription ID due to fraud or non-payment.
     * @link https://docs.microsoft.com/en-us/partner-center/develop/suspend-a-subscription
     */
    public function partnerApiSuspendSubscription($customerID, $subscription)
    {
        try {
            return json_decode($this->callPartnerApi('PATCH', '/customers/' . strtolower(trim($customerID)) . '/subscriptions/' . strtolower(trim($subscription))), true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }

    public function get_debug_message() 
    {
        return $this->aDebugMsg;
    }
}
