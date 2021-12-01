<?php


/**
 * @see VMware_VCloud_SDK_Http_Client_Interface
 */
require_once 'VMware/VCloud/Http/IClient.php';

/**
 * Constants
 */
require_once 'VMware/VCloud/Constants.php';
require_once 'curl/curl.php';
require_once 'curl/curl_response.php';

class MyCurlClient implements VMware_VCloud_SDK_Http_Client_Interface {

    /**
     *
     * @var vcloud\Curl 
     */
    var $curl;
    var $options = [];

    /**
     * HTTP_Request2 configuration parameters
     * @see HTTP_Request2 $apiVersion variable
     */
    private $apiVersion;

    /**
     * Set the API Version
     *
     * @param array $apiVersion An API Version
     * @since SDK Version 5.1.1
     */
    public function setAPIVersion($apiVersion) {
        $this->apiVersion = $apiVersion;
    }

    /**
     * Sets the vcloud token
     *
     * @return string|null $vcloudToken
     * @since API 5.1.0
     * @since SDK 5.1.0
     */
    public function setVcloudToken($authToken) {
        $this->authToken = $authToken;
    }

    /**
     * @return string|null
     */
    public function getVcloudToken() {
        return $this->authToken;
    }


    public function __construct() {
        $this->curl = new vcloud\Curl;
    }

    protected $username;
    protected $password;

    public function setAuth($auth) {
        $this->username = $auth['username'];
        $this->password = $auth['password'];
    }

    protected $authToken;
    protected $acceptHeader = VMware_VCloud_SDK_Constants::VCLOUD_ACCEPT_HEADER;

    private function sendRequest($url, $method, $headers = null, $body = null) {
        $this->curl->headers = array();
        $this->curl->options = $this->options;

        $this->curl->options['CURLOPT_SSL_VERIFYHOST'] = false;
        $this->curl->options['CURLOPT_SSL_VERIFYPEER'] = false;
        $this->curl->headers['Accept'] = $this->acceptHeader . ';' . 'version=' . $this->apiVersion;

        if ($this->authToken) {
            $this->curl->headers['Authorization'] = $this->authToken;
        } else {
            $this->curl->options['CURLOPT_USERPWD'] = $this->username . ':' . $this->password;

        }
        if ($headers) {
            $h = $this->curl->headers;
            $h = array_merge($h, $headers);
            $this->curl->headers = $h;
        }
        /** @var \vcloud\CurlResponse $response */
        $response = $this->curl->$method($url, $body);
        //  var_dump($url,$method,$this->curl,$body);

        if (!is_object($response) && $this->curl->error()) {
            // var_dump($url,$method,$headers,$body,$this->curl);
            throw new Exception ($this->curl->error());
        }

        if (!$this->authToken) {
            //$this->authToken = $response->headers[VMware_VCloud_SDK_Constants::VCLOUD_AUTH_TOKEN];
            $this->authToken = $response->getHeader('X-VMWARE-VCLOUD-TOKEN-TYPE')
                               . ' ' . $response->getHeader('X-VMWARE-VCLOUD-ACCESS-TOKEN');
        }
        return $response;

    }

    public function get($url, $headers = null) {
        return $this->sendRequest($url, 'get', $headers);
    }

    public function post($url, $headers, $data) {
        if (stripos($url, '/vdcs') !== false && stripos($data, 'vmext:NetworkPoolReference') !== false) {
            //hack
            $data = str_replace('<vmext:NetworkPoolReference', '<NetworkPoolReference', $data);
            $headers['Content-Length'] = strlen($data);
        }
        return $this->sendRequest($url, 'post', $headers, $data);
    }

    public function put($url, $headers, $data) {
        return $this->sendRequest($url, 'put', $headers, $data);
    }

    public function delete($url, $headers = null) {
        return $this->sendRequest($url, 'delete', $headers);
    }

    public function download($url, $headers, $dest) {

    }

    public function upload($url, $headers, $file) {

    }

    public function setConfig($config) {
        $this->options = array_merge($this->options, (array) $config);
    }

    /**
     * @return string
     */
    public function getAcceptHeader() {
        return $this->acceptHeader;
    }

    /**
     * @param string $acceptHeader
     */
    public function setAcceptHeader($acceptHeader) {
        $this->acceptHeader = $acceptHeader;
    }

    /**
     * @return string|null
     */
    public function getApiVersion() {
        return $this->apiVersion;
    }

}