<?php
/*
HostBill servers status file
Last modification: 25.03.2010
Put this file on server you'd like to monitor via HostBill.
Update your server status url in HostBill server configuration section so it'll
match this file url.

If somehow you're using different than standard ports for monitored services,
make sure you've updated $ports variable below.

If for services you want to monitor other host than localhost, change $hosts values

 */

$ports=array(
    'FTP'=>'21',
    'SSH'=>'22',
    'IMAP'=>'143',
    'POP3'=>'110',
    'MYSQL'=>'3306',
);

$hosts=array(
    'FTP'=>'localhost',
    'SSH'=>'localhost',
    'IMAP'=>'localhost',
    'POP3'=>'localhost',
    'MYSQL'=>'localhost'
);

$resp=array();
ob_start();
if(isset($_POST['FTP'])) {
    if(fsockopen($hosts['FTP'], $ports['FTP'], $errno, $errstr, 3) != false) {
        $resp['FTP']='1';
    } else {
        $resp['FTP']='0';
    }

}
if(isset($_POST['SSH'])) {
    if(fsockopen($hosts['SSH'], $ports['SSH'], $errno, $errstr, 3) != false) {
        $resp['SSH']='1';
    } else {
        $resp['SSH']='0';
    }

}
if(isset($_POST['IMAP'])) {
    if(fsockopen($hosts['IMAP'], $ports['IMAP'], $errno, $errstr, 3) != false) {
        $resp['IMAP']='1';
    } else {
        $resp['IMAP']='0';
    }

}
if(isset($_POST['POP3'])) {
    if(fsockopen($hosts['POP3'], $ports['POP3'], $errno, $errstr, 3) != false) {
        $resp['POP3']='1';
    } else {
        $resp['POP3']='0';
    }

}
if(isset($_POST['MYSQL'])) {
    if(fsockopen($hosts['MYSQL'], $ports['MYSQL'], $errno, $errstr, 3) != false) {
        $resp['MYSQL']='1';
    } else {
        $resp['MYSQL']='0';
    }

}
if(isset($_POST['LOAD'])) {
    $load=file_get_contents("/proc/loadavg");
    if($load===false || $load=='') {
        $load = trim (exec ('uptime'));
        if ($load) {
            if (preg_match ('/: (.*), (.*), (.*)/', $load, $loads))
                $resp['LOAD'] = $loads[1];
        }
        else {
            $resp['LOAD'] = 'FALSE';
        }
    } else {
        $load = explode(" ",$load);
        $resp['LOAD']=$load[0];
    }


}

if(isset($_POST['UPTIME'])) {
    $uptime = file_get_contents("/proc/uptime");
    if($uptime===false || $uptime=='') {
       $resp['UPTIME'] = shell_exec ('cut -d. -f1 /proc/uptime');
    } else {
        $uptime = explode(" ",trim($uptime));
        $resp['UPTIME']=substr($uptime[0],0,strpos($uptime[0],'.'));
    }
    

}
ob_end_clean();
if(!empty($resp)) {
    $r=array();
    foreach($resp as $k=>$v) {
        $r[]=$k.':'.$v;
    }
    die(implode('|',$r));
}

?>
