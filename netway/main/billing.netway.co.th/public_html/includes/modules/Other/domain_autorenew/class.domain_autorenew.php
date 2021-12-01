<?php

class domain_autorenew extends OtherModule {
    
    protected $modname      = 'Domain auto renew';
    protected $description  = '***NETWAY*** ***** รอยกเลิก ***** แสดงรายชื่อโดเมนที่ถูกตั้งค่า auto renew โดย registrar';
    
    protected $info         = array(
        'haveadmin'         => true,
        'havetpl'           => true,
        'orders_menu'       => true,
        'extras_menu'       => false
        );
    
}
