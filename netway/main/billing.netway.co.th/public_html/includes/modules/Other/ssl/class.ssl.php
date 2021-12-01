<?php

class ssl extends OtherModule
{
    protected $info = array(
            'haveadmin' => true,    //is module accessible from adminarea
            'haveuser' => false,     //is module accessible from client area
            'havelang' => false,     //does module support multilanguage
            'havetpl' => false,      //does module have template
            'havecron' => false,     //does module support cron calls
            'haveapi' => false,      //does module have functions accessible via api
            'needauth' => false,     //does module needs authorisation by clients to use it
            'isobserver' => false,   //is module an observer - must implement Observer interface!
            'clients_menu' => false, //should module be listed in adminarea->clients menu
            'support_menu' => false,  //should module be listed in adminarea->support menu
            'payment_menu' => false,  // should module be listed in adminarea->payments menu
            'orders_menu' => false,   //should module be listed in adminarea->orders menu
            'extras_menu' => false,    //should module be listed in extras menu
            'mainpage' => false,       //should module be listed in admin home screen and/or clientarea root screen
            'header_js' => false,     //does module have getHeaderJS function - add header javascript code to admin/clientarea
    );

    const NAME = 'ssl';

    protected $filename='class.ssl.php';
    protected $description='***NETWAY*** ';
    protected $modname = 'SSL Module';



}