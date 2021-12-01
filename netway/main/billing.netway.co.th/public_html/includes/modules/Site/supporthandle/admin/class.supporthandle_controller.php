<?php

require_once(APPDIR .'class.cache.extend.php');

class supporthandle_controller extends HBController {
    
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
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    public function view ($request)
    {
        $db     = hbm_db();
        
        $id     = isset($request['id']) ? $request['id'] : 0;
        $type   = isset($request['type']) ? $request['type'] : 'ticket';
        $as     = isset($request['as']) ? $request['as'] : '';
        $charset= isset($request['charset']) ? $request['charset'] : 'UTF-8';
        
        if (! $id) {
            echo 'Invalid Id';
            exit;
        }
        
        $message        = '';
        if ($type == 'ticket') {
            $result     = $db->query("
                        SELECT
                            t.body
                        FROM
                            hb_tickets t
                        WHERE
                            t.id = :ticketId
                        ", array(
                            ':ticketId'     => $id
                        ))->fetch();
                        
            if (isset($result['body'])) {
                $message    = $result['body'];
            }
        } elseif ($type == 'reply') {
            $result     = $db->query("
                        SELECT
                            tr.body
                        FROM
                            hb_ticket_replies tr
                        WHERE
                            tr.id = :replyId
                        ", array(
                            ':replyId'     => $id
                        ))->fetch();
                        
            if (isset($result['body'])) {
                $message    = $result['body'];
            }
        }
        
        switch ($as) {
            case 'livehtml' : {
                    header ('Content-type: text/html; charset=utf-8'); 
                    echo htmlspecialchars_decode($message);
                }
                break;
            case 'plaintext' : {
                    header ('Content-type: text/html; charset=utf-8'); 
                    echo nl2br($message);
                }
                break;
            case 'decode' : {
                    header ('Content-type: text/html; charset=utf-8');
                    $message    = base64_decode(trim($message));
                    $message    = iconv($charset, 'UTF-8//IGNORE', $message);
                    echo nl2br($message);
                }
                break;
            default         :
                echo $message;
        }
        
        exit;
    }

    public function search ($request)
    {
        $db         = hbm_db();
        
        $keyword    = isset($request['keyword']) ? $request['keyword'] : '';
        $reload     = isset($request['reload']) ? $request['reload'] : 0;
        unset($request['reload']);
        
        if (! $keyword) {
            $this->template->assign('nodata', 1);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.search_result.tpl', array(), true);
            exit;
        }
        
        $ticketId   = trim($keyword, '#');
        
        $cacheKey   = md5(serialize($request).'-id');
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null || $reload) {
            $result     = $db->query("
                    SELECT *
                    FROM hb_tickets
                    WHERE id = :ticketId
                        OR ticket_number = :ticketId
                    ", array(
                        ':ticketId' => $ticketId
                    ))->fetch();
            $result     = count($result) ? $result : array('name'=>'Not found');
            CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
        } else {
            $this->template->assign('isCache', 1);
        }
        
        $this->template->assign('aTicket', $result);
        
        $cacheKey   = md5(serialize($request));
        $result     = CacheExtend::singleton()->get($cacheKey);
        if ($result == null || $reload) {
            $result     = $db->query("
                    SELECT t.*
                    FROM hb_tickets t
                    WHERE t.name LIKE '%{$keyword}%'
                        OR t.email LIKE '%{$keyword}%'
                        OR t.subject LIKE '%{$keyword}%'
                        OR t.body LIKE '%{$keyword}%'
                    ORDER BY t.id DESC
                    LIMIT 0, 25
                    ")->fetchAll();
            $result     = count($result) ? $result : array(array('name'=>'Not found'));
            CacheExtend::singleton()->set($cacheKey, $result, 3600*3);
        } else {
            $this->template->assign('isCache', 1);
        }
        
        $this->template->assign('aTickets', $result);
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.search_result.tpl', array(), true);
    }
    
    public function unassign ($request)
    {
        $db     = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        if (! $ticketId) {
            echo '<!-- {"ERROR":["Invalid ticket Id."],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }
        
        $aAdmin = hbm_logged_admin();
        
        $result     = $db->query("
                    SELECT 
                        t.id, t.owner_id
                    FROM
                        hb_tickets t
                    WHERE
                        t.id = :ticketId
                        AND t.owner_id = :ownerId
                    ", array(
                        ':ticketId'     => $ticketId,
                        ':ownerId'      => $aAdmin['id']
                    ))->fetch();
                    
        if (! isset($result['id']) || ! $result['id']) {
            echo '<!-- {"ERROR":["Invalid ticket verify owner Id."],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
            UPDATE 
                hb_tickets
            SET 
                owner_id = 0
            WHERE 
                id = :ticketId
            LIMIT 1
            ", array(
                ':ticketId' => $ticketId
            ));
        
        /* --- unassign staff ออกด้วย ---*/
        $result         = $db->query("
                SELECT
                    t.*
                FROM
                    hb_tickets_tags tt,
                    hb_tags t
                WHERE
                    tt.ticket_id = :ticketId
                    AND tt.tag_id = t.id
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetchAll();
        
        if (count($result)) {
            $aTags      = $result;
            
            foreach ($aTags as $arr) {
                if (! $arr['tag']) {
                    continue;
                }
                
                $tagId          = $arr['id'];
                $tag            = substr($arr['tag'], 1);
                
                $result         = $db->query("
                        SELECT
                            aa.id
                        FROM
                            hb_admin_access aa
                        WHERE
                            aa.username LIKE :tag
                        ", array(
                            ':tag'      => $tag . '@%'
                        ))->fetch();
                        
                if (isset($result['id']) && $result['id']) {
                    $db->query("
                        DELETE FROM hb_tickets_tags 
                        WHERE
                            ticket_id = :ticketId
                            AND tag_id = :tagId
                        LIMIT 1
                        ", array(
                            ':ticketId'     => $ticketId,
                            ':tagId'     => $tagId
                        ));
                    
                    /* --- unsubscrbe all --- */
                    $db->query("
                        DELETE FROM hb_ticket_subscriptions 
                        WHERE
                            ticket_id = :ticketId
                        ", array(
                            ':ticketId'     => $ticketId
                        ));
                    
                }
            }
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Unassign staff from ticket success"]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function unassignMyTag ($request)
    {
        $db     = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $ownerId        = isset($request['ownerId']) ? $request['ownerId'] : 0;
        
        $result         = $db->query("
                SELECT
                    aa.id, aa.username
                FROM
                    hb_admin_access aa
                WHERE
                    aa.id = :ownerId
                ", array(
                    ':ownerId'      => $ownerId
                ))->fetch();
        
        if (! isset($result['id']) || ! $result['id']) {
            echo '<!-- {"ERROR":["Invalid verify admin Id."],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }
        
        $pos        = strpos($result['username'], '@');
        $tag        = '@'. substr($result['username'],0,$pos);
        
        $result         = $db->query("
                SELECT
                    t.id
                FROM
                    hb_tags t
                WHERE
                    t.tag = :tag
                ", array(
                    ':tag'      => $tag
                ))->fetch();
        
        if (! isset($result['id']) || ! $result['id']) {
            echo '<!-- {"ERROR":["Invalid tag '. $tag .' id."],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }
        
        $tagId      = $result['id'];
        
        $db->query("
            DELETE FROM hb_tickets_tags
            WHERE
                tag_id = :tagId
                AND ticket_id = :ticketId
            LIMIT 1
            ", array(
                ':ticketId'     => $ticketId,
                ':tagId'        => $tagId
            ));
        
        /* --- unsubscribe -- */
        $db->query("
            DELETE FROM hb_ticket_subscriptions
            WHERE
                admin_id = :adminId
                AND ticket_id = :ticketId
            LIMIT 1
            ", array(
                ':adminId'      => $ownerId,
                ':ticketId'     => $ticketId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Remove owner tag from ticket success"]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function lastreply ($request)
    {
        $db     = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result     = $db->query("
                    SELECT 
                        t.id, t.ticket_number
                    FROM
                        hb_tickets t
                    WHERE
                        t.id = :ticketId
                    ", array(
                        ':ticketId'     => $ticketId
                    ))->fetch();
        
        if (isset($result['id'])) {
            $_SESSION['ticketLastReply']    = $result['ticket_number'];
        }
        exit;
    }
    
    public function deleteattachment ($request)
    {
        $db     = hbm_db();
        
        $attachmentId   = isset($request['id']) ? $request['id'] : 0;
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $ticketNoteId   = isset($request['ticketNoteId']) ? $request['ticketNoteId'] : 0;
        
        if ($ticketNoteId) {
            $db->query("
                DELETE FROM 
                    hb_tickets_notes
                WHERE 
                    id = :ticketNoteId
                    AND ticket_id = :ticketId
                ", array(
                    ':ticketNoteId'  => $ticketNoteId,
                    ':ticketId'      => $ticketId
                ));
        }
        
        $result     = $db->query("
                    SELECT 
                        ta.id, ta.filename
                    FROM
                        hb_tickets_attachments ta
                    WHERE
                        ta.id = :attachmentId
                        AND ta.ticket_id = :ticketId
                    ", array(
                        ':attachmentId'  => $attachmentId,
                        ':ticketId'      => $ticketId
                    ))->fetch();
                    
        if (! isset($result['id']) || ! $result['id']) {
            echo '<!-- {"ERROR":["Invalid attachment Id."],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }
        
        if ($result['filename']) {
            @unlink(MAINDIR . 'attachments/' . $result['filename']);
        }
        
        $db->query("
            DELETE FROM 
                hb_tickets_attachments
            WHERE 
                id = :attachmentId
                AND ticket_id = :ticketId
            ", array(
                ':attachmentId'  => $attachmentId,
                ':ticketId'      => $ticketId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Delete attachment file succes"]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
    }

    public function deleteNote ($request)
    {
        $db     = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $ticketNoteId   = isset($request['ticketNoteId']) ? $request['ticketNoteId'] : 0;
        
        $db->query("
            UPDATE
                hb_tickets_notes
            SET
                note = CONCAT('<strike>',note,'</strike>')
            WHERE 
                id = :ticketNoteId
            ", array(
                ':ticketNoteId'  => $ticketNoteId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Cancel comment successfully"]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
    }
    
    /**
     * ให้ staff สามารถเพิ่ม note attachment ได้
     * @param unknown_type $request
     * @return unknown_type
     */
    public function addnoteattachment ($request)
    {
        $db     = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $allowedAttachmentExt   = ConfigCustom::singleton()->getValue('AllowedAttachmentExt');
        $maxAttachmentSize      = ConfigCustom::singleton()->getValue('MaxAttachmentSize');
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        require_once( dirname(dirname(__FILE__)) .'/libs/php.php');
        
        $uploadPath         = MAINDIR . 'attachments/';
        $allowedExtensions  = explode(';.', 'xxx;' . $allowedAttachmentExt);
        $sizeLimit          = $maxAttachmentSize * 1024 * 1024;
        
        $uploader           = new qqFileUploader($allowedExtensions, $sizeLimit);
        $result             = $uploader->handleUpload($uploadPath);
        
        echo htmlspecialchars(json_encode($result), ENT_NOQUOTES);
        
        if (isset($result['success']) && $result['success']) {
            $fileName       = $uploader->getUploadName();
            
            $db->query("
                INSERT INTO hb_tickets_attachments (
                    id, ticket_id, rel_id, filename, type, is_staff_only
                ) VALUES (
                    null, :ticketId, '0', :fileName, :fileType, '1'
                )
            ", array(
                ':ticketId'     => $ticketId,
                ':fileName'     => $fileName,
                ':fileType'     => substr($fileName, strrpos($fileName, '.'))
            ));
            
            $result     = $db->query("
                    SELECT 
                        MAX(id) AS id
                    FROM
                        hb_tickets_attachments
                    ")->fetch();
            
            if (isset($result['id'])) {
                $attachmentId   = $result['id'];
                $aAdmin         = hbm_logged_admin();

                $db->query("
                    INSERT INTO hb_tickets_notes (
                        id, ticket_id, admin_id, name, email, date, note
                    ) VALUES (
                        null, :ticketId, :adminId, :name, :email, :addDate, ''
                    )
                ", array(
                    ':ticketId'     => $ticketId,
                    ':adminId'      => $aAdmin['id'],
                    ':name'         => $aAdmin['firstname'] . ' ' . $aAdmin['lastname'],
                    ':email'        => $aAdmin['email'],
                    ':addDate'      => date('Y-m-d H:i:s')
                ));
                
                $result     = $db->query("
                        SELECT 
                            MAX(id) AS id
                        FROM
                            hb_tickets_notes
                        ")->fetch();
                if (isset($result['id'])) {
                    $noteId     = $result['id'];
                    
                    // อย่าแก้โครงสร้าง html และ id และ class เพราะเอาไปใช้ใน jquery
                    $note       = '<div class="attachment"><a href="?action=download&id='. $attachmentId .'">Attachment: '. $fileName .'</a>&nbsp;&nbsp;&nbsp;<a class="delbtn" style="display: inline; padding-left: 12px;" onclick=" if (confirm(\'Are you sure you want to delete this attrachment file?\')) deleteAttachmentFile(this); return false;" href="?cmd=supporthandle&action=deleteattachment&ticketId='. $ticketId .'&id='. $attachmentId .'&ticketNoteId='. $noteId .'">Delete</a></div>';
                    $db->query("
                    UPDATE
                        hb_tickets_notes
                    SET
                        note = :note
                    WHERE
                        id = :noteId
                    ", array(
                        ':note'     => $note,
                        ':noteId'   => $noteId
                    ));
                    
                }
                
                echo '<!-- {"ERROR":[],"INFO":["Upload attachment file success"]'
                    . ',"STACK":0} -->';
                exit;
            }
        }
            
        echo '<!-- {"ERROR":["Upload attachment file error"],"INFO":[]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function updateschedule ($request)
    {
        $db     = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $scheduleDate   = isset($request['scheduleDate']) ? $request['scheduleDate'] : '';
        
        $scheduleDate   = self::_convertStrtotime($scheduleDate);
        if (! $ticketId || !$scheduleDate) {
            echo '<!-- {"ERROR":["Invalid ticket id or schedule date."],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
            UPDATE 
                hb_tickets
            SET 
                scheduled_date = :scheduleDate
            WHERE 
                id = :ticketId
            LIMIT 1
            ", array(
                ':scheduleDate'     => date('Y-m-d', $scheduleDate),
                ':ticketId'         => $ticketId
            ));
        
        echo '<!-- {"ERROR":[],"INFO":["Update schedule succes"]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
        
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
    public function updatetickettitle ($request)
    {
        $db     = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $subject        = isset($request['subject']) ? $request['subject'] : '';
        
        if ($subject) {
            $db->query("
                UPDATE 
                    hb_tickets
                SET 
                    subject = :subject
                WHERE 
                    id = :ticketId
                LIMIT 1
                ", array(
                    ':subject'      => $subject,
                    ':ticketId'     => $ticketId
                ));
        }
        
        echo '<!-- {"ERROR":[],"INFO":["Update ticket subject succes"]'
            . ',"HTML":""'
            . ',"STACK":0} -->';
        exit;
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
        
        $filename       = isset($request['filename']) ? $request['filename'] : '';
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $configId       = isset($request['configId']) ? $request['configId'] : 0;
        
        $aFile          = explode('::', $filename);
        $fileId         = isset($aFile[0]) ? $aFile[0] : '';
        
        $result         = $db->query("
                    SELECT
                        d.*
                    FROM
                        hb_downloads d
                    WHERE
                        d.id = :fileId
                    ", array(
                        ':fileId'       => $fileId
                    ))->fetch();
        
        $clientId       = (isset($result['client_id']) && $result['client_id']) ? $result['client_id'] : 0;
        
        if ($clientId) {
            
            $aParam         = array(
                'call'          => 'deleteClientFile',
                'client_id'     => $clientId,
                'file_id'       => $fileId
            );
            $result         = $apiCustom->request($aParam);
            
            if (isset($result['success']) && $result['success']) {
                
                if ($type && $accountId && $configId) {
                    $db->query("
                        UPDATE
                            hb_config2accounts
                        SET 
                            data = ''
                        WHERE
                            rel_type = :type
                            AND account_id  = :accountId
                            AND config_id = :configId
                        ", array(
                            ':type'         => $type,
                            ':accountId'    => $accountId,
                            ':configId'     => $configId
                        ));
                }
                
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
        
        $type           = isset($request['type']) ? $request['type'] : '';
        $accountId      = isset($request['accountId']) ? $request['accountId'] : 0;
        $catId          = isset($request['catId']) ? $request['catId'] : 0;
        $configId       = isset($request['configId']) ? $request['configId'] : 0;
        
        if ($type == 'Domain') {
            $result         = $db->query("
                    SELECT
                        d.id, d.client_id
                    FROM
                        hb_domains d
                    WHERE
                        d.id = :accountId
                    ", array(
                        ':accountId'        => $accountId
                    ))->fetch();
        }
        if ($type == 'Hosting') {
            $result         = $db->query("
                    SELECT
                        a.id, a.client_id
                    FROM
                        hb_accounts a
                    WHERE
                        a.id = :accountId
                    ", array(
                        ':accountId'        => $accountId
                    ))->fetch();
        }
        
        $clientId           = (isset($result['client_id']) && $result['client_id']) ? $result['client_id'] : 0;
        
        if (! $clientId) {
            echo '<!-- {"ERROR":["ข้อมูล client id ไม่ถูกต้อง"],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
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
    
    /**
     * แสดงรายการ ticket เฉพาะที่เป็น open และ client reply
     */
    public function ticketOpenAndClientReply ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();
        
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $assigned       = isset($request['assigned']) ? $request['assigned'] : '';
        $currentdept    = isset($request['currentdept']) ? $request['currentdept'] : '';
        $myTag          = '@' . substr($aAdmin['username'],0, strpos($aAdmin['username'], '@'));
        
        if ($currentdept == 'all') {
            $currentdept    = '';
        }
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE t.tag = :tag
                ", array(
                    ':tag'      => $myTag
                ))->fetch();
        $tagId          = isset($result['id']) ? $result['id'] : 0;
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE t.tag = 'spam'
                ")->fetch();
        $spamTagId      = isset($result['id']) ? $result['id'] : 0;
        
        $total          = 0;
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN hb_tickets_tags tt2 ON (tt2.ticket_id = t.id AND tt2.tag_id = {$spamTagId})
                    ". (($tagId) ? " LEFT JOIN hb_tickets_tags tt ON (tt.ticket_id = t.id AND tt.tag_id = {$tagId}) " : "") ."
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id
                WHERE d.assigned_admins LIKE '%$". $aAdmin['id'] ."$%' 
                    ". (($assigned) ? (($tagId) ? " AND ( t.owner_id = '". $aAdmin['id'] ."' OR tt.ticket_id IS NOT NULL ) " : " AND t.owner_id = '". $aAdmin['id'] ."' " ) : "") ."
                    ". (($currentdept) ? " AND t.dept_id IN (". $currentdept .") " : "") ."
                    AND tt2.ticket_id IS NULL
                    AND t.status IN ('Open', 'Client-Reply') AND !(s.options & 4)  
                GROUP BY 
                    t.id
                ORDER BY 
                    t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        if (!$total) {
            return $aTickets;
        }
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        $aResult            = self::_ticketTagAppendToList($aResult);
        
        $aTickets['result']     = $aResult;
        
        return $aTickets;
    }
    
    public function myFulfillmentTicket ($request)
    {
    	$db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $assigned       = isset($request['assigned']) ? $request['assigned'] : '';
        $myTag          = '@' . substr($aAdmin['username'], 0, strpos($aAdmin['username'], '@'));
        $listall        = isset($request['listall']) ? $request['listall'] : false;
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE t.tag = :tag
                ", array(
                    ':tag'      => $myTag
                ))->fetch();
        $tagId          = isset($result['id']) ? $result['id'] : 0;
        
        if ($listall){
            $tagId      = 0;
        }
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE t.tag = 'spam'
                ")->fetch();
        $spamTagId      = isset($result['id']) ? $result['id'] : 0;
        
        $total          = 0;
		
		$sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM sc_ticket_2_request t2r LEFT JOIN hb_tickets t ON(t2r.ticket_id = t.id)
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN hb_tickets_tags tt2 ON (tt2.ticket_id = t.id AND tt2.tag_id = {$spamTagId})
                    ". (($tagId) ? " LEFT JOIN hb_tickets_tags tt ON (tt.ticket_id = t.id AND tt.tag_id = {$tagId}) " : "") ."
                WHERE t2r.is_fulfillment = 1
                    ". ($listall ? "" : " AND d.assigned_admins LIKE '%$". $aAdmin['id'] ."$%' ") ."
                    ". (($assigned) ? (($tagId) ? " AND ( t.owner_id = '". $aAdmin['id'] ."' OR tt.ticket_id IS NOT NULL ) " : " AND t.owner_id = '". $aAdmin['id'] ."' " ) : "") ."
                    AND tt2.ticket_id IS NULL
                    AND t.status <> 'Closed'
                GROUP BY 
                    t.id
                ORDER BY 
                    t.priority DESC, t.lastreply DESC
                ";
                
    	$result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        if (!$total) {
            return $aTickets;
        }
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        $aResult            = self::_ticketTagAppendToList($aResult);
        
        $aTickets['result']     = $aResult;

        if ($aResult['total']) {
            $aTickets['total']      = $aTickets['total'] + $aResult['total'];
            foreach ($aResult['result'] as $arr) {
                array_push($aTickets['result'], $arr);
            }
        }
        
        return $aTickets;
    }
    
    public function allFulfillmentTicket ($request)
    {
        $request['listall'] = true;
        return self::myFulfillmentTicket($request);
    }

    public function myTicketInprogress ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();

        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $assigned       = isset($request['assigned']) ? $request['assigned'] : '';
        $myTag          = '@' . substr($aAdmin['username'],0, strpos($aAdmin['username'], '@'));
        
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE t.tag = :tag
                ", array(
                    ':tag'      => $myTag
                ))->fetch();
        $tagId          = isset($result['id']) ? $result['id'] : 0;
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE t.tag = 'spam'
                ")->fetch();
        $spamTagId      = isset($result['id']) ? $result['id'] : 0;
        
        $total          = 0;
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN hb_tickets_tags tt2 ON (tt2.ticket_id = t.id AND tt2.tag_id = {$spamTagId})
                    ". (($tagId) ? " LEFT JOIN hb_tickets_tags tt ON (tt.ticket_id = t.id AND tt.tag_id = {$tagId}) " : "") ."
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id
                WHERE d.assigned_admins LIKE '%$". $aAdmin['id'] ."$%' 
                    ". (($assigned) ? (($tagId) ? " AND ( t.owner_id = '". $aAdmin['id'] ."' OR tt.ticket_id IS NOT NULL ) " : " AND t.owner_id = '". $aAdmin['id'] ."' " ) : "") ."
                    AND tt2.ticket_id IS NULL
                    AND t.status = 'In-Progress' AND !(s.options & 4)  
                GROUP BY 
                    t.id
                ORDER BY 
                    t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        if (!$total) {
            return $aTickets;
        }
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        $aResult            = self::_ticketTagAppendToList($aResult);
        
        $aTickets['result']     = $aResult;
        
        /* --- เพิ่ม inprogress สำหรับ ticket ที่ตัวเองถูก tag เข้าไปด้วย --- */
        // $aResult            = self::myTicketCoWorker(array('status' => '\'In-Progress\''));
        
        if ($aResult['total']) {
            $aTickets['total']      = $aTickets['total'] + $aResult['total'];
            foreach ($aResult['result'] as $arr) {
                array_push($aTickets['result'], $arr);
            }
        }
        
        
        return $aTickets;
    }

    public function unassignTicket ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $team           = isset($request['team']) ? $request['team'] : '';
        
        if ($currentdept == 'all') {
            $currentdept    = '';
        }
        
        $aStaffTag      = array();
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE (t.tag = 'spam'
                    OR t.tag LIKE '@%' )
                ")->fetchAll();
        foreach ($result as $arr) {
            array_push($aStaffTag, $arr['id']);
        }
        
        $total          = 0;
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN hb_tickets_tags tt2 ON (tt2.ticket_id = t.id AND tt2.tag_id IN (". implode(',', $aStaffTag) ."))
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id
                WHERE 
                    t.owner_id = 0
                    ". (($team == 'Helpdesk') ? '  ' : ' /*AND t.escalated > 0*/ ') ."
                    AND tt2.ticket_id IS NULL
                    AND t.status IN ('Open', 'Client-Reply', 'In-Progress') AND !(s.options & 4)  
                GROUP BY 
                    t.id
                ORDER BY 
                    t.escalated DESC,t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        if (!$total) {
            return $aTickets;
        }
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        $aResult            = self::_ticketTagAppendToList($aResult);
        
        $aTickets['result']     = $aResult;
        
        return $aTickets;
    }
    
    public function myTicketCoWorker ($request)
    {
        $db             = hbm_db();
        
        $oAdmin         = (object) hbm_logged_admin();
        
        $aTickets       = array();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 1000;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $status         = isset($request['status']) ? $request['status'] : '\'Open\',\'Client-Reply\'';
        
        $total          = 0;
        
        $tagName        = '@' . substr($oAdmin->username, 0, strpos($oAdmin->username, '@'));
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_tickets_tags ttg ON ttg.ticket_id=t.id
                    LEFT JOIN hb_tags tg ON tg.id=ttg.tag_id
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id
                WHERE
                    t.owner_id != {$oAdmin->id}
                    AND t.id IN (
                        SELECT 
                            ttg.ticket_id 
                        FROM 
                            hb_tickets_tags ttg 
                            JOIN hb_tags tg ON tg.id=ttg.tag_id 
                        WHERE 
                            tg.tag IN ('{$tagName}') 
                        GROUP BY 
                            ttg.ticket_id
                    )
                    AND t.status IN ({$status}) 
                    AND !(s.options & 4)  
                GROUP BY 
                    t.id
                ORDER BY 
                    t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        if (!$total) {
            return $aTickets;
        }
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        
        foreach ($result as $k => $arr) {
            $aResult[$k]['tags']    = array();
        }
        
        $aTickets['result']     = $aResult;
        
        return $aTickets;
    }

    private function _ticketTagAppendToList ($aTicketLists)
    {
        $db                 = hbm_db();

        if (! count($aTicketLists)) {
            return $aTicketLists;
        } 
        
        $aTicketLists_temp  = $aTicketLists;
        
        foreach ($aTicketLists_temp as $k => $arr) {
            
            $result         = $db->query("
                        SELECT 
                            tag.id, tag.tag, COUNT(tic.tag_id) `usage` 
                        FROM 
                            hb_tags tag
                            JOIN hb_tickets_tags tic ON tic.tag_id=tag.id
                            JOIN hb_tickets_tags tig ON tig.tag_id=tag.id
                        WHERE 
                            tig.ticket_id = :ticketId
                        GROUP BY tag.id 
                        ORDER BY `usage` DESC
                        ", array(
                            ':ticketId'     => $arr['id']
                        ))->fetchAll();
            
            if (count($result)) {
                $aTicketLists[$k]['tags']    = $result;
            } else {
                $aTicketLists[$k]['tags']   = array();
            }
            
        }
        
        return $aTicketLists;
    }

    public function myTicketSchedule ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();

        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $assigned       = isset($request['assigned']) ? $request['assigned'] : '';
        
        $total          = 0;
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id
                WHERE d.assigned_admins LIKE '%$". $aAdmin['id'] ."$%' 
                    ". (($assigned) ? " AND t.owner_id = '". $aAdmin['id'] ."' " : "") ."
                    AND t.status = 'Scheduled' AND !(s.options & 4)  
                GROUP BY 
                    t.id
                ORDER BY 
                    t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        return $aTickets;
    }
    
    public function allChnageManagementTicket ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();

        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        
        $total          = 0;
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id,
                    ch_request cr
                WHERE t.status != 'closed' AND !(s.options & 4)
                    AND t.id = cr.ticket_id
                GROUP BY 
                    t.id
                ORDER BY 
                    t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        if (!$total) {
            return $aTickets;
        }
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        
        foreach ($result as $k => $arr) {
            $aResult[$k]['tags']    = array();
        }
        
        $aTickets['result']     = $aResult;
        
        return $aTickets;
    }
    
    public function allProblemManagementTicket ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();

        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        
        $total          = 0;
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id,
                    problem_request pr
                WHERE t.status != 'closed' AND !(s.options & 4)
                    AND t.id = pr.ticket_id
                GROUP BY 
                    t.id
                ORDER BY 
                    t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    COUNT(x.id) AS total
                FROM
                    ({$sql}) x
                WHERE
                1
                ")->fetch();
                
        $total                  = isset($result['total']) ? $result['total'] : 0;
        $aTickets['total']      = $total;
        
        if (!$total) {
            return $aTickets;
        }
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        
        foreach ($result as $k => $arr) {
            $aResult[$k]['tags']    = array();
        }
        
        $aTickets['result']     = $aResult;
        
        return $aTickets;
    }
    
    public function assignedTicket ($request)
    {
        $db             = hbm_db();
        
        $aAdmin         = hbm_logged_admin();
        
        $aTickets       = array();
        
        $limit          = isset($request['limit']) ? $request['limit'] : 25;
        $offset         = isset($request['offset']) ? $request['offset'] : 0;
        $myTag          = '@' . substr($aAdmin['username'],0, strpos($aAdmin['username'], '@'));
        
        $aStaffTag      = array();
        $result         = $db->query("
                SELECT t.*
                FROM hb_tags t
                WHERE t.tag != '{$myTag}'
                    AND t.tag LIKE '@%'
                ")->fetchAll();
        foreach ($result as $arr) {
            array_push($aStaffTag, $arr['id']);
        }
        
        $sql            = "
                SELECT DISTINCT t.admin_read, t.id, t.type, 
                    cl.firstname, cl.lastname, 
                    t.date, t.lastreply, t.dept_id, t.name, t.client_id, t.status, t.ticket_number, 
                    CONCAT('#',t.ticket_number,' - ',t.subject) AS tsubject, d.name as deptname, 
                    t.priority, t.flags, t.escalated,
                    t.tags,
                    COALESCE(rp.name ,t.name) as rpname,
                    s.color as status_color,
                    t2r.request_type, t2r.is_fulfillment
                FROM hb_tickets t 
                    JOIN hb_ticket_departments d ON (t.dept_id=d.id) 
                    LEFT JOIN `hb_ticket_replies` rp ON ( rp.ticket_id = t.id AND t.lastreply = rp.date)
                    LEFT JOIN `hb_client_details` cl ON (cl.id = t.client_id) 
                    LEFT JOIN hb_ticket_status s ON s.status=t.status
                    LEFT JOIN hb_tickets_tags tt2 ON (tt2.ticket_id = t.id AND tt2.tag_id IN (". implode(',', $aStaffTag) ."))
                    LEFT JOIN sc_ticket_2_request t2r ON t2r.ticket_id = t.id
                WHERE 
                    t.owner_id != ". $aAdmin['id'] ."
                    AND (
                        ( t.owner_id = 0 AND tt2.ticket_id IS NOT NULL )
                        OR 
                        ( t.owner_id != 0 )
                        )
                    AND t.status IN ('Open', 'Client-Reply') AND !(s.options & 4)  
                GROUP BY 
                    t.id
                ORDER BY 
                    t.escalated DESC,t.priority DESC, t.lastreply DESC
                ";
        
        $result         = $db->query("
                SELECT
                    x.*
                FROM
                    ({$sql}) x
                WHERE
                1
                LIMIT {$offset}, {$limit} 
                ")->fetchAll();
        
        $aResult            = $result;
        $aResult            = self::_ticketTagAppendToList($aResult);
        
        $aTickets['result']     = $aResult;
        
        return $aTickets;
    }

    public function addViewToDashboard ($request)
    {
        $db             = hbm_db();
        
        $oAdmin         = (object) hbm_logged_admin();
        
        $view           = isset($request['view']) ? substr($request['view'], 1) : '';
        
        parse_str($view, $parseUrl);
        
        $viewId         = $parseUrl['tview'];
        
        if (! $viewId) {
            echo '<!-- {"ERROR":["Invalid view id."],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $result         = $db->query("
                SELECT
                    td.id
                FROM
                    hb_ticket_dashboard td
                WHERE
                    admin_id = :adminId
                    AND view_id = :viewId
                ", array(
                    ':adminId'      => $oAdmin->id,
                    ':viewId'       => $viewId
                ))->fetch();
        
        $id             = isset($result['id']) ? $result['id'] : '';
        
        $db->query("
            REPLACE INTO hb_ticket_dashboard (
                id, admin_id, view_id, sorter
            ) VALUES (
                :id, :adminId, :viewId, :sorter
            )
            ", array(
                ':id'       => $id,
                ':adminId'  => $oAdmin->id,
                ':viewId'   => $viewId,
                ':sorter'   => time()
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["View id#'. $viewId .' has been add to dashboard."]'
            . ',"STACK":0} -->';
        exit;
    }

    public function updateViewOrder ($request)
    {
        $db             = hbm_db();
        
        $oAdmin         = (object) hbm_logged_admin();
        
        $viewId         = isset($request['viewId']) ? $request['viewId'] : 0;
        $sorter         = isset($request['sorter']) ? $request['sorter'] : 0;
        
        $db->query("
            UPDATE 
                hb_ticket_dashboard
            SET
                sorter = :sorter
            WHERE
                view_id = :viewId
                AND admin_id = :adminId
            ", array(
                ':adminId'  => $oAdmin->id,
                ':viewId'   => $viewId,
                ':sorter'   => $sorter
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["View id#'. $viewId .' order has been update."]'
            . ',"STACK":0} -->';
        exit;
    }

    public function removeViewFromDashboard ($request)
    {
        $db             = hbm_db();
        
        $oAdmin         = (object) hbm_logged_admin();
        
        $viewId         = isset($request['viewId']) ? $request['viewId'] : '';
        
        if ($viewId) {
            $db->query("
                DELETE FROM 
                    hb_ticket_dashboard 
                WHERE 
                    view_id = :viewId
                    AND admin_id = :adminId
                LIMIT 1
                ", array(
                    ':viewId'       => $viewId,
                    ':adminId'      => $oAdmin->id,
                ));
        }
        
        header('location:?cmd=tickets&list=all&showall=true&assigned=true');
        exit;
    }
    
    public function alsoAssignTo ($request)
    {
        require_once(APPDIR . 'class.general.custom.php');
        
        $db             = hbm_db();
        
        $oAdmin         = (object) hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $assignTo       = isset($request['assignTo']) ? $request['assignTo'] : '';
        $forceUnAssign  = isset($request['force']) ? 1 : 0;
        
        $aStaff         = array();
        $aStaffEmail    = array();
        $aTagIds        = array();
        
        /* --- list staff tag --- */
        $result         = $db->query("
                SELECT
                    aa.id, aa.username
                FROM
                    hb_admin_access aa
                WHERE
                    1
                ")->fetchAll();
                
        if (count($result)) {
            foreach ($result as $arr) {
                $username               = '@' . substr($arr['username'],0, strpos($arr['username'], '@'));
                $aStaff[$arr['id']]     = $username;
            }
        }
        
        /* --- list staff email --- */
        $result         = $db->query("
                SELECT
                    ad.id, ad.email
                FROM
                    hb_admin_details ad
                WHERE
                    1
                ")->fetchAll();
                
        if (count($result)) {
            foreach ($result as $arr) {
                $aStaffEmail[$arr['id']]     = $arr['email'];
            }
        }
        
        /* --- get ticket tag id --- */
        $result         = $db->query("
                SELECT
                    tt.tag_id
                FROM
                    hb_tickets_tags tt
                WHERE
                    tt.ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetchAll();
                
        if (count($result)) {
            foreach ($result as $arr) {
                array_push($aTagIds, $arr['tag_id']);
            }
        }
        
        /* --- owner ticket tag --- */
        $result         = $db->query("
                SELECT
                    t.ticket_number, t.owner_id
                FROM
                    hb_tickets t
                WHERE
                    t.id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
                
        $ownerTag       = (isset($result['owner_id']) && $result['owner_id']) ? $aStaff[$result['owner_id']] : '';
        $ticketNumber   = isset($result['ticket_number']) ? $result['ticket_number'] : '';
        $ownerId        = isset($result['owner_id']) ? $result['owner_id'] : 0;
        
        /* --- add assign to tag --- */
        $aAssignTo      = explode(',', $assignTo);
        $assignlog      = '';
        $aEmailTo       = array();
        
        if (count($aAssignTo)) {
            foreach ($aAssignTo as $staffId) {
                if (! isset($aStaff[$staffId])) {
                    continue;
                }
                
                $tagName    = $aStaff[$staffId];
                
                $result     = $db->query("
                        SELECT
                            t.*
                        FROM
                            hb_tags t
                        WHERE
                            t.tag = :tagName
                        ", array(
                            ':tagName'  => $tagName
                        ))->fetch();
                    
                if (isset($result['id']) && $result['id']) {
                    $tagId      = $result['id'];
                    
                } else {
                    $db->query("
                        INSERT INTO hb_tags (
                            id, tag
                        ) VALUES (
                            '', :tagName
                        )
                        ", array(
                            ':tagName'      => $tagName
                        ));
                    $tagId      = mysql_insert_id();
                    
                }
                
                $db->query("
                    REPLACE INTO hb_tickets_tags (
                        tag_id, ticket_id
                    ) VALUES (
                        :tagId, :ticketId
                    )
                    ", array(
                        ':tagId'        => $tagId,
                        ':ticketId'     => $ticketId
                    ));
                
                /* --- subscribe --- */
                $db->query("
                    REPLACE INTO hb_ticket_subscriptions (
                        admin_id, ticket_id
                    ) VALUES (
                        :adminId, :ticketId
                    )
                    ", array(
                        ':adminId'      => $staffId,
                        ':ticketId'     => $ticketId
                    ));
                
                $assignlog  .= ', '. $tagName;
                
                if (! in_array($tagId, $aTagIds)) {
                    array_push($aEmailTo, $aStaffEmail[$staffId]);
                }
                
            }
        }

        /* --- remove staff tag form ticket --- */
        foreach ($aStaff as $staffId => $tagName) {
            if ($tagName == $ownerTag && $forceUnAssign) {
                // Nothing
            } else if ($tagName == $ownerTag || in_array($staffId, $aAssignTo)) {
                continue;
            }
            
            $result     = $db->query("
                    SELECT
                        t.*
                    FROM
                        hb_tags t
                    WHERE
                        t.tag = :tagName
                    ", array(
                        ':tagName'  => $tagName
                    ))->fetch();
                    
            if (! isset($result['id']) || ! $result['id']) {
                continue;
            }
            
            $tagId      = $result['id'];
            
            $db->query("
                DELETE FROM 
                    hb_tickets_tags
                WHERE
                    tag_id = :tagId
                    AND ticket_id = :ticketId
                ", array(
                    ':tagId'        => $tagId,
                    ':ticketId'     => $ticketId
                ));
                
            /* --- unsubscribe --- */
            $db->query("
                DELETE FROM 
                    hb_ticket_subscriptions
                WHERE
                    admin_id = :adminId
                    AND ticket_id = :ticketId
                ", array(
                    ':adminId'      => $staffId,
                    ':ticketId'     => $ticketId
                ));
            
        }

        /* --- ส่ง email ถึง staff ที่ถูก tag ---*/
        if (count($aEmailTo)) {
            
            $ticketUrl  = GeneralCustom::singleton()->getAdminUrl() .'?cmd=tickets&action=view&num='. $ticketNumber;
            
            $emailTo    = implode(',', $aEmailTo);
            $subject    = $ownerTag .' ได้ tag คุณให้เข้าไปช่วยแก้ปัญหา ticket #'. $ticketNumber;
            $message    = "
                    
                    Staff: ". $oAdmin->firstname ."
                    ได้ tag : {$assignlog}
                    ให้เข้าไปช่วยแก้ปัญหา ticket #{$ticketNumber}
                    
                    Url: {$ticketUrl}
                    
                    ";
            
            $header     = 'MIME-Version: 1.0' . "\r\n" .
                    'Content-type: text/plain; charset=utf-8' . "\r\n" .
                    'From: admin@netway.co.th' . "\r\n" .
                    'Reply-To: admin@netway.co.th' . "\r\n" .
                    'X-Mailer: PHP/' . phpversion();
            @mail($emailTo, $subject, $message, $header);
        }
        
        /* --- สามารถเอา staff ออกจาก Ticket Assign หลักได้ --- */
        if ($forceUnAssign && $ownerId && ! in_array($ownerId, $aAssignTo)) {
            $db->query("
                UPDATE hb_tickets
                SET owner_id = 0
                WHERE id = :ticketId
                ",  array(
                    ':ticketId'     => $ticketId
                ));
        }
        
        /* --- update log --- */
        $db->query("
            INSERT INTO hb_tickets_log (
                id, ticket_id, date, action
            ) VALUES (
                '', :ticketId, :date, :action
            )
            ", array(
                ':ticketId'     => $ticketId,
                ':date'         => date('Y-m-d H:i:s'),
                ':action'       => 'Staff member '. $oAdmin->firstname .' '. $oAdmin->lastname 
                                    . ' tag tocket to '. $assignlog
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["Also assign to staff has been update."]'
            . ',"STACK":0} -->';
        exit;
    }

    /**
     * sync tag และ subscribe
     * ให้เป็นข้อมูลชุดเดียวกัน
     */
    public function ticketTagAndSubscribeSync ($request)
    {
        $db             = hbm_db();
        
        $oAdmin         = (object) hbm_logged_admin();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        if (! $ticketId) {
            return false;
        }
        
        $result         = $db->query("
                SELECT
                    aa.id, aa.username
                FROM
                    hb_admin_access aa
                WHERE
                    1
                ")->fetchAll();
        
        $aAdmin         = array();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $pos                    = strpos($arr['username'], '@');
                $aAdmin[$arr['id']]     = '@'. substr($arr['username'], 0, $pos);
            }
        }
        
        /* --- add tag from subscribe --- */
        $result         = $db->query("
                SELECT
                    ts.*
                FROM
                    hb_ticket_subscriptions ts
                WHERE
                    ts.ticket_id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $tagName        = isset($aAdmin[$arr['admin_id']]) ? $aAdmin[$arr['admin_id']] : '';
                
                if (! $tagName) {
                    continue;
                }
                
                /* --- ถ้าไม่มี tag ต้องเพิ่ม -- */
                $result2    = $db->query("
                        SELECT
                            t.id
                        FROM
                            hb_tags t
                        WHERE
                            t.tag = :tagName
                        ", array(
                            ':tagName'  => $tagName
                        ))->fetch();
                if (! isset($result2['id'])) {
                    $db->query("
                        INSERT INTO hb_tags (
                            id, tag
                        ) VALUES (
                            '', :tagName
                        )
                        ", array(
                            ':tagName'  => $tagName
                        ));
                    
                }
                
                // [XXX] ระวังหน่อย
                $db->query("
                    REPLACE INTO hb_tickets_tags (
                        tag_id, ticket_id
                    ) SELECT 
                        id, :ticketId 
                    FROM
                        hb_tags
                    WHERE
                        tag = :tagName
                    LIMIT 1
                    ", array(
                        ':ticketId'     => $ticketId,
                        ':tagName'      => $tagName
                    ));
            }
        }
        
        /* --- add subscribe from tag --- */
        $aAdminTag      = array_flip($aAdmin);
        
        $result         = $db->query("
                SELECT
                    t.tag
                FROM
                    hb_tickets_tags tt,
                    hb_tags t
                WHERE
                    tt.ticket_id = :ticketId
                    AND tt.tag_id = t.id
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $adminId        = isset($aAdminTag[$arr['tag']]) ? $aAdminTag[$arr['tag']] : '';
                
                if (! $adminId) {
                    continue;
                }

                $db->query("
                    REPLACE INTO hb_ticket_subscriptions (
                        admin_id, ticket_id
                    ) VALUES (
                        :adminId, :ticketId
                    )
                    ", array(
                        ':adminId'      => $adminId,
                        ':ticketId'     => $ticketId
                    ));
                
            }
        }
        
        return true;
    }
    
    /**
     * unsubscribe ออกด้วย เมื่อคลิกลบ tag
     */
    public function unsubscribeWhenRemoveTag ($request)
    {
        $db             = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $tagName        = isset($request['tagName']) ? $request['tagName'] : '';
        
        $result         = $db->query("
                SELECT
                    aa.id
                FROM
                    hb_admin_access aa
                WHERE
                    aa.username LIKE :username
                ", array(
                    ':username'     => substr($tagName, 1) . '@%'
                ))->fetch();
        
        if (! isset($result['id'])) {
            echo '<!-- {"ERROR":["Invalid admin verification."],"INFO":[""]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $adminId        = $result['id'];
        
        $db->query("
            DELETE FROM hb_ticket_subscriptions
            WHERE
                admin_id = :adminId
                AND ticket_id = :ticketId
            ", array(
                ':adminId'      => $adminId,
                ':ticketId'     => $ticketId
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["Also unassign staff subscribtion has been update."]'
            . ',"STACK":0} -->';
        exit;
    }

   /**
     * บันทึก kb category ที่จะ map เข้ากับหมวดของ support ticket
     */
    public function updateDepartmentToKbCategory ($request)
    {
        $db             = hbm_db();
        
        $deptId         = isset($request['deptId']) ? $request['deptId'] : 0;
        $catSelect      = isset($request['catSelect']) ? $request['catSelect'] : 0;
        
        if (! $deptId || ! $catSelect) {
            echo '<!-- {"ERROR":["Invalid ticket dept or kb cat."],"INFO":[]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $db->query("
            UPDATE
                hb_ticket_departments
            SET
                kb_category = :catSelect
            WHERE
                id = :deptId
            ", array(
                ':catSelect'    => $catSelect,
                ':deptId'       => $deptId
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["Ticket department has been map to kb category."]'
            . ',"STACK":0} -->';
        exit;
    }
    
    /**
     * ตั้งสถานะ การแจ้งเตือนลูกค้าเมื่อเจ้หาน้าที่ create ticket ให้
     */
    public function updateTicketNewNotifyStatus ($request)
    {
        $db             = hbm_db();
        
        $isEnable       = isset($request['isEnable']) ? $request['isEnable'] : 1;
        
        $db->query("
            UPDATE
                hb_email_templates
            SET
                send = :isEnable
            WHERE
                id = 76
            ", array(
                ':isEnable' => $isEnable
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":[]'
            . ',"STACK":0} -->';
        exit;
    }
    public function addNoteTowrike($request){

        $db         = hbm_db();
        
        require_once APPDIR . 'libs/wrikeapi/class.wrikeApiV3.php';
        
        $wrike          = new wrikeV3();
        
        $text           = "Staff : ".$request['name']."<br>";
        $text          .= "Note : ".$request['note'];
        
        $result         = $db->query("
                                    SELECT task_id
                                    FROM tickets_to_wrike
                                    WHERE ticket_id = :ticketid
                                    ", array(
                                        ':ticketid'    => $request['id']
                                    ))->fetch();
                            
        $taskID        =  $result['task_id'];
        
        $wrike->addComment($taskID,$text);
    }
    
    public function updateWrikeStatusFromTicket($request){

        $db             = hbm_db();

        require_once APPDIR . 'libs/wrikeapi/class.wrikeApiV3.php';
        
        $wrike          = new wrikeV3();
        
        $result         = $db->query("
                                    SELECT task_id
                                    FROM tickets_to_wrike
                                    WHERE ticket_id = :ticketid
                                    ", array(
                                        ':ticketid'    => $request['id']
                                    ))->fetch();
                            
        $taskID        =  $result['task_id'];     
        $status        =  $request['status']; 
        
        $result         = $db->query("
                                    SELECT dept_id,subject
                                    FROM hb_tickets
                                    WHERE id = :ticketid
                                    ", array(
                                        ':ticketid'    => $request['id']
                                    ))->fetch();
        
       
        $text          = "Staff : ".$request['name']."<br>";
        $text         .= "Set status to : ".$request['status'];
        $title          = '('.$request['status'].') '.$result['subject'];
        
        if($status == 'Closed'){
            $status    = 'Completed'; //completed
             $wrike->addComment($taskID,$text);
             $wrike->updateTask($taskID,$title,'',$status);
        }else{
            $status    = 'Active'; //active
            $wrike->addComment($taskID,$text);
            $wrike->updateTask($taskID,$title,'',$status);
        }
        
    }

    public function markasspam ($request) 
    {
        $db             = hbm_db();
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $ticketNumber   = isset($request['ticketNumber']) ? $request['ticketNumber'] : '';
        
        $result         = $db->query("
                SELECT
                    t.id
                FROM
                    hb_tags t
                WHERE
                    t.tag = 'spam'
                ")->fetch();
        
        if (! isset($result['id'])) {
            $db->query("INSERT INTO hb_tags (`tag`) VALUES ('spam') ON DUPLICATE KEY UPDATE id= LAST_INSERT_ID(id)");
            $result     = $db->query("SELECT MAX(t.id) AS id FROM hb_tags t")->fetch();
        }
        
        $tagId          = isset($result['id']) ? $result['id'] : 0;
        
        $db->query("
            REPLACE INTO hb_tickets_tags (`tag_id`,`ticket_id`) VALUES (:tagId, :ticketId)
            ", array(
                ':tagId'        => $tagId,
                ':ticketId'     => $ticketId
            ));
            
        $db->query("
            UPDATE 
                hb_tickets 
            SET 
                lastupdate = :lastupdate,
                tags = tags+1
             WHERE 
                id = :ticketId
            ", array(
                ':lastupdate'   => date('Y-m-d H:i:s'),
                ':ticketId'     => $ticketId
            ));
        
        
        echo '<!-- {"ERROR":[""],"INFO":["Ticket #'. $ticketNumber .' ถูกต้องค่าเป็น spam เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    /**
     * รายการ view ที่ create เอง เอาเฉพาะ view id เท่านั้น
     */
    public function listMyTicketView ()
    {
        $db             = hbm_db();
        $oAdmin         = (object) hbm_logged_admin();
        
        $aView          = array();
        
        $result         = $db->query("
                SELECT
                    tv.id
                FROM
                    hb_ticket_views tv
                WHERE
                    tv.owner = :ownerId
                    OR tv.id NOT IN (4,5)
                ", array(
                    ':ownerId'      => $oAdmin->id
                ))->fetchAll();
        
        if (! count($result)) {
            return $aView;
        }
        
        foreach ($result as $arr) {
            array_push($aView, $arr['id']);
        }
        
        return $aView;
    }
    
    public function getClient ($request)
    {
        $db             = hbm_db();
        
        $clientId       = isset($request['clientId']) ? $request['clientId'] : 0;
        
        $result         = $db->query("
                SELECT
                    ca.email, cd.*
                FROM
                    hb_client_access ca,
                    hb_client_details cd
                WHERE
                    ca.id = cd.id
                    AND ca.id = :clientId
                ", array(
                    ':clientId'     => $clientId
                ))->fetch();
        
        return $result;
    }
    
    public function updateccemail ($request)
    {
        $db             = hbm_db();
        
        $icketId        = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $ccemail        = isset($request['ccemail']) ? $request['ccemail'] : '';
        
        $db->query("
            UPDATE hb_tickets
            SET cc = :ccemail
            WHERE id = :ticketId
            ", array(
                ':ccemail'      => $ccemail,
                ':ticketId'     => $icketId,
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["บันทึกข้อมูล CC Email เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function updatedept ($request)
    {
        $db             = hbm_db();
        
        $icketId        = isset($request['ticketId']) ? $request['ticketId'] : 0;
        $deptId         = isset($request['deptId']) ? $request['deptId'] : 0;
        
        $db->query("
            UPDATE hb_tickets
            SET dept_id = :deptId
            WHERE id = :ticketId
            ", array(
                ':deptId'       => $deptId,
                ':ticketId'     => $icketId,
            ));
        
        echo '<!-- {"ERROR":[""],"INFO":["บันทึกข้อมูล Department เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function createticket ($request)
    {
        $db             = hbm_db();
        $oAdmin         = (object) hbm_logged_admin();
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        $redirect       = isset($request['redirect']) ? $request['redirect'] : 0;
        $clientId       = isset($request['client_id']) ? $request['client_id'] : 0;
        
        // #2025 Prasit test3 DNS Service
        $aParam         = array(
            'call'      => 'addTicket',
            'name'      => 'Staff',
            'subject'   => '[Draft] New ticket create by '. $oAdmin->firstname,
            'body'      => '
-----------------------------------
อย่าเพิ่ง Reply จนกว่า จะ edit ข้อความนี้
ตอน edit สามารถเลือกได้ว่า จะส่งข้อความที่แก้ไข ให้ลูกค้าด้วยหรือไม่

ถ้าทำการ reply ticket จะมี email หาลูกค้าทุกกรณี
-----------------------------------
            ',
            'dept_id'   => 3,
            'email'     => 'nobody-'.time() . '@netway.co.th'
            );
        
        //$result         = $apiCustom->request($aParam);
        
        header('location:?cmd=redirecthandle&cmd_=tickets&action_=clienttickets&id='. $clientId);
        exit;
        
        if (isset($result['error']) && count($result['error'])) {
            echo '<!-- {"ERROR":["'. implode(',', $result['error']) .'"],"INFO":[""]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $ticketNumber   = isset($result['ticket_id']) ? $result['ticket_id'] : '';
        
        // Auto assign staff
        $db->query("
            UPDATE hb_tickets
            SET owner_id = :ownerId,
                client_id = :clientId,
                email = :email
            WHERE ticket_number = :ticketNumber
            ", array(
                ':ownerId'      => $oAdmin->id,
                ':clientId'     => $clientId,
                ':email'        => $oAdmin->email,
                ':ticketNumber' => $ticketNumber
            ));
        
        if ($redirect) {
            header('location:?cmd=tickets&action=view&num='. $ticketNumber);
            exit;
        }
        
        echo '<!-- {"ERROR":[""],"INFO":["สร้าง ticket เรียบร้อย"]'
            . ', "TICKET_NUMBER":["'. $result['ticket_id'] .'"]'
            . ',"STACK":0} -->';
        exit;
    }

    public function sendemailticket ($request)
    {
        $db             = hbm_db();
        $oAdmin         = (object) hbm_logged_admin();
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.general.custom.php');
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl.'/api.php');
        // --- Custom helper ---
        
        $ticketId       = isset($request['ticketId']) ? $request['ticketId'] : 0;
        
        $result         = $db->query("
                SELECT t.*
                FROM hb_tickets t
                WHERE t.id = :ticketId
                ", array(
                    ':ticketId'     => $ticketId
                ))->fetch();
        
        $ticketNumber   = isset($result['ticket_number']) ? $result['ticket_number'] : '';
        $body           = isset($result['body']) ? $result['body'] : '';
        $status         = isset($result['status']) ? $result['status'] : 'Open';
        
        if (! $ticketNumber) {
            echo '<!-- {"ERROR":["ไม่พบข้อมูล"],"INFO":[""]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $code            = '@'. date('Y-m-d H:i:s');
        
        $aParam         = array(
            'call'      => 'addTicketReply',
            'id'        => $ticketNumber,
            'body'      => $body ."\n\n\n". $code
            );
        $result         = $apiCustom->request($aParam);
        
        if (isset($result['error']) && count($result['error'])) {
            echo '<!-- {"ERROR":["'. implode(',', $result['error']) .'"],"INFO":[""]'
                . ',"STACK":0} -->';
            exit;
        }
        
        // delete reply
        $db->query("
            DELETE FROM hb_ticket_replies 
            WHERE ticket_id = :ticketId
                AND body LIKE :body
            LIMIT 1
            ", array(
                ':ticketId'     => $ticketId,
                ':body'         => '%'. $code .'%'
            ));
        
        $status         = isset($request['status']) ? $request['status'] : $status;
        
        // update ticket
        $db->query("
            UPDATE hb_tickets
            SET status = :status
            WHERE id = :ticketId
            ", array(
                ':status'       => $status,
                ':ticketId'     => $ticketId
            ));
        
        $isUnassign     = isset($request['isUnassign']) ? $request['isUnassign'] : 0;
        
        // unassign staff
        if ($isUnassign) {
            $db->query("
                UPDATE hb_tickets
                SET owner_id = 0
                WHERE id = :ticketId
                    AND owner_id = :ownerId
                ", array(
                    ':ownerId'      => $oAdmin->id,
                    ':ticketId'     => $ticketId
                ));
        }
        
        echo '<!-- {"ERROR":[""],"INFO":["ส่ง Email แจ้งลูกค้าเรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function sendEmailToSubscribe ($request)
    {
        $db         = hbm_db();
        $oAdmin     = (object) hbm_logged_admin();
        
        // --- Custom helper ---
        require_once(APPDIR . 'class.general.custom.php');
        // --- Custom helper ---
        
        $ticketId   = isset($request['id']) ? $request['id'] : 0;
        
        $result     = $db->query("
            SELECT ad.email
            FROM hb_ticket_subscriptions ts,
                hb_admin_details ad
            WHERE ts.admin_id = ad.id
                AND ts.ticket_id = :ticketId
                AND ad.id != :adminId
            ", array(
                ':ticketId' => $ticketId,
                ':adminId'  => $oAdmin->id
            ))->fetchAll();
        
        if (! count($result)) {
            echo '<!-- {"ERROR":[],"INFO":["ไม่มีรายชื่อ staff ที่ติดตาม ticket นี้"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $aEmail         = array();
        foreach ($result as $arr) {
            array_push($aEmail, $arr['email']);
        }
        
        $result     = $db->query("
            SELECT t.id, t.ticket_number, t.subject,
                tn.note
            FROM hb_tickets t,
                hb_tickets_notes tn
            WHERE t.id = :ticketId
                AND tn.ticket_id = t.id
            ORDER BY tn.id DESC LIMIT 1
            ", array(
                ':ticketId' => $ticketId
            ))->fetch();
        
        if (! isset($result['id'])) {
            echo '<!-- {"ERROR":[],"INFO":["ไม่มีข้อมูล ticket note"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        $ticketNumber   = $result['ticket_number'];
        $ticketSubject  = $result['subject'];
        $comment        = $result['note'];
        
        $ticketUrl  = GeneralCustom::singleton()->getAdminUrl() .'?cmd=tickets&action=view&num='. $ticketNumber;
        
        $emailTo    = implode(', ', $aEmail);
        $subject    = 'Staff comment ticket #'. $ticketNumber .' '. $ticketSubject;
        $message    = "
                
                Staff: ". $oAdmin->firstname ."
                Comment : {$comment}
                
                Url: {$ticketUrl}
                
                ";
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: admin@netway.co.th' . "\r\n" .
                'Reply-To: admin@netway.co.th' . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        @mail($emailTo, $subject, $message, $header);
        
        echo '<!-- {"ERROR":[],"INFO":["ส่ง email แจ้ง '. $emailTo .' เรียบร้อยแล้ว"]'
            . ',"STACK":0} -->';
        exit;
    }
    
    public function menubutton ($request)
    {
        echo '<!-- {"ERROR":[""],"INFO":[""]'
            . ',"STACK":0} -->';
        exit;
    }
	
	public function addFulfillmentAttachment($request){
		
		$db     = hbm_db();
        
        require_once(APPDIR . 'class.config.custom.php');
        
        $allowedAttachmentExt   = ConfigCustom::singleton()->getValue('AllowedAttachmentExt');
        $maxAttachmentSize      = ConfigCustom::singleton()->getValue('MaxAttachmentSize');
        
        $ticketFulfillmentId       = isset($request['ticketFulfillmentId']) ? $request['ticketFulfillmentId'] : 0;
        
        require_once( dirname(dirname(__FILE__)) .'/libs/php.php');
        
        $uploadPath         = MAINDIR . 'attachments/';
        $allowedExtensions  = explode(';.', 'xxx;' . $allowedAttachmentExt);
        $sizeLimit          = $maxAttachmentSize * 1024 * 1024;
        
        $uploader           = new qqFileUploader($allowedExtensions, $sizeLimit);
        $result             = $uploader->handleUpload($uploadPath);
        
        echo htmlspecialchars(json_encode($result), ENT_NOQUOTES);
        
        if (isset($result['success']) && $result['success']) {
        	
			$fileName       = $uploader->getUploadName();
			
			$db->query("
                INSERT INTO sc_ticket_fulfillment_attachment (
                    id, ticket_fulfillment_id, filename, type
                ) VALUES (
                    null, :ticketFulfillmentId, :fileName, :fileType
                )
            ", array(
                ':ticketFulfillmentId'     	=> $ticketFulfillmentId,
                ':fileName'     			=> $fileName,
                ':fileType'     			=> substr($fileName, strrpos($fileName, '.'))
            ));
			
            echo '<!-- {"ERROR":[],"INFO":["Upload attachment file success"]'
                . ',"STACK":0} -->';
            exit;
        }
        
        echo '<!-- {"ERROR":["Upload attachment file error"],"INFO":[]'
            . ',"STACK":0} -->';
        exit;
	}	
    
    public function getSubmitter ($ticketId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT id, name_original, email_original
            FROM hb_tickets
            WHERE id = :id
                AND email_original != ''
                AND email != email_original
            ", array(
                ':id'   => $ticketId
            ))->fetch();
        
        return $result;
    }
    
    public function beautifierReply ($aReplies)
    {
        
        $aReplies_  = $aReplies;
        if (count($aReplies_)) {
            foreach ($aReplies_ as $k => $arr)  {
                $body       = htmlspecialchars_decode($arr['body']);
                
                // Reference http://stackoverflow.com/questions/4995962/how-to-strip-tags-in-a-safer-way-than-using-strip-tags-function
                $body       = preg_replace("# <(?![/a-z]) | (?<=\s)>(?![a-z]) #exi", "htmlentities('$0')", $body);
                
                $body       = strip_tags($body, '<br><img><a><u><strong><span>');
                $body       = preg_replace('/inline; filename="Image.*((\r|\n).*)+------/i', ' Image ', $body);
                $aReplies[$k]['body']   = $body;
            }
        }
        
        /*
        echo '<pre>'.print_r($aReplies,true).'</pre>';
        exit;
        */
        return $aReplies;
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