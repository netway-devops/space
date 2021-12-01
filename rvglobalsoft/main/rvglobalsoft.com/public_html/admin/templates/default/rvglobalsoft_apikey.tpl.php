<?php 
require_once HBFDIR_LIBS . 'RvLibs/RvapikeyMgr.php';
$module = new RvapikeyMgr();
$this->assign('showapikey',$module->showapikey());
