<?php
#@LICENSE@#

class rvsitebuilder_developer_license extends HostingModule
{
    protected $description = 'rvsitebuilder_developer_license';

    protected $options = [];

    /**
     * You can choose which fields to display in Settings->Apps section
     * by defining this variable
     * @var array
     */
    protected $serverFields = array( //
        'hostname'         => false,
        'ip'             => false,
        'maxaccounts'     => false,
        'status_url'     => false,
        'field1'         => false,
        'field2'         => false,
        'username'         => false,
        'password'         => false,
        'hash'             => false,
        'ssl'             => false,
        'nameservers'     => false,
    );

    protected $serverFieldsDescription = array(
        'ip'         => 'Database IP',
        'hostname'     => 'Database Name',
        'username'     => 'Database Username',
        'password'     => 'Database Password'
    );

    /**
     * HostBill will replace default labels for server fields
     * with this variable configured
     * @var array
     */
    protected $details = [];

    private $aProduct   = array(
        'trial'     => array('id' => 170,),
        'starter'   => array('id' => 162,),
        'pro'       => array('id' => 161,),
    );

    private static $instance;

    public static function singleton()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }

        return self::$instance;
    }

    public function verifyLicense($ip, $pb_ip)
    {
        return true;
    }

    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect)
    {
        return true;
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
    public function testConnection()
    {
        return true;
    }


    /**
     * This method is invoked automatically when creating an account.
     * @return boolean true if creation succeeds
     */
    public function Create()
    {
        $db = hbm_db();
        $accDetail = $this->account_details;
        $productDetail = $this->product_details;

        $hb_acc = $accDetail['id'];
        $client_id  = $accDetail['client_id'];
        $expire = $accDetail['expiry_date'];
        $product_id = $accDetail['product_id'];
        $product_name = $accDetail['product_name'];
        //$status = $accDetail['status'];
        $status = 'Active';
        $clientDetail = $this->_getClient($client_id);
        $clientEmail = $clientDetail['email'];
        $accountId      = $accDetail['id'];
        $dateCreated    = $accDetail['date_created'];

        // trial expire
        if ($product_id == $this->aProduct['trial']['id']) {
            $expire = date('Y-m-d', strtotime('+30 days', strtotime($dateCreated)));
        }
        // starter,pro expire
        else {
            $expire = date('Y-m-d', strtotime('+1 year', strtotime($dateCreated)));
            // if update from trial -> starter,pro to terminate trial
            $this->terminateTrialLicense($client_id);
        }

        $db->query("
            UPDATE hb_accounts 
            SET expiry_date = :expiry_date,
                billingcycle = 'Annually'
            WHERE id = :id
            ", array(
            ':expiry_date'  => $expire,
            ':id'   => $accountId,
        ));

        $result = $db->query("
            SELECT
                *
            FROM
                rvsitebuilder_developer_license
            WHERE
                rvsitebuilder_developer_license.client_id = :clientId
            ", array(
            ':clientId'     => $client_id
        ))->fetch();

        //insert
        if (!isset($result['id'])) {
            $query = $db->query("
            INSERT INTO	
                rvsitebuilder_developer_license
                (product_id,  product_name ,client_id, hb_acc,  expire, active, status , dev_tokenkey,dev_email)
            VALUES
                (:product_id, :product_name, :client_id,:hb_acc, :expire,:active, :status , :dev_tokenkey,:dev_email)
            ", array(
                ':product_id'    => $product_id,
                ':product_name' => $product_name,
                ':client_id'    => $client_id,
                ':hb_acc'        => $hb_acc,
                ':expire'        => $expire,
                ':active'        => 1,
                ':status'       => $status,
                ':dev_tokenkey'    =>  $this->autoGenTokenKey(),
                ':dev_email'    => $clientEmail,
            ));
            if ($query) {
                return true;
            } else {
                $this->addError('cannot insert dev data to rvsitebuilder_developer_license');
                return false;
            }
        }
        //update
        else {
            $query = $db->query("
                UPDATE
                    rvsitebuilder_developer_license
                SET
                    product_id = :product_id,
                    product_name = :product_name,
                    hb_acc = :hb_acc,
                    expire = :expire,
                    active = 1,
                    status = :status,
                    dev_email = :dev_email
                WHERE
                    client_id = :client_id
                ", array(
                ':product_id'   => $product_id,
                ':product_name' => $product_name,
                ':hb_acc'        => $hb_acc,
                ':expire'        => $expire,
                ':status'       => $status,
                ':dev_email'    => $clientEmail,
                ':client_id'    => $client_id,
            ));
        }

        return true;
    }

    private function terminateTrialLicense($client_id)
    {
        $hbapi = new ApiWrapper();
        $hbaccounts = $hbapi->getClientAccounts(['id' => $client_id]);
        if (isset($hbaccounts['accounts'])) {
            foreach ($hbaccounts['accounts'] as $account) {
                if ($account['product_id'] == $this->aProduct['trial']['id']) {
                    $terminated = $hbapi->editAccountDetails([
                        'id' => $account['id'],
                        'status' => 'Terminated',
                    ]);
                    // if ($terminated['success'] == true)
                }
            }
        }

        return true;
    }

    private function _getClient($id)
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

    private function autoGenTokenKey($length = 64)
    {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }



    /**
     * This method is invoked automatically when suspending an account.
     * @return boolean true if suspend succeeds
     */
    public function Suspend()
    {
        $db     = hbm_db();
        $accDetail = $this->account_details;
        $hb_acc = $accDetail['id'];
        $client_id  = $accDetail['client_id'];
        $status = 'Suspended';

        $query = $db->query("
        UPDATE
            rvsitebuilder_developer_license
        SET
            active = 0,
            status = :status
        WHERE
            hb_acc = :hb_acc
        ", array(
            ':hb_acc'    => $hb_acc,
            ':status'    => $status,
        ));

        $query = $db->query("
        UPDATE
            rvsitebuilder_developer_sites
        SET
            active = 0
        WHERE
            hb_client_id = :hb_client_id
        ", array(
            ':hb_client_id'    => $client_id,
        ));

        return true;
    }

    public function Unsuspend()
    {
        $db     = hbm_db();
        $accDetail = $this->account_details;
        $hb_acc = $accDetail['id'];
        $client_id  = $accDetail['client_id'];
        $expire = $accDetail['expiry_date'];
        $status = 'Active';

        $query = $db->query("
        UPDATE
            rvsitebuilder_developer_license
        SET
            active = 1,
            expire = :expire,
            status = :status
        WHERE
            hb_acc = :hb_acc
        ", array(
            ':hb_acc'    => $hb_acc,
            ':expire' => $expire,
            ':status' => $status
        ));

        $query = $db->query("
        UPDATE
            rvsitebuilder_developer_sites
        SET
            active = 1
        WHERE
            hb_client_id = :hb_client_id
        ", array(
            ':hb_client_id'    => $client_id,
        ));

        return true;
    }


    /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate()
    {
        $db     = hbm_db();
        $accDetail = $this->account_details;
        $hb_acc = $accDetail['id'];
        $client_id  = $accDetail['client_id'];
        $status = 'Terminated';

        $query = $db->query("
        UPDATE
            rvsitebuilder_developer_license
        SET
            active = 0,
            status = :status
        WHERE
            hb_acc = :hb_acc
        ", array(
            ':hb_acc'    => $hb_acc,
            ':status'    => $status,
        ));

        $query = $db->query("
        UPDATE
            rvsitebuilder_developer_sites
        SET
            active = 0
        WHERE
            hb_client_id = :hb_client_id
        ", array(
            ':hb_client_id'    => $client_id,
        ));

        return true;
    }

    public function Renewal()
    {
        $db     = hbm_db();
        $accDetail = $this->account_details;
        $hb_acc = $accDetail['id'];
        $expire = $accDetail['expiry_date'];
        $status = 'Active';

        $accountId  = $accDetail['id'];

        $result     = $db->query("
            SELECT i.id, i.duedate
            FROM hb_invoice_items ii,
                hb_invoices i
            WHERE ii.type = 'Hosting'
                AND ii.item_id = '{$accountId}'
                AND ii.invoice_id = i.id
                AND i.status = 'Paid'
            ORDER BY i.duedate DESC
            LIMIT 1
            ")->fetch();

        if (isset($result['id'])) {
            $expire     = date('Y-m-d', strtotime('+1 year', strtotime($result['duedate'])));
        }

        $db->query("
            UPDATE hb_accounts 
            SET expiry_date = :expiry_date
            WHERE id = :id
            ", array(
            ':expiry_date'  => $expire,
            ':id'   => $accountId,
        ));

        $query = $db->query("
            UPDATE
                rvsitebuilder_developer_license
            SET
                active = 1,
                expire = :expire,
                status = :status
            WHERE
                hb_acc = :hb_acc
            ", array(
            ':hb_acc' => $hb_acc,
            ':expire' => $expire,
            ':status' => $status
        ));

        return true;
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
        $db     = hbm_db();
        $accDetail = $this->account_details;
        $productDetail = $this->product_details;
        $client_id  = $accDetail['client_id'];

        // update rvsb developer license table
        $hb_acc = $accDetail['id'];
        $expire = $accDetail['expiry_date'];
        //$status = $accDetail['status'];
        $status = 'Active';
        $product_id = $productDetail['id'];
        $product_name = $productDetail['name'];
        $query = $db->query("
                UPDATE
                    rvsitebuilder_developer_license
                SET
                    product_id = :product_id,
                    product_name = :product_name,
                    expire = :expire,
                    active = 1,
                    status = :status
                WHERE (
                    hb_acc = :hb_acc
                AND
                    client_id = :client_id
                    )
                ", array(
            ':product_id'   => $product_id,
            ':product_name' => $product_name,
            ':hb_acc'        => $hb_acc,
            ':expire'        => $expire,
            ':status'       => $status,
            ':client_id'    => $client_id,
        ));


        // send email
        $clientDetail = $this->_getClient($client_id);
        $result = $db->query(
            "
             SELECT
                 *
             FROM
                 hb_email_templates
             WHERE
                 hb_email_templates.id = :id
             ",
            array(
                ':id'     => 216
            )
        )->fetch();
        $result['message'] = str_replace('{$client.firstname}', $accDetail['firstname'], $result['message']);
        $result['message'] = str_replace('{$client.lastname}', $accDetail['lastname'], $result['message']);
        $hbapi = new ApiWrapper();
        $sendmessage = $hbapi->sendMessage(
            [
                'subject' => $result['subject'],
                'body' => $result['message'],
                'to' => $clientDetail['email'],
                'html' => 1,
            ]
        );


        return true;
    }


    /**
     * Auxilary method that HostBill will load to get plans from server:
     * @see $options variable above
     * @return array - list of plans to display in product configuration
     */
    public function getPlans()
    {
        $return = array();
        return $return;
    }
}
