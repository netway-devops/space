<?php

class cloudlinuxlicensehandle extends HostingModule
{
    protected $description  = 'ส่วนจัดการ provisioning CloudLinux license';

     protected $serverFields = array(
        'hostname' => false,
        'ip' => false,
        'maxaccounts' => false,
        'status_url' => false,
        'field1' => false,
        'field2' => false,
        'username' => true,
        'password' => true,
        'hash' => false,
        'ssl' => false,
        'nameservers' => false
    );

    protected $serverFieldsDescription = array(
    );

    public $demo        = true;
    public $cpl;

    public $aConfig     = array(
        'username'      => 'Rv97Pj3W',
        'password'      => 'Z6)Hnb)/S48F',
        'groupid'       => '45025'
    );

    public $aPackage    = array(
        '116'           => array('name' => 'CloundLinux (cPanel Server)', 'package' => '6337'),
        '137'           => array('name' => 'CloundLinux (Other Server)', 'package' => '6341'),
        );

    protected $options      = array();

    protected $details      = array();

    public function verifyLicense ($ip)
    {
        $oResult    = new stdClass;
        $oResult->available     = false;
        $oResult->type          = '';

        $urlRequest = 'http://verify.cpanel.net/index.cgi?ip=' . $ip;
        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        $result     = str_replace("\n", "", $result);

        if (preg_match('/<b>Not\slicensed<\/b>/', $result)) {
            $oResult->available     = 'Register';
            return $oResult;
        }

        preg_match('/\<table class=\"history table\"\>.*\<\/table\>/', $result, $specificClass);
        $specificClass = str_replace("\n", "", $specificClass[0]);
        $searchByTr = explode('<tr', $specificClass);
        foreach($searchByTr as $eachData){
        	$nowSearch = str_replace(' ', '', $eachData);
        	if(strpos($nowSearch, '</tr>')) $nowSearch = '<tr' . $nowSearch;
        	if(strpos($nowSearch, '<tdalign="center">CloudLinux</td><td><b>active<br/></b></td>')){
        		if(strpos($nowSearch, 'RVGlobalSoftCo.,Ltd</a></td>')){
        			$oResult->available = false;
        		} else {
        			$oResult->available = 'Transfer';
        			if(strpos($nowSearch, '-VPS</td>')){
        				$oResult->type      = 'VPS';
        			} else {
        				$oResult->type      = 'Dedicated';
        			}
        		}
        		return $oResult;
        	}
        }

        if (preg_match('/<b>active<\/b>/', $result, $matches, PREG_OFFSET_CAPTURE)
            && preg_match('/alt="CloudLinux"/', $result) ) {
            $pos            = isset($matches[0][1]) ? $matches[0][1] : 0;
            $distributor    = substr($result, 0, $pos);

            if (preg_match('/RV\sGlobal\sSoft/', $distributor)) {
                if (self::_isClientLicense($ip)) {
                    $oResult->available     = false;
                    return $oResult;
                }
            }

            $oResult->available     = 'Transfer';

            if (preg_match('/\-VPS/', $distributor)) {
                $oResult->type      = 'VPS';
            } else {
                $oResult->type      = 'Dedicated';
            }

            return $oResult;
        }

        $oResult->available     = 'Register';
        if (preg_match('/active\son/', $result, $matches, PREG_OFFSET_CAPTURE)) {
            $pos            = isset($matches[0][1]) ? $matches[0][1] : 0;
            $license        = substr($result, 0, $pos);

            if (preg_match('/\-VPS/', $license)) {
                $oResult->type      = 'VPS';
            } else {
                $oResult->type      = 'Dedicated';
            }

        }

        return $oResult;
    }

    private function _isClientLicense ($ip)
    {
        $db             = hbm_db();

        $client         = hbm_logged_client();
        $clientId       = isset($client['id']) ? $client['id'] : 0;

        $result         = $db->query("
                SELECT
                    c2a.*
                FROM
                    hb_accounts a,
                    hb_config2accounts c2a,
                    hb_config_items_cat cic
                WHERE
                    a.id = c2a.account_id
                    AND c2a.rel_type = 'Hosting'
                    AND a.status = 'Active'
                    AND cic.variable = 'ip'
                    AND cic.id = c2a.config_cat
                    AND a.client_id = :clientId
                    AND a.product_id IN (". implode(',', array_keys($this->aPackage)) .")
                    AND c2a.data = :ip
                ", array(
                    ':clientId'     => $clientId,
                    ':ip'           => $ip
                ))->fetch();

        if (isset($result['config_id']) && $result['config_id']) {
            return true;
        }

        return false;
    }

    public function connect ($detail)
    {
        if (! class_exists('cPanelLicensing' , false)) {
            require_once(APPDIR .'libs/cpanel/cpl-3.6/php/cpl.inc.php');
        }

        $this->cpl      = new cPanelLicensing($this->aConfig['username'], $this->aConfig['password']);
        //$this->cpl->set_format('json');

        return true;
    }

    public function testConnection ()
    {
        /*
        $result         = $this->cpl->fetchGroups();
        $json           = json_encode($result);
        $array          = json_decode($json,TRUE);
        */
        return true;
    }

    public function Create ()
    {
        require_once(APPDIR . 'class.general.custom.php');

        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $aAdmin['username'] = (empty($aAdmin['username'])) ? 0 : $aAdmin['username'];

        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];

        if (preg_match('/transfer/i', $aDetail['status'])) {
            return $this->_transfer();
        }

        $ip             = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }

        $package        = $this->aPackage[$productId]['package'];

        $aParam         = array(
            'ip'        => $ip,
            'groupid'   => $this->aConfig['groupid'],
            'packageid' => $package
            );

        $result         = $this->cpl->activateLicense($aParam);
        $array          = current($result->attributes());

        if (! $array['status']) {
            $this->addError('Error:'. $array['reason']);
            return false;
        }

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => 'Pending', 'to' => 'Active'),
            '1'     => array('status' => $array['status'], 'result' => $array['result'], 'reason' => $array['reason']),
            ));
//         $db->query("
//             INSERT INTO hb_account_logs (
//                 id, date, account_id, admin_login, module, manual, action,
//                 `change`, result, error, event
//             ) VALUES (
//                 '', NOW(), :accountId, :admin, 'cloudlinuxlicensehandle', '0', 'Create Account',
//                 :logs, '1', '', 'CreateAccount'
//             )
//             ", array(
//                 ':accountId'        => $accountId,
//                 ':admin'            => $aAdmin['username'],
//                 ':logs'             => serialize($aLog)
//             ));

        $this->addInfo('Create account:'. $accountId .' succcess.');

        return true;
    }

    private function _transfer ()
    {
        require_once(APPDIR . 'class.general.custom.php');

        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $aAdmin['username'] = (empty($aAdmin['username'])) ? 0 : $aAdmin['username'];

        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];

        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Pending Transfer',
                date_changed = NOW()
            WHERE
                status = 'Transfer Request'
                AND id = :accountId
            ", array(
                ':accountId'    => $accountId
            ));

        if ($aDetail['status'] == 'Transfer Request') {
            $aLog       = array('serialized' => '1', 'data' => array(
                '0'     => array('name' => 'status', 'from' => 'Transfer Request', 'to' => 'Pending Transfer'),
                ));
            $db->query("
                INSERT INTO hb_account_logs (
                    id, date, account_id, admin_login, module, manual, action,
                    `change`, result, error, event
                ) VALUES (
                    '', NOW(), :accountId, :admin, 'cloudlinuxlicensehandle', '0', 'Transfer Account',
                    :logs, '1', '', 'TransferAccount'
                )
                ", array(
                    ':accountId'        => $accountId,
                    ':admin'            => $aAdmin['username'],
                    ':logs'             => serialize($aLog)
                ));
        }

        $ip             = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }

        if ($this->demo) {
            $this->addInfo('Test mode');
            return true;
        }

        $package        = $this->aPackage[$productId]['package'];

        $aParam         = array(
            'ip'        => $ip,
            'groupid'   => $this->aConfig['groupid'],
            'packageid' => $package
            );

        $result         = $this->cpl->requestTransfer($aParam);
        $array          = current($result->attributes());

        if (! $array['status']) {
            $this->addError('Error:'. $array['reason']);
            return false;
        }

        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Active',
                date_changed = NOW()
            WHERE
                AND id = :accountId
            ", array(
                ':accountId'    => $accountId
            ));

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => 'Pending Transfer', 'to' => 'Active'),
            '1'     => array('status' => $array['status'], 'result' => $array['result'], 'reason' => $array['reason']),
            ));
//         $db->query("
//             INSERT INTO hb_account_logs (
//                 id, date, account_id, admin_login, module, manual, action,
//                 `change`, result, error, event
//             ) VALUES (
//                 '', NOW(), :accountId, :admin, 'cloudlinuxlicensehandle', '0', 'Transfer Account',
//                 :logs, '1', '', 'TransferAccount'
//             )
//             ", array(
//                 ':accountId'        => $accountId,
//                 ':admin'            => $aAdmin['username'],
//                 ':logs'             => serialize($aLog)
//             ));

        $this->addInfo('Transfer account:'. $accountId .' succcess.');

        return true;
    }

    /**
     * Cloud linux license จะถูกต่ออายุอัตโนมัติ จนกว่าเราจะยกเลิกบริการ
     */
    public function Renewal ()
    {
        $db             = hbm_db();

        $this->addInfo('Renew account:'. $accountId .' succcess.');

        return true;
    }

    public function Suspend ()
    {
        return ($this->Terminate()) ? true : false;
    }

    public function Unsuspend ()
    {
        return ($this->Create()) ? true : false;
    }

    public function Terminate ()
    {
        require_once(APPDIR . 'class.general.custom.php');

        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $aAdmin['username'] = (empty($aAdmin['username'])) ? 0 : $aAdmin['username'];

        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];
        $status         = $aDetail['status'];

        $ip             = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);
        $package        = $this->aPackage[$productId]['package'];

        $aParam         = array(
            'ip'        => $ip,
            'packageid' => $package,
            );

        $result         = $this->cpl->fetchLicenseId($aParam);
        $json           = json_encode($result);
        $array          = json_decode($json,TRUE);

        $licenseId      = isset($array['licenseid']) ? $array['licenseid'] : '';

        if (! $licenseId) {
            $this->addInfo('Invalid license id');
            return true;
        }

        $aParam         = array(
            'liscid'    => $licenseId,
            'expcode'   => 'normal',
            );

        $result         = $this->cpl->expireLicense($aParam);
        $array          = current($result->attributes());

        if (! $array['status'] && $array['reason'] != 'License must be active.') {
            $this->addError('Error:'. $array['reason']);
            return false;
        }

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => $status, 'to' => 'Terminated'),
            '1'     => array('status' => $array['status'], 'result' => $array['result'], 'reason' => $array['reason']),
            ));
//         $db->query("
//             INSERT INTO hb_account_logs (
//                 id, date, account_id, admin_login, module, manual, action,
//                 `change`, result, error, event
//             ) VALUES (
//                 '', NOW(), :accountId, :admin, 'cloudlinuxlicensehandle', '0', 'Terminate Account',
//                 :logs, '1', '', 'AccountTerminate'
//             )
//             ", array(
//                 ':accountId'        => $accountId,
//                 ':admin'            => $aAdmin['username'],
//                 ':logs'             => serialize($aLog)
//             ));

        $this->addInfo('Terminate account:'. $accountId .' succcess.');

        return true;
    }

    private static  $instance;

    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }
}
