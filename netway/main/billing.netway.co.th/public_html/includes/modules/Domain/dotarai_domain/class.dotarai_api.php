<?php

class dotAraiApi {
    
    public static $aHBFieldToReg      = array(
                'firstname'         => 'fname',
                'lastname'          => 'lname',
                'companyname'       => 'company',
                'address1'          => 'address1',
                'address2'          => 'address2',
                'address3'          => 'address3', //  ไม่ปรากฏ
                'city'              => 'city',
                'state'             => 'state',
                'postcode'          => 'zip',
                'country'           => 'country',
                'email'             => 'email',
                'phonenumber'       => 'phone',
                'fax'               => 'fax'
                );
    public static $aContact = array('admin' => 'admin', 'tech' => 'tech', 'registrant' => 'reg', 'billing' => 'bill');
    
    public $apiLogin;
    public $apiKey;
    
    public function __construct ($apiLogin, $apiKey)
    {
        $this->apiLogin     = $apiLogin;
        $this->apiKey       = $apiKey;
    }
    
    private function send ($action, $param)
    {
        
        $strRequest = '&api_login='     . $this->apiLogin
                    . '&api_key='       . $this->apiKey
                    . $param
                    . '&action='        . $action;
        
        $hoststring = 'https://bp.dotarai.com/api/index.php';
        $ch = curl_init ();
        curl_setopt ($ch, CURLOPT_URL,$hoststring);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt ($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt ($ch, CURLOPT_POST, 1);
        curl_setopt ($ch, CURLOPT_POSTFIELDS, $strRequest);
        curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
        
        $result = curl_exec ($ch);

        return $result;
    }
    
    public function synchronize ($domainName)
    {

        $param          = '&domain_name='   . $domainName;
        
        return $this->send('whois', $param);
    }
    
    public function register ($details)
    {
        // [XXX] มันจะสร้างแค่ InvoiceID ให้เท่านั้น ไม่ได้จดจริง
        
        $domainName     = $details['domain'];
        $year           = $details['period'];
        
        $param          = '&domain_name='   . $domainName . '&years=' . $year;
        
        foreach (self::$aContact as $k => $v) {
            foreach (self::$aHBFieldToReg as $ki => $vi) {
                $key    = $v . '_' . $vi;
                $value  = isset($details[$k][$ki]) ? $details[$k][$ki] : '';
                $param .= '&' . $key . '=' . $value;
            }
        }
        
        foreach ($details['nameservers'] as $k => $v) {
            $param     .= '&' . $k . '=' . $v;
        }
        
        return $this->send('register', $param);
    }
    
    public function renew ($details)
    {
        
        $domainName     = $details['domain'];
        $period         = $details['period'];
        
        $param          = '&domain_name='   . $domainName . '&years=' . $period;
        
        $result         = $this->send('renew', $param);
        
        return $result;
    }
    
    public function transfer ($details)
    {

        $domainName     = $details['domain'];
        
        $param          = '&domain_name='   . $domainName;
        
        foreach (self::$aContact as $k => $v) {
            foreach (self::$aHBFieldToReg as $ki => $vi) {
                $key    = $v . '_' . $vi;
                $value  = isset($details[$k][$ki]) ? $details[$k][$ki] : '';
                $param .= '&' . $key . '=' . $value;
            }
        }
        
        $result         = $this->send('transfer', $param);
        
        return $result;
    }
    
    public function updatenameservers ($details)
    {
        
        if ( ! isset($details['nameservers']) || ! is_array($details['nameservers'])) {
            return false;
        }
        
        $domainName     = $details['domain'];
        
        $param          = '&domain_name='   . $domainName;
        
        foreach ($details['nameservers'] as $k => $v) {
            if (trim($v)) {
                $param .= '&' . $k . '=' . trim($v);
            }
        }
        
        $result         = $this->send('update_ns', $param);

        return $result;
    }
    
    public function errorMessage ($code)
    {
        $message        = '
        
            INVALID_REGISTRANT_FIRSTNAME 2 
            INVALID_REGISTRANT_LASTNAME 3 
            INVALID_REGISTRANT_ADDRESS1 4 
            INVALID_REGISTRANT_ADDRESS2 5 
            INVALID_REGISTRANT_ADDRESS3 6
            INVALID_REGISTRANT_CITY 7
            INVALID_REGISTRANT_STATE 8 
            INVALID_REGISTRANT_COUNTRY 9
            INVALID_REGISTRANT_PHONE 10
            INVALID_REGISTRANT_EMAIL 11 
            INVALID_REGISTRANT_FAX 12
            INVALID_REGISTRANT_ZIP 52
            INVALID_TECHNICAL_FIRSTNAME 13 
            INVALID_TECHNICAL_LASTNAME 14
            INVALID_TECHNICAL_ADDRESS1 15 
            INVALID_TECHNICAL_ADDRESS2 16 
            INVALID_TECHNICAL_ADDRESS3 17
            INVALID_TECHNICAL_CITY 18 
            INVALID_TECHNICAL_STATE 19 
            INVALID_TECHNICAL_COUNTRY 20
            INVALID_TECHNICAL_PHONE 100 
            INVALID_TECHNICAL_EMAIL 101 
            INVALID_TECHNICAL_FAX 102
            INVALID_TECHNICAL_ZIP 50 
            INVALID_ADMINISTRATIVE_FIRSTNAME 103 
            INVALID_ADMINISTRATIVE_LASTNAME 104
            INVALID_ADMINISTRATIVE_ADDRESS1 105 
            INVALID_ADMINISTRATIVE_ADDRESS2 106 
            INVALID_ADMINISTRATIVE_ADDRESS3 21 
            INVALID_ADMINISTRATIVE_CITY 22
            INVALID_ADMINISTRATIVE_STATE 23 
            INVALID_ADMINISTRATIVE_COUNTRY 24 
            INVALID_ADMINISTRATIVE_PHONE 25 
            INVALID_ADMINISTRATIVE_EMAIL 26 
            INVALID_ADMINISTRATIVE_FAX 27 
            INVALID_ADMINISTRATIVE_ZIP 51 
            INVALID_BILLING_FIRSTNAME 28 
            INVALID_BILLING_LASTNAME 29 
            INVALID_BILLING_ADDRESS1 30
            INVALID_BILLING_ADDRESS2 31 
            INVALID_BILLING_ADDRESS3 32 
            INVALID_BILLING_CITY 33 
            INVALID_BILLING_STATE 34 
            INVALID_BILLING_COUNTRY 35 
            INVALID_BILLING_PHONE 36
            INVALID_BILLING_EMAIL 37 
            INVALID_BILLING_FAX 38 
            INVALID_BILLING_ZIP 53 
            INVALID_LOGIN_PASSWORD 39 
            INVALID_COMMAND 40 
            INACTIVE_API 41 
            INVALID_PRODUCT 42
            INVALID_PRODUCT_PRICE 43 
            INACTIVE_BP 44
            INSUFFICIENT_CREDIT 45 
            API_LOCKED 46 
            INVALID_DOMAIN_OWNER 47
            INVALID_YEARS 48 
            INVALID_AUTH_ID 49
            INVALID_OPN_FIRSTNAME 54 
            INVALID_OPN_LASTNAME 55 
            INVALID_OPN_ADDRESS1 56
            INVALID_OPN_ADDRESS2 57
            INVALID_OPN_ADDRESS3 58 
            INVALID_OPN_CITY 59
            INVALID_OPN_STATE 60 
            INVALID_OPN_COUNTRY 61 
            INVALID_OPN_PHONE 62
            INVALID_OPN_EMAIL 63 
            INVALID_OPN_FAX 64 
            INVALID_OPN_ZIP 65 
            INVALID_CED_FIRSTNAME 66 
            INVALID_CED_LASTNAME 67 
            INVALID_CED_ADDRESS1 68 
            INVALID_CED_ADDRESS2 69 
            INVALID_CED_ADDRESS3 70 
            INVALID_CED_CITY 71
            INVALID_CED_STATE 72 
            INVALID_CED_COUNTRY 73 
            INVALID_CED_PHONE 74
            INVALID_CED_EMAIL 75 
            INVALID_CED_FAX 76 
            INVALID_CED_ZIP 77
            NAMESERVER_NEEDED 78 
            INVALID_NAMESERVER 79 
            MAXIMUM_LIMIT_REACH 80
            INVALID_DOMAIN_NAME 81 
            INVALID_DOMAIN_TYPE 82 
            DOMAIN_ONPROCESS 83 
            IP_ADDRESS_NEEDED 84
            INVALID_IP_ADDRESS 85 
            INVALID_REMOTE_ADDRESS 86 
            INVALID_DOMAIN_EXT 87 
            INVALID_HOST_NAME 88 
            INVALID_INPUT 89 
            INVALID_SUB_DOMAIN 90 
            MISSING_NAME 91 
            INVALID_RECORD_TYPE 92 
            INVALID_REFERENCE 93 
            DOMAIN_UNAVAILABLE 94 
            TH_DOMAIN_UNAVAILABLE 95 
            INVALID_TH_DOMAIN 96 
            URL_REQUIRED 97 
            DOTARAI_NAMESERVER_REQUIRED 98 
            REDIRECT_FORWARD_EMPTY 99
            
        ';
        
        $aMessage           = explode("\n", $message);
        
        $msg                = '';
        foreach ($aMessage as $v) {
            $v = trim($v);
            if (preg_match('/\s'. $code .'$/', $v)) {
                $msg        = $v;
                break;
            }
        }
        return $msg;
    }

}