<?php

/**
 * Load VMwarePHP library
 * URL: https://github.com/vadimcomanescu/vmwarephp
 *
 * Base library has few bugs that I must to overcome. And it leads to changes in library.
 *
 * 1. There was bug in property collector. When property collector returns managed object reference
 * VMwarePHP fails to return this object because it has not definition of it in TypeDefinitions.inc
 * probably because it's based only on types xsd file.
 *
 * I solved this problem by changing method findRequestedObjectInCollectionResult in Vmwarephp / Extensions / PropertyCollector.php
 * I added if statement "if ( $managedObject->getReferenceType() == $managedObjectType )"
 *
 * 2. When making SOAP requests Vmwarephp make preg_replace changes in envelope's attributes. Reason of that is some
 * PHP bug, that makes them some problem but their solution repairs something. Makes problem when creating VM
 * because it removes essential xsi type attributes.
 *
 * I commented out line "$request = $this->appendXsiTypeForExtendedDatastructures($request);" in
 * Vmwarephp / SoapClient.php method __doRequest
 *
 * @todo Investigate above problem (2) and find solution that repair both problems
 */
require_once 'Vmwarephp/Autoloader.php';
$Autoloader = new \Vmwarephp\Autoloader;
$Autoloader->register();
unset($Autoloader);

/**
 * Operations on VMware
 */
class VmwareOperations
{

    /**
     * Vhost instance
     *
     * @var \Vmwarephp\Vhost
     */
    public $Vhost;

    /**
     * Construct
     *
     * DI vhost instance
     *
     * @param $_Vhost \Vmwarephp\Vhost
     */
    public function __construct($_Vhost)
    {

        $this->Vhost = $_Vhost;
    }

    /**
     * Create VM
     *
     * This method simply pass control to VmwareCreateVm
     *
     * @param 	$_name
     * @param 	$_datacenterName
     * @param 	$_datastoreName
     * @param 	$_hostName
     * @param 	$_resourcePoolName
     * @param 	$_guestOsName
     * @param 	$_diskKB
     * @param 	$_memoryMB
     * @return 	object
     */
    public function createVm($_name, $_datacenterName, $_datastoreName, $_hostName, $_resourcePoolName, $_guestOsName, $_isoDatastorePath, $_diskKB, $_memoryMB, $_numCPUs, $_dcFolder = '')
    {

        // load class
        require_once 'vmware_create_vm.php';

        $VmwareCreateVm = new VmwareCreateVm($this->Vhost);
        return $VmwareCreateVm->createVm($_name, $_datacenterName, $_datastoreName, $_hostName, $_resourcePoolName, $_guestOsName, $_isoDatastorePath, $_diskKB, $_memoryMB, $_numCPUs, $_dcFolder);
    }

    /**
     * Create user (add)
     *
     * @param $_username
     * @param $_password
     */
    public function createUser($_username, $_password)
    {

        $User = new stdClass();
        $User->id = $_username;
        $User->password = $_password;

        $HostLocalAccountManager = $this->Vhost->service->getAccountManager();

        $response = $HostLocalAccountManager->CreateUser(array(
            'user' => $User
        ));
    }

    /**
     * Terminate user (remove)
     *
     * @param $_username
     */
    public function terminateUser($_username)
    {

        $HostLocalAccountManager = $this->Vhost->service->getAccountManager();
        $HostLocalAccountManager->RemoveUser(array(
            'userName' => $_username
        ));
    }

    /**
     * Add permision to user
     *
     * @param $_Entity
     * @param $_roleName
     * @param $_username
     */
    public function addPermission($_Entity, $_roleName, $_username)
    {

        $AuthorizationManager = $this->Vhost->service->getAuthorizationManager();

        $Permission = new stdClass();
        $Permission->roleId = $this->getRoleIdByName($_roleName);
        $Permission->propagate = true;
        $Permission->principal = $_username;
        $Permission->group = false; // because we operate on user

        $SetEntityPermissions = $AuthorizationManager->setEntityPermissions(array(
            'entity' => $_Entity,
            'permission' => $Permission
        ));
    }

    /**
     * Get VM
     *
     * @param 	$_uuid
     * @return 	mixed
     */
    public function getVm($_uuid)
    {
        $SearchIndex = $this->Vhost->service->getSearchIndex();

        $Vm = $SearchIndex->FindByUuid(array(
            'uuid' => $_uuid,
            'vmSearch' => true,
            'instanceUuid' => true
        ));
        if (!$Vm)
            throw new Exception("VM with uuid {$_uuid} was not found", 404);

        return $Vm;
    }

    /**
     * Get VM
     *
     * @param 	$_uuid
     * @return 	mixed
     */
    public function ListVms()
    {
        return $this->Vhost->findAllManagedObjects('VirtualMachine', ['name', 'summary']);
    }

    /**
     * Terminate VM
     *
     * @param $_uuid
     */
    public function terminateVm($_uuid)
    {

        $Vm = $this->getVm($_uuid);
        $Vm->Destroy_Task();
    }

    /**
     * Suspend VM
     *
     * @param $_uuid
     */
    public function suspendVm($_uuid)
    {

        $Vm = $this->getVm($_uuid);
        $Vm->SuspendVM_Task();
    }

    /**
     * Power on VM
     *
     * @param $_uuid
     */
    public function powerOnVm($_uuid)
    {

        $Vm = $this->getVm($_uuid);
        $Vm->PowerOnVM_Task();
    }

    /**
     * Power off VM
     *
     * @param $_uuid
     */
    public function powerOffVm($_uuid)
    {

        $Vm = $this->getVm($_uuid);
        $Vm->PowerOffVM_Task();
    }

    /**
     * Power off VM and wait till ends
     *
     * @param $_uuid
     */
    public function powerOffVmAndWait($_uuid)
    {

        $Vm = $this->getVm($_uuid);
        if (!is_object($Vm)) {
            throw new Exception('VM not found');
        }
        $Task = $Vm->PowerOffVM_Task();

        // wait for task to be exec
        $time = time();
        do {
            sleep(1);
        } while ($Task->info->state != 'success' && time() - $time < 20);
    }

    /**
     * Reboot VM
     *
     * @param $_uuid
     */
    public function rebootVm($_uuid)
    {

        $Vm = $this->getVm($_uuid);

        try {
            $Vm->RebootGuest();
        } catch (Exception $E) {
            $this->powerOffVmAndWait($_uuid);

            $this->powerOnVm($_uuid);
        }
    }

    /**
     * Get resource pool list
     *
     * @return array
     */
    public function getResourcePoolsList()
    {

        $resourcePools = $this->Vhost->findAllManagedObjects('ResourcePool', 'all');

        foreach ($resourcePools as $ResourcePool) {
            $selectList[] = $ResourcePool->name;
        }

        return $selectList;
    }

    /**
     * Get roles list
     *
     * @return 	array
     */
    public function getRolesList()
    {

        $AuthorizationManager = $this->Vhost->service->getAuthorizationManager();

        foreach ($AuthorizationManager->roleList as $Role) {
            $selectList[] = $Role->name;
        }

        return $selectList;
    }

    /**
     * Get datastores list
     *
     * @return array
     */
    public function getDatastoresList()
    {

        $datastores = $this->Vhost->findAllManagedObjects('Datastore', 'all');

        foreach ($datastores as $Datastore) {
            $selectList[] = $Datastore->name;
        }

        return $selectList;
    }

    /**
     * Get guest list
     *
     * @return array
     */
    public function getGuestList()
    {

        $resourcePools = $this->Vhost->findAllManagedObjects('ResourcePool', 'all');
        $guests = $resourcePools[0]->owner->environmentBrowser->QueryConfigOption()->guestOSDescriptor;

        foreach ($guests as $Guest) {
            $selectList[] = $Guest->fullName;
        }

        return $selectList;
    }

    /**
     * Get host list
     *
     * @return array
     */
    public function getHostList()
    {

        $hostSystems = $this->Vhost->findAllManagedObjects('HostSystem', 'all');

        foreach ($hostSystems as $HostSystem) {
            $selectList[] = $HostSystem->name;
        }

        return $selectList;
    }

    /**
     * Get datacenter list
     *
     * @return array
     */
    public function getDatacenterList()
    {

        $datacenters = $this->Vhost->findAllManagedObjects('Datacenter', 'all');

        foreach ($datacenters as $Datacenter) {
            $selectList[] = $Datacenter->name;
        }

        return $selectList;
    }

    /**
     * Get role id by name
     *
     * @param 	$_roleName
     * @return 	mixed
     * @throws 	Exception
     */
    private function getRoleIdByName($_roleName)
    {

        $AuthorizationManager = $this->Vhost->service->getAuthorizationManager();

        foreach ($AuthorizationManager->roleList as $Role) {
            if ($_roleName == $Role->name) {
                return $Role->roleId;
            }
        }

        throw new Exception('Role id not found by role name');
    }
}
