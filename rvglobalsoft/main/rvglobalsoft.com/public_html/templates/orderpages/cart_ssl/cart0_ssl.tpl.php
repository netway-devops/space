<?php
#@LINENSE@#

$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
$aSSLValidation = $oAuth->request('get', 'sslvalidation');
$aSSLAuthority = $oAuth->request('get', 'sslauthority');

$this->assign('aSSLValidation', $aSSLValidation);
$this->assign('aSSLAuthority', $aSSLAuthority);