<?php

/**
 * ใช้สำหรับ load custom config ไปใช้งาน
 * @author prasit
 *
 */

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

//require_once(dirname(APPDIR) . '/hbf/core/class.hbcache.php');
/*
class HBCache {
    
    public function get ()
    {
        return null;
    }
    
    public function set ()
    {
        return null;
    }
    
}
*/

class CacheExtend extends HBCache {
    
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
    
    
}