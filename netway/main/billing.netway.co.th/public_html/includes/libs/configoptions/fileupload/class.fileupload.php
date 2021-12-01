<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


require_once(dirname(dirname(__FILE__)) . '/input/class.input.php');

class Fileupload extends Input {
    
    public $langid      = 'File upload';
    public $group       = 'special';
    
}

