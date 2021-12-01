<?php
#@LICENSE@#

require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
if (isset($_GET)) {
	foreach ($_GET as $k => $v) {
		$this->_tpl_vars['REQUEST'][$k] = "{$v}";
	}
}

if(isset($_POST)) {
	foreach ($_POST as $k => $v) {
		$this->_tpl_vars['REQUEST'][$k] = "{$v}";
	}
}

$ssl_id = $this->_tpl_vars['REQUEST']['ssl_id'];
$chksession = $_SESSION['AppSettings']['login'];
if(isset($chksession)){
	$chk = 1;
}else{
	$chk = 0;
}
/// Assign Values to Template
$this->assign('ssl_id', $ssl_id);
$this->assign('chk', $chk);
$this->assign('chksession', $chksession);