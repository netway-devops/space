<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');
use GuzzleHttp\Client;

class dbcproducthandle_library {

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
    
    public function getAllItem () 
    {
        $aParam     = array(
            'method'    => 'get',
            'url'       => 'companies('. $this->aConfig['DBC_COMPANY_ID']['value'] .')/items',
        );
        $result     = $this->_send($aParam);
        $result     = isset($result['value']) ? $result['value'] : array();
        
        return $result;
    }
    
    public function getCurrency () 
    {
        $aParam     = array(
            'method'    => 'get',
            'url'       => 'companies('. $this->aConfig['DBC_COMPANY_ID']['value'] .')/currencies',
        );
        $result     = $this->_send($aParam);
        $result     = isset($result['value']) ? $result['value'] : array();
        
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
    
    
    
}
