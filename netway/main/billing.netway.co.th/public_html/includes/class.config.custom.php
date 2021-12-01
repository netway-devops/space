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

class ConfigCustom {
    
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
    
    public function getValue ($settingKey)
    {
        $db         = hbm_db();
        
        $aConfig    = $db->query("
                    SELECT value 
                    FROM hb_configuration 
                    WHERE setting = :settingKey
                    ", array(
                        ':settingKey'   => $settingKey
                    ))->fetch();
        $value = isset($aConfig['value']) ? $aConfig['value'] : '';
        
        return $value;
    }
    
    public function setValue ($settingKey, $value)
    {
        $db         = hbm_db();
        
        $db->query("
            REPLACE INTO
                hb_configuration (setting, value)
            VALUES 
                (:settingKey, :newValue)
        ", array(
            ':settingKey'   => $settingKey,
            ':newValue'     => $value
        ));
        
    }

}