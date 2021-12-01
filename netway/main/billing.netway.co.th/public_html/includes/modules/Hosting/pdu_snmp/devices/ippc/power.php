<?php

require_once HBFDIR_LIBS . DS . 'resty' . DS . 'class.resty.php';

$r = new Resty();
$r->setBaseURL(stristr($app['ip'], 'http') ? $app['ip'] : "http://{$app['ip']}/");
$r->setCredentials($app['read'], $app['write']);
$r->useCurl(true);


$return = $r->get('turn.cgi?' . $port);
HBDebug::setDebug(2);HBDebug::setTarget(16);
HBDebug::Log($return);

if (!$return['body']) {
    throw new Exception('Unable to set new power state');
}