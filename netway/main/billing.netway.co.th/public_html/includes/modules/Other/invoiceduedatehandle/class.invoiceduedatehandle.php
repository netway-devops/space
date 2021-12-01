<?php

class invoiceduedatehandle extends OtherModule {
    
    protected $modname      = 'Invoice Duedate Handle';
    protected $description  = '***NETWAY*** กรณีที่ออก invoice แล้วมี item 2 ตัวขึ้นไป
        hostbill จะยึด duedate ล่าสุดมาใช้ในการตั้ง duedate ให้ invoice
        ทำให้ service ที่มีจะถึง duedate ไม่ถูกแจ้งเตือน
        https://www.wrike.com/open.htm?id=60668203
        ';

    public $configuration    = array();
    
    
    
}
