<?php

/*************************************************************
 *
 * Hosting Module Class - Symantecvip
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/client-area/
https://manage2.cpanel.net/
u: Rv97Pj3W
p: ,o^db0wl;
 *
 * fetchLicenseId
 * SimpleXMLElement Object
(
    [@attributes] => Array
        (
            [reason] => OK
            [status] => 1
        )

    [licenseid] => 15964419
)
 *  
 fetchlicense
 * Array
(
    [@attributes] => Array
        (
            [name] => L10135475
            [adddate] => 1344011220
            [distro] => centos enterprise 5.8
            [envtype] => standard
            [expiredon] => 
            [expirereason] => 
            [groupid] => 45025
            [hostname] => webserv.stock2morrow.com
            [ip] => 202.44.53.242
            [licenseid] => 10135475
            [maxusers] => 
            [os] => Linux
            [osver] => 2.6.18-194.11.3.el5
            [packageid] => 799
            [packageqty] => 1
            [status] => 1
            [updateexpiretime] => 
            [version] => 11.28.83-RELEASE_51164
        )

)
 * 
 ************************************************************/

require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvcpanel_manage2_controller extends HBController 
{
    protected $moduleName = "rvcpanel_manage2";
    protected $cpl;
    
    public function view($request) {
      
        
    }
    
    public function saveDataPriceLinkCpanel(){
        //return true;
        $product_id = $_POST['id'];
        foreach ($_POST['cpanel'] as $k => $v) { 
            $aData = array(
                'product_id' => $product_id,
                'price_code' => $k,
                'cpl_group' => $v['group'],
                'cpl_package' =>$v['package']
            );
            $res = RVCPanelDao::singleton()->saveDataPriceLinkCpanel($aData);
        } 
        
    }
    
    public function chkClassCpanelLicense()
    {
		if (!class_exists('cPanelLicensing' , false) && (!class_exists('cpanellicensing',false))) {
			require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
		}
    }

    public function productdetails($params) 
    {
        $productid  = ($params['product_id'] == '') ? $params['id'] :$params['product_id'];
        $aWhere = array('rel'=>'1','id'=>$productid);
        $aProductPrice = RVCPanelDao::singleton()->getProductPcice($aWhere);
        $serverId = RVCPanelDao::singleton()->getIdServerRvCpanel();
        $aListPrice = array();
        $aSetPriceDef = array();
        //=== ถ้าหา server id ไม่ได้ก็ connect กับ cpanel ไม่ได้
        if (isset($serverId[0]['id'])== false && $serverId[0]['id'] == '') {
            echo 'Error';
        } else {
            $api = new ApiWrapper();
            $aServerDtl = $api->getServerDetails(array('id'=>$serverId[0]['id']));
            if (isset($aServerDtl['success']) && $aServerDtl['success'] == 1) {
                $this->chkClassCpanelLicense();
                $this->cpl = new cPanelLicensing($aServerDtl['server']['username'], $aServerDtl['server']['password']);
                $this->template->assign('aGroup',$this->getGroupByCpanel());
                $this->template->assign('aPackage',$this->getPackagesByCpanel());
            } else { echo 'no get api server detail';}
            $txtHeadPrice = 'Regular';

            if ($aProductPrice[0]['paytype'] == 'Once') {
                $txtHeadPrice = 'Once';
                $aListPrice['m'] = $aProductPrice[0]['m'];
            } else {
                unset($aProductPrice[0]['rel'],$aProductPrice[0]['paytype']);
                $aListPrice = $aProductPrice[0];
            }
            //echo $productid;
            $aGetPriceLinkCpanel = RVCPanelDao::singleton()->getDataPriceLinkCpanel(array('product_id'=>$productid));
            foreach($aGetPriceLinkCpanel as $k=>$v){
                $aSetPriceDef[$v['price_code']] = array('cpl_group'=>$v['cpl_group'],'cpl_package'=>$v['cpl_package']);
            }
           // echo '<pre>';print_r($aSetPriceDef);
        }
        $this->template->assign('aPrice',$aListPrice);
        
        $this->template->assign('aPriceDef',$aSetPriceDef);
        $path_to_yourtpl = APPDIR_MODULES.'Hosting/rvcpanel_manage2/templates/admin_configproduct.tpl';
        $this->template->assign('customconfig',$path_to_yourtpl);
    }
    
    public function getPackagesByCpanel()
    {
        $res = array();
        $lisc = $this->cpl->fetchPackages();
        if ($lisc instanceof SimpleXMLElement) {
            if (isset($lisc->packages[0])) {
                foreach ( $lisc->packages[0]->attributes() as $liscd=>$v) {
                    $v = (array)$v;
                    $res[$liscd]=$v[0];
                }
            }
        }
        return $res;
    
    }
    
    public function getGroupByCpanel()
    {
        $res = array();;
        $lisc = $this->cpl->fetchGroups();
        if ($lisc instanceof SimpleXMLElement) {
            if (isset($lisc->groups[0])) {
                foreach ( $lisc->groups[0]->attributes() as $liscd=>$v) {
                    $v = (array)$v;
                    $res[$liscd]=$v[0];
                }
            }
        } 
        return $res;
    }
    private function getLicenseId($accountId) 
    {
        $aLicense =  RVCPanelDao::singleton()->getDataLogCpanel(array('account_id'=>$accountId));
        if (count($aLicense) > 0) {
            return $aLicense[0];
        }
        return '';
    }
    
    /**
     *
     * Enter description here ...
     * @param $params
     */
    public function accountdetails($params) 
    {
        $this->template->assign('custom', array('Changeip','transferred'));
        $this->template->assign('ischangeip', true);
        //=== check button custom changeip ====
        if (isset($params['customfn']) && $params['customfn'] !='' && method_exists($this,$params['customfn'])) {
            $this->{$params['customfn']}($params);
             //$this->Changeip($params);
        }
        
        //=== case display info license
        //$aDataLicense = $this->getLicenseId($params['account']['id']);
        if ($params['account']['id'] != '') {
            $aDtlLicense = array();
            $api = new ApiWrapper();
            $aServerDtl = $api->getServerDetails(array('id'=>$params['account']['server_id'])); 
            if (isset($aServerDtl['success']) && $aServerDtl['success'] == 1) {
                $this->chkClassCpanelLicense();
                
                $this->cpl = new cPanelLicensing($aServerDtl['server']['username'], $aServerDtl['server']['password']);
				$aGetIp = RVProductLicenseDao::singleton()->getIpByAccountId($params['account']['id']);
				//echo '<pre>';print_r($aGetIp);
				if ((count($aGetIp) > 0)){
					$dataLicense = $this->cpl->fetchLicenseId(array('ip'=>$aGetIp['data']));
	                
	                if($dataLicense instanceof SimpleXMLElement && $dataLicense->attributes()->status  == 1) {
						$licenseid = (string)$dataLicense->licenseid;
						$lisc = $this->cpl->fetchLicenses();
		                
		                if($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
		                    foreach ( $lisc->licenses as $lisc ) {
		                        $lisc = (array)$lisc;
		                        if ($licenseid != $lisc['@attributes']['licenseid']) { continue; }
		                        $aDtlLicense = $lisc['@attributes'];
		                        $aDtlLicense['adddate'] = date("F, d Y", $aDtlLicense['adddate']);
		                    } 
		                }
	                }
				}
               
            }
		    if (count($aDtlLicense) > 0){ 
	            $this->template->assign('aDtlLicense', $aDtlLicense);
	            $accountDtl = APPDIR_MODULES . "Hosting/rvcpanel_manage2/templates/admin_cpanellicense_dtl.tpl";
	            $this->template->assign('custom_template', $accountDtl);
			}
        
        }
       
 
        //$this->template->assign('aLicenseid', $getLicenseId);

        
    }

    
    public function Changeip($params)
    {
        if (!class_exists('cPanelLicensing' , false) && (!class_exists('cpanellicensing',false))) {
            require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
        }

        $api = new ApiWrapper();
        $aServerDtl = $api->getServerDetails(array('id'=>$params['server_id'])); 
        if (isset($aServerDtl['success']) && $aServerDtl['success'] == 1) {
            $this->cpl = new cPanelLicensing($aServerDtl['server']['username'], $aServerDtl['server']['password']);
            
            $aGetIp = RVProductLicenseDao::singleton()->findIpFormCustom($params['custom'],$params['account_id']);
            if ((count($aGetIp) > 0) && isset($params['mod_rvcpanel_manage2_ip']) && $params['mod_rvcpanel_manage2_ip'] != '') {
                $aCpl = array(
                    'oldip' => $aGetIp['ip'],
                    'newip' => $params['mod_rvcpanel_manage2_ip']
                );
                $licenseid = '';
                $dataLicense = $this->cpl->fetchLicenseId(array('ip'=>$aGetIp['ip']));
                if($dataLicense instanceof SimpleXMLElement && $dataLicense->attributes()->status  == 1) {
					$licenseid = (string)$dataLicense->licenseid;
                }
                $lisc = $this->cpl->changeip($aCpl);
                if($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
                    
                    $resUpdateIp = RVProductLicenseDao::singleton()->UpdateIpFormCustom(array(
                                'data' => $params['mod_rvcpanel_manage2_ip'],
                                'account_id' => $params['account_id'],
                                'config_cat' => $aGetIp['config_cat'],
                                'config_id' => $aGetIp['config_id']
                                ));
                    $resLog = RVCPanelDao::singleton()->insertDataLogCpanel(array(
                                'account_id' => $params['account_id'],
                                'licenseid' => $licenseid,
                                'ip' => $params['mod_rvcpanel_manage2_ip'],
                                'reason' => $lisc->attributes()->reason,
                                'action' => 'changeip'
                                ));
                    
                    return true;           
                }
            }

        }
        return false;//$res;
    }
    /**
     *
     * Enter description here ...
     */
    public function getModuleName() 
    {
        return "rvcpanel_manager2";
    }
    
   
}