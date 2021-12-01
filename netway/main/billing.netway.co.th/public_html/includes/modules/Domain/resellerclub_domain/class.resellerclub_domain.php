<?php

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');

class resellerclub_domain extends DomainModule {
    
    protected $description      = 'ResellerClub (Advance module) domain registrar by netway';
    
    protected $configuration    = array(
                'authUser'      => array(
                    'value'     => '',
                    'type'      => 'input',
                    'default'   => false
                ),
                'apiKey'        => array(
                    'value'     => '',
                    'type'      => 'input',
                    'default'   => false
                ),
                'isTestMode'    => array(
                    'value'     => '',
                    'type'      => 'check'
                )
            );
            
    protected $lang             = array(
                'english'       => array(
                    'authUser'      => 'Auth User ID',
                    'apiKey'        => 'API Key',
                    'isTestMode'    => 'Use Test Mode'
                )
            );
    
    protected $commands         = array(
                'Register', 'Transfer', 'Renew', 'Synchronize'
            );
            
    // $this->options;
    // $this->client_data;
    
    public function synchInfo ()
    {
        return self::Synchronize();
    }
    
    public function Synchronize ()
    {
        $detail             = $this->options;
        $detail['domain']   = $detail['sld'] .'.'. $detail['tld'];
        
        $return             = array();
        
        $result             = $this->Send('Synchronize', $detail);
        $expire             = isset($result->endtime) ? $result->endtime : 0;
        
        if ($expire > time()) {
            $return['status']   = 'Active';
        }
        if ($expire && $expire < time()) {
            $return['status']   = 'Expired';
        }
        if ($expire) {
            $return['expires']  = date('Y-m-d', $expire);
        }
        
        $ns1                = isset($result->ns1) ? $result->ns1 : '';
        $ns2                = isset($result->ns2) ? $result->ns2 : '';
        $ns3                = isset($result->ns3) ? $result->ns3 : '';
        $ns4                = isset($result->ns4) ? $result->ns4 : '';
        if ($ns1) {
            $return['ns']   = array($ns1, $ns2, $ns3, $ns4);
        }
        
        return $return;
    }
    
    public function getNameServers ()
    {
        $return     = self::Synchronize();
        return (isset($return['ns']) ? $return['ns'] : array());
    }

    public function updateNameServers ()
    {
        $detail             = $this->options;
        $detail['domain']   = $detail['sld'] .'.'. $detail['tld'];
        
        $return             = array();
        
        $result             = $this->Send('Updatenameservers', $detail);
        
        $ns1                = isset($result->ns1) ? $result->ns1 : '';
        $ns2                = isset($result->ns2) ? $result->ns2 : '';
        $ns3                = isset($result->ns3) ? $result->ns3 : '';
        $ns4                = isset($result->ns4) ? $result->ns4 : '';
        if ($ns1) {
            $return['ns']   = array($ns1, $ns2, $ns3, $ns4);
        }
        
        if (! isset($result->status) && $result->status == 'ERROR') {
            $this->addError('Error: '. $result->message);
        }
        
        return (isset($return['ns']) ? $return['ns'] : array());
    }
    
    public function Register ()
    {
        
        /**
         * ถ้าไม่มี admin contact ให้ copy จาก regsistrar
         * billing contact กับ technical contact เป็นของเรา
         */
         
        $aRegistrant       = $this->options['registrant'];
        if (is_array($aRegistrant) && count($aRegistrant)) {
            foreach ($aRegistrant as $k => $v) {
                if ($this->options['registrant'][$k] == '') {
                    $this->options['registrant'][$k]   = '-';
                }
                if (! isset($this->options['admin'][$k]) || $this->options['admin'][$k] == '') {
                    $this->options['admin'][$k]        = $this->options['registrant'][$k];
                }
            }
        }
        
        $nwTechnicalContact     = ConfigCustom::singleton()->getValue('nwTechnicalContact');
        $aTech                  = GeneralCustom::singleton()->getNetwayTechContactAddress($nwTechnicalContact);
         
        $this->options['tech']          = $aTech;
        $this->options['billing']       = $aTech;
        
        $detail                 = $this->options;
        
        $detail['domain']       = $detail['sld'] .'.'. $detail['tld'];
        $detail['period']       = $detail['numyears'];
        
        $detail['nameservers']['ns1']   = $detail['ns1'];
        $detail['nameservers']['ns2']   = $detail['ns2'];
        $detail['nameservers']['ns3']   = $detail['ns3'];
        $detail['nameservers']['ns4']   = $detail['ns4'];
        
        $results                = $this->Send('Register', $detail);
        
        if (! isset($results->status)) {
            $this->addError('Domain register action is fail.');
            return false;
        }
        
        $this->addInfo('Domain register '. $results->status .' <pre>'. print_r($results, true) .'</pre>');
        return true;
    }
    
    public function Transfer ()
    {
        
        /**
         * ถ้าไม่มี admin contact ให้ copy จาก regsistrar
         * billing contact กับ technical contact เป็นของเรา
         */
         
        $aRegistrant       = $this->options['registrant'];
        if (is_array($aRegistrant) && count($aRegistrant)) {
            foreach ($aRegistrant as $k => $v) {
                if ($this->options['registrant'][$k] == '') {
                    $this->options['registrant'][$k]   = '-';
                }
                if (! isset($this->options['admin'][$k]) || $this->options['admin'][$k] == '') {
                    $this->options['admin'][$k]        = $this->options['registrant'][$k];
                }
            }
        }
        
        $nwTechnicalContact     = ConfigCustom::singleton()->getValue('nwTechnicalContact');
        $aTech                  = GeneralCustom::singleton()->getNetwayTechContactAddress($nwTechnicalContact);
         
        $this->options['tech']          = $aTech;
        $this->options['billing']       = $aTech;
        
        $detail                 = $this->options;
        
        $detail['domain']       = $detail['sld'] .'.'. $detail['tld'];
        $detail['period']       = $detail['numyears'];
        
        $detail['nameservers']['ns1']   = $detail['ns1'];
        $detail['nameservers']['ns2']   = $detail['ns2'];
        $detail['nameservers']['ns3']   = $detail['ns3'];
        $detail['nameservers']['ns4']   = $detail['ns4'];
        
        $results                = $this->Send('Transfer', $detail);
        
        if (! isset($results->status) || $results->status == 'error') {
            $this->addError('Domain transfer action is fail. <pre>'. print_r($results, true) .'</pre>');
            return false;
        }
        
        $this->addInfo('Domain transfer '. $results->status .' <pre>'. print_r($results, true) .'</pre>');
        return true;
    }
    
    public function Renew ()
    {
        
        $domainId       = $this->domain_id;
        
        $result         = GeneralCustom::singleton()->isDomainAllowRenewable($domainId);
        if (! $result) {
            $this->addError('Domain #' . $domainId  . ' ไม่อยู่ในเงื่อนไขที่จะทำการ autorenew ได้ ');
            return false;
        }
        
        $detail                 = $this->options;
        
        $detail['domain']       = $detail['sld'] .'.'. $detail['tld'];
        $detail['period']       = $detail['numyears'];
        
        $results                = $this->Send('Renew', $detail);
        
        if (! isset($results->actionstatus)) {
            $this->addError('Domain renewal fail '. $results);
            return false;
        }
        
        /*
        stdClass Object
        (
            [actiontypedesc] => Renewal of poolandfresh.com for 1 year
            [actionstatus] => Success
            [entityid] => 24030644
            [status] => Success
            [eaqid] => 305111180
            [actiontype] => RenewDomain
            [description] => poolandfresh.com
            [actionstatusdesc] => Domain renewed successfully
        )
         */
        
        $this->addInfo('Domain renewal result is '. $results->actionstatus);
        return true;
    }
    
    private function Send ($action, $detail)
    {
        $apiUser        = $this->configuration['authUser']['value'];
        $apiKey         = $this->configuration['apiKey']['value'];
        $isTestMode     = $this->configuration['isTestMode']['value'];
        
        if ($isTestMode) {
            $this->addError('Domain module is test mode.');
            return false;
        }
        
        switch ($action) {
            case 'Synchronize'      : {
                $handle         = file_get_contents('https://httpapi.com/api/domains/details-by-name.json'
                                . '?auth-userid='. $apiUser 
                                . '&api-key='. $apiKey 
                                . '&domain-name='. $detail['domain'] 
                                . '&options=All');
                $handle         = json_decode($handle);
                break;
            }
            case 'Transfer'         : {
                $customerId         = $this->addCustomer($detail);
                if (! $customerId) {
                    return false;
                }
                
                $regContactId       = $this->addContact($customerId, $detail['registrant']);
                $adminContactId     = $this->addContact($customerId, $detail['admin']);
                $techContactId      = $this->addContact($customerId, $detail['tech']);
                $billingContactId   = $this->addContact($customerId, $detail['billing']);
                
                if (! $regContactId || ! $adminContactId || ! $techContactId || ! $billingContactId) {
                    return false;
                }
                
                $postdata       = http_build_query(
                    array(
                        'auth-userid'   => $apiUser,
                        'api-key'       => $apiKey,
                        'domain-name'   => $detail['domain'] ,
                        'auth-code'     => $detail['epp_code'] ,
                        'customer-id'           => $customerId,
                        'reg-contact-id'        => $regContactId,
                        'admin-contact-id'      => $adminContactId,
                        'tech-contact-id'       => $techContactId,
                        'billing-contact-id'    => $billingContactId,
                        'invoice-option'        => 'KeepInvoice'
                    )
                );
                
                $opts           = array('http' =>
                    array(
                        'method'  => 'POST',
                        'header'  => 'Content-type: application/x-www-form-urlencoded',
                        'content' => $postdata .'&ns='. $detail['ns1'] .'&ns='. $detail['ns2']
                    )
                );
                
                $context        = stream_context_create($opts);
                $handle         = file_get_contents('https://httpapi.com/api/domains/transfer.json'
                                , false, $context);
                $handle         = json_decode($handle);
                
                break;
            }
            case 'Register'         : {
                $customerId         = $this->addCustomer($detail);
                if (! $customerId) {
                    return false;
                }
                
                $regContactId       = $this->addContact($customerId, $detail['registrant']);
                $adminContactId     = $this->addContact($customerId, $detail['admin']);
                $techContactId      = $this->addContact($customerId, $detail['tech']);
                $billingContactId   = $this->addContact($customerId, $detail['billing']);
                
                if (! $regContactId || ! $adminContactId || ! $techContactId || ! $billingContactId) {
                    return false;
                }
                
                $postdata       = http_build_query(
                    array(
                        'auth-userid'   => $apiUser,
                        'api-key'       => $apiKey,
                        'domain-name'   => $detail['domain'] ,
                        'years'         => $detail['period'] ,
                        'customer-id'           => $customerId,
                        'reg-contact-id'        => $regContactId,
                        'admin-contact-id'      => $adminContactId,
                        'tech-contact-id'       => $techContactId,
                        'billing-contact-id'    => $billingContactId,
                        'invoice-option'        => 'KeepInvoice'
                    )
                );
                
                $opts           = array('http' =>
                    array(
                        'method'  => 'POST',
                        'header'  => 'Content-type: application/x-www-form-urlencoded',
                        'content' => $postdata .'&ns='. $detail['ns1'] .'&ns='. $detail['ns2']
                    )
                );
                
                $context        = stream_context_create($opts);
                $handle         = file_get_contents('https://httpapi.com/api/domains/register.json'
                                , false, $context);
                $handle         = json_decode($handle);
                
                break;
            }
            case 'Renew'            : {
                $handle         = file_get_contents('https://httpapi.com/api/domains/details-by-name.json'
                                . '?auth-userid='. $apiUser 
                                . '&api-key='. $apiKey 
                                . '&domain-name='. $detail['domain'] 
                                . '&options=All');
                $handle         = json_decode($handle);
                
                if (! isset($handle->orderid)) {
                    $this->addError('Invalid order id. '. $handle);
                    return false;
                }
                
                $orderId        = $handle->orderid;
                
                $postdata       = http_build_query(
                    array(
                        'auth-userid'   => $apiUser,
                        'api-key'       => $apiKey,
                        'order-id'      => $orderId ,
                        'years'         => $detail['period'],
                        'exp-date'      => $handle->endtime,
                        'invoice-option'    => 'NoInvoice'
                    )
                );
                
                $opts           = array('http' =>
                    array(
                        'method'  => 'POST',
                        'header'  => 'Content-type: application/x-www-form-urlencoded',
                        'content' => $postdata
                    )
                );
                
                $context        = stream_context_create($opts);
                $handle         = file_get_contents('https://httpapi.com/api/domains/renew.json'
                                , false, $context);
                $handle         = json_decode($handle);
                
                break;
            }
            case 'Updatenameservers'    : {
                $handle         = file_get_contents('https://httpapi.com/api/domains/details-by-name.json'
                                . '?auth-userid='. $apiUser 
                                . '&api-key='. $apiKey 
                                . '&domain-name='. $detail['domain'] 
                                . '&options=All');
                $handle         = json_decode($handle);
                
                if (! isset($handle->orderid)) {
                    $this->addError('Invalid order id. '. $handle);
                    return false;
                }
                
                $orderId        = $handle->orderid;
                
                $postdata       = http_build_query(
                    array(
                        'auth-userid'   => $apiUser,
                        'api-key'       => $apiKey,
                        'order-id'      => $orderId
                    )
                );
                
                $opts           = array('http' =>
                    array(
                        'method'  => 'POST',
                        'header'  => 'Content-type: application/x-www-form-urlencoded',
                        'content' => $postdata .'&ns='. $detail['ns1'] .'&ns='. $detail['ns2']
                    )
                );
                
                $context        = stream_context_create($opts);
                $handle         = file_get_contents('https://httpapi.com/api/domains/modify-ns.json'
                                , false, $context);
                $handle         = json_decode($handle);
                
                break;
            }
        }
        
        return $handle;
    }

    private function addCustomer ($detail)
    {
        $apiUser        = $this->configuration['authUser']['value'];
        $apiKey         = $this->configuration['apiKey']['value'];
        
        $email          = $detail['email'];
        $handle         = file_get_contents('https://httpapi.com/api/customers/details.json'
                        . '?auth-userid='. $apiUser 
                        . '&api-key='. $apiKey 
                        . '&username='. $email);
        
        $handle         = json_decode($handle);
        
        if (isset($handle->customerid)) {
            return $handle->customerid;
        }

        // Password should be alphanumeric characters with minimum of 8 characters and maximum of 15 characters
        $password       = GeneralCustom::singleton()->randomPassword();
        $name           = str_replace('@', ' (at) ', $email);
        
        $postdata       = http_build_query(
            array(
                'auth-userid'   => $apiUser,
                'api-key'       => $apiKey,
                'username'      => $email,
                'password'      => $password,
                'passwd'        => $password,
                'name'          => $name,
                'company'       => ($detail['companyname'] ? $detail['companyname'] : 'N/A'),
                'address-line-1'    => ($detail['address1'] ? $detail['address1'] : 'N/A'),
                'city'          => ($detail['city'] ? $detail['city'] : 'N/A'),
                'state'         => 'Bangkok', // ($detail['state'] ? $detail['state'] : 'Bangkok'),
                'country'       => 'TH', // ($detail['country'] ? $detail['country'] : 'TH'),
                'zipcode'       => '10800', // ($detail['postcode'] ? $detail['postcode'] : '10800'),
                'phone-cc'      => '66', // ($detail['phonenumber'] ? substr($detail['phonenumber'],0,2) : '66'),
                'phone'         => '29122558', // ($detail['phonenumber'] ? $detail['phonenumber'] : '29122558'),
                'lang-pref'     => 'en'
            )
        );
        
        $opts           = array('http' =>
            array(
                'method'  => 'POST',
                'header'  => 'Content-type: application/x-www-form-urlencoded',
                'content' => $postdata
            )
        );
        
        $context        = stream_context_create($opts);
        $handle         = file_get_contents('https://httpapi.com/api/customers/signup.xml'
                        , false, $context);
        $customerId     = trim($handle);
        
        if ($customerId) {
            return $customerId;
        }
        
        $this->addError('Cannot create customer account. '. print_r($handle, true));
        return 0;
    }

    private function addContact ($customerId, $detail)
    {
        $apiUser        = $this->configuration['authUser']['value'];
        $apiKey         = $this->configuration['apiKey']['value'];
        
        $email          = $detail['email'];
        $name           = str_replace('@', ' (at) ', $email);
        
        $postdata       = http_build_query(
            array(
                'auth-userid'   => $apiUser,
                'api-key'       => $apiKey,
                'customer-id'   => $customerId,
                'email'         => $email,
                'name'          => $name,
                'company'       => ($detail['companyname'] ? $detail['companyname'] : 'N/A'),
                'address-line-1'    => ($detail['address1'] ? $detail['address1'] : 'N/A'),
                'city'          => ($detail['city'] ? $detail['city'] : 'N/A'),
                'state'         => ($detail['state'] ? $detail['state'] : 'Bangkok'),
                'country'       => ($detail['country'] ? $detail['country'] : 'TH'),
                'zipcode'       => ($detail['postcode'] ? $detail['postcode'] : '10800'),
                'phone-cc'      => '66', // ($detail['phonenumber'] ? substr($detail['phonenumber'],0,2) : '66'),
                'phone'         => '29122558', // ($detail['phonenumber'] ? $detail['phonenumber'] : '29122558'),
                'type'          => 'Contact'
            )
        );
        
        $opts           = array('http' =>
            array(
                'method'  => 'POST',
                'header'  => 'Content-type: application/x-www-form-urlencoded',
                'content' => $postdata
            )
        );
        
        $context        = stream_context_create($opts);
        $handle         = file_get_contents('https://httpapi.com/api/contacts/add.json'
                        , false, $context);
        
        $contactId      = trim($handle);
        
        if ($contactId) {
            return $contactId;
        }
        
        $this->addError('Cannot create customer account. '. $handle);
        return 0;
    }
    
}