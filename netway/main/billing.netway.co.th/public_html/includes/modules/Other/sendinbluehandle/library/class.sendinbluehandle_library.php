<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_LIBS . 'guzzle6/vendor/autoload.php');
use GuzzleHttp\Client;
use GuzzleHttp\Psr7;
use GuzzleHttp\Exception\RequestException;

class sendinbluehandle_library {

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
    
    public function getAllTransactionByMessageId ($messageId)
    {
        $aParam     = array(
            'method'    => 'get',
            'url'       => 'smtp/statistics/events?limit=50&offset=0&messageId='. rawurlencode($messageId),
        );
        $result     = $this->_requestSendinblue($aParam);
        $result     = isset($result['events']) ? $result['events'] : array();
        
        return $result;
    }
    
    public function getUserByEmail ($request)
    {
        $aParam     = array(
            'from'      => $request['from'],
            'method'    => 'get',
            'url'       => 'users/search.json?query=email:'. $request['email'],
        );
        $result     = $this->_requestZendesk($aParam);
        $result     = isset($result['users'][0]) ? $result['users'][0] : array();
        $result     = (isset($result['email']) && $result['email'] == $request['email']) ? $result : array();
        
        return $result;
    }
    
    public function addUser ($request)
    {
        $aParams    = array(
            'from'      => $request['from'],
            'method'    => 'post',
            'url'       => 'users.json',
            'data'      => $request['data']
        );
        $result     = $this->_requestZendesk($aParams);
        $result     = isset($result['user']) ? $result['user'] : array();
        
        return $result;
    }
    
    
    public function importTicket ($request)
    {
        $aParams    = array(
            'from'      => $request['from'],
            'method'    => 'post',
            'url'       => 'imports/tickets.json',
            'data'      => $request['data']
        );
        $result     = $this->_requestZendesk($aParams);
        $result     = isset($result['ticket']) ? $result['ticket'] : array();
        
        return $result;
    }
    private function _requestSendinblue ($request) 
    {
        $client = new Client(array(
            'base_uri'  => $this->aConfig['SIB_API_URL']['value'],
            'headers'   => array(
                'accept'    => 'application/json',
                'api-key'   => $this->aConfig['SIB_API_KEY']['value'],
            ),
        ));
        
        $result     = array();
        
        try {
            $response   = $client->request('GET', $request['url']);
            $code       = $response->getStatusCode();
            
            if ($code == 200) {
                $result     = json_decode($response->getBody(), true);
            }

        } catch (RequestException $e) {
            
        }
        
        return $result;
    }
    
    private function _requestZendesk ($request) 
    {
        $apiUrl     = '';
        $authUser   = '';
        $authPassword   = '';
        if (isset($request['from']) && $request['from'] == $this->aConfig['NETWAY_SENDER_EMAIL']['value']) {
            $apiUrl = $this->aConfig['NETWAY_ZENDESK_API_URL']['value'];
            $arr    = explode(':', $this->aConfig['NETWAY_ZENDESK_API_AUTH']['value']);
            $authUser       = isset($arr[0]) ? $arr[0] : '';
            $authPassword   = isset($arr[1]) ? $arr[1] : '';
        }
        if (isset($request['from']) && $request['from'] == $this->aConfig['RV_SENDER_EMAIL']['value']) {
            $apiUrl = $this->aConfig['RV_ZENDESK_API_URL']['value'];
            $arr    = explode(':', $this->aConfig['RV_ZENDESK_API_AUTH']['value']);
            $authUser       = isset($arr[0]) ? $arr[0] : '';
            $authPassword   = isset($arr[1]) ? $arr[1] : '';
        }

        $client = new Client(array(
            'base_uri'  => $apiUrl,
            'auth'      => array(
                $authUser,
                $authPassword
            ),
            'headers'   => array(
                'accept'    => 'application/json',
            ),
        ));

        $result     = array();
        try {
        
            if ($request['method'] == 'post') {
                $response   = $client->request('POST', $request['url'], array('json' => $request['data']));
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
        
        return $result;
    }
    
    
    
}
