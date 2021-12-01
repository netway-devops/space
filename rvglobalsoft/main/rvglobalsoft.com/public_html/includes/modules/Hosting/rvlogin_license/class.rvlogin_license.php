<?php
#@LICENSE@#

class rvlogin_license extends HostingModule
{
    protected $description = 'rvlogin_license';

    protected $options = array();

    /**
     * You can choose which fields to display in Settings->Apps section
     * by defining this variable
     * @var array
     */
    protected $serverFields = array( //
            'hostname' => false,
            'ip' => false,
            'maxaccounts' => false,
            'status_url' => false,
            'field1' => false,
            'field2' => false,
            'username' => false,
            'password' => false,
            'hash' => false,
            'ssl' => false,
            'nameservers' => false,
    );

    protected $serverFieldsDescription = array();

    /**
     * HostBill will replace default labels for server fields
     * with this variable configured
     * @var array
     */
    protected $details = array();
    public $aCpanel = array(
        'user' => 'Rv97Pj3W',
        'pwd' => 'Z6)Hnb)/S48F'
    );


    public $aPackage        = array(
        '108'           => array('name' => 'RVLogin'),
        );

    public $demo            = true;

    public function verifyLicense ($ip , $pb_ip)
    {
        $db             = hbm_db();

        $oResult        = new stdClass;
        $oResult->available     = false;

		if($pb_ip == '-'){
			$pb_ip = $ip;
		}

        $oResult->type          = '';

        $result         = $db->query("
                SELECT
                    rl.license_id
                FROM
                     rvlogin_license rl
                WHERE
                    rl.primary_ip = :ip
                    AND rl.secondary_ip = :pb_ip
                ", array(
                    ':ip'       => $ip,
                    ':pb_ip'	=> $pb_ip
                ))->fetch();

        if (isset($result['license_id']) && $result['license_id']) {
            return $oResult;
        }

        $oResult->available     = 'Register';
        $oResult->type          = 'VPS';
        return $oResult;
    }

    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect) {
    }




    /**
     * HostBill will call this method when admin clicks on "test Connection" in settings->apps
     * It should test connection to remote app using details provided in connect method
     *
     * Use $this->addError('message'); to provide errors details (if any)
     *
     * @see connect
     * @return boolean true if connection suceeds
     */
    public function testConnection() {
        return true;
    }


    /**
     * This method is invoked automatically when creating an account.
     * @return boolean true if creation succeeds
     */
    public function Create() {
        $db         = hbm_db();
        $ip             = (isset($_POST['ip']) && $_POST['ip'] != '') ? $_POST['ip'] : $this->account_config['ip']['value'];
		$public_ip      = (isset($_POST['public_ip']) && $_POST['public_ip'] != '') ? $_POST['public_ip'] : $this->account_config['public_ip']['value'];
        $accid          = $this->account_details['id'];

        try{
            $query = $db->query("
                INSERT INTO
                    rvlogin_license
                    (primary_ip, secondary_ip,active,hb_acc)
                VALUES
                    ( :primary_ip,:secondara_ip,:active,:hb_acc)
            ",array(
                ':primary_ip'       => $ip,
                ':secondara_ip'     => $public_ip,
                ':active'           => 1,
                ':hb_acc'           => $accid
            ));

        }catch(exception $e){

             $this->addError('Error  rvlogin_license sql');
            return false;
        }

       return true;


    }

    /**
     * This method is invoked automatically when suspending an account.
     * @return boolean true if suspend succeeds
     */
    public function Suspend()
    {
        $db     = hbm_db();
        $accid  = $this->account_details['id'];
        $res    = $db->query("
            UPDATE
                rvlogin_license
            SET
                active = 0
            WHERE
                hb_acc = :accid
            ",array(':accid'=>$accid));
        if ($res) {
            return true;
        } else {
            $this->addError('Error delete rvlogin_license sql = ' . $sql);
            return false;
        }
    }

    public function Unsuspend()
    {
        $db     = hbm_db();
        $accid  = $this->account_details['id'];
        $res    = $db->query("
            UPDATE
                rvlogin_license
            SET
                active = 1
            WHERE
                hb_acc = :accid
            ",array(':accid'=>$accid));
        if ($res) {
            return true;
        } else {
            $this->addError('Error delete rvlogin_license sql = ' . $sql);
            return false;
        }
    }


    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate()
    {
        $db     = hbm_db();
        $accid  = $this->account_details['id'];
        $res    = $db->query("
                            DELETE FROM `rvlogin_license`
                            WHERE   hb_acc = :accid
                            ",array(':accid'=>$accid));
        if ($res) {
            return true;
        } else {
            $this->addError('Error delete rvlogin_license sql = ' . $sql);
            return false;
        }

    }

    /**
     * This method is invoked when account should have password changed
     * @param string $newpassword New password to set account with
     * @return boolean true if action succeeded
     */
    public function ChangePassword($newpassword)
    {
        return true;
    }

    /**
     * This method is invoked when account should be upgraded/downgraded
     * $options variable is loaded with new package configuration
     * @return boolean true if action succeeded
     */
    public function ChangePackage()
    {
        return true;
    }


    /**
     * Auxilary method that HostBill will load to get plans from server:
     * @see $options variable above
     * @return array - list of plans to display in product configuration
     */
    public function getPlans()
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
