<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvskin_perpetual_license_controller extends HBController 
{
	protected $moduleName = 'rvskin_license';
	//public $conn;
	public function view($request) 
	{
	    
	}
	
	public function accountdetails($params)
	{
		$db	= hbm_db();
        $aproductNoc = array(73,74,75,76,77,78,79,80);
        if (in_array($params['account']['product_id'],$aproductNoc)==false){ 
			$this->template->assign('custom',array('Changeip'));
			$this->template->assign('ischangeip', true);
		    //=== check button custom changeip ====
	        if (isset($params['customfn']) && $params['customfn'] !='' && method_exists($this,$params['customfn'])) {
	            $this->{$params['customfn']}($params);
	             //$this->Changeip($params);
	        
	        }
        }
	}

	public function Changeip($params)
	{
	    $db = hbm_db();
	
        $aGetIp = RVProductLicenseDao::singleton()->findIpFormCustom($params['custom'],$params['account_id']);
        if ((count($aGetIp) > 0) && isset($params['mod_rvcpanel_manage2_ip']) && $params['mod_rvcpanel_manage2_ip'] != '') {
            $aIsVerify = $this->module->check_ip_update_na($params['mod_rvcpanel_manage2_ip']);
			
            $ipnew = $params['mod_rvcpanel_manage2_ip'];
            $ipOld = $aGetIp['ip'];
           // $userId = 'hb_acc_'.$params['account_id'];
            if (!isset($params['account_id']) || $params['account_id']=='' || $params['account_id']==0) {
                $this->addError('ไม่มีค่า account id');
                return false;
            }
            $accid = $params['account_id'];
            //$queryLicenseUser = $this->conn->query('update license_user set main_ip="'.$ipnew.'", second_ip="'.$ipnew.'" where user_id="'.$userId.'"');
            $queryLicenseUser = $db->query("
            	update 
            		rvskin_license
            	SET
            		main_ip=:ipnew, second_ip=:ipnew
              	WHERE
              		main_ip=:ipold and hb_acc=:hb_acc"
				,array(':ipnew'=>$ipnew,':ipold'=>$ipOld,':hb_acc'=>$accid));
            if ($queryLicenseUser) {
                $resUpdateIp = RVProductLicenseDao::singleton()->UpdateIpFormCustom(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                        'data' => $params['mod_rvcpanel_manage2_ip'],
                        'account_id' => $params['account_id'],
                        'config_cat' => $aGetIp['config_cat'],
                        'config_id' => $aGetIp['config_id']
                ));
                if ($resUpdateIp == true) {
                	$resInsertLogIp = RVProductLicenseDao::singleton()->InsertLogTransferIp(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                        'from_ip' => $ipOld,
                        'acc_id' => $params['account_id'],
                        'to_ip' => $ipnew,
                        'active_by' => 'admin',
                        'active_id' => $params['account_id'],
                        'product_type' => 'rvk'
                	));
					return true;
                } 
            }
        }
	  
	    return false;
	}
	
}

