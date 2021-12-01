<?php
/**
 * An abstract base class for VMware vCloud SDK service object, providing
 * HTTP methods to the vCloud SDK service object.
 *
 * @package VMware_VCloud_SDK
 */
trait VMware_VCloud_SDK_Service_Trait {

    /**
     * reprents a HTTP client object
     */
    protected $httpClient = null;

    /**
     * Set the HTTP client object to use for retrieving the feeds.  If null,
     * use the default client, the VMware_VCloud_SDK_Http_Client object.
     *
     * @param VMware_VCloud_SDK_Http_Client $httpClient
     * @return null
     * @since Version 1.0.0 
     */
    final public function setHttpClient($httpClient) {
        $this->httpClient = $httpClient;
    }

    /**
     * Gets the HTTP client object.
     *
     * @return VMware_VCloud_SDK_Http_Client
     * @since Version 1.0.0
     */
    final public function getHttpClient() {
        if (!$this->httpClient) {
            $this->httpClient = new VMware_VCloud_SDK_Http_Client();
        }
        return $this->httpClient;
    }

    /**
     * Sets authentication parameters.
     *
     * @param array  $auth   In array('username'=><username>,
     *                                'password'=><password>) format
     */
    protected function setAuth($auth) {
        $this->httpClient->setAuth($auth);
    }

    /**
     * Sets HTTP configuration parameters.
     *
     * @param array  $config  An HTTP configuration array
     */
    protected function setConfig($config) {
        $this->httpClient->setConfig($config);
    }

    /**
     * Sets the API Version.
     *
     * @return VMware_VCloud_SDK_Http_Client
     * @since SDK Version 5.1.1
     */
    protected function setAPIVersion($apiVersion) {
        $this->httpClient->setAPIVersion($apiVersion);
    }

    /**
     * Gets the vcloud token
     *
     * @return String
     * @since API 5.1.0
     * @since SDK 5.1.0
     */
    final public function getToken() {
        return $this->httpClient->getVcloudToken();
    }

    /**
     * Sets the vcloud token
     *
     * @param string $vcloudToken
     * @since API 5.1.0
     * @since SDK 5.1.0
     */
    final public function setToken($vcloudToken) {
        $this->httpClient->setVcloudToken($vcloudToken);
    }

}