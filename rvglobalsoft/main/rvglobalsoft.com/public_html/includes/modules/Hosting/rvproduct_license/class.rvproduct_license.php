<?php
#@LICENSE@#

class rvproduct_license extends HostingModule
{
    protected $description = 'rvproduct_license';

    protected $options = array();

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

    protected $serverFieldsDescription = array();

    /**
     * HostBill will replace default labels for server fields
     * with this variable configured
     * @var array
     */
    protected $details = array();
	public $aCpanel = array(
		'user' => 'Rv97Pj3W',
		'pwd' => 'Z6)Hnb)/S48F'
	);

    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect) {
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
    public function Suspend()
    {
        return true;
    }

    public function Unsuspend()
    {
         return true;
    }


    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate()
    {
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
        return true;
    }

}
