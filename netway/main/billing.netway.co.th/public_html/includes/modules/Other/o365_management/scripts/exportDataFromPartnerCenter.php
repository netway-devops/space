<?php
class AzureApi {
    protected $resource_url;
    protected $tenant_id;
    protected $app_id;
    protected $app_secret;
    protected $timeout;

    private $_token = array();

    private $aDebugMsg = array();

    function __construct($resource_url, $tenant_id, $app_id, $app_secret, $timeout=120) 
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
            if (count($params) > 1) {
                $_opt_array[CURLOPT_POSTFIELDS] = $this->_buildPostData($params);
            } else {
                $_opt_array[CURLOPT_POSTFIELDS] = '';
            }

            curl_setopt_array($curl, $_opt_array);
            $response = curl_exec($curl);
            $err = curl_error($curl);
            curl_close($curl);
            if ($err) {
                throw new Exception("cURL Error: " . $err);
            } else {
                return $response;
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
            
            $aResults = null;
            $aHeaders = array(
                'Accept' => 'application/json',
                'Authorization' => 'Bearer ' . $this->get_access_token(),
                'X-Locale' => 'en-US',
                'Content-Type' => 'application/json'
            );
            
            $doLoop = false;
            do {
                $_url = 'https://api.partnercenter.microsoft.com/v1' . $url;
                $response = $this->_call(
                    $method, 
                    $_url,
                    $params,
                    $aHeaders
                );
                $aResponse  = json_decode($response , true);
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
            $invoiceDetailData = $this->callPartnerApi('GET', '/invoices/' . strtolower(trim($invoice_id)));
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
            return json_decode($subscriptionsData , true);
        } catch (Exception $ex) {
            throw new Exception($ex->getMessage());
        }
    }
    
    public function get_debug_message() 
    {
        return $this->aDebugMsg;
    }
  
}


function fixBillingCycleName($billingCycle) {
    $_billingCycle = $billingCycle;
    switch ($billingCycle) {
        case 'annual': $_billingCycle = 'annually'; break;
        case 'month': $_billingCycle = 'monthly'; break;
    }
    return $_billingCycle;
}

function main()
{
    try {
        $resource_url = 'https://api.partnercenter.microsoft.com';
        $tenant_id = 'ecf92b64-6863-4193-8daa-64d0e8d02998';
        $app_id = '20d7eb6a-b9e6-47b0-9490-d9ac1b951f0f';
        $app_secret = 'W_QoZSkv-1fs8uU6Yo3xmF43JH_RP_7.8n';
        $oAZConn = new AzureApi($resource_url, $tenant_id, $app_id, $app_secret);

        $aResult = array(
            'customers' => array(),
        );

        echo "Get customers from Microsoft Partner Center...";
        $aAzCustomers = $oAZConn->partnerApiGetCustomers();

        if (!isset($aAzCustomers['items'])) {
            throw new Exception('Cannot get customers from Azure Partner Center');
        }

        foreach ($aAzCustomers['items'] as $item) {
            $tenantId = strtolower(trim($item['companyProfile']['tenantId']));
            $aResult['customers'][$tenantId] = array(
                'tenantId' => $tenantId,
                'companyProfile' => $item['companyProfile'],
                'domain' => trim($item['companyProfile']['domain']),
                'subsctiptions' => array()
            );
        }
        echo " Found " . count($aResult['customers']) . " tenant(s).\n";

        $countSubscriptionsActive = 0;
        $count = 0;
        foreach ($aResult['customers'] as $customer_id => $item) {
            $process = (int) (($count*100) /1000);
            echo "[$process%] Get subscriptions for customer ID: " . $customer_id . "...";
            $aSubscriptions = $oAZConn->partnerApiGetSubscriptionsByCustomerID($customer_id);
            if (isset($aSubscriptions['totalCount'])) {
                echo " " . $aSubscriptions['totalCount'] . " record(s).\n";
            } else {
                echo " None record.\n";
            }

            if (isset($aSubscriptions['totalCount']) && (int) $aSubscriptions['totalCount'] > 0) {
                foreach ($aSubscriptions['items'] as $item) {
                    $_offerName = trim($item['offerName']);
                    $_billingCycle = fixBillingCycleName(strtolower(trim($item['billingCycle'])));
                    $_status = strtolower(trim($item['status']));
                    if ($_status == 'active') {
                         $countSubscriptionsActive += 1;
                        array_push($aResult['customers'][$customer_id]['subsctiptions'], array(
                            'subscriptionId' => strtolower(trim($item['id'])),
                            'offerId' => strtolower(trim($item['offerId'])),
                            'offerName' => $_offerName,
                            'billingCycle' => $_billingCycle,
                            'quantity' => strtolower(trim($item['quantity'])),
                            'status' => $_status,
                            'creationDate' => $item['creationDate'],
                            'effectiveStartDate' => $item['effectiveStartDate'],
                            'commitmentEndDate' => $item['commitmentEndDate'],
                            'termDuration' => $item['termDuration'],
                        ));
                    }
                }
            }
            $count += 1;
        }
        $aResult['updayeAt'] = time();
        $aResult['totalCustomers'] =  count($aResult['customers']);
        $aResult['totalSubscription'] =  $countSubscriptionsActive;

        $handle = fopen(dirname(__FILE__) . "/../data/export_ms_partner_center_data.json", "w");
        fwrite($handle,  json_encode($aResult));
        fclose($handle);
        echo "######################################################################\n";
        echo "# Reports\n";
        echo "######################################################################\n";
        echo "Found customer(s):" . count($aResult['customers']) . " record(s).\n";
        echo "Total:" . $countSubscriptionsActive . " subscription(s) is active.\n";
        echo "######################################################################\n";
        echo "Export Data from Microsoft partner center has been successfully.";
    } catch (Exception $ex) {
        echo "\n";
        throw new Exception($ex->getMessage());
    }
}

main();
