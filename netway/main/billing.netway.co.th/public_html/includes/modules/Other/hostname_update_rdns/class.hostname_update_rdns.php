<?php

/*************************************************************
 *
 * Other Module Class - Hostname Update rDNS
 * 
 *  https://dev.hostbillapp.com/dev-kit/advanced-topics/adding-cron-to-your-modules/ 
 * 
 ************************************************************/

class hostname_update_rdns extends OtherModule {
    protected $filename = 'class.hostname_update_rdns.php';
    protected $description = '***NETWAY*** ***** รอยกเลิก ***** Update Hostname Dedicate, VPS by cron use method gethostbyaddr (rDNS) every once day.';
    protected $modname = 'Hostname Update rDNS';
}