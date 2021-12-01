<?php
/*************************************************************
 *
 * Provisioning Module Class - Simple Example
 *
 * You can read more about the hosting modules development at:
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/
 *
 * This simple module is a basic implementation.
 * If you want to get more extended functionality
 * please download the Example 2 file from the article above
 * ไม่ได้ใช้งานแล้ว
 ************************************************************/

class rv_verifylicense extends HostingModule {  
    // class name MUST be the same like the filename. In this example class.simpleexample.php
    protected $modname = "RV Verify License";
    protected $description = 'RV Verify License Cpanel, RVSitebuilder, RVSkin.'; 
    
    protected $options = array();
    protected $details = array();

    protected $cpl;
    public $server_username;
    public $server_password;
    public $server_hostname;
    private $server_ip;

    protected $serverFields = array(
        "hostname" => false,
        "ip" => false,
        "maxaccounts" => false,
        "status_url" => false,
        "username" => true,
        "password" => true,
        "hash" => false,
        "ssl" => false,
        "nameservers" => false
    );

  
    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect) 
    { 
        
        // this is the method to load the Server Info configured at Apps Section.
       if (!class_exists('cPanelLicensing' , false)) {
            require_once APPDIR_MODULES . "Hosting/rvcpanel_manage2/include/cpl-3.6/php/cpl.inc.php";
       }

        $this->server_username = $connect['username'];
        $this->server_password = $connect['password'];
        $this->server_hostname = $connect['hostname'];
        $this->server_ip = $connect['ip'];
        $this->cpl = new cPanelLicensing($this->server_username, $this->server_password);

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
    public function testConnection() 
    {
        return true;
        $lisc = $this->cpl->fetchGroups();
        if($lisc instanceof SimpleXMLElement && $lisc->attributes()->status  == 1) {
            $this->addInfo('Test connect to manage2.cpanel.net has seccessfully.');
            return true;
        } else {
             $this->addError('Test connect to manage2.cpanel.net has problem.');
            return false;
        }
    }
}