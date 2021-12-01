<?php

require_once HBFDIR_LIBS . DS . 'resty' . DS . 'class.resty.php';

$r = new Resty();
$r->setBaseURL(stristr($app['ip'], 'http') ? $app['ip'] : "http://{$app['ip']}/");
$r->setCredentials($app['read'], $app['write']);
$r->useCurl(true);

$page = $r->get();
$ports = array();

if (preg_match_all('/([^<>]+)<\/TD><TD><A.*?(\d+)">.*?(ON|OFF)/i', $page['body'], $match)) {
    foreach($match[1] as $key=>$name){
        $ports[$match[2][$key]] = $name;
    }
}


