<?php

$conf['svnRepositaryUrl'] = 'svn://svn.rvglobalsoft.net/trunk/web-inside/rvglobalsoft.com';
$conf['svnUserName'] = 'root';
$conf['svnPassword'] = 'gvlwvgv=5487';

$conf['projectName'] = 'rvglobalsoft.com';

$conf['moveSourceTowebFolder'] = 0;  # Seagull base or similar set this value to 0

/**
 * $conf['webFolder']
 * 
 * Main domain: set to 'public_html'
 * Addon domain: set the to 'public_html/abcde', seagull ๏ฟฝีปัญ๏ฟฝาติด๏ฟฝ๏ฟฝ้งบ๏ฟฝ addon domain ๏ฟฝ๏ฟฝ๏ฟฝ๏ฟฝ๏ฟฝ
 */
$conf['webFolder'] = 'public_html';  

####################### Don't Edit Below ###########################
$conf['protocal'] = 'http'; //'https;
$conf['tempName'] = 'temp' . md5(time());
if ($demo) {
    include_once 'demoConfig.php';
} else {
    include_once 'liveConfig.php';
}

$conf['ftpHostname'] = $conf['ip'] ? $conf['ip'] : $conf['domainName'];
$conf['tempPath'] = $conf['homePath'] . '/' . $conf['webFolder'] . '/' . $conf['tempName'];
$conf['ftpTempPath'] = $conf['webFolder'] . '/' .  $conf['tempName'];

?> 
