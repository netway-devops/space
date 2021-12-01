<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
$aAdmin     = hbm_logged_admin();
// --- hostbill helper ---

$ssl_id = $this->_tpl_vars['REQUEST']['ssl_id'];

$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
$oSSL = $oAuth->request('get', 'sslitems', array('id' => $ssl_id));
$pid = $oSSL->pid;

$aPrice = (array) $oSSL->_Price;

$setDefault = 12;
$selectConract = ($this->_tpl_vars['REQUEST']['ssl_price'])
	? $this->_tpl_vars['REQUEST']['ssl_price']
	: $setDefault;


$oAllSSL = $oAuth->request('get', 'sslallitems', array('showby' => 'validation'));
$aAllSSL = (array) $oAllSSL->items;

$aRelatedbyValidate = array();

foreach ($aAllSSL as $k => $v) {
	if ($k != $oSSL->ssl_validation_id) {
		continue;
	}
	foreach ($v->_Certificate as $ck => $cv) {
		if ($cv->ssl_id == $aSSL->ssl_id) {
			continue;
		}
		$aRelatedbyValidate[$cv->ssl_id] = $cv->ssl_name;
	}
}

$oAllSSL = $oAuth->request('get', 'sslallitems', array('showby' => 'authority'));
$aAllSSL = (array) $oAllSSL->items;



$aRelatedbyAuthority = array();
foreach ($aAllSSL as $k => $v) {
	if ($k != $oSSL->ssl_authority_id) {
		continue;
	}
	foreach ($v->_Certificate as $ck => $cv) {
		if ($cv->ssl_id == $aSSL->ssl_id) {
			continue;
		}
		$aRelatedbyAuthority[$cv->ssl_id] = $cv->ssl_name;
	}
}
$isSuportServer = true;
if ($oSSL->ssl_authority_id == 1 || $oSSL->ssl_authority_id == 5 ) {
    $aWebSV = array(
		'Microsoft IIS (all versions)' => 'Microsoft IIS (all versions)',
		'other' => 'Other',
        );
} else {
    $isSuportServer = false;
    $aWebSV = array('-Not required-'=>'-Not required-');
}

$CSRForTest = '';
/*
$CSRForTest = '-----BEGIN CERTIFICATE REQUEST-----
MIIDKjCCAhICAQAwgckxCzAJBgNVBAYTAlRIMQ0wCwYDVQQIDAROb25lMRAwDgYD
VQQHDAdCYW5na29rMSYwJAYDVQQKDB1OZXR3YXkgQ29tbXVuaWNhdGlvbiBDby4s
THRkLjEdMBsGA1UECwwUU29mdHdhcmUgRGV2ZWxvcG1lbnQxKjAoBgNVBAMMIWNw
YW5lbG1vZHVsZWRldjEucnZnbG9iYWxzb2Z0Lm5ldDEmMCQGCSqGSIb3DQEJARYX
YW1hcmluQHJ2Z2xvYmFsc29mdC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDnBtN3zY3OK2V7QtTQgSU8ZxJDc5FGMpuDO73mUQ5AznfRZUk7EV1v
acejxe+zSV3oR+uVkBD21r5yh0CVIMjXd2z8N9BZBSJT9RlWOMLgghXj20r8Ynzf
HiTPMFR8avKteR+NP5sgQ4OCvO3oTg+txICSlQd28zCwbgfkIM6ZZ8Awbu8pXDPs
W7Kk0TWt5rDGJdkvF6Noj2hnapJPxZjGfEkYonpxLw5Am1CABt62RqJOZFHDWdTg
el+KbHoxS1wuLtPW/NyT3RTudj/zfwxxEdQZQxmODAwRQ5zd8ts2+2KfJ43AzG5t
0extDDLOyDV+s9fUP1eAIEM/GvIdyUM9AgMBAAGgGzAZBgkqhkiG9w0BCQcxDAwK
YmFuZ2tvazU0ODANBgkqhkiG9w0BAQUFAAOCAQEA41zyTbg1euZZDSlGJzatpfff
frAi3kkPyLTq82NfkhMYMt5WJSZlgGmSygLq4UrVIeDaCwbCe+FxTo5ZHush4eVC
E5+SAORXaEWPc5wBL0ypjgk2RHLXG7ySnOaBC5qvfXuEyFOYJV16ApzUnyaniFEd
wy7AKz5mAiLcyPqPNCqS9BqLwG3r2rpMgNHR3aN00kzanByYWmdPd93B+XbjQ1J8
FSDSqLwE+Gh3v9gqDIx70YNHYlZpS3a67LErZUOKvyB5SY5hnGoBslINbIAl2mch
bg3oxC9wAMxFQJD1wtDqcTi9MpGcSbavKM0JE374hK1XOxCDPavZBJUXuG7PKA==
-----END CERTIFICATE REQUEST-----';
*/

$aSSL = (array) $oSSL;
/// Assing Output to Smarty
$this->assign('aSSL', $aSSL);
$this->assign('selectConract', $selectConract);
$this->assign('aRelatedbyValidate', $aRelatedbyValidate);
$this->assign('aRelatedbyAuthority', $aRelatedbyAuthority);
$this->assign('aSupportServer', $aWebSV);
$this->assign('isSupportServer', $isSuportServer);
$this->assign('ssl_id', $ssl_id);
$this->assign('pid', $pid);
$this->assign('csrData', $CSRForTest);
