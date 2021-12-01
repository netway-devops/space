<?php 
require_once HBFDIR_LIBS . 'RvLibs/RvRootCommission.php';
require_once HBFDIR_LIBS . 'RvLibs/RvCpUsers.php';
$module =& new RvRootCommission();
$oCpUsers =& new RvCpUsers();

$this->assign('isRoot',$oCpUsers->isRoot());
$this->assign('CommissionBalance', $module->getCommissionBalance());
$this->assign('TotalWithdrawn', $module->getTotalWithdrawn());
$this->assign('aReportDate', $module->getReportDate());