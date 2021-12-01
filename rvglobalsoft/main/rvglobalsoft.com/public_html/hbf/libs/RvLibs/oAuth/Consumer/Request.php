<?php 

require_once 'HTTP/OAuth/Consumer/Request.php';
class RVLibs_oAuth_Consumer_Request extends HTTP_OAuth_Consumer_Request
{
    protected function buildRequest()
    {
        $method = $this->getSignatureMethod();
        $this->debug('signing request with: ' . $method);
        $sig = HTTP_OAuth_Signature::factory($this->getSignatureMethod());

        $this->oauth_timestamp = time();
        $this->oauth_nonce     = md5(microtime(true) . rand(1, 999));
        $this->oauth_version   = '1.0';
        $params                = array_merge(
            $this->getParameters(),
            $this->getUrl()->getQueryVariables()
        );
        $this->oauth_signature = $sig->build(
            $this->getMethod(),
            $this->getUrl()->getURL(),
            $params,
            $this->secrets[0],
            $this->secrets[1]
        );

        $params = $this->getOAuthParameters();
        switch ($this->getAuthType()) {
        case self::AUTH_HEADER:
            $auth = $this->getAuthForHeader($params);
            $this->setHeader('Authorization', $auth);
            break;
        case self::AUTH_POST:
            foreach ($params as $name => $value) {
                $this->addPostParameter($name, $value);
            }
            break;
        case self::AUTH_GET:
            break;
        }
        
        switch ($this->getMethod()) {
        case 'POST':
            foreach ($this->getParameters() as $name => $value) {
                if (substr($name, 0, 6) == 'oauth_') {
                    continue;
                }

                $this->addPostParameter($name, $value);
            }
            break;
        case 'GET':
            $url = $this->getUrl();
            foreach ($this->getParameters() as $name => $value) {
                if (substr($name, 0, 6) == 'oauth_' && $this->getAuthType() != self::AUTH_POST) {
                    continue;
                }

                $url->setQueryVariable($name, $value);
            }
            $this->setUrl($url);
            break;
        default:
            break;
        }
    }
    
    function debug($msg)
    {

    }
}