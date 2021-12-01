<?php

class cpanellicensehandle extends HostingModule
{
    protected $description  = 'ส่วนจัดการ provisioning cPanel license';

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

    public $aCpanelAccount = array(
        'username'      => 'Rv97Pj3W',
        'password'      => 'Z6)Hnb)/S48F'
    );

    protected $options      = array();

    protected $details      = array();

    public function verifyLicense ($ip)
    {
        $oResult    = new stdClass;
        $oResult->available     = false;

        require_once(APPDIR .'libs/cpanel/cpl-3.6/php/cpl.inc.php');

        /*
        $cpl        = new cPanelLicensing($this->aCpanelAccount['username'], $this->aCpanelAccount['password']);
        $cpl->set_format('JSON');
        $args       = array('ip' => $ip);
        $oLicense   = $cpl->fetchLicenseRaw($args);
        print_r($oLicense);exit;
        */

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

        // [TODO] ยังไม่มี license
        if (preg_match('/<b>Not\slicensed<\/b>/', $result)) {
            $oResult->available     = 'Register';
            $oResult->type          = 'VPS';
            return $oResult;
        }

        // [TODO] license active
        if (preg_match('/<b>active<\/b>/', $result, $matches, PREG_OFFSET_CAPTURE)) {
            $pos            = isset($matches[0][1]) ? $matches[0][1] : 0;
            $distributor    = substr($result, 0, $pos);

            if (preg_match('/RV\sGlobal\sSoft/', $distributor)) {
                $oResult->available     = false;
                return $oResult;
            }

            $oResult->available     = 'Transfer';

            if (preg_match('/\-VPS/', $distributor)) {
                $oResult->type      = 'VPS';
            } else {
                $oResult->type      = 'Dedicated';
            }

            return $oResult;
        }


        // [TODO] license หมดอายุ
        $oResult->available     = 'Register';
        $oResult->type          = 'VPS';
        return $oResult;
    }

    public function connect ($detail)
    {
        $this->connection['username']   = $detail['username'];
        $this->connection['password']   = $detail['password'];
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
