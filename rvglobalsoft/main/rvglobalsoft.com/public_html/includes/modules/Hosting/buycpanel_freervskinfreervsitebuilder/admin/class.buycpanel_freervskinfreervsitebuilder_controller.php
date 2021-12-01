<?php
require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";

class buycpanel_freervskinfreervsitebuilder_controller extends HBController
{
	protected $moduleName = "buycpanel_freervskinfreervsitebuilder";
	protected $aServerOptions = array('Dedicated','VPS');
	protected $cpl;

    public function view($request) {


    }

	public function chkClassCpanelLicense()
    {
		if (!class_exists('cPanelLicensing' , false) && (!class_exists('cpanellicensing',false))) {
			require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
		}
    }

	public function accountdetails($params)
	{
		$this->template->assign('custom',array('Changeip'));
		$this->template->assign('ischangeip', true);
		//=== check button custom changeip ====
		if (isset($params['customfn']) && $params['customfn'] != '' && method_exists($this,$params['customfn'])) {
			$this->{$params['customfn']}($params);
		}

		//=== case display info cPanel license
		//$aDataLicense = $this->getLicenseId($params['account']['id']);
		if ($params['account']['id'] != '') {
			$aDtlLicense = array();
			$api = new ApiWrapper();
			$aServerDtl = $api->getServerDetails(array('id'=>$params['account']['server_id']));
			if (isset($aServerDtl['success']) && $aServerDtl['success'] == 1) {
				$this->chkClassCpanelLicense();
				$aServerDtl['server']['username'] = $this->module->server_username;
				$aServerDtl['server']['password'] = $this->module->server_password;
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
	}

	public function productdetails($params)
    {
		$this->template->assign('aServerOpts', $this->aServerOptions);

    	$productid  = ($params['product_id'] == '')
    		? $params['id']
			: $params['product_id'];

		$aServerConf = RVCPanelDao::singleton()->getDataServerTypeLinkCpanel($productid);
		$this->template->assign('server_type', $aServerConf[0]['server_type']);

        $aWhere = array('rel'=>'1', 'id' => $productid);
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
		$this->template->assign('rvcpanelManage2Template', APPDIR_MODULES . 'Hosting/rvcpanel_manage2/templates/admin_configproduct.tpl');
        $path_to_yourtpl = APPDIR_MODULES.'Hosting/buycpanel_freervskin/templates/admin_configproduct.tpl';
        $this->template->assign('customconfig',$path_to_yourtpl);
    }

    public function getPackagesByCpanel()
    {
        $res = array();
        $lisc = $this->cpl->fetchPackages();
        if ($lisc instanceof SimpleXMLElement && $lisc->attributes->status != 0) {
            foreach ( $lisc->packages[0]->attributes() as $liscd=>$v) {
                $v = (array)$v;
                $res[$liscd]=$v[0];
            }
        }
        return $res;

    }

    public function getGroupByCpanel()
    {
        $res = array();;
        $lisc = $this->cpl->fetchGroups();
        if ($lisc instanceof SimpleXMLElement && $lisc->attributes->status != 0) {
            foreach ( $lisc->groups[0]->attributes() as $liscd=>$v) {
                $v = (array)$v;
                $res[$liscd]=$v[0];
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

	public function Changeip($params)
	{
        return false; // [TODO] ขาด change rvsitebuilder ip
        
		/// BEGIN: Tranfer cPanel License
		$aGetIp = RVProductLicenseDao::singleton()->findIpFormCustom($params['custom'], $params['account_id']);
		$params['old_ip'] = $aGetIp['ip'];

		require_once APPDIR_MODULES . "/Hosting/rvcpanel_manage2/admin/class.rvcpanel_manage2_controller.php";
		require_once APPDIR_MODULES . "/Hosting/rvcpanel_manage2/class.rvcpanel_manage2.php";
		$oCpanelManage2 = new rvcpanel_manage2_controller();
		$oCpanelManage2->module = new rvcpanel_manage2();
		$res = $oCpanelManage2->Changeip($params);
		if ($res == false) {
			return false;
		}

		/// BEGIN: Tranfer RVSkin Licnese
		require_once APPDIR_MODULES . "Hosting/rvskin_license/admin/class.rvskin_license_controller.php";
		require_once APPDIR_MODULES . "Hosting/rvskin_license/class.rvskin_license.php";
		$oRvskinLicense = new rvskin_license_controller();
		$oRvskinLicense->module = new rvskin_license();
		$res = $oRvskinLicense->Changeip($params);
		if ($res == false) {
			return false;
		}
		return true;
	}

	public function get_risk($params)
	{
		require_once APPDIR_MODULES . "/Hosting/rvcpanel_manage2/class.rvcpanel_manage2.php";

		$db = hbm_db();
		$aGetIp = RVProductLicenseDao::singleton()->findIpFormCustom($params['custom'], $params['account_id']);
		$oCpanelManage2 = new rvcpanel_manage2();
		$product_id = $params["product_id"];

		$getConfig = $db->query("
			SELECT
				ic.id AS config_cat
				, cis.id AS config_id
			FROM
				hb_config_items_cat AS ic
				, hb_config_items AS cis
			WHERE
				ic.product_id = :pid
				AND ic.id = cis.category_id
				AND ic.variable = :varname
		", array(":pid" => $product_id, ":varname" => 'risk_score'))->fetch();

		$chk = $db->query("SELECT * FROM hb_config2accounts WHERE account_id = :acct AND config_cat = :conf_cat AND config_id = :conf_id", array(":acct" => $params["id"], ":conf_cat" => $getConfig["config_cat"], ":conf_id" => $getConfig["config_id"]))->fetch();
		$queData = array(
				":type" => "Hosting"
				, ":acct" => $params["id"]
				, ":conf_cat" => $getConfig["config_cat"]
				, ":conf_id" => $getConfig["config_id"]
				, ":qty" => 1
				, ":data" => $oCpanelManage2->getRiskScore($aGetIp["ip"])
		);

		if(!$chk){
			$db->query("
				INSERT INTO
					hb_config2accounts
						(
							rel_type
							, account_id
							, config_cat
							, config_id
							, qty
							, data
						)
					VALUES
						(
							:type
							, :acct
							, :conf_cat
							, :conf_id
							, :qty
							, :data
						)
			", $queData);
		} else {
			$db->query("
				UPDATE
					hb_config2accounts
				SET
					data = {$oCpanelManage2->getRiskScore($aGetIp["ip"])}
				WHERE
					account_id = {$params["id"]}
					AND config_cat = {$getConfig["config_cat"]}
					AND config_id = {$getConfig["config_id"]}
			", $queData);
		}
	}

	/**
     *
     * Enter description here ...
     */
    public function getModuleName()
    {
        return "buycpanel_freervskinfreervsitebuilder";
    }
}
