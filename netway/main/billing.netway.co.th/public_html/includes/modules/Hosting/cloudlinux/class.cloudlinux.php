<?php 
#@LICENSE@#

class cloudlinux extends HostingModule
{
	protected $modname = "cloudlinux";
	protected $description = 'Cloud Linux provisioning module';
	
	protected $options = array(
			
	);
	
	/**
	 * You can choose which fields to display in Settings->Apps section
	 * by defining this variable
	 * @var array
	 */
	protected $serverFields = array( //
			'hostname' => false,
			'ip' => true,
			'maxaccounts' => false,
			'status_url' => false,
			'field1' => true,
			'field2' => true,
			'username' => true,
			'password' => true,
			'hash' => false,
			'ssl' => true,
			'nameservers' => false,
	);
	
	protected $serverFieldsDescription = array(
			'username' => 'User ID',
			'password' => 'Password',
			'field1'=>'Port',
			'field2'=>'Alternative Port'
	);
	
	/**
	 * HostBill will replace default labels for server fields
	 * with this variable configured
	 * @var array
	 */
	
	protected $details = array(
			'option1' =>array (
					'name'=> 'username',
					'value' => false,
					'type'=> 'input',
					'default'=>false
			),
			'option2' =>array (
					'name'=> 'password',
					'value' => false,
					'type'=> 'input',
					'default'=>false
			),
			'option3' =>array (
					'name'=> 'domain',
					'value' => false,
					'type'=> 'hidden',        // this field is required, so we have set the type to 'hidden' and its not visible.
					'default'=>false
			),
			'option4' =>array (               // NEW FIELD declared here
					'name'=> 'Client ID',     // this name will be displayed as a label of this field
					'value' => false,
					'type'=> 'input',
					'default'=>false
			)
	);
	
	private $server_username;
	private $server_password;
	private $server_hostname;
	private $server_ip;
	
	/**
	 * HostBill will call this method before calling any other function from your module
	 * It will pass remote  app details that module should connect with
	 *
	 * @param array $connect Server details configured in Settings->Apps
	 */
	public function connect($connect) {
		$this->server_username = $connect['username'];
		$this->server_password = $connect['password'];
		$this->server_hostname = $connect['hostname'];
		$this->server_ip = $connect['ip'];
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
	
	 
	
	/**
	 * This method is invoked automatically when creating an account.
	 * @return boolean true if creation succeeds
	 */
	public function Create() {
		return true;
	}
	
	
	/**
	 * This method is invoked automatically when suspending an account.
	 * @return boolean true if suspend succeeds
	 */
	public function Suspend() {
		return true;
	}
	
	
	/**
	 * This method is invoked automatically when unsuspending an account.
	 * @return boolean true if unsuspend succeeds
	 */
	public function Unsuspend() {
		return true;
	}
	
	
	/**
	 * This method is invoked automatically when terminating an account.
	 * @return boolean true if termination succeeds
	 */
	public function Terminate() {
		return true;
	}
	
	/**
	 * This method is invoked when account should have password changed
	 * @param string $newpassword New password to set account with
	 * @return boolean true if action succeeded
	 */
	public function ChangePassword($newpassword)
	{
		return true;
	}
	
	/**
	 * This method is invoked when account should be upgraded/downgraded
	 * $options variable is loaded with new package configuration
	 * @return boolean true if action succeeded
	 */
	public function ChangePackage()
	{
		return true;
	}
	
	
	/**
	 * Auxilary method that HostBill will load to get plans from server:
	 * @see $options variable above
	 * @return array - list of plans to display in product configuration
	 */
	public function getPlans() 
	{
		$return = array();
		return $return;
	}
	
}