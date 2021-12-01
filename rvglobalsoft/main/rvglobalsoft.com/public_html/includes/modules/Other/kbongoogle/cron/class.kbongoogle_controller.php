<?php

class kbongoogle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * 
     * @return string
     */
    public function call_Hourly() 
    {
        $db     = hbm_db();
        
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
        
        $nwLastKbCategorySync = ConfigCustom::singleton()->getValue('nwLastKbCategorySyncWithGoogleDrive');
        
        // --- ถ้ามีที่ยังไม่ update ---
        $result = $db->query("
                SELECT 
                    kc.id, kc.google_drive_id
                FROM 
                    hb_knowledgebase_cat kc
                WHERE 
                    kc.id > :catId
                    AND kc.google_drive_id != ''
                ORDER BY kc.id ASC LIMIT 5
            ", array(
                ':catId'        => $nwLastKbCategorySync
            ))->fetchAll();
        
        if (! count($result) || ! isset($result[0]['id'])) {
            ConfigCustom::singleton()->setValue('nwLastKbCategorySyncWithGoogleDrive', 0);
            $message    = 'Start new round.';
            return $message;
        }
        
        foreach ($result as $arr) {
            $documentRootId = $arr['google_drive_id'];
            $catId          = $arr['id'];            
            $this->_updateKb($documentRootId, $catId, $languageId);
            
            ConfigCustom::singleton()->setValue('nwLastKbCategorySyncWithGoogleDrive', $catId);
        }
        
        return $message;
    }
    
    private function _updateKb ($documentRootId, $catId, $languageId)
    {
        $db     = hbm_db();
                
        $aConfigs       = $this->module->configuration;
        $clientId       = $aConfigs['Client ID']['value'];
        $clientSecret   = $aConfigs['Client Secret']['value'];
        $accessToken    = $aConfigs['Access Token']['value'];
        
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

        // --- reset sync date ---
        $db->query("
            UPDATE
                hb_knowledgebase
            SET
                last_sync_date = 0
            WHERE
                cat_id = :catId
        ", array(
            ':catId'    => $catId
        ));
        
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
                
                $body       = '<iframe id="gDocs" src="https://docs.google.com/document/d/'
                            . $aItem['id'] .'/pub?embed?start=false&loop=false&delayms=3000" width="100%" height="250" 
                            scrolling="auto" vspace="10" hspace="10" frameborder="0" style="min-height:450px;"></iframe>
                            <br />';
                
                $result     = $db->query("
                            SELECT
                                kb.id
                            FROM
                                hb_knowledgebase kb
                            WHERE
                                kb.google_drive_file_id = :gDriveId
                        ", array(
                            ':gDriveId'     => $aItem['id']
                        ))->fetch();
    
                if (isset($result['id']) && $result['id']) {
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
                            tags = :tags
                        WHERE
                            id = :kbId
                    ", array(
                        ':syncDate'     => time(),
                        ':languageId'   => $languageId,
                        ':catId'        => $catId,
                        ':title'        => $aItem['title'],
                        ':body'         => $body,
                        ':kbId'         => $result['id'],
                        ':description'  => $description,
                        ':tags'         => $tags
                    ));
    
                } else {
                    // --- insert ---
                    $db->query("
                        INSERT INTO hb_knowledgebase (
                            id, language_id, cat_id, title, body, registered, options, 
                            google_drive_file_id, last_sync_date, 
                            description, tags
                        ) VALUES (
                            null, :languageId, :catId, :title, :body, '0', '3', 
                            :gDriveId, :syncDate,
                            :description, :tags
                        )
                    ", array(
                        ':languageId'   => $languageId,
                        ':catId'        => $catId,
                        ':title'        => $aItem['title'],
                        ':body'         => $body,
                        ':gDriveId'     => $aItem['id'],
                        ':syncDate'     => time(),
                        ':description'  => $description,
                        ':tags'         => $tags
                    ));
                    
                }
                
            }// foreach
        }
        
    }
    
    /**
     * Sync Knowledgebase category
     * @return string
     */
    public function call_Daily() 
    {
        global $gDriveService;
        
        $aConfigs       = $this->module->configuration;
        $clientId       = $aConfigs['Client ID']['value'];
        $clientSecret   = $aConfigs['Client Secret']['value'];
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
        
        $gDriveService  = new Google_DriveService($client);
        
        $aFile      = array();
        $message    = '';
        try {
            $aFile  = $gDriveService->files->get($documentRootId);
        } catch (Exception $e) {
            $message = 'An error occurred:' . $e->getMessage();
            return $message;
        }
        
        if (! isset($aFile['id'])) {
            return $message;
        }
        
        $message    = $this->_updateCategory($documentRootId);
        $this->call_Hourly();
        return $message;
    }
    
    private function _updateCategory ($documentRootId, $parentId = 0)
    {
        global $gDriveService;
        
        $db     = hbm_db();
        
        // --- reset sync date ---
        $db->query("
            UPDATE
                hb_knowledgebase_cat
            SET
                sync_date = 0
            WHERE
                parent_cat = :parentId
        ", array(
            ':parentId'     => $parentId
        ));
        
        $param  = array('q' => '\''.$documentRootId.'\' in parents and trashed = false '
                    . ' and mimeType = \'application/vnd.google-apps.folder\'');
        $files  = $gDriveService->files->listFiles($param);
        
        if ( isset($files['items']) && count($files['items'])) {
                        
            foreach ($files['items'] as $aItem) {
                
                $result     = $db->query("
                        SELECT
                            kc.id
                        FROM
                            hb_knowledgebase_cat kc
                        WHERE
                            kc.parent_cat = :parentId
                            AND kc.google_drive_id = :gDriveId
                        ", array(
                            ':parentId'     => $parentId,
                            ':gDriveId'     => $aItem['id']
                        ))->fetch();
                
                if (isset($result['id']) && $result['id']) {
                    // --- update ---
                    $db->query("
                        UPDATE 
                            hb_knowledgebase_cat
                        SET
                            sync_date = :syncDate,
                            name = :catName
                        WHERE
                            id = :catId
                    ", array(
                        ':catId'    => $result['id'],
                        ':syncDate' => time(),
                        ':catName'  => $aItem['title']
                    ));
                    
                    $currentParentId    = $result['id'];
                    
                } else {
                    // --- insert ---
                    $db->query("
                        INSERT INTO hb_knowledgebase_cat (
                            id, parent_cat, name, google_drive_id, sync_date
                        ) VALUES (
                            null, :parentId, :catName, :gDriveId, :syncDate
                        )
                    ", array(
                        ':parentId'     => $parentId,
                        ':catName'      => $aItem['title'],
                        ':gDriveId'     => $aItem['id'],
                        ':syncDate'     => time()
                    ));
                    
                    $result     = $db->query("
                                SELECT 
                                    MAX(id) AS id
                                FROM
                                    hb_knowledgebase_cat
                            ")->fetch();
                    
                    if (isset($result['id']) && $result['id']) {
                        $currentParentId    = $result['id'];
                    }
                }
                
                if (isset($currentParentId) && $currentParentId) {
                    $this->_updateCategory($aItem['id'], $currentParentId);
                }
            }
        }
        
    }
    
}


