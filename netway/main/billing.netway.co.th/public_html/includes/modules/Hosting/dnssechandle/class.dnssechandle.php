<?php

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.api.custom.php');
require_once(APPDIR . 'modules/Domain/srsplus_domain/srsplus_command.php');
require_once dirname(__FILE__) . '/model/class.dnssechandle_model.php';

class dnssechandle extends HostingModule {
 
    protected $modname  = 'DNSSEC Request';
    
    protected $commands = array(
        'Create', 'Request'
    );
    
    protected $options  = array();
    
    protected $details  = array(
        'dnssec_status'   => array(
            'name'  => 'DS Request Status',
            'value' => '',
            'type'  => 'select',
            'default'   => array('none', 'request', 'processing', 'active')
        ),
        'dnssec_keytag'   => array(
            'name'  => 'DS Records KeyTag',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
        'dnssec_algorithm'   => array(
            'name'  => 'DS Records Algorithm',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
        'dnssec_digest_type'   => array(
            'name'  => 'DS Records Digest Type',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
        'dnssec_digest'   => array(
            'name'  => 'DS Records Digest',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
        'dnssec_info'   => array(
            'name'  => 'DS Records Info (from whois data)',
            'value' => '',
            'type'  => 'input',
            'default'   => false
        ),
    );
    
    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }

    public function connect ($detail)
    {
        
    }
    
    public function testConnection ()
    {
        return true;
    }
    
    public function Create ()
    {   
        $details    = $this->account_details;

        $this->Request();

        return true;
    }

    private function _validateField ()
    {
        
        $details    = $this->account_details;
        $domain     = isset($details['domain']) ? $details['domain'] : '';
        
        $details    = isset($details['extra_details']) ? $details['extra_details'] : '';
        $keytag     = isset($details['dnssec_keytag']) ? $details['dnssec_keytag'] : '';
        $algorithm  = isset($details['dnssec_algorithm']) ? $details['dnssec_algorithm'] : '';
        $digestType = isset($details['dnssec_digest_type']) ? $details['dnssec_digest_type'] : '';
        $digest     = isset($details['dnssec_digest']) ? $details['dnssec_digest'] : '';

        //echo '<pre>'. print_r($details, true) .'</pre>';exit;

        if ($domain == '' || $keytag == '' || $algorithm == '' || $digestType == '' || $digest == '') {
            return false;
        }
        return true;
    }
    
    public function Request ()
    {   
        if (! $this->_validateField()) {
            $this->addError('DNSSEC Request is require all field.');
            return false;
        }
        
        $details    = $this->account_details;
        
        $accountId  = isset($details['id']) ? $details['id'] : 0;

        $details    = isset($details['extra_details']) ? $details['extra_details'] : '';
        $status     = isset($details['dnssec_status']) ? $details['dnssec_status'] : '';

        if ($status != 'request') {
            $this->addError('DNSSEC Request status not in request.');
            return false;
        }

        $adminUrl       = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom      = ApiCustom::singleton($adminUrl . '/api.php');

        $aParam         = array(
            'call'      => 'module',
            'module'    => 'dnssechandle',
            'fn'        => 'sendRequest',
            'accountId' => $accountId
        );
        $apiCustom->request($aParam);

        $aAccount   = dnssechandle_model::singleton()->getAccountById($accountId);
        $aDetail    = isset($aAccount['extra_details']) ? unserialize($aAccount['extra_details']) : array();
        $status     = isset($aDetail['dnssec_status']) ? $aDetail['dnssec_status'] : '';

        if ($status != 'processing') {
            $this->addError('DNSSEC Request fail, try to change dnssec_status to request and make Request again.');
            return false;
        }

        $message    = 'DNSSEC Request to partners@srsplus.com,DNSSEC@srsplus.com.';
        $this->addInfo($message);
        hbm_log_account($message, $accountId);
        return true;
    }

    public function getSynchInfo ()
    {
        $details    = $this->account_details;
        $accountId  = isset($details['id']) ? $details['id'] : 0;
        $domain     = isset($details['domain']) ? $details['domain'] : '';

        $details    = isset($details['extra_details']) ? $details['extra_details'] : '';
        $status     = isset($details['dnssec_status']) ? $details['dnssec_status'] : '';

        if ($status != 'processing') {
            $this->addInfo('DNSSEC Request status not in processing.');
            return true;
        }

        $tld        = substr(strstr($domain, '.'), 1);
        $sld        = substr($domain, 0, - (strlen($tld)+1));

        $aParam     = array(
                    'DOMAIN'    => $sld,
                    'TLD'       => $tld
                );
        
        $result     = SRSPlusCommand::singleton()->_whois_server( $aParam );
        
        $status     = '';
        $info       = '';
        if (count($result)) {
            foreach ($result as $v) {
                if (preg_match('/DNSSEC/i', $v)) {
                    $status = 'active';
                    $info .= $v .'<br />';
                    //break;
                }
            }
        }
        
        $aDetail    = $details;
        
        if ($status) {
            $aDetail['dnssec_status']   = $status;
            $aDetail['dnssec_info']     = $info;
            
            dnssechandle_model::singleton()->updateAccountExtraDetail($accountId, $aDetail);
        }
        
        if (isset($_POST['extra_details']['dnssec_status'])) {
            echo '<pre>'. print_r($aDetail, true) .'</pre>';
            exit;
        }

        $aReturn    = array(
            'domain'        => $domain,
            'suspended'     => 0,
        );

        return $aReturn;
    }
    
}
