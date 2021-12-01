<?php

class kbongoogle_controller extends HBController {
    
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
        
        require_once($modPath . '/google-api-php-client/src/Google_Client.php');
        require_once($modPath . '/google-api-php-client/src/contrib/Google_DriveService.php');
        
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
        
        require_once($modPath . '/google-api-php-client/src/Google_Client.php');
        require_once($modPath . '/google-api-php-client/src/contrib/Google_DriveService.php');
        
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
        $documentRootId = $aConfigs['Document Root ID']['value'];
        
        $modPath    = dirname(dirname(__FILE__));
        
        require_once($modPath . '/google-api-php-client/src/Google_Client.php');
        require_once($modPath . '/google-api-php-client/src/contrib/Google_DriveService.php');
        
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
    
    public function syncKbongoogle($request){
         
        $db     = hbm_db();
        $aConfigs       = $this->module->configuration;
        $clientId       = $aConfigs['Client ID']['value'];
        $clientSecret   = $aConfigs['Client Secret']['value'];
        $accessToken    = $aConfigs['Access Token']['value'];
        
        $typOfsync = isset($request['type'])?$request['type'] : ''; 
        $id        = isset($request['id'])?$request['id'] : 0; 
        if($typOfsync == '' || $id == 0){
            exit;
        }
        
        $modPath    = dirname(dirname(__FILE__));
       
        require_once($modPath . '/google-api-php-client/src/Google_Client.php');
        require_once($modPath . '/google-api-php-client/src/contrib/Google_DriveService.php');

        $client     = new Google_Client();
        // Get your credentials from the APIs Console
        $client->setClientId($clientId);
        $client->setClientSecret($clientSecret);
        $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
        $client->setScopes(array('https://www.googleapis.com/auth/drive'));
        $accessToken = preg_replace('/\-quote\-/','"', $accessToken);
        $client->setAccessToken($accessToken);
            
        $gDriveService  = new Google_DriveService($client);
        
        $result = $db->query("
                                 SELECT google_drive_id 
                                 FROM hb_knowledgebase_cat 
                                 WHERE id = :id"
                                 ,array(
                                    ':id'       => $id
                                 ))->fetch();
                                 
        $documentRootId = $result['google_drive_id'];     
           
        if($typOfsync == 'cat'){
            $db->query("
                        UPDATE hb_knowledgebase_cat 
                        SET is_delete = 1 
                        WHERE parent_cat = :parent_Id
                        ",array(
                            ':parent_Id'        => $id
                        ));
                        
            $param  = array('q' => '\''.$documentRootId.'\' in parents and trashed = false '
                    . ' and mimeType = \'application/vnd.google-apps.folder\'');
            $files  = $gDriveService->files->listFiles($param);
            
            if ( isset($files['items']) && count($files['items'])) {
                    
                foreach ($files['items'] as $aItem) {
                
                    $result = $db->query("
                                        SELECT
                                            kc.id
                                        FROM
                                            hb_knowledgebase_cat kc
                                        WHERE
                                            kc.parent_cat = :parentId
                                            AND kc.google_drive_id = :gDriveId
                                        ", array(
                                            ':parentId'     => $id,
                                            ':gDriveId'     => $aItem['id']
                                        ))->fetch();

                    if (isset($result['id']) && $result['id']) {
                        // --- update ---
                        $db->query("
                            UPDATE 
                                hb_knowledgebase_cat
                            SET
                                sync_date = :syncDate,
                                name = :catName,
                                is_delete = 0
                            WHERE
                                id = :catId
                        ", array(
                            ':catId'    => $result['id'],
                            ':syncDate' => time(),
                            ':catName'  => $aItem['title']
                        ));
                        
                    } else {
                        // --- insert ---
                        $db->query("
                            INSERT INTO hb_knowledgebase_cat (
                                id, parent_cat, name, google_drive_id, sync_date, is_delete
                            ) VALUES (
                                null, :parentId, :catName, :gDriveId, :syncDate, 0
                            )
                        ", array(
                            ':parentId'     => $id,
                            ':catName'      => $aItem['title'],
                            ':gDriveId'     => $aItem['id'],
                            ':syncDate'     => time()
                        ));
                    }
                }
            }
            $db->query("
                        DELETE 
                        FROM hb_knowledgebase_cat 
                        WHERE is_delete = 1
                        AND parent_cat = :parent_Id
                        ",array(
                            ':parent_Id'        => $id
                        ));
            $this->syncKbongoogle(array(
                                        'type'  => 'kb',
                                        'id'    => $id
                                        ));
                            
        }else if($typOfsync == 'kb'){
            
            $db->query("
                        UPDATE hb_knowledgebase 
                        SET cat_id = 0 
                        WHERE cat_id = :catId
                        ",array(
                            ':catId'        => $id
                        ));
            require_once(APPDIR . 'class.config.custom.php');
            $userLanguage   = ConfigCustom::singleton()->getValue('UserLanguage');
                    
            // --- หา language id ---
            $result = $db->query("
                    SELECT
                        l.id
                    FROM
                        hb_language l
                    WHERE
                        l.name = :languageName
                        AND l.status = '1'
                        AND l.target = 'user'
                ", array(
                    ':languageName'     => $userLanguage
                ))->fetch();
            if (isset($result['id']) && $result['id']) {
                $languageId = $result['id'];
            } else {
                $message    = 'Unable to find language ID for client.';
                return $message;
            }
            
            // [XXX] RVGlobalSoft ทำไม language id เป็น 1
            $installURL     = ConfigCustom::singleton()->getValue('InstallURL');
            if (preg_match('/rvglobalsoft/', $installURL)) {
                $languageId = 1;
            }
            
            $param  = array('q' => '\''.$documentRootId.'\' in parents and trashed = false '
                    . ' and mimeType != \'application/vnd.google-apps.folder\'');
            $files  = $gDriveService->files->listFiles($param);
            
            if ( isset($files['items']) && count($files['items'])) {
                foreach ($files['items'] as $aItem) {
                    $description    = isset($aItem['description']) ? $aItem['description'] : '';
                    $tags           = '';
                    $tagPos         = strpos($description, 'Tags:');
                    
                    if ($tagPos) {
                        $tags           = substr($description, $tagPos+5);
                        $description    = substr($description, 0, $tagPos);
                    }
                    
                    $urlPublish = 'https://docs.google.com/a/netway.co.th/document/d/' . $aItem['id'] . '/pub';
                    $returned_content = $this->get_data($urlPublish);
                    if(preg_match('/^\<!DOC/i', $returned_content)){
                        $isActive = 1;
                    }else{
                        $isActive = 0;
                    }
                    
                    $body       = '<iframe id="gDocs" src="https://docs.google.com/document/d/'
                                . $aItem['id'] .'/pub?embed?start=false&loop=false&delayms=3000" width="100%" height="450" 
                                scrolling="auto" vspace="10" hspace="10" frameborder="0"></iframe>
                                <br />';
                    
                    $result1     = $db->query("
                                SELECT
                                    kb.id
                                FROM
                                    hb_knowledgebase kb
                                WHERE
                                    kb.google_drive_file_id = :gDriveId
                            ", array(
                                ':gDriveId'     => $aItem['id']
                            ))->fetch();
        
                    if (isset($result1['id']) && $result1['id']) {
                        // --- update ---
                        $db->query("
                            UPDATE 
                                hb_knowledgebase
                            SET
                                last_sync_date = :syncDate,
                                language_id = :languageId,
                                cat_id = :catId,
                                title = :title,
                                body = :body,
                                registered = '0',
                                options = '3',
                                description = :description,
                                tags = :tags,
                                is_active = :isActive
                            WHERE
                                id = :kbId
                        ", array(
                            ':syncDate'     => time(),
                            ':languageId'   => $languageId,
                            ':catId'        => $id,
                            ':title'        => $aItem['title'],
                            ':body'         => $body,
                            ':kbId'         => $result1['id'],
                            ':description'  => $description,
                            ':tags'         => $tags,
                            ':isActive'     => $isActive
                        ));
        
                    } else {
                        // --- insert ---
                        $db->query("
                            INSERT INTO hb_knowledgebase (
                                id, language_id, cat_id, title, body, registered, options, 
                                google_drive_file_id, last_sync_date, 
                                description, tags, is_active
                            ) VALUES (
                                null, :languageId, :catId, :title, :body, '0', '3', 
                                :gDriveId, :syncDate,
                                :description, :tags, :isActive
                            )
                        ", array(
                            ':languageId'   => $languageId,
                            ':catId'        => $id,
                            ':title'        => $aItem['title'],
                            ':body'         => $body,
                            ':gDriveId'     => $aItem['id'],
                            ':syncDate'     => time(),
                            ':description'  => $description,
                            ':tags'         => $tags,
                            ':isActive'     => $isActive
                        ));  
                    }
                }
            }
        }     
    }
    
    public function get_data($url) {
        $ch = curl_init();
        $timeout = 10;
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        $data = curl_exec($ch);
        curl_close($ch);
        return $data;
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