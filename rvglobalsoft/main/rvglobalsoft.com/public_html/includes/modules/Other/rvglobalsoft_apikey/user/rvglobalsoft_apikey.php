<?php 
if (isset($_POST['rv_action']) && $_POST['rv_action'] == 'dogen') {
	$module->user_genNewKey();
	$module->show_info('คุณได้ทำการ Generate API Key ใหม่ ดังนั้นการ connect จากส่วนต่างๆที่เคยติดตั้งไว้จะใช้งานไม่ได้ โปรดนำค่า API Key ที่ได้ใหม่ไปอับเดจ');
}

$module->template->assign('showapikey',$module->user_showapikey());