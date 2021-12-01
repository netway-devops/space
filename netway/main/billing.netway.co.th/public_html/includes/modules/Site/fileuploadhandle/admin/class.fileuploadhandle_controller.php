<?php

class fileuploadhandle_controller extends HBController {

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

        $type           = isset($request['type']) ? $request['type'] : '';
        
        if (! $type) {
            echo '<!-- {"ERROR":["ข้อมูล $type ไม่ถูกต้อง"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        if ($type == 'rack') {
            $fieldId        = isset($request['field_id']) ? $request['field_id'] : 0;
            $itemId         = isset($request['item_id']) ? $request['item_id'] : 0;
            $fileName       = isset($request['fileName']) ? $request['fileName'] : '';
            $delete         = isset($request['delete']) ? $request['delete'] : false;
            
            if ($fileName && is_file(MAINDIR . $fileName)) {
                @unlink(MAINDIR . $fileName);
            }
            
            $result         = $db->query("
                        SELECT
                            rifv.*
                        FROM
                            tb_rack_item_field_value rifv
                        WHERE
                            rifv.field_id = :fileId
                            AND rifv.item_id = :itemId
                            AND rifv.value != ''
                        ", array(
                            ':fileId'       => $fieldId,
                            ':itemId'       => $itemId
                        ))->fetch();
            
            if (isset($result['id']) && $delete) {
                $id                 = $result['id'];
                $fileName           = $result['value'];
                
                if ($fileName && is_file(MAINDIR . $fileName)) {
                    @unlink(MAINDIR . $fileName);
                }
                
                $db->query("
                        UPDATE
                            tb_rack_item_field_value
                        SET
                            value = ''
                        WHERE
                            id = :id
                        ", array(
                            ':id'           => $id
                        ));
                echo 'File '. $fileName .' is deleted.';
            }
            
            echo '<!-- {"ERROR":[],"INFO":["File '. $fileName .' is deleted."]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }

        
        echo '<!-- {"ERROR":["Can not delete file."],"INFO":[]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
    }
    
    /**
     * file upload
     */
    public function customfieldFileupload ($request)
    {
        $db     = hbm_db();
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $path           = isset($request['path']) ? $request['path'] : 'attachments';
        
        if (! $type) {
            echo '<!-- {"ERROR":["ข้อมูล $type ไม่ถูกต้อง"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        require_once( MAINDIR .'includes/modules/Site/supporthandle/libs/php.php');
        
        $uploadPath         = MAINDIR . $path . '/';
        $allowedExtensions  = array();
        $sizeLimit          = 20 * 1024 * 1024;
        
        $uploader           = new qqFileUploader($allowedExtensions, $sizeLimit);
        $result             = $uploader->handleUpload($uploadPath);
        
        if (isset($result['success']) && $result['success']) {
            $aUploadResult  = $result;
            $fileName       = $uploader->getUploadName();
            $aUploadResult['filename']  = $path .'/'. $fileName;
            
            if ($type == 'rack') {
                
                $fieldId        = isset($request['field_id']) ? $request['field_id'] : 0;
                $itemId         = isset($request['item_id']) ? $request['item_id'] : 0;
                
                $result         = $db->query("
                        SELECT
                            rifv.*
                        FROM
                            tb_rack_item_field_value rifv
                        WHERE
                            field_id = :fieldId
                            AND item_id = :itemId
                        ", array(
                            ':fieldId'      => $fieldId,
                            ':itemId'       => $itemId
                        ))->fetch();
                
                if (isset($result['id'])) {
                    $db->query("
                        UPDATE
                            tb_rack_item_field_value
                        SET
                            value = :fileName
                        WHERE
                            id = :id
                        ", array(
                            ':fileName'     => $path .'/'. $fileName,
                            ':id'           => $result['id']
                        ));
                    
                } else {
                    $db->query("
                        INSERT INTO tb_rack_item_field_value (
                            id, field_id, item_id, value
                        ) VALUES (
                            '', :fieldId, :itemId, :fileName
                        )
                        ", array(
                            ':fieldId'      => $fieldId,
                            ':itemId'       => $itemId,
                            ':fileName'     => $path .'/'. $fileName
                        ));
                    
                }
            }
            
            echo htmlspecialchars(json_encode($aUploadResult), ENT_NOQUOTES);
            
            echo '<!-- {"ERROR":[],"INFO":["Upload attachment file success"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        echo htmlspecialchars(json_encode($result), ENT_NOQUOTES);
        
        echo '<!-- {"ERROR":["Upload file error"],"INFO":[]'
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