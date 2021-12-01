<?php

class attachmenthandle_controller extends HBController {
    
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
        
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
        
    }
    
    public function isImage ($aAttachments)
    {
        $aAttachments_  = $aAttachments;
        
        if (! is_array($aAttachments_)) {
            return $aAttachments;
        }
        
        foreach ($aAttachments_ as $k => $arr) {
            if (! is_array($arr[0])) {
                continue;
            }
            foreach ($arr as $k2 => $arr2) {
                if (preg_match('/\.(jpeg|jpg|gif|png|bmp)/', $arr2['org_filename'])) {
                    $aAttachments[$k][$k2]['isImage']    = 1;
                }
            }
        }
        
        return $aAttachments;
    }
    
    public function image ($request)
    {
        $db         = hbm_db();
        
        $id         = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
                SELECT *
                FROM hb_tickets_attachments
                WHERE id = :id
                ", array(
                    ':id'   => $id
                ))->fetch();
        
        if (! isset($result['id'])) {
            $img    = imagecreatetruecolor(40, 40);
            header('Content-Type: image/jpeg');
            imagejpeg($img);
            imagedestroy($img);
            exit;
        }
        
        $filename   = $result['filename'];
        $imgPath    = dirname(APPDIR) .'/attachments/'. $filename;
        if (preg_match('/\.bmp/', $filename)) {
            $img    = @imagecreatefromwbmp($imgPath);
        } else if (preg_match('/\.png/', $filename)) {
            $img    = @imagecreatefrompng($imgPath);
        } else if (preg_match('/\.gif/', $filename)) {
            $img    = @imagecreatefromgif($imgPath);
        } else {
            $img    = @imagecreatefromjpeg($imgPath);
        }
        header('Content-Type: image/jpeg');
        imagejpeg($img);
        imagedestroy($img);
        exit;
    }
    
    public function afterCall ($request)
    {
        
    }
}