<?php

class importongoogle extends OtherModule {
    
    protected $modname      = 'IMPORT on Google Drive';
    protected $description  = 'IMPORT syncronize from google drive to hostbill automatically by rvglobalsoft<br />
        1. ให้ส่งคำร้องไปขอ Auth Code <a href="?cmd=importongoogle&action=getauthcode" target="_blank">here</a> ก่อน<br />
        2. บันทึกค่า Auth Code ลงใน config<br />
        3. ส่งคำร้องไปขอ Access Token <a href="?cmd=importongoogle&action=getaccesstoken" target="_blank">here</a><br />
        4. บันทึกค่า Access Token ลงใน config<br />
        5. ทดสอบ config ว่าสามารถใช้งานได้หรือไม่ <a href="?cmd=importongoogle&action=testaccesstoken" target="_blank">Test configuration</a><br />
    ';

    public $configuration    = array(
        'Client ID'     => array(
            'value'     => '40825206682-kc25gdri7emglrem0j7id182qttnpgtt.apps.googleusercontent.com',
            'type'      => 'input'
        ),
        'Client Secret' => array(
            'value'     => 'sua2Jw7X2thgz2AllHQ1Nyx0',
            'type'      => 'input'
        ),
        'Auth Code'     => array(
            'value'     => '4/U7q0_joXuUan_WBQmz3FbW9rs4ev.skNHePIvYaIZXE-sT2ZLcbQbfvU6hQI',
            'type'      => 'input'
        ),
        'Access Token'  => array(
            'value'     => '{-quote-access_token-quote-:-quote-ya29.1.AADtN_V117PL2gJ2EnbwiCpGM0O5DH1IGF51WhDXTkqgbFouLOAYP_LWkl6BJP8rUi0kGw-quote-,-quote-token_type-quote-:-quote-Bearer-quote-,-quote-expires_in-quote-:3600,-quote-refresh_token-quote-:-quote-1\/xEUCUS239-UMX5cuXzLF3mSdOylbDyVDBTkkD7aLbis-quote-,-quote-created-quote-:1385637021}',
            'type'      => 'input'
        ),
        'Daily Document Root ID'  => array(
            'value'     => '0B-dcZJ98s6ZdWllwOTJ6VXo1c0E',
            'type'      => 'input'
        ),
        'Month Document Root ID'  => array(
            'value'     => '0B-dcZJ98s6ZdaDh4dWI3TmpyRVE',
            'type'      => 'input'
        ),
        'Today'  => array(
            'value'     => '2014-2-7',
            'type'      => 'input'
        )
    );
    public $prodcutOrCatId = array('sslCategory' => 1,
                                   'rvskinNocProductID' => array(73,74),
                                   'rvskinDistributorProductID' => array(75,76),
                                   'rvsiteBuiderNocProductID' => array(77,78),
                                   'rvsiteBuiderDistributorProductID' => array(79,80),
                                   'cpanelDedProductID' => array(63,96,109),
                                   'cpanelVPSProductID' => array(64,97,65,111,113),
                                   'rvSkinRegularProductID' => array(70,71,81,82,88,89,92,93),
                                   'rvSiteBuiderProductID' => array(66,67,90,91,158),
                                   'rv2factorWHMProductID' => array(58,59,103),
                                   'rv2factorCPanelProductID' => array(60,104),
                                   'rv2factorAPPProductID' => array(61,105)                    
                            );
                            
    public $departmentID = array('rv2Factor' => 1,
                                 'billingAndPayment' => 2,
                                 'sslCertificates' => 3,
                                 'cPanelWHMLicense' => 4,
                                 'rvSiteBuilder' => 5,
                                 'rvskinAndRVSubversion' => 6,
                                 'bouncedMail' => 8,
                                 'rvPanel' => 9,
                                 'translation' => 10
                                 );
    
    
}
