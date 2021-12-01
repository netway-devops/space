<?php

/*
  General, onapp reseller module.
  This is only base class, other classes will extend it?
 */

require_once MAINDIR . 'includes' . DS . 'types' . DS . 'class.dedicated.php';

class Vmware5Type extends Dedicated {

    protected $featured_modules = array('class.vmware5.php');
    protected $related_modules = array('class.vmware5.php');

	private $setvm_aid = 0;
	private $vmmodule;


    public function install() {
        $this->db->exec("
        REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
        SELECT id, 'global', '".strtolower(get_class($this).'_hosting')."','Vmware5' FROM hb_language WHERE target='admin';
        ");
    }

    public function getProductEmails() {
        return array(
            'ProductAccountCreated' => array(),
            'SuspendAccount' => array(),
            'UnsuspendAccount' => array(),
            'AfterModuleTerminate' => array()
        );
    }

    public function getSampleData() {
        $this->sample_data = array(
            'paytype' => 'Regular'
        );
        $this->sample_data['emails'] = array(
            'ProductAccountCreated' => '0'
        );

        $this->sample_data['autosetup'] = 2;
        return $this->sample_data;
    }

     public function controller($params, &$smarty, $extra=array()) {
        $customfile = MAINDIR . 'includes' . DS . 'types' . DS . 'vmware5type' . DS;

        if ($this->section == 'clientaccount') {
            include $customfile . 'controllers' . DS . 'clientaccount.php';
        } elseif ($this->section == 'adminproduct') {
            include $customfile . 'controllers' . DS . 'adminproduct.php';
        } elseif ($this->section == 'clientaccountslist') {
            include $customfile . 'controllers' . DS . 'clientaccountslist.php';
        }
    }

    protected function _setVM($account_id){
		
		if($this->setvm_aid == $account_id)
			return $this->vmmodule;
		
		$a = HBLoader::LoadModel('Accounts');
        $d = $a->getAccount($account_id);
        if(!$d)
            return 'off';
        
        $s= HBLoader::LoadModel('Servers');
        $sid = $s->getServerDetails($d['server_id']);
        if(!$sid)
            return 'off';

        $module = ModuleFactory::singleton()->getModule('Hosting', 'class.vmware5.php');
        $module->connect($sid);
        $module->setAccount($d);
		$this->vmmodule = $module;
		return $module;
	}
	
	protected function _setVMStatus($account_id, $do) {
		$module = $this->_setVM($account_id);
		if($do=='poweron' && $module->Start()){
			return 'on';
		}elseif($do=='poweroff' && $module->Stop()){
			return 'off';
		}
		return $this->_getVMStatus($account_id);
	}
	
	protected function _getVMStatus($account_id) {
        $module = $this->_setVM($account_id);
        if(is_string($module))
            return $module;
        $vms = $module->getVMDetails();
		$this->updateVMDetails($account_id, $vms);
        if(!$vms)
            return 'off';
        return $vms['powerState'] == 'poweredOn' ? 'on':'off';
    }
	
	private function updateVMDetails($id, $vm){
		$fields = array();
		
		if(!empty($vm['guest']['networks']))
			$fields['ip'] = array_pop($vm['guest']['networks']);
		
		while(!empty($vm['guest']['networks'])){
			$fields['additional_ip'] .= array_pop($vm['guest']['networks']).',';
		}
		$executeArray = $upf = array();
		foreach($fields as $name => $value){
			$executeArray[':'.$name] = $value;
			$upf[] = '`'.$name.'` = :'.$name;
		}
		$upfx = implode(', ', $upf);
		
		if(empty($executeArray))
			return true;
                $executeArray[':account_id'] = $id;

		
		$q = $this->db->prepare('UPDATE hb_vps_details SET '.$upfx.' WHERE account_id = :account_id');
		$status = $q->execute($executeArray);
		
		return $status;
	}
	
	public function listClientAccounts($client_id=false, $category_id=false) {
        $acstat='';
        if(!$client_id) {
             $sorter = new Sorter('accounts',
                array('acc.id', 'acc.client_id', 'acc.domain',
                    'acc.billingcycle', 'acc.status', 'acc.total',
                    'acc.next_due', 'acc.username', 'vps.disk_usage',
                    'vps.disk_limit', 'vps.bw_usage', 'vps.bw_limit',
                    'acc.server_id', 'prod.name', 'cd.lastname',
                    'cd.firstname'), $_REQUEST);
          if ($status)
            $acstat = ' AND acc.status=? ';
            $status = array($status);
          $acstat.=$sorter->sort('AND');
        }
        elseif($client_id) {
           $acstat=' AND acc.client_id=? AND prod.category_id=? ';
           $status=array($client_id,$category_id);
        }
        $type=strtolower(get_class($this));


        $q = $this->db->prepare('SELECT acc.id, acc.client_id, acc.domain, acc.manual, acc.billingcycle, acc.status, acc.total, acc.next_due, acc.username,
 vps.disk_usage, acc.server_id, vps.disk_limit, vps.guaranteed_ram as mem_limit,
  pm.options, vps.ip as vpsip, prod.name, cb.currency_id, cd.lastname, cd.firstname
FROM hb_accounts acc
JOIN hb_products prod ON (prod.id=acc.product_id)
JOIN hb_product_types pt ON (pt.id=prod.type)
JOIN hb_client_details cd ON (cd.id=acc.client_id)
JOIN hb_client_billing cb ON (cb.client_id=acc.client_id)
LEFT JOIN hb_vps_details vps ON (vps.account_id=acc.id)
LEFT JOIN hb_products_modules pm ON (pm.product_id=prod.id AND pm.server=acc.server_id)
 WHERE pt.type= \''.$type.'\' ' . $acstat  );
        if (empty($acstat)) {
            $q->execute();
        }else
            $q->execute($status);
        $accounts = $q->fetchAll(PDO::FETCH_ASSOC);
        $q->closeCursor();


        if (empty($accounts))
            return false;


       foreach($accounts as &$ac) {
           list($ac['name'])=Engine::singleton()->getObject('language')->parseTag(array($ac['name']));
           $ac['options']=unserialize($ac['options']);
           $ac['mem_limit']=$ac['mem_limit']?$ac['mem_limit']:$ac['options']['memoryMB'];
           $ac['disk_limit']=$ac['disk_limit']?$ac['disk_limit']:$ac['options']['diskSpaceGB'];
       }
        return $accounts;
    }

}