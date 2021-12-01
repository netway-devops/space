<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');
use GuzzleHttp\Client;
use GuzzleHttp\Psr7;
use GuzzleHttp\Exception\RequestException;

class dbccustomerhandle_library {

    private static  $instance;
    private $aConfig;
     
    public static function singleton ($aConfig)
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c($aConfig);
        }

        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    private function __construct ($aConfig) 
    {
        $this->aConfig      = $aConfig;
    }
    
    public function getCompany () 
    {
        $aParam     = array(
            'method'    => 'get',
            'url'       => 'companies',
        );
        $result     = $this->_send($aParam);
        $result     = isset($result['value']) ? $result['value'] : array();
        
        return $result;
    }
    
    public function getCustomerByNo ($customerNo) 
    {
        $aParam     = array(
            'method'    => 'get',
            'url'       => 'Company(\''. $this->aConfig['DBC_COMPANY_NAME']['value'] .'\')/viewCustomer(\''. $customerNo .'\')',
        );
        $result     = $this->_sendWebService($aParam);
        $result     = isset($result['No']) ? $result : array();
        
        return $result;
    }
    
    public function syncCustomer ($customerNo, $data) 
    {
        $aHeader        = $data['aHeader'];
        $aBody          = $data['aBody'];
        
        $aParam     = array(
            'method'    => 'put',
            'header'    => $aHeader,
            'body'      => $aBody,
            'url'       => 'Company(\''. $this->aConfig['DBC_COMPANY_NAME']['value'] .'\')/viewCustomer(\''. $customerNo .'\')',
        );
        $result     = $this->_sendWebService($aParam);
        $result     = isset($result['No']) ? $result : array();
        
        return $result;
    }
    
    private function _send ($request) 
    {
        $client = new Client(array(
            'base_uri'  => $this->aConfig['DBC_API_URL']['value'],
            'auth'      => array(
                $this->aConfig['DBC_API_USER']['value'],
                $this->aConfig['DBC_API_PASSWORD']['value'],
                'ntlm'
            ),
            'headers'   => array(
                'Accept'    => 'application/json',
            ),
        ));
        
        $response   = $client->request('GET', $request['url']);
        $code       = $response->getStatusCode();
        
        $result     = array();
        if ($code == 200) {
            $result     = json_decode($response->getBody(), true);
        }
        
        return $result;
    }
    
    private function _sendWebService ($request) 
    {
        $aHeader    = array(
            'Accept'    => 'application/json',
        );
        if (isset($request['header'])) {
            foreach ($request['header'] as $k => $v) {
                $aHeader[$k]    = $v;
            }
        }
        
        $client = new Client(array(
            'base_uri'  => $this->aConfig['DBC_WEB_SERVICE_URL']['value'],
            'auth'      => array(
                $this->aConfig['DBC_API_USER']['value'],
                $this->aConfig['DBC_API_PASSWORD']['value'],
                'ntlm'
            ),
            'headers'   => $aHeader,
        ));
        
        $result     = array();
        try {
        
            if ($request['method'] == 'put') {
                $response   = $client->request('PUT', $request['url'], array('json' => $request['body']));
            } else {
                $response   = $client->request('GET', $request['url']);
            }
            
            $code       = $response->getStatusCode();
            if ($code == 200) {
                $result     = json_decode($response->getBody(), true);
            }
            
        } catch (RequestException $e) {
            $e->getRequest();
            if ($e->hasResponse()) {
                $response   = $e->getResponse();
                $result     = json_decode($response->getBody(), true);
            }
        }
        
        /*
        if ($request['method'] == 'put') {
            echo '<pre>'. print_r($result, true)  .'</pre>';
            exit;
        }
        */
        
        return $result;
    }
    
    
    
}
