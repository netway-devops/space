<?php

/**
 * Create VM
 */
class VmwareCreateVm {

    /**
     * Vhost instance
     *
     * @var Vmwarephp\Vhost
     */
    public $Vhost;

    /**
     * Construct
     *
     * DI Vhost instance
     *
     * @param $_Vhost
     */
    public function __construct($_Vhost) {

        $this->Vhost = $_Vhost;
    }

    /**
     * Create VM
     *
     * Based on examples provided by VMware for C# and java in respective SDKs.
     * Exact files are: CreateVM.cs, VMCreate.java.
     * But probably more readable is C# example rather than java's
     *
     * U can also find helpful post on VMware forum that show example correct config needed to create VM,
     * http://communities.vmware.com/message/1699904#1699904 [@jeveenj Feb 16, 2011 2:29 AM]
     *
     * @param 	$_name
     * @param 	$_datacenterName
     * @param 	$_datastoreName
     * @param 	$_hostName
     * @param 	$_resourcePoolName
     * @param 	$_guestOsName
     * @param	$_isoDatastorePath
     * @param 	$_diskKB
     * @param 	$_memoryMB
     * @return 	object
     */
    public function createVm($_name, $_datacenterName, $_datastoreName, $_hostName, $_resourcePoolName, $_guestOsName, $_isoDatastorePath, $_diskKB, $_memoryMB, $_numCPUs = 1, $_dcFolder = '') {


        // to get to Folder where we store VMs
        $Datacenter = $this->getDatacenterByName($_datacenterName);
        $VmFolder = $Datacenter->vmFolder;
        $DatacenterRef = $Datacenter->toReference();

        // resource where we create VM
        $ResourcePool = $this->getResourcePoolByName($_resourcePoolName);
        $ResourcePoolRef = $ResourcePool->toReference();

        // get data from datastore
        $Datastore = $this->getDatastoreByName($_datastoreName);
        $dataStoreName = $Datastore->name;
        $DatastoreRef = $Datastore->toReference();

        // this object is used for searching of entities
        $SearchIndex = $this->Vhost->service->getSearchIndex();

        // find host for VM
        $HostRef = $SearchIndex->FindByDnsName(array(
            'datacenter' => $DatacenterRef,
            'dnsName' => $_hostName,
            'vmSearch' => false,
        ));

        if(is_null($HostRef)) {
            $hostSystems 	= $this->Vhost->findAllManagedObjects( 'HostSystem', 'all' );
            foreach($hostSystems as $system) {
                if($system->name == $_hostName) {
                    $HostRef=$system;
                    break;
                }
            }
        }



        if(is_null($HostRef)) {
            throw new Exception("Host :".$_hostName." was not found in datacenter: ".$_datacenterName);
        }

        // create config for VM
        $Config = new VirtualMachineConfigSpec;
        $Config->name = $_name;
        $Config->numCPUs = $_numCPUs;
        $Config->guestId = $this->getGuestIdByName($ResourcePool, $_guestOsName);
        $Config->memoryMB = $_memoryMB;

        // place where we store VMs files
        $Config->files = new VirtualMachineFileInfo;
        $Config->files->vmPathName = "[" . $dataStoreName . "]";

        if ($_dcFolder) {
            $Config->files->vmPathName = "[" . $dataStoreName . "]" . $_dcFolder;
        }

        // we need get some data needed for devices like scsi, cdrom, hardrive
        $HostParentCompResRef = $HostRef->parent;
        $EnvBrowseMor = $HostParentCompResRef->environmentBrowser;
        $ConfigTarget = $EnvBrowseMor->QueryConfigTarget(array(
            'host' => $HostRef->toReference()
        ));

        $CfgOpt = $EnvBrowseMor->QueryConfigOption(array(
            'host' => $HostRef->toReference()
        ));

        $defaultDevices = $CfgOpt->defaultDevice;

        // find network name
        if (!empty($ConfigTarget->network)) {
            foreach ($ConfigTarget->network as $netInfo) {
                $netSummary = $netInfo->network;
                if ($netSummary->accessible == true) {
                    $networkName = $netSummary->name;
                    break;
                }
            }
        }

        // find IDE controller
        foreach ($defaultDevices as $device) {
            if (get_class($device) == 'VirtualIDEController') {
                $IdeCtlr = $device;
                break;
            }
        }

        // create floppy
        $FlpBacking = new VirtualFloppyDeviceBackingInfo;
        $FlpBacking->deviceName = "/dev/fd0";

        $Floppy = new VirtualFloppy;
        $Floppy->backing = $FlpBacking;
        $Floppy->key = 3;

        $FloppySpec = new VirtualDeviceConfigSpec;
        $FloppySpec->operation = 'add';
        $FloppySpec->device = $Floppy;

        // create cdrom
        if (!empty($IdeCtlr)) {

            $CdDeviceBacking = new VirtualCdromIsoBackingInfo();
            $CdDeviceBacking->datastore = $DatastoreRef;
            if ($_isoDatastorePath) {
                $CdDeviceBacking->fileName = $_isoDatastorePath;
            } else {
                $CdDeviceBacking->fileName = "[" . $dataStoreName . "]testcd.iso";
            }

            $Cdrom = new VirtualCdrom();
            $Cdrom->backing = $CdDeviceBacking;
            $Cdrom->key = 20;
            $Cdrom->controllerKey = $IdeCtlr->key;
            $Cdrom->controllerKeySpecified = true;
            $Cdrom->unitNumberSpecified = true;
            $Cdrom->unitNumber = 0;

            $CdSpec = new VirtualDeviceConfigSpec();
            $CdSpec->operation = 'add';
            $CdSpec->operationSpecified = true;
            $CdSpec->device = $Cdrom;
        }

        $diskCtlrKey = -2;

        // create SCSI controller
        $ScsiCtrl = new VirtualLsiLogicController;
        $ScsiCtrl->busNumber = 0;
        $ScsiCtrl->controllerKey = 100;
        $ScsiCtrl->key = $diskCtlrKey;
        $ScsiCtrl->sharedBus = 'noSharing';
        $ScsiCtrl->scsiCtlrUnitNumber = 7;
        $ScsiCtrl->hotAddRemove = true;
        $ScsiCtrl->unitNumber = 1;

        $ScsiCtrlSpec = new VirtualDeviceConfigSpec();
        $ScsiCtrlSpec->operation = 'add';
        $ScsiCtrlSpec->device = $ScsiCtrl;

        // create HD, attach it to SCSI controller
        $DiskfileBacking = new VirtualDiskFlatVer2BackingInfo();
        $DiskfileBacking->fileName = $Config->files->vmPathName;
        $DiskfileBacking->diskMode = 'persistent';
        $DiskfileBacking->datastore = $DatastoreRef;

        $DiskfileBacking->thinProvisioned = true;
        $DiskfileBacking->writeThrough = false;
        $DiskfileBacking->split = false;

        $Disk = new VirtualDisk();
        $Disk->key = -3;
        $Disk->controllerKey = $diskCtlrKey;
        $Disk->unitNumber = 0;
        $Disk->backing = $DiskfileBacking;
        $Disk->capacityInKB = $_diskKB;

        $DiskSpec = new VirtualDeviceConfigSpec;
        $DiskSpec->fileOperation = 'create';
        $DiskSpec->operation = 'add';
        $DiskSpec->device = $Disk;

        // create NIC
        if (!empty($networkName)) {
            $NicBacking = new VirtualEthernetCardNetworkBackingInfo();
            $NicBacking->deviceName = $networkName;

            $Nic = new VirtualPCNet32();
            $Nic->addressType = "generated";
            $Nic->backing = $NicBacking;
            $Nic->key = 4;

            $NicSpec = new VirtualDeviceConfigSpec();
            $NicSpec->operation = 'add';
            $NicSpec->operationSpecified = true;
            $NicSpec->device = $Nic;
        }

        // now bind devices to VM
        $deviceConfigSpec = array();
        $deviceConfigSpec[] = $ScsiCtrlSpec;
        $deviceConfigSpec[] = $FloppySpec;
        $deviceConfigSpec[] = $DiskSpec;
        if($CdSpec)
            $deviceConfigSpec[] = $CdSpec;
        if($NicSpec)
            $deviceConfigSpec[] = $NicSpec;

        $Config->deviceChange = $deviceConfigSpec;


        // create VM
        $CreateVM_Task = $VmFolder->CreateVM_Task(array(
            'config' => $Config,
            'pool' => $ResourcePoolRef
        ));

        return $CreateVM_Task;
    }

    /**
     * Get datastore by name
     *
     * @param 	$_datastoreName
     * @return 	mixed
     * @throws 	Exception
     */
    private function getDatastoreByName($_datastoreName) {

        $datastores = $this->Vhost->findAllManagedObjects('Datastore', 'all');

        foreach ($datastores as $Datastore) {
            if ($Datastore->name == $_datastoreName) {
                return $Datastore;
            }
        }

        throw new Exception('Datastore not found by name');
    }

    /**
     * Get resource pool name
     *
     * @param 	$_resourcePoolName
     * @return 	mixed
     * @throws 	Exception
     */
    private function getResourcePoolByName($_resourcePoolName) {

        $resourcePools = $this->Vhost->findAllManagedObjects('ResourcePool', 'all');

        foreach ($resourcePools as $ResourcePool) {
            if ($_resourcePoolName == $ResourcePool->name) {
                return $ResourcePool;
            }
        }

        throw new Exception('Resource Pool not found by name');
    }

    /**
     * Get guest OS by it's full name
     *
     * @param 	$_ResourcePool
     * @param 	$_guestOsName
     * @return 	mixed
     * @throws 	Exception
     */
    private function getGuestIdByName($_ResourcePool, $_guestOsName) {

        $guests = $_ResourcePool->owner->environmentBrowser->QueryConfigOption()->guestOSDescriptor;

        foreach ($guests as $Guest) {
            if ($_guestOsName == $Guest->fullName) {
                return $Guest->id;
            }
        }

        throw new Exception('Guest os not found by name');
    }

    /**
     * Get datacenter by it's name
     *
     * @param 	$_datacenterName
     * @return 	mixed
     * @throws 	Exception
     */
    private function getDatacenterByName($_datacenterName) {

        $datacenters = $this->Vhost->findAllManagedObjects('Datacenter', 'all');

        foreach ($datacenters as $Datacenter) {
            if ($_datacenterName == $Datacenter->name) {
                return $Datacenter;
            }
        }

        throw new Exception('Datacenter not found by name');
    }

}
