<?php
require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/common/RVCPanelDao.php";

class buycpanel_freervskin extends HostingModule
{
	protected $description = 'Buy cPanel Free RVSkin';

	protected $options = array(
			'Server Type' =>array (
					'name'=> 'server_type',
					'type'=> 'select',
					'default'=>array('Dedicated','VPS', 'VZZO')
			)
	);

	public $server_username ='Rv97Pj3W';
	public $server_password = 'Z6)Hnb)/S48F';

	/**
	 * You can choose which fields to display in Settings->Apps section
	 * by defining this variable
	 * @var array
	 */
	protected $serverFields = array( //
			'hostname' => false,
			'ip' => false,
			'maxaccounts' => false,
			'status_url' => false,
			'field1' => false,
			'field2' => false,
			'username' => false,
			'password' => false,
			'hash' => false,
			'ssl' => false,
			'nameservers' => false,
	);

	protected $serverFieldsDescription = array(
			'ip' => 'Database IP',
			'hostname' => 'Database Name',
			'username' => 'Database Username',
			'password' => 'Database Password'
	);

	/**
	 * HostBill will replace default labels for server fields
	 * with this variable configured
	 * @var array
	*/
	protected $details = array();

	public function getCplConnect()
	{
		if (!class_exists('cPanelLicensing' , false) && (!class_exists('cpanellicensing',false))) {
			require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
		}
		return new cPanelLicensing($this->server_username, $this->server_password);
	}
	/**
	 * HostBill will call this method before calling any other function from your module
	 * It will pass remote  app details that module should connect with
	 *
	 * @param array $connect Server details configured in Settings->Apps
	 */
	public function connect($connect) {
		/*if (!class_exists('cPanelLicensing' , false)) {
		 require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
		}

		$this->server_username = $connect['username'];
		$this->server_password = $connect['password'];
		$this->server_hostname = $connect['hostname'];
		$this->server_ip = $connect['ip'];
		$this->cpl = new cPanelLicensing($this->server_username, $this->server_password);*/
	}

	/**
	 * HostBill will call this method when admin clicks on "test Connection" in settings->apps
	 * It should test connection to remote app using details provided in connect method
	 *
	 * Use $this->addError('message'); to provide errors details (if any)
	 *
	 * @see connect
	 * @return boolean true if connection suceeds
	 */
	public function testConnection() {
		return true;
	}

	private function setRvskinModule()
	{
		require_once APPDIR_MODULES . "Hosting/rvskin_license/class.rvskin_license.php";
		$oRvskinLicense = new rvskin_license();
		$oRvskinLicense->connect(array());
		$oRvskinLicense->account_details = $this->account_details;
		$oRvskinLicense->account_config = $this->account_config;
		$oRvskinLicense->product_details = $this->product_details;
		$aServerConf = RVCPanelDao::singleton()->getDataServerTypeLinkCpanel($this->account_details['product_id']);
		if (!isset($oRvskinLicense->product_details['options'])) {
			$oRvskinLicense->product_details['options'] = array();
		}
		$oRvskinLicense->product_details['options']['Server Type'] = $aServerConf[0]['server_type'];
		return $oRvskinLicense;
	}

	private function setCpaelModule()
	{
		require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/class.rvcpanel_manage2.php";
		$oCpanelLicense = new rvcpanel_manage2();
		$oCpanelLicense->connect(array());
		$oCpanelLicense->testConnection();
		$oCpanelLicense->account_details = $this->account_details;
		$oCpanelLicense->account_config = $this->account_config;
		$oCpanelLicense->product_details = $this->product_details;
		return $oCpanelLicense;
	}

	public function validateRisk()
	{
		$config = $this->account_config;
		if(isset($config["risk_score"])){
			if($config["risk_score"]["value"] > 0){
				if(empty($config["accept_risk"]) || !$config["accept_risk"]["value"]){
					$this->addError("Too high risk score for this IP [{$config["risk_score"]["value"]}], Waiting for risk approval from staff.");
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * This method is invoked automatically when creating an account.
	 * @return boolean true if creation succeeds
	 */
	public function Create()
	{
		if($this->validateRisk()){
			/// Add RVSkin Licnese
			$rvskinRes = $cpanelRes = false;
			if($this->checkCreation()){
				$oRvskinLicense = $this->setRvskinModule();
				$rvskinRes = $oRvskinLicense->Create();
				if ($rvskinRes == false) {
					return false;
				}
			}

			/// Add cPanel Licnese
			$oCpanelLicense = $this->setCpaelModule();
 			$cpanelRes = $oCpanelLicense->Create();
			if ($cpanelRes == false) {
				return false;
			}
			return true;
		}
		return false;
	}

	public function checkCreation()
	{
		$db = hbm_db();
		$ip = $this->account_config["ip"]["value"];

		if($ip != ""){
			$chk = $db->query("
					SELECT
        				*
        			FROM
        				rvskin_license
        			WHERE
        				main_ip = :ip
			", array(":ip" => $ip))->fetchAll();
			if(count($chk) > 0){
				return false;
			}
		}
		return true;
	}

	/**
	 * This method is invoked automatically when suspending an account.
	 * @return boolean true if suspend succeeds
	 */
	public function Suspend()
	{
		/// Add RVSkin Licnese
		$rvskinRes = $cpanelRes = false;
		$oRvskinLicense = $this->setRvskinModule();
		$rvskinRes = $oRvskinLicense->Suspend();
		if ($rvskinRes == false) {
			return false;
		}

		/// Add cPanel Licnese
		$oCpanelLicense = $this->setCpaelModule();
		$cpanelRes = $oCpanelLicense->Suspend();
		if ($cpanelRes == false) {
			return false;
		}

		return true;
	}

	public function Unsuspend()
	{
		/// Add RVSkin Licnese
		$rvskinRes = $cpanelRes = false;
		$oRvskinLicense = $this->setRvskinModule();
		$rvskinRes = $oRvskinLicense->Unsuspend();
		if ($rvskinRes == false) {
			return false;
		}

		/// Add cPanel Licnese
		$oCpanelLicense = $this->setCpaelModule();
		$cpanelRes = $oCpanelLicense->Unsuspend();
		if ($cpanelRes == false) {
			return false;
		}

		return true;
	}

	/**
	 * This method is invoked automatically when terminating an account.
	 * @return boolean true if termination succeeds
	 */
	public function Terminate()
	{
		/// Add RVSkin License
		$rvskinRes = $cpanelRes = false;
		$oRvskinLicense = $this->setRvskinModule();
		$rvskinRes = $oRvskinLicense->Terminate();
		if ($rvskinRes == false) {
			return false;
		}

		/// Add cPanel License
		$oCpanelLicense = $this->setCpaelModule();
		$cpanelRes = $oCpanelLicense->Terminate();
		if ($cpanelRes == false) {
			return false;
		}

		return true;
	}

	public function Renewal()
	{
		/// Add RVSkin Licnese
		$rvskinRes = $cpanelRes = false;
		$oRvskinLicense = $this->setRvskinModule();
		$rvskinRes = $oRvskinLicense->Renewal();
		if ($rvskinRes == false) {
			return false;
		}

		/// Add cPanel Licnese
		$oCpanelLicense = $this->setCpaelModule();
		$cpanelRes = $oCpanelLicense->Renewal();
		if ($cpanelRes == false) {
			return false;
		}

		return true;
	}

	/**
	 * This method is invoked when account should have password changed
	 * @param string $newpassword New password to set account with
	 * @return boolean true if action succeeded
	 */
	public function ChangePasswordff($newpassword)
	{
		return true;
	}

	/**
	 * This method is invoked when account should be upgraded/downgraded
	 * $options variable is loaded with new package configuration
	 * @return boolean true if action succeeded
	 */
	public function ChangePackageddd()
	{
		return true;
	}


	/**
	 * Auxilary method that HostBill will load to get plans from server:
	 * @see $options variable above
	 * @return array - list of plans to display in product configuration
	 **/
	public function getPlansdd()
	{
		$return = array();
		return $return;
	}

	private function printrToString($params)
	{
		ob_start();
		#echo '<pre>';
		print_r($params);
		#echo '</pre>';
		$string = ob_get_contents();
		ob_end_clean();
		return $string;
	}
}
