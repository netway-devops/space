<?php

class mtdpipedrive_controller extends HBController {
    
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        $api    = new ApiWrapper();
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    /**
     * ส่งไป google เพื่อ copy auth code
     * @param unknown_type $request
     * @return unknown_type
     */
    public function getauthcode ($request)
    {
        $aConfigs       = $this->module->configuration;
        $clientId       = $aConfigs['Client ID']['value'];
        $clientSecret   = $aConfigs['Client Secret']['value'];
        
        $modPath    = dirname(dirname(__FILE__));
        
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/Google_Client.php');
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/contrib/Google_DriveService.php');
        
        $client = new Google_Client();
        // Get your credentials from the APIs Console
        $client->setAccessType('offline');
        $client->setApprovalPrompt('force');
        $client->setClientId($clientId);
        $client->setClientSecret($clientSecret);
        $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
        $client->setScopes(array('https://www.googleapis.com/auth/drive', 
            'https://www.googleapis.com/auth/drive.file',
            'https://spreadsheets.google.com/feeds'));

        $authUrl = $client->createAuthUrl();
        
        $this->template->assign('authUrl', $authUrl);
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/getauthcode.tpl',array(), true);
    }
    
    /**
     * Verify auth code ว่ายังใช้ได้อยู่ใหม
     * @return unknown_type
     */
    public function getaccesstoken ($request)
    {
        $aConfigs       = $this->module->configuration;
        $clientId       = $aConfigs['Client ID']['value'];
        $clientSecret   = $aConfigs['Client Secret']['value'];
        $authCode       = $aConfigs['Auth Code']['value'];
        
        $modPath    = dirname(dirname(__FILE__));
        
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/Google_Client.php');
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/contrib/Google_DriveService.php');
        
        $client     = new Google_Client();
        // Get your credentials from the APIs Console
        $client->setClientId($clientId);
        $client->setClientSecret($clientSecret);
        $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
        $client->setScopes(array('https://www.googleapis.com/auth/drive'));
        $accessToken = $client->authenticate($authCode);
        
        $accessToken    = preg_replace('/\"/', '-quote-', $accessToken);
        $this->template->assign('accessToken', $accessToken);
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/getaccesstoken.tpl',array(), true);
    }
    
    public function testaccesstoken ($request)
    {
        $aConfigs       = $this->module->configuration;
        $clientId       = $aConfigs['Client ID']['value'];
        $clientSecret   = $aConfigs['Client Secret']['value'];
        $authCode       = $aConfigs['Auth Code']['value'];
        $accessToken    = $aConfigs['Access Token']['value'];
        $documentRootId = $aConfigs['MTD Pipedrive Document ID']['value'];
        
        $modPath    = dirname(dirname(__FILE__));
        
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/Google_Client.php');
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/contrib/Google_DriveService.php');
        
        $client     = new Google_Client();
        // Get your credentials from the APIs Console
        $client->setClientId($clientId);
        $client->setClientSecret($clientSecret);
        $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
        $client->setScopes(array('https://www.googleapis.com/auth/drive'));
        $accessToken = preg_replace('/\-quote\-/','"', $accessToken);
        $client->setAccessToken($accessToken);
        
        $service = new Google_DriveService($client);

        $aFile  = array();
        try {
            $aFile = $service->files->get($documentRootId);
        } catch (Exception $e) {
            echo 'An error occurred:' . $e->getMessage();
            exit;
        }
        
        $this->template->assign('aFile', $aFile);
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/testaccesstoken.tpl',array(), true);
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) 
            . '/templates/');
    }

    public function afterCall ($request)
    {
        
    }
}