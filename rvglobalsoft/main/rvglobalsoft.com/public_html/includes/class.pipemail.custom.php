<?php

/**
 * [XXX]
 * @author prasit
 *
 */

require(dirname(dirname(__FILE__)) . '/includes/hostbill.php');

class PipemailCustom {
    
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
    
    private function __construct () 
    {
        
    }
    
    public function base64toAttachment ($email)
    {
        if (! preg_match('/Content\-Transfer\-Encoding:\s?base64/i', $email, $matches)) {
            return $email;
        }
        
        $email  = preg_replace('/(Content\-Type\:.*)(name\=.*\r?\n?)(Content\-Transfer\-Encoding:\s?base64)/',
                    '$1$2Content-Disposition: attachment; file$2$3',
                    $email
                );
        
        /* --- text/* encode with base64 --- */
        preg_match('/Content\-Type\:\stext\/.*[\r\n]?.*charset\=.*[\r\n]'.
            'Content\-Transfer\-Encoding\:\s?base64[\r\n]{2}/',
            $email, $matches, PREG_OFFSET_CAPTURE
        );
        if (! isset($matches[0][1])) {
            return $email;
        }
        
        $pos    = $matches[0][1] + strlen($matches[0][0]);
        $pre    = substr($email, 0, $pos);
        $msg    = substr($email, $pos);
        
        preg_match('/[\r\n]{2}\-\-/', $msg, $matches, PREG_OFFSET_CAPTURE);
        if (! isset($matches[0][1])) {
            return $email;
        }
        
        $pos            = $matches[0][1];
        $text64         = substr($msg, 0, $pos);
        $text64length   = strlen($text64);

        /* --- ถ้ามี text64 content ดึงออกมาเป็น text เลย ---*/
        if ($text64) {
            
            preg_match('/([\r\n].*[\r\n]Content\-Transfer\-Encoding:\s?base64)[\r\n]{2}/', $email, $matches, PREG_OFFSET_CAPTURE);
            if (! isset($matches[0][1])) {
                return $email;
            }
            
            $char   = $matches[0][0];
            $pos    = $matches[0][1] + strlen($matches[0][0]);
            $pre    = substr($email, 0, $pos);
            $msg    = substr($email, $pos);
            
            $text64 = base64_decode($text64);
            
            /* --- เปลี่ยนเป็น text เลยสำหรับ Microsoft Office Outlook ---*/
            if (preg_match('/charset\=\"(.*)\"/', $char, $matches)) {
                //echo '<pre>'.print_r($matches, true).'</pre>';exit;
                
                if (isset($matches[1])) {
                    $chSet      = $matches[1];
                    $text64     = iconv($chSet, 'UTF-8//IGNORE', $text64);
                    $msg        = substr($email, $pos + $text64length);
                }
                
            }
            
            $email  = $pre . "\n\n". $text64 ."\n\n" . $msg;
            
            //echo $msg;exit;
        }
        
        return $email;
    }
    
    public function rewriteFromToInMessage ($email)
    {

        preg_match('/[\r\n]{2}/', $email, $matches, PREG_OFFSET_CAPTURE);
        if (! isset($matches[0][1])) {
            return $email;
        }
        
        $pos    = $matches[0][1];
        $pre    = substr($email, 0, $pos);
        $msg    = substr($email, $pos);

        $msg    = preg_replace('/From\:\s/i', 'From&#58; ', $msg);
        $msg    = preg_replace('/To\:\s/i', 'To&#58; ', $msg);
        $msg    = preg_replace('/Subject\:\s/i', 'Subject&#58; ', $msg);
        
        $email  = $pre . $msg;

        return $email;
    }
    
    public function rewriteClearToHeader ($email)
    {
        $db         = hbm_db();
        
        preg_match('/[\r\n]To\:\s/', $email, $matches, PREG_OFFSET_CAPTURE);
        if (! isset($matches[0][1])) {
            return $email;
        }

        $pos    = $matches[0][1];
        $msg    = substr($email, $pos, 300);
        
        preg_match('/\r?\n?[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})/', $msg, $matches);
        if (! isset($matches[0])) {
            return $email;
        }
        
        $emailTo    = $matches[0];
        
        $email  = preg_replace('/([\r\n])To\:\s.*\r?\n?.*<?[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})>?/', 
                    '$1To: '. $emailTo, 
                    $email
                );
        
        /* --- บางครั้งมีการเปลี่ยน department พอ reply มีการ Mismatch --- */
        preg_match('/[\r\n]Subject\:\s.*#(\d{6}).*/', $email, $matches);
        if (! isset($matches[1])) {
            return $email;
        }
        
        $ticketNumber   = $matches[1];
        
        $result     = $db->query("
            SELECT id
            FROM hb_ticket_departments
            WHERE email = :email
            ", array(
                ':email'    => $emailTo
            ))->fetch();
        if (! isset($result['id'])) {
            return $email;
        }
        
        $departmentId   = $result['id'];
        
        // เปลี่ยน ticket department อิงตาม to
        $db->query("
            UPDATE hb_tickets
            SET dept_id = :departmentId
            WHERE ticket_number = :ticketNumber
            LIMIT 1
            ", array(
                ':departmentId'     => $departmentId,
                ':ticketNumber'     => $ticketNumber
            ));
        
        //echo "\n".print_r($matches, true)."\n";exit;
        return $email;
    }
    
}