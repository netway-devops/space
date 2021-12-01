<?php

class supporthandle_controller extends HBController {

    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    public function customfieldDeleteFile ($request)
    {
        $db     = hbm_db();
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        $aClient        = hbm_logged_client();
        $clientId       = isset($aClient['id']) ? $aClient['id'] : 0;
        
        $filename       = isset($request['filename']) ? $request['filename'] : '';
        
        $aFile          = explode('::', $filename);
        $fileId         = isset($aFile[0]) ? $aFile[0] : '';
        
        if ($clientId) {
            
            $result         = $db->query("
                        SELECT
                            d.*
                        FROM
                            hb_downloads d
                        WHERE
                            d.id = :fileId
                            AND d.client_id = :clientId
                        ", array(
                            ':fileId'       => $fileId,
                            ':clientId'     => $clientId
                        ))->fetch();
                        
        } else {
            
            $result         = $db->query("
                        SELECT
                            d.*
                        FROM
                            hb_downloads d
                        WHERE
                            d.id = :fileId
                            AND d.description = :description
                        ", array(
                            ':fileId'       => $fileId,
                            ':description'  => 'session_id:' . session_id()
                        ))->fetch();
                        
        }
        
        if (isset($result['id']) && $result['id']) {
            
            $clientId   = $result['client_id'];
            
            $aParam         = array(
                'call'          => 'deleteClientFile',
                'client_id'     => $clientId,
                'file_id'       => $fileId
            );
            $result         = $apiCustom->request($aParam);
            
            if (isset($result['success']) && $result['success']) {
                echo '<!-- {"ERROR":[],"INFO":["Delete file succes"]'
                    . ',"HTML":""'
                    . ',"STACK":0} -->';
                exit;
            }
        }

        echo '<!-- {"ERROR":["Can not delete file."],"INFO":[]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
    }
    
    /**
     * ให้ staff สามารถเพิ่ม note attachment ได้
     * @param unknown_type $request
     * @return unknown_type
     */
    public function customfieldFileupload ($request)
    {
        $db     = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        $aClient    = hbm_logged_client();
        // [XXX] ฝช้ account test ของเราที่ห้ามลบก่อน 1
        $clientId   = isset($aClient['id']) ? $aClient['id'] : 1;
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $configId       = isset($request['configId']) ? $request['configId'] : 0;
        
        $allowedAttachmentExt   = ConfigCustom::singleton()->getValue('AllowedAttachmentExt');
        $maxAttachmentSize      = ConfigCustom::singleton()->getValue('MaxAttachmentSize');
        
        require_once( dirname(dirname(__FILE__)) .'/libs/php.php');
        
        $uploadPath         = HOSTBILL_ATTACHMENT_DIR;
        $allowedExtensions  = explode(';.', 'xxx;' . $allowedAttachmentExt);
        $sizeLimit          = $maxAttachmentSize * 1024 * 1024;
        
        $uploader           = new qqFileUploader($allowedExtensions, $sizeLimit);
        $result             = $uploader->handleUpload($uploadPath);
        
        
        
        if (isset($result['success']) && $result['success']) {
            $aUploadResult  = $result;
            $fileName       = $uploader->getUploadName();
            $dataBase64     = base64_encode(file_get_contents($uploadPath . $fileName));
            
            $aParam         = array(
                'call'          => 'addClientFile',
                'client_id'     => $clientId,
                'data'          => $dataBase64,
                'name'          => $fileName,
                'filename'      => $fileName
            );
            $result         = $apiCustom->request($aParam);
            
            if (isset($result['file_id']) && $result['file_id']) {
                $fileId     = $result['file_id'];
                
                $db->query("
                    UPDATE
                        hb_downloads
                    SET
                        description = :description
                    WHERE
                        id = :fileId
                    ", array(
                        ':fileId'       => $fileId,
                        ':description'  => 'session_id:' . session_id()
                    ));
                
                $result     = $db->query("
                        SELECT
                            d.*
                        FROM
                            hb_downloads d
                        WHERE
                            d.id = :fileId
                        ", array(
                            ':fileId'   => $fileId
                        ))->fetch();
                if (isset($result['id']) && $result['id']) {
                    
                    $aUploadResult['filename']  = $fileId .'::'. $result['filename'];
                    
                    if ($type && $accountId && $configId) {
                            
                        $result             = array();
                        
                        if ($type == 'Domain') {
                            $result         = $db->query("
                                    SELECT
                                        d.id
                                    FROM
                                        hb_domains d
                                    WHERE
                                        d.id = :accountId
                                        AND d.client_id = :clientId
                                    ", array(
                                        ':accountId'        => $accountId,
                                        ':clientId'         => $clientId
                                    ))->fetch();
                        }
                        if ($type == 'Hosting') {
                            $result         = $db->query("
                                    SELECT
                                        a.id
                                    FROM
                                        hb_accounts a
                                    WHERE
                                        a.id = :accountId
                                        AND a.client_id = :clientId
                                    ", array(
                                        ':accountId'        => $accountId,
                                        ':clientId'         => $clientId
                                    ))->fetch();
                        }
                        
                        if (isset($result['id']) && $result['id']) {
                            $db->query("
                                UPDATE
                                    hb_config2accounts
                                SET 
                                    data = :data
                                WHERE
                                    rel_type = :type
                                    AND account_id  = :accountId
                                    AND config_id = :configId
                                ", array(
                                    ':data'         => $aUploadResult['filename'],
                                    ':type'         => $type,
                                    ':accountId'    => $accountId,
                                    ':configId'     => $configId
                                ));
                        }
                        
                    }
                    
                    echo htmlspecialchars(json_encode($aUploadResult), ENT_NOQUOTES);
                    
                    echo '<!-- {"ERROR":[],"INFO":["Upload attachment file success"]'
                        . ',"STACK":0} -->';
                    exit;
                }
                
            }
        }
        
        echo htmlspecialchars(json_encode($result), ENT_NOQUOTES);
            
        echo '<!-- {"ERROR":["Upload attachment file error"],"INFO":[]'
            . ',"STACK":0} -->';
        exit;
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function afterCall ($request)
    {
        
    }
}