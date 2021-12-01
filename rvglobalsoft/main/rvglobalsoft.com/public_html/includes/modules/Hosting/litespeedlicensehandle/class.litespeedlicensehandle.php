<?php

class litespeedlicensehandle extends HostingModule
{
    protected $description  = 'ส่วนจัดการ provisioning LiteSpeed license';

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

    public $aPackage        = array(
        '138'           => array('name' => 'LiteSpeed for VPS Lease', 'cpu' => 'V'),
        '139'           => array('name' => 'LiteSpeed for Ultra VPS Lease', 'cpu' => 'U'),
        '140'           => array('name' => 'LiteSpeed for 1-CPU Lease', 'cpu' => '1'),
        '141'           => array('name' => 'LiteSpeed for 2-CPU Lease', 'cpu' => '2'),
        '142'           => array('name' => 'LiteSpeed for 4-CPU Lease', 'cpu' => '4'),
        '143'           => array('name' => 'LiteSpeed for 8-CPU Lease', 'cpu' => '8'),
        );

    public $aCycle          = array(
        'Monthly'       => 'monthly',
        'Quarterly'     => 'monthly',
        'Semi-Annually' => 'monthly',
        'Annually'      => 'yearly'
        );

    public $aConfig         = array(
        'url'           => 'https://store.litespeedtech.com/reseller/LiteSpeed_eService.php?eService_version=1.1',
        'username'      => 'paisarn@rvglobalsoft.com',
        'password'      => ',o^db0wl;'
    );

    public $demo        = true;

    public function verifyLicense ($ip)
    {
        $oResult    = new stdClass;
        $oResult->available     = false;

        $urlRequest = $this->aConfig['url'];
        $urlRequest .= '&litespeed_store_login='. $this->aConfig['username'];
        $urlRequest .= '&litespeed_store_pass='. $this->aConfig['password'];
        $urlRequest .= '&eService_action=Query';
        $urlRequest .= '&query_field=LicenseDetail_IP:'. $ip;

        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $obj        = (object) json_decode($json, TRUE);

        // [TODO] license active

        if (isset($obj->message) && preg_match('/Cannot\sfind\san\sactive\slicense/i', $obj->message)) {
            if (self::_isClientLicense($ip)) {
                $oResult->available     = false;
                return $oResult;
            }

            $oResult->available     = 'Register';
            $oResult->type          = 'VPS';
            return $oResult;
        }

        $oResult->available     = 'Transfer';
        $oResult->type          = 'VPS';
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

    public function Create ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

        $aDetail        = $this->account_details;
        $accountId      = $aDetail['id'];
        $productId      = $aDetail['product_id'];
        $billingCycle   = $aDetail['billingcycle'];
        $clientId       = $aDetail['client_id'];

        if (preg_match('/transfer/i', $aDetail['status'])) {
            return $this->_transfer();
        }

        $ip             = $this->_findIPAddress();

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }

        $period         = $this->aCycle[$billingCycle];
        $cpu            = $this->aPackage[$productId]['cpu'];

        $urlRequest = $this->aConfig['url'];
        $urlRequest .= '&litespeed_store_login='. $this->aConfig['username'];
        $urlRequest .= '&litespeed_store_pass='. $this->aConfig['password'];
        $urlRequest .= '&eService_action=Order';
        $urlRequest .= '&order_product=LSWS';
        $urlRequest .= '&order_cpu='. $cpu;
        $urlRequest .= '&order_period='. $period;
        $urlRequest .= '&order_payment=credit';

        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        self::_addNote ($accountId, $result);

        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $obj        = (object) json_decode($json, TRUE);

        if ($obj->result == 'error') {
            $this->addError('Error:'. $obj->message);
            return false;
        }

        require_once(APPDIR . 'class.general.custom.php');
        GeneralCustom::singleton()->updateCustomfieldData($accountId, 'Hosting', 'serial_number', $obj->serial);

        $this->addInfo('Info:'. $obj->message);

        if ($obj->result == 'success') {
            return true;
        } else {
            return false;
        }
    }

    public function Renewal ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

        return true;
    }

    public function Suspend ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }

        $ip             = $this->_findIPAddress();

        $urlRequest = $this->aConfig['url'];
        $urlRequest .= '&litespeed_store_login='. $this->aConfig['username'];
        $urlRequest .= '&litespeed_store_pass='. $this->aConfig['password'];
        $urlRequest .= '&eService_action=Suspend';
        $urlRequest .= '&server_ip='. $ip;

        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $obj        = (object) json_decode($json, TRUE);

        if ($obj->result != 'success') {
            $this->addError('Error:'. $obj->message);
            return false;
        }

        $this->addInfo('Info:'. $obj->message);

        return true;
    }

    public function Unsuspend ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }

        $ip             = $this->_findIPAddress();

        $urlRequest = $this->aConfig['url'];
        $urlRequest .= '&litespeed_store_login='. $this->aConfig['username'];
        $urlRequest .= '&litespeed_store_pass='. $this->aConfig['password'];
        $urlRequest .= '&eService_action=Unsuspend';
        $urlRequest .= '&server_ip='. $ip;

        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $obj        = (object) json_decode($json, TRUE);

        if ($obj->result != 'success') {
            $this->addError('Error:'. $obj->message);
            return false;
        }

        $this->addInfo('Info:'. $obj->message);

        return true;
    }

    public function Terminate ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

        if ($this->demo) {
            $this->addInfo('Test mode');
            return false;
        }

        $ip             = $this->_findIPAddress();

        $urlRequest = $this->aConfig['url'];
        $urlRequest .= '&litespeed_store_login='. $this->aConfig['username'];
        $urlRequest .= '&litespeed_store_pass='. $this->aConfig['password'];
        $urlRequest .= '&eService_action=Cancel';
        $urlRequest .= '&server_ip='. $ip;
        $urlRequest .= '&cancel_now=Y';

        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $obj        = (object) json_decode($json, TRUE);

        if ($obj->result == 'error') {
            $this->addError('Error:'. $obj->message);
            return false;
        }

        $this->addInfo('Info:'. $obj->message);

        return true;
    }

    private function _transfer ()
    {
        $db             = hbm_db();
        $aAdmin         = hbm_logged_admin();

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
                    '', NOW(), :accountId, :admin, 'litespeedlicensehandle', '0', 'Transfer Account',
                    :logs, '1', '', 'TransferAccount'
                )
                ", array(
                    ':accountId'        => $accountId,
                    ':admin'            => $aAdmin['username'],
                    ':logs'             => serialize($aLog)
                ));
        }

        $ip             = $this->_findIPAddress();

        if (filter_var($ip, FILTER_VALIDATE_IP) === false) {
            $this->addError('Invalid IP Address format.');
            return false;
        }

        $period         = $this->aCycle[$billingCycle];
        $cpu            = $this->aPackage[$productId]['cpu'];

        $urlRequest = $this->aConfig['url'];
        $urlRequest .= '&litespeed_store_login='. $this->aConfig['username'];
        $urlRequest .= '&litespeed_store_pass='. $this->aConfig['password'];
        $urlRequest .= '&eService_action=Order';
        $urlRequest .= '&order_product=LSWS';
        $urlRequest .= '&order_cpu='. $cpu;
        $urlRequest .= '&order_period='. $period;
        $urlRequest .= '&order_payment=credit';

        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        self::_addNote ($accountId, $result);

        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $obj        = (object) json_decode($json, TRUE);

        if ($obj->result == 'error') {
            $this->addError('Error:'. $obj->message);
            return false;
        }

        require_once(APPDIR . 'class.general.custom.php');
        GeneralCustom::singleton()->updateCustomfieldData($accountId, 'Hosting', 'serial_number', $obj->serial);

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
            '0'     => array('name' => 'status', 'from' => 'Pending Transfer', 'to' => 'Active')
            ));
        $db->query("
            INSERT INTO hb_account_logs (
                id, date, account_id, admin_login, module, manual, action,
                `change`, result, error, event
            ) VALUES (
                '', NOW(), :accountId, :admin, 'litespeedlicensehandle', '0', 'Transfer Account',
                :logs, '1', '', 'TransferAccount'
            )
            ", array(
                ':accountId'        => $accountId,
                ':admin'            => $aAdmin['username'],
                ':logs'             => serialize($aLog)
            ));

        $this->addInfo('Transfer account:'. $accountId .' succcess.');

        return true;
    }

    private function _findIPAddress ()
    {
        $aDetail        = $this->account_details;
        $ip             = '';

        if (! isset($aDetail['customforms'])) {
            return $ip;
        }

        foreach ($aDetail['customforms'] as $arr) {
            if ($arr['name'] == 'Server IP Address') {
                foreach ($arr['data'] as $v) {
                    return $v;
                }
            }
        }

        return $ip;
    }

    private function _addNote ($accountId, $result)
    {
        $db             = hbm_db();

        $db->query("
            INSERT INTO hb_notes (
                id, type, rel_id, admin_id, date, note
            ) VALUES (
                '', 'account', :accountId, :adminId, NOW(), :note
            )
            ", array(
                ':accountId'        => $accountId,
                ':adminId'          => 31, // staffprasit
                ':note'             => $result,
            ));
    }

    public function connect ($detail)
    {
        $this->connection['username']   = $detail['username'];
        $this->connection['password']   = $detail['password'];
    }

    public function testConnection ()
    {
        $urlRequest = $this->aConfig['url'];
        $urlRequest .= '&litespeed_store_login='. $this->aConfig['username'];
        $urlRequest .= '&litespeed_store_pass='. $this->aConfig['password'];
        $urlRequest .= '&eService_action=Ping';

        $ch         = curl_init();
        curl_setopt($ch, CURLOPT_URL, $urlRequest);
        curl_setopt($ch, CURLOPT_FAILONERROR, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_REFERER, 'https://rvglobalsoft.com/');
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110303 Firefox/3.6.15');
        $result     = curl_exec($ch);
        curl_close($ch);

        $xml        = simplexml_load_string($result);
        $json       = json_encode($xml);
        $obj        = (object) json_decode($json, TRUE);

        return $obj->result == 'success' ? true : false ;
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
