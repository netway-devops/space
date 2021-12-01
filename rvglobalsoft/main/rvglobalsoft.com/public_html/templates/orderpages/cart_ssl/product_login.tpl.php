<?php
require_once HBFDIR_LIBS . 'RvLibs/RvGlobalSoftApi.php';
if (isset($_GET)) {
	foreach ($_GET as $k => $v) {
		$this->_tpl_vars['REQUEST'][$k] = "{$v}";
	}
}
$ssl_id = $this->_tpl_vars['REQUEST']['ssl_id'];
