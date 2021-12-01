<?php

class sendinbluehandle extends OtherModule {
    
    protected $modname = 'Sendinblue Event Handle';
    protected $description = '***NETWAY*** ตัวจัดการ hook จาก sendinblue activity
        <br />
        - อย่างเช่น email ส่งออกไปหาผู้รับไม่ได้ให้ไปสร้าง task ที่ zendesk เพื่อให้เจ้าหน้าที่แก้ไข
        ';

    public $configuration    = array(
        'SIB_API_URL'   => array(
            'value'     => '',
            'type'      => 'input',
            'description'      => 'Sendinblue api url  https://api.sendinblue.com/v3/ '
        ),
        'SIB_API_KEY'   => array(
            'value'     => '',
            'type'      => 'input'
        ),
        'NETWAY_ZENDESK_API_URL'    => array(
            'value'     => '',
            'type'      => 'input',
            'description'      => 'Sendinblue api url https://pdi-netway.zendesk.com/api/v2/ '
        ),
        'NETWAY_ZENDESK_API_AUTH'    => array(
            'value'     => '',
            'type'      => 'input',
        ),
        'NETWAY_SENDER_EMAIL'    => array(
            'value'     => '',
            'type'      => 'input',
        ),
        'RV_ZENDESK_API_URL'    => array(
            'value'     => '',
            'type'      => 'input',
            'description'      => 'Sendinblue api url https://rvglobalsoft.zendesk.com/api/v2/ '
        ),
        'RV_ZENDESK_API_AUTH'    => array(
            'value'     => '',
            'type'      => 'input',
        ),
        'RV_SENDER_EMAIL'    => array(
            'value'     => '',
            'type'      => 'input',
        ),
    );

}
