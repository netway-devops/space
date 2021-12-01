<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_MODULES . 'Other/paypalhandle/libs/guzzle6/vendor/autoload.php');
use GuzzleHttp\Client;

class paypalhandle_library {

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
    
    public function getAccesstoken ($clientId, $clientSecret) 
    {
        $uri        = $this->aConfig['PAYPAL_API_URL']['value'] .'v1/oauth2/token';
        $client     = new Client();
        $response   = $client->request('POST', $uri, array(
            'headers'   => array(
                'Accept'            => 'application/json',
                'Accept-Language'   => 'en_US',
                'Content-Type'      => 'application/x-www-form-urlencoded',
            ),
            'body'      => 'grant_type=client_credentials',
            'auth'      => array(
                $clientId,
                $clientSecret,
                'basic'
            ),
        ));
        
        $result         = json_decode($response->getBody()->getContents(), true);
        $accessToken    = isset($result['access_token']) ? $result['access_token'] : '';
        
        return $accessToken;
    }
    
    public function getLatestTransaction ($aAccount, $request)
    {
        $pastTime   = isset($request['pastTime']) ? $request['pastTime'] : '-1 day';
        
        $startDate  = date('Y-m-d', strtotime($pastTime)) .'T'. date('H:i', strtotime($pastTime)) .':00-0000';
        $endDate    = strtotime('+30 day', strtotime($startDate));
        $endDate    = ($endDate < time()) ? $endDate : time();
        $endDate    = date('Y-m-d', $endDate) .'T'. date('H:i', $endDate) .':00-0000';
        
        $aParam     = array(
            'method'    => 'get',
            'url'       => 'v1/reporting/transactions?fields=all&start_date='. $startDate .'&end_date='. $endDate,
            'data'      => array(),
        );
        $result     = $this->_send($aAccount, $aParam);
        
        // echo '<pre>'. print_r($result, true) .'</pre>';

        $result     = isset($result['transaction_details']) ? $result['transaction_details'] : array();
        
        return $result;
    }
    
    private function _send ($aAccount, $request) 
    {
        $accessToken    = $this->getAccesstoken($aAccount['clientId'], $aAccount['clientSecret']);
        $client     = new Client(array(
            'base_uri'  => $this->aConfig['PAYPAL_API_URL']['value'],
            'headers'   => array(
                'Authorization' => 'Bearer '. $accessToken,   
                'Accept'        => 'application/json',
            ),
        ));
        
        $result     = array();

        try {

            if ($request['method'] == 'post') {
                $response   = $client->request('POST', $request['url'], array('json' => $request['data']) );
            } else {
                $response   = $client->request('GET', $request['url']);
            }
            
            $result     = json_decode($response->getBody()->getContents(), true);
        
        }
        catch (GuzzleHttp\Exception\ClientException $e) {
            $response = $e->getResponse();
            $responseBodyAsString = $response->getBody()->getContents();
        }
        
        # echo '<pre>'. print_r($result, true) .'</pre>';
        
        return $result;
    }
    
    
    
    
}
