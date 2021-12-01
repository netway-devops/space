<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvsitebuilder_license_controller extends HBController 
{
    protected $moduleName = 'rvsitebuilder_license';
    //public $conn;
    public function view($request) 
    {
        
    }
    
    public function accountdetails($params)
    {
        $db = hbm_db();
        $aproductNoc = array(73,74,75,76,77,78,79,80,159);
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

    private function calExpireDateMonthly(){
        $startDate = time();
        return mktime(
                                date('H', $startDate),
                                date('i', $startDate),
                                date('s', $startDate),
                                date('n', $startDate) + 1,
                                date('j', $startDate),
                                date('Y', $startDate)
                            );
    }
	
    public function Changeip($params)
    { 
      	$db 	= hbm_db();  	
        $aGetIp = RVProductLicenseDao::singleton()->findIpFormCustom($params['custom'], $params['account_id']);
        $db_ip 	= $aGetIp['ip'];
        if ((count($aGetIp) > 0) && isset($params['mod_rvcpanel_manage2_ip']) && $params['mod_rvcpanel_manage2_ip'] != '') {
            $ipnew 	= $params['mod_rvcpanel_manage2_ip'];
            $pref 	= ($_SERVER['SERVER_NAME'] == '192.168.1.82') ? 'test' : '';
           // $userId = 'hb_acc_' . $pref . $params['account_id'];
            if (!isset($params['account_id']) || $params['account_id'] == '' || $params['account_id'] == 0) {
                $this->addError('ไม่มีค่า account id');
                return false;
            }
            $accid = $params['account_id'];
			$queryLicenseUser = $db->query("
				UPDATE 
					rvsitebuilder_license 
				SET
					primary_ip=:ipnew, secondary_ip=:ipnew
            	WHERE
            		primary_ip=:db_ip 
            		AND hb_acc=:userid
				",array(
				':ipnew' 	=> $ipnew,
				':db_ip' 	=> $db_ip,
				':userid' 	=> $accid,
				
				));
            if ($queryLicenseUser) {
                $resUpdateIp = RVProductLicenseDao::singleton()->UpdateIpFormCustom(array(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                            'data' 			=> $params['mod_rvcpanel_manage2_ip'],
                            'account_id' 	=> $params['account_id'],
                            'config_cat' 	=> $aGetIp['config_cat'],
                            'config_id' 	=> $aGetIp['config_id']
                ));
                if ($resUpdateIp == true){
                    // === update ใน tril
                    $api 			= new ApiWrapper();
                    $aProductDtl 	= $api->getProductDetails(array('id' => $_POST['product_id']));
                    $db_license_type 	= ($aProductDtl['product']['options']['Server Type']=='VPS') ? 11 : 9;
                    $expiredate 		= $this->calExpireDateMonthly();
					
					$queryLicenseUserTril = $db->query("
						INSERT INTO rvsitebuilder_license_trial          
                            (license_type, main_ip, second_ip, exprie,effective_expiry) 
                        VALUES
                            (:license_type ,:main_ip, :second_ip, :exp, :exp_eff)
						",array(
						':license_type' => $db_license_type,
						':main_ip' 		=> $db_ip,
						':second_ip' 	=> $db_ip,
						':exp' 			=> $expiredate,
						':exp_eff' 		=> $expiredate,
						
						));
                    if ($queryLicenseUserTril) {
                        return true;
                    }
                } 
            }
        }
        return false;
    }
}

