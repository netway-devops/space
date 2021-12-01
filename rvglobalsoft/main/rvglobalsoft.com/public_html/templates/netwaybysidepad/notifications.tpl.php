<?php


/*
 You have reached your limit for
<strong>2-factor Authentication for WHM</strong>
service
 * */
//$_SESSION['Upgrade']['config'][13]['new_qty'] = ;
 //echo '<pre>'.print_r($this->_tpl_vars,TRUE).'</pre>';
$aError = $this->_tpl_vars['error'];
$path = $this->_tpl_vars['template_dir'];
//$aError = array('You have reached your limit for <strong>2-factor Authentication for WHM</strong> service');
if (isset($aError[0]) && preg_match("/\s*limit for\s*<strong>\s*2-factor Authentication\s*/i", $aError[0])){
	unset($aError[0]);
	$this->assign('error', $aError);
	echo '<img src="' . $path . 'img/message.png">';
}