<?php
#@LICENSE@#
require_once APPDIR_MODULES . "Hosting/rvproduct_license/include/common/RVProductLicenseDao.php";
class rvsitebuilder_license_trial extends HostingModule 
{
    protected $moduleName = 'rvsitebuilder_license_trial';
    
    protected $options = array(
    'Server Type' =>array (
                    'name'=> 'server_type',
                    'type'=> 'select',
                    'default'=>array('Dedicated','VPS')
            )
            
    );
    
    /**
     * You can choose which fields to display in Settings->Apps section
     * by defining this variable
     * @var array
     */
    protected $serverFields = array( //
            'hostname'      => false,
            'ip'            => false,
            'maxaccounts'   => false,
            'status_url'    => false,
            'field1'        => false,
            'field2'        => false,
            'username'      => false,
            'password'      => false,
            'hash'          => false,
            'ssl'           => false,
            'nameservers'   => false,
    );
    
    protected $serverFieldsDescription = array(
            'ip'        => 'Database IP',
            'hostname'  => 'Database Name',
            'username'  => 'Database Username',
            'password'  => 'Database Password'
    );
    
    /**
     * HostBill will replace default labels for server fields
     * with this variable configured
     * @var array
     */
    protected $details = array();
  
    /**
     * HostBill will call this method before calling any other function from your module
     * It will pass remote  app details that module should connect with
     *
     * @param array $connect Server details configured in Settings->Apps
     */
    public function connect($connect) {
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
    public function testConnection() {
        return true;
    }
    
    
    private function calExpireDate($next_due_date = '') {
        date_default_timezone_set('UTC');
        if ($next_due_date == '0000-00-00')  $next_due_date = '2030-01-07';
        $aDate['exp'] = strtotime($next_due_date."+30 day");
        $aDate['eff'] = mktime(
                                date('H', $aDate['exp'])+23,
                                date('i', $aDate['exp']),
                                date('s', $aDate['exp']),
                                date('n', $aDate['exp']),
                                date('j', $aDate['exp'])+3,
                                date('Y', $aDate['exp'])
                            );
        return $aDate;
    }
    
    public function Create() {
        $db = hbm_db();


        if(isset($_POST['ip']) && $_POST['ip'] != '') {
            $sqlUpdateAcc = RVProductLicenseDao::singleton()->updateAccountByAccid($this->account_details['id'],$_POST['ip']);
            $this->account_config['ip']['value'] = $_POST['ip'];
        }
        $db_ip      = $this->account_config['ip']['value'];
        $aProduct   = $this->product_details['options'];
        
        if (isset($db_ip) && $db_ip != '') {
            if (isset($aProduct['Server Type']) && $aProduct['Server Type'] != '') {
                $db_license_type = ($aProduct['Server Type'] == 'VPS' ) ? 11 : 9;
                $accid = $this->account_details['id'];
                RVProductLicenseDao::singleton()->updateExpireDateByAccid($this->account_details['id'],date('Y-m-d',$aDate['exp']));
                
                try{
                $query = $db->query("
                    INSERT INTO 
                        rvsitebuilder_license_trial
                        (crient_id,license_type, main_ip, second_ip,exprie,effective_expiry,hb_acc_id)
                    VALUES
                        (:crient_id, :license_type,:main_ip,:second_ip,:exprie,:effective_expiry,:accid)
                ",array(
                    ':crient_id'        => 1,
                    ':license_type'       => $db_license_type,
                    ':main_ip'     => $db_ip,
                    ':second_ip'              => $db_ip,
                    ':exprie'           => $aDate['exp'],
                    ':effective_expiry'    => $aDate['eff'],
                    ':accid'            => $accid
                ));
                }catch(exception $e){
                   $this->addError("ip is unavailable");
                    return false;
                }
                if ($query) {
                       return true;
                }
            } else {
                $this->addError('หาค่า Server Type ไม่เจอ (Dedicate/Vps)');
                return false;
            }
        } else {
            $this->addError('หาค่า IP ไม่เจอ');
            return false;
        }
       
    }
    
    /**
     * This method is invoked automatically when suspending an account.
     * @return boolean true if suspend succeeds
     */
    public function Suspend()
    {
        $db = hbm_db();
        if (!isset($this->account_details['id']) || $this->account_details['id'] == '' || $this->account_details['id'] == 0) {
            $this->addError('ไม่มีค่า account id');
            return false;
        }
             
        $accid =  $this->account_details['id'];
        
        $sql = "DELETE FROM rvsitebuilder_license_trial WHERE hb_acc_id=:accid";
        $res = $db->query($sql, array(':accid' => $accid));
        if ($res) {
            return true;
        } else {
            $this->addError('Error delete rvkin sql = ' . $sql);
            return false;
        }
    }
    
     /**
     * This method is invoked automatically when terminating an account.
     * @return boolean true if termination succeeds
     */
    public function Terminate() 
    {
        $db = hbm_db();
        if (!isset($this->account_details['id']) || $this->account_details['id'] == '' || $this->account_details['id'] == 0) {
            $this->addError('ไม่มีค่า account id');
            return false;
        }
        $accid =  $this->account_details['id'];
        
        $sql = "DELETE FROM rvsitebuilder_license_trial WHERE hb_acc_id=:accid";
        $res = $db->query($sql, array(':accid' => $accid));
        if ($res) {
            return true;
        } else {
            $this->addError('Error delete rvkin sql = ' . $sql);
            return false;
        }
    }

}
?>