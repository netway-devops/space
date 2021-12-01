<?php

if (! defined('SRSPLUS_REGISTRAR_WEBROOT')) {
    define("SRSPLUS_REGISTRAR_WEBROOT", dirname(__FILE__) . '/srsplus');
}

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'modules/Domain/srsplus_domain/srsplus_command.php');

class srsplus_domain extends DomainModule {
    
    protected $description      = 'SRSPlus (Advance module) domain registrar by netway';
    
    protected $configuration    = array();
            
    protected $lang             = array();
    
    protected $commands         = array(
        'Register', 'Transfer', 'Renew', 'Synchronize'
    );
            
    // $this->options;
    // $this->client_data;
    

    public function testConnection() {         
        $sld    = 'siaminterhost';
        $tld    = '.com';
        $aParam         = array(
            'DOMAIN'    => $sld,
            'TLD'       => $tld
        );
        $result         = SRSPlusCommand::singleton()->SynchronizeDomain( $aParam );
        $this->addInfo('<pre>'. print_r($result, true) .'</pre>');
        return true;

    }
    
    public function synchInfo ()
    {
        return self::Synchronize();
    }
    
    public function Synchronize ()
    {
        $detail             = $this->options;
        $detail['domain']   = $detail['sld'] .'.'. $detail['tld'];
        
        $return             = array(
            'status' => $this->status // ต้องมี return ป้องกัน error
        );

        $aResult    = SRSPlusAPI::synchronize($detail['domain']);

        if ($aResult['status'] != 'Active') {
            if(preg_match('/pending/i', $this->status)) {
                return $return;
            }
        }

        if ($aResult['success']) {
            $return['expires']  = $aResult['expires'];
            $return['status']   = $aResult['status'];
            $return['ns']       = $aResult['ns'];
            $return['lockdomain'] = $aResult['lockdomain'];
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
        
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
           
        $adminUrl = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
         
        $post = array(
               'call'       => 'module',
               'module'     => 'dnsservicehandle',
               'fn'         => 'addDNSZone',
               'domainName' => $detail['domain'] ,
               'domainID'   => $detail['id'] ,
               'do'         => 'Update name server srsplus'
        );
        
        $aRes = $apiCustom->request($post);
        
        $aResult    = SRSPlusAPI::updatenameservers($detail);
        
        if ($aResult['success']) {
            
            require_once(APPDIR . 'class.config.custom.php');
            require_once(APPDIR . 'class.general.custom.php');
            require_once(APPDIR . 'class.api.custom.php');
            
            /* --- sync update domain info --- */
            $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
            $apiCustom  = ApiCustom::singleton($adminUrl .'/api.php');
            
            $aParam     = array(
                'call'  => 'domainSynch',
                'id'    => $details['id']
            );
            $result     = $apiCustom->request($aParam);
            
            return true;
            
        }
        
        $aResult    = SRSPlusAPI::synchronize($detail['domain']);
        if ($aResult['success']) {
            $return['ns']       = $aResult['ns'];
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
        
        $aResult        = SRSPlusAPI::register($detail);
        
        if ($aResult['success']) {
            return true;
        }
        
        $this->addError('Domain register action is fail. <pre>'. print_r($aResult['log'], true) .'</pre>');
        return false;
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
        
        $aResult        = SRSPlusAPI::transfer($detail);
        
        if ($aResult['success']) {
            return true;
        }
        
        $this->addError('Domain transfer action is fail. <pre>'. print_r($aResult['log'], true) .'</pre>');
        return false;
    }
    
    public function Renew ()
    {
        $db             = hbm_db();
        $domainId       = $this->domain_id;
        
        $result         = GeneralCustom::singleton()->isDomainAllowRenewable($domainId);
        if (! $result) {
            $this->addError('Domain #' . $domainId  . ' ไม่อยู่ในเงื่อนไขที่จะทำการ autorenew ได้ ');
            return false;
        }
        
        $detail                 = $this->options;
        
        $detail['domain']       = $detail['sld'] .'.'. $detail['tld'];
        $detail['period']       = $detail['numyears'];
        
        $aResult    = SRSPlusAPI::renew($detail);
        
        if ($aResult['success']) {
            
            $result     = $this->Synchronize();
            if (isset($result['expires'])) {
                
                $db->query("
                    UPDATE hb_domains
                    SET expires = :expires
                    WHERE id = :id
                    ", array(
                        ':expires'  => $result['expires'],
                        ':id'       => $domainId
                    ));
                
            }
            
            return true;
        }
        
        $this->addError('Domain transfer action is fail. <pre>'. print_r($aResult['log'], true) .'</pre>');
        return false;
    }
    
}

class SRSPlusAPI {
    
    public static $aHBFieldToReg      = array(
                'firstname'         => 'FNAME',
                'lastname'          => 'LNAME',
                'companyname'       => 'ORGANIZATION',
                'address1'          => 'ADDRESS1',
                'city'              => 'CITY',
                'state'             => 'PROVINCE',
                'country'           => 'COUNTRY',
                'postcode'          => 'POSTAL_CODE',
                'phonenumber'       => 'PHONE',
                'email'             => 'EMAIL',
                'fax'               => 'FAX',
                'address2'          => 'ADDRESS2'
                );
    public static $aContact = array('admin' => 'Admin', 'tech' => 'Tech', 'registrant' => 'Registrant', 'billing' => 'Billing');
    
    public function synchronize ($domainName)
    {
        $return                 = array();
        $return['success']      = 1;
        $return['status']       = '';
        $return['ns']           = array();
        
        $tld            = substr(strstr($domainName, '.'), 1);
        $sld            = substr($domainName, 0, - (strlen($tld)+1));
        
        $aParam         = array(
                    'DOMAIN'    => $sld,
                    'TLD'       => $tld
                );
        
        $result         = SRSPlusCommand::singleton()->SynchronizeDomain( $aParam );

        if (isset($result['expire'])) {
            $return['expires']      = date('Y-m-d', $result['expire']);
            
            if ($result['expire'] > time()) {
                $return['status']   = 'Active';
            } else {
                $return['status']   = 'Expired';
            }
            
        }
        
        if (isset($result['nameserver1'])) {
            $return['ns']           = array($result['nameserver1'], $result['nameserver2']);
        }
        
        if ($return['status'] == '') {
            $return['success']      = 0;
            $return['log']          = '<pre>'. $result['log'] .'</pre>';
        }
        
        $return['log']          = '<pre>'. $result['log'] .'</pre>';

        $isLock = $result['lockdomain'] ;
        self::lockDomain($domainName,$isLock);

        $isPrivate  = isset($result['privateDomain']) ? $result['privateDomain'] : 0;
        self::privateDomain($domainName,$isPrivate);
        
        return $return;
    }

    public function privateDomain ($domainName, $isPrivate)
    {
        $db             = hbm_db();
        $db->query("
            UPDATE hb_domains
            SET idprotection = :idprotection
            WHERE name = :name
            ", array(
                ':idprotection' => $isPrivate,
                ':name'     => $domainName,
            ));
    }
    
    public function lockDomain($domainName,$isLock){
            
        $db             = hbm_db();
            
        //หาโปรดักไอดี
        $result         = $db->query("SELECT d.id,d.tld_id
                                      FROM hb_domains d
                                      WHERE d.name = :domainName
                                    ",array(
                                            ':domainName'   => $domainName
                                    ))->fetch();
        $accountId      = $result['id'];
        
        //หา customfield_id
        $result         = $db->query("SELECT cic.id
                                      FROM hb_config_items_cat cic
                                      WHERE cic.variable = 'lock_domain'
                                      AND cic.product_id = :productId
                                    ",array(
                                            ':productId'   => $result['tld_id']
                                    ))->fetch();
        $configCat      = $result['id'];
        
        //หา config_items_id
        $result         = $db->query("SELECT ci.id
                                      FROM hb_config_items ci
                                      WHERE ci.category_id = :category_id
                                    ",array(
                                            ':category_id'   => $result['id']
                                    ))->fetch();
        $configId       = $result['id'];
        
        if($isLock == 0){
            
            $db             = hbm_db();
            $db->query("DELETE FROM hb_config2accounts
                                          WHERE account_id = :accountId
                                          AND config_cat = :configCat
                                          AND config_id = :configId
                                        ",array(
                                                ':accountId'        => $accountId,
                                                ':configCat'        => $configCat,
                                                ':configId'         => $configId
                                        ));

        }else{

            $result         = $db->query("SELECT count(*) as num
                                          FROM hb_config2accounts
                                          WHERE account_id = :accountId
                                          AND config_cat = :configCat
                                          AND config_id = :configId
                                        ",array(
                                                ':accountId'        => $accountId,
                                                ':configCat'        => $configCat,
                                                ':configId'         => $configId
                                        ))->fetch();
            if($result['num'] != 0){
                 $db->query("UPDATE
                             hb_config2accounts
                             SET qty = 1 , data = 1
                             WHERE account_id = :accountId
                             AND config_cat = :configCat
                             AND config_id = :configId
                             ",array(
                                    ':accountId'        => $accountId,
                                    ':configCat'        => $configCat,
                                    ':configId'         => $configId
                                    ));
            }else{
                 $db->query("INSERT INTO 
                       hb_config2accounts 
                       (rel_type,account_id,config_cat,config_id,qty,data)
                       VALUE('Domain',:accountId,:configCat,:configId,1,1)
                       ",array(
                               ':accountId'        => $accountId,
                               ':configCat'        => $configCat,
                               ':configId'         => $configId
                       ));
            }
        }
    }
    
    public function register ($details)
    {        
        $domainName     = $details['domain'];
        $year           = $details['period'];
        
        $ns1            = $details['nameservers']['ns1'];
        $ns2            = $details['nameservers']['ns2'];
        $ns3            = $details['nameservers']['ns3'];
        $ns4            = $details['nameservers']['ns4'];
        
        $oPersonRegistrant  = (object) $details['registrant'];
        $aPersonRegistrant  = array();
        
        $oPersonAdmin       = (object) $details['admin'];
        $aPersonAdmin       = array();
        
        foreach (self::$aHBFieldToReg as $key => $val) {
            $aPersonRegistrant[$val]    = $oPersonRegistrant->{$key};
            $aPersonAdmin[$val]         = $oPersonAdmin->{$key};
        }
        
        $tld            = substr(strstr($domainName, '.'), 1);
        $sld            = substr($domainName, 0, - (strlen($tld)+1));
        
        $aParam         = array(
                    'DOMAIN'                => $sld,
                    'TLD'                   => $tld,
                    'TERM_YEARS'            => $year,
                    'RESPONSIBLE_PERSON'    => 0,
                    'TECHNICAL_CONTACT'     => 0,
                    'PRICE'                 => 100.00,
                    'DNS_SERVER_NAME_1'     => $ns1,
                    'DNS_SERVER_NAME_2'     => $ns2,
                    'DNS_SERVER_NAME_3'     => $ns3,
                    'DNS_SERVER_NAME_4'     => $ns4,
                    'REGISTRANT_CONTACT'    => $aPersonRegistrant,
                    'ADMIN_CONTACT'         => $aPersonRegistrant
                );
        
        $result         = SRSPlusCommand::singleton()->RegisterDomain( $aParam );
        
        $return                 = array();
        $return['success']      = 1;
        
        if (isset($result['error']) && $result['error']) {
            $return['success']      = 0;
            $return['log']          = $result['log'];
        }
        
        return $return;
    }
    
    public function renew($details)
    {
        
        $domainName     = $details['domain'];
        $period         = $details['period'];

        $tld            = substr(strstr($domainName, '.'), 1);
        $sld            = substr($domainName, 0, - (strlen($tld)+1));
        
        $aParam         = array(
                    'DOMAIN'        => $sld,
                    'TLD'           => $tld,
                    'TERM_YEARS'    => $period,
                    'PRICE'         => 100.00
                );
        
        $result         = SRSPlusCommand::singleton()->RenewDomain( $aParam );
        
        $return                 = array();
        $return['success']      = 1;
        
        if (isset($result['error']) && $result['error']) {
            $return['success']      = 0;
            $return['log']          = '<pre>'. $result['log'] .'</pre>';
        }
        
        return $return;
    }
    
    public function transfer($details)
    {
        $eppCode        = $details['epp_code'];
        if (! $eppCode) {
            $return                 = array();
            $return['success']      = 0;
            $return['log']          = '<pre>Empty epp_code</pre>';
            return $return;
        }
        
        $domainName     = $details['domain'];
        
        $tld            = substr(strstr($domainName, '.'), 1);
        $sld            = substr($domainName, 0, - (strlen($tld)+1));
        
        $oPersonRegistrant  = (object) $details['registrant'];
        $aPersonRegistrant  = array();
        
        $oPersonAdmin       = (object) $details['admin'];
        $aPersonAdmin       = array();
        
        foreach (self::$aHBFieldToReg as $key => $val) {
            $aPersonRegistrant[$val]    = $oPersonRegistrant->{$key};
            $aPersonAdmin[$val]         = $oPersonAdmin->{$key};
        }
        
        $aParam         = array(
                    'DOMAIN'                => $sld,
                    'TLD'                   => $tld,
                    'REGISTRANT_CONTACT'    => $aPersonRegistrant,
                    'ADMIN_CONTACT'         => $aPersonAdmin,
                    'CURRENT_ADMIN_EMAIL'   => $oPersonAdmin->email,
                    'AUTH_CODE'             => $eppCode,
                );

        $result         = SRSPlusCommand::singleton()->TransferDomain( $aParam );
        
        $return                 = array();
        $return['success']      = 1;
        $return['result']       = $result;
        
        if (isset($result['error']) && $result['error']) {
            $return['success']      = 0;
            $return['log']          = '<pre>'. $result['log'] .'</pre>';
        }
        
        hbm_error($result['log']);
        hbm_error($result['error']);
        
        return $return;
    }
    
    public function updatenameservers($details)
    {
        $return                 = array();
        $return['success']      = 0;
        
        if (! isset($details['nameservers']) && isset($details['ns1'])) {
            $details['nameservers'] = array($details['ns1'], $details['ns2']);
            if (isset($details['ns3'])) {
                $details['nameservers'][]   = $details['ns3'];
            }
            if (isset($details['ns4'])) {
                $details['nameservers'][]   = $details['ns4'];
            }
        }
        
        if ( ! isset($details['nameservers']) || ! is_array($details['nameservers'])) {
            $return['log']          = 'ข้อมูล Nameserver ไม่ถูกต้อง';
            
            return $return;
        }
        
        $domainName     = $details['domain'];
        
        $tld            = substr(strstr($domainName, '.'), 1);
        $sld            = substr($domainName, 0, - (strlen($tld)+1));
        
        $aParam         = array(
                    'DOMAIN'    => $sld,
                    'TLD'       => $tld
                );

        $i      = 0;
        if (is_array($details['nameservers']) && count($details['nameservers'])) {
            foreach ($details['nameservers'] as $v) {
                $v      = trim($v);
                if ($v) {
                    $i++;
                    $aParam['DNS_SERVER_NAME_'. $i]     = $v;
                }
            }
        }
        
        if (! $i) {
            $return['log']          = 'ข้อมูล Nameserver ไม่ถูกต้อง';
            
            return $return;
        }
        
        $result         = SRSPlusCommand::singleton()->SaveDNS( $aParam );
        /*
        if ($domainName == 'thaivps.com') {
            echo '<pre>'. print_r($aParam, true) .'</pre>';
            echo '<pre>'. print_r($result, true) .'</pre>';
            exit;
        }
        */
        $return                     = array();
        $return['success']          = 1;
        
        if (isset($result['error']) && $result['error']) {
            $return['success']      = 0;
            
            if (isset($result['log'])) {
                $return['log']      = '<pre>'. $result['log'] .'</pre>';
            }
            
        }
        
        echo '
            <style>
            #infos {
                background:#d5ffce; border:solid 1px #9adf8f; padding:8px 8px 8px 30px;
                margin-bottom:8px; color:#556652; font-weight:bold; position:relative;
            }
            #infos span, #errors span { display:block; margin-bottom:3px; }
            </style>
            <div id="infos">
                <h4>Success: อาจจะต้องรอประมาณ 5-10 นาที เพื่อให้ข้อมูล nameserver ที่ registrar อัพเดท</h4>
                <p>' . $result['error'] . '</p>
            </div>
            ';
            
        return $return;
    }
    
    public function getcontacts($domainName)
    {
        $return         = array();
        
        $tld            = substr(strstr($domainName, '.'), 1);
        $sld            = substr($domainName, 0, - (strlen($tld)+1));
        
        $aParam         = array(
                    'DOMAIN'    => $sld,
                    'TLD'       => $tld
                );
        
        $result         = SRSPlusCommand::singleton()->GetContactDetails( $aParam );
        
        if ( ! isset($result['Registrant'])) {
            return false;
        }

        foreach (self::$aContact as $k => $v) {
            if (! is_array($return[$k])) {
                $return[$k]     = array();
            }
            foreach (self::$aHBFieldToReg as $key => $val) {
                $return[$k][$key]   = isset($result[$v][$val]) ? $result[$v][$val] : '';
            }
            
        }
        
        return $return;
    }
    
    public function updatecontacts($details)
    {
        $return         = array();
        
        require_once(APPDIR . 'class.config.custom.php');
        $nwTechnicalContact     = ConfigCustom::singleton()->getValue('nwTechnicalContact');
        
        // --- hostbill helper ---
        $db         = hbm_db();
        // --- hostbill helper ---
        
        $result         = $db->query("
                    SELECT
                        ca.email
                    FROM
                        hb_client_access ca
                    WHERE
                        ca.id = :contactId
                    ", array(
                        ':contactId'    => $nwTechnicalContact
                    ))->fetch();
        $techEmailContact   = $result['email'];
        
        $domainName     = $details['domain'];
        
        $aContactInfo   = array(
                    'registrant'    => $details['registrant'],
                    'admin'         => $details['admin'],
                    'tech'          => $details['tech'],
                    'billing'       => $details['billing']
                );
        
        $tld            = substr(strstr($domainName, '.'), 1);
        $sld            = substr($domainName, 0, - (strlen($tld)+1));
        
        $aParam         = array(
                    'DOMAIN'    => $sld,
                    'TLD'       => $tld
                );
        /* --- สำหรับ srsplus ต้องได้ contact id ก่อน --- */
        $aCurrentContact    = SRSPlusCommand::singleton()->GetContactDetails( $aParam );

        foreach (self::$aContact as $k => $v) {
            
            if ( ! isset($aContactInfo[$k])) {
                continue;
            }
            
            $oPerson        = (object) $aContactInfo[$k];
            $aParam         = array();
            foreach (self::$aHBFieldToReg as $key => $val) {
                $aParam[$val]   = $oPerson->{$key};
            }
            
            $aParam['TLD']          = $tld;
            
            $isEdit         = self::_isEditContactInfo($aParam, $aCurrentContact[$v]);
            
            if (! $isEdit) {
                continue;
            }
            
            /* --- ถ้ามีการแก้ไข ให้ไปค้นหา contact id ก่อน --- */
            $result         = SRSPlusCommand::singleton()->SaveContactDetails( $aParam );
            if (! isset($result['contact_id']) || ! $result['contact_id'] 
                || $aCurrentContact[$v]['CONTACTID'] == $result['contact_id']) {
                continue;
            }
            
            $aCurrentContact[$v]['CONTACTID']   = $result['contact_id'];

        }

        /* --- ส่งไป update contact id ให้ domain --- */
        $aParam         = array(
                    'TLD'                       => $tld,
                    'DOMAIN'                    => $sld,
                    'REGISTRANT_CONTACT_ID'     => $aCurrentContact['Registrant']['CONTACTID'],
                    'TECHNICAL_CONTACT_ID'      => $aCurrentContact['Tech']['CONTACTID'],
                    'BILLING_CONTACT_ID'        => $aCurrentContact['Billing']['CONTACTID'],
                    'ADMIN_CONTACT_ID'          => $aCurrentContact['Admin']['CONTACTID']
                );
        
        $result         = SRSPlusCommand::singleton()->UpdateDomainContact( $aParam );
        
        if (isset($result['error']) && $result['error']) {
            $return['error']    = $result['error'];
        }
        
        return $return;
    }

    private function _isEditContactInfo ($aNewContact, $aCurrentContact)
    {
        
        $newContact     = $aNewContact['FNAME'] . $aNewContact['LNAME'] . $aNewContact['ORGANIZATION'] .
                $aNewContact['ADDRESS1'] . $aNewContact['ADDRESS2'] . $aNewContact['CITY'] . 
                $aNewContact['PROVINCE'] . $aNewContact['COUNTRY'] . $aNewContact['POSTAL_CODE'] . 
                $aNewContact['PHONE'] . $aNewContact['EMAIL'];
                
        $currentContact = $aCurrentContact['FNAME'] . $aCurrentContact['LNAME'] . $aCurrentContact['ORGANIZATION'] .
                $aCurrentContact['ADDRESS1'] . $aCurrentContact['ADDRESS2'] . $aCurrentContact['CITY'] . 
                $aCurrentContact['PROVINCE'] . $aCurrentContact['COUNTRY'] . $aCurrentContact['POSTAL_CODE'] . 
                $aCurrentContact['PHONE'] . $aCurrentContact['EMAIL'];
                
        if (md5($newContact) == md5($currentContact)) {
            return false;
        }
        
        return true;
    }
    

}