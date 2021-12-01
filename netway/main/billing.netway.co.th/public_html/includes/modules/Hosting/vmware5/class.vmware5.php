<?php

// load our VMware operations class
require_once 'lib/vmware_operations.php';

/**
 * Integrates HostBill with VMware 5
 *
 * There are PHPdocs that may interest u in vmware_operations.php (for class)
 * and in vmware_create_vm.php for method createVm
 */
class Vmware5 extends VPSModule  implements HostingModuleListing
{

    public function __construct()
    {
        foreach ($this->details as &$opt) {
            if ($opt['type']) {
                $opt['tpl'] = __DIR__ . DS . 'admin' . DS . $opt['tpl'];
            }
        }
        parent::__construct();

        #licensesnippet#
    }

    public function __sleep()
    {
        return array_diff(array_keys(get_object_vars($this)), ['db', 'logger_obj', 'VmwareOperations']);
    }

    public function __wakeup()
    {

        $this->db = \HBRegistry::db();
        if (!empty($this->connection)) {
            $this->connect($this->connection);
        }
    }


    public function upgrade($old)
    {
        $old = (float) $old;
        if ($old < 1.1) {
            $q = $this->db->prepare("UPDATE hb_modules_configuration SET remote=? WHERE id=?");
            $q->execute(array($this->_repository, $this->id));
        }
    }

    protected $_repository = 'vmware5';
    protected $version = '1.20210428';

    /**
     * Module name to be displayed in admin area
     *
     * @var string
     */
    protected $modname = 'VMware 5';

    /**
     * Description to be displayed in admin area
     *
     * @var string
     */
    protected $description = 'Manage your VMware vSphere ESXi 5 virtual machines';

    /**
     * All commands
     *
     * @var array
     */
    protected $commands = array(
        'Suspend',
        'Unsuspend',
        'Terminate',
        'Create',
        'Reboot',
        'Start',
        'Stop'
    );

    /**
     * Client's commands
     *
     * @var array
     */
    protected $clientCommands = array(
        'Start',
        'Stop',
        'Reboot'
    );

    /**
     * Product configuration capabilities, so during account creation it will be able to distinguish
     * parameters that should be used
     *
     * This is set in admin area during product creation.
     *
     * @var array
     */
    protected $options = array(
        'userRole' => array(
            'name' => "VM's user role",
            'value' => false,
            'type' => 'loadable',
            'default' => 'getRolesList',
            'description' => 'Role that will be assigned to user when creating VM',
        ),
        'datacenterName' => array(
            'name' => "Datacenter for VM",
            'value' => false,
            'type' => 'loadable',
            'default' => 'getDatacenterList',
            'description' => 'Datacenter used by created VM',
        ),
        'datastoreName' => array(
            'name' => "Datastore for VM",
            'value' => false,
            'type' => 'loadable',
            'default' => 'getDatastoresList',
            'description' => 'Datastore used by created VM',
        ),
        'hostName' => array(
            'name' => "Host name on which create VM",
            'value' => false,
            'type' => 'loadable',
            'default' => 'getHostList',
            'description' => 'Host name on which VM should be created',
        ),
        'resourcePoolName' => array(
            'name' => "Resource Pool for VM",
            'value' => false,
            'type' => 'loadable',
            'default' => 'getResourcePoolsList',
            'description' => 'Resource Pool that should be used for VM',
        ),
        'guestOs' => array(
            'name' => "Guest OS",
            'value' => false,
            'type' => 'loadable',
            'default' => 'getGuestList',
            'description' => 'For which OS should be VM prepared',
            'variable' => 'guestos',
            'forms' => 'select'
        ),
        'isoDatastorePath' => array(
            'name' => "[optional] Path to iso file",
            'value' => false,
            'type' => 'input',
            'description' => 'Path to iso file in datastore, Example: [datastore1]ISO/debian.iso.
								Where datastore1 is datastore in which iso should be located, and path is location where
								iso is located in selected datastore',

            'variable' => 'isodatastorepath',
            'forms' => 'select'
        ),
        'numCPUs' => array(
            'name' => 'Number of virtual processors in a virtual machine',
            'value' => '1',
            'type' => 'input'
        ),
        'memoryMB' => array(
            'name' => "Size of a virtual machine's memory, in MB",
            'value' => '128',
            'type' => 'input',
        ),
        'diskSpaceGB' => array(
            'name' => "Size of a virtual machine's disk space, in GB",
            'value' => '',
            'type' => 'input',
        ),
        'useESXIAccountMgr' => array(
            'name' => "Use ESXi Account Manager",
            'value' => '',
            'type' => 'check',
        ),
        'dataStoreFolder' => array(
            'name' => "Store client VMs in this folder:",
            'value' => '',
            'type' => 'input',
        ),
    );

    /**
     * Define additional fields that should be displayed in admin account details page
     *
     * Modifying $details array values in Create method will update database values.
     * Its good place to modify password or username if it was set during account creation.
     *
     * @var array
     */
    protected $details = array(
        'username' => array(
            'name' => 'username',
            'value' => '',
            'type' => 'input',
            'default' => false
        ),
        'option4' => array(
            'name' => 'domain',
            'value' => false,
            'type' => 'input',
            'default' => false
        ),
        'password' => array(
            'name' => 'password',
            'value' => '',
            'type' => 'input',
            'default' => false
        ),
        'VmUuid' => array(
            'name' => 'VM uuid',
            'value' => '',
            'type' => 'tpl',
            'tpl' => 'uuid.tpl',
            'default' => false
        ),
    );

    /**
     * Connection to vmware
     *
     * @var VmwareOperations
     */
    private $VmwareOperations;

    /**
     * Info about connection
     *
     * @var
     */
    private $connection;

    /**
     * Connect to VM
     *
     * @param 	$_appDetails
     * @return 	bool
     */
    public function connect($_appDetails)
    {

        $this->options = array();
        $host = !empty($_appDetails['ip']) ? $_appDetails['ip'] : $_appDetails['host'];

        // use SSL connection?
        if ($_appDetails['secure']) {
            $host .= ':443';
        }

        $this->connection['host'] = trim($host);
        $this->connection['username'] = $_appDetails['username'];
        $this->connection['password'] = $_appDetails['password'];
        $this->connection['secure'] = $_appDetails['secure'];

        if (Engine::getMode() !== Engine::QUEUE_WORKER && MEMORY_LIMIT && MEMORY_LIMIT < 512) {
            $this->addError('PHP Memory limit is to low, required at least 512MB');
            return false;
        }

        try {

            $Vhost = new \Vmwarephp\Vhost(
                $this->connection['host'],
                $this->connection['username'],
                $this->connection['password']
            );

            $Vhost->getApiType();
            $this->VmwareOperations = new VmwareOperations($Vhost);
        } catch (Exception $E) {
            $this->addError($E->getMessage());
            $this->VmwareOperations = new VmwareNoConnection();
        }

        return $_appDetails;
    }



    /**
     * List domains managed by module.
     * Returned data is in form of an array with keys like in hb_accounts,
     *
     * @return array[] [
     *  'username' => 'username', //account identifier
     *
     *  '... other keys are optional'
     *  'account_id' => if its set and non-zero, it will mean that this account is alrady in HostBill. Module did some internal checks to determine this
     * ]
     */
    public function getAccounts()
    {

        try {
            $_vms = $this->VmwareOperations->ListVms();

            $vms = [];
            foreach ($_vms as $vm) {
                $disk = $vm->summary->storage->committed ? floor($vm->summary->storage->committed / \HBC\Gi) : 0;
                $product = "mem: " . $vm->summary->config->memorySizeMB . "MB, cpu: " . $vm->summary->config->numCpu;
                if ($disk) {
                    $product .= ', hdd: ' . $disk . 'GB';
                }

                $vms[] = [
                    'vpstype' => 'Other',
                    'extra_details' => [
                        'VmUuid' => $vm->summary->config->instanceUuid,
                        'option4' => $vm->name
                    ],
                    'ip' => $vm->summary->guest->ipAddress ? $vm->summary->guest->ipAddress : '',
                    'domain' => $vm->name,
                    'status' => $vm->summary->runtime->powerState  === 'poweredOff' ? 'Suspended' : 'Active',
                    'username' => $vm->name,
                    'veid' => $vm->summary->config->instanceUuid,
                    'guaranteed_ram' => $vm->summary->config->memorySizeMB,
                    'burstable_ram' => $vm->summary->config->memorySizeMB,
                    'disk_limit' => $disk,
                    'os' => $vm->summary->config->guestFullName,
                    'node' => '0',
                    'product_name' => $product,
                    'id' => str_replace('vm-', '', $vm->getReferenceId())
                ];
            }
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            return [];
        }

        return $vms;
    }



    public function getImportType()
    {
        return ImportAccounts_Model::TYPE_IMPORT_NO_PRODUCTS;
    }

    /**
     * When adding new App for your module administrator may want to check whether details he provided are valid.
     *
     * @return bool
     */
    public function testConnection()
    {
        if (!($this->VmwareOperations instanceof VmwareOperations)) {
            return false;
        }
        return true;
    }


    public function __destruct()
    {
        if ($this->VmwareOperations instanceof VmwareOperations) {
            $this->VmwareOperations->Vhost->service->disconnect();
        }
    }

    /**
     * Hook: create VM
     *
     * @return bool
     */
    public function Create()
    {
        $EXIACC = $this->options['useESXIAccountMgr']['value'] == '1';
        $username = $this->details['username']['value'];

        if ($EXIACC) {
            try {
                $this->VmwareOperations->createUser($username, $this->details['password']['value']);
            } catch (Exception $e) {
                $this->addError($e->getMessage());
                return false;
            }
        }
        // change GB to KB
        $diskSpaceKB = $this->options['diskSpaceGB']['value'] * 1024 * 1024;

        $iso = $this->account_config['isodatastorepath']['variable_id'] ?: $this->options['isoDatastorePath']['value'];
        $guestos = $this->account_config['guestos']['variable_id'] ?: $this->options['guestOs']['value'];
        try {
            $CreateVm = $this->VmwareOperations->createVm(
                $this->details['option4']['value'] ? $this->details['option4']['value'] : $username, // name of VM
                $this->options['datacenterName']['value'], // datacenter name
                $this->options['datastoreName']['value'], // datastore name
                $this->options['hostName']['value'], // host name
                $this->options['resourcePoolName']['value'], // resource pool name
                $guestos, // guest os
                $iso, // path to iso in datastore
                $diskSpaceKB, // disk space in GB
                $this->options['memoryMB']['value'], // memory in MB
                $this->options['numCPUs']['value'],
                $this->options['dataStoreFolder']['value']
            );
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            if ($EXIACC)
                $this->VmwareOperations->terminateUser($username);
            return false;
        }


        $this->disk_limit = $this->options['diskSpaceGB']['value'];
        $this->guaranteed_ram = $this->options['memoryMB']['value'];

        // wait for VM to be created
        try {
            $time = time();
            do {
                $vmInfo = $CreateVm->getInfo();
                sleep(1);
            } while ($vmInfo->state != 'success' && time() - $time < 20 && $vmInfo->state != 'error');

            if ($vmInfo->state == 'error') {
                throw new Exception($vmInfo->error->localizedMessage);
            }
            $CreatedVm = $vmInfo->result;
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            if ($EXIACC)
                $this->VmwareOperations->terminateUser($username);
            return false;
        }

        // store instance UUID in HostBill
        $this->details['VmUuid']['value'] = $CreatedVm->config->instanceUuid;

        if ($EXIACC) {
            $userRoleName = $this->options['userRole']['value'];
            $VmReference = $CreatedVm->toReference();
            $this->VmwareOperations->addPermission($VmReference, $userRoleName, $username);
        }


        // power on machine
        $this->Start();

        return true;
    }

    /**
     * Hook: terminate VM and it's user
     *
     * @return bool
     */
    public function Terminate()
    {

        // VM to terminate must be powered off
        try {
            $this->VmwareOperations->powerOffVmAndWait($this->details['VmUuid']['value']);
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            return false;
        }
        try {
            $this->VmwareOperations->terminateVm($this->details['VmUuid']['value']);
            if ($this->options['useESXIAccountMgr']['value'] == '1') {
                $this->VmwareOperations->terminateUser($this->details['username']['value']);
            }
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            return false;
        }
        return true;
    }

    /**
     * Hook: suspend VM
     *
     * @return bool
     */
    public function Suspend()
    {
        try {
            $this->VmwareOperations->suspendVm($this->details['VmUuid']['value']);
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
        return true;
    }

    /**
     * Hook: unsuspend VM
     *
     * @return bool
     */
    public function Unsuspend()
    {
        try {
            $this->VmwareOperations->powerOnVm($this->details['VmUuid']['value']);
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
        return true;
    }

    /**
     * Hook: start VM. Executed by $this->clientCommands property
     *
     * It also unsuspends suspended VM.
     *
     * used on client's side
     */
    public function getStart()
    {
        try {
            $this->Start();
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
    }

    /**
     * Hook: stop VM. Executed by $this->clientCommands property
     *
     * used on client's side
     */
    public function getStop()
    {
        try {
            $this->Stop();
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
    }

    /**
     * Hook: reboot WM. Executed by $this->clientCommands property
     *
     * used on client's side
     */
    public function getReboot()
    {
        try {
            $this->Reboot();
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
    }

    /**
     * Hook: start VM.
     *
     * It also unsuspends suspended VM.
     *
     * used on client's side
     */
    public function Start()
    {
        try {
            $this->VmwareOperations->powerOnVm($this->details['VmUuid']['value']);
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
        $this->addInfo("actionsuccess");
        return true;
    }

    /**
     * Hook: stop VM.
     *
     * used on client's side
     */
    public function Stop()
    {
        try {
            $this->VmwareOperations->powerOffVm($this->details['VmUuid']['value']);
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
        $this->addInfo("actionsuccess");
        return true;
    }

    /**
     * Hook: reboot WM.
     *
     * used on client's side
     */
    public function Reboot()
    {
        try {
            $this->VmwareOperations->rebootVm($this->details['VmUuid']['value']);
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
        }
        $this->addInfo("actionsuccess");
        return true;
    }

    /**
     * Get VM details
     *
     * @return array
     */
    public function getVMDetails()
    {
        try {
            $Vm = $this->VmwareOperations->getVm($this->details['VmUuid']['value']);
            $Config = $Vm->config;
        } catch (Exception $ex) {
            $this->addError($ex->getMessage());
            return [];
        }


        $details = array();
        $details['powerState'] = $Vm->runtime->powerState;
        $details['guestOS'] = $Config->guestFullName;
        $details['memoryMB'] = $Config->hardware->memoryMB;
        $details['numCPU'] = $Config->hardware->numCPU;

        // find info about disk
        foreach ($Config->hardware->device as $Device) {
            if (get_class($Device) == 'VirtualDisk') {
                $details['diskSpaceGB'] = $Device->capacityInKB / 1024 / 1024;
            }
        }

        return $details;
    }

    /**
     * Get Roles list
     *
     * @return array
     */
    public function getRolesList()
    {
        return $this->VmwareOperations->getRolesList();
    }

    /**
     * Get datastores list
     *
     * @return array
     */
    public function getDatastoresList()
    {
        return $this->VmwareOperations->getDatastoresList();
    }

    /**
     * Get resource pools list
     *
     * @return array
     */
    public function getResourcePoolsList()
    {
        return $this->VmwareOperations->getResourcePoolsList();
    }

    /**
     * Get guest list
     *
     * @return array
     */
    public function getGuestList()
    {
        return $this->VmwareOperations->getGuestList();
    }

    /**
     * Get host list
     *
     * @return array
     */
    public function getHostList()
    {
        return $this->VmwareOperations->getHostList();
    }

    /**
     * Get datacenter list
     *
     * @return array
     */
    public function getDatacenterList()
    {
        return $this->VmwareOperations->getDatacenterList();
    }

    public function listHostVms()
    {
        try {
            $_vms = $this->VmwareOperations->ListVms();
        } catch (Exception $e) {
            $this->addError($e->getMessage());
            return [];
        }
        $vms = [];
        foreach ($_vms as $vm) {
            $vms[] = [
                'uuid' => $vm->summary->config->instanceUuid,
                'name' => $vm->name,
                'id' => str_replace('vm-', '', $vm->getReferenceId())
            ];
        }
        return $vms;
    }
}

class VmwareNoConnection
{

    public function __get($name)
    {
        Engine::addError('Vmware server not connected, cannot use ' . $name);
    }

    public function __call($name, $arguments)
    {
        Engine::addError('Vmware server not connected, cannot use ' . $name);
    }
}
