<?php

class oldnetwayhandle extends HostingModule {
 
    protected $modname  = 'Old Netway Sharehost';
    
    protected $commands = array(
        'Create', 'Suspend', 'Unsuspend', 'Terminate'
    );
    
    protected $options  = array(
        'package'   => array(
            'name'  => 'Package type',
            'value' => '',
            'type'  => 'select', //html select element
            'default'   => array(
                'Linux Economy plan',
                'Linux Standard Plan',
                'Linux Premium Plan',
                'Linux Ecommerce Plan',
                'Linux Corporate Plan',
                'Linux Ultimate Plan',
                'Linux Enterprise Plan',
                'Window Hosting Small Plan',
                'Window Hosting Business Plan',
                'Window Advance Plan',
                'Window Maximum Plan',
                'Reseller Plan RE-WIN1',
                'Reseller Plan RE-WIN2',
                'Reseller Plan RE-WIN3',
                'Window Hosting Demo Plan',
            ),
        )
    );
    
    protected $details  = array(
        'option1'   => array(
            'name'  => 'username',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
        'option2'   => array(
            'name'  => 'password',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
        'option3'   => array(
            'name'  => 'domain',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
    );
    
    public function connect ($app_details) {
        
        $this->connection['ip'] = $app_details['ip'];
        $this->connection['host'] = $app_details['host'];
        $this->connection['username'] = $app_details['username'];
        $this->connection['password'] = $app_details['password'];
 
        //is "use ssl" option enabled? (True/false)
        $this->connection['secure'] = $app_details['secure'];
    }
    
    public function testConnection ()
    {
        return true;
    }
    
    public function Create ()
    {
        //$this->details['option1']['value']='Username_to_store';
        
        $details    = $this->details;
        oldnetwayHandleHostingAPI::send($details, 'Create');
        $this->addError('Module ไม่มี function รองรับ ให้แจ้งเจ้าหน้าที่ที่เกี่ยวข้องดำเนินการ');
        return false;
       
    }
    
    public function Suspend ()
    {
        //$this->details['option1']['value']='Username_to_store';
        
        $details    = $this->details;
        oldnetwayHandleHostingAPI::send($details, 'Suspend');
        $this->addError('Module ไม่มี function รองรับ ให้แจ้งเจ้าหน้าที่ที่เกี่ยวข้องดำเนินการ');
        return false;
       
    }
    
    public function Unsuspend ()
    {
        //$this->details['option1']['value']='Username_to_store';
        
        $details    = $this->details;
        oldnetwayHandleHostingAPI::send($details, 'Unsuspend');
        $this->addError('Module ไม่มี function รองรับ ให้แจ้งเจ้าหน้าที่ที่เกี่ยวข้องดำเนินการ');
        return false;
       
    }
    
    public function Terminate ()
    {
        //$this->details['option1']['value']='Username_to_store';
        
        $details    = $this->details;
        oldnetwayHandleHostingAPI::send($details, 'Terminate');
        $this->addError('Module ไม่มี function รองรับ ให้แจ้งเจ้าหน้าที่ที่เกี่ยวข้องดำเนินการ');
        return false;
       
    }
    
}

class oldnetwayHandleHostingAPI {
    
    public function send ($details, $action)
    {
        
        // --- hostbill helper ---
        $db         = hbm_db();
        $api        = new ApiWrapper();
        // --- hostbill helper ---
                
        $oClient    = (object) $details['client'];
        $oAccount   = (object) $details['account'];
        
        if (! isset($oClient->id)) {
            $params = array(
                'id'    => $oAccount->client_id
            );
            $return = $api->getClientDetails($params);
            $oClient    = ($return['success'] == true) ? (object) $return['client'] : new stdClass();
        }
        
        $subject    = 'แจ้งดำเนินการ '. $action .' account #' . $oAccount->id . ' ' . $oAccount->domain;
        $message    = "\n". 'รายละเอียด'
                . "\n" . '============================================================'
                . "\n" . 'Account:      #' . $oAccount->id
                . "\n" . 'Domain:        ' . $oAccount->domain
                . "\n" . 'Account detail: ##a# href="?cmd=accounts&action=edit&id=' . $oAccount->id .'"'
                       . ' target="_blank" ##View#a##'
                . "\n"
                . "\n" . '============================================================'
                ;
        
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: noreply@netway.co.th' . "\r\n" .
                'Reply-To: noreply@netway.co.th' . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        $mailto     = 'support@netway.co.th';
        @mail($mailto, $subject, $message, $header);
        
    }
    
}
