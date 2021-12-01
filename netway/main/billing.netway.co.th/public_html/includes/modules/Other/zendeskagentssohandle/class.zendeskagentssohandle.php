<?php

class zendeskagentssohandle extends OtherModule {
    
    protected $modname      = 'Zendesk Agent SSO Handle';
    protected $description  = '***NETWAY*** Staff ส่วนการทำ Single sign-on เพื่อ login เข้าใช้งาน zendesk ด้วย account กลางได้';
    
    protected $info         = array();
    
    private static  $instance;
	
	public $configuration    = array(
        'ZENDESK_URL'       => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'JWT_SECRET'      => array(
            'value'     => '',
            'type'      => 'input'
        )
    );
    
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
