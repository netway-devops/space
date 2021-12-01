<?php

class importtozendesk_controller extends HBController {

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }

    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
        
        $this->template->assign('title', 'Import to Z3endesk');
    
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function deleteKbCategory ($request)
    {        
        $db     = hbm_db();
        
        $request    = array(
            'url'       => '/help_center/categories.json',
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        
        echo '<pre>'. print_r($result, true) .'</pre>';
        
        if (! isset($result['categories']) && count($result['categories']) ) {
            exit;
        }
        
        $result     = $result['categories'];
        
        
       
        foreach ($result as $arr) {
            $id     = $arr['id'];
            
            $request    = array(
                'url'       => '/help_center/categories/'. $id .'.json',
                'method'    => 'delete',
                'data'      => array()
            );
            $result     = self::_send($request);
            
            $db->query("
                DELETE FROM hb_zendesk_category
                WHERE zendesk_id = '{$id}'
                ");
            
        }


    }
    
    private function _send ($request)
    {
        $url        = $request['url'];
        $method     = isset($request['method']) ? $request['method'] : 'get';
        $data       = isset($request['data']) ? json_encode($request['data']) : array();
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://rvglobalsoft.zendesk.com/api/v2'. $url);
        if ($method == 'post') {
            curl_setopt($ch, CURLOPT_POST, 1);
        }
        if ($method == 'put') {
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
        }
        if ($method != 'get') {
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        }
        if ($method == 'delete') {
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');
        }
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_USERPWD, 'prasit+rv@netway.co.th/token:rzkJaKdbWg2cptxaVZjsezCiIY8mxgrpG89kobAg');
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
        $data   = curl_exec($ch);
        curl_close($ch);
        $result = json_decode($data, true);
        
        return $result;
    }
    
    
    public function deleteKbSection ($request)
    {        
     
        $db     = hbm_db();
        $id     = $arr['id'];
//เรียกดูSection  
       $request    = array(
            'url'       => '/help_center/sections'.$id.'.json',
            'method'    => 'get',
            'data'      =>  array()
        );
        $result     = self::_send($request);
        echo '<pre>'. print_r($result, true) .'</pre>';
  
              
        if (!isset($result['sections']) && count($result['sections']) ) {
            exit;
        }

        $result     = $result['sections'];
        echo '<pre>'. print_r($result, true) .'</pre>';
    
  
 //ลบ section ใน zendesk และ DB
    
        foreach ($result as $arr) {
            $id     = $arr['id'];   
            //echo '<pre>'. print_r($id, true) .'</pre>';
            $request    = array(
                'url'       => '/help_center/sections/'. $id .'.json',
                'method'    => 'delete',            
                'data'      => array()
            );
            $result     = self::_send($request);
            echo '<pre>'. print_r($result, true) .'</pre>';
            
             $db->query("
                DELETE FROM hb_zendesk_section
                WHERE zendesk_id = '{$id}'
                ");
   
         }
        

       }
    
    public function importKbCategory ($request)
    {
        global $gDriveService, $aCategory;
       
        $db             = hbm_db();
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
        }
        
        echo '<p>'. $message .'</p>';
        
        $aCategory  = array();
        $this->_getCategory($documentRootId);
        
        $index      = 0;
        $aCategory_ = $aCategory;
        
        echo '<table border="1">
        <tr>
            <td>id</td>
            <td>parentId</td>
            <td>level</td>
            <td>isSection</td>
            <td>fullName</td>
            <td>ZendeskId</td>
            <td>Log</td>
            </tr>
        ';
        foreach ($aCategory_ as $id => $arr) {
            $googleId   = $id;
            
            echo '<tr>
            <td>'. $id .'</td>
            <td>'. $arr['parentId'] .'</td>
            <td>'. $arr['level'] .'</td>
            <td>'. $arr['isSection'] .'</td>
            <td>'. $arr['fullName'] .'</td>
            ';
            /*
            if ($arr['isSection']) {
                continue;
            }
            */
            if ($arr['level'] > 1) {
                continue;
            }

            $result     = $db->query("
                SELECT zc.*
                FROM hb_zendesk_category zc
                WHERE google_id = '{$googleId}'
                ")->fetch();
            
            
            if (isset($result['zendesk_id']) && $result['zendesk_id']) {
                continue;
            }
            
            
            if (! isset($result['google_id'])) {
                $db->query("
                    INSERT INTO hb_zendesk_category (
                    google_id
                    ) VALUES (
                    '{$googleId}'
                    )
                    ");
            }
            
            $fullName   = substr($arr['fullName'],2);
            
            $zendeskId  = 0;
            $result     = '';
            
            $request    = array(
                'url'       => '/help_center/categories.json',
                'method'    => 'post',
                'data'      => array(
                    'category'   => array(
                        'locale'    => 'en-us',
                        'name'      => $fullName
                    )
                      
                )
            );
            
            $result     = self::_send($request);
            //echo '<pre>'. print_r($result,true).'</pre>';
            if (isset($result['category']['id'])) {
                $zendeskId  = $result['category']['id'];
                $db->query("
                    UPDATE hb_zendesk_category
                    SET zendesk_id = '{$zendeskId}'
                    WHERE google_id = '{$googleId}'
                    ");
            }
            
            echo '
                <td>'. $zendeskId .'</td>
                <td><pre>'. print_r($result, true) .'</pre></td>
                </tr>
                ';
        }
        echo '</table>';
        
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/import_kb.tpl',array(), true);
    }
    
    private function _getCategory ($documentRootId, $level = 0)
    {
        global $gDriveService, $aCategory;
        
        $db     = hbm_db();
        
        $param  = array('q' => '\''.$documentRootId.'\' in parents and trashed = false '
                    . ' and mimeType = \'application/vnd.google-apps.folder\'');
        $files  = $gDriveService->files->listFiles($param);
        
        if ( isset($files['items']) && count($files['items'])) {
            $level++;
            foreach ($files['items'] as $aItem) {
                $id         = $aItem['id'];
                $aCategory[$id]     = $aItem;
                $aCategory[$id]['parentId']     = $documentRootId;
                $aCategory[$id]['level']        = $level;
                $aCategory[$id]['isSection']    = 1;
                $aCategory[$documentRootId]['isSection']    = 0;
                $aCategory[$id]['fullName']     = $aCategory[$documentRootId]['fullName'] .' / '. $aItem['title'];
                
                $this->_getCategory($aItem['id'], $level);
            }
            
        }
        
    }
    
    
    
    public function importKbSection ($request)
    {
        global $gDriveService, $aCategory;
        
        $db             = hbm_db();
        
        
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
        }
        
        echo '<p>'. $message .'</p>';
        
        $aCategory  = array();
        $this->_getCategory($documentRootId);
        
        $index      = 0;
        $aCategory_ = $aCategory;
        
        echo '<table border="1">
        <tr>
            <td>id</td>
            <td>parentId</td>
            <td>level</td>
            <td>isSection</td>
            <td>fullName</td>
            </tr>
        ';
        foreach ($aCategory_ as $id => $arr) {
            $googleId   = $id;
            $parentId   = $arr['parentId'];
            
            echo '<tr>
            <td>'. $id .'</td>
            <td>'. $arr['parentId'] .'</td>
            <td>'. $arr['level'] .'</td>
            <td>'. $arr['isSection'] .'</td>
            <td>'. $arr['fullName'] .'</td>
            </tr>';
            
            if (! $arr['isSection']) {
                continue;
            }

            $result     = $db->query("
                SELECT zs.*
                FROM hb_zendesk_section zs
                WHERE google_id = '{$googleId}'
                ")->fetch();
            
            
            if (isset($result['zendesk_id']) && $result['zendesk_id']) {
                continue;
            }
            
            
            if (! isset($result['google_id'])) {
                $db->query("
                    INSERT INTO hb_zendesk_section (
                    google_id
                    ) VALUES (
                    '{$googleId}'
                    )
                    ");
            }
            
            
            $result     = $db->query("
                SELECT zc.*
                FROM hb_zendesk_category zc
                WHERE zc.google_id = '{$parentId}'
                ")->fetch();
            
            $categoryId = $result['zendesk_id'];
            
            $fullName   = substr($arr['fullName'],2);
            
            $request    = array(
                'url'       => '/help_center/categories/'. $categoryId .'/sections.json',
                'method'    => 'post',
                'data'      => array(
                    'section'   => array(
                        'locale'  =>    'en-us',
                        'name'    =>    $fullName
                    )
                )
            );
            $result     = self::_send($request);
            
            if (isset($result['section']['id'])) {
                $zendeskId  = $result['section']['id'];
              
                $db->query("
                    UPDATE hb_zendesk_section
                    SET zendesk_id = '{$zendeskId}'
                    WHERE google_id = '{$googleId}'
                    ");
            }
            
            
        } 
        echo '</table>';
        
       
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/import_kb.tpl',array(), true);
             
    }


    
    public function importKb ($request)
    {
        $db             = hbm_db();
        
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
        
        
        $result = $db->query("
                SELECT *
                FROM hb_zendesk_section
                WHERE 1
                ORDER BY google_id ASC
                #LIMIT 0,1
            ")->fetchAll();
       
        echo '<pre>'. print_r($result, true) .'</pre>';
      
       
        if (count($result)) {
            foreach ($result as $arr) {
                $documentRootId = $arr['google_id'];
                $sectionId      = $arr['zendesk_id'];
                
                $param  = array('q' => '\''.$documentRootId.'\' in parents and trashed = false '
                            . ' and mimeType != \'application/vnd.google-apps.folder\'');
                $files  = $gDriveService->files->listFiles($param);
                
                if ( ! isset($files['items']) || ! count($files['items'])) {
                    continue;
                }
                
                foreach ($files['items'] as $aItem) {
     
                    $googleId   = $aItem['id'];
                    $title      = $aItem['title'];
                    
                    $result     = $db->query("
                        SELECT za.*
                        FROM hb_zendesk_article za
                        WHERE za.google_id = '{$googleId}'
                        ")->fetch();
                  
                  echo '</ br>'.'<pre>'. print_r($result, true) .'</pre>';
                 
          
                    
                    if (! isset($result['google_id'])) {
                        $db->query("
                            INSERT INTO hb_zendesk_article (
                            google_id, section_id
                            ) VALUES (
                            '{$googleId}', '{$sectionId}'
                            )
                            ");
                    }
 
                   
                    $db->query("
                        UPDATE hb_zendesk_article
                        SET title = :title
                        WHERE google_id = '{$googleId}'
                        ", array(
                            ':title'    => $title
                        ));
                    
                } //foreach Item
            
            }
        }
        
        exit;
    }
    
    
    public function importKbContent ($request)
    {
        // https://support.zendesk.com/hc/en-us/articles/115004292147-How-do-I-update-Help-Center-articles-via-API-
    }
   
    public function importKbArticle ($request)
    {
        $db             = hbm_db();     
        $result     = $db->query("
            SELECT za.*
            FROM hb_zendesk_article za
            WHERE article_id = ''
            LIMIT 10
            ")->fetchAll();
         
        if (! count($result)) {
            exit;
        }
        
        foreach ($result as $arr) {
            
            $fileId     = $arr['google_id'];
            $title      = $arr['title'];
            $sectionId  = $arr['section_id'];

            echo $sectionId ;
                              
            $respond    = file_get_contents('http://netway.co.th/google/export.php?googleId='. $fileId);
            $content    = $respond;
                       
            $request    = array(
                'url'       => '/help_center/sections/'. $sectionId .'/articles.json',         
                'method'    => 'post',
                'data'      => array(
                    'article'   => array(
                      'locale'  => 'en-us',
                      'title'   => $title,
                      'body'    => $content
                    )
                )
            );
            $result     = self::_send($request);

            echo '<pre>'. print_r($result, true) .'</pre>';
            
            
            if (isset($result['article']['id'])) {
                $articleId  = $result['article']['id'];
                $db->query("
                    UPDATE hb_zendesk_article
                    SET article_id = '{$articleId}'
                    WHERE google_id = '{$fileId}'
                    ");
            }
            
        }
        echo '
            <script language="javascript">
            location.reload();
            </script>
            ';
        exit;
   }
    
    
      
    public function deleteKbArticle ($request)
    {        
     
        $db     = hbm_db();
        $result     = $db->query("
            SELECT *
            FROM hb_zendesk_article
            WHERE article_id IS NOT NULL
            ORDER BY article_id ASC 
            LIMIT  10 
            ")->fetchAll();
         
        if (!count($result)) {
            exit;
        }
        
        foreach ($result as $arr) {
            
            $id  = $arr['article_id'];


            $request    = array(
            'url'       => '/help_center/articles/'.$id.'.json',
            'method'    => 'delete',
            'data'      =>  array()
        );
        $result     = self::_send($request);
       
        echo '<pre>'. print_r($result, true) .'</pre>';
   
             $db->query("
                DELETE FROM hb_zendesk_article
                WHERE article_id = '{$id}'
                ");
             
         }
         echo '
            <script language="javascript">
            location.reload();
            </script>
            ';
        exit;
     }
    
    
   public function deleteUser ($request){
        $db     = hbm_db();

       $request    = array(
            'url'       => '/users.json',
            'method'    => 'get',
            'data'      =>  array(
           
            )
        );
        $result     = self::_send($request);
        
         if (!isset($result['users']) && count($result['users']) ) {
            exit;
        }
         
         
        $result     = $result['users'];
        //echo '<pre>'. print_r($result, true) .'</pre>';
       
           foreach ($result as $arr) {
            $id     = $arr['id'];             
            $request    = array(
                'url'       => '/users/'. $id.'.json',
                'method'    => 'delete',            
                'data'      => array(
                    'user'      => array(
                      'email'   => $email,
                      'name'    => $name,
                      'role'    => 'end-user',                        
                      'verified'=> false
                      
                        )
                )
              
            );
            $result     = self::_send($request);
            echo '<pre>'. print_r($result, true) .'</pre>';
            
         }

      }



    
    public function importUser ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'User integration',
            'desc'      => 'จัดการข้อมูลผู้ใช้งาน'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $aDatas     = array();
        
        $result     = $db->query("
            SELECT ca.id, ca.email, zu.client_id, zu.user_id,
                cd.firstname, cd.lastname
            FROM hb_client_access ca
                LEFT JOIN hb_zendesk_user zu
                    ON zu.client_id = ca.id
                ,
                hb_client_details cd
            WHERE ca.id = cd.id
                AND (zu.user_id IS NULL OR zu.sync_date < SUBDATE(CURDATE(), 7))
               
            #GROUP BY ca.id
            ORDER BY ca.id DESC
            LIMIT 20
            ")->fetchAll();
        
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $clientId   = $arr['id'];
                $userId     = $arr['user_id'];
                $email      = trim(strtolower($arr['email']));
                if ($arr['firstname'] || $arr['lastname']) {
                $name       = $arr['firstname'] .' '. $arr['lastname'];
                } else {
                $name       = $email;
                }
                if (! isset($arr['client_id']) || ! $arr['client_id']) {
                    $db->query("
                        INSERT INTO hb_zendesk_user (
                        client_id
                        ) VALUES (
                        :clientId
                        )
                        ", array(
                            ':clientId'     => $clientId
                        ));
                }
                
                $aParam         = array(
                    'url'       => '/users/search.json?query='. $email,
                    'method'    => 'get',
                    'data'      => array()
                );
                $result = self::_send($aParam);
                $result = isset($result['users'][0]) ? $result['users'][0] : array();
                
                if (isset($result['id']) && $result['id'] != $userId) {
                    $db->query("
                        UPDATE hb_zendesk_user
                        SET is_error_email = 1,
                            sync_date = NOW()
                        WHERE client_id = :clientId
                        ", array(
                            ':clientId' => $clientId
                        ));
                    continue;
                }
                
                if (! isset($result['email']) || $result['email'] != $email) {
                    
                    $aParam         = array(
                        'url'       => '/users.json',
                        'method'    => 'post',
                        'data'      => array(
                            'user'      => array(
                                'email'     => $email,
                                'name'      => $name,
                                'role'      => 'end-user',
                                'locale'    => 'th',
                                'time_zone' => 'Bangkok',
                                'verified'  => true
                            )
                        )
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['user']) ? $result['user'] : array();
                    
                }
                
                if (isset($result['id'])) {
                    $userId     = $result['id'];
                    
                    $db->query("
                        UPDATE hb_zendesk_user
                        SET user_id = :userId,
                            sync_date = NOW()
                        WHERE client_id = :clientId
                        ", array(
                            ':userId'   => $userId,
                            ':clientId' => $clientId
                        ));
                    
                }
                
                $aDatas[$clientId]      = $result;
                
            }
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        if ($isReturn) {
            return $aDatas;
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/user.tpl',array(), true);
    }
    
    public function importOrganization ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'User organization integration',
            'desc'      => 'จัดการข้อมูล Organization ของผู้ใช้งาน'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $aDatas     = array();
        
        $aIgnoreOrg = array(
            '-1',
            '360001016774'
        );
        
        $db->query("
            UPDATE hb_zendesk_user
            SET org_id = ''
            WHERE org_id IN ('". implode("','", $aIgnoreOrg) ."')
            ");
        
        $result     = $db->query("
            SELECT ca.id, ca.email, zu.user_id, zu.org_id,
                cd.companyname
            FROM hb_client_access ca,
                hb_client_details cd,
                hb_zendesk_user zu
            WHERE ca.id = cd.id
                # AND cd.company = 1
                AND cd.parent_id = 0
                AND ca.id = zu.client_id
                AND zu.user_id != ''
                AND (zu.org_id = '' OR zu.org_id = '0' OR zu.sync_date < SUBDATE(CURDATE(), 7))
            ORDER BY ca.id DESC
            LIMIT 10
            ")->fetchAll();
        
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $clientId   = $arr['id'];
                $userId     = $arr['user_id'];
                $orgId      = $arr['org_id'];
                $companyname    = $arr['companyname'] ? $arr['companyname'] : 'Organization #'. $clientId;
                
                if (! $orgId) {
                    
                    $aParam         = array(
                        'url'       => '/users/'. $userId .'.json',
                        'method'    => 'get',
                        'data'      => array()
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['user']) ? $result['user'] : array();
                    
                    $orgId      = isset($result['organization_id']) ? $result['organization_id'] : 0;
                    if (in_array($orgId, $aIgnoreOrg)) {
                        $orgId  = 0;
                    }
                    
                    if (! $orgId) {
                        
                        $aParam         = array(
                            'url'       => '/organizations.json',
                            'method'    => 'post',
                            'data'      => array(
                                'organization'  => array(
                                    'name'      => $companyname
                                )
                            )
                        );
                        $result = self::_send($aParam);
                        $result = isset($result['organization']) ? $result['organization'] : array();
                        
                        if (! isset($result['id'])) {
                            $aParam         = array(
                                'url'       => '/organizations.json',
                                'method'    => 'post',
                                'data'      => array(
                                    'organization'  => array(
                                        'name'      => 'Org #'. $clientId
                                    )
                                )
                            );
                            $result = self::_send($aParam);
                            $result = isset($result['organization']) ? $result['organization'] : array();
                        }
                        
                        $orgId      = isset($result['id']) ? $result['id'] : 0;
                        
                        $result['json']         = 'organizations';
                        $aDatas[$clientId]      = $result;
                        
                        if ($orgId) {
                            
                            $aParam         = array(
                                'url'       => '/organization_memberships.json',
                                'method'    => 'post',
                                'data'      => array(
                                    'organization_membership'   => array(
                                        'user_id'           => $userId,
                                        'organization_id'   => $orgId,
                                        'default'   => true
                                    )
                                )
                            );
                            $result = self::_send($aParam);
                            $result = isset($result['organization_membership']) ? $result['organization_membership'] : array();
                            
                            if (isset($result['id'])) {
                                $db->query("
                                    UPDATE hb_zendesk_user
                                    SET org_id = :orgId,
                                        sync_date = NOW()
                                    WHERE client_id = :clientId
                                    ", array(
                                        ':orgId'    => $orgId,
                                        ':clientId' => $clientId
                                    ));
                                
                                $result['json']         = 'organization_memberships';
                                $aDatas[$clientId]      = $result;
                            }
                            
                        }
                        
                    } else {
                        $orgId      = $result['organization_id'];
                        $db->query("
                            UPDATE hb_zendesk_user
                            SET org_id = :orgId,
                                sync_date = NOW()
                            WHERE client_id = :clientId
                            ", array(
                                ':orgId'    => $orgId,
                                ':clientId' => $clientId
                            ));
                    }
                
                }
                
                if (! $orgId) {
                    $db->query("
                        UPDATE hb_zendesk_user
                        SET sync_date = NOW()
                        WHERE client_id = :clientId
                        ", array(
                            ':clientId' => $clientId
                        ));
                    continue;
                }
                
                $result     = $db->query("
                    SELECT ca.id, ca.email, zu.user_id, zu.org_id
                    FROM hb_client_access ca,
                        hb_client_details cd,
                        hb_zendesk_user zu
                    WHERE ca.id = cd.id
                        AND cd.parent_id = '{$clientId}'
                        AND ca.id = zu.client_id
                        AND zu.user_id != ''
                        AND (zu.org_id = '' OR zu.sync_date < SUBDATE(CURDATE(), 7))
                    ")->fetchAll();
                
                if (! count($result)) {
                    continue;
                }
                
                $result2    = $result;
                
                foreach ($result2 as $arr) {
                    $clientId   = $arr['id'];
                    $userId     = $arr['user_id'];
                    
                    $aParam         = array(
                        'url'       => '/organization_memberships.json',
                        'method'    => 'post',
                        'data'      => array(
                            'organization_membership'   => array(
                                'user_id'           => $userId,
                                'organization_id'   => $orgId,
                                'default'   => true
                            )
                        )
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['organization_membership']) ? $result['organization_membership'] : array();
                    
                    if (isset($result['id'])) {
                        $db->query("
                            UPDATE hb_zendesk_user
                            SET org_id = :orgId,
                                sync_date = NOW()
                            WHERE client_id = :clientId
                            ", array(
                                ':orgId'    => $orgId,
                                ':clientId' => $clientId
                            ));
                        
                        $result['json']         = 'organization_memberships';
                        $aDatas[$clientId]      = $result;
                    }
                    
                }
                
            }
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        if ($isReturn) {
            return $aDatas;
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/organization.tpl',array(), true);
    }
    
    public function setorgclientid ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'Main client id',
            'desc'      => 'จัดการเชื่อมข้อมูล client id ของ Netway กับ Organization ขแง Zendesk'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $aDatas     = array();
        
        $result     = $db->query("
            SELECT *
            FROM hb_zendesk_user
            WHERE is_set_org_client_id = 0
                AND user_id != ''
                AND org_id != ''
                AND org_id != '0'
            LIMIT 10
            ")->fetchAll();
        
        if (count($result)) {
            $result_    = $result;
            foreach ($result_ as $arr) {
                $clientId   = $arr['client_id'];
                $orgId      = $arr['org_id'];
                $userId     = $arr['user_id'];
                
                $aParam         = array(
                    'url'       => '/organizations/'. $orgId .'.json',
                    'method'    => 'get',
                    'data'      => array(
                    )
                );
                $result = self::_send($aParam);
                $result = isset($result['organization']) ? $result['organization'] : array();
                $aField = isset($result['organization_fields']) ? $result['organization_fields'] : array();
                $mainClientId   = isset($aField['main_client_id']) ? $aField['main_client_id'] : 0;
                
                if (! $mainClientId) {
                    $aParam         = array(
                        'url'       => '/organizations/'. $orgId .'.json',
                        'method'    => 'put',
                        'data'      => array(
                            'organization'  => array(
                                'organization_fields'   => array(
                                    'main_client_id'    => $clientId
                                )
                            )
                        )
                    );
                    $result = self::_send($aParam);
                    $result = isset($result['organization']) ? $result['organization'] : array();
                }
                
                $db->query("
                    UPDATE hb_zendesk_user
                    SET is_set_org_client_id = 1
                    WHERE client_id = :clientId
                    ", array(
                        ':clientId' => $clientId
                    ));
                
                $aDatas[$clientId]  = $result;
                
            }
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/setorgclientid.tpl',array(), true);
    }
    
    
    
public function getUser ($request)
    {
        $db         = hbm_db();
        
        $email      = isset($request['email']) ? $request['email'] : '';
        $clientId   = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $aData      = array();
        
        if (! $email) {
            return $aData;
        }
        
        $request    = array(
            'url'       => '/users/search.json?query='. $email,
            'method'    => 'get',
            'data'      => array()
        );
        $result     = self::_send($request);
        
        $result     = isset($result['users'][0]) ? $result['users'][0] : array();
        
        if (isset($result['id'])) {
            $userId     = $result['id'];
            $orgId      = isset($result['organization_id']) ? $result['organization_id'] : 0;
            $aData      = $result;
            
            // Check organization share ticket
            
            if (in_array($orgId, $this->aPublicOrganization)) {
                $orgId  = 0;
                $aData['organization_id']   = $orgId;
                
            } else {
                $request    = array(
                    'url'       => '/users/'. $userId .'/organizations.json',
                    'method'    => 'get',
                    'data'      => array()
                );
                $result     = self::_send($request);
                echo '<p><pre>'. print_r($result, true) .'</pre></p>';
                $result     = isset($result['organizations']) ? $result['organizations'] : array();
                
                if (count($result)) {
                    foreach ($result as $arr) {
                        if ($arr['shared_tickets']) {
                            $orgId  = $arr['id'];
                        } else {
                            $orgId  = 0;
                        }
                    }
                }
                
                $aData['organization_id']   = $orgId;
            }
            
            $result     = $db->query("
                SELECT zu.*
                FROM hb_zendesk_user zu
                WHERE zu.client_id = :clientId
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();
            
            if (isset($result['client_id'])) {
                $db->query("
                    UPDATE hb_zendesk_user
                    SET user_id = :userId,
                        org_id = :orgId,
                        sync_date = NOW()
                    WHERE client_id = :clientId
                    ", array(
                        ':userId'   => $userId,
                        ':orgId'    => $orgId,
                        ':clientId' => $clientId
                    ));
            } else {
                $db->query("
                    INSERT INTO hb_zendesk_user (
                        client_id, user_id, org_id, sync_date
                    ) VALUES (
                        :clientId, :userId, :orgId, NOW()
                    )
                    ", array(
                        ':userId'   => $userId,
                        ':orgId'    => $orgId,
                        ':clientId' => $clientId
                    ));
            }
            
        }
        
        
        return $aData;
    }
    

    public function importTicket ($request)
    {
        $db         = hbm_db();
        
        $oInfo          = (object) array(
            'title'     => 'Import ticket',
            'desc'      => 'นำเข้า ticket ไปยัง zendesk'
            );
        $this->template->assign('oInfo', $oInfo);
        
        $isReturn   = isset($request['isReturn']) ? $request['isReturn'] : 0;
        
        $aDatas     = array();
      
        $aUsers     = $this->aUsers;
        
        $result     = $db->query("
            SELECT t.id, t.subject, t.client_id, t.body, t.ticket_number, t.date, t.lastupdate,
                zt.ticket_id, zt.zendesk_ticket_id, zt.replies,
                t2r.request_type
            FROM hb_tickets t
                LEFT JOIN hb_zendesk_ticket zt
                    ON zt.ticket_id = t.id
                LEFT JOIN sc_ticket_2_request t2r
                    ON t2r.ticket_id = t.id
            WHERE (zt.zendesk_ticket_id IS NULL AND (zt.sync_date IS NULL OR zt.sync_date < SUBDATE(CURDATE(), 3) ) )
                AND t.client_id !=0               
            ORDER BY t.id ASC
            LIMIT 10
            ")->fetchAll();

   
        $result_    = count($result) ? $result : array();
        
        foreach ($result_ as $arr) {
            $ticketId       = $arr['id'];
            $ticketNum      = $arr['ticket_number'];
            $clientId       = $arr['client_id'];
            $subject        = $arr['subject'];
            $description    = $arr['body'];
            $zendeskId      = $arr['zendesk_ticket_id'];
            switch ($arr['request_type']) {
                case 'Service Request' : $type = 'question'; break;
                case 'Change' : $type = 'task'; break;
                case 'Problem' : $type = 'problem'; break;
                default : $type = 'incident';
            }
            $create         = date('Y-m-d', strtotime($arr['date']));
            $update         = date('Y-m-d', strtotime($arr['lastupdate']));
            
            if (! $arr['ticket_id']) {
                $db->query("
                    INSERT INTO hb_zendesk_ticket (
                    ticket_id
                    ) VALUES (
                    :ticketId
                    )
                    ", array(
                        ':ticketId' => $ticketId
                    ));
            }
            
            $result     = $db->query("
                SELECT zu.user_id
                FROM hb_zendesk_user zu
                WHERE zu.client_id = :clientId
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();
            
            $userId     = (isset($result['user_id']) && $result['user_id']) ? $result['user_id'] : 0;
            
            if (! $userId) {
                $db->query("
                    UPDATE hb_zendesk_ticket
                    SET zendesk_ticket_id = -1
                    WHERE ticket_id = :ticketId
                    ", array(
                        ':ticketId' => $ticketId
                    ));
                
                continue;
            }

            $db->query("
                UPDATE hb_zendesk_ticket
                SET sync_date = NOW()
                WHERE ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ));
            
            $aComments  = array();
            $aComments[]    = array(
                'author_id' => 115243990634,
                'value'     => 'Import from https://rvglobalsoft.com/7944web/index.php?cmd=tickets&action=view&list=all&num='. $ticketNum,
                'created_at'    => date('Y-m-d'),
                'public'    => false
            );
            
            $result     = $db->query("
                SELECT tr.*,
                    zu.user_id
                FROM hb_ticket_replies tr
                    LEFT JOIN hb_zendesk_user zu
                        ON zu.client_id = tr.replier_id
                WHERE tr.ticket_id = :ticketId
                ", array(
                    ':ticketId' => $ticketId
                ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr2) {
                    if ($arr2['type'] == 'Admin') {
                        $arr2['user_id']    = 115243990634;
                    } else {
                        if (! $arr2['user_id']) {
                            $arr2['user_id']    = 115243990634;
                        }
                    }
                    $aComments[]  = array(
                        'author_id' => $arr2['user_id'],
                        'value'     => $arr2['body'],
                        'created_at'    => date('Y-m-d', strtotime($arr2['date'])),
                        'public'    => true
                    );
                }
            }
            
            $result     = $db->query("
                SELECT tr.*,
                    zu.user_id
                FROM hb_ticket_replies_archive tr
                    LEFT JOIN hb_zendesk_user zu
                        ON zu.client_id = tr.replier_id
                WHERE tr.ticket_id = :ticketId
                ", array(
                    ':ticketId' => $ticketId
                ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr2) {
                    if ($arr2['type'] == 'Admin') {
                        $arr2['user_id']    = 115243990634;
                    } else {
                        if (! $arr2['user_id']) {
                            $arr2['user_id']    = 115243990634;
                        }
                    }
                    $aComments[]  = array(
                        'author_id' => $arr2['user_id'],
                        'value'     => $arr2['body'],
                        'created_at'    => date('Y-m-d', strtotime($arr2['date'])),
                        'public'    => true
                    );
                }
            }
            
            $result     = $db->query("
                SELECT tn.*
                FROM hb_tickets_notes tn
                WHERE tn.ticket_id = :ticketId
                ", array(
                    ':ticketId' => $ticketId
                ))->fetchAll();
            
            if (count($result)) {
                foreach ($result as $arr2) {
                    $uid    = 115243990634;
                    $aComments[]  = array(
                        'author_id' => $uid,
                        'value'     => $arr2['note'] ."\nNote by: ". $arr2['name'] .' '. $arr2['email'],
                        'created_at'    => date('Y-m-d', strtotime($arr2['date'])),
                        'public'    => false
                    );
                }
            }
            
            
            if (! $zendeskTicketId) {
                $aParam     = array(
                    'ticket'    => array(
                        'created_at'    => $create,
                        'updated_at'    => $update,
                        'subject'       => $subject,
                        'description'   => $description,
                        'type'          => $type,
                        'requester_id'  => $userId,
                        'status'        => 'closed',
                        'tags'          => array('import_from_hostbill'),
                        'comments'      => $aComments
                    )
                );
                $data       = json_encode($aParam);
                
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, 'https://rvglobalsoft.zendesk.com/api/v2/imports/tickets.json');
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_USERPWD, 'prasit+rv@netway.co.th/token:rzkJaKdbWg2cptxaVZjsezCiIY8mxgrpG89kobAg');
                curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
                curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
                $data   = curl_exec($ch);
                curl_close($ch);
                $result = json_decode($data, true);
               
                echo '<p><pre>'. print_r($result, true) .'</pre></p>';
                
                $result = isset($result['ticket']) ? $result['ticket'] : array();

                $zendeskId      = isset($result['id']) ? $result['id'] : '';
            
            }
            
            if ($zendeskId) {
                $db->query("
                    UPDATE hb_zendesk_ticket
                    SET zendesk_ticket_id = :zendeskId,
                        sync_date = NOW()
                    WHERE ticket_id = :ticketId
                    ", array(
                        ':zendeskId'    => $zendeskId,
                        ':ticketId'     => $ticketId
                    ));
            }
            
            $aDatas[$ticketNum]     = $result;
            
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        if ($isReturn) {
            return $aDatas;
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/importticket.tpl',array(), true);
  
        
}
    
    
    

    //-----------------------------------------------------------------------------------------------------------------
    
    public function afterCall ($request)
    {
        $_SESSION['notification']   = array();
    }
}