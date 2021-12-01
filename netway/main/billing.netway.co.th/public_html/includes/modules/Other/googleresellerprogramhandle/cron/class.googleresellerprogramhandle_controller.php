<?php

require_once dirname(__DIR__) . '/class.googleresellerprogramhandle.php';

class googleresellerprogramhandle_controller extends HBController {
    
    public $module;
    
    public function call_Hourly ()
    {
        $aAdmin         = hbm_logged_admin();

        $message    = '';

        $result    = googleresellerprogramhandle::singleton()->sync();
        if (isset($aAdmin['id'])) {
            $message    .= serialize($result);
        }
        
        if (isset($aAdmin['id'])) {
            echo $message;
        }

        return $message;
    }
    
}


