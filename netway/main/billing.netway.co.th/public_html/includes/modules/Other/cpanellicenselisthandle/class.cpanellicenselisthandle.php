<?php

require_once __DIR__ . '/model/class.cpanellicenselisthandle_model.php';

class cpanellicenselisthandle extends OtherModule {
    
    protected $modname      = 'Cpanel license list';
    protected $description  = '***NETWAY*** รายงาน cPanel License ที่อยู่ตามเครื่องต่างๆ
        <br />
        - เพื่อให้เจ้าหน้าที่ export ไปใช้งานต่อได้ <a target="_blank" href="https://billing.netway.co.th/7944web/index.php?cmd=cpanellicenselisthandle">https://billing.netway.co.th/7944web/index.php?cmd=cpanellicenselisthandle</a>
        ';

    protected $info         = array(
        'orders_menu'       => true,
    );

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
