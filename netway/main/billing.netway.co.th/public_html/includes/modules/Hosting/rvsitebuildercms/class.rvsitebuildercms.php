<?php 

class rvsitebuildercms extends HostingModule
{
    protected $modname      = 'RVSitebuilder CMS';
    protected $description  = '';
    
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