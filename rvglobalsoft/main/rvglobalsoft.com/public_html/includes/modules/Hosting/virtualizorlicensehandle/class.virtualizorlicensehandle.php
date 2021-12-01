<?php

// https://www.softaculous.com/docs/NOC_API#Purchase.2FRenew_Softaculous_Licenses

class virtualizorlicensehandle extends HostingModule
{
    protected $description  = 'ส่วนจัดการ provisioning Vitualizor license';

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

    protected $options      = array();

    protected $details      = array();

    public $aConfig         = array(
        'username'      => 'rvglobalsoft',
        'password'      => ',o^db0wl;',
        'url'           => 'https://www.softaculous.com/noc'
    );

    public $aPackage        = array(
        '149'           => array('name' => 'Virtualizor', 'serverType' => '1')
        );

    public $aCycle          = array(
        'Monthly'       => '1M'
        );

    public $demo        = true;
    public $noc;

    public function verifyLicense ($ip)
    {
        $db             = hbm_db();
        $oResult    = new stdClass;
        $oResult->available     = false;

        $this->connect(array());
        $result     = $this->noc->virt_licenses('', $ip);

        if (isset($result['licenses']) && count($result['licenses'])) {
            foreach ($result['licenses'] as $arr) {
                $ip     = isset($arr['ip']) ? $arr['ip'] : '';
                if (self::_isClientLicense($ip)) {
                    $oResult->available     = false;
                    return $oResult;
                }

                $oResult->available     = 'Transfer';
                $oResult->type          = 'Dedicated';
                return $oResult;
            }
        }

        $oResult->available     = 'Register';
        $oResult->type          = 'Dedicated';
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
        if (! class_exists('SOFT_NOC' , false)) {
            require_once(dirname(__FILE__) . '/lib/noc_api.php');
        }

        $this->noc      = new SOFT_NOC($this->aConfig['username'], $this->aConfig['password'], '', 1);

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
        $billingCycle   = $aDetail['billingcycle'];
        $clientId       = $aDetail['client_id'];

        if (preg_match('/transfer/i', $aDetail['status'])) {
            return $this->_transfer();
        }

        $ip             = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }

        $period         = $this->aCycle[$billingCycle];

        $result         = $this->noc->virt_licenses('', $ip);

        if (isset($result['licenses'])) {
            foreach ($result['licenses'] as $arr) {
                if (isset($arr['lid'])) {
                    $this->addError('License '. $arr['license'] .' is already created earlier.');
                    return false;
                }
            }
        }

        $result         = $this->noc->virt_buy(
            $ip,
            $period,
            0
            );

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => 'Pending', 'to' => 'Active')
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action,
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, 'virtualizorlicensehandle', '0', 'Create Account',
                :logs, '1', :result, 'CreateAccount'
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog),
                ':result'           => serialize($result)
            ));

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
        $billingCycle   = $aDetail['billingcycle'];
        $clientId       = $aDetail['client_id'];

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
                '0'     => array('name' => 'status', 'from' => 'Transfer Request', 'to' => 'Pending Transfer')
                ));
            $db->query("
                INSERT INTO hb_account_logs (
                    id, date, account_id, admin_login, module, manual, action,
                    `change`, result, error, event
                ) VALUES (
                    '', NOW(), :accountId, :admin, 'virtualizorlicensehandle', '0', 'Transfer Account',
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


        $period         = $this->aCycle[$billingCycle];

        $result         = $this->noc->virt_buy(
            $ip,
            $period,
            0
            );

        $db->query("
            UPDATE
                hb_accounts
            SET
                status = 'Active',
                date_changed = NOW()
            WHERE
                id = :accountId
            ", array(
                ':accountId'    => $accountId
            ));

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => 'Pending Transfer', 'to' => 'Active')
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action,
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, 'virtualizorlicensehandle', '0', 'Transfer Account',
                :logs, '1', :result, 'TransferAccount'
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog),
                ':result'           => serialize($result)
            ));

        $this->addInfo('Transfer account:'. $accountId .' succcess.');

        return true;
    }

    private function _getClient ($id)
    {
        $db             = hbm_db();

        $result         = $db->query("
            SELECT
                ca.*
            FROM
                hb_client_access ca
            WHERE
                ca.id = :clientId
            ", array(
                ':clientId'     => $id
            ))->fetch();

        return $result;
    }

    public function Renewal ()
    {
        require_once(APPDIR . 'class.general.custom.php');

        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $aAdmin['username'] = (empty($aAdmin['username'])) ? 0 : $aAdmin['username'];

        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];
        $billingCycle   = $aDetail['billingcycle'];
        $clientId       = $aDetail['client_id'];

        $ip             = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }

        $period         = $this->aCycle[$billingCycle];

        $result         = $this->noc->virt_buy(
            $ip,
            $period,
            0
            );

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => 'Active', 'to' => 'Active')
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action,
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, 'virtualizorlicensehandle', '0', 'Renewal Account',
                :logs, '1', :result, 'RenewalAccount'
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog),
                ':result'           => serialize($result)
            ));

        $this->addInfo('Renewal account:'. $accountId .' succcess.');

        return true;
    }

    public function Suspend ()
    {
        $db             = hbm_db();

        $this->addError('Softaculous ไม่รองรับ command Suspend Account');

        return false;
    }

    public function Unsuspend ()
    {
        $db             = hbm_db();

        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }

        return true;
    }

    public function Terminate ()
    {
        require_once(APPDIR . 'class.general.custom.php');

        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();
        $aAdmin['username'] = (empty($aAdmin['username'])) ? 0 : $aAdmin['username'];

        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $status         = $aDetail['status'];

        $ip             = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }

        $result     = $this->noc->virt_licenses('', $ip);

        if (! isset($result['licenses']) || ! count($result['licenses'])) {
            $this->addError('Connection error please try again.');
            return false;
        }

        $aKey       = array_keys($result['licenses']);
        $licenseId  = isset($aKey[0]) ? $aKey[0] : 0;
        $licenseKey = $result['licenses'][$licenseId]['license'];

//         $result         = $this->noc->virt_remove($licenseId);
        $result		= $this->noc->virt_refund_and_cancel($licenseKey, $ip);

        $aLog       = array('serialized' => '1', 'data' => array(
            '0'     => array('name' => 'status', 'from' => $status, 'to' => 'Terminated')
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action,
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, 'virtualizorlicensehandle', '0', 'Terminated Account',
                :logs, '1', :result, 'TerminatedAccount'
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog),
                ':result'           => serialize($result)
            ));

        return true;
    }

    public function testConnection ()
    {
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
