<?php 
require_once HBFDIR_LIBS . 'RvLibs/RvapikeyMgr.php';
$module = new RvapikeyMgr();
if (isset($_POST['rv_action']) && $_POST['rv_action'] == 'dogen') {
	$module->user_genNewKey();
}
$this->assign('showapikey',$module->user_showapikey());
