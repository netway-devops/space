<?php

require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'class.general.custom.php');
require_once( dirname(__FILE__) . '/class.dotarai_api.php');

class dotarai_domain extends DomainModule {
    
    protected $description      = 'DotArai (Advance module) domain registrar by netway';
    
    protected $configuration    = array(
                'apiLogin'      => array(
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
                    'apiLogin'      => 'API Login',
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
        $detail                 = $this->options;
        $detail['domain']       = $detail['sld'] .'.'. $detail['tld'];

        $return             = array(
            'status' => $this->status // ต้องมี return ป้องกัน error
        );

        $results                = $this->Send('Synchronize', $detail);

        if (! $results) {
            $this->addError('Domain synchronize action is fail.');
            return $return;
        }
        
        preg_match('/result=([0-9]+)$/', $results, $matches);
        
        $result             = isset($matches[1]) ? $matches[1] : 0;
        
        if ($result) {
            $errorMessage       = dotAraiApi::errorMessage($result);
            $this->addError($results .' '. $errorMessage);
            return $return;
        }
        
        preg_match('/Status:\s(.*)/i', $results, $matches);
        
        if (! isset($matches[1])) {
            $this->addError($results);
            return $return;
        }
        
        $status         = ucfirst(strtolower(trim($matches[1])));

        if ($status != 'Active') {
            if(preg_match('/pending/i', $this->status)) {
                return $return;
            }
        }

        if ($status) {
            $return['status']   = $status;
        }
        
        preg_match_all('/Name\sServer:\s(.*)/i', $results, $matches);
        
        if (isset($matches[1]) && count($matches[1]) && is_array($matches[1])) {
            $return['ns']       = $matches[1];
        }
        
        preg_match('/Exp\sdate:\s(.*)/i', $results, $matches);
        
        if (isset($matches[1])) {
            $return['expires']  = date('Y-m-d', strtotime(trim($matches[1])));
        }
        
        return $return;
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
        
        //echo '<pre>'. print_r($errorCode, true) .'</pre>'; exit;
        
        $results                = $this->Send('Register', $detail);
        $results                = trim($results);
        if ($results == '') {
            $this->addError('Domain register action is fail.');
            return false;
        }
        
        parse_str($results);
        /*
        if (isset($result) && $result == '0') {
            $this->addDomain('Active');
            $this->addInfo($results);
            return true;
        }
        */
        if (isset($invoiceId) && $invoiceId) {
            $this->addDomain('Pending Registration');
            $this->addInfo($results 
                . ' Invoice id: #'. $invoiceId 
                . ' ถูกสร้างไว้ที่ DotArai จะมี cron ตรวจสอบและเปลี่ยนสถานะใน billing ให้แบบ auto');
            return true;
        }
        
        if (isset($result) && $result) {
            $errorMessage       = dotAraiApi::errorMessage($result);
            $this->addError($results .' '. $errorMessage);
        }
        
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
        
        //echo '<pre>'. print_r($detail, true) .'</pre>'; exit;
        
        $results                = $this->Send('Transfer', $detail);
        $results                = trim($results);
        
        if (! $results) {
            $this->addError('Domain transfer action is fail.');
            return false;
        }
        
        parse_str($results);
        /*
        if (isset($result) && $result == '0') {
            $this->addDomain('Active');
            $this->addInfo($results);
            return true;
        }
        */
        if (isset($invoiceId) && $invoiceId) {
            $this->addDomain('Pending Transfer');
            $this->addInfo($results 
                . ' Invoice id: #'. $invoiceId 
                . ' ถูกสร้างไว้ที่ DotArai จะมี cron ตรวจสอบและเปลี่ยนสถานะใน billing ให้แบบ auto');
            return true;
        }
        
        if (isset($result) && $result) {
            $errorMessage       = dotAraiApi::errorMessage($result);
            $this->addError($results .' '. $errorMessage);
        }
        
        return false;
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
        
        if (! $results) {
            $this->addError('Domain renew action is fail.');
            return false;
        }
        
        parse_str($results);
        
        if (isset($result) && (int)$result) {
            $errorMessage       = dotAraiApi::errorMessage($result);
            $this->addError($results .' '. $errorMessage);
            return false;
        }
        self::_apiSyncDomain($domainId);
        $this->addInfo('ถ้าโดเมนไม่ได้ถูก renew ให้เข้าไปจ่ายเงินสำหรับ Invoice#'. (isset($invoiceId) ? $invoiceId : '') .' '. $results .' ที่ dotarai');
        return true;
    }
    
    private function _apiSyncDomain ($domainId)
    {
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        
        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl . '/api.php');
        
        $aParam         = array(
            'call'      => 'domainSynch',
            'id'        => $domainId
        );
        
        $apiCustom->request($aParam);
    }

    public function getNameServers ()
    {
        $detail                 = $this->options;
        $detail['domain']       = $detail['sld'] .'.'. $detail['tld'];
        
        //echo '<pre>'. print_r($detail, true) .'</pre>'; exit;
        
        $results                = $this->Send('Synchronize', $detail);

        if (! $results) {
            $this->addError('Domain synchronize action is fail.');
            return false;
        }
        
        preg_match('/result=([0-9]+)$/', $results, $matches);
        
        $result             = isset($matches[1]) ? $matches[1] : 0;
        
        if ($result) {
            $errorMessage       = dotAraiApi::errorMessage($result);
            $this->addError('ไม่สามารถดำเนินการได้ อาจต้องรอสักพัก '. $errorMessage);
            return false;
        }
        
        preg_match_all('/Name\sServer:\s(.*)/i', $results, $matches);
        
        $aNameserver        = array();
        if (isset($matches[1]) && count($matches[1]) && is_array($matches[1])) {
            $aNameserver        = $matches[1];
        }
        
        return $aNameserver;
    }

    public function updateNameServers ()
    {
        
        $detail                 = $this->options;
        
        $detail['domain']       = $detail['sld'] .'.'. $detail['tld'];
        
        $detail['nameservers']['ns1']   = $detail['ns1'];
        $detail['nameservers']['ns2']   = $detail['ns2'];
        $detail['nameservers']['ns3']   = $detail['ns3'];
        $detail['nameservers']['ns4']   = $detail['ns4'];
        
        //echo '<pre>'. print_r($detail, true) .'</pre>'; exit;
        
        $results                = $this->Send('UpdateNameserver', $detail);
        
        if (! $results) {
            $this->addError('Domain update nameserver action is fail.');
            return false;
        }
        
        preg_match('/result=([0-9]+)$/', $results, $matches);
        
        $result             = isset($matches[1]) ? $matches[1] : 0;
        
        if ($result) {
            $errorMessage       = dotAraiApi::errorMessage($result);
            $this->addError($results .' '. $errorMessage);
            return false;
        }
        
        // Puttipong Pengprakhon (puttipong at rvglobalsoft.com)
        // Solution https://docs.google.com/a/rvglobalsoft.com/document/d/1b09Uu3rrKI_24FE4qdVD2zJU-BnpxLUbU2X2QeqNbCY/edit
        // 5. บน hostbill กรณีเปลี่ยน NS มาที่เราแล้ว zone จะถูกสรางขึ้นได้อย่างไร 
          
        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
           
        $adminUrl = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
        
        $post = array(
               'call' => 'module',
               'module' => 'billingcycle',
               'fn' => 'updateNameServer',
               'domainName' => $details['domain']
        );
        $apiCustom->request($post);
        
        $this->addInfo($results);
        return true;
    }
    
    private function Send ($action, $detail)
    {
        $apiLogin       = $this->configuration['apiLogin']['value'];
        $apiKey         = $this->configuration['apiKey']['value'];
        $isTestMode     = $this->configuration['isTestMode']['value'];
        
        if ($isTestMode) {
            $this->addError('Domain module is test mode.');
            return false;
        }
        
        $oDotAraiApi    = new dotAraiApi($apiLogin, $apiKey);
        
        switch ($action) {
            case 'Register'         : {
                return $oDotAraiApi->register($detail);
                break;
            }
            case 'Synchronize'      : {
                return $oDotAraiApi->synchronize($detail['domain']);
                break;
            }
            case 'Transfer'         : {
                return $oDotAraiApi->transfer($detail);
                break;
            }
            case 'Renew'            : {
                return $oDotAraiApi->renew($detail);
                break;
            }
            case 'UpdateNameserver' : {
                return $oDotAraiApi->updatenameservers($detail);
                break;
            }
        }
        
        return false;
    }
    
}