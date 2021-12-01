<?php

class mtdpipedrive extends OtherModule {
    
    protected $modname      = 'MTD Pipedrive';
    protected $description  = 'สรุปข้อมูลจาก hostbill เข้าไฟล์ MTD Pipedrive by rvglobalsoft<br />
        1. ให้ส่งคำร้องไปขอ Auth Code <a href="?cmd=mtdpipedrive&action=getauthcode" target="_blank">here</a> ก่อน<br />
        2. บันทึกค่า Auth Code ลงใน config<br />
        3. ส่งคำร้องไปขอ Access Token <a href="?cmd=mtdpipedrive&action=getaccesstoken" target="_blank">here</a><br />
        4. บันทึกค่า Access Token ลงใน config<br />
        5. ทดสอบ config ว่าสามารถใช้งานได้หรือไม่ <a href="?cmd=mtdpipedrive&action=testaccesstoken" target="_blank">Test configuration</a><br />
    ';

    public $configuration    = array(
        'Client ID'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'Client Secret' => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'Auth Code'     => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'Access Token'  => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'MTD Pipedrive Document ID'  => array(
            'value'     => '1k6Ut6n5wU7VobxTXWyOjFnYR-wIGJWgiieGAXKQB5hg',
            'type'      => 'input'
        )
    );
    
}
