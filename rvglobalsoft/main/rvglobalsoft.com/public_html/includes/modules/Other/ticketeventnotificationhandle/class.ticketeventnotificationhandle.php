<?php

class ticketeventnotificationhandle extends OtherModule {
    
    protected $modname      = 'Ticket event notification';
    protected $description  = 'แจ้งเตือนเจ้าหน้าที่ เมื่อมีเหตุการณ์เกิดขึ้นใน ticket <br />
        <pre>
        พี่กวง request มาว่าอยากให้แจ้งเตือนว่าถ้ามี
            - ticket ใกม่
            - เจ้าหน้าที่ reply comment
            - ลูกค้าตอบ
        </pre>
        ';

    public $configuration    = array(
        'Email To'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'Note'     => array(
            'value'     => '',
            'type'      => 'textarea'
        )
    );
    
    
    
}
