<?php

class cancel_invoice_when_account_terminate extends OtherModule {
    
    protected $modname = 'Cancel invoice when account terminate';
    protected $description = '***NETWAY*** ยกเลิก invoice ที่เกี่ยวข้องเมื่อ account ถูก terminate 
        ยกเว้นถ้า invoice มีหลาย item ถ้ามีตัวที่ active อยู่ ไม่ต้องดำเนินการ
        ';

}
