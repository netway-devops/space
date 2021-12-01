<?php 
require_once HBFDIR_LIBS . 'RvLibs/RvCpUsers.php';
$module =& new RvCpUsers();

$this->assign('isRoot',$module->isRoot());