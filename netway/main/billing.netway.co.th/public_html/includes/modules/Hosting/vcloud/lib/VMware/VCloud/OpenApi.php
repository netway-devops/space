<?php

require_once __DIR__ . '/ServiceTrait.php';

/**
 * Accessing point for VMware vCloud Director.
 *
 * @package VMware_VCloud_SDK
 */
class VMware_VCloud_SDK_OpenApi {

    use VMware_VCloud_SDK_Service_Trait;

    /**
     * vCloud Director login URL.
     */
    private $loginUrl = null;

    /**
     * vCloud Director base URL. 
     */
    private $baseUrl = null;

    /**
     * Constructor
     *
     * @param VMware_VCloud_SDK_Http_Client_Interface $client
     * @access private
     */
    private function __construct($client) {
        if ($client instanceof MyCurlClient) {
            $client->setAcceptHeader('application/json');
        }
        $this->setHttpClient($client);
    }

    /**
     * Get a VMware_VCloud_SDK_Server object
     *
     * @param VMware_VCloud_SDK_Http_Client_Interface $client An object implements
     *                        VMware_VCloud_SDK_Http_Client_Interface. If it is
     *                        null, use the default implementation,
     *                        VMware_VCloud_SDK_Http_Client
     * @return self
     * @since Version 1.0.0
     */
    public static function getService($client = null) {
        if (!$client) {
            $client = new VMware_VCloud_SDK_Http_Client();
        }
        return new self($client);
    }

    /**
     * Set login URL.
     *
     * @param string $url Login URL
     * @return null
     * @since Version 1.0.0
     */
    public function setLoginUrl($url) {
        $this->loginUrl = $url;
    }

    /**
     * Login to VMware vCloud Director.
     *
     * @param string $server Server IP or host name and port
     * @param array $auth In array('username'=><username>,
     *                                 'password'=><password>) format
     * @param array $config An HTTP configuration array
     * @param string $apiVersion An API Version
     * @return VMware_VCloud_API_OrgListType
     * @since API Version 1.0.0
     * @since SDK Version 5.5.0
     */
    public function login($server, $auth, $config, $apiVersion) {
        if (false === strpos($server, 'http')) {
            $server = "https://$server";
        }
        $this->setConfig($config);
        $this->setAPIVersion($apiVersion);
        $this->setUrl($server);

        $credential = $auth['username'] . ':' . $auth['password'];
        // Encodes data with MIME base64
        $encodeddata = base64_encode($credential);
        $auth = "Basic " . $encodeddata;

        return $this->post($this->loginUrl, [
            'Accept' => 'application/*+json',
            'Authorization' => $auth
        ]);
    }

    /**
     * Set vcloud token for login.
     *
     * @param string $server Server IP or host name and port
     * @param string $vcloudtoken Vcloud Token
     * @param array $config An HTTP configuration array
     * @param string $apiVersion An API Version
     * @since API Version 5.1.0
     * @since SDK Version 5.1.0
     */
    public function SetVcloudToken($server, $vcloudtoken, $config, $apiVersion) {
        if (false === strpos($server, 'http')) {
            $server = "https://$server";
        }
        $this->setToken($vcloudtoken);
        $this->setConfig($config);
        $this->setAPIVersion($apiVersion);
        $this->setUrl($server);
    }

    public function setUrl($server) {
        if (!$this->baseUrl) {
            $this->baseUrl = $server . '/cloudapi/1.0.0';
        }

        if (!$this->loginUrl) {
            $this->loginUrl = $server . '/api/sessions';
        }
    }

    /**
     * Get base URL of the VMware vCloud Director.
     *
     * @return string Base URL
     * @since Version 1.0.0
     */
    public function getBaseUrl() {
        return $this->baseUrl;
    }

    protected function prepareUrl($url) {
        if (strpos($url, 'http') !== 0) {
            $url = $this->getBaseUrl() . '/' . ltrim($url, '/ ');
        }
        return $url;
    }

    /**
     * Sets HTTP configuration
     *
     * @param string $url URL to send an HTTP request
     * @param array|null $headers
     * @return mixed VMware vCloud data object or response body
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function get($url, $headers = null) {
        $url = $this->prepareUrl($url);
        $response = $this->httpClient->get($url, $headers);
        $code = $response->getStatus();
        $body = $response->getBody();

        $obj = json_decode($body, true);

        if (200 !== (int) $code) {
            $this->_error($obj);
            throw new VMware_VCloud_SDK_Exception("$body");
        }

        return $this->_parase($response, $obj);
    }

    /**
     * Send an HTTP POST request.
     *
     * @param string $url URL to send an HTTP request
     * @param array|null $headers
     * @param mixed $data
     * @param int[] $expect
     * @return mixed A VMware vCloud data object
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function post($url, $headers = null, $data = null, $expect = [200, 202]) {
        $data = json_encode($data, JSON_PRETTY_PRINT);

        $headers = array_merge((array) $headers, [
            'Content-Type' => 'application/json',
            'Content-Length' => strlen($data)
        ]);

        $url = $this->prepareUrl($url);
        $response = $this->httpClient->post($url, $headers, $data);
        $code = $response->getStatus();
        $body = $response->getBody();

        $obj = json_decode($body, true);

        $expect = (array) $expect;

        if (!empty($expect) && !in_array($code, $expect, true)) {
            $this->_error($obj);
            throw new VMware_VCloud_SDK_Exception("POST $url failed, return " .
                                                  "code: $code, error: $body, request data:\n$data\n");
        }

        return $this->_parase($response, $obj);
    }

    /**
     * Send an HTTP PUT request.
     *
     * @param string $url URL to send an HTTP request
     * @param array|null $headers
     * @param mixed $data
     * @return mixed A VMware vCloud data object
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function put($url, $headers = null, $data = null, $expect = [200]) {

        $data = json_encode($data, JSON_PRETTY_PRINT);
        $headers = array_merge((array) $headers, [
            'Content-Type' => 'application/json',
            'Content-Length' => strlen($data)
        ]);

        $url = $this->prepareUrl($url);
        $response = $this->httpClient->put($url, $headers, $data);
        $code = $response->getStatus();
        $body = $response->getBody();

        $obj = json_decode($body, true);

        $expect = (array) $expect;

        if (!empty($expect) && !in_array($code, $expect, true)) {
            $this->_error($obj);
            throw new VMware_VCloud_SDK_Exception("PUT $url failed, error " .
                                                  "code: $code, error: $body, request data:\n$data\n");
        }

        return $this->_parase($response, $obj);
    }

    /**
     * Send an HTTP DELETE request.
     *
     * @param string $url URL to send an HTTP request
     * @param array|null $headers
     * @param int[] $expect Expected HTTP status code on a successful request
     * @return mixed
     * @throws VMware_VCloud_SDK_ApiException
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function delete($url, $headers = null, $expect = [200]) {
        $url = $this->prepareUrl($url);
        $response = $this->httpClient->get($url, $headers);
        $code = $response->getStatus();
        $body = $response->getBody();

        $obj = json_decode($body, true);
        $expect = (array) $expect;

        if (!empty($expect) && !in_array($code, $expect, true)) {
            $this->_error($obj);
            throw new VMware_VCloud_SDK_Exception("DELETE $url failed, " .
                                                  "error code: $code, error: $body\n");
        }

        return $this->_parase($response, $obj);
    }

    protected function _parase(VMware_VCloud_SDK_Http_Response_Interface $response, $obj){
        if(!empty($obj)){
            return $obj;
        }

        $url = $response->getHeader('location');
        if($url && strpos($url, $this->baseUrl) === 0){
            return $this->get($url);
        }

        return [
            'location' => $url
        ];
    }

    protected function _error($data) {
        if(!$data && !is_array($data)){
            return;
        }

        $errorCode = $data['minorErrorCode'] ?: $data['vendorSpecificErrorCode'] ?: $data['majorErrorCode'];
        $errorMessage = $data['message'] ?: $data['stackTrace'];

        throw new VMware_VCloud_SDK_ApiException(
            "$errorCode: $errorMessage", $data['minorErrorCode'], $data['majorErrorCode']
        );
    }

}
