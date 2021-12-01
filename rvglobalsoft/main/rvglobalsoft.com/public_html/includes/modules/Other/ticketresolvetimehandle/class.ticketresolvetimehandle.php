<?php

class ticketresolvetimehandle extends OtherModule {
    
    protected $modname      = 'Ticket resolve time handle';
    protected $description  = 'Matrix SLA module เวลาตั้งแต่ ticket เปิด ถึง ที่ตัวเองตอบหรือ comment สุดท้าย โดย ticket นั้นจะต้อง close แล้ว';
    
    protected $info         = array();
    
    //react on event: before_displayuserfooter
    public function before_displayadminheader($details) {
        //$script_location    = '../includes/modules/Other/servicecataloghandle/templates/js/script.js';
        //this will be rendered in adminarea head tag:
        //echo '<script type="text/javascript" src="'.$script_location.'"></script>';
    }
    
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
    
    
}
