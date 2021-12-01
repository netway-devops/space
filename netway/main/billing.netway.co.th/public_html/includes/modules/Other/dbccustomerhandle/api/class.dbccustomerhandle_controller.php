<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Other/dbccustomerhandle/model/class.dbccustomerhandle_model.php');
require_once(APPDIR . 'modules/Other/dbccustomerhandle/library/class.dbccustomerhandle_library.php');

class dbccustomerhandle_controller extends HBController {
    
    public function xxxx ($request)
    {
        $aReturn    = array();
        
        
        return array(true, $aReturn);
    }
}