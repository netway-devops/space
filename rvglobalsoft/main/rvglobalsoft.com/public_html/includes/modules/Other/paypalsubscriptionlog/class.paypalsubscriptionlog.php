<?php

class paypalsubscriptionlog extends OtherModule {
    
    protected $modname      = 'Paypal Subscription Log';
    protected $description  = 'ใช้แยกข้อมูลที่ได้จาก Paypal เก็บลง field ในตาราง';
    public $configuration   = array();

	protected $info = array(
        'payment_menu' => true,
    );

}
