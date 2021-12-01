<?php

class dbc_integration extends OtherModule implements Observer {
    protected $modname      = 'Dynamics365 Business Central Integration';
    protected $description  = 'Dynamics365 Business Central Integration';

    protected $info         = array(
        'extras_menu'      => true
    );
    private static  $instance;
    

    public $configuration    = array();

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function before_displayadminheader($details)
    {
    }

}