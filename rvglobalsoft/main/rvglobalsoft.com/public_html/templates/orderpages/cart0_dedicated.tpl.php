<?php

$aTemplatelProducts = $this->get_template_vars('products');
foreach ($aTemplatelProducts as $item => $dtl) {
	if (preg_match("/Cpanel/i", $dtl['name']) && isset($dtl['m']) && $dtl['m'] != 0) {
		$aTemplatelProducts[$item]['default_m'] = true;
		//echo '<br>OK = '.$dtl['name'];
	} elseif (isset($dtl['q']) && $dtl['q'] != 0) {
		$aTemplatelProducts[$item]['default_q'] = true;
	}
}
$this->assign('products',$aTemplatelProducts);

