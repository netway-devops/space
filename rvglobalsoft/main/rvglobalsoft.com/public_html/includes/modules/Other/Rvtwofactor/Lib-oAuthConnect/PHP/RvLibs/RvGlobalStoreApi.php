<?php 
# WebSite:  https://rvglobalsoft.com/rv2factor
# Unauthorized copying is strictly forbidden and may result in severe legal action.
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
#
# =====YOU MUST KEEP THIS COPYRIGHTS NOTICE INTACT AND CAN NOT BE REMOVE =======
# Copyright (c) 2013 RV Global Soft Co.,Ltd. All rights reserved.
# This Agreement is a legal contract, which specifies the terms of the license
# and warranty limitation between you and RV Global Soft Co.,Ltd. and RV2Factor for Apps Product for RV Global Soft.
# You should carefully read the following terms and conditions before
# installing or using this software.  Unless you have a different license
# agreement obtained from RV Global Soft Co.,Ltd., installation or use of this software
# indicates your acceptance of the license and warranty limitation terms
# contained in this Agreement. If you do not agree to the terms of this
# Agreement, promptly delete and destroy all copies of the Software.
#
# =====  Grant of License =======
# The Software may only be installed and used on a single host machine.
#
# =====  Disclaimer of Warranty =======
# THIS SOFTWARE AND ACCOMPANYING DOCUMENTATION ARE PROVIDED "AS IS" AND
# WITHOUT WARRANTIES AS TO PERFORMANCE OF MERCHANTABILITY OR ANY OTHER
# WARRANTIES WHETHER EXPRESSED OR IMPLIED.   BECAUSE OF THE VARIOUS HARDWARE
# AND SOFTWARE ENVIRONMENTS INTO WHICH RV SITE BUILDER MAY BE USED, NO WARRANTY OF
# FITNESS FOR A PARTICULAR PURPOSE IS OFFERED.  THE USER MUST ASSUME THE
# ENTIRE RISK OF USING THIS PROGRAM.  ANY LIABILITY OF RV GLOBAL SOFT CO.,LTD. WILL BE
# LIMITED EXCLUSIVELY TO PRODUCT REPLACEMENT OR REFUND OF PURCHASE PRICE.
# IN NO CASE SHALL RV GLOBAL SOFT CO.,LTD. BE LIABLE FOR ANY INCIDENTAL, SPECIAL OR
# CONSEQUENTIAL DAMAGES OR LOSS, INCLUDING, WITHOUT LIMITATION, LOST PROFITS
# OR THE INABILITY TO USE EQUIPMENT OR ACCESS DATA, WHETHER SUCH DAMAGES ARE
# BASED UPON A BREACH OF EXPRESS OR IMPLIED WARRANTIES, BREACH OF CONTRACT,
# NEGLIGENCE, STRICT TORT, OR ANY OTHER LEGAL THEORY. THIS IS TRUE EVEN IF
# RV GLOBAL SOFT CO.,LTD. IS ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. IN NO CASE WILL
# RV GLOBAL SOFT CO.,LTD.'S LIABILITY EXCEED THE AMOUNT OF THE LICENSE FEE ACTUALLY PAID
# BY LICENSEE TO RV GLOBAL SOFT CO.,LTD.
# ===============================

?>
<?php 

define("VIP_MOD_DIR","Rvtwofactor");
//set_include_path(HBFDIR_LIBS. 'pear');
set_include_path(HBFDIR_LIBS. 'pear' . PATH_SEPARATOR . APPDIR_MODULES . 'Other/' . VIP_MOD_DIR . '/Lib-oAuthConnect/PHP/pear' . PATH_SEPARATOR . dirname(__FILE__) . '/' . VIP_MOD_DIR . '/Lib-oAuthConnect/PHP/RvLibs' . PATH_SEPARATOR . get_include_path());
/*
require_once 'oAuth/Consumer.php';
require_once 'oAuth/Consumer/Request.php';
*/
require_once dirname(__FILE__) .  '/oAuth/Consumer.php';
require_once dirname(__FILE__) .  '/oAuth/Consumer/Request.php';


class RvLibs_RvGlobalStoreApi 
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
        return RvLibs_RvGlobalStoreApi::singleton(
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
            /*
            if(!class_exists('RVLibs_oAuth_Consumer')){
            	require_once dirname(__FILE__) .  '/oAuth/Consumer.php';
            }
            
         	if(!class_exists('RVLibs_oAuth_Consumer_Request')){
            	require_once dirname(__FILE__) .  'oAuth/Consumer/Request.php';
            }*/
            
            $oClass->oAuth = new RVLibs_oAuth_ConsumerPlugin($dsn['uid'], $oClass->secret);
            
            $oAuthReq = new RVLibs_oAuth_Consumer_RequestPlugin();
            $oAuthReq->setAuthType(2); 
            $oClass->oAuth->accept($oAuthReq);
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
    
    public static function request_authorizekey($url, $uid, $key)
    {
    	$appId = defined('RV_APPS_ID') ? RV_APPS_ID : 'unknow';
    	$domain = isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : $_SERVER['HTTP_HOST'];
    	$appUser_id = 'app_' . md5($appId . '_' .  $domain);
    	$oConnect =  self::singleton(
			array(
				'url' => $url,
				'uid' => $uid,
				'publickey' => $key,
				'cp_perms' => 'cpuser',
		));

    	$response = $oConnect->oAuth->sendRequest($url . '/authorize', array(
			'cp_perms' => 'apps',
    		'APP_ID' => defined('RV_APPS_ID') ? RV_APPS_ID : 'unknow',
    		'app_user_id' => $appUser_id,
    		'SERVER_DATA' => base64_encode(serialize($_SERVER)),
    	), 'POST');
    	
    	$aData = array('key' => '', 'code' => '');
    	$data = $oConnect->decodeData($response);
    	foreach (explode("\n",$data) as $line) {
    		$aLine = explode("=", $line, 2);
    		switch (strtolower($aLine[0])) {
    			case 'key': $aData['key'] = $aLine[1];break;
    			case 'code': $aData['code'] = $aLine[1];break;
    		}
    	}
    	
    	$authorizekey = $oConnect->getAuthorizekey($key, $aData);
   
	    $aResData = array(
	    	'authorizeid' => $appUser_id,
	    	'authorizekey' => $authorizekey,
	    );
    
		return $aResData;
    }
	
    function getAuthorizekey($key, $aData)
    {
    	$data = base64_decode($aData['key']);
    	openssl_get_publickey($key);
    	openssl_public_decrypt($data, $keyphrase, $key);
    	$iv = '12345678';
    	return mcrypt_decrypt(MCRYPT_BLOWFISH, $keyphrase, base64_decode($aData['code']), MCRYPT_MODE_CBC, $iv);
    }
    
    
    
    
    function acceptToken()
    {
        $response = $this->oAuth->sendRequest($this->url . '/accept_token', array('SERVER_DATA' => base64_encode(serialize($_SERVER))), 'POST');    
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

        $response = $this->oAuth->sendRequest($this->url . '/validate_token', array(), 'POST');    
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
        $contentType = self::getContentType($header['content-type']);
        switch (strtolower($contentType)) {
            case 'application/rvglobalstore':
                $pub_key = self::getPublickey();
                openssl_get_publickey($pub_key);
                openssl_public_decrypt($data, $token, $pub_key);
                if ($token != '') {
                    self::setToken($token);
                } else {
                    self::errormsg("Cannot decrypt data, please check API Key.");
                }
                $data = $token;
            break;
            case 'text/json':
            case 'application/json':
                $data = json_decode($data);
                self::errormsg($data);
            break;
        }
        return $data;
    }
    
    function getError()
    {
        return self::aError;    
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

class RVL_ErrorPlugin
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
