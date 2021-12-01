<?php

/**
 * ใช้สำหรับ module custom api 
 * 'call'      => 'module'
 * ซึ่งเรียกแบบ internal ไม่ได้ จะต้องใช้ curl call 
 * @author prasit
 *
 */

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

class ApiCustom {
    
    private static  $instance;
    public static   $apiId;
    public static   $apiKey;
    public static   $apiUrl;
    
    public static function singleton ($url)
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c($url);
        }

        return self::$instance;
    }

    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    private function __construct ($url) 
    {
        if ($this->apiId == '') {
        	$ip = (isset($_SERVER['SERVER_ADDR']) && $_SERVER['SERVER_ADDR'] !='') ? $_SERVER['SERVER_ADDR'] : '50.28.10.251';
            $db         = hbm_db();
            $result     = $db->query("
                      SELECT aa.*
                      FROM hb_api_access aa
                      WHERE aa.ip = :aaIp
                      ", array(
                           ':aaIp' => $ip
                      ))->fetch();
            if (isset($result['id'])) {
                $this->apiId    = $result['api_id'];
                $this->apiKey   = '6680e811c1c2548de0e5';
            }
        }
        
        $this->apiUrl   = $url;

    }
    
    public function request ($post = array())
    {

        $aParam     = array(
            'api_id'    => $this->apiId,
            'api_key'   => $this->apiKey,
        );
        $aParams    = array_merge($aParam, $post);
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->apiUrl);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $aParams);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        $data = curl_exec($ch);
        curl_close($ch);
    
        $result = json_decode($data, true);
        
        return $result;
    }
    

}