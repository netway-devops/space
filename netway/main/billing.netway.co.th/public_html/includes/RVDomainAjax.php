<?php

/**
 * 
 * RVDomainAjax
 * 
 */


$obj = new RVDomainAjax();
$obj->validate();

class RVDomainAjax {
    
    protected $request;

    protected $params;
    
    protected $query;

    public function __construct() {
        
        try {
            
            if (isset($_REQUEST)) {
                $this->setRequest($_REQUEST);
                $this->setParams($_REQUEST);
                $this->setQuery();
            }
            
        } catch (Exception $e) {
            
        }
        
        //print_r($this->getParams());
        //print_r($this->query);
        
    }
    
    /**
     * Returns a singleton RVDomainAjax instance.
     *
     * @param bool $autoload
     * @return obj
     */
    public function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
    
    /**
     * 
     * Enter description here ...
     */
    public function validate() {
        
        $action = $this->getParam('action');
        
        if (isset($action)) {
            
            if ($action == 'tld') {
                // extension
                $this->_ajax_tld();
            }
            else if($action == 'dname') {
                $this->_ajax_domainname();
            }
            else {
                // orders, whois, suggestion
                $this->_ajax_post();    
            }
        }
        
    }
    
    public function _ajax_tld() {
        
        // create a new cURL resource
        $ch = curl_init();
        
        // set URL and other appropriate options
        $url = 'https://'. $_SERVER['HTTP_HOST'] .'/index.php?/checkdomain/domain-registrations/';
        
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)");
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Charset: UTF-8,*;q=0.5',
            'Accept-Encoding: gzip,deflate,sdch',
            'Accept-Language:en-US,en;q=0.8',
            'Cache-Control: max-age=0',
            'Connection: keep-alive',
            'Host: billing.netway.co.th'
        ));
                
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 20);
        
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
        
        $res = curl_exec($ch);
        
        if ($res === false) {
            // TODO send mail
            echo 'Curl error curl_post: ' . curl_error($ch);
        } else {
            echo $res;
        }
        
        // Close handle
        curl_close($ch);
        exit;
    }



    public function _ajax_domainname() {
      
        // create a new cURL resource
        $ch = curl_init();
        
        // set URL and other appropriate options
        $url = 'https://'. $_SERVER['HTTP_HOST'] .'/listdomain.json';
        
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)");
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Charset: UTF-8,*;q=0.5',
            'Accept-Encoding: gzip,deflate,sdch',
            'Accept-Language:en-US,en;q=0.8',
            'Cache-Control: max-age=0',
            'Connection: keep-alive',
            'Host: billing.netway.co.th'
        ));
                
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 20);
        
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
        
        $this->listTld = curl_exec($ch);
        
        if ($res === false) {
            // TODO send mail
            echo 'Curl error curl_post: ' . curl_error($ch);
        } else {
            echo $this->listTld ;
        }
        
        // Close handle
        curl_close($ch);
        exit;
    }
    
    
    /**
     * 
     * Enter description here ...
     */
    public function _ajax_post() {
        
         // create a new cURL resource
        $ch = curl_init();
        
        // set URL and other appropriate options
        $url = ($this->getParam('action') == 'whois') ? 'https://'. $_SERVER['HTTP_HOST'] .'/checkdomain&' : 'https://'. $_SERVER['HTTP_HOST'] .'/index.php?';
        
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)");
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            'Origin: https://billing.netway.co.th',
            'Accept-Encoding: gzip,deflate,sdch',
            'Host: billing.netway.co.th',
            'Accept-Language: en-US,en;q=0.8',
            'Content-Type: application/x-www-form-urlencoded; charset=UTF-8',
            'Accept: */*',
            'Referer: https://billing.netway.co.th/index.php?/checkdomain/domain-registrations/',
            'X-Requested-With: XMLHttpRequest',
            'Connection: keep-alive'
        ));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $this->getQuery());
        curl_setopt($ch, CURLOPT_TIMEOUT, 20);
        
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_ENCODING, 'gzip');
        
        $res = curl_exec($ch);
        
        if ($res === false) {
            // TODO send mail
            echo 'Curl error curl_post: ' . curl_error($ch);
        } else {
            echo $res;
        }
        
        // Close handle
        curl_close($ch);
        exit;
    }
            
    /**
     * Get a param
     *
     * This method will get a single param
     * out of the request variable.
     *
     * @param  string $key  The key to extract
     * @return Mixed Either value of the array key or false
     */
    public function getParam($key)
    {
        if (isset($this->params[$key])) {
            return $this->params[$key];
        }

        return null;
    }
    
    
    /**
     * Set Query
     *
     * This method returns the request
     *
     */
    public function setQuery() 
    {
        
        $this->query = '';
        
        if (is_array($this->params) === true) {
            foreach($this->params as $keys => $values) {
                $this->query .= $keys . '=' . $values . '&';
            }
        }
        
        $this->query = preg_replace('/\&$/', '', $this->query);
        
        return $this->query;
    }
    
    
    /**
     * 
     * Get query
     *
     */
    public function getQuery() 
    {
        return $this->query;
    }
    
    
    /**
     * Get parameters
     *
     * This method returns an array of the parameters
     * passed.
     *
     * @return Mixed An array or a string of parameters
     */
    public function getParams()
    {
        return $this->params;
    }
    
    /**
     * parses the request and sets request parameters for later use
     *
     * @param array $params request params collected so far
     */
    public function setParams(array $aParams)
    {
        $params = array();
        
        if (isset($aParams['param'])) {
            foreach($aParams['param'] as $keys => $values) {
                list($key, $value) = explode('=', $values, 2);
                $params[$key] = $value;
            }
            unset($aParams['param']);
        }
        
        foreach($aParams as $keys => $values) {
            $params[$keys] = $values;
        }
    
        $this->params = $params;
    }
    
    /**
     * Set Request
     *
     * This method returns the request
     * ($_REQUEST) mostly.
     *
     *
     */
    public function setRequest($request)
    {
        $this->request = $request;
    }
    
    
}