<?php





require_once HBFDIR_LIBS . DS . 'resty' . DS . 'class.resty.php';

$r = new Resty();
$r->setBaseURL(stristr($app['ip'], 'http') ? $app['ip'] : "http://{$app['ip']}/");
$r->useCurl(true);

$page = $r->get('/basic.cgi?sid=0.'.microtime(true));
if($page['body']) {
    $items = explode("\n",$page['body']);
    if($items) {
        $ports[0]=1;
    }
    $active_power = $items[17] * 1000;
} else {
    throw new Exception("Unable to access /basic.cgi on this device. Currently it should enable login-less access to work");
}
