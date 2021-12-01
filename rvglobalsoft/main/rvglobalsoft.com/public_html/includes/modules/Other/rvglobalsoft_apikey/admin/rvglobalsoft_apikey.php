<?php 
$oAuth =& RvLibs_RvGlobalSoftApi::singleton();
// $aRes = $oAuth->request('get', 'sessiontest', array());

$module->template->assign('showapikey',$module->showapikey());