<?php
require_once HBFDIR_LIBS . 'RvLibs/RvRootCommission.php';

class rootcommission_controller extends HBController
{
	public function _default ($request)
	{
		$db     = hbm_db();
	}
	
	public function getreport($request)
	{
		$db     = hbm_db();
		$date = $request['date'];
		$module =& new RvRootCommission();
		$aReports = $module->getReports($date);

		$totalCommission = 0;
		$aSummery = array(
			'ssl' => 0,
			'vip' => 0,
		);

		foreach ($aReports[1] as $k => $v) {
			$aSummery['ssl'] = $aSummery['ssl'] + $v['commission'];
			$totalCommission = $totalCommission + $v['commission'];
		}
		foreach ($aReports[2] as $k => $v) {
			$aSummery['vip'] = $aSummery['vip'] + $v['commission'];
			$totalCommission = $totalCommission + $v['commission'];
		}
		/// Get VIP reports
		$this->template->assign('date', $date);
		$this->template->assign('aReports', $aReports);
		$this->template->assign('totalCommission', $totalCommission);
		$this->template->assign('aSummery', $aSummery);
		
		$this->_beforeRender();
		$this->template->display(dirname(dirname(__FILE__)) . '/templates/user/reports.tpl',array(), true); 
	}
	
	private function _beforeRender()
	{
		$this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
		$this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__))))))
		. '/templates/');
	}
}