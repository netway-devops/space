<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');
use GuzzleHttp\Client;

class internalcontrolhandle_library {

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
    
    public function createTicket ($request)
    {
        $aParam     = array(
            'method'    => 'post',
            'url'       => 'tickets.json',
            'data'      => array(
                'ticket'    => $request
            ),
        );
        $result     = $this->_sendZendesk($aParam);
        $result     = isset($result['ticket']) ? $result['ticket'] : array();
        
        return $result;
    }
    
    public function getViewCountById ($id)
    {
        $aParam     = array(
            'method'    => 'get',
            'url'       => 'views/'. $id .'/count.json',
            'data'      => array(),
        );
        $result     = $this->_sendZendesk($aParam);
        $result     = isset($result['view_count']) ? $result['view_count'] : array();
        
        return $result;
    }
    
    private function _sendZendesk ($request) 
    {
        $client = new Client(array(
            'base_uri'  => $this->aConfig['ZENDESK_API_URL']['value'],
            'auth'      => array(
                $this->aConfig['ZENDESK_API_USER']['value'],
                $this->aConfig['ZENDESK_API_TOKEN']['value'],
            ),
            'headers'   => array(
                'Accept'    => 'application/json',
            ),
        ));
        
        if ($request['method'] == 'post') {
            $response   = $client->request('POST', $request['url'], array('json' => $request['data']) );
        } else {
            $response   = $client->request('GET', $request['url']);
        }
        
        $result     = json_decode($response->getBody()->getContents(), true);
        
        // echo '<pre>'. print_r($result, true) .'</pre>';
        
        return $result;
    }
    
    
    
}
