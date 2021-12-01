<?php 
#@LICENSE@#

class rvsitebuilder_Addon extends ModuleAddon
{
	/**
	 * Provide addon description
	 * @var string
	 */
	protected $description = 'RVSiteBuilder provisioning module';
	
	/**
	 * Provide addon name
	 * @var string
	 */
	protected $name = 'RVSiteBuilder';
	
	protected $options = array();
	
	/**
     * Here you can provide list of functions this module supports. 
     * Ie. if you wish only to use create, remove all except it
     * @var array
     */
    protected $adminFunctions = array('Create', 'Terminate','Suspend','Unsuspend');
    
    /**
     * Under $account_module variable HostBill will load instance of your hosting module class.
     * So you will be able to access its public method directly from this addon class
     * 
     * @var AdvancedExample
     */
    protected $account_module = null;
    
    /**
     * Before calling any method from addon module, HostBill will call connect first.
     *
     * @param array $connect Connection details array, contains same keys as one passed
     * in Yourmodule::connect
     */
	public function connect($connect) 
	{
		$this->account_module->connect($connect);
	}
	
	/**
     * Addon module can have its own create method, called everytime admin 
     * (or system/automation)choose to create addon.
     * Usually called right after related account creation
     * @return boolean
     */
	public function Create() 
	{
		return true;
	}
	
	/**
	 * Addon module can have its own terminate method, called everytime admin
	 * (or system/automation)choose to terminate addon
	 * @return boolean
	 */
	public function Terminate() 
	{
		return true;
	}
	
	/**
	 * Addon module can have its own suspend method, called everytime admin
	 * (or system/automation)choose to suspend addon
	 * @return boolean
	 */
	public function Suspend() 
	{
		return true;
	}
	
	/**
	 * Addon module can have its own unsuspend method, called everytime admin
	 * (or system/automation)choose to unsuspend addon
	 * @return boolean
	 */
	public function Unsuspend() 
	{
		return true;
	}
}