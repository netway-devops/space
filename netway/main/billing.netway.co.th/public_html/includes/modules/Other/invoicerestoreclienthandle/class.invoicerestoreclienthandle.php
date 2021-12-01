<?php

class invoicerestoreclienthandle extends OtherModule {
    
    protected $modname      = 'Invoice Restore Client ID';
    protected $description  = '***NETWAY*** คืน client id ให้กับ invoice เนื่องจากการรวม บาง invoice 
        จะต้องทำการเปลี่ยน client id ให้เป็นค่าติดลบ แล้วรวมรายการที่เลือก จากนั้นจะเปลี่ยน client id กลับ
        บางครั้งมันไม่เปลี่ยนกลับ จึงต้องทำ cron ให้คืนค่า
        ';

    public $configuration    = array();
    
    
    
}
