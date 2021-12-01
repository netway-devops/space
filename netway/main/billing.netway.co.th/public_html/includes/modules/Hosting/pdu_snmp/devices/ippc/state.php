<?php

require_once HBFDIR_LIBS . DS . 'resty' . DS . 'class.resty.php';

$r = new Resty();
$r->setBaseURL(stristr($app['ip'], 'http') ? $app['ip'] : "http://{$app['ip']}/");
$r->setCredentials($app['read'], $app['write']);
$r->useCurl(true);

$page = $r->get();
$state = 0;

if (preg_match_all('/([^<>]+)<\/TD><TD><A.*?(\d+)">.*?(ON|OFF)/i', $page['body'], $match)) {
    foreach ($match[1] as $key => $name) {
        if ($port == $match[2][$key]) {
            $state = $match[3][$key] == 'ON';
            break;
        }
    }
}
if($state === 0) {
    throw new Exception("Unable to fetch current port state from PDU");
}