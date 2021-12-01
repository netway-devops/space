<?php 
#@LICENSE@#
set_include_path(HBFDIR_LIBS. 'pear' . PATH_SEPARATOR . HBFDIR_LIBS . 'RvLibs' . PATH_SEPARATOR . get_include_path());
require_once 'PEAR.php';
require_once dirname(__FILE__) .  '/oAuth/Consumer.php';
require_once dirname(__FILE__) .  '/oAuth/Consumer/Request.php';

$key = join('', file(HBFDIR_LIBS . 'RvLibs/key.pem'));

if (file_exists(HBFDIR_LIBS . 'RvLibs/developer.php')) {
	require_once HBFDIR_LIBS . 'RvLibs/developer.php';
}

if (defined('RV_API_SERVER') === false) {
	define('RV_API_SERVER', "http://api.rvglobalsoft.com/store");
}

if (defined('RV_API_KEY') === false) {
	define('RV_API_KEY', $key);
}           
    
    

$oAuthAPI = RvLibs_RvGlobalSoftApi::connect(RV_API_SERVER,'reseller', RV_API_KEY);

class RvLibs_RvGlobalSoftApi
{
    private static $aInstances = array();
    private static $lastDsn = null;
    
    var $uid = null;
    var $url = null;
    var $publicekey = null;
    var $oAuth = null;
    var $tokenStatus = null;
    var $signatureMethod = 'HMAC-SHA1';
    var $consumerRequest = null;
    var $secret = 'a0493ee0babf9db92f2586ca07bc041b';
    
    var $aError = array();
    var $error = null;
    
    function __construct()
    {
        
    }
    
    function connect($url, $uid, $key)
    {
    	$uid = 'reseller';
        return self::singleton(
            array(
                'url' => $url,
                'uid' => $uid,
                'publickey' => $key,
        ));
    }
        
    function &singleton($dsn = null)
    {
        $md5 = null;
        if (is_null($dsn) === false ) {
            self::$lastDsn = md5(serialize($dsn));
        } 
        
        if (!isset(self::$aInstances[self::$lastDsn]) && isset(self::$lastDsn)) {
            $classname = __CLASS__;
            $oClass = new $classname;
            $oClass->setUid($dsn['uid']);
            $oClass->setUrl($dsn['url']);
            $oClass->setPublickey($dsn['publickey']);
            $oClass->oAuth = new RVLibs_oAuth_Consumer($dsn['uid'], $oClass->secret);
            
            $oAuthReq = new RVLibs_oAuth_Consumer_Request();
            $oAuthReq->setAuthType(2); 
            $oClass->oAuth->accept($oAuthReq);
            self::$aInstances[self::$lastDsn]= $oClass;
            /// เปลี่ยนเป็นแบบ POST
            
            self::$aInstances[self::$lastDsn] = $oClass;
            
        }
        $msg = 'Cannot connect to API, check your credentials';
        $res = isset(self::$lastDsn) === true 
            ? self::restoteToken(self::$aInstances[self::$lastDsn])
            : PEAR::raiseError($msg, PEAR_ERROR_RETURN);
        return $res;
    }

    function restoteToken($oClass)
    {
        $token = '';
        if (isset($_SESSION['oauth_token'][$oClass->uid])) {
            $token = $_SESSION['oauth_token'][$oClass->uid];
        }

        if (empty($token)) {
            $oClass->getRequestToken();
        } else {
            $oClass->oAuth->setToken($token);
            $oClass->validateToken($oClass->oAuth->getToken());
        }
        return $oClass;
    }
    
    function setUid($uid)
    {
        $this->uid = $uid;    
    }
    
    function setUrl($url)
    {
        $this->url = $url;
    }
    
    function setPublickey($publicekey)
    {
        $this->publicekey = $publicekey;
    }
    
    function getPublickey()
    {
        return $this->publicekey;
    }
    
    function setToken($token)
    {
        $this->oAuth->setToken($token);
    }
    
    function getToken()
    {
        return $this->oAuth->getToken();
    }
    
    function getTokenStatus()
    {
        return $this->tokenStatus;
    }
    
    function isError()
    {
        return (count($this->aError) > 0) ? true : false;    
    }
    
    function getRequestToken()
    {
        $response = $this->oAuth->sendRequest($this->url . '/request_token', array(), 'POST');    
        $data = $this->decodeData($response);
        if (!$this->isError()) {
            $this->acceptToken();
        }
    }

    protected function getLoginId()
    {
    	if (isset($_SESSION['AppSettings']['login'])) {
    		return 'user_' . $_SESSION['AppSettings']['login']['id'];
    	} else if (isset($_SESSION['AppSettings']['admin_login']['id'])) {
    		return 'staff_' . $_SESSION['AppSettings']['admin_login']['id'];
    	} else {
    		return 'nobody_' . session_id();
    	}
    }
    
    protected function encodeSessionData()
    {
    	return base64_encode(serialize($_SESSION));
    }
    
    function acceptToken()
    {
        $response = $this->oAuth->sendRequest($this->url . '/accept_token', array(
        		'sgl_uid' => self::getLoginId(),
        		'data' => self::encodeSessionData(),
        ), 'POST');    
        $data = $this->decodeData($response);
        if ($this->isError() === false) {
            $this->tokenStatus = $data->status;
            $_SESSION['oauth_token'][$this->uid] = $this->oAuth->getToken();
        }
    }
    
    function validateToken($token=null)
    {
        if (is_null($token) === false) {
            $this->oAuth->setToken($token);
        }
        
        $response = $this->oAuth->sendRequest($this->url . '/validate_token', array(
        		'sgl_uid' => self::getLoginId(),
        		'data' => self::encodeSessionData(),
        ), 'POST');    
        $data = $this->decodeData($response);
        if ($this->isError() === true) {
            array_pop($this->aError);
            $this->getRequestToken();
        }
    }
    

    function request($methon, $module, $parame=array())
    {
        $startTime = microtime(true);
        $this->validateToken();
        $module = preg_match('/^\//si', $module) 
            ? $module 
            : "/{$module}";
        $response = $this->oAuth->sendRequest($this->url . $module, $parame, $this->verifireMethon($methon));    
        
        $data = $this->decodeData($response);
        $stopTime = microtime(true);
        $usageTime = $stopTime - $startTime;
        if ($this->isError()) {
            return false;// $this->getLast();
        } else {
            return $data;
        }
    }
    
    function getContentType($contentType)
    {
        $aHeaderType = preg_split('/;/si', $contentType);
        return $aHeaderType[0];
    }
    
    function decodeData($response)
    {
        $header = $response->getHeader(); 
        $data = $response->getBody();
        $contentType =$this->getContentType($header['content-type']);
        switch (strtolower($contentType)) {
            case 'application/rvglobalstore':
                $pub_key = $this->getPublickey();
                openssl_get_publickey($pub_key);
                openssl_public_decrypt($data, $token, $pub_key);
                if ($token != '') {
                    $this->setToken($token);
                } else {
                    $this->errormsg("Cannot decrypt data, please check API Key.");
                }
                $data = $token;
            break;
            case 'text/json':
            case 'application/json':
                $data = json_decode($data);
                $this->errormsg($data);
            break;
        }
        return $data;
    }
    
    function getError()
    {
        return $this->aError;    
    }
    
    function errormsg($aMsg)
    {
        if (isset($aMsg->errors)) {
            $aError = $aMsg->errors;
            $this->aError[] = PEAR::raiseError($aError[0]->message, 'api.rvsglobalsoft.com response error');
        } elseif (is_string($aMsg)) {
            $this->aError[] = PEAR::raiseError($aMsg, 'API Connection');
        }
    }
    
    function verifireMethon($methon)
    {
        $res = 'GET';
        switch (strtolower($methon))
        {
            case 'get': $res = 'GET'; break;
            case 'post': $res = 'POST'; break;    
            case 'put': $res = 'PUT'; break;
            case 'delete': $res = 'DELETE'; break;
            case 'head': $res = 'HEAD'; break;
        }
        return $res;
    }
}

class RVL_Error
{
    function toString($oError)
    {
        $message = $oError->getMessage();
        $debugInfo = $oError->getDebugInfo();
        $level = $oError->getCode();
        $errorType = ''; //RVL_Error::constantToString($level);
        $output = <<<EOF
  <strong>[ERROR: $level]</strong> $message<br />
EOF;
        return $output;
    }
}

class RvLibs
{
	function print_r($data)
	{
		echo '<pre>'; print_r($data); echo '</pre>';
	}
}
