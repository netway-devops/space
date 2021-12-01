<?php


// DomainsWidget ptype 9 
// ServicesWidget ptype 0
// HostingWidget

class widget_domainforwardinghandle extends DomainsWidget {
 
    protected $description = 'domainforwardinghandle';
    protected $widgetfullname = 'Domain Forwarding';
    
    public function __construct ()
    {
        parent::__construct();
        $this->info['appendtpl'] = 'template.tpl';
    }
    
    public function controller ($detail)
    {
        
    }
    

    
}