<?php 

class addondomainbynetway extends HostingModule
{
	protected $modname     = "Add-on Domain by Netway";
	protected $description = 'Add-on Domain สำหรับ share hosting';
	
    protected $options      = array();
    protected $details      = array();
    
	public function connect($detail) {
	    
	}
	
	public function testConnection() {
		return true;
	}
	
	public function Create() {
		return false;
	}
	
	public function Suspend() {
		return false;
	}
	
	public function Unsuspend() {
		return false;
	}
	
	public function Terminate() {
		return false;
	}
	
}