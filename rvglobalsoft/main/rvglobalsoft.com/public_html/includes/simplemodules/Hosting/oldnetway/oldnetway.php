<?php

hbm_create('Old Netway', array(
    'description'   =>'Old netway controlpanel for HostBill, using procedural DevKit',
    'version'       =>'1.0'
));

//Configure server fields, visible under settings->apps
hbm_add_app_config('ip');

//Configure account fields, visible under Accounts
hbm_add_account_config('username'); //client username
hbm_add_account_config('password'); //client password
hbm_add_account_config('domain'); //client domain


//Configure product fields, visible under Products
hbm_add_product_config('package', array(
    'type'          =>'select',
    'description'   =>'Package to create account with',
    'default'       => array(
                    'Linux Economy plan',
                    'Linux Standard Plan',
                    'Linux Premium Plan',
                    'Linux Ecommerce Plan',
                    'Window Hosting Small Plan',
                    'Window Hosting Business Plan',
                    'Linux Corporate Plan',
                    'Linux Ultimate Plan',
                    'Linux Enterprise Plan',
                    'Window Advance Plan',
                    'Window Maximum Plan'
                )
));


//test connection
hbm_on_action('module.testconnection', function() {
    return true;
});

 // handle account creation
hbm_on_action('account.create', function($details) {
    oldnetwayHostingAPI::send($details, 'Create');
    return true;
});

hbm_on_action('account.suspend', function($details) {
    oldnetwayHostingAPI::send($details, 'Suspend');
    return true;
});

hbm_on_action('account.unsuspend', function($details) {
    oldnetwayHostingAPI::send($details, 'Unsuspend');
    return true;
});

hbm_on_action('account.terminate', function($details) {
    oldnetwayHostingAPI::send($details, 'Terminate');
    return true;
});


class oldnetwayHostingAPI {
    
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

        require_once(APPDIR . 'class.config.custom.php');
        $nwSupportDepartmentId = ConfigCustom::singleton()->getValue('nwSupportDepartmentId');
        
        $params = array(
            'name'      => 'System', //$oClient->firstname . ' ' . $oClient->lastname,
            'subject'   => $subject,
            'body'      => $message,
            'email'     => 'noreply@netway.co.th', //$oClient->email,
            
            'dept_id'   => $nwSupportDepartmentId,
            //'client_id' => $oClient->id
        
        );
        $return = $api->addTicket($params);
        if ($return['success'] == true) {
            $params = array(
                'id'        => $return['ticket_id'],
                'priority'  => 'Medium'
            );
            $api->setTicketPriority($params);
        }
        
    }
    
}