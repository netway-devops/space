<?php

/**
 * VMware vCloud SDK for PHP
 *
 * PHP version 5
 * *******************************************************
 * Copyright VMware, Inc. 2010-2013. All Rights Reserved.
 * *******************************************************
 *
 * @category    VMware
 * @package     VMware_VCloud_SDK
 * @subpackage  Samples
 * @author      Ecosystem Engineering
 * @disclaimer  this program is provided to you "as is" without
 *              warranties or conditions # of any kind, whether oral or written,
 *              express or implied. the author specifically # disclaims any implied
 *              warranties or conditions of merchantability, satisfactory # quality,
 *              non-infringement and fitness for a particular purpose.
 * @SDK version 5.5.0
 */
/**
 * Contains VMware vCloud SDK for PHP global utility functions
 */
require_once __DIR__ . '/Helper.php';
require_once __DIR__ . '/ServiceTrait.php';

/**
 * An abstract base class for VMware vCloud SDK service object, providing
 * HTTP methods to the vCloud SDK service object.
 *
 * @package VMware_VCloud_SDK
 */
abstract class VMware_VCloud_SDK_Service_Abstract {
    use VMware_VCloud_SDK_Service_Trait;

    /**
     * Sets HTTP configuration
     *
     * @param string $url URL to send an HTTP request
     * @param string $type The HTTP request Content-type
     * @param boolean $reObj Indicates whether return a vCloud data object
     *                         (true) or response body (false)
     * @param string $return Expected response data type name
     * @return mixed           VMware vCloud data object or response body
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function get($url, $type = '', $reObj = true, $return = null) {
        $headers = array('Content-Type' => $type);
        $response = $this->httpClient->get($url, $headers);
        $code = $response->getStatus();
        $body = $response->getBody();
        if (200 != $code) {
            $this->_error($body);
            throw new VMware_VCloud_SDK_Exception(
                "$body");
        }
        return (true === $reObj) ?
            VMware_VCloud_SDK_Helper::getObjByXml($body, $return) : $body;
    }

    /**
     * Send an HTTP POST request.
     *
     * @param string $url URL to send an HTTP request
     * @param int $expect Expected HTTP status code on a successful request
     * @param string $type HTTP request Content-Type
     * @param mixed $data A vCloud data object which has export() method
     *                         defined, or an XML data which will be used as an
     *                         HTTP request body
     * @param string $return Expected response data type name
     * @param string $auth Authorization token
     * @return mixed           A VMware vCloud data object
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function post($url, $expect = null, $type = null, $data = null, $return = null, $auth = null) {
        $len = 0;
        if (!is_null($data)) {
            if (method_exists($data, 'export')) {
                $data = $data->export();
            }
            $len = strlen($data);
        }
        $headers = array('Content-Type' => $type,
            'Content-Length' => $len);
        if (!is_null($auth)) {
            $headers = array(
                'Authorization' => $auth);
        }

        $response = $this->httpClient->post($url, $headers, $data);
        $code = $response->getStatus();
        $body = $response->getBody();
        if (isset($expect) && $expect != $code) {
            $this->_error($body);
            throw new VMware_VCloud_SDK_Exception("POST $url failed, return " .
                                                  "code: $code, error: $body, request data:\n$data\n");
        }
        return VMware_VCloud_SDK_Helper::getObjByXml($body, $return);
    }

    /**
     * Send an HTTP PUT request.
     *
     * @param string $url URL to send an HTTP request
     * @param int $expect Expected HTTP status code on a successful request
     * @param string $type HTTP request Content-Type
     * @param mixed $data A VMware vCloud data object, which has export()
     *                      method defined, or an XML data which will be used
     *                      as HTTP request body
     * @return mixed        A VMware vCloud data object
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function put($url, $expect = null, $type = null, $data = null) {
        $len = 0;
        if (!is_null($data)) {
            if (method_exists($data, 'export')) {
                $data = $data->export();
            }
            $len = strlen($data);
        }
        $headers = array('Content-Type' => $type,
            'Content-Length' => $len);
        $response = $this->httpClient->put($url, $headers, $data);
        $code = $response->getStatus();
        $body = $response->getBody();
        if (isset($expect) && $expect != $code) {
            $this->_error($body);
            throw new VMware_VCloud_SDK_Exception("PUT $url failed, error " .
                                                  "code: $code, error: $body, request data:\n$data\n");
        }
        return VMware_VCloud_SDK_Helper::getObjByXml($body);
    }

    /**
     * Send an HTTP DELETE request.
     *
     * @param string $url URL to send an HTTP request
     * @param int[] $expect Expected HTTP status code on a successful request
     * @return VMware_VCloud_API_TaskType|null
     * @throws VMware_VCloud_SDK_ApiException
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function delete($url, $expect = []) {
        $response = $this->httpClient->delete($url);
        $code = (int) $response->getStatus();
        $body = $response->getBody();

        $expect = (array) $expect;

        if (!empty($expect) && !in_array($code, $expect, true)) {
            $this->_error($body);
            throw new VMware_VCloud_SDK_Exception("DELETE $url failed, " .
                                                  "error code: $code, error: $body\n");
        }
        return VMware_VCloud_SDK_Helper::getObjByXML($body);
    }

    /**
     * Refetch the given VMware vCloud data object from vCloud.
     *
     * @param mixed $obj A VMware vCloud data object to be refeched.
     *                     The data object should have an href attribute.
     * @return mixed       A VMware vCloud data object
     * @since Version 1.0.0
     */
    public function refetch($obj) {
        $class = get_class($obj);
        if (0 == preg_match('/VMware_VCloud_API_/', $class)
            || !method_exists($obj, 'get_href')) {
            throw new VMware_VCloud_SDK_Exception("The given object is " .
                                                  "in class $class type, cannot invoke refetch() function.\n");
        }
        return $this->get($obj->get_href(), '', true, get_class($obj));
    }

    /**
     * Download a file and dump to specified location.
     *
     * @param string $url Source of the file
     * @param string $dest Destination of the file to write to
     * @param string $type HTTP request Content-Type
     * @return null
     * @since Version 1.0.0
     */
    public function download($url, $dest, $type = 'application/octet-stream') {
        $headers = array('Content-Type' => $type);
        $this->httpClient->download($url, $headers, $dest);
    }

    /**
     * Upload a file.
     *
     * @param string $url Target to upload the file
     * @param string $file Full path of a file to be uploaded
     * @param string $type HTTP request Content-Type
     * @return null
     * @throws VMware_VCloud_SDK_Exception
     * @since Version 1.0.0
     */
    public function upload($url, $file, $type = 'application/octet-stream') {
        $headers = array('Content-Type' => $type);
        $this->httpClient->upload($url, $headers, $file);
    }

    protected function _error($body) {
        try {
            $response = VMware_VCloud_SDK_Helper::getObjByXml($body);
        } catch (Exception $ex) {
            //
        }

        /* @var $response  VMware_VCloud_API_ErrorType */
        if ($response instanceof VMware_VCloud_API_ErrorType) {
            $errorCode = $response->get_minorErrorCode() ?: $response->get_vendorSpecificErrorCode() ?: $response->get_majorErrorCode();
            $errorMessage = $response->get_message() ?: $response->get_stackTrace();
            throw new VMware_VCloud_SDK_ApiException("$errorCode: $errorMessage", $response->get_minorErrorCode(), $response->get_majorErrorCode());
        }
    }

}
