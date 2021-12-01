<?php

class crispchathandle_controller extends HBController {

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
    
    public function beforeCall ($request)
    {
        $this->_beforeRender();
    }
    
    public function _default ($request)
    {
        $db     = hbm_db();
    }
    
    // https://billing.netway.co.th/index.php?cmd=crispchathandle&action=webhook
    public function webhook ($request)
    {
        $db     = hbm_db();
        
        $inputJSON  = file_get_contents('php://input');
        $aData      = json_decode($inputJSON, TRUE);
        $sessionId  = isset($aData['data']['session_id']) ? $aData['data']['session_id'] : '';

        if ($sessionId != 'session_13f0317f-7e18-450e-afe2-22ad4288896e') {
            return true;
        }
        

        $file   = fopen('/home/managene/logs/debug.txt', 'a+');
        fwrite($file, print_r($aData, true) ."\n");
        fclose($file);

    }
    
    private function _beforeRender ()
    {
     
    }
    
    public function afterCall ($request)
    {
        
    }
}