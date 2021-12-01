<?php
/*************************************************************
 *
 * Hosting Module Class - Zabbix
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/
 * http://wiki.hostbillapp.com/index.php?title=Custom_Modules#Examples
 * http://wiki.hostbillapp.com/index.php?title=Hosting_Modules
 * http://hostbillapp.com/features/
 * http://wiki.hostbillapp.com/index.php?title=HostBill_Plugins
 * 
 * 
 ************************************************************/

// Load Hostbill Api
include_once("include/api/class.hostbill.api.php");

// Load Zabbix Api
include_once("include/api/class.zabbix.api.php");

class zabbix extends HostingModule {

	private $server_hostname;
    private $server_username;
    private $server_password;

	// Extras >> Plugins >> Hosting Modules
	// Module name
	protected $modname = "Zabbix";
	
	// Extras >> Search results
	// Description module
	protected $description = "Zabbix integration with HostBill. Additionally trough client functions it allows to browse usage graphs generated by Zabbix.";
	
	
	// Settings >> Products && Services
    // Connect with App
	protected $options = array();
	
	
	/**
    * You can choose which fields to display in Settings->Apps section
    * by defining this variable
    * @var array
    */
	protected $serverFields = array(
        "hostname" => true,
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
      * HostBill will replace default labels for server fields
      * with this variable configured
      * @var array
      */
    protected $serverFieldsDescription = array(
        "hostname" => "Zabbix Api",
        "username" => "Username",
        "password" => "Password"
    );
    

	/**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect) {
    	
    	$this->server_hostname = (isset($connect["host"])) ? $connect["host"] : "";
    	$this->server_username = (isset($connect["username"])) ? $connect["username"] : "";
        $this->server_password = (isset($connect["password"])) ? $connect["password"] : "";
        
    }
    
    
    /**
     * HostBill will call this method when admin clicks on "test Connection" in settings->apps
     * It should test connection to remote app using details provided in connect method
     *
     * Use $this->addError('message'); to provide errors details (if any)
     *
     * http://xxx.xxx.xxx.xxx/public_html/admin/index.php?cmd=servers&action=test_connection
     * 
     * @see connect
     * @return boolean true if connection suceeds
     */
    public function testConnection() {
        $res = false;
        
    	try {
    		$res = ZabbixApi::singleton()->_connect($this->server_hostname, $this->server_username, $this->server_password);
    	} catch (Exception $e) {
    		$this->addError($e->getMessage());
        }
        
        // Replace server_hostname, server_username, server_passs to hook files
    	
        return $res;
    }
	
    
    
    
    
    /**
     * This method is invoked automatically when creating an account.
     * @return boolean true if creation succeeds
     */
    public function Create() {
    	
    	// ขั้นตอนการทำงาน เมื่อ click create and re-create
        // 1. บน hostbill: ในส่วนของ IPAM ให้เพิ่ม UI การตั้งค่า main server ip (ตั้งค่า ip สำหรับเชื่อมต่อกับ zabbix)
        // 2. บน hostbill: ในส่วนของการทำ Provision ให้เพิ่ม button "Re-Create"
        // 3. บน hostbill: การทำงานของ button "Create" และ "Re-Create" เหมือนกัน คือ
        //     3.1 บน zabbix: ถ้ามี host visible name [h-__hb_account_id__] ให้ update เป็นตั้งค่าเป็นค่าว่าง
        //     3.2 บน zabbix: ถ้ามี action [a-__hb_account_id__] ให้ delete
        //     3.3 บน hostbill: uassign Switch
        
    	$request = array(
    	   "server_hostname" => $this->server_hostname,
    	   "server_username" => $this->server_username,
    	   "server_password" => $this->server_password,
    	   "account_id" => $this->account_details["id"]
    	);
    	
    	$aResponse = HostbillCommon::singleton()->doCleanZabbix($request);
        if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
            $this->addError($aResponse['raiseError']);
             return false;
        }
    	
    	
    	// ขั้นตอนการทำงาน เมื่อ click create zabbix app
    	// 3. บน zabbix: match hostbill account w/ zabbix discovered host by IP address and update visible name to [h-__hb_account_id__]
        // 1. บน zabbix: add user [u-__hb_user_id__] (ถ้ายังไม่มี) ใส่ email และ CCemail ใน ช่อง media
        // 2. บน zabbix: add user เข้า hostbill usergroup (ถ้ายังไม่มี)
        // 4. บน zabbix: create action [a-__hb_account_id__-ping] สำหรับ ping test ของใครของมัน
        // 5. บน hostbill: update ค่า switch ID and switch port จาก zabbix โดยอัตโนมัติ  จะใช้ ip switch เพื่อให้เข้าใจตรงกันระหว่าง hostbill และ zabbix [s__ip_switch]
        $request = array(
           "server_hostname" => $this->server_hostname,
           "server_username" => $this->server_username,
           "server_password" => $this->server_password,
           "account_id" => $this->account_details["id"],
           "client_id" => $this->client_data["id"],
           "client_email" => $this->client_data["email"],
           "client_ccmail" => $this->client_data["ccmail"]
        );
        $aResponse = HostbillCommon::singleton()->doCreateZabbix($request);
        if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
        	$this->addError($aResponse['raiseError']);
             return false;
        }
        
        
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
        
        // ทำงานเหมือนกันกับ Create และ Re-Create 
        
        $request = array(
           "server_hostname" => $this->server_hostname,
           "server_username" => $this->server_username,
           "server_password" => $this->server_password,
           "account_id" => $this->account_details["id"]
        );
        
        $aResponse = HostbillCommon::singleton()->doCleanZabbix($request);
        if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
            $this->addError($aResponse['raiseError']);
             return false;
        }
        
        
        $aClient = HostbillApi::singleton()->getClientDetailsByClientId($this->account_details["client_id"]);
        $email = (isset($aClient["client"]["email"])) ? $aClient["client"]["email"] : '';
        $ccmail = (isset($aClient["client"]["email"])) ? $aClient["client"]["ccmail"] : '';
        
        $request = array(
           "server_hostname" => $this->server_hostname,
           "server_username" => $this->server_username,
           "server_password" => $this->server_password,
           "account_id" => $this->account_details["id"],
           "client_id" => $this->account_details["client_id"],
           "client_email" => $email,
           "client_ccmail" => $ccmail
        );
        $aResponse = HostbillCommon::singleton()->doCreateZabbix($request);
        if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
            $this->addError($aResponse['raiseError']);
             return false;
        }
        
        
    	return true;
    }
    
    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate() {

        // ขั้นตอนการทำงาน ให้ disable host บน zabbix server
        // บน zabbix: ถ้ามี action [a-__hb_account_id__-ping] ให้ delete
        
        $request = array(
           "server_hostname" => $this->server_hostname,
           "server_username" => $this->server_username,
           "server_password" => $this->server_password,
           "account_id" => $this->account_details["id"]
        );
        $aResponse = HostbillCommon::singleton()->doDisableHost($request);
        if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
            $this->addError($aResponse['raiseError']);
            return false;
        } else {
            $aResponse = HostbillCommon::singleton()->doDeleteActionPing($request);
            if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != "") {
                $this->addError($aResponse['raiseError']);
                return false;
            }
        }
        
    	return true;
    }
    
    
    /**
     * This method is invoked when account should have password changed
     * @param string $newpassword New password to set account with
     * @return boolean true if action succeeded
     */
    public function ChangePassword($newpassword) {
    	return true;
    }
    
    
    /**
     * This method is invoked when account should be upgraded/downgraded
     * $options variable is loaded with new package configuration
     * @return boolean true if action succeeded
     */
    public function ChangePackage() {
    	return true;
    }
    
    
    /**
     * Auxilary method that HostBill will load to get plans from server:
     * @see $options variable above
     * @return array - list of plans to display in product configuration
     */
    public function getPlans() {
    	return true;
    }
    
    
    /**
     * This method is OPTIONAL. in this example it is used to connect to the server and manage all the modules action with the API.
     *  @ignore
     */
    private function Send($action, $post) {
    	return true;
    }
    
    
    
}