<?php 

class basicmodulebynetway extends HostingModule
{
    protected $modname      = 'Basic Module by Netway';
    protected $description  = 'Basic Module by Netway provisioning module';
    
    protected $commands     = array(
            'Create', 'Suspend', 'Unsuspend', 'Terminate'
        );
    
    protected $options      = array();
    protected $details      = array();
    
    public function connect ($details) 
    {
        
    }
    
    public function testConnection () 
    {
        return true;
    }

    public function getCertDetails ($detail = array()) 
    {
        return $detail;
    }
    
    public function Create () 
    {
        return true;
    }
    
    public function Suspend () 
    {
        return true;
    }
    
    public function Unsuspend () 
    {
        return true;
    }
    
    public function Terminate () 
    {
        return true;
    }
    
}