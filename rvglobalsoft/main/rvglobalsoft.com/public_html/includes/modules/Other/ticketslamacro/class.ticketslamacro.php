<?php
/*
sendToCSMgr - เวลา 7:00 - 18:00 ส่ง email ถึงใคร ..... รวมเสาร์อาทิตย์ ไหม ..... 18:01 - 6:59 ส่ง email ไหม ถึงใคร
sendToSYSMgr - 
sendToNOCMgr - 
sendToGITMgr - 
sendToTRAMgr - 
sendToOFHMgr - 
 * */

class ticketslamacro extends OtherModule {
    
    protected $modname = 'Ticket sla macro';
    protected $description = '
    Ticket sla macro by rvglobalsoft
    config setting (
    {sendToCSMgr}|
    {Mon:1,Tue:2..Sun:0}|
    {1[00:00-07:00],2[07:00-18:00],3[18:00-24:00]})';
    // Configuration
    
    public $configuration = array(
         'OFH KPI Controller E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'OFH KPI Controller E-mail'
        ),
        //=== sendToCSMgr ===
        'sendToCSMgr-email' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'sendToCSMgr E-mail'
        ),
        //=== sendToCSMgr : Monday
        'sendToCSMgr|1|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Monday 0:00-07:00'
        ),
        'sendToCSMgr|1|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Monday 07:00-18:00'
        ),
        'sendToCSMgr|1|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Monday 18:00-24:00'
        ),
         //=== sendToCSMgr : Tuesday
        'sendToCSMgr|2|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Tuesday 0:00-07:00'
        ),
        'sendToCSMgr|2|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Tuesday 07:00-18:00'
        ),
        'sendToCSMgr|2|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Tuesday 18:00-24:00'
        ),
         //=== sendToCSMgr : Wednesday
        'sendToCSMgr|3|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Wednesday 0:00-07:00'
        ),
        'sendToCSMgr|3|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Wednesday 07:00-18:00'
        ),
        'sendToCSMgr|3|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Wednesday 18:00-24:00'
        ),
         //=== sendToCSMgr : Thursday
        'sendToCSMgr|4|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Thursday 0:00-07:00'
        ),
        'sendToCSMgr|4|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Thursday 07:00-18:00'
        ),
        'sendToCSMgr|4|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Thursday 18:00-24:00'
        ),
         //=== sendToCSMgr : Friday
        'sendToCSMgr|5|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Friday 0:00-07:00'
        ),
        'sendToCSMgr|5|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Friday 07:00-18:00'
        ),
        'sendToCSMgr|5|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Friday 18:00-24:00'
        ),
         //=== sendToCSMgr : Saturday
        'sendToCSMgr|6|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Saturday 0:00-07:00'
        ),
        'sendToCSMgr|6|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Saturday 07:00-18:00'
        ),
        'sendToCSMgr|6|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Saturday 18:00-24:00'
        ),
         //=== sendToCSMgr : Sunday
        'sendToCSMgr|0|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Sunday 0:00-07:00'
        ),
        'sendToCSMgr|0|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Sunday 07:00-18:00'
        ),
        'sendToCSMgr|0|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToCSMgr Send email to Manager on Sunday 18:00-24:00'
        ),
        //=== sendToSYSMgr ===
        'sendToSYSMgr E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'sendToSYSMgr E-mail'
        ),
        //=== sendToSYSMgr : Monday
        'sendToSYSMgr|1|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Monday 0:00-07:00'
        ),
        'sendToSYSMgr|1|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Monday 07:00-18:00'
        ),
        'sendToSYSMgr|1|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Monday 18:00-24:00'
        ),
         //=== sendToSYSMgr : Tuesday
        'sendToSYSMgr|2|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Tuesday 0:00-07:00'
        ),
        'sendToSYSMgr|2|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Tuesday 07:00-18:00'
        ),
        'sendToSYSMgr|2|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Tuesday 18:00-24:00'
        ),
         //=== sendToSYSMgr : Wednesday
        'sendToSYSMgr|3|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Wednesday 0:00-07:00'
        ),
        'sendToSYSMgr|3|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Wednesday 07:00-18:00'
        ),
        'sendToSYSMgr|3|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Wednesday 18:00-24:00'
        ),
         //=== sendToSYSMgr : Thursday
        'sendToSYSMgr|4|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Thursday 0:00-07:00'
        ),
        'sendToSYSMgr|4|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Thursday 07:00-18:00'
        ),
        'sendToSYSMgr|4|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Thursday 18:00-24:00'
        ),
         //=== sendToSYSMgr : Friday
        'sendToSYSMgr|5|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Friday 0:00-07:00'
        ),
        'sendToSYSMgr|5|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Friday 07:00-18:00'
        ),
        'sendToSYSMgr|5|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Friday 18:00-24:00'
        ),
         //=== sendToSYSMgr : Saturday
        'sendToSYSMgr|6|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Saturday 0:00-07:00'
        ),
        'sendToSYSMgr|6|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Saturday 07:00-18:00'
        ),
        'sendToSYSMgr|6|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Saturday 18:00-24:00'
        ),
         //=== sendToSYSMgr : Sunday
        'sendToSYSMgr|0|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Sunday 0:00-07:00'
        ),
        'sendToSYSMgr|0|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Sunday 07:00-18:00'
        ),
        'sendToSYSMgr|0|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToSYSMgr Send email to Manager on Sunday 18:00-24:00'
        ),
        //=== sendToNOCMgr ===
        'sendToNOCMgr E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'sendToNOCMgr E-mail'
        ),
        //=== sendToNOCMgr : Monday
        'sendToNOCMgr|1|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Monday 0:00-07:00'
        ),
        'sendToNOCMgr|1|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Monday 07:00-18:00'
        ),
        'sendToNOCMgr|1|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Monday 18:00-24:00'
        ),
         //=== sendToNOCMgr : Tuesday
        'sendToNOCMgr|2|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Tuesday 0:00-07:00'
        ),
        'sendToNOCMgr|2|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Tuesday 07:00-18:00'
        ),
        'sendToNOCMgr|2|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Tuesday 18:00-24:00'
        ),
         //=== sendToNOCMgr : Wednesday
        'sendToNOCMgr|3|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Wednesday 0:00-07:00'
        ),
        'sendToNOCMgr|3|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Wednesday 07:00-18:00'
        ),
        'sendToNOCMgr|3|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Wednesday 18:00-24:00'
        ),
         //=== sendToNOCMgr : Thursday
        'sendToNOCMgr|4|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Thursday 0:00-07:00'
        ),
        'sendToNOCMgr|4|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Thursday 07:00-18:00'
        ),
        'sendToNOCMgr|4|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Thursday 18:00-24:00'
        ),
         //=== sendToNOCMgr : Friday
        'sendToNOCMgr|5|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Friday 0:00-07:00'
        ),
        'sendToNOCMgr|5|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Friday 07:00-18:00'
        ),
        'sendToNOCMgr|5|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Friday 18:00-24:00'
        ),
         //=== sendToNOCMgr : Saturday
        'sendToNOCMgr|6|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Saturday 0:00-07:00'
        ),
        'sendToNOCMgr|6|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Saturday 07:00-18:00'
        ),
        'sendToNOCMgr|6|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Saturday 18:00-24:00'
        ),
         //=== sendToNOCMgr : Sunday
        'sendToNOCMgr|0|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Sunday 0:00-07:00'
        ),
        'sendToNOCMgr|0|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Sunday 07:00-18:00'
        ),
        'sendToNOCMgr|0|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToNOCMgr Send email to Manager on Sunday 18:00-24:00'
        ),
        //=== sendToGITMgr ===
        'sendToGITMgr E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'sendToGITMgr E-mail'
        ),
        //=== sendToGITMgr : Monday
        'sendToGITMgr|1|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Monday 0:00-07:00'
        ),
        'sendToGITMgr|1|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Monday 07:00-18:00'
        ),
        'sendToGITMgr|1|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Monday 18:00-24:00'
        ),
         //=== sendToGITMgr : Tuesday
        'sendToGITMgr|2|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Tuesday 0:00-07:00'
        ),
        'sendToGITMgr|2|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Tuesday 07:00-18:00'
        ),
        'sendToGITMgr|2|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Tuesday 18:00-24:00'
        ),
         //=== sendToGITMgr : Wednesday
        'sendToGITMgr|3|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Wednesday 0:00-07:00'
        ),
        'sendToGITMgr|3|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Wednesday 07:00-18:00'
        ),
        'sendToGITMgr|3|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Wednesday 18:00-24:00'
        ),
         //=== sendToGITMgr : Thursday
        'sendToGITMgr|4|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Thursday 0:00-07:00'
        ),
        'sendToGITMgr|4|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Thursday 07:00-18:00'
        ),
        'sendToGITMgr|4|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Thursday 18:00-24:00'
        ),
         //=== sendToGITMgr : Friday
        'sendToGITMgr|5|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Friday 0:00-07:00'
        ),
        'sendToGITMgr|5|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Friday 07:00-18:00'
        ),
        'sendToGITMgr|5|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Friday 18:00-24:00'
        ),
         //=== sendToGITMgr : Saturday
        'sendToGITMgr|6|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Saturday 0:00-07:00'
        ),
        'sendToGITMgr|6|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Saturday 07:00-18:00'
        ),
        'sendToGITMgr|6|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Saturday 18:00-24:00'
        ),
         //=== sendToGITMgr : Sunday
        'sendToGITMgr|0|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Sunday 0:00-07:00'
        ),
        'sendToGITMgr|0|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Sunday 07:00-18:00'
        ),
        'sendToGITMgr|0|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToGITMgr Send email to Manager on Sunday 18:00-24:00'
        ),
        //=== sendToTRAMgr ===
        'sendToTRAMgr E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'sendToTRAMgr E-mail'
        ),
        //=== sendToTRAMgr : Monday
        'sendToTRAMgr|1|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Monday 0:00-07:00'
        ),
        'sendToTRAMgr|1|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Monday 07:00-18:00'
        ),
        'sendToTRAMgr|1|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Monday 18:00-24:00'
        ),
         //=== sendToTRAMgr : Tuesday
        'sendToTRAMgr|2|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Tuesday 0:00-07:00'
        ),
        'sendToTRAMgr|2|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Tuesday 07:00-18:00'
        ),
        'sendToTRAMgr|2|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Tuesday 18:00-24:00'
        ),
         //=== sendToTRAMgr : Wednesday
        'sendToTRAMgr|3|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Wednesday 0:00-07:00'
        ),
        'sendToTRAMgr|3|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Wednesday 07:00-18:00'
        ),
        'sendToTRAMgr|3|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Wednesday 18:00-24:00'
        ),
         //=== sendToTRAMgr : Thursday
        'sendToTRAMgr|4|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Thursday 0:00-07:00'
        ),
        'sendToTRAMgr|4|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Thursday 07:00-18:00'
        ),
        'sendToTRAMgr|4|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Thursday 18:00-24:00'
        ),
         //=== sendToTRAMgr : Friday
        'sendToTRAMgr|5|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Friday 0:00-07:00'
        ),
        'sendToTRAMgr|5|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Friday 07:00-18:00'
        ),
        'sendToTRAMgr|5|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Friday 18:00-24:00'
        ),
         //=== sendToTRAMgr : Saturday
        'sendToTRAMgr|6|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Saturday 0:00-07:00'
        ),
        'sendToTRAMgr|6|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Saturday 07:00-18:00'
        ),
        'sendToTRAMgr|6|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Saturday 18:00-24:00'
        ),
         //=== sendToTRAMgr : Sunday
        'sendToTRAMgr|0|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Sunday 0:00-07:00'
        ),
        'sendToTRAMgr|0|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Sunday 07:00-18:00'
        ),
        'sendToTRAMgr|0|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToTRAMgr Send email to Manager on Sunday 18:00-24:00'
        ),
        //=== sendToOFHMgr ===
        'sendToOFHMgr E-mail' => array(
            'value' => '',
            'type' => 'input',
            'description' => 'sendToOFHMgr E-mail'
        ),
        //=== sendToOFHMgr : Monday
        'sendToOFHMgr|1|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Monday 0:00-07:00'
        ),
        'sendToOFHMgr|1|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Monday 07:00-18:00'
        ),
        'sendToOFHMgr|1|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Monday 18:00-24:00'
        ),
         //=== sendToOFHMgr : Tuesday
        'sendToOFHMgr|2|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Tuesday 0:00-07:00'
        ),
        'sendToOFHMgr|2|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Tuesday 07:00-18:00'
        ),
        'sendToOFHMgr|2|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Tuesday 18:00-24:00'
        ),
         //=== sendToOFHMgr : Wednesday
        'sendToOFHMgr|3|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Wednesday 0:00-07:00'
        ),
        'sendToOFHMgr|3|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Wednesday 07:00-18:00'
        ),
        'sendToOFHMgr|3|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Wednesday 18:00-24:00'
        ),
         //=== sendToOFHMgr : Thursday
        'sendToOFHMgr|4|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Thursday 0:00-07:00'
        ),
        'sendToOFHMgr|4|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Thursday 07:00-18:00'
        ),
        'sendToOFHMgr|4|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Thursday 18:00-24:00'
        ),
         //=== sendToOFHMgr : Friday
        'sendToOFHMgr|5|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Friday 0:00-07:00'
        ),
        'sendToOFHMgr|5|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Friday 07:00-18:00'
        ),
        'sendToOFHMgr|5|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Friday 18:00-24:00'
        ),
         //=== sendToOFHMgr : Saturday
        'sendToOFHMgr|6|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Saturday 0:00-07:00'
        ),
        'sendToOFHMgr|6|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Saturday 07:00-18:00'
        ),
        'sendToOFHMgr|6|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Saturday 18:00-24:00'
        ),
         //=== sendToOFHMgr : Sunday
        'sendToOFHMgr|0|1' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Sunday 0:00-07:00'
        ),
        'sendToOFHMgr|0|2' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Sunday 07:00-18:00'
        ),
        'sendToOFHMgr|0|3' => array(
            'value' => '0',
            'type' => 'check',
            'description' => 'sendToOFHMgr Send email to Manager on Sunday 18:00-24:00'
        ),
        
    );


     /*
     public static function genArray(){
       //  $aConfig = array('sendToCSMgr', 'sendToSYSMgr', 'sendToNOCMgr', 'sendToGITMgr', 'sendToTRAMgr', 'sendToOFHMgr');
         $aConfig = array('sendToCSMgr');
         //$aDay = array('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
         $aDay = array('Monday');
         $aTime = array('00:00-07:00', '07:00-18:00', '18:00-24:00');
         $g=1;
         foreach($aConfig as $kConfig){
             $mailToMgr = $kConfig.' E-mail:'.$g;
             $vvconfiguration[$mailToMgr] = array(
                'value' => '',
                'type' => 'input',
                'description' => $mailToMgr
             );
             $g++;
             foreach($aDay as $kDay){
                 foreach ($aTime as $kTime) {
                     $kByDayTime = $kConfig . ' Send email to Manager on ' . $kDay . ' ' . $kTime.'::'.$g;
                     $vvconfiguration[$kByDayTime] = array(
                        'value' => '',
                        'type' => 'check',
                        'description' => $kByDayTime
                     );
                     $g++;
                 }
             }
         }
         echo '<pre>';print_r('vvvvvvvvvvvvvvvvvvvvvvvvvvvv');
         return $vvconfiguration;
     }*/
     
}



























