<?php
class DynamicArray {
	public $dynamicType; //string
	public $val; //anyType

	function __construct($dynamicType = null, $val = null) {
		$this->dynamicType = $dynamicType;
		$this->val = $val;
	}
}

class DynamicData {
	public $dynamicType; //string
	public $dynamicProperty; //DynamicProperty

	function __construct($dynamicType = null, $dynamicProperty = null) {
		$this->dynamicType = $dynamicType;
		$this->dynamicProperty = $dynamicProperty;
	}
}

class DynamicProperty {
	public $name; //string
	public $val; //anyType

	function __construct($name = null, $val = null) {
		$this->name = $name;
		$this->val = $val;
	}
}

class ArrayOfDynamicProperty {
	public $DynamicProperty; //DynamicProperty

	function __construct($DynamicProperty = null) {
		$this->DynamicProperty = $DynamicProperty;
	}
}

class KeyAnyValue {
	public $key; //string
	public $value; //anyType

	function __construct($key = null, $value = null) {
		$this->key = $key;
		$this->value = $value;
	}
}

class ArrayOfKeyAnyValue {
	public $KeyAnyValue; //KeyAnyValue

	function __construct($KeyAnyValue = null) {
		$this->KeyAnyValue = $KeyAnyValue;
	}
}

class LocalizableMessage {
	public $key; //string
	public $arg; //KeyAnyValue
	public $message; //string

	function __construct($key = null, $arg = null, $message = null) {
		$this->key = $key;
		$this->arg = $arg;
		$this->message = $message;
	}
}

class ArrayOfLocalizableMessage {
	public $LocalizableMessage; //LocalizableMessage

	function __construct($LocalizableMessage = null) {
		$this->LocalizableMessage = $LocalizableMessage;
	}
}

class HostCommunication {
}

class HostNotConnected {
}

class HostNotReachable {
}

class InvalidArgument {
	public $invalidProperty; //string

	function __construct($invalidProperty = null) {
		$this->invalidProperty = $invalidProperty;
	}
}

class InvalidRequest {
}

class InvalidType {
	public $argument; //string

	function __construct($argument = null) {
		$this->argument = $argument;
	}
}

class ManagedObjectNotFound {
	public $obj; //ManagedObjectReference

	function __construct($obj = null) {
		$this->obj = $obj;
	}
}

class MethodNotFound {
	public $receiver; //ManagedObjectReference
	public $method; //string

	function __construct($receiver = null, $method = null) {
		$this->receiver = $receiver;
		$this->method = $method;
	}
}

class NotEnoughLicenses {
}

class NotImplemented {
}

class NotSupported {
}

class RequestCanceled {
}

class SecurityError {
}

class SystemError {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class UnexpectedFault {
	public $faultName; //string
	public $fault; //LocalizedMethodFault

	function __construct($faultName = null, $fault = null) {
		$this->faultName = $faultName;
		$this->fault = $fault;
	}
}

class LocalizedMethodFault {
	public $fault; //MethodFault
	public $localizedMessage; //string

	function __construct($fault = null, $localizedMessage = null) {
		$this->fault = $fault;
		$this->localizedMessage = $localizedMessage;
	}
}

class MethodFault {
	public $dynamicType; //string
	public $dynamicProperty; //DynamicProperty
	public $faultCause; //LocalizedMethodFault
	public $faultMessage; //LocalizableMessage

	function __construct($dynamicType = null, $dynamicProperty = null, $faultCause = null, $faultMessage = null) {
		$this->dynamicType = $dynamicType;
		$this->dynamicProperty = $dynamicProperty;
		$this->faultCause = $faultCause;
		$this->faultMessage = $faultMessage;
	}
}

class ArrayOfMethodFault {
	public $MethodFault; //MethodFault

	function __construct($MethodFault = null) {
		$this->MethodFault = $MethodFault;
	}
}

class RuntimeFault {
}

class ManagedObjectReference {
	public $_; //string
	public $type; //string

	function __construct($_ = null, $type = null) {
		$this->_ = $_;
		$this->type = $type;
	}
}

class ArrayOfString {
	public $string; //string

	function __construct($string = null) {
		$this->string = $string;
	}
}

class ArrayOfAnyType {
	public $anyType; //anyType

	function __construct($anyType = null) {
		$this->anyType = $anyType;
	}
}

class ArrayOfManagedObjectReference {
	public $ManagedObjectReference; //ManagedObjectReference

	function __construct($ManagedObjectReference = null) {
		$this->ManagedObjectReference = $ManagedObjectReference;
	}
}

class ArrayOfBoolean {
	public $boolean; //boolean

	function __construct($boolean = null) {
		$this->boolean = $boolean;
	}
}

class ArrayOfByte {
	public $byte; //byte

	function __construct($byte = null) {
		$this->byte = $byte;
	}
}

class ArrayOfInt {
	public $int; //int

	function __construct($int = null) {
		$this->int = $int;
	}
}

class ArrayOfLong {
	public $long; //long

	function __construct($long = null) {
		$this->long = $long;
	}
}

class ArrayOfShort {
	public $short; //short

	function __construct($short = null) {
		$this->short = $short;
	}
}

class InvalidCollectorVersion {
}

class InvalidProperty {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class PropertyFilterSpec {
	public $propSet; //PropertySpec
	public $objectSet; //ObjectSpec
	public $reportMissingObjectsInResults; //boolean

	function __construct($propSet = null, $objectSet = null, $reportMissingObjectsInResults = null) {
		$this->propSet = $propSet;
		$this->objectSet = $objectSet;
		$this->reportMissingObjectsInResults = $reportMissingObjectsInResults;
	}
}

class ArrayOfPropertyFilterSpec {
	public $PropertyFilterSpec; //PropertyFilterSpec

	function __construct($PropertyFilterSpec = null) {
		$this->PropertyFilterSpec = $PropertyFilterSpec;
	}
}

class PropertySpec {
	public $type; //string
	public $all; //boolean
	public $pathSet; //string

	function __construct($type = null, $all = null, $pathSet = null) {
		$this->type = $type;
		$this->all = $all;
		$this->pathSet = $pathSet;
	}
}

class ArrayOfPropertySpec {
	public $PropertySpec; //PropertySpec

	function __construct($PropertySpec = null) {
		$this->PropertySpec = $PropertySpec;
	}
}

class ObjectSpec {
	public $obj; //ManagedObjectReference
	public $skip; //boolean
	public $selectSet; //SelectionSpec

	function __construct($obj = null, $skip = null, $selectSet = null) {
		$this->obj = $obj;
		$this->skip = $skip;
		$this->selectSet = $selectSet;
	}
}

class ArrayOfObjectSpec {
	public $ObjectSpec; //ObjectSpec

	function __construct($ObjectSpec = null) {
		$this->ObjectSpec = $ObjectSpec;
	}
}

class SelectionSpec {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class ArrayOfSelectionSpec {
	public $SelectionSpec; //SelectionSpec

	function __construct($SelectionSpec = null) {
		$this->SelectionSpec = $SelectionSpec;
	}
}

class TraversalSpec extends SelectionSpec {
	public $type; //string
	public $path; //string
	public $skip; //boolean
	public $selectSet; //SelectionSpec

	function __construct($name = null, $type = null, $path = null, $skip = null, $selectSet = null) {
		parent::__construct($name);
		$this->type = $type;
		$this->path = $path;
		$this->skip = $skip;
		$this->selectSet = $selectSet;
	}
}

class ObjectContent {
	public $obj; //ManagedObjectReference
	public $propSet; //DynamicProperty
	public $missingSet; //MissingProperty

	function __construct($obj = null, $propSet = null, $missingSet = null) {
		$this->obj = $obj;
		$this->propSet = $propSet;
		$this->missingSet = $missingSet;
	}
}

class ArrayOfObjectContent {
	public $ObjectContent; //ObjectContent

	function __construct($ObjectContent = null) {
		$this->ObjectContent = $ObjectContent;
	}
}

class UpdateSet {
	public $version; //string
	public $filterSet; //PropertyFilterUpdate
	public $truncated; //boolean

	function __construct($version = null, $filterSet = null, $truncated = null) {
		$this->version = $version;
		$this->filterSet = $filterSet;
		$this->truncated = $truncated;
	}
}

class PropertyFilterUpdate {
	public $filter; //ManagedObjectReference
	public $objectSet; //ObjectUpdate
	public $missingSet; //MissingObject

	function __construct($filter = null, $objectSet = null, $missingSet = null) {
		$this->filter = $filter;
		$this->objectSet = $objectSet;
		$this->missingSet = $missingSet;
	}
}

class ArrayOfPropertyFilterUpdate {
	public $PropertyFilterUpdate; //PropertyFilterUpdate

	function __construct($PropertyFilterUpdate = null) {
		$this->PropertyFilterUpdate = $PropertyFilterUpdate;
	}
}

class ObjectUpdate {
	public $kind; //ObjectUpdateKind
	public $obj; //ManagedObjectReference
	public $changeSet; //PropertyChange
	public $missingSet; //MissingProperty

	function __construct($kind = null, $obj = null, $changeSet = null, $missingSet = null) {
		$this->kind = $kind;
		$this->obj = $obj;
		$this->changeSet = $changeSet;
		$this->missingSet = $missingSet;
	}
}

class ArrayOfObjectUpdate {
	public $ObjectUpdate; //ObjectUpdate

	function __construct($ObjectUpdate = null) {
		$this->ObjectUpdate = $ObjectUpdate;
	}
}

class PropertyChange {
	public $name; //string
	public $op; //PropertyChangeOp
	public $val; //anyType

	function __construct($name = null, $op = null, $val = null) {
		$this->name = $name;
		$this->op = $op;
		$this->val = $val;
	}
}

class ArrayOfPropertyChange {
	public $PropertyChange; //PropertyChange

	function __construct($PropertyChange = null) {
		$this->PropertyChange = $PropertyChange;
	}
}

class MissingProperty {
	public $path; //string
	public $fault; //LocalizedMethodFault

	function __construct($path = null, $fault = null) {
		$this->path = $path;
		$this->fault = $fault;
	}
}

class ArrayOfMissingProperty {
	public $MissingProperty; //MissingProperty

	function __construct($MissingProperty = null) {
		$this->MissingProperty = $MissingProperty;
	}
}

class MissingObject {
	public $obj; //ManagedObjectReference
	public $fault; //LocalizedMethodFault

	function __construct($obj = null, $fault = null) {
		$this->obj = $obj;
		$this->fault = $fault;
	}
}

class ArrayOfMissingObject {
	public $MissingObject; //MissingObject

	function __construct($MissingObject = null) {
		$this->MissingObject = $MissingObject;
	}
}

class WaitOptions {
	public $maxWaitSeconds; //int
	public $maxObjectUpdates; //int

	function __construct($maxWaitSeconds = null, $maxObjectUpdates = null) {
		$this->maxWaitSeconds = $maxWaitSeconds;
		$this->maxObjectUpdates = $maxObjectUpdates;
	}
}

class RetrieveOptions {
	public $maxObjects; //int

	function __construct($maxObjects = null) {
		$this->maxObjects = $maxObjects;
	}
}

class RetrieveResult {
	public $token; //string
	public $objects; //ObjectContent

	function __construct($token = null, $objects = null) {
		$this->token = $token;
		$this->objects = $objects;
	}
}

class DestroyPropertyFilterRequestType {
	public $_this; //ManagedObjectReference

	function __construct($_this = null) {
		$this->_this = $_this;
	}
}

class CreateFilterRequestType {
	public $_this; //ManagedObjectReference
	public $spec; //PropertyFilterSpec
	public $partialUpdates; //boolean

	function __construct($_this = null, $spec = null, $partialUpdates = null) {
		$this->_this = $_this;
		$this->spec = $spec;
		$this->partialUpdates = $partialUpdates;
	}
}

class RetrievePropertiesRequestType {
	public $_this; //ManagedObjectReference
	public $specSet; //PropertyFilterSpec

	function __construct($_this = null, $specSet = null) {
		$this->_this = $_this;
		$this->specSet = $specSet;
	}
}

class CheckForUpdatesRequestType {
	public $_this; //ManagedObjectReference
	public $version; //string

	function __construct($_this = null, $version = null) {
		$this->_this = $_this;
		$this->version = $version;
	}
}

class WaitForUpdatesRequestType {
	public $_this; //ManagedObjectReference
	public $version; //string

	function __construct($_this = null, $version = null) {
		$this->_this = $_this;
		$this->version = $version;
	}
}

class CancelWaitForUpdatesRequestType {
	public $_this; //ManagedObjectReference

	function __construct($_this = null) {
		$this->_this = $_this;
	}
}

class WaitForUpdatesExRequestType {
	public $_this; //ManagedObjectReference
	public $version; //string
	public $options; //WaitOptions

	function __construct($_this = null, $version = null, $options = null) {
		$this->_this = $_this;
		$this->version = $version;
		$this->options = $options;
	}
}

class RetrievePropertiesExRequestType {
	public $_this; //ManagedObjectReference
	public $specSet; //PropertyFilterSpec
	public $options; //RetrieveOptions

	function __construct($_this = null, $specSet = null, $options = null) {
		$this->_this = $_this;
		$this->specSet = $specSet;
		$this->options = $options;
	}
}

class ContinueRetrievePropertiesExRequestType {
	public $_this; //ManagedObjectReference
	public $token; //string

	function __construct($_this = null, $token = null) {
		$this->_this = $_this;
		$this->token = $token;
	}
}

class CancelRetrievePropertiesExRequestType {
	public $_this; //ManagedObjectReference
	public $token; //string

	function __construct($_this = null, $token = null) {
		$this->_this = $_this;
		$this->token = $token;
	}
}

class CreatePropertyCollectorRequestType {
	public $_this; //ManagedObjectReference

	function __construct($_this = null) {
		$this->_this = $_this;
	}
}

class DestroyPropertyCollectorRequestType {
	public $_this; //ManagedObjectReference

	function __construct($_this = null) {
		$this->_this = $_this;
	}
}

class AboutInfo {
	public $name; //string
	public $fullName; //string
	public $vendor; //string
	public $version; //string
	public $build; //string
	public $localeVersion; //string
	public $localeBuild; //string
	public $osType; //string
	public $productLineId; //string
	public $apiType; //string
	public $apiVersion; //string
	public $instanceUuid; //string
	public $licenseProductName; //string
	public $licenseProductVersion; //string

	function __construct($name = null, $fullName = null, $vendor = null, $version = null, $build = null, $localeVersion = null, $localeBuild = null, $osType = null, $productLineId = null, $apiType = null, $apiVersion = null, $instanceUuid = null, $licenseProductName = null, $licenseProductVersion = null) {
		$this->name = $name;
		$this->fullName = $fullName;
		$this->vendor = $vendor;
		$this->version = $version;
		$this->build = $build;
		$this->localeVersion = $localeVersion;
		$this->localeBuild = $localeBuild;
		$this->osType = $osType;
		$this->productLineId = $productLineId;
		$this->apiType = $apiType;
		$this->apiVersion = $apiVersion;
		$this->instanceUuid = $instanceUuid;
		$this->licenseProductName = $licenseProductName;
		$this->licenseProductVersion = $licenseProductVersion;
	}
}

class AuthorizationDescription {
	public $privilege; //ElementDescription
	public $privilegeGroup; //ElementDescription

	function __construct($privilege = null, $privilegeGroup = null) {
		$this->privilege = $privilege;
		$this->privilegeGroup = $privilegeGroup;
	}
}

class Permission {
	public $entity; //ManagedObjectReference
	public $principal; //string
	public $group; //boolean
	public $roleId; //int
	public $propagate; //boolean

	function __construct($entity = null, $principal = null, $group = null, $roleId = null, $propagate = null) {
		$this->entity = $entity;
		$this->principal = $principal;
		$this->group = $group;
		$this->roleId = $roleId;
		$this->propagate = $propagate;
	}
}

class ArrayOfPermission {
	public $Permission; //Permission

	function __construct($Permission = null) {
		$this->Permission = $Permission;
	}
}

class AuthorizationRole {
	public $roleId; //int
	public $system; //boolean
	public $name; //string
	public $info; //Description
	public $privilege; //string

	function __construct($roleId = null, $system = null, $name = null, $info = null, $privilege = null) {
		$this->roleId = $roleId;
		$this->system = $system;
		$this->name = $name;
		$this->info = $info;
		$this->privilege = $privilege;
	}
}

class ArrayOfAuthorizationRole {
	public $AuthorizationRole; //AuthorizationRole

	function __construct($AuthorizationRole = null) {
		$this->AuthorizationRole = $AuthorizationRole;
	}
}

class AuthorizationPrivilege {
	public $privId; //string
	public $onParent; //boolean
	public $name; //string
	public $privGroupName; //string

	function __construct($privId = null, $onParent = null, $name = null, $privGroupName = null) {
		$this->privId = $privId;
		$this->onParent = $onParent;
		$this->name = $name;
		$this->privGroupName = $privGroupName;
	}
}

class ArrayOfAuthorizationPrivilege {
	public $AuthorizationPrivilege; //AuthorizationPrivilege

	function __construct($AuthorizationPrivilege = null) {
		$this->AuthorizationPrivilege = $AuthorizationPrivilege;
	}
}

class BoolPolicy {
	public $value; //boolean

	function __construct($value = null) {
		$this->value = $value;
	}
}

class Capability {
	public $provisioningSupported; //boolean
	public $multiHostSupported; //boolean
	public $userShellAccessSupported; //boolean
	public $supportedEVCMode; //EVCMode

	function __construct($provisioningSupported = null, $multiHostSupported = null, $userShellAccessSupported = null, $supportedEVCMode = null) {
		$this->provisioningSupported = $provisioningSupported;
		$this->multiHostSupported = $multiHostSupported;
		$this->userShellAccessSupported = $userShellAccessSupported;
		$this->supportedEVCMode = $supportedEVCMode;
	}
}

class ClusterComputeResourceSummary {
	public $currentFailoverLevel; //int
	public $admissionControlInfo; //ClusterDasAdmissionControlInfo
	public $numVmotions; //int
	public $targetBalance; //int
	public $currentBalance; //int
	public $currentEVCModeKey; //string
	public $dasData; //ClusterDasData

	function __construct($currentFailoverLevel = null, $admissionControlInfo = null, $numVmotions = null, $targetBalance = null, $currentBalance = null, $currentEVCModeKey = null, $dasData = null) {
		$this->currentFailoverLevel = $currentFailoverLevel;
		$this->admissionControlInfo = $admissionControlInfo;
		$this->numVmotions = $numVmotions;
		$this->targetBalance = $targetBalance;
		$this->currentBalance = $currentBalance;
		$this->currentEVCModeKey = $currentEVCModeKey;
		$this->dasData = $dasData;
	}
}

class ComputeResourceSummary {
	public $totalCpu; //int
	public $totalMemory; //long
	public $numCpuCores; //short
	public $numCpuThreads; //short
	public $effectiveCpu; //int
	public $effectiveMemory; //long
	public $numHosts; //int
	public $numEffectiveHosts; //int
	public $overallStatus; //ManagedEntityStatus

	function __construct($totalCpu = null, $totalMemory = null, $numCpuCores = null, $numCpuThreads = null, $effectiveCpu = null, $effectiveMemory = null, $numHosts = null, $numEffectiveHosts = null, $overallStatus = null) {
		$this->totalCpu = $totalCpu;
		$this->totalMemory = $totalMemory;
		$this->numCpuCores = $numCpuCores;
		$this->numCpuThreads = $numCpuThreads;
		$this->effectiveCpu = $effectiveCpu;
		$this->effectiveMemory = $effectiveMemory;
		$this->numHosts = $numHosts;
		$this->numEffectiveHosts = $numEffectiveHosts;
		$this->overallStatus = $overallStatus;
	}
}

class ComputeResourceConfigInfo {
	public $vmSwapPlacement; //string
	public $spbmEnabled; //boolean

	function __construct($vmSwapPlacement = null, $spbmEnabled = null) {
		$this->vmSwapPlacement = $vmSwapPlacement;
		$this->spbmEnabled = $spbmEnabled;
	}
}

class ComputeResourceHostSPBMLicenseInfo {
	public $host; //ManagedObjectReference
	public $licenseState; //ComputeResourceHostSPBMLicenseInfoHostSPBMLicenseState

	function __construct($host = null, $licenseState = null) {
		$this->host = $host;
		$this->licenseState = $licenseState;
	}
}

class ArrayOfComputeResourceHostSPBMLicenseInfo {
	public $ComputeResourceHostSPBMLicenseInfo; //ComputeResourceHostSPBMLicenseInfo

	function __construct($ComputeResourceHostSPBMLicenseInfo = null) {
		$this->ComputeResourceHostSPBMLicenseInfo = $ComputeResourceHostSPBMLicenseInfo;
	}
}

class ComputeResourceConfigSpec {
	public $vmSwapPlacement; //string
	public $spbmEnabled; //boolean

	function __construct($vmSwapPlacement = null, $spbmEnabled = null) {
		$this->vmSwapPlacement = $vmSwapPlacement;
		$this->spbmEnabled = $spbmEnabled;
	}
}

class CustomFieldDef {
	public $key; //int
	public $name; //string
	public $type; //string
	public $managedObjectType; //string
	public $fieldDefPrivileges; //PrivilegePolicyDef
	public $fieldInstancePrivileges; //PrivilegePolicyDef

	function __construct($key = null, $name = null, $type = null, $managedObjectType = null, $fieldDefPrivileges = null, $fieldInstancePrivileges = null) {
		$this->key = $key;
		$this->name = $name;
		$this->type = $type;
		$this->managedObjectType = $managedObjectType;
		$this->fieldDefPrivileges = $fieldDefPrivileges;
		$this->fieldInstancePrivileges = $fieldInstancePrivileges;
	}
}

class ArrayOfCustomFieldDef {
	public $CustomFieldDef; //CustomFieldDef

	function __construct($CustomFieldDef = null) {
		$this->CustomFieldDef = $CustomFieldDef;
	}
}

class CustomFieldValue {
	public $key; //int

	function __construct($key = null) {
		$this->key = $key;
	}
}

class ArrayOfCustomFieldValue {
	public $CustomFieldValue; //CustomFieldValue

	function __construct($CustomFieldValue = null) {
		$this->CustomFieldValue = $CustomFieldValue;
	}
}

class CustomFieldStringValue {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class CustomizationSpecInfo {
	public $name; //string
	public $description; //string
	public $type; //string
	public $changeVersion; //string
	public $lastUpdateTime; //dateTime

	function __construct($name = null, $description = null, $type = null, $changeVersion = null, $lastUpdateTime = null) {
		$this->name = $name;
		$this->description = $description;
		$this->type = $type;
		$this->changeVersion = $changeVersion;
		$this->lastUpdateTime = $lastUpdateTime;
	}
}

class ArrayOfCustomizationSpecInfo {
	public $CustomizationSpecInfo; //CustomizationSpecInfo

	function __construct($CustomizationSpecInfo = null) {
		$this->CustomizationSpecInfo = $CustomizationSpecInfo;
	}
}

class CustomizationSpecItem {
	public $info; //CustomizationSpecInfo
	public $spec; //CustomizationSpec

	function __construct($info = null, $spec = null) {
		$this->info = $info;
		$this->spec = $spec;
	}
}

class DatastoreSummary {
	public $datastore; //ManagedObjectReference
	public $name; //string
	public $url; //string
	public $capacity; //long
	public $freeSpace; //long
	public $uncommitted; //long
	public $accessible; //boolean
	public $multipleHostAccess; //boolean
	public $type; //string
	public $maintenanceMode; //string

	function __construct($datastore = null, $name = null, $url = null, $capacity = null, $freeSpace = null, $uncommitted = null, $accessible = null, $multipleHostAccess = null, $type = null, $maintenanceMode = null) {
		$this->datastore = $datastore;
		$this->name = $name;
		$this->url = $url;
		$this->capacity = $capacity;
		$this->freeSpace = $freeSpace;
		$this->uncommitted = $uncommitted;
		$this->accessible = $accessible;
		$this->multipleHostAccess = $multipleHostAccess;
		$this->type = $type;
		$this->maintenanceMode = $maintenanceMode;
	}
}

class DatastoreInfo {
	public $name; //string
	public $url; //string
	public $freeSpace; //long
	public $maxFileSize; //long
	public $timestamp; //dateTime

	function __construct($name = null, $url = null, $freeSpace = null, $maxFileSize = null, $timestamp = null) {
		$this->name = $name;
		$this->url = $url;
		$this->freeSpace = $freeSpace;
		$this->maxFileSize = $maxFileSize;
		$this->timestamp = $timestamp;
	}
}

class DatastoreCapability {
	public $directoryHierarchySupported; //boolean
	public $rawDiskMappingsSupported; //boolean
	public $perFileThinProvisioningSupported; //boolean
	public $storageIORMSupported; //boolean

	function __construct($directoryHierarchySupported = null, $rawDiskMappingsSupported = null, $perFileThinProvisioningSupported = null, $storageIORMSupported = null) {
		$this->directoryHierarchySupported = $directoryHierarchySupported;
		$this->rawDiskMappingsSupported = $rawDiskMappingsSupported;
		$this->perFileThinProvisioningSupported = $perFileThinProvisioningSupported;
		$this->storageIORMSupported = $storageIORMSupported;
	}
}

class DatastoreHostMount {
	public $key; //ManagedObjectReference
	public $mountInfo; //HostMountInfo

	function __construct($key = null, $mountInfo = null) {
		$this->key = $key;
		$this->mountInfo = $mountInfo;
	}
}

class ArrayOfDatastoreHostMount {
	public $DatastoreHostMount; //DatastoreHostMount

	function __construct($DatastoreHostMount = null) {
		$this->DatastoreHostMount = $DatastoreHostMount;
	}
}

class DatastoreMountPathDatastorePair {
	public $oldMountPath; //string
	public $datastore; //ManagedObjectReference

	function __construct($oldMountPath = null, $datastore = null) {
		$this->oldMountPath = $oldMountPath;
		$this->datastore = $datastore;
	}
}

class ArrayOfDatastoreMountPathDatastorePair {
	public $DatastoreMountPathDatastorePair; //DatastoreMountPathDatastorePair

	function __construct($DatastoreMountPathDatastorePair = null) {
		$this->DatastoreMountPathDatastorePair = $DatastoreMountPathDatastorePair;
	}
}

class Description {
	public $label; //string
	public $summary; //string

	function __construct($label = null, $summary = null) {
		$this->label = $label;
		$this->summary = $summary;
	}
}

class DiagnosticManagerLogDescriptor {
	public $key; //string
	public $fileName; //string
	public $creator; //string
	public $format; //string
	public $mimeType; //string
	public $info; //Description

	function __construct($key = null, $fileName = null, $creator = null, $format = null, $mimeType = null, $info = null) {
		$this->key = $key;
		$this->fileName = $fileName;
		$this->creator = $creator;
		$this->format = $format;
		$this->mimeType = $mimeType;
		$this->info = $info;
	}
}

class ArrayOfDiagnosticManagerLogDescriptor {
	public $DiagnosticManagerLogDescriptor; //DiagnosticManagerLogDescriptor

	function __construct($DiagnosticManagerLogDescriptor = null) {
		$this->DiagnosticManagerLogDescriptor = $DiagnosticManagerLogDescriptor;
	}
}

class DiagnosticManagerLogHeader {
	public $lineStart; //int
	public $lineEnd; //int
	public $lineText; //string

	function __construct($lineStart = null, $lineEnd = null, $lineText = null) {
		$this->lineStart = $lineStart;
		$this->lineEnd = $lineEnd;
		$this->lineText = $lineText;
	}
}

class DiagnosticManagerBundleInfo {
	public $system; //ManagedObjectReference
	public $url; //string

	function __construct($system = null, $url = null) {
		$this->system = $system;
		$this->url = $url;
	}
}

class ArrayOfDiagnosticManagerBundleInfo {
	public $DiagnosticManagerBundleInfo; //DiagnosticManagerBundleInfo

	function __construct($DiagnosticManagerBundleInfo = null) {
		$this->DiagnosticManagerBundleInfo = $DiagnosticManagerBundleInfo;
	}
}

class DVSContactInfo {
	public $name; //string
	public $contact; //string

	function __construct($name = null, $contact = null) {
		$this->name = $name;
		$this->contact = $contact;
	}
}

class DVSNetworkResourceManagementCapability {
	public $networkResourceManagementSupported; //boolean
	public $networkResourcePoolHighShareValue; //int
	public $qosSupported; //boolean
	public $userDefinedNetworkResourcePoolsSupported; //boolean

	function __construct($networkResourceManagementSupported = null, $networkResourcePoolHighShareValue = null, $qosSupported = null, $userDefinedNetworkResourcePoolsSupported = null) {
		$this->networkResourceManagementSupported = $networkResourceManagementSupported;
		$this->networkResourcePoolHighShareValue = $networkResourcePoolHighShareValue;
		$this->qosSupported = $qosSupported;
		$this->userDefinedNetworkResourcePoolsSupported = $userDefinedNetworkResourcePoolsSupported;
	}
}

class DVSFeatureCapability {
	public $networkResourceManagementSupported; //boolean
	public $vmDirectPathGen2Supported; //boolean
	public $nicTeamingPolicy; //string
	public $networkResourcePoolHighShareValue; //int
	public $networkResourceManagementCapability; //DVSNetworkResourceManagementCapability

	function __construct($networkResourceManagementSupported = null, $vmDirectPathGen2Supported = null, $nicTeamingPolicy = null, $networkResourcePoolHighShareValue = null, $networkResourceManagementCapability = null) {
		$this->networkResourceManagementSupported = $networkResourceManagementSupported;
		$this->vmDirectPathGen2Supported = $vmDirectPathGen2Supported;
		$this->nicTeamingPolicy = $nicTeamingPolicy;
		$this->networkResourcePoolHighShareValue = $networkResourcePoolHighShareValue;
		$this->networkResourceManagementCapability = $networkResourceManagementCapability;
	}
}

class DVSCapability {
	public $dvsOperationSupported; //boolean
	public $dvPortGroupOperationSupported; //boolean
	public $dvPortOperationSupported; //boolean
	public $compatibleHostComponentProductInfo; //DistributedVirtualSwitchHostProductSpec
	public $featuresSupported; //DVSFeatureCapability

	function __construct($dvsOperationSupported = null, $dvPortGroupOperationSupported = null, $dvPortOperationSupported = null, $compatibleHostComponentProductInfo = null, $featuresSupported = null) {
		$this->dvsOperationSupported = $dvsOperationSupported;
		$this->dvPortGroupOperationSupported = $dvPortGroupOperationSupported;
		$this->dvPortOperationSupported = $dvPortOperationSupported;
		$this->compatibleHostComponentProductInfo = $compatibleHostComponentProductInfo;
		$this->featuresSupported = $featuresSupported;
	}
}

class DVSSummary {
	public $name; //string
	public $uuid; //string
	public $numPorts; //int
	public $productInfo; //DistributedVirtualSwitchProductSpec
	public $hostMember; //ManagedObjectReference
	public $vm; //ManagedObjectReference
	public $host; //ManagedObjectReference
	public $portgroupName; //string
	public $description; //string
	public $contact; //DVSContactInfo

	function __construct($name = null, $uuid = null, $numPorts = null, $productInfo = null, $hostMember = null, $vm = null, $host = null, $portgroupName = null, $description = null, $contact = null) {
		$this->name = $name;
		$this->uuid = $uuid;
		$this->numPorts = $numPorts;
		$this->productInfo = $productInfo;
		$this->hostMember = $hostMember;
		$this->vm = $vm;
		$this->host = $host;
		$this->portgroupName = $portgroupName;
		$this->description = $description;
		$this->contact = $contact;
	}
}

class DVSPolicy {
	public $autoPreInstallAllowed; //boolean
	public $autoUpgradeAllowed; //boolean
	public $partialUpgradeAllowed; //boolean

	function __construct($autoPreInstallAllowed = null, $autoUpgradeAllowed = null, $partialUpgradeAllowed = null) {
		$this->autoPreInstallAllowed = $autoPreInstallAllowed;
		$this->autoUpgradeAllowed = $autoUpgradeAllowed;
		$this->partialUpgradeAllowed = $partialUpgradeAllowed;
	}
}

class DVSUplinkPortPolicy {
}

class DVSNameArrayUplinkPortPolicy {
	public $uplinkPortName; //string

	function __construct($uplinkPortName = null) {
		$this->uplinkPortName = $uplinkPortName;
	}
}

class DVSConfigSpec {
	public $configVersion; //string
	public $name; //string
	public $numStandalonePorts; //int
	public $maxPorts; //int
	public $uplinkPortPolicy; //DVSUplinkPortPolicy
	public $uplinkPortgroup; //ManagedObjectReference
	public $defaultPortConfig; //DVPortSetting
	public $host; //DistributedVirtualSwitchHostMemberConfigSpec
	public $extensionKey; //string
	public $description; //string
	public $policy; //DVSPolicy
	public $vendorSpecificConfig; //DistributedVirtualSwitchKeyedOpaqueBlob
	public $contact; //DVSContactInfo
	public $switchIpAddress; //string

	function __construct($configVersion = null, $name = null, $numStandalonePorts = null, $maxPorts = null, $uplinkPortPolicy = null, $uplinkPortgroup = null, $defaultPortConfig = null, $host = null, $extensionKey = null, $description = null, $policy = null, $vendorSpecificConfig = null, $contact = null, $switchIpAddress = null) {
		$this->configVersion = $configVersion;
		$this->name = $name;
		$this->numStandalonePorts = $numStandalonePorts;
		$this->maxPorts = $maxPorts;
		$this->uplinkPortPolicy = $uplinkPortPolicy;
		$this->uplinkPortgroup = $uplinkPortgroup;
		$this->defaultPortConfig = $defaultPortConfig;
		$this->host = $host;
		$this->extensionKey = $extensionKey;
		$this->description = $description;
		$this->policy = $policy;
		$this->vendorSpecificConfig = $vendorSpecificConfig;
		$this->contact = $contact;
		$this->switchIpAddress = $switchIpAddress;
	}
}

class DVSCreateSpec {
	public $configSpec; //DVSConfigSpec
	public $productInfo; //DistributedVirtualSwitchProductSpec
	public $capability; //DVSCapability

	function __construct($configSpec = null, $productInfo = null, $capability = null) {
		$this->configSpec = $configSpec;
		$this->productInfo = $productInfo;
		$this->capability = $capability;
	}
}

class DVSConfigInfo {
	public $uuid; //string
	public $name; //string
	public $numStandalonePorts; //int
	public $numPorts; //int
	public $maxPorts; //int
	public $uplinkPortPolicy; //DVSUplinkPortPolicy
	public $uplinkPortgroup; //ManagedObjectReference
	public $defaultPortConfig; //DVPortSetting
	public $host; //DistributedVirtualSwitchHostMember
	public $productInfo; //DistributedVirtualSwitchProductSpec
	public $targetInfo; //DistributedVirtualSwitchProductSpec
	public $extensionKey; //string
	public $vendorSpecificConfig; //DistributedVirtualSwitchKeyedOpaqueBlob
	public $policy; //DVSPolicy
	public $description; //string
	public $configVersion; //string
	public $contact; //DVSContactInfo
	public $switchIpAddress; //string
	public $createTime; //dateTime
	public $networkResourceManagementEnabled; //boolean

	function __construct($uuid = null, $name = null, $numStandalonePorts = null, $numPorts = null, $maxPorts = null, $uplinkPortPolicy = null, $uplinkPortgroup = null, $defaultPortConfig = null, $host = null, $productInfo = null, $targetInfo = null, $extensionKey = null, $vendorSpecificConfig = null, $policy = null, $description = null, $configVersion = null, $contact = null, $switchIpAddress = null, $createTime = null, $networkResourceManagementEnabled = null) {
		$this->uuid = $uuid;
		$this->name = $name;
		$this->numStandalonePorts = $numStandalonePorts;
		$this->numPorts = $numPorts;
		$this->maxPorts = $maxPorts;
		$this->uplinkPortPolicy = $uplinkPortPolicy;
		$this->uplinkPortgroup = $uplinkPortgroup;
		$this->defaultPortConfig = $defaultPortConfig;
		$this->host = $host;
		$this->productInfo = $productInfo;
		$this->targetInfo = $targetInfo;
		$this->extensionKey = $extensionKey;
		$this->vendorSpecificConfig = $vendorSpecificConfig;
		$this->policy = $policy;
		$this->description = $description;
		$this->configVersion = $configVersion;
		$this->contact = $contact;
		$this->switchIpAddress = $switchIpAddress;
		$this->createTime = $createTime;
		$this->networkResourceManagementEnabled = $networkResourceManagementEnabled;
	}
}

class EVCMode {
	public $guaranteedCPUFeatures; //HostCpuIdInfo
	public $vendor; //string
	public $track; //string
	public $vendorTier; //int

	function __construct($guaranteedCPUFeatures = null, $vendor = null, $track = null, $vendorTier = null) {
		$this->guaranteedCPUFeatures = $guaranteedCPUFeatures;
		$this->vendor = $vendor;
		$this->track = $track;
		$this->vendorTier = $vendorTier;
	}
}

class ArrayOfEVCMode {
	public $EVCMode; //EVCMode

	function __construct($EVCMode = null) {
		$this->EVCMode = $EVCMode;
	}
}

class ElementDescription {
	public $key; //string

	function __construct($key = null) {
		$this->key = $key;
	}
}

class ArrayOfElementDescription {
	public $ElementDescription; //ElementDescription

	function __construct($ElementDescription = null) {
		$this->ElementDescription = $ElementDescription;
	}
}

class EnumDescription {
	public $key; //string
	public $tags; //ElementDescription

	function __construct($key = null, $tags = null) {
		$this->key = $key;
		$this->tags = $tags;
	}
}

class ArrayOfEnumDescription {
	public $EnumDescription; //EnumDescription

	function __construct($EnumDescription = null) {
		$this->EnumDescription = $EnumDescription;
	}
}

class ExtendedDescription {
	public $messageCatalogKeyPrefix; //string
	public $messageArg; //KeyAnyValue

	function __construct($messageCatalogKeyPrefix = null, $messageArg = null) {
		$this->messageCatalogKeyPrefix = $messageCatalogKeyPrefix;
		$this->messageArg = $messageArg;
	}
}

class ExtendedElementDescription {
	public $messageCatalogKeyPrefix; //string
	public $messageArg; //KeyAnyValue

	function __construct($messageCatalogKeyPrefix = null, $messageArg = null) {
		$this->messageCatalogKeyPrefix = $messageCatalogKeyPrefix;
		$this->messageArg = $messageArg;
	}
}

class ExtensionServerInfo {
	public $url; //string
	public $description; //Description
	public $company; //string
	public $type; //string
	public $adminEmail; //string
	public $serverThumbprint; //string

	function __construct($url = null, $description = null, $company = null, $type = null, $adminEmail = null, $serverThumbprint = null) {
		$this->url = $url;
		$this->description = $description;
		$this->company = $company;
		$this->type = $type;
		$this->adminEmail = $adminEmail;
		$this->serverThumbprint = $serverThumbprint;
	}
}

class ArrayOfExtensionServerInfo {
	public $ExtensionServerInfo; //ExtensionServerInfo

	function __construct($ExtensionServerInfo = null) {
		$this->ExtensionServerInfo = $ExtensionServerInfo;
	}
}

class ExtensionClientInfo {
	public $version; //string
	public $description; //Description
	public $company; //string
	public $type; //string
	public $url; //string

	function __construct($version = null, $description = null, $company = null, $type = null, $url = null) {
		$this->version = $version;
		$this->description = $description;
		$this->company = $company;
		$this->type = $type;
		$this->url = $url;
	}
}

class ArrayOfExtensionClientInfo {
	public $ExtensionClientInfo; //ExtensionClientInfo

	function __construct($ExtensionClientInfo = null) {
		$this->ExtensionClientInfo = $ExtensionClientInfo;
	}
}

class ExtensionTaskTypeInfo {
	public $taskID; //string

	function __construct($taskID = null) {
		$this->taskID = $taskID;
	}
}

class ArrayOfExtensionTaskTypeInfo {
	public $ExtensionTaskTypeInfo; //ExtensionTaskTypeInfo

	function __construct($ExtensionTaskTypeInfo = null) {
		$this->ExtensionTaskTypeInfo = $ExtensionTaskTypeInfo;
	}
}

class ExtensionEventTypeInfo {
	public $eventID; //string
	public $eventTypeSchema; //string

	function __construct($eventID = null, $eventTypeSchema = null) {
		$this->eventID = $eventID;
		$this->eventTypeSchema = $eventTypeSchema;
	}
}

class ArrayOfExtensionEventTypeInfo {
	public $ExtensionEventTypeInfo; //ExtensionEventTypeInfo

	function __construct($ExtensionEventTypeInfo = null) {
		$this->ExtensionEventTypeInfo = $ExtensionEventTypeInfo;
	}
}

class ExtensionFaultTypeInfo {
	public $faultID; //string

	function __construct($faultID = null) {
		$this->faultID = $faultID;
	}
}

class ArrayOfExtensionFaultTypeInfo {
	public $ExtensionFaultTypeInfo; //ExtensionFaultTypeInfo

	function __construct($ExtensionFaultTypeInfo = null) {
		$this->ExtensionFaultTypeInfo = $ExtensionFaultTypeInfo;
	}
}

class ExtensionPrivilegeInfo {
	public $privID; //string
	public $privGroupName; //string

	function __construct($privID = null, $privGroupName = null) {
		$this->privID = $privID;
		$this->privGroupName = $privGroupName;
	}
}

class ArrayOfExtensionPrivilegeInfo {
	public $ExtensionPrivilegeInfo; //ExtensionPrivilegeInfo

	function __construct($ExtensionPrivilegeInfo = null) {
		$this->ExtensionPrivilegeInfo = $ExtensionPrivilegeInfo;
	}
}

class ExtensionResourceInfo {
	public $locale; //string
	public $module; //string
	public $data; //KeyValue

	function __construct($locale = null, $module = null, $data = null) {
		$this->locale = $locale;
		$this->module = $module;
		$this->data = $data;
	}
}

class ArrayOfExtensionResourceInfo {
	public $ExtensionResourceInfo; //ExtensionResourceInfo

	function __construct($ExtensionResourceInfo = null) {
		$this->ExtensionResourceInfo = $ExtensionResourceInfo;
	}
}

class ExtensionHealthInfo {
	public $url; //string

	function __construct($url = null) {
		$this->url = $url;
	}
}

class ExtensionOvfConsumerInfo {
	public $callbackUrl; //string
	public $sectionType; //string

	function __construct($callbackUrl = null, $sectionType = null) {
		$this->callbackUrl = $callbackUrl;
		$this->sectionType = $sectionType;
	}
}

class Extension {
	public $description; //Description
	public $key; //string
	public $company; //string
	public $type; //string
	public $version; //string
	public $subjectName; //string
	public $server; //ExtensionServerInfo
	public $client; //ExtensionClientInfo
	public $taskList; //ExtensionTaskTypeInfo
	public $eventList; //ExtensionEventTypeInfo
	public $faultList; //ExtensionFaultTypeInfo
	public $privilegeList; //ExtensionPrivilegeInfo
	public $resourceList; //ExtensionResourceInfo
	public $lastHeartbeatTime; //dateTime
	public $healthInfo; //ExtensionHealthInfo
	public $ovfConsumerInfo; //ExtensionOvfConsumerInfo
	public $extendedProductInfo; //ExtExtendedProductInfo
	public $managedEntityInfo; //ExtManagedEntityInfo
	public $shownInSolutionManager; //boolean
	public $solutionManagerInfo; //ExtSolutionManagerInfo

	function __construct($description = null, $key = null, $company = null, $type = null, $version = null, $subjectName = null, $server = null, $client = null, $taskList = null, $eventList = null, $faultList = null, $privilegeList = null, $resourceList = null, $lastHeartbeatTime = null, $healthInfo = null, $ovfConsumerInfo = null, $extendedProductInfo = null, $managedEntityInfo = null, $shownInSolutionManager = null, $solutionManagerInfo = null) {
		$this->description = $description;
		$this->key = $key;
		$this->company = $company;
		$this->type = $type;
		$this->version = $version;
		$this->subjectName = $subjectName;
		$this->server = $server;
		$this->client = $client;
		$this->taskList = $taskList;
		$this->eventList = $eventList;
		$this->faultList = $faultList;
		$this->privilegeList = $privilegeList;
		$this->resourceList = $resourceList;
		$this->lastHeartbeatTime = $lastHeartbeatTime;
		$this->healthInfo = $healthInfo;
		$this->ovfConsumerInfo = $ovfConsumerInfo;
		$this->extendedProductInfo = $extendedProductInfo;
		$this->managedEntityInfo = $managedEntityInfo;
		$this->shownInSolutionManager = $shownInSolutionManager;
		$this->solutionManagerInfo = $solutionManagerInfo;
	}
}

class ArrayOfExtension {
	public $Extension; //Extension

	function __construct($Extension = null) {
		$this->Extension = $Extension;
	}
}

class ReplicationVmProgressInfo {
	public $progress; //int
	public $bytesTransferred; //long
	public $bytesToTransfer; //long
	public $checksumTotalBytes; //long
	public $checksumComparedBytes; //long

	function __construct($progress = null, $bytesTransferred = null, $bytesToTransfer = null, $checksumTotalBytes = null, $checksumComparedBytes = null) {
		$this->progress = $progress;
		$this->bytesTransferred = $bytesTransferred;
		$this->bytesToTransfer = $bytesToTransfer;
		$this->checksumTotalBytes = $checksumTotalBytes;
		$this->checksumComparedBytes = $checksumComparedBytes;
	}
}

class HbrManagerReplicationVmInfo {
	public $state; //string
	public $progressInfo; //ReplicationVmProgressInfo
	public $imageId; //string
	public $lastError; //LocalizedMethodFault

	function __construct($state = null, $progressInfo = null, $imageId = null, $lastError = null) {
		$this->state = $state;
		$this->progressInfo = $progressInfo;
		$this->imageId = $imageId;
		$this->lastError = $lastError;
	}
}

class HostServiceTicket {
	public $host; //string
	public $port; //int
	public $sslThumbprint; //string
	public $service; //string
	public $serviceVersion; //string
	public $sessionId; //string

	function __construct($host = null, $port = null, $sslThumbprint = null, $service = null, $serviceVersion = null, $sessionId = null) {
		$this->host = $host;
		$this->port = $port;
		$this->sslThumbprint = $sslThumbprint;
		$this->service = $service;
		$this->serviceVersion = $serviceVersion;
		$this->sessionId = $sessionId;
	}
}

class HostSystemReconnectSpec {
	public $syncState; //boolean

	function __construct($syncState = null) {
		$this->syncState = $syncState;
	}
}

class HttpNfcLeaseDatastoreLeaseInfo {
	public $datastoreKey; //string
	public $hosts; //HttpNfcLeaseHostInfo

	function __construct($datastoreKey = null, $hosts = null) {
		$this->datastoreKey = $datastoreKey;
		$this->hosts = $hosts;
	}
}

class ArrayOfHttpNfcLeaseDatastoreLeaseInfo {
	public $HttpNfcLeaseDatastoreLeaseInfo; //HttpNfcLeaseDatastoreLeaseInfo

	function __construct($HttpNfcLeaseDatastoreLeaseInfo = null) {
		$this->HttpNfcLeaseDatastoreLeaseInfo = $HttpNfcLeaseDatastoreLeaseInfo;
	}
}

class HttpNfcLeaseHostInfo {
	public $url; //string
	public $sslThumbprint; //string

	function __construct($url = null, $sslThumbprint = null) {
		$this->url = $url;
		$this->sslThumbprint = $sslThumbprint;
	}
}

class ArrayOfHttpNfcLeaseHostInfo {
	public $HttpNfcLeaseHostInfo; //HttpNfcLeaseHostInfo

	function __construct($HttpNfcLeaseHostInfo = null) {
		$this->HttpNfcLeaseHostInfo = $HttpNfcLeaseHostInfo;
	}
}

class HttpNfcLeaseInfo {
	public $lease; //ManagedObjectReference
	public $entity; //ManagedObjectReference
	public $deviceUrl; //HttpNfcLeaseDeviceUrl
	public $totalDiskCapacityInKB; //long
	public $leaseTimeout; //int
	public $hostMap; //HttpNfcLeaseDatastoreLeaseInfo

	function __construct($lease = null, $entity = null, $deviceUrl = null, $totalDiskCapacityInKB = null, $leaseTimeout = null, $hostMap = null) {
		$this->lease = $lease;
		$this->entity = $entity;
		$this->deviceUrl = $deviceUrl;
		$this->totalDiskCapacityInKB = $totalDiskCapacityInKB;
		$this->leaseTimeout = $leaseTimeout;
		$this->hostMap = $hostMap;
	}
}

class HttpNfcLeaseDeviceUrl {
	public $key; //string
	public $importKey; //string
	public $url; //string
	public $sslThumbprint; //string
	public $disk; //boolean
	public $targetId; //string
	public $datastoreKey; //string
	public $fileSize; //long

	function __construct($key = null, $importKey = null, $url = null, $sslThumbprint = null, $disk = null, $targetId = null, $datastoreKey = null, $fileSize = null) {
		$this->key = $key;
		$this->importKey = $importKey;
		$this->url = $url;
		$this->sslThumbprint = $sslThumbprint;
		$this->disk = $disk;
		$this->targetId = $targetId;
		$this->datastoreKey = $datastoreKey;
		$this->fileSize = $fileSize;
	}
}

class ArrayOfHttpNfcLeaseDeviceUrl {
	public $HttpNfcLeaseDeviceUrl; //HttpNfcLeaseDeviceUrl

	function __construct($HttpNfcLeaseDeviceUrl = null) {
		$this->HttpNfcLeaseDeviceUrl = $HttpNfcLeaseDeviceUrl;
	}
}

class HttpNfcLeaseManifestEntry {
	public $key; //string
	public $sha1; //string
	public $size; //long
	public $disk; //boolean
	public $capacity; //long
	public $populatedSize; //long

	function __construct($key = null, $sha1 = null, $size = null, $disk = null, $capacity = null, $populatedSize = null) {
		$this->key = $key;
		$this->sha1 = $sha1;
		$this->size = $size;
		$this->disk = $disk;
		$this->capacity = $capacity;
		$this->populatedSize = $populatedSize;
	}
}

class ArrayOfHttpNfcLeaseManifestEntry {
	public $HttpNfcLeaseManifestEntry; //HttpNfcLeaseManifestEntry

	function __construct($HttpNfcLeaseManifestEntry = null) {
		$this->HttpNfcLeaseManifestEntry = $HttpNfcLeaseManifestEntry;
	}
}

class ImportSpec {
	public $entityConfig; //VAppEntityConfigInfo
	public $instantiationOst; //OvfConsumerOstNode

	function __construct($entityConfig = null, $instantiationOst = null) {
		$this->entityConfig = $entityConfig;
		$this->instantiationOst = $instantiationOst;
	}
}

class ArrayOfImportSpec {
	public $ImportSpec; //ImportSpec

	function __construct($ImportSpec = null) {
		$this->ImportSpec = $ImportSpec;
	}
}

class InheritablePolicy {
	public $inherited; //boolean

	function __construct($inherited = null) {
		$this->inherited = $inherited;
	}
}

class IntPolicy {
	public $value; //int

	function __construct($value = null) {
		$this->value = $value;
	}
}

class KeyValue {
	public $key; //string
	public $value; //string

	function __construct($key = null, $value = null) {
		$this->key = $key;
		$this->value = $value;
	}
}

class ArrayOfKeyValue {
	public $KeyValue; //KeyValue

	function __construct($KeyValue = null) {
		$this->KeyValue = $KeyValue;
	}
}

class LicenseAssignmentManagerLicenseAssignment {
	public $entityId; //string
	public $scope; //string
	public $entityDisplayName; //string
	public $assignedLicense; //LicenseManagerLicenseInfo
	public $properties; //KeyAnyValue

	function __construct($entityId = null, $scope = null, $entityDisplayName = null, $assignedLicense = null, $properties = null) {
		$this->entityId = $entityId;
		$this->scope = $scope;
		$this->entityDisplayName = $entityDisplayName;
		$this->assignedLicense = $assignedLicense;
		$this->properties = $properties;
	}
}

class ArrayOfLicenseAssignmentManagerLicenseAssignment {
	public $LicenseAssignmentManagerLicenseAssignment; //LicenseAssignmentManagerLicenseAssignment

	function __construct($LicenseAssignmentManagerLicenseAssignment = null) {
		$this->LicenseAssignmentManagerLicenseAssignment = $LicenseAssignmentManagerLicenseAssignment;
	}
}

class LicenseSource {
}

class LicenseServerSource {
	public $licenseServer; //string

	function __construct($licenseServer = null) {
		$this->licenseServer = $licenseServer;
	}
}

class LocalLicenseSource {
	public $licenseKeys; //string

	function __construct($licenseKeys = null) {
		$this->licenseKeys = $licenseKeys;
	}
}

class EvaluationLicenseSource {
	public $remainingHours; //long

	function __construct($remainingHours = null) {
		$this->remainingHours = $remainingHours;
	}
}

class LicenseFeatureInfo {
	public $key; //string
	public $featureName; //string
	public $featureDescription; //string
	public $state; //LicenseFeatureInfoState
	public $costUnit; //string
	public $sourceRestriction; //string
	public $dependentKey; //string
	public $edition; //boolean
	public $expiresOn; //dateTime

	function __construct($key = null, $featureName = null, $featureDescription = null, $state = null, $costUnit = null, $sourceRestriction = null, $dependentKey = null, $edition = null, $expiresOn = null) {
		$this->key = $key;
		$this->featureName = $featureName;
		$this->featureDescription = $featureDescription;
		$this->state = $state;
		$this->costUnit = $costUnit;
		$this->sourceRestriction = $sourceRestriction;
		$this->dependentKey = $dependentKey;
		$this->edition = $edition;
		$this->expiresOn = $expiresOn;
	}
}

class ArrayOfLicenseFeatureInfo {
	public $LicenseFeatureInfo; //LicenseFeatureInfo

	function __construct($LicenseFeatureInfo = null) {
		$this->LicenseFeatureInfo = $LicenseFeatureInfo;
	}
}

class LicenseReservationInfo {
	public $key; //string
	public $state; //LicenseReservationInfoState
	public $required; //int

	function __construct($key = null, $state = null, $required = null) {
		$this->key = $key;
		$this->state = $state;
		$this->required = $required;
	}
}

class ArrayOfLicenseReservationInfo {
	public $LicenseReservationInfo; //LicenseReservationInfo

	function __construct($LicenseReservationInfo = null) {
		$this->LicenseReservationInfo = $LicenseReservationInfo;
	}
}

class LicenseAvailabilityInfo {
	public $feature; //LicenseFeatureInfo
	public $total; //int
	public $available; //int

	function __construct($feature = null, $total = null, $available = null) {
		$this->feature = $feature;
		$this->total = $total;
		$this->available = $available;
	}
}

class ArrayOfLicenseAvailabilityInfo {
	public $LicenseAvailabilityInfo; //LicenseAvailabilityInfo

	function __construct($LicenseAvailabilityInfo = null) {
		$this->LicenseAvailabilityInfo = $LicenseAvailabilityInfo;
	}
}

class LicenseDiagnostics {
	public $sourceLastChanged; //dateTime
	public $sourceLost; //string
	public $sourceLatency; //float
	public $licenseRequests; //string
	public $licenseRequestFailures; //string
	public $licenseFeatureUnknowns; //string
	public $opState; //LicenseManagerState
	public $lastStatusUpdate; //dateTime
	public $opFailureMessage; //string

	function __construct($sourceLastChanged = null, $sourceLost = null, $sourceLatency = null, $licenseRequests = null, $licenseRequestFailures = null, $licenseFeatureUnknowns = null, $opState = null, $lastStatusUpdate = null, $opFailureMessage = null) {
		$this->sourceLastChanged = $sourceLastChanged;
		$this->sourceLost = $sourceLost;
		$this->sourceLatency = $sourceLatency;
		$this->licenseRequests = $licenseRequests;
		$this->licenseRequestFailures = $licenseRequestFailures;
		$this->licenseFeatureUnknowns = $licenseFeatureUnknowns;
		$this->opState = $opState;
		$this->lastStatusUpdate = $lastStatusUpdate;
		$this->opFailureMessage = $opFailureMessage;
	}
}

class LicenseUsageInfo {
	public $source; //LicenseSource
	public $sourceAvailable; //boolean
	public $reservationInfo; //LicenseReservationInfo
	public $featureInfo; //LicenseFeatureInfo

	function __construct($source = null, $sourceAvailable = null, $reservationInfo = null, $featureInfo = null) {
		$this->source = $source;
		$this->sourceAvailable = $sourceAvailable;
		$this->reservationInfo = $reservationInfo;
		$this->featureInfo = $featureInfo;
	}
}

class LicenseManagerEvaluationInfo {
	public $properties; //KeyAnyValue

	function __construct($properties = null) {
		$this->properties = $properties;
	}
}

class HostLicensableResourceInfo {
	public $resource; //KeyAnyValue

	function __construct($resource = null) {
		$this->resource = $resource;
	}
}

class LicenseManagerLicenseInfo {
	public $licenseKey; //string
	public $editionKey; //string
	public $name; //string
	public $total; //int
	public $used; //int
	public $costUnit; //string
	public $properties; //KeyAnyValue
	public $labels; //KeyValue

	function __construct($licenseKey = null, $editionKey = null, $name = null, $total = null, $used = null, $costUnit = null, $properties = null, $labels = null) {
		$this->licenseKey = $licenseKey;
		$this->editionKey = $editionKey;
		$this->name = $name;
		$this->total = $total;
		$this->used = $used;
		$this->costUnit = $costUnit;
		$this->properties = $properties;
		$this->labels = $labels;
	}
}

class ArrayOfLicenseManagerLicenseInfo {
	public $LicenseManagerLicenseInfo; //LicenseManagerLicenseInfo

	function __construct($LicenseManagerLicenseInfo = null) {
		$this->LicenseManagerLicenseInfo = $LicenseManagerLicenseInfo;
	}
}

class LocalizationManagerMessageCatalog {
	public $moduleName; //string
	public $catalogName; //string
	public $locale; //string
	public $catalogUri; //string
	public $lastModified; //dateTime
	public $md5sum; //string
	public $version; //string

	function __construct($moduleName = null, $catalogName = null, $locale = null, $catalogUri = null, $lastModified = null, $md5sum = null, $version = null) {
		$this->moduleName = $moduleName;
		$this->catalogName = $catalogName;
		$this->locale = $locale;
		$this->catalogUri = $catalogUri;
		$this->lastModified = $lastModified;
		$this->md5sum = $md5sum;
		$this->version = $version;
	}
}

class ArrayOfLocalizationManagerMessageCatalog {
	public $LocalizationManagerMessageCatalog; //LocalizationManagerMessageCatalog

	function __construct($LocalizationManagerMessageCatalog = null) {
		$this->LocalizationManagerMessageCatalog = $LocalizationManagerMessageCatalog;
	}
}

class LongPolicy {
	public $value; //long

	function __construct($value = null) {
		$this->value = $value;
	}
}

class MethodDescription {
	public $key; //string

	function __construct($key = null) {
		$this->key = $key;
	}
}

class NetworkSummary {
	public $network; //ManagedObjectReference
	public $name; //string
	public $accessible; //boolean
	public $ipPoolName; //string

	function __construct($network = null, $name = null, $accessible = null, $ipPoolName = null) {
		$this->network = $network;
		$this->name = $name;
		$this->accessible = $accessible;
		$this->ipPoolName = $ipPoolName;
	}
}

class NumericRange {
	public $start; //int
	public $end; //int

	function __construct($start = null, $end = null) {
		$this->start = $start;
		$this->end = $end;
	}
}

class ArrayOfNumericRange {
	public $NumericRange; //NumericRange

	function __construct($NumericRange = null) {
		$this->NumericRange = $NumericRange;
	}
}

class OvfConsumerOvfSection {
	public $lineNumber; //int
	public $xml; //string

	function __construct($lineNumber = null, $xml = null) {
		$this->lineNumber = $lineNumber;
		$this->xml = $xml;
	}
}

class ArrayOfOvfConsumerOvfSection {
	public $OvfConsumerOvfSection; //OvfConsumerOvfSection

	function __construct($OvfConsumerOvfSection = null) {
		$this->OvfConsumerOvfSection = $OvfConsumerOvfSection;
	}
}

class OvfConsumerOstNode {
	public $id; //string
	public $type; //string
	public $section; //OvfConsumerOvfSection
	public $child; //OvfConsumerOstNode
	public $entity; //ManagedObjectReference

	function __construct($id = null, $type = null, $section = null, $child = null, $entity = null) {
		$this->id = $id;
		$this->type = $type;
		$this->section = $section;
		$this->child = $child;
		$this->entity = $entity;
	}
}

class ArrayOfOvfConsumerOstNode {
	public $OvfConsumerOstNode; //OvfConsumerOstNode

	function __construct($OvfConsumerOstNode = null) {
		$this->OvfConsumerOstNode = $OvfConsumerOstNode;
	}
}

class OvfDeploymentOption {
	public $key; //string
	public $label; //string
	public $description; //string

	function __construct($key = null, $label = null, $description = null) {
		$this->key = $key;
		$this->label = $label;
		$this->description = $description;
	}
}

class ArrayOfOvfDeploymentOption {
	public $OvfDeploymentOption; //OvfDeploymentOption

	function __construct($OvfDeploymentOption = null) {
		$this->OvfDeploymentOption = $OvfDeploymentOption;
	}
}

class OvfManagerCommonParams {
	public $locale; //string
	public $deploymentOption; //string
	public $msgBundle; //KeyValue

	function __construct($locale = null, $deploymentOption = null, $msgBundle = null) {
		$this->locale = $locale;
		$this->deploymentOption = $deploymentOption;
		$this->msgBundle = $msgBundle;
	}
}

class OvfValidateHostParams {
}

class OvfValidateHostResult {
	public $downloadSize; //long
	public $flatDeploymentSize; //long
	public $sparseDeploymentSize; //long
	public $error; //LocalizedMethodFault
	public $warning; //LocalizedMethodFault
	public $supportedDiskProvisioning; //string

	function __construct($downloadSize = null, $flatDeploymentSize = null, $sparseDeploymentSize = null, $error = null, $warning = null, $supportedDiskProvisioning = null) {
		$this->downloadSize = $downloadSize;
		$this->flatDeploymentSize = $flatDeploymentSize;
		$this->sparseDeploymentSize = $sparseDeploymentSize;
		$this->error = $error;
		$this->warning = $warning;
		$this->supportedDiskProvisioning = $supportedDiskProvisioning;
	}
}

class OvfParseDescriptorParams {
}

class OvfParseDescriptorResult {
	public $eula; //string
	public $network; //OvfNetworkInfo
	public $ipAllocationScheme; //string
	public $ipProtocols; //string
	public $property; //VAppPropertyInfo
	public $productInfo; //VAppProductInfo
	public $annotation; //string
	public $approximateDownloadSize; //long
	public $approximateFlatDeploymentSize; //long
	public $approximateSparseDeploymentSize; //long
	public $defaultEntityName; //string
	public $virtualApp; //boolean
	public $deploymentOption; //OvfDeploymentOption
	public $defaultDeploymentOption; //string
	public $entityName; //KeyValue
	public $annotatedOst; //OvfConsumerOstNode
	public $error; //LocalizedMethodFault
	public $warning; //LocalizedMethodFault

	function __construct($eula = null, $network = null, $ipAllocationScheme = null, $ipProtocols = null, $property = null, $productInfo = null, $annotation = null, $approximateDownloadSize = null, $approximateFlatDeploymentSize = null, $approximateSparseDeploymentSize = null, $defaultEntityName = null, $virtualApp = null, $deploymentOption = null, $defaultDeploymentOption = null, $entityName = null, $annotatedOst = null, $error = null, $warning = null) {
		$this->eula = $eula;
		$this->network = $network;
		$this->ipAllocationScheme = $ipAllocationScheme;
		$this->ipProtocols = $ipProtocols;
		$this->property = $property;
		$this->productInfo = $productInfo;
		$this->annotation = $annotation;
		$this->approximateDownloadSize = $approximateDownloadSize;
		$this->approximateFlatDeploymentSize = $approximateFlatDeploymentSize;
		$this->approximateSparseDeploymentSize = $approximateSparseDeploymentSize;
		$this->defaultEntityName = $defaultEntityName;
		$this->virtualApp = $virtualApp;
		$this->deploymentOption = $deploymentOption;
		$this->defaultDeploymentOption = $defaultDeploymentOption;
		$this->entityName = $entityName;
		$this->annotatedOst = $annotatedOst;
		$this->error = $error;
		$this->warning = $warning;
	}
}

class OvfNetworkInfo {
	public $name; //string
	public $description; //string

	function __construct($name = null, $description = null) {
		$this->name = $name;
		$this->description = $description;
	}
}

class ArrayOfOvfNetworkInfo {
	public $OvfNetworkInfo; //OvfNetworkInfo

	function __construct($OvfNetworkInfo = null) {
		$this->OvfNetworkInfo = $OvfNetworkInfo;
	}
}

class OvfCreateImportSpecParams {
	public $entityName; //string
	public $hostSystem; //ManagedObjectReference
	public $networkMapping; //OvfNetworkMapping
	public $ipAllocationPolicy; //string
	public $ipProtocol; //string
	public $propertyMapping; //KeyValue
	public $resourceMapping; //OvfResourceMap
	public $diskProvisioning; //string
	public $instantiationOst; //OvfConsumerOstNode

	function __construct($entityName = null, $hostSystem = null, $networkMapping = null, $ipAllocationPolicy = null, $ipProtocol = null, $propertyMapping = null, $resourceMapping = null, $diskProvisioning = null, $instantiationOst = null) {
		$this->entityName = $entityName;
		$this->hostSystem = $hostSystem;
		$this->networkMapping = $networkMapping;
		$this->ipAllocationPolicy = $ipAllocationPolicy;
		$this->ipProtocol = $ipProtocol;
		$this->propertyMapping = $propertyMapping;
		$this->resourceMapping = $resourceMapping;
		$this->diskProvisioning = $diskProvisioning;
		$this->instantiationOst = $instantiationOst;
	}
}

class OvfResourceMap {
	public $source; //string
	public $parent; //ManagedObjectReference
	public $resourceSpec; //ResourceConfigSpec
	public $datastore; //ManagedObjectReference

	function __construct($source = null, $parent = null, $resourceSpec = null, $datastore = null) {
		$this->source = $source;
		$this->parent = $parent;
		$this->resourceSpec = $resourceSpec;
		$this->datastore = $datastore;
	}
}

class ArrayOfOvfResourceMap {
	public $OvfResourceMap; //OvfResourceMap

	function __construct($OvfResourceMap = null) {
		$this->OvfResourceMap = $OvfResourceMap;
	}
}

class OvfNetworkMapping {
	public $name; //string
	public $network; //ManagedObjectReference

	function __construct($name = null, $network = null) {
		$this->name = $name;
		$this->network = $network;
	}
}

class ArrayOfOvfNetworkMapping {
	public $OvfNetworkMapping; //OvfNetworkMapping

	function __construct($OvfNetworkMapping = null) {
		$this->OvfNetworkMapping = $OvfNetworkMapping;
	}
}

class OvfCreateImportSpecResult {
	public $importSpec; //ImportSpec
	public $fileItem; //OvfFileItem
	public $warning; //LocalizedMethodFault
	public $error; //LocalizedMethodFault

	function __construct($importSpec = null, $fileItem = null, $warning = null, $error = null) {
		$this->importSpec = $importSpec;
		$this->fileItem = $fileItem;
		$this->warning = $warning;
		$this->error = $error;
	}
}

class OvfFileItem {
	public $deviceId; //string
	public $path; //string
	public $compressionMethod; //string
	public $chunkSize; //long
	public $size; //long
	public $cimType; //int
	public $create; //boolean

	function __construct($deviceId = null, $path = null, $compressionMethod = null, $chunkSize = null, $size = null, $cimType = null, $create = null) {
		$this->deviceId = $deviceId;
		$this->path = $path;
		$this->compressionMethod = $compressionMethod;
		$this->chunkSize = $chunkSize;
		$this->size = $size;
		$this->cimType = $cimType;
		$this->create = $create;
	}
}

class ArrayOfOvfFileItem {
	public $OvfFileItem; //OvfFileItem

	function __construct($OvfFileItem = null) {
		$this->OvfFileItem = $OvfFileItem;
	}
}

class OvfCreateDescriptorParams {
	public $ovfFiles; //OvfFile
	public $name; //string
	public $description; //string
	public $includeImageFiles; //boolean

	function __construct($ovfFiles = null, $name = null, $description = null, $includeImageFiles = null) {
		$this->ovfFiles = $ovfFiles;
		$this->name = $name;
		$this->description = $description;
		$this->includeImageFiles = $includeImageFiles;
	}
}

class OvfCreateDescriptorResult {
	public $ovfDescriptor; //string
	public $error; //LocalizedMethodFault
	public $warning; //LocalizedMethodFault
	public $includeImageFiles; //boolean

	function __construct($ovfDescriptor = null, $error = null, $warning = null, $includeImageFiles = null) {
		$this->ovfDescriptor = $ovfDescriptor;
		$this->error = $error;
		$this->warning = $warning;
		$this->includeImageFiles = $includeImageFiles;
	}
}

class OvfFile {
	public $deviceId; //string
	public $path; //string
	public $compressionMethod; //string
	public $chunkSize; //long
	public $size; //long
	public $capacity; //long
	public $populatedSize; //long

	function __construct($deviceId = null, $path = null, $compressionMethod = null, $chunkSize = null, $size = null, $capacity = null, $populatedSize = null) {
		$this->deviceId = $deviceId;
		$this->path = $path;
		$this->compressionMethod = $compressionMethod;
		$this->chunkSize = $chunkSize;
		$this->size = $size;
		$this->capacity = $capacity;
		$this->populatedSize = $populatedSize;
	}
}

class ArrayOfOvfFile {
	public $OvfFile; //OvfFile

	function __construct($OvfFile = null) {
		$this->OvfFile = $OvfFile;
	}
}

class PasswordField {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class PerformanceDescription {
	public $counterType; //ElementDescription
	public $statsType; //ElementDescription

	function __construct($counterType = null, $statsType = null) {
		$this->counterType = $counterType;
		$this->statsType = $statsType;
	}
}

class PerfProviderSummary {
	public $entity; //ManagedObjectReference
	public $currentSupported; //boolean
	public $summarySupported; //boolean
	public $refreshRate; //int

	function __construct($entity = null, $currentSupported = null, $summarySupported = null, $refreshRate = null) {
		$this->entity = $entity;
		$this->currentSupported = $currentSupported;
		$this->summarySupported = $summarySupported;
		$this->refreshRate = $refreshRate;
	}
}

class PerfCounterInfo {
	public $key; //int
	public $nameInfo; //ElementDescription
	public $groupInfo; //ElementDescription
	public $unitInfo; //ElementDescription
	public $rollupType; //PerfSummaryType
	public $statsType; //PerfStatsType
	public $level; //int
	public $perDeviceLevel; //int
	public $associatedCounterId; //int

	function __construct($key = null, $nameInfo = null, $groupInfo = null, $unitInfo = null, $rollupType = null, $statsType = null, $level = null, $perDeviceLevel = null, $associatedCounterId = null) {
		$this->key = $key;
		$this->nameInfo = $nameInfo;
		$this->groupInfo = $groupInfo;
		$this->unitInfo = $unitInfo;
		$this->rollupType = $rollupType;
		$this->statsType = $statsType;
		$this->level = $level;
		$this->perDeviceLevel = $perDeviceLevel;
		$this->associatedCounterId = $associatedCounterId;
	}
}

class ArrayOfPerfCounterInfo {
	public $PerfCounterInfo; //PerfCounterInfo

	function __construct($PerfCounterInfo = null) {
		$this->PerfCounterInfo = $PerfCounterInfo;
	}
}

class PerfMetricId {
	public $counterId; //int
	public $instance; //string

	function __construct($counterId = null, $instance = null) {
		$this->counterId = $counterId;
		$this->instance = $instance;
	}
}

class ArrayOfPerfMetricId {
	public $PerfMetricId; //PerfMetricId

	function __construct($PerfMetricId = null) {
		$this->PerfMetricId = $PerfMetricId;
	}
}

class PerfQuerySpec {
	public $entity; //ManagedObjectReference
	public $startTime; //dateTime
	public $endTime; //dateTime
	public $maxSample; //int
	public $metricId; //PerfMetricId
	public $intervalId; //int
	public $format; //string

	function __construct($entity = null, $startTime = null, $endTime = null, $maxSample = null, $metricId = null, $intervalId = null, $format = null) {
		$this->entity = $entity;
		$this->startTime = $startTime;
		$this->endTime = $endTime;
		$this->maxSample = $maxSample;
		$this->metricId = $metricId;
		$this->intervalId = $intervalId;
		$this->format = $format;
	}
}

class ArrayOfPerfQuerySpec {
	public $PerfQuerySpec; //PerfQuerySpec

	function __construct($PerfQuerySpec = null) {
		$this->PerfQuerySpec = $PerfQuerySpec;
	}
}

class PerfSampleInfo {
	public $timestamp; //dateTime
	public $interval; //int

	function __construct($timestamp = null, $interval = null) {
		$this->timestamp = $timestamp;
		$this->interval = $interval;
	}
}

class ArrayOfPerfSampleInfo {
	public $PerfSampleInfo; //PerfSampleInfo

	function __construct($PerfSampleInfo = null) {
		$this->PerfSampleInfo = $PerfSampleInfo;
	}
}

class PerfMetricSeries {
	public $id; //PerfMetricId

	function __construct($id = null) {
		$this->id = $id;
	}
}

class ArrayOfPerfMetricSeries {
	public $PerfMetricSeries; //PerfMetricSeries

	function __construct($PerfMetricSeries = null) {
		$this->PerfMetricSeries = $PerfMetricSeries;
	}
}

class PerfMetricIntSeries {
	public $value; //long

	function __construct($value = null) {
		$this->value = $value;
	}
}

class PerfMetricSeriesCSV {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class ArrayOfPerfMetricSeriesCSV {
	public $PerfMetricSeriesCSV; //PerfMetricSeriesCSV

	function __construct($PerfMetricSeriesCSV = null) {
		$this->PerfMetricSeriesCSV = $PerfMetricSeriesCSV;
	}
}

class PerfEntityMetricBase {
	public $entity; //ManagedObjectReference

	function __construct($entity = null) {
		$this->entity = $entity;
	}
}

class ArrayOfPerfEntityMetricBase {
	public $PerfEntityMetricBase; //PerfEntityMetricBase

	function __construct($PerfEntityMetricBase = null) {
		$this->PerfEntityMetricBase = $PerfEntityMetricBase;
	}
}

class PerfEntityMetric {
	public $sampleInfo; //PerfSampleInfo
	public $value; //PerfMetricSeries

	function __construct($sampleInfo = null, $value = null) {
		$this->sampleInfo = $sampleInfo;
		$this->value = $value;
	}
}

class PerfEntityMetricCSV {
	public $sampleInfoCSV; //string
	public $value; //PerfMetricSeriesCSV

	function __construct($sampleInfoCSV = null, $value = null) {
		$this->sampleInfoCSV = $sampleInfoCSV;
		$this->value = $value;
	}
}

class PerfCompositeMetric {
	public $entity; //PerfEntityMetricBase
	public $childEntity; //PerfEntityMetricBase

	function __construct($entity = null, $childEntity = null) {
		$this->entity = $entity;
		$this->childEntity = $childEntity;
	}
}

class PerformanceManagerCounterLevelMapping {
	public $counterId; //int
	public $aggregateLevel; //int
	public $perDeviceLevel; //int

	function __construct($counterId = null, $aggregateLevel = null, $perDeviceLevel = null) {
		$this->counterId = $counterId;
		$this->aggregateLevel = $aggregateLevel;
		$this->perDeviceLevel = $perDeviceLevel;
	}
}

class ArrayOfPerformanceManagerCounterLevelMapping {
	public $PerformanceManagerCounterLevelMapping; //PerformanceManagerCounterLevelMapping

	function __construct($PerformanceManagerCounterLevelMapping = null) {
		$this->PerformanceManagerCounterLevelMapping = $PerformanceManagerCounterLevelMapping;
	}
}

class PerfInterval {
	public $key; //int
	public $samplingPeriod; //int
	public $name; //string
	public $length; //int
	public $level; //int
	public $enabled; //boolean

	function __construct($key = null, $samplingPeriod = null, $name = null, $length = null, $level = null, $enabled = null) {
		$this->key = $key;
		$this->samplingPeriod = $samplingPeriod;
		$this->name = $name;
		$this->length = $length;
		$this->level = $level;
		$this->enabled = $enabled;
	}
}

class ArrayOfPerfInterval {
	public $PerfInterval; //PerfInterval

	function __construct($PerfInterval = null) {
		$this->PerfInterval = $PerfInterval;
	}
}

class PosixUserSearchResult {
	public $id; //int
	public $shellAccess; //boolean

	function __construct($id = null, $shellAccess = null) {
		$this->id = $id;
		$this->shellAccess = $shellAccess;
	}
}

class PrivilegePolicyDef {
	public $createPrivilege; //string
	public $readPrivilege; //string
	public $updatePrivilege; //string
	public $deletePrivilege; //string

	function __construct($createPrivilege = null, $readPrivilege = null, $updatePrivilege = null, $deletePrivilege = null) {
		$this->createPrivilege = $createPrivilege;
		$this->readPrivilege = $readPrivilege;
		$this->updatePrivilege = $updatePrivilege;
		$this->deletePrivilege = $deletePrivilege;
	}
}

class ResourceAllocationInfo {
	public $reservation; //long
	public $expandableReservation; //boolean
	public $limit; //long
	public $shares; //SharesInfo
	public $overheadLimit; //long

	function __construct($reservation = null, $expandableReservation = null, $limit = null, $shares = null, $overheadLimit = null) {
		$this->reservation = $reservation;
		$this->expandableReservation = $expandableReservation;
		$this->limit = $limit;
		$this->shares = $shares;
		$this->overheadLimit = $overheadLimit;
	}
}

class ResourceAllocationOption {
	public $sharesOption; //SharesOption

	function __construct($sharesOption = null) {
		$this->sharesOption = $sharesOption;
	}
}

class ResourceConfigOption {
	public $cpuAllocationOption; //ResourceAllocationOption
	public $memoryAllocationOption; //ResourceAllocationOption

	function __construct($cpuAllocationOption = null, $memoryAllocationOption = null) {
		$this->cpuAllocationOption = $cpuAllocationOption;
		$this->memoryAllocationOption = $memoryAllocationOption;
	}
}

class ResourceConfigSpec {
	public $entity; //ManagedObjectReference
	public $changeVersion; //string
	public $lastModified; //dateTime
	public $cpuAllocation; //ResourceAllocationInfo
	public $memoryAllocation; //ResourceAllocationInfo

	function __construct($entity = null, $changeVersion = null, $lastModified = null, $cpuAllocation = null, $memoryAllocation = null) {
		$this->entity = $entity;
		$this->changeVersion = $changeVersion;
		$this->lastModified = $lastModified;
		$this->cpuAllocation = $cpuAllocation;
		$this->memoryAllocation = $memoryAllocation;
	}
}

class ArrayOfResourceConfigSpec {
	public $ResourceConfigSpec; //ResourceConfigSpec

	function __construct($ResourceConfigSpec = null) {
		$this->ResourceConfigSpec = $ResourceConfigSpec;
	}
}

class DatabaseSizeParam {
	public $inventoryDesc; //InventoryDescription
	public $perfStatsDesc; //PerformanceStatisticsDescription

	function __construct($inventoryDesc = null, $perfStatsDesc = null) {
		$this->inventoryDesc = $inventoryDesc;
		$this->perfStatsDesc = $perfStatsDesc;
	}
}

class InventoryDescription {
	public $numHosts; //int
	public $numVirtualMachines; //int
	public $numResourcePools; //int
	public $numClusters; //int
	public $numCpuDev; //int
	public $numNetDev; //int
	public $numDiskDev; //int
	public $numvCpuDev; //int
	public $numvNetDev; //int
	public $numvDiskDev; //int

	function __construct($numHosts = null, $numVirtualMachines = null, $numResourcePools = null, $numClusters = null, $numCpuDev = null, $numNetDev = null, $numDiskDev = null, $numvCpuDev = null, $numvNetDev = null, $numvDiskDev = null) {
		$this->numHosts = $numHosts;
		$this->numVirtualMachines = $numVirtualMachines;
		$this->numResourcePools = $numResourcePools;
		$this->numClusters = $numClusters;
		$this->numCpuDev = $numCpuDev;
		$this->numNetDev = $numNetDev;
		$this->numDiskDev = $numDiskDev;
		$this->numvCpuDev = $numvCpuDev;
		$this->numvNetDev = $numvNetDev;
		$this->numvDiskDev = $numvDiskDev;
	}
}

class PerformanceStatisticsDescription {
	public $intervals; //PerfInterval

	function __construct($intervals = null) {
		$this->intervals = $intervals;
	}
}

class DatabaseSizeEstimate {
	public $size; //long

	function __construct($size = null) {
		$this->size = $size;
	}
}

class ResourcePoolResourceUsage {
	public $reservationUsed; //long
	public $reservationUsedForVm; //long
	public $unreservedForPool; //long
	public $unreservedForVm; //long
	public $overallUsage; //long
	public $maxUsage; //long

	function __construct($reservationUsed = null, $reservationUsedForVm = null, $unreservedForPool = null, $unreservedForVm = null, $overallUsage = null, $maxUsage = null) {
		$this->reservationUsed = $reservationUsed;
		$this->reservationUsedForVm = $reservationUsedForVm;
		$this->unreservedForPool = $unreservedForPool;
		$this->unreservedForVm = $unreservedForVm;
		$this->overallUsage = $overallUsage;
		$this->maxUsage = $maxUsage;
	}
}

class ResourcePoolRuntimeInfo {
	public $memory; //ResourcePoolResourceUsage
	public $cpu; //ResourcePoolResourceUsage
	public $overallStatus; //ManagedEntityStatus

	function __construct($memory = null, $cpu = null, $overallStatus = null) {
		$this->memory = $memory;
		$this->cpu = $cpu;
		$this->overallStatus = $overallStatus;
	}
}

class ResourcePoolQuickStats {
	public $overallCpuUsage; //long
	public $overallCpuDemand; //long
	public $guestMemoryUsage; //long
	public $hostMemoryUsage; //long
	public $distributedCpuEntitlement; //long
	public $distributedMemoryEntitlement; //long
	public $staticCpuEntitlement; //int
	public $staticMemoryEntitlement; //int
	public $privateMemory; //long
	public $sharedMemory; //long
	public $swappedMemory; //long
	public $balloonedMemory; //long
	public $overheadMemory; //long
	public $consumedOverheadMemory; //long
	public $compressedMemory; //long

	function __construct($overallCpuUsage = null, $overallCpuDemand = null, $guestMemoryUsage = null, $hostMemoryUsage = null, $distributedCpuEntitlement = null, $distributedMemoryEntitlement = null, $staticCpuEntitlement = null, $staticMemoryEntitlement = null, $privateMemory = null, $sharedMemory = null, $swappedMemory = null, $balloonedMemory = null, $overheadMemory = null, $consumedOverheadMemory = null, $compressedMemory = null) {
		$this->overallCpuUsage = $overallCpuUsage;
		$this->overallCpuDemand = $overallCpuDemand;
		$this->guestMemoryUsage = $guestMemoryUsage;
		$this->hostMemoryUsage = $hostMemoryUsage;
		$this->distributedCpuEntitlement = $distributedCpuEntitlement;
		$this->distributedMemoryEntitlement = $distributedMemoryEntitlement;
		$this->staticCpuEntitlement = $staticCpuEntitlement;
		$this->staticMemoryEntitlement = $staticMemoryEntitlement;
		$this->privateMemory = $privateMemory;
		$this->sharedMemory = $sharedMemory;
		$this->swappedMemory = $swappedMemory;
		$this->balloonedMemory = $balloonedMemory;
		$this->overheadMemory = $overheadMemory;
		$this->consumedOverheadMemory = $consumedOverheadMemory;
		$this->compressedMemory = $compressedMemory;
	}
}

class ResourcePoolSummary {
	public $name; //string
	public $config; //ResourceConfigSpec
	public $runtime; //ResourcePoolRuntimeInfo
	public $quickStats; //ResourcePoolQuickStats
	public $configuredMemoryMB; //int

	function __construct($name = null, $config = null, $runtime = null, $quickStats = null, $configuredMemoryMB = null) {
		$this->name = $name;
		$this->config = $config;
		$this->runtime = $runtime;
		$this->quickStats = $quickStats;
		$this->configuredMemoryMB = $configuredMemoryMB;
	}
}

class HostVMotionCompatibility {
	public $host; //ManagedObjectReference
	public $compatibility; //string

	function __construct($host = null, $compatibility = null) {
		$this->host = $host;
		$this->compatibility = $compatibility;
	}
}

class ArrayOfHostVMotionCompatibility {
	public $HostVMotionCompatibility; //HostVMotionCompatibility

	function __construct($HostVMotionCompatibility = null) {
		$this->HostVMotionCompatibility = $HostVMotionCompatibility;
	}
}

class ProductComponentInfo {
	public $id; //string
	public $name; //string
	public $version; //string
	public $release; //int

	function __construct($id = null, $name = null, $version = null, $release = null) {
		$this->id = $id;
		$this->name = $name;
		$this->version = $version;
		$this->release = $release;
	}
}

class ArrayOfProductComponentInfo {
	public $ProductComponentInfo; //ProductComponentInfo

	function __construct($ProductComponentInfo = null) {
		$this->ProductComponentInfo = $ProductComponentInfo;
	}
}

class ServiceContent {
	public $rootFolder; //ManagedObjectReference
	public $propertyCollector; //ManagedObjectReference
	public $viewManager; //ManagedObjectReference
	public $about; //AboutInfo
	public $setting; //ManagedObjectReference
	public $userDirectory; //ManagedObjectReference
	public $sessionManager; //ManagedObjectReference
	public $authorizationManager; //ManagedObjectReference
	public $perfManager; //ManagedObjectReference
	public $scheduledTaskManager; //ManagedObjectReference
	public $alarmManager; //ManagedObjectReference
	public $eventManager; //ManagedObjectReference
	public $taskManager; //ManagedObjectReference
	public $extensionManager; //ManagedObjectReference
	public $customizationSpecManager; //ManagedObjectReference
	public $customFieldsManager; //ManagedObjectReference
	public $accountManager; //ManagedObjectReference
	public $diagnosticManager; //ManagedObjectReference
	public $licenseManager; //ManagedObjectReference
	public $searchIndex; //ManagedObjectReference
	public $fileManager; //ManagedObjectReference
	public $virtualDiskManager; //ManagedObjectReference
	public $virtualizationManager; //ManagedObjectReference
	public $snmpSystem; //ManagedObjectReference
	public $vmProvisioningChecker; //ManagedObjectReference
	public $vmCompatibilityChecker; //ManagedObjectReference
	public $ovfManager; //ManagedObjectReference
	public $ipPoolManager; //ManagedObjectReference
	public $dvSwitchManager; //ManagedObjectReference
	public $hostProfileManager; //ManagedObjectReference
	public $clusterProfileManager; //ManagedObjectReference
	public $complianceManager; //ManagedObjectReference
	public $localizationManager; //ManagedObjectReference
	public $storageResourceManager; //ManagedObjectReference
	public $guestOperationsManager; //ManagedObjectReference

	function __construct($rootFolder = null, $propertyCollector = null, $viewManager = null, $about = null, $setting = null, $userDirectory = null, $sessionManager = null, $authorizationManager = null, $perfManager = null, $scheduledTaskManager = null, $alarmManager = null, $eventManager = null, $taskManager = null, $extensionManager = null, $customizationSpecManager = null, $customFieldsManager = null, $accountManager = null, $diagnosticManager = null, $licenseManager = null, $searchIndex = null, $fileManager = null, $virtualDiskManager = null, $virtualizationManager = null, $snmpSystem = null, $vmProvisioningChecker = null, $vmCompatibilityChecker = null, $ovfManager = null, $ipPoolManager = null, $dvSwitchManager = null, $hostProfileManager = null, $clusterProfileManager = null, $complianceManager = null, $localizationManager = null, $storageResourceManager = null, $guestOperationsManager = null) {
		$this->rootFolder = $rootFolder;
		$this->propertyCollector = $propertyCollector;
		$this->viewManager = $viewManager;
		$this->about = $about;
		$this->setting = $setting;
		$this->userDirectory = $userDirectory;
		$this->sessionManager = $sessionManager;
		$this->authorizationManager = $authorizationManager;
		$this->perfManager = $perfManager;
		$this->scheduledTaskManager = $scheduledTaskManager;
		$this->alarmManager = $alarmManager;
		$this->eventManager = $eventManager;
		$this->taskManager = $taskManager;
		$this->extensionManager = $extensionManager;
		$this->customizationSpecManager = $customizationSpecManager;
		$this->customFieldsManager = $customFieldsManager;
		$this->accountManager = $accountManager;
		$this->diagnosticManager = $diagnosticManager;
		$this->licenseManager = $licenseManager;
		$this->searchIndex = $searchIndex;
		$this->fileManager = $fileManager;
		$this->virtualDiskManager = $virtualDiskManager;
		$this->virtualizationManager = $virtualizationManager;
		$this->snmpSystem = $snmpSystem;
		$this->vmProvisioningChecker = $vmProvisioningChecker;
		$this->vmCompatibilityChecker = $vmCompatibilityChecker;
		$this->ovfManager = $ovfManager;
		$this->ipPoolManager = $ipPoolManager;
		$this->dvSwitchManager = $dvSwitchManager;
		$this->hostProfileManager = $hostProfileManager;
		$this->clusterProfileManager = $clusterProfileManager;
		$this->complianceManager = $complianceManager;
		$this->localizationManager = $localizationManager;
		$this->storageResourceManager = $storageResourceManager;
		$this->guestOperationsManager = $guestOperationsManager;
	}
}

class SessionManagerLocalTicket {
	public $userName; //string
	public $passwordFilePath; //string

	function __construct($userName = null, $passwordFilePath = null) {
		$this->userName = $userName;
		$this->passwordFilePath = $passwordFilePath;
	}
}

class SessionManagerGenericServiceTicket {
	public $id; //string

	function __construct($id = null) {
		$this->id = $id;
	}
}

class SessionManagerServiceRequestSpec {
}

class SessionManagerHttpServiceRequestSpec {
	public $method; //string
	public $url; //string

	function __construct($method = null, $url = null) {
		$this->method = $method;
		$this->url = $url;
	}
}

class UserSession {
	public $key; //string
	public $userName; //string
	public $fullName; //string
	public $loginTime; //dateTime
	public $lastActiveTime; //dateTime
	public $locale; //string
	public $messageLocale; //string
	public $extensionSession; //boolean

	function __construct($key = null, $userName = null, $fullName = null, $loginTime = null, $lastActiveTime = null, $locale = null, $messageLocale = null, $extensionSession = null) {
		$this->key = $key;
		$this->userName = $userName;
		$this->fullName = $fullName;
		$this->loginTime = $loginTime;
		$this->lastActiveTime = $lastActiveTime;
		$this->locale = $locale;
		$this->messageLocale = $messageLocale;
		$this->extensionSession = $extensionSession;
	}
}

class ArrayOfUserSession {
	public $UserSession; //UserSession

	function __construct($UserSession = null) {
		$this->UserSession = $UserSession;
	}
}

class SharesInfo {
	public $shares; //int
	public $level; //SharesLevel

	function __construct($shares = null, $level = null) {
		$this->shares = $shares;
		$this->level = $level;
	}
}

class SharesOption {
	public $sharesOption; //IntOption
	public $defaultLevel; //SharesLevel

	function __construct($sharesOption = null, $defaultLevel = null) {
		$this->sharesOption = $sharesOption;
		$this->defaultLevel = $defaultLevel;
	}
}

class StoragePodSummary {
	public $name; //string
	public $capacity; //long
	public $freeSpace; //long

	function __construct($name = null, $capacity = null, $freeSpace = null) {
		$this->name = $name;
		$this->capacity = $capacity;
		$this->freeSpace = $freeSpace;
	}
}

class StorageIOAllocationInfo {
	public $limit; //long
	public $shares; //SharesInfo

	function __construct($limit = null, $shares = null) {
		$this->limit = $limit;
		$this->shares = $shares;
	}
}

class StorageIOAllocationOption {
	public $limitOption; //LongOption
	public $sharesOption; //SharesOption

	function __construct($limitOption = null, $sharesOption = null) {
		$this->limitOption = $limitOption;
		$this->sharesOption = $sharesOption;
	}
}

class StorageIORMInfo {
	public $enabled; //boolean
	public $congestionThreshold; //int
	public $statsCollectionEnabled; //boolean
	public $statsAggregationDisabled; //boolean

	function __construct($enabled = null, $congestionThreshold = null, $statsCollectionEnabled = null, $statsAggregationDisabled = null) {
		$this->enabled = $enabled;
		$this->congestionThreshold = $congestionThreshold;
		$this->statsCollectionEnabled = $statsCollectionEnabled;
		$this->statsAggregationDisabled = $statsAggregationDisabled;
	}
}

class StorageIORMConfigSpec {
	public $enabled; //boolean
	public $congestionThreshold; //int
	public $statsCollectionEnabled; //boolean
	public $statsAggregationDisabled; //boolean

	function __construct($enabled = null, $congestionThreshold = null, $statsCollectionEnabled = null, $statsAggregationDisabled = null) {
		$this->enabled = $enabled;
		$this->congestionThreshold = $congestionThreshold;
		$this->statsCollectionEnabled = $statsCollectionEnabled;
		$this->statsAggregationDisabled = $statsAggregationDisabled;
	}
}

class StorageIORMConfigOption {
	public $enabledOption; //BoolOption
	public $congestionThresholdOption; //IntOption
	public $statsCollectionEnabledOption; //BoolOption

	function __construct($enabledOption = null, $congestionThresholdOption = null, $statsCollectionEnabledOption = null) {
		$this->enabledOption = $enabledOption;
		$this->congestionThresholdOption = $congestionThresholdOption;
		$this->statsCollectionEnabledOption = $statsCollectionEnabledOption;
	}
}

class PodStorageDrsEntry {
	public $storageDrsConfig; //StorageDrsConfigInfo
	public $recommendation; //ClusterRecommendation
	public $drsFault; //ClusterDrsFaults
	public $actionHistory; //ClusterActionHistory

	function __construct($storageDrsConfig = null, $recommendation = null, $drsFault = null, $actionHistory = null) {
		$this->storageDrsConfig = $storageDrsConfig;
		$this->recommendation = $recommendation;
		$this->drsFault = $drsFault;
		$this->actionHistory = $actionHistory;
	}
}

class StringPolicy {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class Tag {
	public $key; //string

	function __construct($key = null) {
		$this->key = $key;
	}
}

class ArrayOfTag {
	public $Tag; //Tag

	function __construct($Tag = null) {
		$this->Tag = $Tag;
	}
}

class TaskDescription {
	public $methodInfo; //ElementDescription
	public $state; //ElementDescription
	public $reason; //TypeDescription

	function __construct($methodInfo = null, $state = null, $reason = null) {
		$this->methodInfo = $methodInfo;
		$this->state = $state;
		$this->reason = $reason;
	}
}

class TaskFilterSpecByEntity {
	public $entity; //ManagedObjectReference
	public $recursion; //TaskFilterSpecRecursionOption

	function __construct($entity = null, $recursion = null) {
		$this->entity = $entity;
		$this->recursion = $recursion;
	}
}

class TaskFilterSpecByTime {
	public $timeType; //TaskFilterSpecTimeOption
	public $beginTime; //dateTime
	public $endTime; //dateTime

	function __construct($timeType = null, $beginTime = null, $endTime = null) {
		$this->timeType = $timeType;
		$this->beginTime = $beginTime;
		$this->endTime = $endTime;
	}
}

class TaskFilterSpecByUsername {
	public $systemUser; //boolean
	public $userList; //string

	function __construct($systemUser = null, $userList = null) {
		$this->systemUser = $systemUser;
		$this->userList = $userList;
	}
}

class TaskFilterSpec {
	public $entity; //TaskFilterSpecByEntity
	public $time; //TaskFilterSpecByTime
	public $userName; //TaskFilterSpecByUsername
	public $state; //TaskInfoState
	public $alarm; //ManagedObjectReference
	public $scheduledTask; //ManagedObjectReference
	public $eventChainId; //int
	public $tag; //string
	public $parentTaskKey; //string
	public $rootTaskKey; //string

	function __construct($entity = null, $time = null, $userName = null, $state = null, $alarm = null, $scheduledTask = null, $eventChainId = null, $tag = null, $parentTaskKey = null, $rootTaskKey = null) {
		$this->entity = $entity;
		$this->time = $time;
		$this->userName = $userName;
		$this->state = $state;
		$this->alarm = $alarm;
		$this->scheduledTask = $scheduledTask;
		$this->eventChainId = $eventChainId;
		$this->tag = $tag;
		$this->parentTaskKey = $parentTaskKey;
		$this->rootTaskKey = $rootTaskKey;
	}
}

class ArrayOfTaskInfoState {
	public $TaskInfoState; //TaskInfoState

	function __construct($TaskInfoState = null) {
		$this->TaskInfoState = $TaskInfoState;
	}
}

class TaskInfo {
	public $key; //string
	public $task; //ManagedObjectReference
	public $description; //LocalizableMessage
	public $name; //string
	public $descriptionId; //string
	public $entity; //ManagedObjectReference
	public $entityName; //string
	public $locked; //ManagedObjectReference
	public $state; //TaskInfoState
	public $cancelled; //boolean
	public $cancelable; //boolean
	public $error; //LocalizedMethodFault
	public $result; //anyType
	public $progress; //int
	public $reason; //TaskReason
	public $queueTime; //dateTime
	public $startTime; //dateTime
	public $completeTime; //dateTime
	public $eventChainId; //int
	public $changeTag; //string
	public $parentTaskKey; //string
	public $rootTaskKey; //string

	function __construct($key = null, $task = null, $description = null, $name = null, $descriptionId = null, $entity = null, $entityName = null, $locked = null, $state = null, $cancelled = null, $cancelable = null, $error = null, $result = null, $progress = null, $reason = null, $queueTime = null, $startTime = null, $completeTime = null, $eventChainId = null, $changeTag = null, $parentTaskKey = null, $rootTaskKey = null) {
		$this->key = $key;
		$this->task = $task;
		$this->description = $description;
		$this->name = $name;
		$this->descriptionId = $descriptionId;
		$this->entity = $entity;
		$this->entityName = $entityName;
		$this->locked = $locked;
		$this->state = $state;
		$this->cancelled = $cancelled;
		$this->cancelable = $cancelable;
		$this->error = $error;
		$this->result = $result;
		$this->progress = $progress;
		$this->reason = $reason;
		$this->queueTime = $queueTime;
		$this->startTime = $startTime;
		$this->completeTime = $completeTime;
		$this->eventChainId = $eventChainId;
		$this->changeTag = $changeTag;
		$this->parentTaskKey = $parentTaskKey;
		$this->rootTaskKey = $rootTaskKey;
	}
}

class ArrayOfTaskInfo {
	public $TaskInfo; //TaskInfo

	function __construct($TaskInfo = null) {
		$this->TaskInfo = $TaskInfo;
	}
}

class TaskReason {
}

class TaskReasonSystem {
}

class TaskReasonUser {
	public $userName; //string

	function __construct($userName = null) {
		$this->userName = $userName;
	}
}

class TaskReasonAlarm {
	public $alarmName; //string
	public $alarm; //ManagedObjectReference
	public $entityName; //string
	public $entity; //ManagedObjectReference

	function __construct($alarmName = null, $alarm = null, $entityName = null, $entity = null) {
		$this->alarmName = $alarmName;
		$this->alarm = $alarm;
		$this->entityName = $entityName;
		$this->entity = $entity;
	}
}

class TaskReasonSchedule {
	public $name; //string
	public $scheduledTask; //ManagedObjectReference

	function __construct($name = null, $scheduledTask = null) {
		$this->name = $name;
		$this->scheduledTask = $scheduledTask;
	}
}

class TypeDescription {
	public $key; //string

	function __construct($key = null) {
		$this->key = $key;
	}
}

class ArrayOfTypeDescription {
	public $TypeDescription; //TypeDescription

	function __construct($TypeDescription = null) {
		$this->TypeDescription = $TypeDescription;
	}
}

class UpdateVirtualMachineFilesResultFailedVmFileInfo {
	public $vmFile; //string
	public $fault; //LocalizedMethodFault

	function __construct($vmFile = null, $fault = null) {
		$this->vmFile = $vmFile;
		$this->fault = $fault;
	}
}

class ArrayOfUpdateVirtualMachineFilesResultFailedVmFileInfo {
	public $UpdateVirtualMachineFilesResultFailedVmFileInfo; //UpdateVirtualMachineFilesResultFailedVmFileInfo

	function __construct($UpdateVirtualMachineFilesResultFailedVmFileInfo = null) {
		$this->UpdateVirtualMachineFilesResultFailedVmFileInfo = $UpdateVirtualMachineFilesResultFailedVmFileInfo;
	}
}

class UpdateVirtualMachineFilesResult {
	public $failedVmFile; //UpdateVirtualMachineFilesResultFailedVmFileInfo

	function __construct($failedVmFile = null) {
		$this->failedVmFile = $failedVmFile;
	}
}

class UserSearchResult {
	public $principal; //string
	public $fullName; //string
	public $group; //boolean

	function __construct($principal = null, $fullName = null, $group = null) {
		$this->principal = $principal;
		$this->fullName = $fullName;
		$this->group = $group;
	}
}

class ArrayOfUserSearchResult {
	public $UserSearchResult; //UserSearchResult

	function __construct($UserSearchResult = null) {
		$this->UserSearchResult = $UserSearchResult;
	}
}

class VirtualAppSummary {
	public $product; //VAppProductInfo
	public $vAppState; //VirtualAppVAppState
	public $suspended; //boolean
	public $installBootRequired; //boolean
	public $instanceUuid; //string

	function __construct($product = null, $vAppState = null, $suspended = null, $installBootRequired = null, $instanceUuid = null) {
		$this->product = $product;
		$this->vAppState = $vAppState;
		$this->suspended = $suspended;
		$this->installBootRequired = $installBootRequired;
		$this->instanceUuid = $instanceUuid;
	}
}

class VirtualAppLinkInfo {
	public $key; //ManagedObjectReference
	public $destroyWithParent; //boolean

	function __construct($key = null, $destroyWithParent = null) {
		$this->key = $key;
		$this->destroyWithParent = $destroyWithParent;
	}
}

class ArrayOfVirtualAppLinkInfo {
	public $VirtualAppLinkInfo; //VirtualAppLinkInfo

	function __construct($VirtualAppLinkInfo = null) {
		$this->VirtualAppLinkInfo = $VirtualAppLinkInfo;
	}
}

class VirtualDiskSpec {
	public $diskType; //string
	public $adapterType; //string

	function __construct($diskType = null, $adapterType = null) {
		$this->diskType = $diskType;
		$this->adapterType = $adapterType;
	}
}

class FileBackedVirtualDiskSpec {
	public $capacityKb; //long

	function __construct($capacityKb = null) {
		$this->capacityKb = $capacityKb;
	}
}

class DeviceBackedVirtualDiskSpec {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class StorageRequirement {
	public $datastore; //ManagedObjectReference
	public $freeSpaceRequiredInKb; //long

	function __construct($datastore = null, $freeSpaceRequiredInKb = null) {
		$this->datastore = $datastore;
		$this->freeSpaceRequiredInKb = $freeSpaceRequiredInKb;
	}
}

class ArrayOfStorageRequirement {
	public $StorageRequirement; //StorageRequirement

	function __construct($StorageRequirement = null) {
		$this->StorageRequirement = $StorageRequirement;
	}
}

class VirtualMachineTicket {
	public $ticket; //string
	public $cfgFile; //string
	public $host; //string
	public $port; //int
	public $sslThumbprint; //string

	function __construct($ticket = null, $cfgFile = null, $host = null, $port = null, $sslThumbprint = null) {
		$this->ticket = $ticket;
		$this->cfgFile = $cfgFile;
		$this->host = $host;
		$this->port = $port;
		$this->sslThumbprint = $sslThumbprint;
	}
}

class VirtualMachineMksTicket {
	public $ticket; //string
	public $cfgFile; //string
	public $host; //string
	public $port; //int
	public $sslThumbprint; //string

	function __construct($ticket = null, $cfgFile = null, $host = null, $port = null, $sslThumbprint = null) {
		$this->ticket = $ticket;
		$this->cfgFile = $cfgFile;
		$this->host = $host;
		$this->port = $port;
		$this->sslThumbprint = $sslThumbprint;
	}
}

class VirtualMachineDisplayTopology {
	public $x; //int
	public $y; //int
	public $width; //int
	public $height; //int

	function __construct($x = null, $y = null, $width = null, $height = null) {
		$this->x = $x;
		$this->y = $y;
		$this->width = $width;
		$this->height = $height;
	}
}

class ArrayOfVirtualMachineDisplayTopology {
	public $VirtualMachineDisplayTopology; //VirtualMachineDisplayTopology

	function __construct($VirtualMachineDisplayTopology = null) {
		$this->VirtualMachineDisplayTopology = $VirtualMachineDisplayTopology;
	}
}

class DiskChangeExtent {
	public $start; //long
	public $length; //long

	function __construct($start = null, $length = null) {
		$this->start = $start;
		$this->length = $length;
	}
}

class ArrayOfDiskChangeExtent {
	public $DiskChangeExtent; //DiskChangeExtent

	function __construct($DiskChangeExtent = null) {
		$this->DiskChangeExtent = $DiskChangeExtent;
	}
}

class DiskChangeInfo {
	public $startOffset; //long
	public $length; //long
	public $changedArea; //DiskChangeExtent

	function __construct($startOffset = null, $length = null, $changedArea = null) {
		$this->startOffset = $startOffset;
		$this->length = $length;
		$this->changedArea = $changedArea;
	}
}

class Action {
}

class MethodActionArgument {
	public $value; //anyType

	function __construct($value = null) {
		$this->value = $value;
	}
}

class ArrayOfMethodActionArgument {
	public $MethodActionArgument; //MethodActionArgument

	function __construct($MethodActionArgument = null) {
		$this->MethodActionArgument = $MethodActionArgument;
	}
}

class MethodAction {
	public $name; //string
	public $argument; //MethodActionArgument

	function __construct($name = null, $argument = null) {
		$this->name = $name;
		$this->argument = $argument;
	}
}

class SendEmailAction {
	public $toList; //string
	public $ccList; //string
	public $subject; //string
	public $body; //string

	function __construct($toList = null, $ccList = null, $subject = null, $body = null) {
		$this->toList = $toList;
		$this->ccList = $ccList;
		$this->subject = $subject;
		$this->body = $body;
	}
}

class SendSNMPAction {
}

class RunScriptAction {
	public $script; //string

	function __construct($script = null) {
		$this->script = $script;
	}
}

class CreateTaskAction {
	public $taskTypeId; //string
	public $cancelable; //boolean

	function __construct($taskTypeId = null, $cancelable = null) {
		$this->taskTypeId = $taskTypeId;
		$this->cancelable = $cancelable;
	}
}

class AlarmAction {
}

class ArrayOfAlarmAction {
	public $AlarmAction; //AlarmAction

	function __construct($AlarmAction = null) {
		$this->AlarmAction = $AlarmAction;
	}
}

class AlarmTriggeringActionTransitionSpec {
	public $startState; //ManagedEntityStatus
	public $finalState; //ManagedEntityStatus
	public $repeats; //boolean

	function __construct($startState = null, $finalState = null, $repeats = null) {
		$this->startState = $startState;
		$this->finalState = $finalState;
		$this->repeats = $repeats;
	}
}

class ArrayOfAlarmTriggeringActionTransitionSpec {
	public $AlarmTriggeringActionTransitionSpec; //AlarmTriggeringActionTransitionSpec

	function __construct($AlarmTriggeringActionTransitionSpec = null) {
		$this->AlarmTriggeringActionTransitionSpec = $AlarmTriggeringActionTransitionSpec;
	}
}

class AlarmTriggeringAction {
	public $action; //Action
	public $transitionSpecs; //AlarmTriggeringActionTransitionSpec
	public $green2yellow; //boolean
	public $yellow2red; //boolean
	public $red2yellow; //boolean
	public $yellow2green; //boolean

	function __construct($action = null, $transitionSpecs = null, $green2yellow = null, $yellow2red = null, $red2yellow = null, $yellow2green = null) {
		$this->action = $action;
		$this->transitionSpecs = $transitionSpecs;
		$this->green2yellow = $green2yellow;
		$this->yellow2red = $yellow2red;
		$this->red2yellow = $red2yellow;
		$this->yellow2green = $yellow2green;
	}
}

class GroupAlarmAction {
	public $action; //AlarmAction

	function __construct($action = null) {
		$this->action = $action;
	}
}

class AlarmDescription {
	public $expr; //TypeDescription
	public $stateOperator; //ElementDescription
	public $metricOperator; //ElementDescription
	public $hostSystemConnectionState; //ElementDescription
	public $virtualMachinePowerState; //ElementDescription
	public $datastoreConnectionState; //ElementDescription
	public $hostSystemPowerState; //ElementDescription
	public $virtualMachineGuestHeartbeatStatus; //ElementDescription
	public $entityStatus; //ElementDescription
	public $action; //TypeDescription

	function __construct($expr = null, $stateOperator = null, $metricOperator = null, $hostSystemConnectionState = null, $virtualMachinePowerState = null, $datastoreConnectionState = null, $hostSystemPowerState = null, $virtualMachineGuestHeartbeatStatus = null, $entityStatus = null, $action = null) {
		$this->expr = $expr;
		$this->stateOperator = $stateOperator;
		$this->metricOperator = $metricOperator;
		$this->hostSystemConnectionState = $hostSystemConnectionState;
		$this->virtualMachinePowerState = $virtualMachinePowerState;
		$this->datastoreConnectionState = $datastoreConnectionState;
		$this->hostSystemPowerState = $hostSystemPowerState;
		$this->virtualMachineGuestHeartbeatStatus = $virtualMachineGuestHeartbeatStatus;
		$this->entityStatus = $entityStatus;
		$this->action = $action;
	}
}

class AlarmExpression {
}

class ArrayOfAlarmExpression {
	public $AlarmExpression; //AlarmExpression

	function __construct($AlarmExpression = null) {
		$this->AlarmExpression = $AlarmExpression;
	}
}

class AndAlarmExpression {
	public $expression; //AlarmExpression

	function __construct($expression = null) {
		$this->expression = $expression;
	}
}

class OrAlarmExpression {
	public $expression; //AlarmExpression

	function __construct($expression = null) {
		$this->expression = $expression;
	}
}

class StateAlarmExpression {
	public $operator; //StateAlarmOperator
	public $type; //string
	public $statePath; //string
	public $yellow; //string
	public $red; //string

	function __construct($operator = null, $type = null, $statePath = null, $yellow = null, $red = null) {
		$this->operator = $operator;
		$this->type = $type;
		$this->statePath = $statePath;
		$this->yellow = $yellow;
		$this->red = $red;
	}
}

class EventAlarmExpressionComparison {
	public $attributeName; //string
	public $operator; //string
	public $value; //string

	function __construct($attributeName = null, $operator = null, $value = null) {
		$this->attributeName = $attributeName;
		$this->operator = $operator;
		$this->value = $value;
	}
}

class ArrayOfEventAlarmExpressionComparison {
	public $EventAlarmExpressionComparison; //EventAlarmExpressionComparison

	function __construct($EventAlarmExpressionComparison = null) {
		$this->EventAlarmExpressionComparison = $EventAlarmExpressionComparison;
	}
}

class EventAlarmExpression {
	public $comparisons; //EventAlarmExpressionComparison
	public $eventType; //string
	public $eventTypeId; //string
	public $objectType; //string
	public $status; //ManagedEntityStatus

	function __construct($comparisons = null, $eventType = null, $eventTypeId = null, $objectType = null, $status = null) {
		$this->comparisons = $comparisons;
		$this->eventType = $eventType;
		$this->eventTypeId = $eventTypeId;
		$this->objectType = $objectType;
		$this->status = $status;
	}
}

class MetricAlarmExpression {
	public $operator; //MetricAlarmOperator
	public $type; //string
	public $metric; //PerfMetricId
	public $yellow; //int
	public $yellowInterval; //int
	public $red; //int
	public $redInterval; //int

	function __construct($operator = null, $type = null, $metric = null, $yellow = null, $yellowInterval = null, $red = null, $redInterval = null) {
		$this->operator = $operator;
		$this->type = $type;
		$this->metric = $metric;
		$this->yellow = $yellow;
		$this->yellowInterval = $yellowInterval;
		$this->red = $red;
		$this->redInterval = $redInterval;
	}
}

class AlarmInfo {
	public $key; //string
	public $alarm; //ManagedObjectReference
	public $entity; //ManagedObjectReference
	public $lastModifiedTime; //dateTime
	public $lastModifiedUser; //string
	public $creationEventId; //int

	function __construct($key = null, $alarm = null, $entity = null, $lastModifiedTime = null, $lastModifiedUser = null, $creationEventId = null) {
		$this->key = $key;
		$this->alarm = $alarm;
		$this->entity = $entity;
		$this->lastModifiedTime = $lastModifiedTime;
		$this->lastModifiedUser = $lastModifiedUser;
		$this->creationEventId = $creationEventId;
	}
}

class AlarmSetting {
	public $toleranceRange; //int
	public $reportingFrequency; //int

	function __construct($toleranceRange = null, $reportingFrequency = null) {
		$this->toleranceRange = $toleranceRange;
		$this->reportingFrequency = $reportingFrequency;
	}
}

class AlarmSpec {
	public $name; //string
	public $systemName; //string
	public $description; //string
	public $enabled; //boolean
	public $expression; //AlarmExpression
	public $action; //AlarmAction
	public $actionFrequency; //int
	public $setting; //AlarmSetting

	function __construct($name = null, $systemName = null, $description = null, $enabled = null, $expression = null, $action = null, $actionFrequency = null, $setting = null) {
		$this->name = $name;
		$this->systemName = $systemName;
		$this->description = $description;
		$this->enabled = $enabled;
		$this->expression = $expression;
		$this->action = $action;
		$this->actionFrequency = $actionFrequency;
		$this->setting = $setting;
	}
}

class AlarmState {
	public $key; //string
	public $entity; //ManagedObjectReference
	public $alarm; //ManagedObjectReference
	public $overallStatus; //ManagedEntityStatus
	public $time; //dateTime
	public $acknowledged; //boolean
	public $acknowledgedByUser; //string
	public $acknowledgedTime; //dateTime

	function __construct($key = null, $entity = null, $alarm = null, $overallStatus = null, $time = null, $acknowledged = null, $acknowledgedByUser = null, $acknowledgedTime = null) {
		$this->key = $key;
		$this->entity = $entity;
		$this->alarm = $alarm;
		$this->overallStatus = $overallStatus;
		$this->time = $time;
		$this->acknowledged = $acknowledged;
		$this->acknowledgedByUser = $acknowledgedByUser;
		$this->acknowledgedTime = $acknowledgedTime;
	}
}

class ArrayOfAlarmState {
	public $AlarmState; //AlarmState

	function __construct($AlarmState = null) {
		$this->AlarmState = $AlarmState;
	}
}

class ClusterAction {
	public $type; //string
	public $target; //ManagedObjectReference

	function __construct($type = null, $target = null) {
		$this->type = $type;
		$this->target = $target;
	}
}

class ArrayOfClusterAction {
	public $ClusterAction; //ClusterAction

	function __construct($ClusterAction = null) {
		$this->ClusterAction = $ClusterAction;
	}
}

class ClusterActionHistory {
	public $action; //ClusterAction
	public $time; //dateTime

	function __construct($action = null, $time = null) {
		$this->action = $action;
		$this->time = $time;
	}
}

class ArrayOfClusterActionHistory {
	public $ClusterActionHistory; //ClusterActionHistory

	function __construct($ClusterActionHistory = null) {
		$this->ClusterActionHistory = $ClusterActionHistory;
	}
}

class ClusterAffinityRuleSpec {
	public $vm; //ManagedObjectReference

	function __construct($vm = null) {
		$this->vm = $vm;
	}
}

class ClusterAntiAffinityRuleSpec {
	public $vm; //ManagedObjectReference

	function __construct($vm = null) {
		$this->vm = $vm;
	}
}

class ClusterAttemptedVmInfo {
	public $vm; //ManagedObjectReference
	public $task; //ManagedObjectReference

	function __construct($vm = null, $task = null) {
		$this->vm = $vm;
		$this->task = $task;
	}
}

class ArrayOfClusterAttemptedVmInfo {
	public $ClusterAttemptedVmInfo; //ClusterAttemptedVmInfo

	function __construct($ClusterAttemptedVmInfo = null) {
		$this->ClusterAttemptedVmInfo = $ClusterAttemptedVmInfo;
	}
}

class ClusterConfigInfo {
	public $dasConfig; //ClusterDasConfigInfo
	public $dasVmConfig; //ClusterDasVmConfigInfo
	public $drsConfig; //ClusterDrsConfigInfo
	public $drsVmConfig; //ClusterDrsVmConfigInfo
	public $rule; //ClusterRuleInfo

	function __construct($dasConfig = null, $dasVmConfig = null, $drsConfig = null, $drsVmConfig = null, $rule = null) {
		$this->dasConfig = $dasConfig;
		$this->dasVmConfig = $dasVmConfig;
		$this->drsConfig = $drsConfig;
		$this->drsVmConfig = $drsVmConfig;
		$this->rule = $rule;
	}
}

class ClusterDrsConfigInfo {
	public $enabled; //boolean
	public $enableVmBehaviorOverrides; //boolean
	public $defaultVmBehavior; //DrsBehavior
	public $vmotionRate; //int
	public $option; //OptionValue

	function __construct($enabled = null, $enableVmBehaviorOverrides = null, $defaultVmBehavior = null, $vmotionRate = null, $option = null) {
		$this->enabled = $enabled;
		$this->enableVmBehaviorOverrides = $enableVmBehaviorOverrides;
		$this->defaultVmBehavior = $defaultVmBehavior;
		$this->vmotionRate = $vmotionRate;
		$this->option = $option;
	}
}

class ClusterDrsVmConfigInfo {
	public $key; //ManagedObjectReference
	public $enabled; //boolean
	public $behavior; //DrsBehavior

	function __construct($key = null, $enabled = null, $behavior = null) {
		$this->key = $key;
		$this->enabled = $enabled;
		$this->behavior = $behavior;
	}
}

class ArrayOfClusterDrsVmConfigInfo {
	public $ClusterDrsVmConfigInfo; //ClusterDrsVmConfigInfo

	function __construct($ClusterDrsVmConfigInfo = null) {
		$this->ClusterDrsVmConfigInfo = $ClusterDrsVmConfigInfo;
	}
}

class ClusterConfigInfoEx {
	public $dasConfig; //ClusterDasConfigInfo
	public $dasVmConfig; //ClusterDasVmConfigInfo
	public $drsConfig; //ClusterDrsConfigInfo
	public $drsVmConfig; //ClusterDrsVmConfigInfo
	public $rule; //ClusterRuleInfo
	public $dpmConfigInfo; //ClusterDpmConfigInfo
	public $dpmHostConfig; //ClusterDpmHostConfigInfo
	public $group; //ClusterGroupInfo

	function __construct($dasConfig = null, $dasVmConfig = null, $drsConfig = null, $drsVmConfig = null, $rule = null, $dpmConfigInfo = null, $dpmHostConfig = null, $group = null) {
		$this->dasConfig = $dasConfig;
		$this->dasVmConfig = $dasVmConfig;
		$this->drsConfig = $drsConfig;
		$this->drsVmConfig = $drsVmConfig;
		$this->rule = $rule;
		$this->dpmConfigInfo = $dpmConfigInfo;
		$this->dpmHostConfig = $dpmHostConfig;
		$this->group = $group;
	}
}

class ClusterDpmConfigInfo {
	public $enabled; //boolean
	public $defaultDpmBehavior; //DpmBehavior
	public $hostPowerActionRate; //int
	public $option; //OptionValue

	function __construct($enabled = null, $defaultDpmBehavior = null, $hostPowerActionRate = null, $option = null) {
		$this->enabled = $enabled;
		$this->defaultDpmBehavior = $defaultDpmBehavior;
		$this->hostPowerActionRate = $hostPowerActionRate;
		$this->option = $option;
	}
}

class ClusterDpmHostConfigInfo {
	public $key; //ManagedObjectReference
	public $enabled; //boolean
	public $behavior; //DpmBehavior

	function __construct($key = null, $enabled = null, $behavior = null) {
		$this->key = $key;
		$this->enabled = $enabled;
		$this->behavior = $behavior;
	}
}

class ArrayOfClusterDpmHostConfigInfo {
	public $ClusterDpmHostConfigInfo; //ClusterDpmHostConfigInfo

	function __construct($ClusterDpmHostConfigInfo = null) {
		$this->ClusterDpmHostConfigInfo = $ClusterDpmHostConfigInfo;
	}
}

class ClusterConfigSpec {
	public $dasConfig; //ClusterDasConfigInfo
	public $dasVmConfigSpec; //ClusterDasVmConfigSpec
	public $drsConfig; //ClusterDrsConfigInfo
	public $drsVmConfigSpec; //ClusterDrsVmConfigSpec
	public $rulesSpec; //ClusterRuleSpec

	function __construct($dasConfig = null, $dasVmConfigSpec = null, $drsConfig = null, $drsVmConfigSpec = null, $rulesSpec = null) {
		$this->dasConfig = $dasConfig;
		$this->dasVmConfigSpec = $dasVmConfigSpec;
		$this->drsConfig = $drsConfig;
		$this->drsVmConfigSpec = $drsVmConfigSpec;
		$this->rulesSpec = $rulesSpec;
	}
}

class ClusterDasVmConfigSpec {
	public $info; //ClusterDasVmConfigInfo

	function __construct($info = null) {
		$this->info = $info;
	}
}

class ArrayOfClusterDasVmConfigSpec {
	public $ClusterDasVmConfigSpec; //ClusterDasVmConfigSpec

	function __construct($ClusterDasVmConfigSpec = null) {
		$this->ClusterDasVmConfigSpec = $ClusterDasVmConfigSpec;
	}
}

class ClusterDrsVmConfigSpec {
	public $info; //ClusterDrsVmConfigInfo

	function __construct($info = null) {
		$this->info = $info;
	}
}

class ArrayOfClusterDrsVmConfigSpec {
	public $ClusterDrsVmConfigSpec; //ClusterDrsVmConfigSpec

	function __construct($ClusterDrsVmConfigSpec = null) {
		$this->ClusterDrsVmConfigSpec = $ClusterDrsVmConfigSpec;
	}
}

class ClusterConfigSpecEx {
	public $dasConfig; //ClusterDasConfigInfo
	public $dasVmConfigSpec; //ClusterDasVmConfigSpec
	public $drsConfig; //ClusterDrsConfigInfo
	public $drsVmConfigSpec; //ClusterDrsVmConfigSpec
	public $rulesSpec; //ClusterRuleSpec
	public $dpmConfig; //ClusterDpmConfigInfo
	public $dpmHostConfigSpec; //ClusterDpmHostConfigSpec
	public $groupSpec; //ClusterGroupSpec

	function __construct($dasConfig = null, $dasVmConfigSpec = null, $drsConfig = null, $drsVmConfigSpec = null, $rulesSpec = null, $dpmConfig = null, $dpmHostConfigSpec = null, $groupSpec = null) {
		$this->dasConfig = $dasConfig;
		$this->dasVmConfigSpec = $dasVmConfigSpec;
		$this->drsConfig = $drsConfig;
		$this->drsVmConfigSpec = $drsVmConfigSpec;
		$this->rulesSpec = $rulesSpec;
		$this->dpmConfig = $dpmConfig;
		$this->dpmHostConfigSpec = $dpmHostConfigSpec;
		$this->groupSpec = $groupSpec;
	}
}

class ClusterDpmHostConfigSpec {
	public $info; //ClusterDpmHostConfigInfo

	function __construct($info = null) {
		$this->info = $info;
	}
}

class ArrayOfClusterDpmHostConfigSpec {
	public $ClusterDpmHostConfigSpec; //ClusterDpmHostConfigSpec

	function __construct($ClusterDpmHostConfigSpec = null) {
		$this->ClusterDpmHostConfigSpec = $ClusterDpmHostConfigSpec;
	}
}

class ClusterGroupSpec {
	public $info; //ClusterGroupInfo

	function __construct($info = null) {
		$this->info = $info;
	}
}

class ArrayOfClusterGroupSpec {
	public $ClusterGroupSpec; //ClusterGroupSpec

	function __construct($ClusterGroupSpec = null) {
		$this->ClusterGroupSpec = $ClusterGroupSpec;
	}
}

class ClusterDasAamHostInfo {
	public $hostDasState; //ClusterDasAamNodeState
	public $primaryHosts; //string

	function __construct($hostDasState = null, $primaryHosts = null) {
		$this->hostDasState = $hostDasState;
		$this->primaryHosts = $primaryHosts;
	}
}

class ClusterDasAamNodeState {
	public $host; //ManagedObjectReference
	public $name; //string
	public $configState; //string
	public $runtimeState; //string

	function __construct($host = null, $name = null, $configState = null, $runtimeState = null) {
		$this->host = $host;
		$this->name = $name;
		$this->configState = $configState;
		$this->runtimeState = $runtimeState;
	}
}

class ArrayOfClusterDasAamNodeState {
	public $ClusterDasAamNodeState; //ClusterDasAamNodeState

	function __construct($ClusterDasAamNodeState = null) {
		$this->ClusterDasAamNodeState = $ClusterDasAamNodeState;
	}
}

class ClusterDasAdmissionControlInfo {
}

class ClusterDasAdmissionControlPolicy {
}

class DasHeartbeatDatastoreInfo {
	public $datastore; //ManagedObjectReference
	public $hosts; //ManagedObjectReference

	function __construct($datastore = null, $hosts = null) {
		$this->datastore = $datastore;
		$this->hosts = $hosts;
	}
}

class ArrayOfDasHeartbeatDatastoreInfo {
	public $DasHeartbeatDatastoreInfo; //DasHeartbeatDatastoreInfo

	function __construct($DasHeartbeatDatastoreInfo = null) {
		$this->DasHeartbeatDatastoreInfo = $DasHeartbeatDatastoreInfo;
	}
}

class ClusterDasAdvancedRuntimeInfo {
	public $dasHostInfo; //ClusterDasHostInfo
	public $heartbeatDatastoreInfo; //DasHeartbeatDatastoreInfo

	function __construct($dasHostInfo = null, $heartbeatDatastoreInfo = null) {
		$this->dasHostInfo = $dasHostInfo;
		$this->heartbeatDatastoreInfo = $heartbeatDatastoreInfo;
	}
}

class ClusterDasConfigInfo {
	public $enabled; //boolean
	public $vmMonitoring; //string
	public $hostMonitoring; //string
	public $failoverLevel; //int
	public $admissionControlPolicy; //ClusterDasAdmissionControlPolicy
	public $admissionControlEnabled; //boolean
	public $defaultVmSettings; //ClusterDasVmSettings
	public $option; //OptionValue
	public $heartbeatDatastore; //ManagedObjectReference
	public $hBDatastoreCandidatePolicy; //string

	function __construct($enabled = null, $vmMonitoring = null, $hostMonitoring = null, $failoverLevel = null, $admissionControlPolicy = null, $admissionControlEnabled = null, $defaultVmSettings = null, $option = null, $heartbeatDatastore = null, $hBDatastoreCandidatePolicy = null) {
		$this->enabled = $enabled;
		$this->vmMonitoring = $vmMonitoring;
		$this->hostMonitoring = $hostMonitoring;
		$this->failoverLevel = $failoverLevel;
		$this->admissionControlPolicy = $admissionControlPolicy;
		$this->admissionControlEnabled = $admissionControlEnabled;
		$this->defaultVmSettings = $defaultVmSettings;
		$this->option = $option;
		$this->heartbeatDatastore = $heartbeatDatastore;
		$this->hBDatastoreCandidatePolicy = $hBDatastoreCandidatePolicy;
	}
}

class ClusterDasData {
}

class ClusterDasDataSummary {
	public $hostListVersion; //long
	public $clusterConfigVersion; //long
	public $compatListVersion; //long

	function __construct($hostListVersion = null, $clusterConfigVersion = null, $compatListVersion = null) {
		$this->hostListVersion = $hostListVersion;
		$this->clusterConfigVersion = $clusterConfigVersion;
		$this->compatListVersion = $compatListVersion;
	}
}

class ClusterDasFailoverLevelAdvancedRuntimeInfoSlotInfo {
	public $numVcpus; //int
	public $cpuMHz; //int
	public $memoryMB; //int

	function __construct($numVcpus = null, $cpuMHz = null, $memoryMB = null) {
		$this->numVcpus = $numVcpus;
		$this->cpuMHz = $cpuMHz;
		$this->memoryMB = $memoryMB;
	}
}

class ClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots {
	public $host; //ManagedObjectReference
	public $slots; //int

	function __construct($host = null, $slots = null) {
		$this->host = $host;
		$this->slots = $slots;
	}
}

class ArrayOfClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots {
	public $ClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots; //ClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots

	function __construct($ClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots = null) {
		$this->ClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots = $ClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots;
	}
}

class ClusterDasFailoverLevelAdvancedRuntimeInfo {
	public $slotInfo; //ClusterDasFailoverLevelAdvancedRuntimeInfoSlotInfo
	public $totalSlots; //int
	public $usedSlots; //int
	public $unreservedSlots; //int
	public $totalVms; //int
	public $totalHosts; //int
	public $totalGoodHosts; //int
	public $hostSlots; //ClusterDasFailoverLevelAdvancedRuntimeInfoHostSlots

	function __construct($slotInfo = null, $totalSlots = null, $usedSlots = null, $unreservedSlots = null, $totalVms = null, $totalHosts = null, $totalGoodHosts = null, $hostSlots = null) {
		$this->slotInfo = $slotInfo;
		$this->totalSlots = $totalSlots;
		$this->usedSlots = $usedSlots;
		$this->unreservedSlots = $unreservedSlots;
		$this->totalVms = $totalVms;
		$this->totalHosts = $totalHosts;
		$this->totalGoodHosts = $totalGoodHosts;
		$this->hostSlots = $hostSlots;
	}
}

class ClusterDasFdmHostState {
	public $state; //string
	public $stateReporter; //ManagedObjectReference

	function __construct($state = null, $stateReporter = null) {
		$this->state = $state;
		$this->stateReporter = $stateReporter;
	}
}

class ClusterDasHostInfo {
}

class ClusterDasHostRecommendation {
	public $host; //ManagedObjectReference
	public $drsRating; //int

	function __construct($host = null, $drsRating = null) {
		$this->host = $host;
		$this->drsRating = $drsRating;
	}
}

class ClusterDasVmConfigInfo {
	public $key; //ManagedObjectReference
	public $restartPriority; //DasVmPriority
	public $powerOffOnIsolation; //boolean
	public $dasSettings; //ClusterDasVmSettings

	function __construct($key = null, $restartPriority = null, $powerOffOnIsolation = null, $dasSettings = null) {
		$this->key = $key;
		$this->restartPriority = $restartPriority;
		$this->powerOffOnIsolation = $powerOffOnIsolation;
		$this->dasSettings = $dasSettings;
	}
}

class ArrayOfClusterDasVmConfigInfo {
	public $ClusterDasVmConfigInfo; //ClusterDasVmConfigInfo

	function __construct($ClusterDasVmConfigInfo = null) {
		$this->ClusterDasVmConfigInfo = $ClusterDasVmConfigInfo;
	}
}

class ClusterDasVmSettings {
	public $restartPriority; //string
	public $isolationResponse; //string
	public $vmToolsMonitoringSettings; //ClusterVmToolsMonitoringSettings

	function __construct($restartPriority = null, $isolationResponse = null, $vmToolsMonitoringSettings = null) {
		$this->restartPriority = $restartPriority;
		$this->isolationResponse = $isolationResponse;
		$this->vmToolsMonitoringSettings = $vmToolsMonitoringSettings;
	}
}

class ClusterDrsFaultsFaultsByVm {
	public $vm; //ManagedObjectReference
	public $fault; //LocalizedMethodFault

	function __construct($vm = null, $fault = null) {
		$this->vm = $vm;
		$this->fault = $fault;
	}
}

class ArrayOfClusterDrsFaultsFaultsByVm {
	public $ClusterDrsFaultsFaultsByVm; //ClusterDrsFaultsFaultsByVm

	function __construct($ClusterDrsFaultsFaultsByVm = null) {
		$this->ClusterDrsFaultsFaultsByVm = $ClusterDrsFaultsFaultsByVm;
	}
}

class ClusterDrsFaultsFaultsByVirtualDisk {
	public $disk; //VirtualDiskId

	function __construct($disk = null) {
		$this->disk = $disk;
	}
}

class ClusterDrsFaults {
	public $reason; //string
	public $faultsByVm; //ClusterDrsFaultsFaultsByVm

	function __construct($reason = null, $faultsByVm = null) {
		$this->reason = $reason;
		$this->faultsByVm = $faultsByVm;
	}
}

class ArrayOfClusterDrsFaults {
	public $ClusterDrsFaults; //ClusterDrsFaults

	function __construct($ClusterDrsFaults = null) {
		$this->ClusterDrsFaults = $ClusterDrsFaults;
	}
}

class ClusterDrsMigration {
	public $key; //string
	public $time; //dateTime
	public $vm; //ManagedObjectReference
	public $cpuLoad; //int
	public $memoryLoad; //long
	public $source; //ManagedObjectReference
	public $sourceCpuLoad; //int
	public $sourceMemoryLoad; //long
	public $destination; //ManagedObjectReference
	public $destinationCpuLoad; //int
	public $destinationMemoryLoad; //long

	function __construct($key = null, $time = null, $vm = null, $cpuLoad = null, $memoryLoad = null, $source = null, $sourceCpuLoad = null, $sourceMemoryLoad = null, $destination = null, $destinationCpuLoad = null, $destinationMemoryLoad = null) {
		$this->key = $key;
		$this->time = $time;
		$this->vm = $vm;
		$this->cpuLoad = $cpuLoad;
		$this->memoryLoad = $memoryLoad;
		$this->source = $source;
		$this->sourceCpuLoad = $sourceCpuLoad;
		$this->sourceMemoryLoad = $sourceMemoryLoad;
		$this->destination = $destination;
		$this->destinationCpuLoad = $destinationCpuLoad;
		$this->destinationMemoryLoad = $destinationMemoryLoad;
	}
}

class ArrayOfClusterDrsMigration {
	public $ClusterDrsMigration; //ClusterDrsMigration

	function __construct($ClusterDrsMigration = null) {
		$this->ClusterDrsMigration = $ClusterDrsMigration;
	}
}

class ClusterDrsRecommendation {
	public $key; //string
	public $rating; //int
	public $reason; //string
	public $reasonText; //string
	public $migrationList; //ClusterDrsMigration

	function __construct($key = null, $rating = null, $reason = null, $reasonText = null, $migrationList = null) {
		$this->key = $key;
		$this->rating = $rating;
		$this->reason = $reason;
		$this->reasonText = $reasonText;
		$this->migrationList = $migrationList;
	}
}

class ArrayOfClusterDrsRecommendation {
	public $ClusterDrsRecommendation; //ClusterDrsRecommendation

	function __construct($ClusterDrsRecommendation = null) {
		$this->ClusterDrsRecommendation = $ClusterDrsRecommendation;
	}
}

class ClusterEnterMaintenanceResult {
	public $recommendations; //ClusterRecommendation
	public $fault; //ClusterDrsFaults

	function __construct($recommendations = null, $fault = null) {
		$this->recommendations = $recommendations;
		$this->fault = $fault;
	}
}

class ClusterFailoverHostAdmissionControlInfoHostStatus {
	public $host; //ManagedObjectReference
	public $status; //ManagedEntityStatus

	function __construct($host = null, $status = null) {
		$this->host = $host;
		$this->status = $status;
	}
}

class ArrayOfClusterFailoverHostAdmissionControlInfoHostStatus {
	public $ClusterFailoverHostAdmissionControlInfoHostStatus; //ClusterFailoverHostAdmissionControlInfoHostStatus

	function __construct($ClusterFailoverHostAdmissionControlInfoHostStatus = null) {
		$this->ClusterFailoverHostAdmissionControlInfoHostStatus = $ClusterFailoverHostAdmissionControlInfoHostStatus;
	}
}

class ClusterFailoverHostAdmissionControlInfo {
	public $hostStatus; //ClusterFailoverHostAdmissionControlInfoHostStatus

	function __construct($hostStatus = null) {
		$this->hostStatus = $hostStatus;
	}
}

class ClusterFailoverHostAdmissionControlPolicy {
	public $failoverHosts; //ManagedObjectReference

	function __construct($failoverHosts = null) {
		$this->failoverHosts = $failoverHosts;
	}
}

class ClusterFailoverLevelAdmissionControlInfo {
	public $currentFailoverLevel; //int

	function __construct($currentFailoverLevel = null) {
		$this->currentFailoverLevel = $currentFailoverLevel;
	}
}

class ClusterFailoverLevelAdmissionControlPolicy {
	public $failoverLevel; //int

	function __construct($failoverLevel = null) {
		$this->failoverLevel = $failoverLevel;
	}
}

class ClusterFailoverResourcesAdmissionControlInfo {
	public $currentCpuFailoverResourcesPercent; //int
	public $currentMemoryFailoverResourcesPercent; //int

	function __construct($currentCpuFailoverResourcesPercent = null, $currentMemoryFailoverResourcesPercent = null) {
		$this->currentCpuFailoverResourcesPercent = $currentCpuFailoverResourcesPercent;
		$this->currentMemoryFailoverResourcesPercent = $currentMemoryFailoverResourcesPercent;
	}
}

class ClusterFailoverResourcesAdmissionControlPolicy {
	public $cpuFailoverResourcesPercent; //int
	public $memoryFailoverResourcesPercent; //int

	function __construct($cpuFailoverResourcesPercent = null, $memoryFailoverResourcesPercent = null) {
		$this->cpuFailoverResourcesPercent = $cpuFailoverResourcesPercent;
		$this->memoryFailoverResourcesPercent = $memoryFailoverResourcesPercent;
	}
}

class ClusterGroupInfo {
	public $name; //string
	public $userCreated; //boolean

	function __construct($name = null, $userCreated = null) {
		$this->name = $name;
		$this->userCreated = $userCreated;
	}
}

class ArrayOfClusterGroupInfo {
	public $ClusterGroupInfo; //ClusterGroupInfo

	function __construct($ClusterGroupInfo = null) {
		$this->ClusterGroupInfo = $ClusterGroupInfo;
	}
}

class ClusterHostGroup {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class ClusterHostPowerAction {
	public $operationType; //HostPowerOperationType
	public $powerConsumptionWatt; //int
	public $cpuCapacityMHz; //int
	public $memCapacityMB; //int

	function __construct($operationType = null, $powerConsumptionWatt = null, $cpuCapacityMHz = null, $memCapacityMB = null) {
		$this->operationType = $operationType;
		$this->powerConsumptionWatt = $powerConsumptionWatt;
		$this->cpuCapacityMHz = $cpuCapacityMHz;
		$this->memCapacityMB = $memCapacityMB;
	}
}

class ClusterHostRecommendation {
	public $host; //ManagedObjectReference
	public $rating; //int

	function __construct($host = null, $rating = null) {
		$this->host = $host;
		$this->rating = $rating;
	}
}

class ArrayOfClusterHostRecommendation {
	public $ClusterHostRecommendation; //ClusterHostRecommendation

	function __construct($ClusterHostRecommendation = null) {
		$this->ClusterHostRecommendation = $ClusterHostRecommendation;
	}
}

class ClusterInitialPlacementAction {
	public $targetHost; //ManagedObjectReference
	public $pool; //ManagedObjectReference

	function __construct($targetHost = null, $pool = null) {
		$this->targetHost = $targetHost;
		$this->pool = $pool;
	}
}

class ClusterMigrationAction {
	public $drsMigration; //ClusterDrsMigration

	function __construct($drsMigration = null) {
		$this->drsMigration = $drsMigration;
	}
}

class ClusterNotAttemptedVmInfo {
	public $vm; //ManagedObjectReference
	public $fault; //LocalizedMethodFault

	function __construct($vm = null, $fault = null) {
		$this->vm = $vm;
		$this->fault = $fault;
	}
}

class ArrayOfClusterNotAttemptedVmInfo {
	public $ClusterNotAttemptedVmInfo; //ClusterNotAttemptedVmInfo

	function __construct($ClusterNotAttemptedVmInfo = null) {
		$this->ClusterNotAttemptedVmInfo = $ClusterNotAttemptedVmInfo;
	}
}

class ClusterPowerOnVmResult {
	public $attempted; //ClusterAttemptedVmInfo
	public $notAttempted; //ClusterNotAttemptedVmInfo
	public $recommendations; //ClusterRecommendation

	function __construct($attempted = null, $notAttempted = null, $recommendations = null) {
		$this->attempted = $attempted;
		$this->notAttempted = $notAttempted;
		$this->recommendations = $recommendations;
	}
}

class ClusterRecommendation {
	public $key; //string
	public $type; //string
	public $time; //dateTime
	public $rating; //int
	public $reason; //string
	public $reasonText; //string
	public $prerequisite; //string
	public $action; //ClusterAction
	public $target; //ManagedObjectReference

	function __construct($key = null, $type = null, $time = null, $rating = null, $reason = null, $reasonText = null, $prerequisite = null, $action = null, $target = null) {
		$this->key = $key;
		$this->type = $type;
		$this->time = $time;
		$this->rating = $rating;
		$this->reason = $reason;
		$this->reasonText = $reasonText;
		$this->prerequisite = $prerequisite;
		$this->action = $action;
		$this->target = $target;
	}
}

class ArrayOfClusterRecommendation {
	public $ClusterRecommendation; //ClusterRecommendation

	function __construct($ClusterRecommendation = null) {
		$this->ClusterRecommendation = $ClusterRecommendation;
	}
}

class ClusterRuleInfo {
	public $key; //int
	public $status; //ManagedEntityStatus
	public $enabled; //boolean
	public $name; //string
	public $mandatory; //boolean
	public $userCreated; //boolean
	public $inCompliance; //boolean

	function __construct($key = null, $status = null, $enabled = null, $name = null, $mandatory = null, $userCreated = null, $inCompliance = null) {
		$this->key = $key;
		$this->status = $status;
		$this->enabled = $enabled;
		$this->name = $name;
		$this->mandatory = $mandatory;
		$this->userCreated = $userCreated;
		$this->inCompliance = $inCompliance;
	}
}

class ArrayOfClusterRuleInfo {
	public $ClusterRuleInfo; //ClusterRuleInfo

	function __construct($ClusterRuleInfo = null) {
		$this->ClusterRuleInfo = $ClusterRuleInfo;
	}
}

class ClusterRuleSpec {
	public $info; //ClusterRuleInfo

	function __construct($info = null) {
		$this->info = $info;
	}
}

class ArrayOfClusterRuleSpec {
	public $ClusterRuleSpec; //ClusterRuleSpec

	function __construct($ClusterRuleSpec = null) {
		$this->ClusterRuleSpec = $ClusterRuleSpec;
	}
}

class ClusterVmGroup {
	public $vm; //ManagedObjectReference

	function __construct($vm = null) {
		$this->vm = $vm;
	}
}

class ClusterVmHostRuleInfo {
	public $vmGroupName; //string
	public $affineHostGroupName; //string
	public $antiAffineHostGroupName; //string

	function __construct($vmGroupName = null, $affineHostGroupName = null, $antiAffineHostGroupName = null) {
		$this->vmGroupName = $vmGroupName;
		$this->affineHostGroupName = $affineHostGroupName;
		$this->antiAffineHostGroupName = $antiAffineHostGroupName;
	}
}

class ClusterVmToolsMonitoringSettings {
	public $enabled; //boolean
	public $vmMonitoring; //string
	public $clusterSettings; //boolean
	public $failureInterval; //int
	public $minUpTime; //int
	public $maxFailures; //int
	public $maxFailureWindow; //int

	function __construct($enabled = null, $vmMonitoring = null, $clusterSettings = null, $failureInterval = null, $minUpTime = null, $maxFailures = null, $maxFailureWindow = null) {
		$this->enabled = $enabled;
		$this->vmMonitoring = $vmMonitoring;
		$this->clusterSettings = $clusterSettings;
		$this->failureInterval = $failureInterval;
		$this->minUpTime = $minUpTime;
		$this->maxFailures = $maxFailures;
		$this->maxFailureWindow = $maxFailureWindow;
	}
}

class DVPortConfigSpec {
	public $operation; //string
	public $key; //string
	public $name; //string
	public $scope; //ManagedObjectReference
	public $description; //string
	public $setting; //DVPortSetting
	public $configVersion; //string

	function __construct($operation = null, $key = null, $name = null, $scope = null, $description = null, $setting = null, $configVersion = null) {
		$this->operation = $operation;
		$this->key = $key;
		$this->name = $name;
		$this->scope = $scope;
		$this->description = $description;
		$this->setting = $setting;
		$this->configVersion = $configVersion;
	}
}

class ArrayOfDVPortConfigSpec {
	public $DVPortConfigSpec; //DVPortConfigSpec

	function __construct($DVPortConfigSpec = null) {
		$this->DVPortConfigSpec = $DVPortConfigSpec;
	}
}

class DVPortConfigInfo {
	public $name; //string
	public $scope; //ManagedObjectReference
	public $description; //string
	public $setting; //DVPortSetting
	public $configVersion; //string

	function __construct($name = null, $scope = null, $description = null, $setting = null, $configVersion = null) {
		$this->name = $name;
		$this->scope = $scope;
		$this->description = $description;
		$this->setting = $setting;
		$this->configVersion = $configVersion;
	}
}

class DVSTrafficShapingPolicy {
	public $enabled; //BoolPolicy
	public $averageBandwidth; //LongPolicy
	public $peakBandwidth; //LongPolicy
	public $burstSize; //LongPolicy

	function __construct($enabled = null, $averageBandwidth = null, $peakBandwidth = null, $burstSize = null) {
		$this->enabled = $enabled;
		$this->averageBandwidth = $averageBandwidth;
		$this->peakBandwidth = $peakBandwidth;
		$this->burstSize = $burstSize;
	}
}

class DVSVendorSpecificConfig {
	public $keyValue; //DistributedVirtualSwitchKeyedOpaqueBlob

	function __construct($keyValue = null) {
		$this->keyValue = $keyValue;
	}
}

class DVPortSetting {
	public $blocked; //BoolPolicy
	public $vmDirectPathGen2Allowed; //BoolPolicy
	public $inShapingPolicy; //DVSTrafficShapingPolicy
	public $outShapingPolicy; //DVSTrafficShapingPolicy
	public $vendorSpecificConfig; //DVSVendorSpecificConfig
	public $networkResourcePoolKey; //StringPolicy

	function __construct($blocked = null, $vmDirectPathGen2Allowed = null, $inShapingPolicy = null, $outShapingPolicy = null, $vendorSpecificConfig = null, $networkResourcePoolKey = null) {
		$this->blocked = $blocked;
		$this->vmDirectPathGen2Allowed = $vmDirectPathGen2Allowed;
		$this->inShapingPolicy = $inShapingPolicy;
		$this->outShapingPolicy = $outShapingPolicy;
		$this->vendorSpecificConfig = $vendorSpecificConfig;
		$this->networkResourcePoolKey = $networkResourcePoolKey;
	}
}

class DVPortStatus {
	public $linkUp; //boolean
	public $blocked; //boolean
	public $vlanIds; //NumericRange
	public $trunkingMode; //boolean
	public $mtu; //int
	public $linkPeer; //string
	public $macAddress; //string
	public $statusDetail; //string
	public $vmDirectPathGen2Active; //boolean
	public $vmDirectPathGen2InactiveReasonNetwork; //string
	public $vmDirectPathGen2InactiveReasonOther; //string
	public $vmDirectPathGen2InactiveReasonExtended; //string

	function __construct($linkUp = null, $blocked = null, $vlanIds = null, $trunkingMode = null, $mtu = null, $linkPeer = null, $macAddress = null, $statusDetail = null, $vmDirectPathGen2Active = null, $vmDirectPathGen2InactiveReasonNetwork = null, $vmDirectPathGen2InactiveReasonOther = null, $vmDirectPathGen2InactiveReasonExtended = null) {
		$this->linkUp = $linkUp;
		$this->blocked = $blocked;
		$this->vlanIds = $vlanIds;
		$this->trunkingMode = $trunkingMode;
		$this->mtu = $mtu;
		$this->linkPeer = $linkPeer;
		$this->macAddress = $macAddress;
		$this->statusDetail = $statusDetail;
		$this->vmDirectPathGen2Active = $vmDirectPathGen2Active;
		$this->vmDirectPathGen2InactiveReasonNetwork = $vmDirectPathGen2InactiveReasonNetwork;
		$this->vmDirectPathGen2InactiveReasonOther = $vmDirectPathGen2InactiveReasonOther;
		$this->vmDirectPathGen2InactiveReasonExtended = $vmDirectPathGen2InactiveReasonExtended;
	}
}

class DVPortState {
	public $runtimeInfo; //DVPortStatus
	public $stats; //DistributedVirtualSwitchPortStatistics
	public $vendorSpecificState; //DistributedVirtualSwitchKeyedOpaqueBlob

	function __construct($runtimeInfo = null, $stats = null, $vendorSpecificState = null) {
		$this->runtimeInfo = $runtimeInfo;
		$this->stats = $stats;
		$this->vendorSpecificState = $vendorSpecificState;
	}
}

class DistributedVirtualPort {
	public $key; //string
	public $config; //DVPortConfigInfo
	public $dvsUuid; //string
	public $portgroupKey; //string
	public $proxyHost; //ManagedObjectReference
	public $connectee; //DistributedVirtualSwitchPortConnectee
	public $conflict; //boolean
	public $conflictPortKey; //string
	public $state; //DVPortState
	public $connectionCookie; //int
	public $lastStatusChange; //dateTime

	function __construct($key = null, $config = null, $dvsUuid = null, $portgroupKey = null, $proxyHost = null, $connectee = null, $conflict = null, $conflictPortKey = null, $state = null, $connectionCookie = null, $lastStatusChange = null) {
		$this->key = $key;
		$this->config = $config;
		$this->dvsUuid = $dvsUuid;
		$this->portgroupKey = $portgroupKey;
		$this->proxyHost = $proxyHost;
		$this->connectee = $connectee;
		$this->conflict = $conflict;
		$this->conflictPortKey = $conflictPortKey;
		$this->state = $state;
		$this->connectionCookie = $connectionCookie;
		$this->lastStatusChange = $lastStatusChange;
	}
}

class ArrayOfDistributedVirtualPort {
	public $DistributedVirtualPort; //DistributedVirtualPort

	function __construct($DistributedVirtualPort = null) {
		$this->DistributedVirtualPort = $DistributedVirtualPort;
	}
}

class DVPortgroupPolicy {
	public $blockOverrideAllowed; //boolean
	public $shapingOverrideAllowed; //boolean
	public $vendorConfigOverrideAllowed; //boolean
	public $livePortMovingAllowed; //boolean
	public $portConfigResetAtDisconnect; //boolean
	public $networkResourcePoolOverrideAllowed; //boolean

	function __construct($blockOverrideAllowed = null, $shapingOverrideAllowed = null, $vendorConfigOverrideAllowed = null, $livePortMovingAllowed = null, $portConfigResetAtDisconnect = null, $networkResourcePoolOverrideAllowed = null) {
		$this->blockOverrideAllowed = $blockOverrideAllowed;
		$this->shapingOverrideAllowed = $shapingOverrideAllowed;
		$this->vendorConfigOverrideAllowed = $vendorConfigOverrideAllowed;
		$this->livePortMovingAllowed = $livePortMovingAllowed;
		$this->portConfigResetAtDisconnect = $portConfigResetAtDisconnect;
		$this->networkResourcePoolOverrideAllowed = $networkResourcePoolOverrideAllowed;
	}
}

class DVPortgroupConfigSpec {
	public $configVersion; //string
	public $name; //string
	public $numPorts; //int
	public $portNameFormat; //string
	public $defaultPortConfig; //DVPortSetting
	public $description; //string
	public $type; //string
	public $scope; //ManagedObjectReference
	public $policy; //DVPortgroupPolicy
	public $vendorSpecificConfig; //DistributedVirtualSwitchKeyedOpaqueBlob
	public $autoExpand; //boolean

	function __construct($configVersion = null, $name = null, $numPorts = null, $portNameFormat = null, $defaultPortConfig = null, $description = null, $type = null, $scope = null, $policy = null, $vendorSpecificConfig = null, $autoExpand = null) {
		$this->configVersion = $configVersion;
		$this->name = $name;
		$this->numPorts = $numPorts;
		$this->portNameFormat = $portNameFormat;
		$this->defaultPortConfig = $defaultPortConfig;
		$this->description = $description;
		$this->type = $type;
		$this->scope = $scope;
		$this->policy = $policy;
		$this->vendorSpecificConfig = $vendorSpecificConfig;
		$this->autoExpand = $autoExpand;
	}
}

class ArrayOfDVPortgroupConfigSpec {
	public $DVPortgroupConfigSpec; //DVPortgroupConfigSpec

	function __construct($DVPortgroupConfigSpec = null) {
		$this->DVPortgroupConfigSpec = $DVPortgroupConfigSpec;
	}
}

class DVPortgroupConfigInfo {
	public $key; //string
	public $name; //string
	public $numPorts; //int
	public $distributedVirtualSwitch; //ManagedObjectReference
	public $defaultPortConfig; //DVPortSetting
	public $description; //string
	public $type; //string
	public $policy; //DVPortgroupPolicy
	public $portNameFormat; //string
	public $scope; //ManagedObjectReference
	public $vendorSpecificConfig; //DistributedVirtualSwitchKeyedOpaqueBlob
	public $configVersion; //string
	public $autoExpand; //boolean

	function __construct($key = null, $name = null, $numPorts = null, $distributedVirtualSwitch = null, $defaultPortConfig = null, $description = null, $type = null, $policy = null, $portNameFormat = null, $scope = null, $vendorSpecificConfig = null, $configVersion = null, $autoExpand = null) {
		$this->key = $key;
		$this->name = $name;
		$this->numPorts = $numPorts;
		$this->distributedVirtualSwitch = $distributedVirtualSwitch;
		$this->defaultPortConfig = $defaultPortConfig;
		$this->description = $description;
		$this->type = $type;
		$this->policy = $policy;
		$this->portNameFormat = $portNameFormat;
		$this->scope = $scope;
		$this->vendorSpecificConfig = $vendorSpecificConfig;
		$this->configVersion = $configVersion;
		$this->autoExpand = $autoExpand;
	}
}

class DistributedVirtualPortgroupInfo {
	public $switchName; //string
	public $switchUuid; //string
	public $portgroupName; //string
	public $portgroupKey; //string
	public $portgroupType; //string
	public $uplinkPortgroup; //boolean
	public $portgroup; //ManagedObjectReference

	function __construct($switchName = null, $switchUuid = null, $portgroupName = null, $portgroupKey = null, $portgroupType = null, $uplinkPortgroup = null, $portgroup = null) {
		$this->switchName = $switchName;
		$this->switchUuid = $switchUuid;
		$this->portgroupName = $portgroupName;
		$this->portgroupKey = $portgroupKey;
		$this->portgroupType = $portgroupType;
		$this->uplinkPortgroup = $uplinkPortgroup;
		$this->portgroup = $portgroup;
	}
}

class ArrayOfDistributedVirtualPortgroupInfo {
	public $DistributedVirtualPortgroupInfo; //DistributedVirtualPortgroupInfo

	function __construct($DistributedVirtualPortgroupInfo = null) {
		$this->DistributedVirtualPortgroupInfo = $DistributedVirtualPortgroupInfo;
	}
}

class DistributedVirtualSwitchInfo {
	public $switchName; //string
	public $switchUuid; //string
	public $distributedVirtualSwitch; //ManagedObjectReference

	function __construct($switchName = null, $switchUuid = null, $distributedVirtualSwitch = null) {
		$this->switchName = $switchName;
		$this->switchUuid = $switchUuid;
		$this->distributedVirtualSwitch = $distributedVirtualSwitch;
	}
}

class ArrayOfDistributedVirtualSwitchInfo {
	public $DistributedVirtualSwitchInfo; //DistributedVirtualSwitchInfo

	function __construct($DistributedVirtualSwitchInfo = null) {
		$this->DistributedVirtualSwitchInfo = $DistributedVirtualSwitchInfo;
	}
}

class DVSManagerDvsConfigTarget {
	public $distributedVirtualPortgroup; //DistributedVirtualPortgroupInfo
	public $distributedVirtualSwitch; //DistributedVirtualSwitchInfo

	function __construct($distributedVirtualPortgroup = null, $distributedVirtualSwitch = null) {
		$this->distributedVirtualPortgroup = $distributedVirtualPortgroup;
		$this->distributedVirtualSwitch = $distributedVirtualSwitch;
	}
}

class DistributedVirtualSwitchManagerCompatibilityResult {
	public $host; //ManagedObjectReference
	public $error; //LocalizedMethodFault

	function __construct($host = null, $error = null) {
		$this->host = $host;
		$this->error = $error;
	}
}

class ArrayOfDistributedVirtualSwitchManagerCompatibilityResult {
	public $DistributedVirtualSwitchManagerCompatibilityResult; //DistributedVirtualSwitchManagerCompatibilityResult

	function __construct($DistributedVirtualSwitchManagerCompatibilityResult = null) {
		$this->DistributedVirtualSwitchManagerCompatibilityResult = $DistributedVirtualSwitchManagerCompatibilityResult;
	}
}

class DistributedVirtualSwitchManagerHostContainer {
	public $container; //ManagedObjectReference
	public $recursive; //boolean

	function __construct($container = null, $recursive = null) {
		$this->container = $container;
		$this->recursive = $recursive;
	}
}

class DistributedVirtualSwitchManagerHostDvsFilterSpec {
	public $inclusive; //boolean

	function __construct($inclusive = null) {
		$this->inclusive = $inclusive;
	}
}

class ArrayOfDistributedVirtualSwitchManagerHostDvsFilterSpec {
	public $DistributedVirtualSwitchManagerHostDvsFilterSpec; //DistributedVirtualSwitchManagerHostDvsFilterSpec

	function __construct($DistributedVirtualSwitchManagerHostDvsFilterSpec = null) {
		$this->DistributedVirtualSwitchManagerHostDvsFilterSpec = $DistributedVirtualSwitchManagerHostDvsFilterSpec;
	}
}

class DistributedVirtualSwitchManagerHostArrayFilter {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class DistributedVirtualSwitchManagerHostContainerFilter {
	public $hostContainer; //DistributedVirtualSwitchManagerHostContainer

	function __construct($hostContainer = null) {
		$this->hostContainer = $hostContainer;
	}
}

class DistributedVirtualSwitchManagerHostDvsMembershipFilter {
	public $distributedVirtualSwitch; //ManagedObjectReference

	function __construct($distributedVirtualSwitch = null) {
		$this->distributedVirtualSwitch = $distributedVirtualSwitch;
	}
}

class DistributedVirtualSwitchManagerDvsProductSpec {
	public $newSwitchProductSpec; //DistributedVirtualSwitchProductSpec
	public $distributedVirtualSwitch; //ManagedObjectReference

	function __construct($newSwitchProductSpec = null, $distributedVirtualSwitch = null) {
		$this->newSwitchProductSpec = $newSwitchProductSpec;
		$this->distributedVirtualSwitch = $distributedVirtualSwitch;
	}
}

class DistributedVirtualSwitchHostMemberConfigSpec {
	public $operation; //string
	public $host; //ManagedObjectReference
	public $backing; //DistributedVirtualSwitchHostMemberBacking
	public $maxProxySwitchPorts; //int
	public $vendorSpecificConfig; //DistributedVirtualSwitchKeyedOpaqueBlob

	function __construct($operation = null, $host = null, $backing = null, $maxProxySwitchPorts = null, $vendorSpecificConfig = null) {
		$this->operation = $operation;
		$this->host = $host;
		$this->backing = $backing;
		$this->maxProxySwitchPorts = $maxProxySwitchPorts;
		$this->vendorSpecificConfig = $vendorSpecificConfig;
	}
}

class ArrayOfDistributedVirtualSwitchHostMemberConfigSpec {
	public $DistributedVirtualSwitchHostMemberConfigSpec; //DistributedVirtualSwitchHostMemberConfigSpec

	function __construct($DistributedVirtualSwitchHostMemberConfigSpec = null) {
		$this->DistributedVirtualSwitchHostMemberConfigSpec = $DistributedVirtualSwitchHostMemberConfigSpec;
	}
}

class DistributedVirtualSwitchHostMemberPnicSpec {
	public $pnicDevice; //string
	public $uplinkPortKey; //string
	public $uplinkPortgroupKey; //string
	public $connectionCookie; //int

	function __construct($pnicDevice = null, $uplinkPortKey = null, $uplinkPortgroupKey = null, $connectionCookie = null) {
		$this->pnicDevice = $pnicDevice;
		$this->uplinkPortKey = $uplinkPortKey;
		$this->uplinkPortgroupKey = $uplinkPortgroupKey;
		$this->connectionCookie = $connectionCookie;
	}
}

class ArrayOfDistributedVirtualSwitchHostMemberPnicSpec {
	public $DistributedVirtualSwitchHostMemberPnicSpec; //DistributedVirtualSwitchHostMemberPnicSpec

	function __construct($DistributedVirtualSwitchHostMemberPnicSpec = null) {
		$this->DistributedVirtualSwitchHostMemberPnicSpec = $DistributedVirtualSwitchHostMemberPnicSpec;
	}
}

class DistributedVirtualSwitchHostMemberBacking {
}

class DistributedVirtualSwitchHostMemberPnicBacking {
	public $pnicSpec; //DistributedVirtualSwitchHostMemberPnicSpec

	function __construct($pnicSpec = null) {
		$this->pnicSpec = $pnicSpec;
	}
}

class DistributedVirtualSwitchHostMemberRuntimeState {
	public $currentMaxProxySwitchPorts; //int

	function __construct($currentMaxProxySwitchPorts = null) {
		$this->currentMaxProxySwitchPorts = $currentMaxProxySwitchPorts;
	}
}

class DistributedVirtualSwitchHostMemberConfigInfo {
	public $host; //ManagedObjectReference
	public $maxProxySwitchPorts; //int
	public $vendorSpecificConfig; //DistributedVirtualSwitchKeyedOpaqueBlob
	public $backing; //DistributedVirtualSwitchHostMemberBacking

	function __construct($host = null, $maxProxySwitchPorts = null, $vendorSpecificConfig = null, $backing = null) {
		$this->host = $host;
		$this->maxProxySwitchPorts = $maxProxySwitchPorts;
		$this->vendorSpecificConfig = $vendorSpecificConfig;
		$this->backing = $backing;
	}
}

class DistributedVirtualSwitchHostMember {
	public $runtimeState; //DistributedVirtualSwitchHostMemberRuntimeState
	public $config; //DistributedVirtualSwitchHostMemberConfigInfo
	public $productInfo; //DistributedVirtualSwitchProductSpec
	public $uplinkPortKey; //string
	public $status; //string
	public $statusDetail; //string

	function __construct($runtimeState = null, $config = null, $productInfo = null, $uplinkPortKey = null, $status = null, $statusDetail = null) {
		$this->runtimeState = $runtimeState;
		$this->config = $config;
		$this->productInfo = $productInfo;
		$this->uplinkPortKey = $uplinkPortKey;
		$this->status = $status;
		$this->statusDetail = $statusDetail;
	}
}

class ArrayOfDistributedVirtualSwitchHostMember {
	public $DistributedVirtualSwitchHostMember; //DistributedVirtualSwitchHostMember

	function __construct($DistributedVirtualSwitchHostMember = null) {
		$this->DistributedVirtualSwitchHostMember = $DistributedVirtualSwitchHostMember;
	}
}

class DistributedVirtualSwitchHostProductSpec {
	public $productLineId; //string
	public $version; //string

	function __construct($productLineId = null, $version = null) {
		$this->productLineId = $productLineId;
		$this->version = $version;
	}
}

class ArrayOfDistributedVirtualSwitchHostProductSpec {
	public $DistributedVirtualSwitchHostProductSpec; //DistributedVirtualSwitchHostProductSpec

	function __construct($DistributedVirtualSwitchHostProductSpec = null) {
		$this->DistributedVirtualSwitchHostProductSpec = $DistributedVirtualSwitchHostProductSpec;
	}
}

class DistributedVirtualSwitchKeyedOpaqueBlob {
	public $key; //string
	public $opaqueData; //string

	function __construct($key = null, $opaqueData = null) {
		$this->key = $key;
		$this->opaqueData = $opaqueData;
	}
}

class ArrayOfDistributedVirtualSwitchKeyedOpaqueBlob {
	public $DistributedVirtualSwitchKeyedOpaqueBlob; //DistributedVirtualSwitchKeyedOpaqueBlob

	function __construct($DistributedVirtualSwitchKeyedOpaqueBlob = null) {
		$this->DistributedVirtualSwitchKeyedOpaqueBlob = $DistributedVirtualSwitchKeyedOpaqueBlob;
	}
}

class DVSNetworkResourcePoolAllocationInfo {
	public $limit; //long
	public $shares; //SharesInfo
	public $priorityTag; //int

	function __construct($limit = null, $shares = null, $priorityTag = null) {
		$this->limit = $limit;
		$this->shares = $shares;
		$this->priorityTag = $priorityTag;
	}
}

class DVSNetworkResourcePoolConfigSpec {
	public $key; //string
	public $configVersion; //string
	public $allocationInfo; //DVSNetworkResourcePoolAllocationInfo
	public $name; //string
	public $description; //string

	function __construct($key = null, $configVersion = null, $allocationInfo = null, $name = null, $description = null) {
		$this->key = $key;
		$this->configVersion = $configVersion;
		$this->allocationInfo = $allocationInfo;
		$this->name = $name;
		$this->description = $description;
	}
}

class ArrayOfDVSNetworkResourcePoolConfigSpec {
	public $DVSNetworkResourcePoolConfigSpec; //DVSNetworkResourcePoolConfigSpec

	function __construct($DVSNetworkResourcePoolConfigSpec = null) {
		$this->DVSNetworkResourcePoolConfigSpec = $DVSNetworkResourcePoolConfigSpec;
	}
}

class DVSNetworkResourcePool {
	public $key; //string
	public $name; //string
	public $description; //string
	public $configVersion; //string
	public $allocationInfo; //DVSNetworkResourcePoolAllocationInfo

	function __construct($key = null, $name = null, $description = null, $configVersion = null, $allocationInfo = null) {
		$this->key = $key;
		$this->name = $name;
		$this->description = $description;
		$this->configVersion = $configVersion;
		$this->allocationInfo = $allocationInfo;
	}
}

class ArrayOfDVSNetworkResourcePool {
	public $DVSNetworkResourcePool; //DVSNetworkResourcePool

	function __construct($DVSNetworkResourcePool = null) {
		$this->DVSNetworkResourcePool = $DVSNetworkResourcePool;
	}
}

class DistributedVirtualSwitchPortConnectee {
	public $connectedEntity; //ManagedObjectReference
	public $nicKey; //string
	public $type; //string
	public $addressHint; //string

	function __construct($connectedEntity = null, $nicKey = null, $type = null, $addressHint = null) {
		$this->connectedEntity = $connectedEntity;
		$this->nicKey = $nicKey;
		$this->type = $type;
		$this->addressHint = $addressHint;
	}
}

class DistributedVirtualSwitchPortConnection {
	public $switchUuid; //string
	public $portgroupKey; //string
	public $portKey; //string
	public $connectionCookie; //int

	function __construct($switchUuid = null, $portgroupKey = null, $portKey = null, $connectionCookie = null) {
		$this->switchUuid = $switchUuid;
		$this->portgroupKey = $portgroupKey;
		$this->portKey = $portKey;
		$this->connectionCookie = $connectionCookie;
	}
}

class DistributedVirtualSwitchPortCriteria {
	public $connected; //boolean
	public $active; //boolean
	public $uplinkPort; //boolean
	public $scope; //ManagedObjectReference
	public $portgroupKey; //string
	public $inside; //boolean
	public $portKey; //string

	function __construct($connected = null, $active = null, $uplinkPort = null, $scope = null, $portgroupKey = null, $inside = null, $portKey = null) {
		$this->connected = $connected;
		$this->active = $active;
		$this->uplinkPort = $uplinkPort;
		$this->scope = $scope;
		$this->portgroupKey = $portgroupKey;
		$this->inside = $inside;
		$this->portKey = $portKey;
	}
}

class DistributedVirtualSwitchPortStatistics {
	public $packetsInMulticast; //long
	public $packetsOutMulticast; //long
	public $bytesInMulticast; //long
	public $bytesOutMulticast; //long
	public $packetsInUnicast; //long
	public $packetsOutUnicast; //long
	public $bytesInUnicast; //long
	public $bytesOutUnicast; //long
	public $packetsInBroadcast; //long
	public $packetsOutBroadcast; //long
	public $bytesInBroadcast; //long
	public $bytesOutBroadcast; //long
	public $packetsInDropped; //long
	public $packetsOutDropped; //long
	public $packetsInException; //long
	public $packetsOutException; //long

	function __construct($packetsInMulticast = null, $packetsOutMulticast = null, $bytesInMulticast = null, $bytesOutMulticast = null, $packetsInUnicast = null, $packetsOutUnicast = null, $bytesInUnicast = null, $bytesOutUnicast = null, $packetsInBroadcast = null, $packetsOutBroadcast = null, $bytesInBroadcast = null, $bytesOutBroadcast = null, $packetsInDropped = null, $packetsOutDropped = null, $packetsInException = null, $packetsOutException = null) {
		$this->packetsInMulticast = $packetsInMulticast;
		$this->packetsOutMulticast = $packetsOutMulticast;
		$this->bytesInMulticast = $bytesInMulticast;
		$this->bytesOutMulticast = $bytesOutMulticast;
		$this->packetsInUnicast = $packetsInUnicast;
		$this->packetsOutUnicast = $packetsOutUnicast;
		$this->bytesInUnicast = $bytesInUnicast;
		$this->bytesOutUnicast = $bytesOutUnicast;
		$this->packetsInBroadcast = $packetsInBroadcast;
		$this->packetsOutBroadcast = $packetsOutBroadcast;
		$this->bytesInBroadcast = $bytesInBroadcast;
		$this->bytesOutBroadcast = $bytesOutBroadcast;
		$this->packetsInDropped = $packetsInDropped;
		$this->packetsOutDropped = $packetsOutDropped;
		$this->packetsInException = $packetsInException;
		$this->packetsOutException = $packetsOutException;
	}
}

class DistributedVirtualSwitchProductSpec {
	public $name; //string
	public $vendor; //string
	public $version; //string
	public $build; //string
	public $forwardingClass; //string
	public $bundleId; //string
	public $bundleUrl; //string

	function __construct($name = null, $vendor = null, $version = null, $build = null, $forwardingClass = null, $bundleId = null, $bundleUrl = null) {
		$this->name = $name;
		$this->vendor = $vendor;
		$this->version = $version;
		$this->build = $build;
		$this->forwardingClass = $forwardingClass;
		$this->bundleId = $bundleId;
		$this->bundleUrl = $bundleUrl;
	}
}

class ArrayOfDistributedVirtualSwitchProductSpec {
	public $DistributedVirtualSwitchProductSpec; //DistributedVirtualSwitchProductSpec

	function __construct($DistributedVirtualSwitchProductSpec = null) {
		$this->DistributedVirtualSwitchProductSpec = $DistributedVirtualSwitchProductSpec;
	}
}

class VMwareDVSFeatureCapability {
	public $vspanSupported; //boolean
	public $lldpSupported; //boolean
	public $ipfixSupported; //boolean

	function __construct($vspanSupported = null, $lldpSupported = null, $ipfixSupported = null) {
		$this->vspanSupported = $vspanSupported;
		$this->lldpSupported = $lldpSupported;
		$this->ipfixSupported = $ipfixSupported;
	}
}

class VMwareVspanPort {
	public $portKey; //string
	public $uplinkPortName; //string
	public $wildcardPortConnecteeType; //string

	function __construct($portKey = null, $uplinkPortName = null, $wildcardPortConnecteeType = null) {
		$this->portKey = $portKey;
		$this->uplinkPortName = $uplinkPortName;
		$this->wildcardPortConnecteeType = $wildcardPortConnecteeType;
	}
}

class VMwareVspanSession {
	public $key; //string
	public $name; //string
	public $description; //string
	public $enabled; //boolean
	public $sourcePortTransmitted; //VMwareVspanPort
	public $sourcePortReceived; //VMwareVspanPort
	public $destinationPort; //VMwareVspanPort
	public $encapsulationVlanId; //int
	public $stripOriginalVlan; //boolean
	public $mirroredPacketLength; //int
	public $normalTrafficAllowed; //boolean

	function __construct($key = null, $name = null, $description = null, $enabled = null, $sourcePortTransmitted = null, $sourcePortReceived = null, $destinationPort = null, $encapsulationVlanId = null, $stripOriginalVlan = null, $mirroredPacketLength = null, $normalTrafficAllowed = null) {
		$this->key = $key;
		$this->name = $name;
		$this->description = $description;
		$this->enabled = $enabled;
		$this->sourcePortTransmitted = $sourcePortTransmitted;
		$this->sourcePortReceived = $sourcePortReceived;
		$this->destinationPort = $destinationPort;
		$this->encapsulationVlanId = $encapsulationVlanId;
		$this->stripOriginalVlan = $stripOriginalVlan;
		$this->mirroredPacketLength = $mirroredPacketLength;
		$this->normalTrafficAllowed = $normalTrafficAllowed;
	}
}

class ArrayOfVMwareVspanSession {
	public $VMwareVspanSession; //VMwareVspanSession

	function __construct($VMwareVspanSession = null) {
		$this->VMwareVspanSession = $VMwareVspanSession;
	}
}

class VMwareIpfixConfig {
	public $collectorIpAddress; //string
	public $collectorPort; //int
	public $activeFlowTimeout; //int
	public $idleFlowTimeout; //int
	public $samplingRate; //int
	public $internalFlowsOnly; //boolean

	function __construct($collectorIpAddress = null, $collectorPort = null, $activeFlowTimeout = null, $idleFlowTimeout = null, $samplingRate = null, $internalFlowsOnly = null) {
		$this->collectorIpAddress = $collectorIpAddress;
		$this->collectorPort = $collectorPort;
		$this->activeFlowTimeout = $activeFlowTimeout;
		$this->idleFlowTimeout = $idleFlowTimeout;
		$this->samplingRate = $samplingRate;
		$this->internalFlowsOnly = $internalFlowsOnly;
	}
}

class VMwareDVSConfigInfo {
	public $vspanSession; //VMwareVspanSession
	public $pvlanConfig; //VMwareDVSPvlanMapEntry
	public $maxMtu; //int
	public $linkDiscoveryProtocolConfig; //LinkDiscoveryProtocolConfig
	public $ipfixConfig; //VMwareIpfixConfig

	function __construct($vspanSession = null, $pvlanConfig = null, $maxMtu = null, $linkDiscoveryProtocolConfig = null, $ipfixConfig = null) {
		$this->vspanSession = $vspanSession;
		$this->pvlanConfig = $pvlanConfig;
		$this->maxMtu = $maxMtu;
		$this->linkDiscoveryProtocolConfig = $linkDiscoveryProtocolConfig;
		$this->ipfixConfig = $ipfixConfig;
	}
}

class VMwareDVSConfigSpec {
	public $pvlanConfigSpec; //VMwareDVSPvlanConfigSpec
	public $vspanConfigSpec; //VMwareDVSVspanConfigSpec
	public $maxMtu; //int
	public $linkDiscoveryProtocolConfig; //LinkDiscoveryProtocolConfig
	public $ipfixConfig; //VMwareIpfixConfig

	function __construct($pvlanConfigSpec = null, $vspanConfigSpec = null, $maxMtu = null, $linkDiscoveryProtocolConfig = null, $ipfixConfig = null) {
		$this->pvlanConfigSpec = $pvlanConfigSpec;
		$this->vspanConfigSpec = $vspanConfigSpec;
		$this->maxMtu = $maxMtu;
		$this->linkDiscoveryProtocolConfig = $linkDiscoveryProtocolConfig;
		$this->ipfixConfig = $ipfixConfig;
	}
}

class VMwareUplinkPortOrderPolicy {
	public $activeUplinkPort; //string
	public $standbyUplinkPort; //string

	function __construct($activeUplinkPort = null, $standbyUplinkPort = null) {
		$this->activeUplinkPort = $activeUplinkPort;
		$this->standbyUplinkPort = $standbyUplinkPort;
	}
}

class DVSFailureCriteria {
	public $checkSpeed; //StringPolicy
	public $speed; //IntPolicy
	public $checkDuplex; //BoolPolicy
	public $fullDuplex; //BoolPolicy
	public $checkErrorPercent; //BoolPolicy
	public $percentage; //IntPolicy
	public $checkBeacon; //BoolPolicy

	function __construct($checkSpeed = null, $speed = null, $checkDuplex = null, $fullDuplex = null, $checkErrorPercent = null, $percentage = null, $checkBeacon = null) {
		$this->checkSpeed = $checkSpeed;
		$this->speed = $speed;
		$this->checkDuplex = $checkDuplex;
		$this->fullDuplex = $fullDuplex;
		$this->checkErrorPercent = $checkErrorPercent;
		$this->percentage = $percentage;
		$this->checkBeacon = $checkBeacon;
	}
}

class VmwareUplinkPortTeamingPolicy {
	public $policy; //StringPolicy
	public $reversePolicy; //BoolPolicy
	public $notifySwitches; //BoolPolicy
	public $rollingOrder; //BoolPolicy
	public $failureCriteria; //DVSFailureCriteria
	public $uplinkPortOrder; //VMwareUplinkPortOrderPolicy

	function __construct($policy = null, $reversePolicy = null, $notifySwitches = null, $rollingOrder = null, $failureCriteria = null, $uplinkPortOrder = null) {
		$this->policy = $policy;
		$this->reversePolicy = $reversePolicy;
		$this->notifySwitches = $notifySwitches;
		$this->rollingOrder = $rollingOrder;
		$this->failureCriteria = $failureCriteria;
		$this->uplinkPortOrder = $uplinkPortOrder;
	}
}

class VmwareDistributedVirtualSwitchVlanSpec {
}

class VmwareDistributedVirtualSwitchPvlanSpec {
	public $pvlanId; //int

	function __construct($pvlanId = null) {
		$this->pvlanId = $pvlanId;
	}
}

class VmwareDistributedVirtualSwitchVlanIdSpec {
	public $vlanId; //int

	function __construct($vlanId = null) {
		$this->vlanId = $vlanId;
	}
}

class VmwareDistributedVirtualSwitchTrunkVlanSpec {
	public $vlanId; //NumericRange

	function __construct($vlanId = null) {
		$this->vlanId = $vlanId;
	}
}

class DVSSecurityPolicy {
	public $allowPromiscuous; //BoolPolicy
	public $macChanges; //BoolPolicy
	public $forgedTransmits; //BoolPolicy

	function __construct($allowPromiscuous = null, $macChanges = null, $forgedTransmits = null) {
		$this->allowPromiscuous = $allowPromiscuous;
		$this->macChanges = $macChanges;
		$this->forgedTransmits = $forgedTransmits;
	}
}

class VMwareDVSPortSetting {
	public $vlan; //VmwareDistributedVirtualSwitchVlanSpec
	public $qosTag; //IntPolicy
	public $uplinkTeamingPolicy; //VmwareUplinkPortTeamingPolicy
	public $securityPolicy; //DVSSecurityPolicy
	public $ipfixEnabled; //BoolPolicy
	public $txUplink; //BoolPolicy

	function __construct($vlan = null, $qosTag = null, $uplinkTeamingPolicy = null, $securityPolicy = null, $ipfixEnabled = null, $txUplink = null) {
		$this->vlan = $vlan;
		$this->qosTag = $qosTag;
		$this->uplinkTeamingPolicy = $uplinkTeamingPolicy;
		$this->securityPolicy = $securityPolicy;
		$this->ipfixEnabled = $ipfixEnabled;
		$this->txUplink = $txUplink;
	}
}

class VMwareDVSPortgroupPolicy {
	public $vlanOverrideAllowed; //boolean
	public $uplinkTeamingOverrideAllowed; //boolean
	public $securityPolicyOverrideAllowed; //boolean
	public $ipfixOverrideAllowed; //boolean

	function __construct($vlanOverrideAllowed = null, $uplinkTeamingOverrideAllowed = null, $securityPolicyOverrideAllowed = null, $ipfixOverrideAllowed = null) {
		$this->vlanOverrideAllowed = $vlanOverrideAllowed;
		$this->uplinkTeamingOverrideAllowed = $uplinkTeamingOverrideAllowed;
		$this->securityPolicyOverrideAllowed = $securityPolicyOverrideAllowed;
		$this->ipfixOverrideAllowed = $ipfixOverrideAllowed;
	}
}

class VMwareDVSPvlanConfigSpec {
	public $pvlanEntry; //VMwareDVSPvlanMapEntry
	public $operation; //string

	function __construct($pvlanEntry = null, $operation = null) {
		$this->pvlanEntry = $pvlanEntry;
		$this->operation = $operation;
	}
}

class ArrayOfVMwareDVSPvlanConfigSpec {
	public $VMwareDVSPvlanConfigSpec; //VMwareDVSPvlanConfigSpec

	function __construct($VMwareDVSPvlanConfigSpec = null) {
		$this->VMwareDVSPvlanConfigSpec = $VMwareDVSPvlanConfigSpec;
	}
}

class VMwareDVSPvlanMapEntry {
	public $primaryVlanId; //int
	public $secondaryVlanId; //int
	public $pvlanType; //string

	function __construct($primaryVlanId = null, $secondaryVlanId = null, $pvlanType = null) {
		$this->primaryVlanId = $primaryVlanId;
		$this->secondaryVlanId = $secondaryVlanId;
		$this->pvlanType = $pvlanType;
	}
}

class ArrayOfVMwareDVSPvlanMapEntry {
	public $VMwareDVSPvlanMapEntry; //VMwareDVSPvlanMapEntry

	function __construct($VMwareDVSPvlanMapEntry = null) {
		$this->VMwareDVSPvlanMapEntry = $VMwareDVSPvlanMapEntry;
	}
}

class VMwareDVSVspanConfigSpec {
	public $vspanSession; //VMwareVspanSession
	public $operation; //string

	function __construct($vspanSession = null, $operation = null) {
		$this->vspanSession = $vspanSession;
		$this->operation = $operation;
	}
}

class ArrayOfVMwareDVSVspanConfigSpec {
	public $VMwareDVSVspanConfigSpec; //VMwareDVSVspanConfigSpec

	function __construct($VMwareDVSVspanConfigSpec = null) {
		$this->VMwareDVSVspanConfigSpec = $VMwareDVSVspanConfigSpec;
	}
}

class Event {
	public $key; //int
	public $chainId; //int
	public $createdTime; //dateTime
	public $userName; //string
	public $datacenter; //DatacenterEventArgument
	public $computeResource; //ComputeResourceEventArgument
	public $host; //HostEventArgument
	public $vm; //VmEventArgument
	public $ds; //DatastoreEventArgument
	public $net; //NetworkEventArgument
	public $dvs; //DvsEventArgument
	public $fullFormattedMessage; //string
	public $changeTag; //string

	function __construct($key = null, $chainId = null, $createdTime = null, $userName = null, $datacenter = null, $computeResource = null, $host = null, $vm = null, $ds = null, $net = null, $dvs = null, $fullFormattedMessage = null, $changeTag = null) {
		$this->key = $key;
		$this->chainId = $chainId;
		$this->createdTime = $createdTime;
		$this->userName = $userName;
		$this->datacenter = $datacenter;
		$this->computeResource = $computeResource;
		$this->host = $host;
		$this->vm = $vm;
		$this->ds = $ds;
		$this->net = $net;
		$this->dvs = $dvs;
		$this->fullFormattedMessage = $fullFormattedMessage;
		$this->changeTag = $changeTag;
	}
}

class ArrayOfEvent {
	public $Event; //Event

	function __construct($Event = null) {
		$this->Event = $Event;
	}
}

class GeneralEvent {
	public $message; //string

	function __construct($message = null) {
		$this->message = $message;
	}
}

class GeneralHostInfoEvent {
}

class GeneralHostWarningEvent {
}

class GeneralHostErrorEvent {
}

class GeneralVmInfoEvent {
}

class GeneralVmWarningEvent {
}

class GeneralVmErrorEvent {
}

class GeneralUserEvent {
	public $entity; //ManagedEntityEventArgument

	function __construct($entity = null) {
		$this->entity = $entity;
	}
}

class ExtendedEventPair {
	public $key; //string
	public $value; //string

	function __construct($key = null, $value = null) {
		$this->key = $key;
		$this->value = $value;
	}
}

class ArrayOfExtendedEventPair {
	public $ExtendedEventPair; //ExtendedEventPair

	function __construct($ExtendedEventPair = null) {
		$this->ExtendedEventPair = $ExtendedEventPair;
	}
}

class ExtendedEvent {
	public $eventTypeId; //string
	public $managedObject; //ManagedObjectReference
	public $data; //ExtendedEventPair

	function __construct($eventTypeId = null, $managedObject = null, $data = null) {
		$this->eventTypeId = $eventTypeId;
		$this->managedObject = $managedObject;
		$this->data = $data;
	}
}

class HealthStatusChangedEvent {
	public $componentId; //string
	public $oldStatus; //string
	public $newStatus; //string
	public $componentName; //string

	function __construct($componentId = null, $oldStatus = null, $newStatus = null, $componentName = null) {
		$this->componentId = $componentId;
		$this->oldStatus = $oldStatus;
		$this->newStatus = $newStatus;
		$this->componentName = $componentName;
	}
}

class HostInventoryUnreadableEvent {
}

class DatacenterEvent {
}

class DatacenterCreatedEvent {
	public $parent; //FolderEventArgument

	function __construct($parent = null) {
		$this->parent = $parent;
	}
}

class DatacenterRenamedEvent {
	public $oldName; //string
	public $newName; //string

	function __construct($oldName = null, $newName = null) {
		$this->oldName = $oldName;
		$this->newName = $newName;
	}
}

class SessionEvent {
}

class ServerStartedSessionEvent {
}

class UserLoginSessionEvent {
	public $ipAddress; //string
	public $locale; //string
	public $sessionId; //string

	function __construct($ipAddress = null, $locale = null, $sessionId = null) {
		$this->ipAddress = $ipAddress;
		$this->locale = $locale;
		$this->sessionId = $sessionId;
	}
}

class UserLogoutSessionEvent {
}

class BadUsernameSessionEvent {
	public $ipAddress; //string

	function __construct($ipAddress = null) {
		$this->ipAddress = $ipAddress;
	}
}

class AlreadyAuthenticatedSessionEvent {
}

class NoAccessUserEvent {
	public $ipAddress; //string

	function __construct($ipAddress = null) {
		$this->ipAddress = $ipAddress;
	}
}

class SessionTerminatedEvent {
	public $sessionId; //string
	public $terminatedUsername; //string

	function __construct($sessionId = null, $terminatedUsername = null) {
		$this->sessionId = $sessionId;
		$this->terminatedUsername = $terminatedUsername;
	}
}

class GlobalMessageChangedEvent {
	public $message; //string

	function __construct($message = null) {
		$this->message = $message;
	}
}

class UpgradeEvent {
	public $message; //string

	function __construct($message = null) {
		$this->message = $message;
	}
}

class InfoUpgradeEvent {
}

class WarningUpgradeEvent {
}

class ErrorUpgradeEvent {
}

class UserUpgradeEvent {
}

class HostEvent {
}

class HostDasEvent {
}

class HostConnectedEvent {
}

class HostDisconnectedEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class HostSyncFailedEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class HostConnectionLostEvent {
}

class HostReconnectionFailedEvent {
}

class HostCnxFailedNoConnectionEvent {
}

class HostCnxFailedBadUsernameEvent {
}

class HostCnxFailedBadVersionEvent {
}

class HostCnxFailedAlreadyManagedEvent {
	public $serverName; //string

	function __construct($serverName = null) {
		$this->serverName = $serverName;
	}
}

class HostCnxFailedNoLicenseEvent {
}

class HostCnxFailedNetworkErrorEvent {
}

class HostRemovedEvent {
}

class HostCnxFailedCcagentUpgradeEvent {
}

class HostCnxFailedBadCcagentEvent {
}

class HostCnxFailedEvent {
}

class HostCnxFailedAccountFailedEvent {
}

class HostCnxFailedNoAccessEvent {
}

class HostShutdownEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class HostCnxFailedNotFoundEvent {
}

class HostCnxFailedTimeoutEvent {
}

class HostUpgradeFailedEvent {
}

class EnteringMaintenanceModeEvent {
}

class EnteredMaintenanceModeEvent {
}

class ExitMaintenanceModeEvent {
}

class CanceledHostOperationEvent {
}

class TimedOutHostOperationEvent {
}

class HostDasEnabledEvent {
}

class HostDasDisabledEvent {
}

class HostDasEnablingEvent {
}

class HostDasDisablingEvent {
}

class HostDasErrorEvent {
	public $message; //string
	public $reason; //string

	function __construct($message = null, $reason = null) {
		$this->message = $message;
		$this->reason = $reason;
	}
}

class HostDasOkEvent {
}

class VcAgentUpgradedEvent {
}

class VcAgentUninstalledEvent {
}

class VcAgentUpgradeFailedEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VcAgentUninstallFailedEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class HostAddedEvent {
}

class HostAddFailedEvent {
	public $hostname; //string

	function __construct($hostname = null) {
		$this->hostname = $hostname;
	}
}

class HostIpChangedEvent {
	public $oldIP; //string
	public $newIP; //string

	function __construct($oldIP = null, $newIP = null) {
		$this->oldIP = $oldIP;
		$this->newIP = $newIP;
	}
}

class EnteringStandbyModeEvent {
}

class DrsEnteringStandbyModeEvent {
}

class EnteredStandbyModeEvent {
}

class DrsEnteredStandbyModeEvent {
}

class ExitingStandbyModeEvent {
}

class DrsExitingStandbyModeEvent {
}

class ExitedStandbyModeEvent {
}

class DrsExitedStandbyModeEvent {
}

class ExitStandbyModeFailedEvent {
}

class DrsExitStandbyModeFailedEvent {
}

class UpdatedAgentBeingRestartedEvent {
}

class AccountCreatedEvent {
	public $spec; //HostAccountSpec
	public $group; //boolean

	function __construct($spec = null, $group = null) {
		$this->spec = $spec;
		$this->group = $group;
	}
}

class AccountRemovedEvent {
	public $account; //string
	public $group; //boolean

	function __construct($account = null, $group = null) {
		$this->account = $account;
		$this->group = $group;
	}
}

class UserPasswordChanged {
	public $userLogin; //string

	function __construct($userLogin = null) {
		$this->userLogin = $userLogin;
	}
}

class AccountUpdatedEvent {
	public $spec; //HostAccountSpec
	public $group; //boolean

	function __construct($spec = null, $group = null) {
		$this->spec = $spec;
		$this->group = $group;
	}
}

class UserAssignedToGroup {
	public $userLogin; //string
	public $group; //string

	function __construct($userLogin = null, $group = null) {
		$this->userLogin = $userLogin;
		$this->group = $group;
	}
}

class UserUnassignedFromGroup {
	public $userLogin; //string
	public $group; //string

	function __construct($userLogin = null, $group = null) {
		$this->userLogin = $userLogin;
		$this->group = $group;
	}
}

class DatastorePrincipalConfigured {
	public $datastorePrincipal; //string

	function __construct($datastorePrincipal = null) {
		$this->datastorePrincipal = $datastorePrincipal;
	}
}

class VMFSDatastoreCreatedEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class NASDatastoreCreatedEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class LocalDatastoreCreatedEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class VMFSDatastoreExtendedEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class VMFSDatastoreExpandedEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class DatastoreRemovedOnHostEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class DatastoreRenamedOnHostEvent {
	public $oldName; //string
	public $newName; //string

	function __construct($oldName = null, $newName = null) {
		$this->oldName = $oldName;
		$this->newName = $newName;
	}
}

class DuplicateIpDetectedEvent {
	public $duplicateIP; //string
	public $macAddress; //string

	function __construct($duplicateIP = null, $macAddress = null) {
		$this->duplicateIP = $duplicateIP;
		$this->macAddress = $macAddress;
	}
}

class DatastoreDiscoveredEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class DrsResourceConfigureFailedEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class DrsResourceConfigureSyncedEvent {
}

class HostGetShortNameFailedEvent {
}

class HostShortNameToIpFailedEvent {
	public $shortName; //string

	function __construct($shortName = null) {
		$this->shortName = $shortName;
	}
}

class HostIpToShortNameFailedEvent {
}

class HostPrimaryAgentNotShortNameEvent {
	public $primaryAgent; //string

	function __construct($primaryAgent = null) {
		$this->primaryAgent = $primaryAgent;
	}
}

class HostNotInClusterEvent {
}

class HostIsolationIpPingFailedEvent {
	public $isolationIp; //string

	function __construct($isolationIp = null) {
		$this->isolationIp = $isolationIp;
	}
}

class HostIpInconsistentEvent {
	public $ipAddress; //string
	public $ipAddress2; //string

	function __construct($ipAddress = null, $ipAddress2 = null) {
		$this->ipAddress = $ipAddress;
		$this->ipAddress2 = $ipAddress2;
	}
}

class HostUserWorldSwapNotEnabledEvent {
}

class HostNonCompliantEvent {
}

class HostCompliantEvent {
}

class HostComplianceCheckedEvent {
	public $profile; //ProfileEventArgument

	function __construct($profile = null) {
		$this->profile = $profile;
	}
}

class ClusterComplianceCheckedEvent {
	public $profile; //ProfileEventArgument

	function __construct($profile = null) {
		$this->profile = $profile;
	}
}

class ProfileEvent {
	public $profile; //ProfileEventArgument

	function __construct($profile = null) {
		$this->profile = $profile;
	}
}

class ProfileCreatedEvent {
}

class ProfileRemovedEvent {
}

class ProfileAssociatedEvent {
}

class ProfileDissociatedEvent {
}

class HostConfigAppliedEvent {
}

class ProfileReferenceHostChangedEvent {
	public $referenceHost; //ManagedObjectReference

	function __construct($referenceHost = null) {
		$this->referenceHost = $referenceHost;
	}
}

class ProfileChangedEvent {
}

class HostProfileAppliedEvent {
	public $profile; //ProfileEventArgument

	function __construct($profile = null) {
		$this->profile = $profile;
	}
}

class HostShortNameInconsistentEvent {
	public $shortName; //string
	public $shortName2; //string

	function __construct($shortName = null, $shortName2 = null) {
		$this->shortName = $shortName;
		$this->shortName2 = $shortName2;
	}
}

class HostNoRedundantManagementNetworkEvent {
}

class HostNoAvailableNetworksEvent {
	public $ips; //string

	function __construct($ips = null) {
		$this->ips = $ips;
	}
}

class HostExtraNetworksEvent {
	public $ips; //string

	function __construct($ips = null) {
		$this->ips = $ips;
	}
}

class HostNoHAEnabledPortGroupsEvent {
}

class HostMissingNetworksEvent {
	public $ips; //string

	function __construct($ips = null) {
		$this->ips = $ips;
	}
}

class VnicPortArgument {
	public $vnic; //string
	public $port; //DistributedVirtualSwitchPortConnection

	function __construct($vnic = null, $port = null) {
		$this->vnic = $vnic;
		$this->port = $port;
	}
}

class ArrayOfVnicPortArgument {
	public $VnicPortArgument; //VnicPortArgument

	function __construct($VnicPortArgument = null) {
		$this->VnicPortArgument = $VnicPortArgument;
	}
}

class HostVnicConnectedToCustomizedDVPortEvent {
	public $vnic; //VnicPortArgument

	function __construct($vnic = null) {
		$this->vnic = $vnic;
	}
}

class GhostDvsProxySwitchDetectedEvent {
	public $switchUuid; //string

	function __construct($switchUuid = null) {
		$this->switchUuid = $switchUuid;
	}
}

class GhostDvsProxySwitchRemovedEvent {
	public $switchUuid; //string

	function __construct($switchUuid = null) {
		$this->switchUuid = $switchUuid;
	}
}

class VmEvent {
	public $template; //boolean

	function __construct($template = null) {
		$this->template = $template;
	}
}

class VmPoweredOffEvent {
}

class VmPoweredOnEvent {
}

class VmSuspendedEvent {
}

class VmStartingEvent {
}

class VmStoppingEvent {
}

class VmSuspendingEvent {
}

class VmResumingEvent {
}

class VmDisconnectedEvent {
}

class VmRemoteConsoleConnectedEvent {
}

class VmRemoteConsoleDisconnectedEvent {
}

class VmDiscoveredEvent {
}

class VmOrphanedEvent {
}

class VmBeingCreatedEvent {
	public $configSpec; //VirtualMachineConfigSpec

	function __construct($configSpec = null) {
		$this->configSpec = $configSpec;
	}
}

class VmCreatedEvent {
}

class VmStartRecordingEvent {
}

class VmEndRecordingEvent {
}

class VmStartReplayingEvent {
}

class VmEndReplayingEvent {
}

class VmRegisteredEvent {
}

class VmAutoRenameEvent {
	public $oldName; //string
	public $newName; //string

	function __construct($oldName = null, $newName = null) {
		$this->oldName = $oldName;
		$this->newName = $newName;
	}
}

class VmBeingHotMigratedEvent {
	public $destHost; //HostEventArgument
	public $destDatacenter; //DatacenterEventArgument
	public $destDatastore; //DatastoreEventArgument

	function __construct($destHost = null, $destDatacenter = null, $destDatastore = null) {
		$this->destHost = $destHost;
		$this->destDatacenter = $destDatacenter;
		$this->destDatastore = $destDatastore;
	}
}

class VmResettingEvent {
}

class VmStaticMacConflictEvent {
	public $conflictedVm; //VmEventArgument
	public $mac; //string

	function __construct($conflictedVm = null, $mac = null) {
		$this->conflictedVm = $conflictedVm;
		$this->mac = $mac;
	}
}

class VmMacConflictEvent {
	public $conflictedVm; //VmEventArgument
	public $mac; //string

	function __construct($conflictedVm = null, $mac = null) {
		$this->conflictedVm = $conflictedVm;
		$this->mac = $mac;
	}
}

class VmBeingDeployedEvent {
	public $srcTemplate; //VmEventArgument

	function __construct($srcTemplate = null) {
		$this->srcTemplate = $srcTemplate;
	}
}

class VmDeployFailedEvent {
	public $destDatastore; //EntityEventArgument
	public $reason; //LocalizedMethodFault

	function __construct($destDatastore = null, $reason = null) {
		$this->destDatastore = $destDatastore;
		$this->reason = $reason;
	}
}

class VmDeployedEvent {
	public $srcTemplate; //VmEventArgument

	function __construct($srcTemplate = null) {
		$this->srcTemplate = $srcTemplate;
	}
}

class VmMacChangedEvent {
	public $adapter; //string
	public $oldMac; //string
	public $newMac; //string

	function __construct($adapter = null, $oldMac = null, $newMac = null) {
		$this->adapter = $adapter;
		$this->oldMac = $oldMac;
		$this->newMac = $newMac;
	}
}

class VmMacAssignedEvent {
	public $adapter; //string
	public $mac; //string

	function __construct($adapter = null, $mac = null) {
		$this->adapter = $adapter;
		$this->mac = $mac;
	}
}

class VmUuidConflictEvent {
	public $conflictedVm; //VmEventArgument
	public $uuid; //string

	function __construct($conflictedVm = null, $uuid = null) {
		$this->conflictedVm = $conflictedVm;
		$this->uuid = $uuid;
	}
}

class VmInstanceUuidConflictEvent {
	public $conflictedVm; //VmEventArgument
	public $instanceUuid; //string

	function __construct($conflictedVm = null, $instanceUuid = null) {
		$this->conflictedVm = $conflictedVm;
		$this->instanceUuid = $instanceUuid;
	}
}

class VmBeingMigratedEvent {
	public $destHost; //HostEventArgument
	public $destDatacenter; //DatacenterEventArgument
	public $destDatastore; //DatastoreEventArgument

	function __construct($destHost = null, $destDatacenter = null, $destDatastore = null) {
		$this->destHost = $destHost;
		$this->destDatacenter = $destDatacenter;
		$this->destDatastore = $destDatastore;
	}
}

class VmFailedMigrateEvent {
	public $destHost; //HostEventArgument
	public $reason; //LocalizedMethodFault
	public $destDatacenter; //DatacenterEventArgument
	public $destDatastore; //DatastoreEventArgument

	function __construct($destHost = null, $reason = null, $destDatacenter = null, $destDatastore = null) {
		$this->destHost = $destHost;
		$this->reason = $reason;
		$this->destDatacenter = $destDatacenter;
		$this->destDatastore = $destDatastore;
	}
}

class VmMigratedEvent {
	public $sourceHost; //HostEventArgument
	public $sourceDatacenter; //DatacenterEventArgument
	public $sourceDatastore; //DatastoreEventArgument

	function __construct($sourceHost = null, $sourceDatacenter = null, $sourceDatastore = null) {
		$this->sourceHost = $sourceHost;
		$this->sourceDatacenter = $sourceDatacenter;
		$this->sourceDatastore = $sourceDatastore;
	}
}

class VmUnsupportedStartingEvent {
	public $guestId; //string

	function __construct($guestId = null) {
		$this->guestId = $guestId;
	}
}

class DrsVmMigratedEvent {
}

class DrsVmPoweredOnEvent {
}

class DrsRuleViolationEvent {
}

class DrsRuleComplianceEvent {
}

class VmRelocateSpecEvent {
}

class VmBeingRelocatedEvent {
	public $destHost; //HostEventArgument
	public $destDatacenter; //DatacenterEventArgument
	public $destDatastore; //DatastoreEventArgument

	function __construct($destHost = null, $destDatacenter = null, $destDatastore = null) {
		$this->destHost = $destHost;
		$this->destDatacenter = $destDatacenter;
		$this->destDatastore = $destDatastore;
	}
}

class VmRelocatedEvent {
	public $sourceHost; //HostEventArgument
	public $sourceDatacenter; //DatacenterEventArgument
	public $sourceDatastore; //DatastoreEventArgument

	function __construct($sourceHost = null, $sourceDatacenter = null, $sourceDatastore = null) {
		$this->sourceHost = $sourceHost;
		$this->sourceDatacenter = $sourceDatacenter;
		$this->sourceDatastore = $sourceDatastore;
	}
}

class VmRelocateFailedEvent {
	public $destHost; //HostEventArgument
	public $reason; //LocalizedMethodFault
	public $destDatacenter; //DatacenterEventArgument
	public $destDatastore; //DatastoreEventArgument

	function __construct($destHost = null, $reason = null, $destDatacenter = null, $destDatastore = null) {
		$this->destHost = $destHost;
		$this->reason = $reason;
		$this->destDatacenter = $destDatacenter;
		$this->destDatastore = $destDatastore;
	}
}

class VmEmigratingEvent {
}

class VmCloneEvent {
}

class VmBeingClonedEvent {
	public $destFolder; //FolderEventArgument
	public $destName; //string
	public $destHost; //HostEventArgument

	function __construct($destFolder = null, $destName = null, $destHost = null) {
		$this->destFolder = $destFolder;
		$this->destName = $destName;
		$this->destHost = $destHost;
	}
}

class VmBeingClonedNoFolderEvent {
	public $destName; //string
	public $destHost; //HostEventArgument

	function __construct($destName = null, $destHost = null) {
		$this->destName = $destName;
		$this->destHost = $destHost;
	}
}

class VmCloneFailedEvent {
	public $destFolder; //FolderEventArgument
	public $destName; //string
	public $destHost; //HostEventArgument
	public $reason; //LocalizedMethodFault

	function __construct($destFolder = null, $destName = null, $destHost = null, $reason = null) {
		$this->destFolder = $destFolder;
		$this->destName = $destName;
		$this->destHost = $destHost;
		$this->reason = $reason;
	}
}

class VmClonedEvent {
	public $sourceVm; //VmEventArgument

	function __construct($sourceVm = null) {
		$this->sourceVm = $sourceVm;
	}
}

class VmResourceReallocatedEvent {
}

class VmRenamedEvent {
	public $oldName; //string
	public $newName; //string

	function __construct($oldName = null, $newName = null) {
		$this->oldName = $oldName;
		$this->newName = $newName;
	}
}

class VmDateRolledBackEvent {
}

class VmNoNetworkAccessEvent {
	public $destHost; //HostEventArgument

	function __construct($destHost = null) {
		$this->destHost = $destHost;
	}
}

class VmDiskFailedEvent {
	public $disk; //string
	public $reason; //LocalizedMethodFault

	function __construct($disk = null, $reason = null) {
		$this->disk = $disk;
		$this->reason = $reason;
	}
}

class VmFailedToPowerOnEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmFailedToPowerOffEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmFailedToSuspendEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmFailedToResetEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmFailedToShutdownGuestEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmFailedToRebootGuestEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmFailedToStandbyGuestEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmRemovedEvent {
}

class VmGuestShutdownEvent {
}

class VmGuestRebootEvent {
}

class VmGuestStandbyEvent {
}

class VmUpgradingEvent {
	public $version; //string

	function __construct($version = null) {
		$this->version = $version;
	}
}

class VmUpgradeCompleteEvent {
	public $version; //string

	function __construct($version = null) {
		$this->version = $version;
	}
}

class VmUpgradeFailedEvent {
}

class VmRestartedOnAlternateHostEvent {
	public $sourceHost; //HostEventArgument

	function __construct($sourceHost = null) {
		$this->sourceHost = $sourceHost;
	}
}

class VmReconfiguredEvent {
	public $configSpec; //VirtualMachineConfigSpec

	function __construct($configSpec = null) {
		$this->configSpec = $configSpec;
	}
}

class VmMessageEvent {
	public $message; //string
	public $messageInfo; //VirtualMachineMessage

	function __construct($message = null, $messageInfo = null) {
		$this->message = $message;
		$this->messageInfo = $messageInfo;
	}
}

class VmMessageWarningEvent {
	public $message; //string
	public $messageInfo; //VirtualMachineMessage

	function __construct($message = null, $messageInfo = null) {
		$this->message = $message;
		$this->messageInfo = $messageInfo;
	}
}

class VmMessageErrorEvent {
	public $message; //string
	public $messageInfo; //VirtualMachineMessage

	function __construct($message = null, $messageInfo = null) {
		$this->message = $message;
		$this->messageInfo = $messageInfo;
	}
}

class VmConfigMissingEvent {
}

class VmPowerOffOnIsolationEvent {
	public $isolatedHost; //HostEventArgument

	function __construct($isolatedHost = null) {
		$this->isolatedHost = $isolatedHost;
	}
}

class VmShutdownOnIsolationEvent {
	public $isolatedHost; //HostEventArgument
	public $shutdownResult; //string

	function __construct($isolatedHost = null, $shutdownResult = null) {
		$this->isolatedHost = $isolatedHost;
		$this->shutdownResult = $shutdownResult;
	}
}

class VmFailoverFailed {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmDasBeingResetEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmDasResetFailedEvent {
}

class VmMaxRestartCountReached {
}

class VmMaxFTRestartCountReached {
}

class VmDasBeingResetWithScreenshotEvent {
	public $screenshotFilePath; //string

	function __construct($screenshotFilePath = null) {
		$this->screenshotFilePath = $screenshotFilePath;
	}
}

class NotEnoughResourcesToStartVmEvent {
}

class VmUuidAssignedEvent {
	public $uuid; //string

	function __construct($uuid = null) {
		$this->uuid = $uuid;
	}
}

class VmInstanceUuidAssignedEvent {
	public $instanceUuid; //string

	function __construct($instanceUuid = null) {
		$this->instanceUuid = $instanceUuid;
	}
}

class VmUuidChangedEvent {
	public $oldUuid; //string
	public $newUuid; //string

	function __construct($oldUuid = null, $newUuid = null) {
		$this->oldUuid = $oldUuid;
		$this->newUuid = $newUuid;
	}
}

class VmInstanceUuidChangedEvent {
	public $oldInstanceUuid; //string
	public $newInstanceUuid; //string

	function __construct($oldInstanceUuid = null, $newInstanceUuid = null) {
		$this->oldInstanceUuid = $oldInstanceUuid;
		$this->newInstanceUuid = $newInstanceUuid;
	}
}

class VmWwnConflictEvent {
	public $conflictedVms; //VmEventArgument
	public $conflictedHosts; //HostEventArgument
	public $wwn; //long

	function __construct($conflictedVms = null, $conflictedHosts = null, $wwn = null) {
		$this->conflictedVms = $conflictedVms;
		$this->conflictedHosts = $conflictedHosts;
		$this->wwn = $wwn;
	}
}

class VmAcquiredMksTicketEvent {
}

class VmAcquiredTicketEvent {
	public $ticketType; //string

	function __construct($ticketType = null) {
		$this->ticketType = $ticketType;
	}
}

class HostWwnConflictEvent {
	public $conflictedVms; //VmEventArgument
	public $conflictedHosts; //HostEventArgument
	public $wwn; //long

	function __construct($conflictedVms = null, $conflictedHosts = null, $wwn = null) {
		$this->conflictedVms = $conflictedVms;
		$this->conflictedHosts = $conflictedHosts;
		$this->wwn = $wwn;
	}
}

class VmWwnAssignedEvent {
	public $nodeWwns; //long
	public $portWwns; //long

	function __construct($nodeWwns = null, $portWwns = null) {
		$this->nodeWwns = $nodeWwns;
		$this->portWwns = $portWwns;
	}
}

class VmWwnChangedEvent {
	public $oldNodeWwns; //long
	public $oldPortWwns; //long
	public $newNodeWwns; //long
	public $newPortWwns; //long

	function __construct($oldNodeWwns = null, $oldPortWwns = null, $newNodeWwns = null, $newPortWwns = null) {
		$this->oldNodeWwns = $oldNodeWwns;
		$this->oldPortWwns = $oldPortWwns;
		$this->newNodeWwns = $newNodeWwns;
		$this->newPortWwns = $newPortWwns;
	}
}

class VmSecondaryAddedEvent {
}

class VmFaultToleranceTurnedOffEvent {
}

class VmFaultToleranceStateChangedEvent {
	public $oldState; //VirtualMachineFaultToleranceState
	public $newState; //VirtualMachineFaultToleranceState

	function __construct($oldState = null, $newState = null) {
		$this->oldState = $oldState;
		$this->newState = $newState;
	}
}

class VmSecondaryDisabledEvent {
}

class VmSecondaryDisabledBySystemEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmSecondaryEnabledEvent {
}

class VmStartingSecondaryEvent {
}

class VmSecondaryStartedEvent {
}

class VmFailedUpdatingSecondaryConfig {
}

class VmFailedStartingSecondaryEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmTimedoutStartingSecondaryEvent {
	public $timeout; //long

	function __construct($timeout = null) {
		$this->timeout = $timeout;
	}
}

class VmNoCompatibleHostForSecondaryEvent {
}

class VmPrimaryFailoverEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmFaultToleranceVmTerminatedEvent {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class HostWwnChangedEvent {
	public $oldNodeWwns; //long
	public $oldPortWwns; //long
	public $newNodeWwns; //long
	public $newPortWwns; //long

	function __construct($oldNodeWwns = null, $oldPortWwns = null, $newNodeWwns = null, $newPortWwns = null) {
		$this->oldNodeWwns = $oldNodeWwns;
		$this->oldPortWwns = $oldPortWwns;
		$this->newNodeWwns = $newNodeWwns;
		$this->newPortWwns = $newPortWwns;
	}
}

class HostAdminDisableEvent {
}

class HostAdminEnableEvent {
}

class HostEnableAdminFailedEvent {
	public $permissions; //Permission

	function __construct($permissions = null) {
		$this->permissions = $permissions;
	}
}

class VmFailedRelayoutOnVmfs2DatastoreEvent {
}

class VmFailedRelayoutEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class VmRelayoutSuccessfulEvent {
}

class VmRelayoutUpToDateEvent {
}

class VmConnectedEvent {
}

class VmPoweringOnWithCustomizedDVPortEvent {
	public $vnic; //VnicPortArgument

	function __construct($vnic = null) {
		$this->vnic = $vnic;
	}
}

class VmDasUpdateErrorEvent {
}

class NoMaintenanceModeDrsRecommendationForVM {
}

class VmDasUpdateOkEvent {
}

class ScheduledTaskEvent {
	public $scheduledTask; //ScheduledTaskEventArgument
	public $entity; //ManagedEntityEventArgument

	function __construct($scheduledTask = null, $entity = null) {
		$this->scheduledTask = $scheduledTask;
		$this->entity = $entity;
	}
}

class ScheduledTaskCreatedEvent {
}

class ScheduledTaskStartedEvent {
}

class ScheduledTaskRemovedEvent {
}

class ScheduledTaskReconfiguredEvent {
}

class ScheduledTaskCompletedEvent {
}

class ScheduledTaskFailedEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class ScheduledTaskEmailCompletedEvent {
	public $to; //string

	function __construct($to = null) {
		$this->to = $to;
	}
}

class ScheduledTaskEmailFailedEvent {
	public $to; //string
	public $reason; //LocalizedMethodFault

	function __construct($to = null, $reason = null) {
		$this->to = $to;
		$this->reason = $reason;
	}
}

class AlarmEvent {
	public $alarm; //AlarmEventArgument

	function __construct($alarm = null) {
		$this->alarm = $alarm;
	}
}

class AlarmCreatedEvent {
	public $entity; //ManagedEntityEventArgument

	function __construct($entity = null) {
		$this->entity = $entity;
	}
}

class AlarmStatusChangedEvent {
	public $source; //ManagedEntityEventArgument
	public $entity; //ManagedEntityEventArgument
	public $from; //string
	public $to; //string

	function __construct($source = null, $entity = null, $from = null, $to = null) {
		$this->source = $source;
		$this->entity = $entity;
		$this->from = $from;
		$this->to = $to;
	}
}

class AlarmActionTriggeredEvent {
	public $source; //ManagedEntityEventArgument
	public $entity; //ManagedEntityEventArgument

	function __construct($source = null, $entity = null) {
		$this->source = $source;
		$this->entity = $entity;
	}
}

class AlarmEmailCompletedEvent {
	public $entity; //ManagedEntityEventArgument
	public $to; //string

	function __construct($entity = null, $to = null) {
		$this->entity = $entity;
		$this->to = $to;
	}
}

class AlarmEmailFailedEvent {
	public $entity; //ManagedEntityEventArgument
	public $to; //string
	public $reason; //LocalizedMethodFault

	function __construct($entity = null, $to = null, $reason = null) {
		$this->entity = $entity;
		$this->to = $to;
		$this->reason = $reason;
	}
}

class AlarmSnmpCompletedEvent {
	public $entity; //ManagedEntityEventArgument

	function __construct($entity = null) {
		$this->entity = $entity;
	}
}

class AlarmSnmpFailedEvent {
	public $entity; //ManagedEntityEventArgument
	public $reason; //LocalizedMethodFault

	function __construct($entity = null, $reason = null) {
		$this->entity = $entity;
		$this->reason = $reason;
	}
}

class AlarmScriptCompleteEvent {
	public $entity; //ManagedEntityEventArgument
	public $script; //string

	function __construct($entity = null, $script = null) {
		$this->entity = $entity;
		$this->script = $script;
	}
}

class AlarmScriptFailedEvent {
	public $entity; //ManagedEntityEventArgument
	public $script; //string
	public $reason; //LocalizedMethodFault

	function __construct($entity = null, $script = null, $reason = null) {
		$this->entity = $entity;
		$this->script = $script;
		$this->reason = $reason;
	}
}

class AlarmRemovedEvent {
	public $entity; //ManagedEntityEventArgument

	function __construct($entity = null) {
		$this->entity = $entity;
	}
}

class AlarmReconfiguredEvent {
	public $entity; //ManagedEntityEventArgument

	function __construct($entity = null) {
		$this->entity = $entity;
	}
}

class AlarmAcknowledgedEvent {
	public $source; //ManagedEntityEventArgument
	public $entity; //ManagedEntityEventArgument

	function __construct($source = null, $entity = null) {
		$this->source = $source;
		$this->entity = $entity;
	}
}

class AlarmClearedEvent {
	public $source; //ManagedEntityEventArgument
	public $entity; //ManagedEntityEventArgument
	public $from; //string

	function __construct($source = null, $entity = null, $from = null) {
		$this->source = $source;
		$this->entity = $entity;
		$this->from = $from;
	}
}

class CustomFieldEvent {
}

class CustomFieldDefEvent {
	public $fieldKey; //int
	public $name; //string

	function __construct($fieldKey = null, $name = null) {
		$this->fieldKey = $fieldKey;
		$this->name = $name;
	}
}

class CustomFieldDefAddedEvent {
}

class CustomFieldDefRemovedEvent {
}

class CustomFieldDefRenamedEvent {
	public $newName; //string

	function __construct($newName = null) {
		$this->newName = $newName;
	}
}

class CustomFieldValueChangedEvent {
	public $entity; //ManagedEntityEventArgument
	public $fieldKey; //int
	public $name; //string
	public $value; //string

	function __construct($entity = null, $fieldKey = null, $name = null, $value = null) {
		$this->entity = $entity;
		$this->fieldKey = $fieldKey;
		$this->name = $name;
		$this->value = $value;
	}
}

class AuthorizationEvent {
}

class PermissionEvent {
	public $entity; //ManagedEntityEventArgument
	public $principal; //string
	public $group; //boolean

	function __construct($entity = null, $principal = null, $group = null) {
		$this->entity = $entity;
		$this->principal = $principal;
		$this->group = $group;
	}
}

class PermissionAddedEvent {
	public $role; //RoleEventArgument
	public $propagate; //boolean

	function __construct($role = null, $propagate = null) {
		$this->role = $role;
		$this->propagate = $propagate;
	}
}

class PermissionUpdatedEvent {
	public $role; //RoleEventArgument
	public $propagate; //boolean

	function __construct($role = null, $propagate = null) {
		$this->role = $role;
		$this->propagate = $propagate;
	}
}

class PermissionRemovedEvent {
}

class RoleEvent {
	public $role; //RoleEventArgument

	function __construct($role = null) {
		$this->role = $role;
	}
}

class RoleAddedEvent {
	public $privilegeList; //string

	function __construct($privilegeList = null) {
		$this->privilegeList = $privilegeList;
	}
}

class RoleUpdatedEvent {
	public $privilegeList; //string

	function __construct($privilegeList = null) {
		$this->privilegeList = $privilegeList;
	}
}

class RoleRemovedEvent {
}

class DatastoreEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class DatastoreDestroyedEvent {
}

class DatastoreRenamedEvent {
	public $oldName; //string
	public $newName; //string

	function __construct($oldName = null, $newName = null) {
		$this->oldName = $oldName;
		$this->newName = $newName;
	}
}

class DatastoreCapacityIncreasedEvent {
	public $oldCapacity; //long
	public $newCapacity; //long

	function __construct($oldCapacity = null, $newCapacity = null) {
		$this->oldCapacity = $oldCapacity;
		$this->newCapacity = $newCapacity;
	}
}

class DatastoreDuplicatedEvent {
}

class DatastoreFileEvent {
	public $targetFile; //string

	function __construct($targetFile = null) {
		$this->targetFile = $targetFile;
	}
}

class DatastoreFileCopiedEvent {
	public $sourceDatastore; //DatastoreEventArgument
	public $sourceFile; //string

	function __construct($sourceDatastore = null, $sourceFile = null) {
		$this->sourceDatastore = $sourceDatastore;
		$this->sourceFile = $sourceFile;
	}
}

class DatastoreFileMovedEvent {
	public $sourceDatastore; //DatastoreEventArgument
	public $sourceFile; //string

	function __construct($sourceDatastore = null, $sourceFile = null) {
		$this->sourceDatastore = $sourceDatastore;
		$this->sourceFile = $sourceFile;
	}
}

class DatastoreFileDeletedEvent {
}

class NonVIWorkloadDetectedOnDatastoreEvent {
}

class DatastoreIORMReconfiguredEvent {
}

class TaskEvent {
	public $info; //TaskInfo

	function __construct($info = null) {
		$this->info = $info;
	}
}

class TaskTimeoutEvent {
}

class LicenseEvent {
}

class ServerLicenseExpiredEvent {
	public $product; //string

	function __construct($product = null) {
		$this->product = $product;
	}
}

class HostLicenseExpiredEvent {
}

class VMotionLicenseExpiredEvent {
}

class NoLicenseEvent {
	public $feature; //LicenseFeatureInfo

	function __construct($feature = null) {
		$this->feature = $feature;
	}
}

class LicenseServerUnavailableEvent {
	public $licenseServer; //string

	function __construct($licenseServer = null) {
		$this->licenseServer = $licenseServer;
	}
}

class LicenseServerAvailableEvent {
	public $licenseServer; //string

	function __construct($licenseServer = null) {
		$this->licenseServer = $licenseServer;
	}
}

class LicenseExpiredEvent {
	public $feature; //LicenseFeatureInfo

	function __construct($feature = null) {
		$this->feature = $feature;
	}
}

class InvalidEditionEvent {
	public $feature; //string

	function __construct($feature = null) {
		$this->feature = $feature;
	}
}

class HostInventoryFullEvent {
	public $capacity; //int

	function __construct($capacity = null) {
		$this->capacity = $capacity;
	}
}

class LicenseRestrictedEvent {
}

class IncorrectHostInformationEvent {
}

class UnlicensedVirtualMachinesEvent {
	public $unlicensed; //int
	public $available; //int

	function __construct($unlicensed = null, $available = null) {
		$this->unlicensed = $unlicensed;
		$this->available = $available;
	}
}

class UnlicensedVirtualMachinesFoundEvent {
	public $available; //int

	function __construct($available = null) {
		$this->available = $available;
	}
}

class AllVirtualMachinesLicensedEvent {
}

class LicenseNonComplianceEvent {
	public $url; //string

	function __construct($url = null) {
		$this->url = $url;
	}
}

class MigrationEvent {
	public $fault; //LocalizedMethodFault

	function __construct($fault = null) {
		$this->fault = $fault;
	}
}

class MigrationWarningEvent {
}

class MigrationErrorEvent {
}

class MigrationHostWarningEvent {
	public $dstHost; //HostEventArgument

	function __construct($dstHost = null) {
		$this->dstHost = $dstHost;
	}
}

class MigrationHostErrorEvent {
	public $dstHost; //HostEventArgument

	function __construct($dstHost = null) {
		$this->dstHost = $dstHost;
	}
}

class MigrationResourceWarningEvent {
	public $dstPool; //ResourcePoolEventArgument
	public $dstHost; //HostEventArgument

	function __construct($dstPool = null, $dstHost = null) {
		$this->dstPool = $dstPool;
		$this->dstHost = $dstHost;
	}
}

class MigrationResourceErrorEvent {
	public $dstPool; //ResourcePoolEventArgument
	public $dstHost; //HostEventArgument

	function __construct($dstPool = null, $dstHost = null) {
		$this->dstPool = $dstPool;
		$this->dstHost = $dstHost;
	}
}

class ClusterEvent {
}

class DasEnabledEvent {
}

class DasDisabledEvent {
}

class DasAdmissionControlDisabledEvent {
}

class DasAdmissionControlEnabledEvent {
}

class DasHostFailedEvent {
	public $failedHost; //HostEventArgument

	function __construct($failedHost = null) {
		$this->failedHost = $failedHost;
	}
}

class DasHostIsolatedEvent {
	public $isolatedHost; //HostEventArgument

	function __construct($isolatedHost = null) {
		$this->isolatedHost = $isolatedHost;
	}
}

class DasClusterIsolatedEvent {
}

class DasAgentUnavailableEvent {
}

class DasAgentFoundEvent {
}

class InsufficientFailoverResourcesEvent {
}

class FailoverLevelRestored {
}

class ClusterOvercommittedEvent {
}

class HostOvercommittedEvent {
}

class ClusterStatusChangedEvent {
	public $oldStatus; //string
	public $newStatus; //string

	function __construct($oldStatus = null, $newStatus = null) {
		$this->oldStatus = $oldStatus;
		$this->newStatus = $newStatus;
	}
}

class HostStatusChangedEvent {
}

class ClusterCreatedEvent {
	public $parent; //FolderEventArgument

	function __construct($parent = null) {
		$this->parent = $parent;
	}
}

class ClusterDestroyedEvent {
}

class DrsEnabledEvent {
	public $behavior; //string

	function __construct($behavior = null) {
		$this->behavior = $behavior;
	}
}

class DrsDisabledEvent {
}

class ClusterReconfiguredEvent {
}

class HostMonitoringStateChangedEvent {
	public $state; //string

	function __construct($state = null) {
		$this->state = $state;
	}
}

class VmHealthMonitoringStateChangedEvent {
	public $state; //string

	function __construct($state = null) {
		$this->state = $state;
	}
}

class ResourcePoolEvent {
	public $resourcePool; //ResourcePoolEventArgument

	function __construct($resourcePool = null) {
		$this->resourcePool = $resourcePool;
	}
}

class ResourcePoolCreatedEvent {
	public $parent; //ResourcePoolEventArgument

	function __construct($parent = null) {
		$this->parent = $parent;
	}
}

class ResourcePoolDestroyedEvent {
}

class ResourcePoolMovedEvent {
	public $oldParent; //ResourcePoolEventArgument
	public $newParent; //ResourcePoolEventArgument

	function __construct($oldParent = null, $newParent = null) {
		$this->oldParent = $oldParent;
		$this->newParent = $newParent;
	}
}

class ResourcePoolReconfiguredEvent {
}

class ResourceViolatedEvent {
}

class VmResourcePoolMovedEvent {
	public $oldParent; //ResourcePoolEventArgument
	public $newParent; //ResourcePoolEventArgument

	function __construct($oldParent = null, $newParent = null) {
		$this->oldParent = $oldParent;
		$this->newParent = $newParent;
	}
}

class TemplateUpgradeEvent {
	public $legacyTemplate; //string

	function __construct($legacyTemplate = null) {
		$this->legacyTemplate = $legacyTemplate;
	}
}

class TemplateBeingUpgradedEvent {
}

class TemplateUpgradeFailedEvent {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class TemplateUpgradedEvent {
}

class CustomizationEvent {
	public $logLocation; //string

	function __construct($logLocation = null) {
		$this->logLocation = $logLocation;
	}
}

class CustomizationStartedEvent {
}

class CustomizationSucceeded {
}

class CustomizationFailed {
}

class CustomizationUnknownFailure {
}

class CustomizationSysprepFailed {
	public $sysprepVersion; //string
	public $systemVersion; //string

	function __construct($sysprepVersion = null, $systemVersion = null) {
		$this->sysprepVersion = $sysprepVersion;
		$this->systemVersion = $systemVersion;
	}
}

class CustomizationLinuxIdentityFailed {
}

class CustomizationNetworkSetupFailed {
}

class LockerMisconfiguredEvent {
	public $datastore; //DatastoreEventArgument

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class LockerReconfiguredEvent {
	public $oldDatastore; //DatastoreEventArgument
	public $newDatastore; //DatastoreEventArgument

	function __construct($oldDatastore = null, $newDatastore = null) {
		$this->oldDatastore = $oldDatastore;
		$this->newDatastore = $newDatastore;
	}
}

class NoDatastoresConfiguredEvent {
}

class AdminPasswordNotChangedEvent {
}

class HostInAuditModeEvent {
}

class LocalTSMEnabledEvent {
}

class RemoteTSMEnabledEvent {
}

class VimAccountPasswordChangedEvent {
}

class IScsiBootFailureEvent {
}

class DvsEvent {
}

class DvsCreatedEvent {
	public $parent; //FolderEventArgument

	function __construct($parent = null) {
		$this->parent = $parent;
	}
}

class DvsRenamedEvent {
	public $oldName; //string
	public $newName; //string

	function __construct($oldName = null, $newName = null) {
		$this->oldName = $oldName;
		$this->newName = $newName;
	}
}

class DvsReconfiguredEvent {
	public $configSpec; //DVSConfigSpec

	function __construct($configSpec = null) {
		$this->configSpec = $configSpec;
	}
}

class DvsUpgradeAvailableEvent {
	public $productInfo; //DistributedVirtualSwitchProductSpec

	function __construct($productInfo = null) {
		$this->productInfo = $productInfo;
	}
}

class DvsUpgradeInProgressEvent {
	public $productInfo; //DistributedVirtualSwitchProductSpec

	function __construct($productInfo = null) {
		$this->productInfo = $productInfo;
	}
}

class DvsUpgradeRejectedEvent {
	public $productInfo; //DistributedVirtualSwitchProductSpec

	function __construct($productInfo = null) {
		$this->productInfo = $productInfo;
	}
}

class DvsUpgradedEvent {
	public $productInfo; //DistributedVirtualSwitchProductSpec

	function __construct($productInfo = null) {
		$this->productInfo = $productInfo;
	}
}

class DvsHostJoinedEvent {
	public $hostJoined; //HostEventArgument

	function __construct($hostJoined = null) {
		$this->hostJoined = $hostJoined;
	}
}

class DvsHostLeftEvent {
	public $hostLeft; //HostEventArgument

	function __construct($hostLeft = null) {
		$this->hostLeft = $hostLeft;
	}
}

class DvsOutOfSyncHostArgument {
	public $outOfSyncHost; //HostEventArgument
	public $configParamters; //string

	function __construct($outOfSyncHost = null, $configParamters = null) {
		$this->outOfSyncHost = $outOfSyncHost;
		$this->configParamters = $configParamters;
	}
}

class ArrayOfDvsOutOfSyncHostArgument {
	public $DvsOutOfSyncHostArgument; //DvsOutOfSyncHostArgument

	function __construct($DvsOutOfSyncHostArgument = null) {
		$this->DvsOutOfSyncHostArgument = $DvsOutOfSyncHostArgument;
	}
}

class OutOfSyncDvsHost {
	public $hostOutOfSync; //DvsOutOfSyncHostArgument

	function __construct($hostOutOfSync = null) {
		$this->hostOutOfSync = $hostOutOfSync;
	}
}

class DvsHostWentOutOfSyncEvent {
	public $hostOutOfSync; //DvsOutOfSyncHostArgument

	function __construct($hostOutOfSync = null) {
		$this->hostOutOfSync = $hostOutOfSync;
	}
}

class DvsHostBackInSyncEvent {
	public $hostBackInSync; //HostEventArgument

	function __construct($hostBackInSync = null) {
		$this->hostBackInSync = $hostBackInSync;
	}
}

class DvsHostStatusUpdated {
	public $hostMember; //HostEventArgument
	public $oldStatus; //string
	public $newStatus; //string
	public $oldStatusDetail; //string
	public $newStatusDetail; //string

	function __construct($hostMember = null, $oldStatus = null, $newStatus = null, $oldStatusDetail = null, $newStatusDetail = null) {
		$this->hostMember = $hostMember;
		$this->oldStatus = $oldStatus;
		$this->newStatus = $newStatus;
		$this->oldStatusDetail = $oldStatusDetail;
		$this->newStatusDetail = $newStatusDetail;
	}
}

class DvsPortCreatedEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsPortReconfiguredEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsPortDeletedEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsPortConnectedEvent {
	public $portKey; //string
	public $connectee; //DistributedVirtualSwitchPortConnectee

	function __construct($portKey = null, $connectee = null) {
		$this->portKey = $portKey;
		$this->connectee = $connectee;
	}
}

class DvsPortDisconnectedEvent {
	public $portKey; //string
	public $connectee; //DistributedVirtualSwitchPortConnectee

	function __construct($portKey = null, $connectee = null) {
		$this->portKey = $portKey;
		$this->connectee = $connectee;
	}
}

class DvsPortLinkUpEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsPortLinkDownEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsPortJoinPortgroupEvent {
	public $portKey; //string
	public $portgroupKey; //string
	public $portgroupName; //string

	function __construct($portKey = null, $portgroupKey = null, $portgroupName = null) {
		$this->portKey = $portKey;
		$this->portgroupKey = $portgroupKey;
		$this->portgroupName = $portgroupName;
	}
}

class DvsPortLeavePortgroupEvent {
	public $portKey; //string
	public $portgroupKey; //string
	public $portgroupName; //string

	function __construct($portKey = null, $portgroupKey = null, $portgroupName = null) {
		$this->portKey = $portKey;
		$this->portgroupKey = $portgroupKey;
		$this->portgroupName = $portgroupName;
	}
}

class DvsPortBlockedEvent {
	public $portKey; //string
	public $statusDetail; //string

	function __construct($portKey = null, $statusDetail = null) {
		$this->portKey = $portKey;
		$this->statusDetail = $statusDetail;
	}
}

class DvsPortUnblockedEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsPortEnteredPassthruEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsPortExitedPassthruEvent {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class DvsDestroyedEvent {
}

class DvsMergedEvent {
	public $sourceDvs; //DvsEventArgument
	public $destinationDvs; //DvsEventArgument

	function __construct($sourceDvs = null, $destinationDvs = null) {
		$this->sourceDvs = $sourceDvs;
		$this->destinationDvs = $destinationDvs;
	}
}

class DVPortgroupEvent {
}

class DVPortgroupCreatedEvent {
}

class DVPortgroupRenamedEvent {
	public $oldName; //string
	public $newName; //string

	function __construct($oldName = null, $newName = null) {
		$this->oldName = $oldName;
		$this->newName = $newName;
	}
}

class DVPortgroupReconfiguredEvent {
	public $configSpec; //DVPortgroupConfigSpec

	function __construct($configSpec = null) {
		$this->configSpec = $configSpec;
	}
}

class DVPortgroupDestroyedEvent {
}

class DrsInvocationFailedEvent {
}

class DrsRecoveredFromFailureEvent {
}

class VmReloadFromPathEvent {
	public $configPath; //string

	function __construct($configPath = null) {
		$this->configPath = $configPath;
	}
}

class VmReloadFromPathFailedEvent {
	public $configPath; //string

	function __construct($configPath = null) {
		$this->configPath = $configPath;
	}
}

class EventArgument {
}

class RoleEventArgument {
	public $roleId; //int
	public $name; //string

	function __construct($roleId = null, $name = null) {
		$this->roleId = $roleId;
		$this->name = $name;
	}
}

class EntityEventArgument {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class ManagedEntityEventArgument {
	public $entity; //ManagedObjectReference

	function __construct($entity = null) {
		$this->entity = $entity;
	}
}

class FolderEventArgument {
	public $folder; //ManagedObjectReference

	function __construct($folder = null) {
		$this->folder = $folder;
	}
}

class DatacenterEventArgument {
	public $datacenter; //ManagedObjectReference

	function __construct($datacenter = null) {
		$this->datacenter = $datacenter;
	}
}

class ComputeResourceEventArgument {
	public $computeResource; //ManagedObjectReference

	function __construct($computeResource = null) {
		$this->computeResource = $computeResource;
	}
}

class ResourcePoolEventArgument {
	public $resourcePool; //ManagedObjectReference

	function __construct($resourcePool = null) {
		$this->resourcePool = $resourcePool;
	}
}

class HostEventArgument {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class ArrayOfHostEventArgument {
	public $HostEventArgument; //HostEventArgument

	function __construct($HostEventArgument = null) {
		$this->HostEventArgument = $HostEventArgument;
	}
}

class VmEventArgument {
	public $vm; //ManagedObjectReference

	function __construct($vm = null) {
		$this->vm = $vm;
	}
}

class ArrayOfVmEventArgument {
	public $VmEventArgument; //VmEventArgument

	function __construct($VmEventArgument = null) {
		$this->VmEventArgument = $VmEventArgument;
	}
}

class DatastoreEventArgument {
	public $datastore; //ManagedObjectReference

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class NetworkEventArgument {
	public $network; //ManagedObjectReference

	function __construct($network = null) {
		$this->network = $network;
	}
}

class AlarmEventArgument {
	public $alarm; //ManagedObjectReference

	function __construct($alarm = null) {
		$this->alarm = $alarm;
	}
}

class ScheduledTaskEventArgument {
	public $scheduledTask; //ManagedObjectReference

	function __construct($scheduledTask = null) {
		$this->scheduledTask = $scheduledTask;
	}
}

class ProfileEventArgument {
	public $profile; //ManagedObjectReference
	public $name; //string

	function __construct($profile = null, $name = null) {
		$this->profile = $profile;
		$this->name = $name;
	}
}

class DvsEventArgument {
	public $dvs; //ManagedObjectReference

	function __construct($dvs = null) {
		$this->dvs = $dvs;
	}
}

class EventArgDesc {
	public $name; //string
	public $type; //string
	public $description; //ElementDescription

	function __construct($name = null, $type = null, $description = null) {
		$this->name = $name;
		$this->type = $type;
		$this->description = $description;
	}
}

class ArrayOfEventArgDesc {
	public $EventArgDesc; //EventArgDesc

	function __construct($EventArgDesc = null) {
		$this->EventArgDesc = $EventArgDesc;
	}
}

class EventDescriptionEventDetail {
	public $key; //string
	public $description; //string
	public $category; //string
	public $formatOnDatacenter; //string
	public $formatOnComputeResource; //string
	public $formatOnHost; //string
	public $formatOnVm; //string
	public $fullFormat; //string
	public $longDescription; //string

	function __construct($key = null, $description = null, $category = null, $formatOnDatacenter = null, $formatOnComputeResource = null, $formatOnHost = null, $formatOnVm = null, $fullFormat = null, $longDescription = null) {
		$this->key = $key;
		$this->description = $description;
		$this->category = $category;
		$this->formatOnDatacenter = $formatOnDatacenter;
		$this->formatOnComputeResource = $formatOnComputeResource;
		$this->formatOnHost = $formatOnHost;
		$this->formatOnVm = $formatOnVm;
		$this->fullFormat = $fullFormat;
		$this->longDescription = $longDescription;
	}
}

class ArrayOfEventDescriptionEventDetail {
	public $EventDescriptionEventDetail; //EventDescriptionEventDetail

	function __construct($EventDescriptionEventDetail = null) {
		$this->EventDescriptionEventDetail = $EventDescriptionEventDetail;
	}
}

class EventDescription {
	public $category; //ElementDescription
	public $eventInfo; //EventDescriptionEventDetail
	public $enumeratedTypes; //EnumDescription

	function __construct($category = null, $eventInfo = null, $enumeratedTypes = null) {
		$this->category = $category;
		$this->eventInfo = $eventInfo;
		$this->enumeratedTypes = $enumeratedTypes;
	}
}

class EventEx {
	public $eventTypeId; //string
	public $severity; //string
	public $message; //string
	public $arguments; //KeyAnyValue
	public $objectId; //string
	public $objectType; //string
	public $objectName; //string
	public $fault; //LocalizedMethodFault

	function __construct($eventTypeId = null, $severity = null, $message = null, $arguments = null, $objectId = null, $objectType = null, $objectName = null, $fault = null) {
		$this->eventTypeId = $eventTypeId;
		$this->severity = $severity;
		$this->message = $message;
		$this->arguments = $arguments;
		$this->objectId = $objectId;
		$this->objectType = $objectType;
		$this->objectName = $objectName;
		$this->fault = $fault;
	}
}

class EventFilterSpecByEntity {
	public $entity; //ManagedObjectReference
	public $recursion; //EventFilterSpecRecursionOption

	function __construct($entity = null, $recursion = null) {
		$this->entity = $entity;
		$this->recursion = $recursion;
	}
}

class EventFilterSpecByTime {
	public $beginTime; //dateTime
	public $endTime; //dateTime

	function __construct($beginTime = null, $endTime = null) {
		$this->beginTime = $beginTime;
		$this->endTime = $endTime;
	}
}

class EventFilterSpecByUsername {
	public $systemUser; //boolean
	public $userList; //string

	function __construct($systemUser = null, $userList = null) {
		$this->systemUser = $systemUser;
		$this->userList = $userList;
	}
}

class EventFilterSpec {
	public $entity; //EventFilterSpecByEntity
	public $time; //EventFilterSpecByTime
	public $userName; //EventFilterSpecByUsername
	public $eventChainId; //int
	public $alarm; //ManagedObjectReference
	public $scheduledTask; //ManagedObjectReference
	public $disableFullMessage; //boolean
	public $category; //string
	public $type; //string
	public $tag; //string
	public $eventTypeId; //string

	function __construct($entity = null, $time = null, $userName = null, $eventChainId = null, $alarm = null, $scheduledTask = null, $disableFullMessage = null, $category = null, $type = null, $tag = null, $eventTypeId = null) {
		$this->entity = $entity;
		$this->time = $time;
		$this->userName = $userName;
		$this->eventChainId = $eventChainId;
		$this->alarm = $alarm;
		$this->scheduledTask = $scheduledTask;
		$this->disableFullMessage = $disableFullMessage;
		$this->category = $category;
		$this->type = $type;
		$this->tag = $tag;
		$this->eventTypeId = $eventTypeId;
	}
}

class ExtExtendedProductInfo {
	public $companyUrl; //string
	public $productUrl; //string
	public $managementUrl; //string
	public $self; //ManagedObjectReference

	function __construct($companyUrl = null, $productUrl = null, $managementUrl = null, $self = null) {
		$this->companyUrl = $companyUrl;
		$this->productUrl = $productUrl;
		$this->managementUrl = $managementUrl;
		$this->self = $self;
	}
}

class ManagedByInfo {
	public $extensionKey; //string
	public $type; //string

	function __construct($extensionKey = null, $type = null) {
		$this->extensionKey = $extensionKey;
		$this->type = $type;
	}
}

class ExtManagedEntityInfo {
	public $type; //string
	public $smallIconUrl; //string
	public $description; //string

	function __construct($type = null, $smallIconUrl = null, $description = null) {
		$this->type = $type;
		$this->smallIconUrl = $smallIconUrl;
		$this->description = $description;
	}
}

class ArrayOfExtManagedEntityInfo {
	public $ExtManagedEntityInfo; //ExtManagedEntityInfo

	function __construct($ExtManagedEntityInfo = null) {
		$this->ExtManagedEntityInfo = $ExtManagedEntityInfo;
	}
}

class ExtSolutionManagerInfoTabInfo {
	public $label; //string
	public $url; //string

	function __construct($label = null, $url = null) {
		$this->label = $label;
		$this->url = $url;
	}
}

class ArrayOfExtSolutionManagerInfoTabInfo {
	public $ExtSolutionManagerInfoTabInfo; //ExtSolutionManagerInfoTabInfo

	function __construct($ExtSolutionManagerInfoTabInfo = null) {
		$this->ExtSolutionManagerInfoTabInfo = $ExtSolutionManagerInfoTabInfo;
	}
}

class ExtSolutionManagerInfo {
	public $tab; //ExtSolutionManagerInfoTabInfo
	public $smallIconUrl; //string

	function __construct($tab = null, $smallIconUrl = null) {
		$this->tab = $tab;
		$this->smallIconUrl = $smallIconUrl;
	}
}

class ActiveDirectoryFault {
	public $errorCode; //int

	function __construct($errorCode = null) {
		$this->errorCode = $errorCode;
	}
}

class AdminDisabled {
}

class AdminNotDisabled {
}

class AffinityConfigured {
	public $configuredAffinity; //string

	function __construct($configuredAffinity = null) {
		$this->configuredAffinity = $configuredAffinity;
	}
}

class AgentInstallFailed {
	public $reason; //string
	public $statusCode; //int
	public $installerOutput; //string

	function __construct($reason = null, $statusCode = null, $installerOutput = null) {
		$this->reason = $reason;
		$this->statusCode = $statusCode;
		$this->installerOutput = $installerOutput;
	}
}

class AlreadyBeingManaged {
	public $ipAddress; //string

	function __construct($ipAddress = null) {
		$this->ipAddress = $ipAddress;
	}
}

class AlreadyConnected {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class AlreadyExists {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class AlreadyUpgraded {
}

class AnswerFileUpdateFailure {
	public $userInputPath; //ProfilePropertyPath
	public $errMsg; //LocalizableMessage

	function __construct($userInputPath = null, $errMsg = null) {
		$this->userInputPath = $userInputPath;
		$this->errMsg = $errMsg;
	}
}

class ArrayOfAnswerFileUpdateFailure {
	public $AnswerFileUpdateFailure; //AnswerFileUpdateFailure

	function __construct($AnswerFileUpdateFailure = null) {
		$this->AnswerFileUpdateFailure = $AnswerFileUpdateFailure;
	}
}

class AnswerFileUpdateFailed {
	public $failure; //AnswerFileUpdateFailure

	function __construct($failure = null) {
		$this->failure = $failure;
	}
}

class ApplicationQuiesceFault {
}

class AuthMinimumAdminPermission {
}

class BlockedByFirewall {
}

class CAMServerRefusedConnection {
}

class CannotAccessFile {
}

class CannotAccessLocalSource {
}

class CannotAccessNetwork {
}

class CannotAccessVmComponent {
}

class CannotAccessVmConfig {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class CannotAccessVmDevice {
	public $device; //string
	public $backing; //string
	public $connected; //boolean

	function __construct($device = null, $backing = null, $connected = null) {
		$this->device = $device;
		$this->backing = $backing;
		$this->connected = $connected;
	}
}

class CannotAccessVmDisk {
	public $fault; //LocalizedMethodFault

	function __construct($fault = null) {
		$this->fault = $fault;
	}
}

class CannotAddHostWithFTVmAsStandalone {
}

class CannotAddHostWithFTVmToDifferentCluster {
}

class CannotAddHostWithFTVmToNonHACluster {
}

class CannotChangeDrsBehaviorForFtSecondary {
	public $vm; //ManagedObjectReference
	public $vmName; //string

	function __construct($vm = null, $vmName = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
	}
}

class CannotChangeHaSettingsForFtSecondary {
	public $vm; //ManagedObjectReference
	public $vmName; //string

	function __construct($vm = null, $vmName = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
	}
}

class CannotCreateFile {
}

class CannotDecryptPasswords {
}

class CannotDeleteFile {
}

class CannotDisableDrsOnClustersWithVApps {
}

class CannotDisableSnapshot {
}

class CannotDisconnectHostWithFaultToleranceVm {
	public $hostName; //string

	function __construct($hostName = null) {
		$this->hostName = $hostName;
	}
}

class CannotModifyConfigCpuRequirements {
}

class CannotMoveFaultToleranceVm {
	public $moveType; //string
	public $vmName; //string

	function __construct($moveType = null, $vmName = null) {
		$this->moveType = $moveType;
		$this->vmName = $vmName;
	}
}

class CannotMoveHostWithFaultToleranceVm {
}

class CannotMoveVmWithDeltaDisk {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class CannotMoveVmWithNativeDeltaDisk {
}

class CannotPowerOffVmInCluster {
	public $operation; //string
	public $vm; //ManagedObjectReference
	public $vmName; //string

	function __construct($operation = null, $vm = null, $vmName = null) {
		$this->operation = $operation;
		$this->vm = $vm;
		$this->vmName = $vmName;
	}
}

class ClockSkew {
}

class CloneFromSnapshotNotSupported {
}

class ConcurrentAccess {
}

class ConnectedIso {
	public $cdrom; //VirtualCdrom
	public $filename; //string

	function __construct($cdrom = null, $filename = null) {
		$this->cdrom = $cdrom;
		$this->filename = $filename;
	}
}

class CpuCompatibilityUnknown {
}

class CpuHotPlugNotSupported {
}

class CpuIncompatible {
	public $level; //int
	public $registerName; //string
	public $registerBits; //string
	public $desiredBits; //string
	public $host; //ManagedObjectReference

	function __construct($level = null, $registerName = null, $registerBits = null, $desiredBits = null, $host = null) {
		$this->level = $level;
		$this->registerName = $registerName;
		$this->registerBits = $registerBits;
		$this->desiredBits = $desiredBits;
		$this->host = $host;
	}
}

class CpuIncompatible1ECX {
	public $sse3; //boolean
	public $pclmulqdq; //boolean
	public $ssse3; //boolean
	public $sse41; //boolean
	public $sse42; //boolean
	public $aes; //boolean
	public $other; //boolean
	public $otherOnly; //boolean

	function __construct($sse3 = null, $pclmulqdq = null, $ssse3 = null, $sse41 = null, $sse42 = null, $aes = null, $other = null, $otherOnly = null) {
		$this->sse3 = $sse3;
		$this->pclmulqdq = $pclmulqdq;
		$this->ssse3 = $ssse3;
		$this->sse41 = $sse41;
		$this->sse42 = $sse42;
		$this->aes = $aes;
		$this->other = $other;
		$this->otherOnly = $otherOnly;
	}
}

class CpuIncompatible81EDX {
	public $nx; //boolean
	public $ffxsr; //boolean
	public $rdtscp; //boolean
	public $lm; //boolean
	public $other; //boolean
	public $otherOnly; //boolean

	function __construct($nx = null, $ffxsr = null, $rdtscp = null, $lm = null, $other = null, $otherOnly = null) {
		$this->nx = $nx;
		$this->ffxsr = $ffxsr;
		$this->rdtscp = $rdtscp;
		$this->lm = $lm;
		$this->other = $other;
		$this->otherOnly = $otherOnly;
	}
}

class CustomizationFault {
}

class CustomizationPending {
}

class DVPortNotSupported {
}

class DasConfigFault {
	public $reason; //string
	public $output; //string
	public $event; //Event

	function __construct($reason = null, $output = null, $event = null) {
		$this->reason = $reason;
		$this->output = $output;
		$this->event = $event;
	}
}

class DatabaseError {
}

class DatacenterMismatchArgument {
	public $entity; //ManagedObjectReference
	public $inputDatacenter; //ManagedObjectReference

	function __construct($entity = null, $inputDatacenter = null) {
		$this->entity = $entity;
		$this->inputDatacenter = $inputDatacenter;
	}
}

class ArrayOfDatacenterMismatchArgument {
	public $DatacenterMismatchArgument; //DatacenterMismatchArgument

	function __construct($DatacenterMismatchArgument = null) {
		$this->DatacenterMismatchArgument = $DatacenterMismatchArgument;
	}
}

class DatacenterMismatch {
	public $invalidArgument; //DatacenterMismatchArgument
	public $expectedDatacenter; //ManagedObjectReference

	function __construct($invalidArgument = null, $expectedDatacenter = null) {
		$this->invalidArgument = $invalidArgument;
		$this->expectedDatacenter = $expectedDatacenter;
	}
}

class DatastoreNotWritableOnHost {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class DeltaDiskFormatNotSupported {
	public $datastore; //ManagedObjectReference
	public $deltaDiskFormat; //string

	function __construct($datastore = null, $deltaDiskFormat = null) {
		$this->datastore = $datastore;
		$this->deltaDiskFormat = $deltaDiskFormat;
	}
}

class DestinationSwitchFull {
}

class DeviceBackingNotSupported {
	public $backing; //string

	function __construct($backing = null) {
		$this->backing = $backing;
	}
}

class DeviceControllerNotSupported {
	public $controller; //string

	function __construct($controller = null) {
		$this->controller = $controller;
	}
}

class DeviceHotPlugNotSupported {
}

class DeviceNotFound {
}

class DeviceNotSupported {
	public $device; //string
	public $reason; //string

	function __construct($device = null, $reason = null) {
		$this->device = $device;
		$this->reason = $reason;
	}
}

class DeviceUnsupportedForVmPlatform {
}

class DeviceUnsupportedForVmVersion {
	public $currentVersion; //string
	public $expectedVersion; //string

	function __construct($currentVersion = null, $expectedVersion = null) {
		$this->currentVersion = $currentVersion;
		$this->expectedVersion = $expectedVersion;
	}
}

class DirectoryNotEmpty {
}

class DisableAdminNotSupported {
}

class DisallowedChangeByService {
	public $serviceName; //string
	public $disallowedChange; //string

	function __construct($serviceName = null, $disallowedChange = null) {
		$this->serviceName = $serviceName;
		$this->disallowedChange = $disallowedChange;
	}
}

class DisallowedDiskModeChange {
}

class DisallowedMigrationDeviceAttached {
	public $fault; //LocalizedMethodFault

	function __construct($fault = null) {
		$this->fault = $fault;
	}
}

class DisallowedOperationOnFailoverHost {
	public $host; //ManagedObjectReference
	public $hostname; //string

	function __construct($host = null, $hostname = null) {
		$this->host = $host;
		$this->hostname = $hostname;
	}
}

class DiskMoveTypeNotSupported {
}

class DiskNotSupported {
	public $disk; //int

	function __construct($disk = null) {
		$this->disk = $disk;
	}
}

class DomainNotFound {
	public $domainName; //string

	function __construct($domainName = null) {
		$this->domainName = $domainName;
	}
}

class DrsDisabledOnVm {
}

class DrsVmotionIncompatibleFault {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class DuplicateName {
	public $name; //string
	public $object; //ManagedObjectReference

	function __construct($name = null, $object = null) {
		$this->name = $name;
		$this->object = $object;
	}
}

class DvsFault {
}

class DvsNotAuthorized {
	public $sessionExtensionKey; //string
	public $dvsExtensionKey; //string

	function __construct($sessionExtensionKey = null, $dvsExtensionKey = null) {
		$this->sessionExtensionKey = $sessionExtensionKey;
		$this->dvsExtensionKey = $dvsExtensionKey;
	}
}

class DvsOperationBulkFaultFaultOnHost {
	public $host; //ManagedObjectReference
	public $fault; //LocalizedMethodFault

	function __construct($host = null, $fault = null) {
		$this->host = $host;
		$this->fault = $fault;
	}
}

class ArrayOfDvsOperationBulkFaultFaultOnHost {
	public $DvsOperationBulkFaultFaultOnHost; //DvsOperationBulkFaultFaultOnHost

	function __construct($DvsOperationBulkFaultFaultOnHost = null) {
		$this->DvsOperationBulkFaultFaultOnHost = $DvsOperationBulkFaultFaultOnHost;
	}
}

class DvsOperationBulkFault {
	public $hostFault; //DvsOperationBulkFaultFaultOnHost

	function __construct($hostFault = null) {
		$this->hostFault = $hostFault;
	}
}

class DvsScopeViolated {
	public $scope; //ManagedObjectReference
	public $entity; //ManagedObjectReference

	function __construct($scope = null, $entity = null) {
		$this->scope = $scope;
		$this->entity = $entity;
	}
}

class EVCAdmissionFailed {
}

class EVCAdmissionFailedCPUFeaturesForMode {
	public $currentEVCModeKey; //string

	function __construct($currentEVCModeKey = null) {
		$this->currentEVCModeKey = $currentEVCModeKey;
	}
}

class EVCAdmissionFailedCPUModel {
}

class EVCAdmissionFailedCPUModelForMode {
	public $currentEVCModeKey; //string

	function __construct($currentEVCModeKey = null) {
		$this->currentEVCModeKey = $currentEVCModeKey;
	}
}

class EVCAdmissionFailedCPUVendor {
	public $clusterCPUVendor; //string
	public $hostCPUVendor; //string

	function __construct($clusterCPUVendor = null, $hostCPUVendor = null) {
		$this->clusterCPUVendor = $clusterCPUVendor;
		$this->hostCPUVendor = $hostCPUVendor;
	}
}

class EVCAdmissionFailedCPUVendorUnknown {
}

class EVCAdmissionFailedHostDisconnected {
}

class EVCAdmissionFailedHostSoftware {
}

class EVCAdmissionFailedHostSoftwareForMode {
}

class EVCAdmissionFailedVmActive {
}

class EightHostLimitViolated {
}

class ExpiredAddonLicense {
}

class ExpiredEditionLicense {
}

class ExpiredFeatureLicense {
	public $feature; //string
	public $count; //int
	public $expirationDate; //dateTime

	function __construct($feature = null, $count = null, $expirationDate = null) {
		$this->feature = $feature;
		$this->count = $count;
		$this->expirationDate = $expirationDate;
	}
}

class ExtendedFault {
	public $faultTypeId; //string
	public $data; //KeyValue

	function __construct($faultTypeId = null, $data = null) {
		$this->faultTypeId = $faultTypeId;
		$this->data = $data;
	}
}

class FailToEnableSPBM {
	public $cs; //ManagedObjectReference
	public $csName; //string
	public $hostLicenseStates; //ComputeResourceHostSPBMLicenseInfo

	function __construct($cs = null, $csName = null, $hostLicenseStates = null) {
		$this->cs = $cs;
		$this->csName = $csName;
		$this->hostLicenseStates = $hostLicenseStates;
	}
}

class FailToLockFaultToleranceVMs {
	public $vmName; //string
	public $vm; //ManagedObjectReference
	public $alreadyLockedVm; //ManagedObjectReference

	function __construct($vmName = null, $vm = null, $alreadyLockedVm = null) {
		$this->vmName = $vmName;
		$this->vm = $vm;
		$this->alreadyLockedVm = $alreadyLockedVm;
	}
}

class FaultToleranceAntiAffinityViolated {
	public $hostName; //string
	public $host; //ManagedObjectReference

	function __construct($hostName = null, $host = null) {
		$this->hostName = $hostName;
		$this->host = $host;
	}
}

class FaultToleranceCannotEditMem {
	public $vmName; //string
	public $vm; //ManagedObjectReference

	function __construct($vmName = null, $vm = null) {
		$this->vmName = $vmName;
		$this->vm = $vm;
	}
}

class FaultToleranceCpuIncompatible {
	public $model; //boolean
	public $family; //boolean
	public $stepping; //boolean

	function __construct($model = null, $family = null, $stepping = null) {
		$this->model = $model;
		$this->family = $family;
		$this->stepping = $stepping;
	}
}

class FaultToleranceNeedsThickDisk {
	public $vmName; //string

	function __construct($vmName = null) {
		$this->vmName = $vmName;
	}
}

class FaultToleranceNotLicensed {
	public $hostName; //string

	function __construct($hostName = null) {
		$this->hostName = $hostName;
	}
}

class FaultToleranceNotSameBuild {
	public $build; //string

	function __construct($build = null) {
		$this->build = $build;
	}
}

class FaultTolerancePrimaryPowerOnNotAttempted {
	public $secondaryVm; //ManagedObjectReference
	public $primaryVm; //ManagedObjectReference

	function __construct($secondaryVm = null, $primaryVm = null) {
		$this->secondaryVm = $secondaryVm;
		$this->primaryVm = $primaryVm;
	}
}

class FaultToleranceVmNotDasProtected {
	public $vm; //ManagedObjectReference
	public $vmName; //string

	function __construct($vm = null, $vmName = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
	}
}

class FcoeFault {
}

class FcoeFaultPnicHasNoPortSet {
	public $nicDevice; //string

	function __construct($nicDevice = null) {
		$this->nicDevice = $nicDevice;
	}
}

class FileAlreadyExists {
}

class FileBackedPortNotSupported {
}

class FileFault {
	public $file; //string

	function __construct($file = null) {
		$this->file = $file;
	}
}

class FileLocked {
}

class FileNameTooLong {
}

class FileNotFound {
}

class FileNotWritable {
}

class FileTooLarge {
	public $datastore; //string
	public $fileSize; //long
	public $maxFileSize; //long

	function __construct($datastore = null, $fileSize = null, $maxFileSize = null) {
		$this->datastore = $datastore;
		$this->fileSize = $fileSize;
		$this->maxFileSize = $maxFileSize;
	}
}

class FilesystemQuiesceFault {
}

class FtIssuesOnHost {
	public $host; //ManagedObjectReference
	public $hostName; //string
	public $errors; //LocalizedMethodFault

	function __construct($host = null, $hostName = null, $errors = null) {
		$this->host = $host;
		$this->hostName = $hostName;
		$this->errors = $errors;
	}
}

class FullStorageVMotionNotSupported {
}

class GenericDrsFault {
	public $hostFaults; //LocalizedMethodFault

	function __construct($hostFaults = null) {
		$this->hostFaults = $hostFaults;
	}
}

class GenericVmConfigFault {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class GuestAuthenticationChallenge {
	public $serverChallenge; //GuestAuthentication
	public $sessionID; //long

	function __construct($serverChallenge = null, $sessionID = null) {
		$this->serverChallenge = $serverChallenge;
		$this->sessionID = $sessionID;
	}
}

class GuestComponentsOutOfDate {
}

class GuestOperationsFault {
}

class GuestOperationsUnavailable {
}

class GuestPermissionDenied {
}

class GuestProcessNotFound {
	public $pid; //long

	function __construct($pid = null) {
		$this->pid = $pid;
	}
}

class HAErrorsAtDest {
}

class HostAccessRestrictedToManagementServer {
	public $managementServer; //string

	function __construct($managementServer = null) {
		$this->managementServer = $managementServer;
	}
}

class HostConfigFailed {
	public $failure; //LocalizedMethodFault

	function __construct($failure = null) {
		$this->failure = $failure;
	}
}

class HostConfigFault {
}

class HostConnectFault {
}

class HostInDomain {
}

class HostIncompatibleForFaultTolerance {
	public $hostName; //string
	public $reason; //string

	function __construct($hostName = null, $reason = null) {
		$this->hostName = $hostName;
		$this->reason = $reason;
	}
}

class HostIncompatibleForRecordReplay {
	public $hostName; //string
	public $reason; //string

	function __construct($hostName = null, $reason = null) {
		$this->hostName = $hostName;
		$this->reason = $reason;
	}
}

class HostInventoryFull {
	public $capacity; //int

	function __construct($capacity = null) {
		$this->capacity = $capacity;
	}
}

class HostPowerOpFailed {
}

class HotSnapshotMoveNotSupported {
}

class IDEDiskNotSupported {
}

class IORMNotSupportedHostOnDatastore {
	public $datastore; //ManagedObjectReference
	public $datastoreName; //string
	public $host; //ManagedObjectReference

	function __construct($datastore = null, $datastoreName = null, $host = null) {
		$this->datastore = $datastore;
		$this->datastoreName = $datastoreName;
		$this->host = $host;
	}
}

class InUseFeatureManipulationDisallowed {
}

class InaccessibleDatastore {
	public $detail; //string

	function __construct($detail = null) {
		$this->detail = $detail;
	}
}

class IncompatibleDefaultDevice {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class IncompatibleHostForFtSecondary {
	public $host; //ManagedObjectReference
	public $error; //LocalizedMethodFault

	function __construct($host = null, $error = null) {
		$this->host = $host;
		$this->error = $error;
	}
}

class IncompatibleSetting {
	public $conflictingProperty; //string

	function __construct($conflictingProperty = null) {
		$this->conflictingProperty = $conflictingProperty;
	}
}

class IncorrectFileType {
}

class IncorrectHostInformation {
}

class IndependentDiskVMotionNotSupported {
}

class InsufficientAgentVmsDeployed {
	public $hostName; //string
	public $requiredNumAgentVms; //int
	public $currentNumAgentVms; //int

	function __construct($hostName = null, $requiredNumAgentVms = null, $currentNumAgentVms = null) {
		$this->hostName = $hostName;
		$this->requiredNumAgentVms = $requiredNumAgentVms;
		$this->currentNumAgentVms = $currentNumAgentVms;
	}
}

class InsufficientCpuResourcesFault {
	public $unreserved; //long
	public $requested; //long

	function __construct($unreserved = null, $requested = null) {
		$this->unreserved = $unreserved;
		$this->requested = $requested;
	}
}

class InsufficientFailoverResourcesFault {
}

class InsufficientHostCapacityFault {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class InsufficientHostCpuCapacityFault {
	public $unreserved; //long
	public $requested; //long

	function __construct($unreserved = null, $requested = null) {
		$this->unreserved = $unreserved;
		$this->requested = $requested;
	}
}

class InsufficientHostMemoryCapacityFault {
	public $unreserved; //long
	public $requested; //long

	function __construct($unreserved = null, $requested = null) {
		$this->unreserved = $unreserved;
		$this->requested = $requested;
	}
}

class InsufficientMemoryResourcesFault {
	public $unreserved; //long
	public $requested; //long

	function __construct($unreserved = null, $requested = null) {
		$this->unreserved = $unreserved;
		$this->requested = $requested;
	}
}

class InsufficientPerCpuCapacity {
}

class InsufficientResourcesFault {
}

class InsufficientStandbyCpuResource {
	public $available; //long
	public $requested; //long

	function __construct($available = null, $requested = null) {
		$this->available = $available;
		$this->requested = $requested;
	}
}

class InsufficientStandbyMemoryResource {
	public $available; //long
	public $requested; //long

	function __construct($available = null, $requested = null) {
		$this->available = $available;
		$this->requested = $requested;
	}
}

class InsufficientStandbyResource {
}

class InsufficientStorageSpace {
}

class InvalidAffinitySettingFault {
}

class InvalidBmcRole {
}

class InvalidBundle {
}

class InvalidCAMCertificate {
}

class InvalidCAMServer {
	public $camServer; //string

	function __construct($camServer = null) {
		$this->camServer = $camServer;
	}
}

class InvalidClientCertificate {
}

class InvalidController {
	public $controllerKey; //int

	function __construct($controllerKey = null) {
		$this->controllerKey = $controllerKey;
	}
}

class InvalidDasRestartPriorityForFtVm {
	public $vm; //ManagedObjectReference
	public $vmName; //string

	function __construct($vm = null, $vmName = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
	}
}

class InvalidDatastore {
	public $datastore; //ManagedObjectReference
	public $name; //string

	function __construct($datastore = null, $name = null) {
		$this->datastore = $datastore;
		$this->name = $name;
	}
}

class InvalidDatastorePath {
	public $datastorePath; //string

	function __construct($datastorePath = null) {
		$this->datastorePath = $datastorePath;
	}
}

class InvalidDatastoreState {
	public $datastoreName; //string

	function __construct($datastoreName = null) {
		$this->datastoreName = $datastoreName;
	}
}

class InvalidDeviceBacking {
}

class InvalidDeviceOperation {
	public $badOp; //VirtualDeviceConfigSpecOperation
	public $badFileOp; //VirtualDeviceConfigSpecFileOperation

	function __construct($badOp = null, $badFileOp = null) {
		$this->badOp = $badOp;
		$this->badFileOp = $badFileOp;
	}
}

class InvalidDeviceSpec {
	public $deviceIndex; //int

	function __construct($deviceIndex = null) {
		$this->deviceIndex = $deviceIndex;
	}
}

class InvalidDiskFormat {
}

class InvalidDrsBehaviorForFtVm {
	public $vm; //ManagedObjectReference
	public $vmName; //string

	function __construct($vm = null, $vmName = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
	}
}

class InvalidEditionLicense {
	public $feature; //string

	function __construct($feature = null) {
		$this->feature = $feature;
	}
}

class InvalidEvent {
}

class InvalidFolder {
	public $target; //ManagedObjectReference

	function __construct($target = null) {
		$this->target = $target;
	}
}

class InvalidFormat {
}

class InvalidGuestLogin {
}

class InvalidHostName {
}

class InvalidHostState {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class InvalidIndexArgument {
	public $key; //string

	function __construct($key = null) {
		$this->key = $key;
	}
}

class InvalidIpmiLoginInfo {
}

class InvalidIpmiMacAddress {
	public $userProvidedMacAddress; //string
	public $observedMacAddress; //string

	function __construct($userProvidedMacAddress = null, $observedMacAddress = null) {
		$this->userProvidedMacAddress = $userProvidedMacAddress;
		$this->observedMacAddress = $observedMacAddress;
	}
}

class InvalidLicense {
	public $licenseContent; //string

	function __construct($licenseContent = null) {
		$this->licenseContent = $licenseContent;
	}
}

class InvalidLocale {
}

class InvalidLogin {
}

class InvalidName {
	public $name; //string
	public $entity; //ManagedObjectReference

	function __construct($name = null, $entity = null) {
		$this->name = $name;
		$this->entity = $entity;
	}
}

class InvalidNasCredentials {
	public $userName; //string

	function __construct($userName = null) {
		$this->userName = $userName;
	}
}

class InvalidNetworkInType {
}

class InvalidNetworkResource {
	public $remoteHost; //string
	public $remotePath; //string

	function __construct($remoteHost = null, $remotePath = null) {
		$this->remoteHost = $remoteHost;
		$this->remotePath = $remotePath;
	}
}

class InvalidOperationOnSecondaryVm {
	public $instanceUuid; //string

	function __construct($instanceUuid = null) {
		$this->instanceUuid = $instanceUuid;
	}
}

class InvalidPowerState {
	public $requestedState; //VirtualMachinePowerState
	public $existingState; //VirtualMachinePowerState

	function __construct($requestedState = null, $existingState = null) {
		$this->requestedState = $requestedState;
		$this->existingState = $existingState;
	}
}

class InvalidPrivilege {
	public $privilege; //string

	function __construct($privilege = null) {
		$this->privilege = $privilege;
	}
}

class InvalidProfileReferenceHost {
	public $reason; //string
	public $host; //ManagedObjectReference
	public $profile; //ManagedObjectReference

	function __construct($reason = null, $host = null, $profile = null) {
		$this->reason = $reason;
		$this->host = $host;
		$this->profile = $profile;
	}
}

class InvalidPropertyType {
}

class InvalidPropertyValue {
}

class InvalidResourcePoolStructureFault {
}

class InvalidSnapshotFormat {
}

class InvalidState {
}

class InvalidVmConfig {
	public $property; //string

	function __construct($property = null) {
		$this->property = $property;
	}
}

class InventoryHasStandardAloneHosts {
	public $hosts; //string

	function __construct($hosts = null) {
		$this->hosts = $hosts;
	}
}

class IpHostnameGeneratorError {
}

class IscsiFault {
}

class IscsiFaultInvalidVnic {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultPnicInUse {
	public $pnicDevice; //string

	function __construct($pnicDevice = null) {
		$this->pnicDevice = $pnicDevice;
	}
}

class IscsiFaultVnicAlreadyBound {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicHasActivePaths {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicHasMultipleUplinks {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicHasNoUplinks {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicHasWrongUplink {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicInUse {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicIsLastPath {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicNotBound {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class IscsiFaultVnicNotFound {
	public $vnicDevice; //string

	function __construct($vnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
	}
}

class LargeRDMConversionNotSupported {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class LargeRDMNotSupportedOnDatastore {
	public $device; //string
	public $datastore; //ManagedObjectReference
	public $datastoreName; //string

	function __construct($device = null, $datastore = null, $datastoreName = null) {
		$this->device = $device;
		$this->datastore = $datastore;
		$this->datastoreName = $datastoreName;
	}
}

class LegacyNetworkInterfaceInUse {
}

class LicenseAssignmentFailed {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class LicenseDowngradeDisallowed {
	public $edition; //string
	public $entityId; //string
	public $features; //KeyAnyValue

	function __construct($edition = null, $entityId = null, $features = null) {
		$this->edition = $edition;
		$this->entityId = $entityId;
		$this->features = $features;
	}
}

class LicenseEntityNotFound {
	public $entityId; //string

	function __construct($entityId = null) {
		$this->entityId = $entityId;
	}
}

class LicenseExpired {
	public $licenseKey; //string

	function __construct($licenseKey = null) {
		$this->licenseKey = $licenseKey;
	}
}

class LicenseKeyEntityMismatch {
}

class LicenseRestricted {
}

class LicenseServerUnavailable {
	public $licenseServer; //string

	function __construct($licenseServer = null) {
		$this->licenseServer = $licenseServer;
	}
}

class LicenseSourceUnavailable {
	public $licenseSource; //LicenseSource

	function __construct($licenseSource = null) {
		$this->licenseSource = $licenseSource;
	}
}

class LimitExceeded {
	public $property; //string
	public $limit; //int

	function __construct($property = null, $limit = null) {
		$this->property = $property;
		$this->limit = $limit;
	}
}

class LinuxVolumeNotClean {
}

class LogBundlingFailed {
}

class MaintenanceModeFileMove {
}

class MemoryHotPlugNotSupported {
}

class MemorySizeNotRecommended {
	public $memorySizeMB; //int
	public $minMemorySizeMB; //int
	public $maxMemorySizeMB; //int

	function __construct($memorySizeMB = null, $minMemorySizeMB = null, $maxMemorySizeMB = null) {
		$this->memorySizeMB = $memorySizeMB;
		$this->minMemorySizeMB = $minMemorySizeMB;
		$this->maxMemorySizeMB = $maxMemorySizeMB;
	}
}

class MemorySizeNotSupported {
	public $memorySizeMB; //int
	public $minMemorySizeMB; //int
	public $maxMemorySizeMB; //int

	function __construct($memorySizeMB = null, $minMemorySizeMB = null, $maxMemorySizeMB = null) {
		$this->memorySizeMB = $memorySizeMB;
		$this->minMemorySizeMB = $minMemorySizeMB;
		$this->maxMemorySizeMB = $maxMemorySizeMB;
	}
}

class MemorySizeNotSupportedByDatastore {
	public $datastore; //ManagedObjectReference
	public $memorySizeMB; //int
	public $maxMemorySizeMB; //int

	function __construct($datastore = null, $memorySizeMB = null, $maxMemorySizeMB = null) {
		$this->datastore = $datastore;
		$this->memorySizeMB = $memorySizeMB;
		$this->maxMemorySizeMB = $maxMemorySizeMB;
	}
}

class MemorySnapshotOnIndependentDisk {
}

class MethodAlreadyDisabledFault {
	public $sourceId; //string

	function __construct($sourceId = null) {
		$this->sourceId = $sourceId;
	}
}

class MethodDisabled {
	public $source; //string

	function __construct($source = null) {
		$this->source = $source;
	}
}

class MigrationDisabled {
}

class MigrationFault {
}

class MigrationFeatureNotSupported {
	public $atSourceHost; //boolean
	public $failedHostName; //string
	public $failedHost; //ManagedObjectReference

	function __construct($atSourceHost = null, $failedHostName = null, $failedHost = null) {
		$this->atSourceHost = $atSourceHost;
		$this->failedHostName = $failedHostName;
		$this->failedHost = $failedHost;
	}
}

class MigrationNotReady {
	public $reason; //string

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class MismatchedBundle {
	public $bundleUuid; //string
	public $hostUuid; //string
	public $bundleBuildNumber; //int
	public $hostBuildNumber; //int

	function __construct($bundleUuid = null, $hostUuid = null, $bundleBuildNumber = null, $hostBuildNumber = null) {
		$this->bundleUuid = $bundleUuid;
		$this->hostUuid = $hostUuid;
		$this->bundleBuildNumber = $bundleBuildNumber;
		$this->hostBuildNumber = $hostBuildNumber;
	}
}

class MismatchedNetworkPolicies {
	public $device; //string
	public $backing; //string
	public $connected; //boolean

	function __construct($device = null, $backing = null, $connected = null) {
		$this->device = $device;
		$this->backing = $backing;
		$this->connected = $connected;
	}
}

class MismatchedVMotionNetworkNames {
	public $sourceNetwork; //string
	public $destNetwork; //string

	function __construct($sourceNetwork = null, $destNetwork = null) {
		$this->sourceNetwork = $sourceNetwork;
		$this->destNetwork = $destNetwork;
	}
}

class MissingBmcSupport {
}

class MissingController {
}

class MissingIpPool {
}

class MissingLinuxCustResources {
}

class MissingNetworkIpConfig {
}

class MissingPowerOffConfiguration {
}

class MissingPowerOnConfiguration {
}

class MissingWindowsCustResources {
}

class MksConnectionLimitReached {
	public $connectionLimit; //int

	function __construct($connectionLimit = null) {
		$this->connectionLimit = $connectionLimit;
	}
}

class MountError {
	public $vm; //ManagedObjectReference
	public $diskIndex; //int

	function __construct($vm = null, $diskIndex = null) {
		$this->vm = $vm;
		$this->diskIndex = $diskIndex;
	}
}

class MultipleCertificatesVerifyFaultThumbprintData {
	public $port; //int
	public $thumbprint; //string

	function __construct($port = null, $thumbprint = null) {
		$this->port = $port;
		$this->thumbprint = $thumbprint;
	}
}

class ArrayOfMultipleCertificatesVerifyFaultThumbprintData {
	public $MultipleCertificatesVerifyFaultThumbprintData; //MultipleCertificatesVerifyFaultThumbprintData

	function __construct($MultipleCertificatesVerifyFaultThumbprintData = null) {
		$this->MultipleCertificatesVerifyFaultThumbprintData = $MultipleCertificatesVerifyFaultThumbprintData;
	}
}

class MultipleCertificatesVerifyFault {
	public $thumbprintData; //MultipleCertificatesVerifyFaultThumbprintData

	function __construct($thumbprintData = null) {
		$this->thumbprintData = $thumbprintData;
	}
}

class MultipleSnapshotsNotSupported {
}

class NasConfigFault {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class NasConnectionLimitReached {
	public $remoteHost; //string
	public $remotePath; //string

	function __construct($remoteHost = null, $remotePath = null) {
		$this->remoteHost = $remoteHost;
		$this->remotePath = $remotePath;
	}
}

class NasSessionCredentialConflict {
	public $remoteHost; //string
	public $remotePath; //string
	public $userName; //string

	function __construct($remoteHost = null, $remotePath = null, $userName = null) {
		$this->remoteHost = $remoteHost;
		$this->remotePath = $remotePath;
		$this->userName = $userName;
	}
}

class NasVolumeNotMounted {
	public $remoteHost; //string
	public $remotePath; //string

	function __construct($remoteHost = null, $remotePath = null) {
		$this->remoteHost = $remoteHost;
		$this->remotePath = $remotePath;
	}
}

class NetworkCopyFault {
}

class NetworkInaccessible {
}

class NetworksMayNotBeTheSame {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class NicSettingMismatch {
	public $numberOfNicsInSpec; //int
	public $numberOfNicsInVM; //int

	function __construct($numberOfNicsInSpec = null, $numberOfNicsInVM = null) {
		$this->numberOfNicsInSpec = $numberOfNicsInSpec;
		$this->numberOfNicsInVM = $numberOfNicsInVM;
	}
}

class NoActiveHostInCluster {
	public $computeResource; //ManagedObjectReference

	function __construct($computeResource = null) {
		$this->computeResource = $computeResource;
	}
}

class NoAvailableIp {
	public $network; //ManagedObjectReference

	function __construct($network = null) {
		$this->network = $network;
	}
}

class NoClientCertificate {
}

class NoCompatibleDatastore {
}

class NoCompatibleHardAffinityHost {
	public $vmName; //string

	function __construct($vmName = null) {
		$this->vmName = $vmName;
	}
}

class NoCompatibleHost {
	public $host; //ManagedObjectReference
	public $error; //LocalizedMethodFault

	function __construct($host = null, $error = null) {
		$this->host = $host;
		$this->error = $error;
	}
}

class NoCompatibleHostWithAccessToDevice {
}

class NoCompatibleSoftAffinityHost {
	public $vmName; //string

	function __construct($vmName = null) {
		$this->vmName = $vmName;
	}
}

class NoConnectedDatastore {
}

class NoDiskFound {
}

class NoDiskSpace {
	public $datastore; //string

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class NoDisksToCustomize {
}

class NoGateway {
}

class NoGuestHeartbeat {
}

class NoHost {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class NoHostSuitableForFtSecondary {
	public $vm; //ManagedObjectReference
	public $vmName; //string

	function __construct($vm = null, $vmName = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
	}
}

class NoLicenseServerConfigured {
}

class NoPeerHostFound {
}

class NoPermission {
	public $object; //ManagedObjectReference
	public $privilegeId; //string

	function __construct($object = null, $privilegeId = null) {
		$this->object = $object;
		$this->privilegeId = $privilegeId;
	}
}

class NoPermissionOnAD {
}

class NoPermissionOnHost {
}

class NoPermissionOnNasVolume {
	public $userName; //string

	function __construct($userName = null) {
		$this->userName = $userName;
	}
}

class NoSubjectName {
}

class NoVcManagedIpConfigured {
}

class NoVirtualNic {
}

class NoVmInVApp {
}

class NonADUserRequired {
}

class NonHomeRDMVMotionNotSupported {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class NonPersistentDisksNotSupported {
}

class NotADirectory {
}

class NotAFile {
}

class NotAuthenticated {
}

class NotEnoughCpus {
	public $numCpuDest; //int
	public $numCpuVm; //int

	function __construct($numCpuDest = null, $numCpuVm = null) {
		$this->numCpuDest = $numCpuDest;
		$this->numCpuVm = $numCpuVm;
	}
}

class NotEnoughLogicalCpus {
	public $host; //ManagedObjectReference

	function __construct($host = null) {
		$this->host = $host;
	}
}

class NotFound {
}

class NotSupportedDeviceForFT {
	public $host; //ManagedObjectReference
	public $hostName; //string
	public $vm; //ManagedObjectReference
	public $vmName; //string
	public $deviceType; //string
	public $deviceLabel; //string

	function __construct($host = null, $hostName = null, $vm = null, $vmName = null, $deviceType = null, $deviceLabel = null) {
		$this->host = $host;
		$this->hostName = $hostName;
		$this->vm = $vm;
		$this->vmName = $vmName;
		$this->deviceType = $deviceType;
		$this->deviceLabel = $deviceLabel;
	}
}

class NotSupportedHost {
	public $productName; //string
	public $productVersion; //string

	function __construct($productName = null, $productVersion = null) {
		$this->productName = $productName;
		$this->productVersion = $productVersion;
	}
}

class NotSupportedHostInCluster {
}

class NotSupportedHostInDvs {
	public $switchProductSpec; //DistributedVirtualSwitchProductSpec

	function __construct($switchProductSpec = null) {
		$this->switchProductSpec = $switchProductSpec;
	}
}

class NotSupportedHostInHACluster {
	public $hostName; //string
	public $build; //string

	function __construct($hostName = null, $build = null) {
		$this->hostName = $hostName;
		$this->build = $build;
	}
}

class NotUserConfigurableProperty {
}

class NumVirtualCoresPerSocketNotSupported {
	public $maxSupportedCoresPerSocketDest; //int
	public $numCoresPerSocketVm; //int

	function __construct($maxSupportedCoresPerSocketDest = null, $numCoresPerSocketVm = null) {
		$this->maxSupportedCoresPerSocketDest = $maxSupportedCoresPerSocketDest;
		$this->numCoresPerSocketVm = $numCoresPerSocketVm;
	}
}

class NumVirtualCpusExceedsLimit {
	public $maxSupportedVcpus; //int

	function __construct($maxSupportedVcpus = null) {
		$this->maxSupportedVcpus = $maxSupportedVcpus;
	}
}

class NumVirtualCpusIncompatible {
	public $reason; //string
	public $numCpu; //int

	function __construct($reason = null, $numCpu = null) {
		$this->reason = $reason;
		$this->numCpu = $numCpu;
	}
}

class NumVirtualCpusNotSupported {
	public $maxSupportedVcpusDest; //int
	public $numCpuVm; //int

	function __construct($maxSupportedVcpusDest = null, $numCpuVm = null) {
		$this->maxSupportedVcpusDest = $maxSupportedVcpusDest;
		$this->numCpuVm = $numCpuVm;
	}
}

class OperationDisabledByGuest {
}

class OperationDisallowedOnHost {
}

class OperationNotSupportedByGuest {
}

class OutOfBounds {
	public $argumentName; //string

	function __construct($argumentName = null) {
		$this->argumentName = $argumentName;
	}
}

class OvfAttribute {
	public $elementName; //string
	public $attributeName; //string

	function __construct($elementName = null, $attributeName = null) {
		$this->elementName = $elementName;
		$this->attributeName = $attributeName;
	}
}

class OvfConnectedDevice {
}

class OvfConnectedDeviceFloppy {
	public $filename; //string

	function __construct($filename = null) {
		$this->filename = $filename;
	}
}

class OvfConnectedDeviceIso {
	public $filename; //string

	function __construct($filename = null) {
		$this->filename = $filename;
	}
}

class OvfConstraint {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class OvfConsumerCallbackFault {
	public $extensionKey; //string
	public $extensionName; //string

	function __construct($extensionKey = null, $extensionName = null) {
		$this->extensionKey = $extensionKey;
		$this->extensionName = $extensionName;
	}
}

class OvfConsumerCommunicationError {
	public $description; //string

	function __construct($description = null) {
		$this->description = $description;
	}
}

class OvfConsumerFault {
	public $errorKey; //string
	public $message; //string
	public $params; //KeyValue

	function __construct($errorKey = null, $message = null, $params = null) {
		$this->errorKey = $errorKey;
		$this->message = $message;
		$this->params = $params;
	}
}

class OvfConsumerInvalidSection {
	public $lineNumber; //int
	public $description; //string

	function __construct($lineNumber = null, $description = null) {
		$this->lineNumber = $lineNumber;
		$this->description = $description;
	}
}

class OvfConsumerPowerOnFault {
	public $extensionKey; //string
	public $extensionName; //string
	public $description; //string

	function __construct($extensionKey = null, $extensionName = null, $description = null) {
		$this->extensionKey = $extensionKey;
		$this->extensionName = $extensionName;
		$this->description = $description;
	}
}

class OvfConsumerUndeclaredSection {
	public $qualifiedSectionType; //string

	function __construct($qualifiedSectionType = null) {
		$this->qualifiedSectionType = $qualifiedSectionType;
	}
}

class OvfConsumerUndefinedPrefix {
	public $prefix; //string

	function __construct($prefix = null) {
		$this->prefix = $prefix;
	}
}

class OvfConsumerValidationFault {
	public $extensionKey; //string
	public $extensionName; //string
	public $message; //string

	function __construct($extensionKey = null, $extensionName = null, $message = null) {
		$this->extensionKey = $extensionKey;
		$this->extensionName = $extensionName;
		$this->message = $message;
	}
}

class OvfCpuCompatibility {
	public $registerName; //string
	public $level; //int
	public $registerValue; //string
	public $desiredRegisterValue; //string

	function __construct($registerName = null, $level = null, $registerValue = null, $desiredRegisterValue = null) {
		$this->registerName = $registerName;
		$this->level = $level;
		$this->registerValue = $registerValue;
		$this->desiredRegisterValue = $desiredRegisterValue;
	}
}

class OvfCpuCompatibilityCheckNotSupported {
}

class OvfDiskMappingNotFound {
	public $diskName; //string
	public $vmName; //string

	function __construct($diskName = null, $vmName = null) {
		$this->diskName = $diskName;
		$this->vmName = $vmName;
	}
}

class OvfDiskOrderConstraint {
}

class OvfDuplicateElement {
}

class OvfDuplicatedElementBoundary {
	public $boundary; //string

	function __construct($boundary = null) {
		$this->boundary = $boundary;
	}
}

class OvfDuplicatedPropertyIdExport {
	public $fqid; //string

	function __construct($fqid = null) {
		$this->fqid = $fqid;
	}
}

class OvfDuplicatedPropertyIdImport {
}

class OvfElement {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class OvfElementInvalidValue {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class OvfExport {
}

class OvfExportFailed {
}

class OvfFault {
}

class OvfHardwareCheck {
}

class OvfHardwareExport {
	public $device; //VirtualDevice
	public $vmPath; //string

	function __construct($device = null, $vmPath = null) {
		$this->device = $device;
		$this->vmPath = $vmPath;
	}
}

class OvfHostResourceConstraint {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class OvfHostValueNotParsed {
	public $property; //string
	public $value; //string

	function __construct($property = null, $value = null) {
		$this->property = $property;
		$this->value = $value;
	}
}

class OvfImport {
}

class OvfImportFailed {
}

class OvfInternalError {
}

class OvfInvalidPackage {
	public $lineNumber; //int

	function __construct($lineNumber = null) {
		$this->lineNumber = $lineNumber;
	}
}

class OvfInvalidValue {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class OvfInvalidValueConfiguration {
}

class OvfInvalidValueEmpty {
}

class OvfInvalidValueFormatMalformed {
}

class OvfInvalidValueReference {
}

class OvfInvalidVmName {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class OvfMappedOsId {
	public $ovfId; //int
	public $ovfDescription; //string
	public $targetDescription; //string

	function __construct($ovfId = null, $ovfDescription = null, $targetDescription = null) {
		$this->ovfId = $ovfId;
		$this->ovfDescription = $ovfDescription;
		$this->targetDescription = $targetDescription;
	}
}

class OvfMissingAttribute {
}

class OvfMissingElement {
}

class OvfMissingElementNormalBoundary {
	public $boundary; //string

	function __construct($boundary = null) {
		$this->boundary = $boundary;
	}
}

class OvfMissingHardware {
	public $name; //string
	public $resourceType; //int

	function __construct($name = null, $resourceType = null) {
		$this->name = $name;
		$this->resourceType = $resourceType;
	}
}

class OvfNoHostNic {
}

class OvfNoSpaceOnController {
	public $parent; //string

	function __construct($parent = null) {
		$this->parent = $parent;
	}
}

class OvfNoSupportedHardwareFamily {
	public $version; //string

	function __construct($version = null) {
		$this->version = $version;
	}
}

class OvfProperty {
	public $type; //string
	public $value; //string

	function __construct($type = null, $value = null) {
		$this->type = $type;
		$this->value = $value;
	}
}

class OvfPropertyExport {
	public $type; //string
	public $value; //string

	function __construct($type = null, $value = null) {
		$this->type = $type;
		$this->value = $value;
	}
}

class OvfPropertyNetwork {
}

class OvfPropertyNetworkExport {
	public $network; //string

	function __construct($network = null) {
		$this->network = $network;
	}
}

class OvfPropertyQualifier {
	public $qualifier; //string

	function __construct($qualifier = null) {
		$this->qualifier = $qualifier;
	}
}

class OvfPropertyQualifierDuplicate {
	public $qualifier; //string

	function __construct($qualifier = null) {
		$this->qualifier = $qualifier;
	}
}

class OvfPropertyQualifierIgnored {
	public $qualifier; //string

	function __construct($qualifier = null) {
		$this->qualifier = $qualifier;
	}
}

class OvfPropertyType {
}

class OvfPropertyValue {
}

class OvfSystemFault {
}

class OvfToXmlUnsupportedElement {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class OvfUnableToExportDisk {
	public $diskName; //string

	function __construct($diskName = null) {
		$this->diskName = $diskName;
	}
}

class OvfUnexpectedElement {
}

class OvfUnknownDevice {
	public $device; //VirtualDevice
	public $vmName; //string

	function __construct($device = null, $vmName = null) {
		$this->device = $device;
		$this->vmName = $vmName;
	}
}

class OvfUnknownDeviceBacking {
	public $backing; //VirtualDeviceBackingInfo

	function __construct($backing = null) {
		$this->backing = $backing;
	}
}

class OvfUnknownEntity {
	public $lineNumber; //int

	function __construct($lineNumber = null) {
		$this->lineNumber = $lineNumber;
	}
}

class OvfUnsupportedAttribute {
	public $elementName; //string
	public $attributeName; //string

	function __construct($elementName = null, $attributeName = null) {
		$this->elementName = $elementName;
		$this->attributeName = $attributeName;
	}
}

class OvfUnsupportedAttributeValue {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class OvfUnsupportedDeviceBackingInfo {
	public $elementName; //string
	public $instanceId; //string
	public $deviceName; //string
	public $backingName; //string

	function __construct($elementName = null, $instanceId = null, $deviceName = null, $backingName = null) {
		$this->elementName = $elementName;
		$this->instanceId = $instanceId;
		$this->deviceName = $deviceName;
		$this->backingName = $backingName;
	}
}

class OvfUnsupportedDeviceBackingOption {
	public $elementName; //string
	public $instanceId; //string
	public $deviceName; //string
	public $backingName; //string

	function __construct($elementName = null, $instanceId = null, $deviceName = null, $backingName = null) {
		$this->elementName = $elementName;
		$this->instanceId = $instanceId;
		$this->deviceName = $deviceName;
		$this->backingName = $backingName;
	}
}

class OvfUnsupportedDeviceExport {
}

class OvfUnsupportedDiskProvisioning {
	public $diskProvisioning; //string
	public $supportedDiskProvisioning; //string

	function __construct($diskProvisioning = null, $supportedDiskProvisioning = null) {
		$this->diskProvisioning = $diskProvisioning;
		$this->supportedDiskProvisioning = $supportedDiskProvisioning;
	}
}

class OvfUnsupportedElement {
	public $name; //string

	function __construct($name = null) {
		$this->name = $name;
	}
}

class OvfUnsupportedElementValue {
	public $value; //string

	function __construct($value = null) {
		$this->value = $value;
	}
}

class OvfUnsupportedPackage {
	public $lineNumber; //int

	function __construct($lineNumber = null) {
		$this->lineNumber = $lineNumber;
	}
}

class OvfUnsupportedSection {
	public $info; //string

	function __construct($info = null) {
		$this->info = $info;
	}
}

class OvfUnsupportedSubType {
	public $elementName; //string
	public $instanceId; //string
	public $deviceType; //int
	public $deviceSubType; //string

	function __construct($elementName = null, $instanceId = null, $deviceType = null, $deviceSubType = null) {
		$this->elementName = $elementName;
		$this->instanceId = $instanceId;
		$this->deviceType = $deviceType;
		$this->deviceSubType = $deviceSubType;
	}
}

class OvfUnsupportedType {
	public $name; //string
	public $instanceId; //string
	public $deviceType; //int

	function __construct($name = null, $instanceId = null, $deviceType = null) {
		$this->name = $name;
		$this->instanceId = $instanceId;
		$this->deviceType = $deviceType;
	}
}

class OvfWrongElement {
}

class OvfWrongNamespace {
	public $namespaceName; //string

	function __construct($namespaceName = null) {
		$this->namespaceName = $namespaceName;
	}
}

class OvfXmlFormat {
	public $description; //string

	function __construct($description = null) {
		$this->description = $description;
	}
}

class PatchAlreadyInstalled {
}

class PatchBinariesNotFound {
	public $patchID; //string
	public $binary; //string

	function __construct($patchID = null, $binary = null) {
		$this->patchID = $patchID;
		$this->binary = $binary;
	}
}

class PatchInstallFailed {
	public $rolledBack; //boolean

	function __construct($rolledBack = null) {
		$this->rolledBack = $rolledBack;
	}
}

class PatchIntegrityError {
}

class PatchMetadataCorrupted {
}

class PatchMetadataInvalid {
	public $patchID; //string
	public $metaData; //string

	function __construct($patchID = null, $metaData = null) {
		$this->patchID = $patchID;
		$this->metaData = $metaData;
	}
}

class PatchMetadataNotFound {
}

class PatchMissingDependencies {
	public $prerequisitePatch; //string
	public $prerequisiteLib; //string

	function __construct($prerequisitePatch = null, $prerequisiteLib = null) {
		$this->prerequisitePatch = $prerequisitePatch;
		$this->prerequisiteLib = $prerequisiteLib;
	}
}

class PatchNotApplicable {
	public $patchID; //string

	function __construct($patchID = null) {
		$this->patchID = $patchID;
	}
}

class PatchSuperseded {
	public $supersede; //string

	function __construct($supersede = null) {
		$this->supersede = $supersede;
	}
}

class PhysCompatRDMNotSupported {
}

class PlatformConfigFault {
	public $text; //string

	function __construct($text = null) {
		$this->text = $text;
	}
}

class PowerOnFtSecondaryFailed {
	public $vm; //ManagedObjectReference
	public $vmName; //string
	public $hostSelectionBy; //FtIssuesOnHostHostSelectionType
	public $hostErrors; //LocalizedMethodFault
	public $rootCause; //LocalizedMethodFault

	function __construct($vm = null, $vmName = null, $hostSelectionBy = null, $hostErrors = null, $rootCause = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
		$this->hostSelectionBy = $hostSelectionBy;
		$this->hostErrors = $hostErrors;
		$this->rootCause = $rootCause;
	}
}

class PowerOnFtSecondaryTimedout {
	public $vm; //ManagedObjectReference
	public $vmName; //string
	public $timeout; //int

	function __construct($vm = null, $vmName = null, $timeout = null) {
		$this->vm = $vm;
		$this->vmName = $vmName;
		$this->timeout = $timeout;
	}
}

class ProfileUpdateFailedUpdateFailure {
	public $profilePath; //ProfilePropertyPath
	public $errMsg; //LocalizableMessage

	function __construct($profilePath = null, $errMsg = null) {
		$this->profilePath = $profilePath;
		$this->errMsg = $errMsg;
	}
}

class ArrayOfProfileUpdateFailedUpdateFailure {
	public $ProfileUpdateFailedUpdateFailure; //ProfileUpdateFailedUpdateFailure

	function __construct($ProfileUpdateFailedUpdateFailure = null) {
		$this->ProfileUpdateFailedUpdateFailure = $ProfileUpdateFailedUpdateFailure;
	}
}

class ProfileUpdateFailed {
	public $failure; //ProfileUpdateFailedUpdateFailure

	function __construct($failure = null) {
		$this->failure = $failure;
	}
}

class QuestionPending {
	public $text; //string

	function __construct($text = null) {
		$this->text = $text;
	}
}

class QuiesceDatastoreIOForHAFailed {
	public $host; //ManagedObjectReference
	public $hostName; //string
	public $ds; //ManagedObjectReference
	public $dsName; //string

	function __construct($host = null, $hostName = null, $ds = null, $dsName = null) {
		$this->host = $host;
		$this->hostName = $hostName;
		$this->ds = $ds;
		$this->dsName = $dsName;
	}
}

class RDMConversionNotSupported {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class RDMNotPreserved {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class RDMNotSupported {
}

class RDMNotSupportedOnDatastore {
	public $device; //string
	public $datastore; //ManagedObjectReference
	public $datastoreName; //string

	function __construct($device = null, $datastore = null, $datastoreName = null) {
		$this->device = $device;
		$this->datastore = $datastore;
		$this->datastoreName = $datastoreName;
	}
}

class RDMPointsToInaccessibleDisk {
}

class RawDiskNotSupported {
}

class ReadHostResourcePoolTreeFailed {
}

class ReadOnlyDisksWithLegacyDestination {
	public $roDiskCount; //int
	public $timeoutDanger; //boolean

	function __construct($roDiskCount = null, $timeoutDanger = null) {
		$this->roDiskCount = $roDiskCount;
		$this->timeoutDanger = $timeoutDanger;
	}
}

class RebootRequired {
	public $patch; //string

	function __construct($patch = null) {
		$this->patch = $patch;
	}
}

class RecordReplayDisabled {
}

class RemoteDeviceNotSupported {
}

class RemoveFailed {
}

class ReplicationConfigFault {
}

class ReplicationDiskConfigFault {
	public $reason; //string
	public $vmRef; //ManagedObjectReference
	public $key; //int

	function __construct($reason = null, $vmRef = null, $key = null) {
		$this->reason = $reason;
		$this->vmRef = $vmRef;
		$this->key = $key;
	}
}

class ReplicationFault {
}

class ReplicationIncompatibleWithFT {
}

class ReplicationInvalidOptions {
	public $options; //string
	public $entity; //ManagedObjectReference

	function __construct($options = null, $entity = null) {
		$this->options = $options;
		$this->entity = $entity;
	}
}

class ReplicationNotSupportedOnHost {
}

class ReplicationVmConfigFault {
	public $reason; //string
	public $vmRef; //ManagedObjectReference

	function __construct($reason = null, $vmRef = null) {
		$this->reason = $reason;
		$this->vmRef = $vmRef;
	}
}

class ReplicationVmFault {
	public $reason; //string
	public $state; //string
	public $instanceId; //string
	public $vm; //ManagedObjectReference

	function __construct($reason = null, $state = null, $instanceId = null, $vm = null) {
		$this->reason = $reason;
		$this->state = $state;
		$this->instanceId = $instanceId;
		$this->vm = $vm;
	}
}

class ResourceInUse {
	public $type; //string
	public $name; //string

	function __construct($type = null, $name = null) {
		$this->type = $type;
		$this->name = $name;
	}
}

class ResourceNotAvailable {
	public $containerType; //string
	public $containerName; //string
	public $type; //string

	function __construct($containerType = null, $containerName = null, $type = null) {
		$this->containerType = $containerType;
		$this->containerName = $containerName;
		$this->type = $type;
	}
}

class RestrictedVersion {
}

class RuleViolation {
	public $host; //ManagedObjectReference
	public $rule; //ClusterRuleInfo

	function __construct($host = null, $rule = null) {
		$this->host = $host;
		$this->rule = $rule;
	}
}

class SSLDisabledFault {
}

class SSLVerifyFault {
	public $selfSigned; //boolean
	public $thumbprint; //string

	function __construct($selfSigned = null, $thumbprint = null) {
		$this->selfSigned = $selfSigned;
		$this->thumbprint = $thumbprint;
	}
}

class SSPIChallenge {
	public $base64Token; //string

	function __construct($base64Token = null) {
		$this->base64Token = $base64Token;
	}
}

class SecondaryVmAlreadyDisabled {
	public $instanceUuid; //string

	function __construct($instanceUuid = null) {
		$this->instanceUuid = $instanceUuid;
	}
}

class SecondaryVmAlreadyEnabled {
	public $instanceUuid; //string

	function __construct($instanceUuid = null) {
		$this->instanceUuid = $instanceUuid;
	}
}

class SecondaryVmAlreadyRegistered {
	public $instanceUuid; //string

	function __construct($instanceUuid = null) {
		$this->instanceUuid = $instanceUuid;
	}
}

class SecondaryVmNotRegistered {
	public $instanceUuid; //string

	function __construct($instanceUuid = null) {
		$this->instanceUuid = $instanceUuid;
	}
}

class SharedBusControllerNotSupported {
}

class SnapshotCloneNotSupported {
}

class SnapshotCopyNotSupported {
}

class SnapshotDisabled {
}

class SnapshotFault {
}

class SnapshotIncompatibleDeviceInVm {
	public $fault; //LocalizedMethodFault

	function __construct($fault = null) {
		$this->fault = $fault;
	}
}

class SnapshotLocked {
}

class SnapshotMoveFromNonHomeNotSupported {
}

class SnapshotMoveNotSupported {
}

class SnapshotMoveToNonHomeNotSupported {
}

class SnapshotNoChange {
}

class SnapshotRevertIssue {
	public $snapshotName; //string
	public $event; //Event
	public $errors; //boolean

	function __construct($snapshotName = null, $event = null, $errors = null) {
		$this->snapshotName = $snapshotName;
		$this->event = $event;
		$this->errors = $errors;
	}
}

class SoftRuleVioCorrectionDisallowed {
	public $vmName; //string

	function __construct($vmName = null) {
		$this->vmName = $vmName;
	}
}

class SoftRuleVioCorrectionImpact {
	public $vmName; //string

	function __construct($vmName = null) {
		$this->vmName = $vmName;
	}
}

class StorageDrsDisabledOnVm {
}

class StorageDrsIolbDisabledInternally {
}

class StorageVMotionNotSupported {
}

class StorageVmotionIncompatible {
	public $datastore; //ManagedObjectReference

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class SuspendedRelocateNotSupported {
}

class SwapDatastoreNotWritableOnHost {
}

class SwapDatastoreUnset {
}

class SwapPlacementOverrideNotSupported {
}

class SwitchNotInUpgradeMode {
}

class TaskInProgress {
	public $task; //ManagedObjectReference

	function __construct($task = null) {
		$this->task = $task;
	}
}

class ThirdPartyLicenseAssignmentFailed {
	public $host; //ManagedObjectReference
	public $module; //string
	public $reason; //string

	function __construct($host = null, $module = null, $reason = null) {
		$this->host = $host;
		$this->module = $module;
		$this->reason = $reason;
	}
}

class Timedout {
}

class TooManyConcurrentNativeClones {
}

class TooManyConsecutiveOverrides {
}

class TooManyDevices {
}

class TooManyDisksOnLegacyHost {
	public $diskCount; //int
	public $timeoutDanger; //boolean

	function __construct($diskCount = null, $timeoutDanger = null) {
		$this->diskCount = $diskCount;
		$this->timeoutDanger = $timeoutDanger;
	}
}

class TooManyGuestLogons {
}

class TooManyHosts {
}

class TooManyNativeCloneLevels {
}

class TooManyNativeClonesOnFile {
}

class TooManySnapshotLevels {
}

class ToolsAlreadyUpgraded {
}

class ToolsAutoUpgradeNotSupported {
}

class ToolsImageNotAvailable {
}

class ToolsImageSignatureCheckFailed {
}

class ToolsInstallationInProgress {
}

class ToolsUnavailable {
}

class ToolsUpgradeCancelled {
}

class UncommittedUndoableDisk {
}

class UnconfiguredPropertyValue {
}

class UncustomizableGuest {
	public $uncustomizableGuestOS; //string

	function __construct($uncustomizableGuestOS = null) {
		$this->uncustomizableGuestOS = $uncustomizableGuestOS;
	}
}

class UnexpectedCustomizationFault {
}

class UnrecognizedHost {
	public $hostName; //string

	function __construct($hostName = null) {
		$this->hostName = $hostName;
	}
}

class UnsharedSwapVMotionNotSupported {
}

class UnsupportedDatastore {
	public $datastore; //ManagedObjectReference

	function __construct($datastore = null) {
		$this->datastore = $datastore;
	}
}

class UnsupportedGuest {
	public $unsupportedGuestOS; //string

	function __construct($unsupportedGuestOS = null) {
		$this->unsupportedGuestOS = $unsupportedGuestOS;
	}
}

class UnsupportedVimApiVersion {
	public $version; //string

	function __construct($version = null) {
		$this->version = $version;
	}
}

class UnsupportedVmxLocation {
}

class UnusedVirtualDiskBlocksNotScrubbed {
}

class UserNotFound {
	public $principal; //string
	public $unresolved; //boolean

	function __construct($principal = null, $unresolved = null) {
		$this->principal = $principal;
		$this->unresolved = $unresolved;
	}
}

class VAppConfigFault {
}

class VAppNotRunning {
}

class VAppOperationInProgress {
}

class VAppPropertyFault {
	public $id; //string
	public $category; //string
	public $label; //string
	public $type; //string
	public $value; //string

	function __construct($id = null, $category = null, $label = null, $type = null, $value = null) {
		$this->id = $id;
		$this->category = $category;
		$this->label = $label;
		$this->type = $type;
		$this->value = $value;
	}
}

class VAppTaskInProgress {
}

class VMINotSupported {
}

class VMOnConflictDVPort {
}

class VMOnVirtualIntranet {
}

class VMotionInterfaceIssue {
	public $atSourceHost; //boolean
	public $failedHost; //string
	public $failedHostEntity; //ManagedObjectReference

	function __construct($atSourceHost = null, $failedHost = null, $failedHostEntity = null) {
		$this->atSourceHost = $atSourceHost;
		$this->failedHost = $failedHost;
		$this->failedHostEntity = $failedHostEntity;
	}
}

class VMotionLinkCapacityLow {
	public $network; //string

	function __construct($network = null) {
		$this->network = $network;
	}
}

class VMotionLinkDown {
	public $network; //string

	function __construct($network = null) {
		$this->network = $network;
	}
}

class VMotionNotConfigured {
}

class VMotionNotLicensed {
}

class VMotionNotSupported {
}

class VMotionProtocolIncompatible {
}

class VimFault {
}

class VirtualDiskBlocksNotFullyProvisioned {
}

class VirtualDiskModeNotSupported {
	public $mode; //string

	function __construct($mode = null) {
		$this->mode = $mode;
	}
}

class VirtualEthernetCardNotSupported {
}

class VirtualHardwareCompatibilityIssue {
}

class VirtualHardwareVersionNotSupported {
	public $hostName; //string
	public $host; //ManagedObjectReference

	function __construct($hostName = null, $host = null) {
		$this->hostName = $hostName;
		$this->host = $host;
	}
}

class VmAlreadyExistsInDatacenter {
	public $host; //ManagedObjectReference
	public $hostname; //string
	public $vm; //ManagedObjectReference

	function __construct($host = null, $hostname = null, $vm = null) {
		$this->host = $host;
		$this->hostname = $hostname;
		$this->vm = $vm;
	}
}

class VmConfigFault {
}

class VmConfigIncompatibleForFaultTolerance {
	public $fault; //LocalizedMethodFault

	function __construct($fault = null) {
		$this->fault = $fault;
	}
}

class VmConfigIncompatibleForRecordReplay {
	public $fault; //LocalizedMethodFault

	function __construct($fault = null) {
		$this->fault = $fault;
	}
}

class VmFaultToleranceConfigIssue {
	public $reason; //string
	public $entityName; //string
	public $entity; //ManagedObjectReference

	function __construct($reason = null, $entityName = null, $entity = null) {
		$this->reason = $reason;
		$this->entityName = $entityName;
		$this->entity = $entity;
	}
}

class VmFaultToleranceConfigIssueWrapper {
	public $entityName; //string
	public $entity; //ManagedObjectReference
	public $error; //LocalizedMethodFault

	function __construct($entityName = null, $entity = null, $error = null) {
		$this->entityName = $entityName;
		$this->entity = $entity;
		$this->error = $error;
	}
}

class VmFaultToleranceInvalidFileBacking {
	public $backingType; //string
	public $backingFilename; //string

	function __construct($backingType = null, $backingFilename = null) {
		$this->backingType = $backingType;
		$this->backingFilename = $backingFilename;
	}
}

class VmFaultToleranceIssue {
}

class VmFaultToleranceOpIssuesList {
	public $errors; //LocalizedMethodFault
	public $warnings; //LocalizedMethodFault

	function __construct($errors = null, $warnings = null) {
		$this->errors = $errors;
		$this->warnings = $warnings;
	}
}

class VmFaultToleranceTooManyVMsOnHost {
	public $hostName; //string
	public $maxNumFtVms; //int

	function __construct($hostName = null, $maxNumFtVms = null) {
		$this->hostName = $hostName;
		$this->maxNumFtVms = $maxNumFtVms;
	}
}

class VmHostAffinityRuleViolation {
	public $vmName; //string
	public $hostName; //string

	function __construct($vmName = null, $hostName = null) {
		$this->vmName = $vmName;
		$this->hostName = $hostName;
	}
}

class VmLimitLicense {
	public $limit; //int

	function __construct($limit = null) {
		$this->limit = $limit;
	}
}

class VmMonitorIncompatibleForFaultTolerance {
}

class VmPowerOnDisabled {
}

class VmToolsUpgradeFault {
}

class VmValidateMaxDevice {
	public $device; //string
	public $max; //int
	public $count; //int

	function __construct($device = null, $max = null, $count = null) {
		$this->device = $device;
		$this->max = $max;
		$this->count = $count;
	}
}

class VmWwnConflict {
	public $vm; //ManagedObjectReference
	public $host; //ManagedObjectReference
	public $name; //string
	public $wwn; //long

	function __construct($vm = null, $host = null, $name = null, $wwn = null) {
		$this->vm = $vm;
		$this->host = $host;
		$this->name = $name;
		$this->wwn = $wwn;
	}
}

class VmfsAlreadyMounted {
}

class VmfsAmbiguousMount {
}

class VmfsMountFault {
	public $uuid; //string

	function __construct($uuid = null) {
		$this->uuid = $uuid;
	}
}

class VmotionInterfaceNotEnabled {
}

class VolumeEditorError {
}

class VramLimitLicense {
	public $limit; //int

	function __construct($limit = null) {
		$this->limit = $limit;
	}
}

class VspanDestPortConflict {
	public $vspanSessionKey1; //string
	public $vspanSessionKey2; //string
	public $portKey; //string

	function __construct($vspanSessionKey1 = null, $vspanSessionKey2 = null, $portKey = null) {
		$this->vspanSessionKey1 = $vspanSessionKey1;
		$this->vspanSessionKey2 = $vspanSessionKey2;
		$this->portKey = $portKey;
	}
}

class VspanPortConflict {
	public $vspanSessionKey1; //string
	public $vspanSessionKey2; //string
	public $portKey; //string

	function __construct($vspanSessionKey1 = null, $vspanSessionKey2 = null, $portKey = null) {
		$this->vspanSessionKey1 = $vspanSessionKey1;
		$this->vspanSessionKey2 = $vspanSessionKey2;
		$this->portKey = $portKey;
	}
}

class VspanPortMoveFault {
	public $srcPortgroupName; //string
	public $destPortgroupName; //string
	public $portKey; //string

	function __construct($srcPortgroupName = null, $destPortgroupName = null, $portKey = null) {
		$this->srcPortgroupName = $srcPortgroupName;
		$this->destPortgroupName = $destPortgroupName;
		$this->portKey = $portKey;
	}
}

class VspanPortPromiscChangeFault {
	public $portKey; //string

	function __construct($portKey = null) {
		$this->portKey = $portKey;
	}
}

class VspanPortgroupPromiscChangeFault {
	public $portgroupName; //string

	function __construct($portgroupName = null) {
		$this->portgroupName = $portgroupName;
	}
}

class VspanPortgroupTypeChangeFault {
	public $portgroupName; //string

	function __construct($portgroupName = null) {
		$this->portgroupName = $portgroupName;
	}
}

class VspanPromiscuousPortNotSupported {
	public $vspanSessionKey; //string
	public $portKey; //string

	function __construct($vspanSessionKey = null, $portKey = null) {
		$this->vspanSessionKey = $vspanSessionKey;
		$this->portKey = $portKey;
	}
}

class VspanSameSessionPortConflict {
	public $vspanSessionKey; //string
	public $portKey; //string

	function __construct($vspanSessionKey = null, $portKey = null) {
		$this->vspanSessionKey = $vspanSessionKey;
		$this->portKey = $portKey;
	}
}

class WakeOnLanNotSupported {
}

class WakeOnLanNotSupportedByVmotionNIC {
}

class WillLoseHAProtection {
	public $resolution; //string

	function __construct($resolution = null) {
		$this->resolution = $resolution;
	}
}

class WillModifyConfigCpuRequirements {
}

class WillResetSnapshotDirectory {
}

class HostActiveDirectoryInfo {
	public $joinedDomain; //string
	public $trustedDomain; //string
	public $domainMembershipStatus; //string

	function __construct($joinedDomain = null, $trustedDomain = null, $domainMembershipStatus = null) {
		$this->joinedDomain = $joinedDomain;
		$this->trustedDomain = $trustedDomain;
		$this->domainMembershipStatus = $domainMembershipStatus;
	}
}

class HostActiveDirectorySpec {
	public $domainName; //string
	public $userName; //string
	public $password; //string
	public $camServer; //string
	public $thumbprint; //string

	function __construct($domainName = null, $userName = null, $password = null, $camServer = null, $thumbprint = null) {
		$this->domainName = $domainName;
		$this->userName = $userName;
		$this->password = $password;
		$this->camServer = $camServer;
		$this->thumbprint = $thumbprint;
	}
}

class HostActiveDirectory {
	public $changeOperation; //string
	public $spec; //HostActiveDirectorySpec

	function __construct($changeOperation = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->spec = $spec;
	}
}

class ArrayOfHostActiveDirectory {
	public $HostActiveDirectory; //HostActiveDirectory

	function __construct($HostActiveDirectory = null) {
		$this->HostActiveDirectory = $HostActiveDirectory;
	}
}

class HostAuthenticationManagerInfo {
	public $authConfig; //HostAuthenticationStoreInfo

	function __construct($authConfig = null) {
		$this->authConfig = $authConfig;
	}
}

class HostAuthenticationStoreInfo {
	public $enabled; //boolean

	function __construct($enabled = null) {
		$this->enabled = $enabled;
	}
}

class ArrayOfHostAuthenticationStoreInfo {
	public $HostAuthenticationStoreInfo; //HostAuthenticationStoreInfo

	function __construct($HostAuthenticationStoreInfo = null) {
		$this->HostAuthenticationStoreInfo = $HostAuthenticationStoreInfo;
	}
}

class AutoStartDefaults {
	public $enabled; //boolean
	public $startDelay; //int
	public $stopDelay; //int
	public $waitForHeartbeat; //boolean
	public $stopAction; //string

	function __construct($enabled = null, $startDelay = null, $stopDelay = null, $waitForHeartbeat = null, $stopAction = null) {
		$this->enabled = $enabled;
		$this->startDelay = $startDelay;
		$this->stopDelay = $stopDelay;
		$this->waitForHeartbeat = $waitForHeartbeat;
		$this->stopAction = $stopAction;
	}
}

class AutoStartPowerInfo {
	public $key; //ManagedObjectReference
	public $startOrder; //int
	public $startDelay; //int
	public $waitForHeartbeat; //AutoStartWaitHeartbeatSetting
	public $startAction; //string
	public $stopDelay; //int
	public $stopAction; //string

	function __construct($key = null, $startOrder = null, $startDelay = null, $waitForHeartbeat = null, $startAction = null, $stopDelay = null, $stopAction = null) {
		$this->key = $key;
		$this->startOrder = $startOrder;
		$this->startDelay = $startDelay;
		$this->waitForHeartbeat = $waitForHeartbeat;
		$this->startAction = $startAction;
		$this->stopDelay = $stopDelay;
		$this->stopAction = $stopAction;
	}
}

class ArrayOfAutoStartPowerInfo {
	public $AutoStartPowerInfo; //AutoStartPowerInfo

	function __construct($AutoStartPowerInfo = null) {
		$this->AutoStartPowerInfo = $AutoStartPowerInfo;
	}
}

class HostAutoStartManagerConfig {
	public $defaults; //AutoStartDefaults
	public $powerInfo; //AutoStartPowerInfo

	function __construct($defaults = null, $powerInfo = null) {
		$this->defaults = $defaults;
		$this->powerInfo = $powerInfo;
	}
}

class HostBootDeviceInfo {
	public $bootDevices; //HostBootDevice
	public $currentBootDeviceKey; //string

	function __construct($bootDevices = null, $currentBootDeviceKey = null) {
		$this->bootDevices = $bootDevices;
		$this->currentBootDeviceKey = $currentBootDeviceKey;
	}
}

class HostBootDevice {
	public $key; //string
	public $description; //string

	function __construct($key = null, $description = null) {
		$this->key = $key;
		$this->description = $description;
	}
}

class ArrayOfHostBootDevice {
	public $HostBootDevice; //HostBootDevice

	function __construct($HostBootDevice = null) {
		$this->HostBootDevice = $HostBootDevice;
	}
}

class HostCacheConfigurationSpec {
	public $datastore; //ManagedObjectReference
	public $swapSize; //long

	function __construct($datastore = null, $swapSize = null) {
		$this->datastore = $datastore;
		$this->swapSize = $swapSize;
	}
}

class HostCacheConfigurationInfo {
	public $key; //ManagedObjectReference
	public $swapSize; //long

	function __construct($key = null, $swapSize = null) {
		$this->key = $key;
		$this->swapSize = $swapSize;
	}
}

class ArrayOfHostCacheConfigurationInfo {
	public $HostCacheConfigurationInfo; //HostCacheConfigurationInfo

	function __construct($HostCacheConfigurationInfo = null) {
		$this->HostCacheConfigurationInfo = $HostCacheConfigurationInfo;
	}
}

class HostCapability {
	public $recursiveResourcePoolsSupported; //boolean
	public $cpuMemoryResourceConfigurationSupported; //boolean
	public $rebootSupported; //boolean
	public $shutdownSupported; //boolean
	public $vmotionSupported; //boolean
	public $standbySupported; //boolean
	public $ipmiSupported; //boolean
	public $maxSupportedVMs; //int
	public $maxRunningVMs; //int
	public $maxSupportedVcpus; //int
	public $datastorePrincipalSupported; //boolean
	public $sanSupported; //boolean
	public $nfsSupported; //boolean
	public $iscsiSupported; //boolean
	public $vlanTaggingSupported; //boolean
	public $nicTeamingSupported; //boolean
	public $highGuestMemSupported; //boolean
	public $maintenanceModeSupported; //boolean
	public $suspendedRelocateSupported; //boolean
	public $restrictedSnapshotRelocateSupported; //boolean
	public $perVmSwapFiles; //boolean
	public $localSwapDatastoreSupported; //boolean
	public $unsharedSwapVMotionSupported; //boolean
	public $backgroundSnapshotsSupported; //boolean
	public $preAssignedPCIUnitNumbersSupported; //boolean
	public $screenshotSupported; //boolean
	public $scaledScreenshotSupported; //boolean
	public $storageVMotionSupported; //boolean
	public $vmotionWithStorageVMotionSupported; //boolean
	public $recordReplaySupported; //boolean
	public $ftSupported; //boolean
	public $replayUnsupportedReason; //string
	public $replayCompatibilityIssues; //string
	public $ftCompatibilityIssues; //string
	public $loginBySSLThumbprintSupported; //boolean
	public $cloneFromSnapshotSupported; //boolean
	public $deltaDiskBackingsSupported; //boolean
	public $perVMNetworkTrafficShapingSupported; //boolean
	public $tpmSupported; //boolean
	public $supportedCpuFeature; //HostCpuIdInfo
	public $virtualExecUsageSupported; //boolean
	public $storageIORMSupported; //boolean
	public $vmDirectPathGen2Supported; //boolean
	public $vmDirectPathGen2UnsupportedReason; //string
	public $vmDirectPathGen2UnsupportedReasonExtended; //string
	public $supportedVmfsMajorVersion; //int
	public $vStorageCapable; //boolean
	public $snapshotRelayoutSupported; //boolean
	public $firewallIpRulesSupported; //boolean
	public $servicePackageInfoSupported; //boolean
	public $maxHostRunningVms; //int
	public $maxHostSupportedVcpus; //int
	public $vmfsDatastoreMountCapable; //boolean

	function __construct($recursiveResourcePoolsSupported = null, $cpuMemoryResourceConfigurationSupported = null, $rebootSupported = null, $shutdownSupported = null, $vmotionSupported = null, $standbySupported = null, $ipmiSupported = null, $maxSupportedVMs = null, $maxRunningVMs = null, $maxSupportedVcpus = null, $datastorePrincipalSupported = null, $sanSupported = null, $nfsSupported = null, $iscsiSupported = null, $vlanTaggingSupported = null, $nicTeamingSupported = null, $highGuestMemSupported = null, $maintenanceModeSupported = null, $suspendedRelocateSupported = null, $restrictedSnapshotRelocateSupported = null, $perVmSwapFiles = null, $localSwapDatastoreSupported = null, $unsharedSwapVMotionSupported = null, $backgroundSnapshotsSupported = null, $preAssignedPCIUnitNumbersSupported = null, $screenshotSupported = null, $scaledScreenshotSupported = null, $storageVMotionSupported = null, $vmotionWithStorageVMotionSupported = null, $recordReplaySupported = null, $ftSupported = null, $replayUnsupportedReason = null, $replayCompatibilityIssues = null, $ftCompatibilityIssues = null, $loginBySSLThumbprintSupported = null, $cloneFromSnapshotSupported = null, $deltaDiskBackingsSupported = null, $perVMNetworkTrafficShapingSupported = null, $tpmSupported = null, $supportedCpuFeature = null, $virtualExecUsageSupported = null, $storageIORMSupported = null, $vmDirectPathGen2Supported = null, $vmDirectPathGen2UnsupportedReason = null, $vmDirectPathGen2UnsupportedReasonExtended = null, $supportedVmfsMajorVersion = null, $vStorageCapable = null, $snapshotRelayoutSupported = null, $firewallIpRulesSupported = null, $servicePackageInfoSupported = null, $maxHostRunningVms = null, $maxHostSupportedVcpus = null, $vmfsDatastoreMountCapable = null) {
		$this->recursiveResourcePoolsSupported = $recursiveResourcePoolsSupported;
		$this->cpuMemoryResourceConfigurationSupported = $cpuMemoryResourceConfigurationSupported;
		$this->rebootSupported = $rebootSupported;
		$this->shutdownSupported = $shutdownSupported;
		$this->vmotionSupported = $vmotionSupported;
		$this->standbySupported = $standbySupported;
		$this->ipmiSupported = $ipmiSupported;
		$this->maxSupportedVMs = $maxSupportedVMs;
		$this->maxRunningVMs = $maxRunningVMs;
		$this->maxSupportedVcpus = $maxSupportedVcpus;
		$this->datastorePrincipalSupported = $datastorePrincipalSupported;
		$this->sanSupported = $sanSupported;
		$this->nfsSupported = $nfsSupported;
		$this->iscsiSupported = $iscsiSupported;
		$this->vlanTaggingSupported = $vlanTaggingSupported;
		$this->nicTeamingSupported = $nicTeamingSupported;
		$this->highGuestMemSupported = $highGuestMemSupported;
		$this->maintenanceModeSupported = $maintenanceModeSupported;
		$this->suspendedRelocateSupported = $suspendedRelocateSupported;
		$this->restrictedSnapshotRelocateSupported = $restrictedSnapshotRelocateSupported;
		$this->perVmSwapFiles = $perVmSwapFiles;
		$this->localSwapDatastoreSupported = $localSwapDatastoreSupported;
		$this->unsharedSwapVMotionSupported = $unsharedSwapVMotionSupported;
		$this->backgroundSnapshotsSupported = $backgroundSnapshotsSupported;
		$this->preAssignedPCIUnitNumbersSupported = $preAssignedPCIUnitNumbersSupported;
		$this->screenshotSupported = $screenshotSupported;
		$this->scaledScreenshotSupported = $scaledScreenshotSupported;
		$this->storageVMotionSupported = $storageVMotionSupported;
		$this->vmotionWithStorageVMotionSupported = $vmotionWithStorageVMotionSupported;
		$this->recordReplaySupported = $recordReplaySupported;
		$this->ftSupported = $ftSupported;
		$this->replayUnsupportedReason = $replayUnsupportedReason;
		$this->replayCompatibilityIssues = $replayCompatibilityIssues;
		$this->ftCompatibilityIssues = $ftCompatibilityIssues;
		$this->loginBySSLThumbprintSupported = $loginBySSLThumbprintSupported;
		$this->cloneFromSnapshotSupported = $cloneFromSnapshotSupported;
		$this->deltaDiskBackingsSupported = $deltaDiskBackingsSupported;
		$this->perVMNetworkTrafficShapingSupported = $perVMNetworkTrafficShapingSupported;
		$this->tpmSupported = $tpmSupported;
		$this->supportedCpuFeature = $supportedCpuFeature;
		$this->virtualExecUsageSupported = $virtualExecUsageSupported;
		$this->storageIORMSupported = $storageIORMSupported;
		$this->vmDirectPathGen2Supported = $vmDirectPathGen2Supported;
		$this->vmDirectPathGen2UnsupportedReason = $vmDirectPathGen2UnsupportedReason;
		$this->vmDirectPathGen2UnsupportedReasonExtended = $vmDirectPathGen2UnsupportedReasonExtended;
		$this->supportedVmfsMajorVersion = $supportedVmfsMajorVersion;
		$this->vStorageCapable = $vStorageCapable;
		$this->snapshotRelayoutSupported = $snapshotRelayoutSupported;
		$this->firewallIpRulesSupported = $firewallIpRulesSupported;
		$this->servicePackageInfoSupported = $servicePackageInfoSupported;
		$this->maxHostRunningVms = $maxHostRunningVms;
		$this->maxHostSupportedVcpus = $maxHostSupportedVcpus;
		$this->vmfsDatastoreMountCapable = $vmfsDatastoreMountCapable;
	}
}

class HostConfigChange {
}

class HostConfigInfo {
	public $host; //ManagedObjectReference
	public $product; //AboutInfo
	public $hyperThread; //HostHyperThreadScheduleInfo
	public $consoleReservation; //ServiceConsoleReservationInfo
	public $virtualMachineReservation; //VirtualMachineMemoryReservationInfo
	public $storageDevice; //HostStorageDeviceInfo
	public $multipathState; //HostMultipathStateInfo
	public $fileSystemVolume; //HostFileSystemVolumeInfo
	public $systemFile; //string
	public $network; //HostNetworkInfo
	public $vmotion; //HostVMotionInfo
	public $virtualNicManagerInfo; //HostVirtualNicManagerInfo
	public $capabilities; //HostNetCapabilities
	public $datastoreCapabilities; //HostDatastoreSystemCapabilities
	public $offloadCapabilities; //HostNetOffloadCapabilities
	public $service; //HostServiceInfo
	public $firewall; //HostFirewallInfo
	public $autoStart; //HostAutoStartManagerConfig
	public $activeDiagnosticPartition; //HostDiagnosticPartition
	public $option; //OptionValue
	public $optionDef; //OptionDef
	public $datastorePrincipal; //string
	public $localSwapDatastore; //ManagedObjectReference
	public $systemResources; //HostSystemResourceInfo
	public $dateTimeInfo; //HostDateTimeInfo
	public $flags; //HostFlagInfo
	public $adminDisabled; //boolean
	public $ipmi; //HostIpmiInfo
	public $sslThumbprintInfo; //HostSslThumbprintInfo
	public $sslThumbprintData; //HostSslThumbprintInfo
	public $certificate; //byte
	public $pciPassthruInfo; //HostPciPassthruInfo
	public $authenticationManagerInfo; //HostAuthenticationManagerInfo
	public $featureVersion; //HostFeatureVersionInfo
	public $powerSystemCapability; //PowerSystemCapability
	public $powerSystemInfo; //PowerSystemInfo
	public $cacheConfigurationInfo; //HostCacheConfigurationInfo
	public $wakeOnLanCapable; //boolean

	function __construct($host = null, $product = null, $hyperThread = null, $consoleReservation = null, $virtualMachineReservation = null, $storageDevice = null, $multipathState = null, $fileSystemVolume = null, $systemFile = null, $network = null, $vmotion = null, $virtualNicManagerInfo = null, $capabilities = null, $datastoreCapabilities = null, $offloadCapabilities = null, $service = null, $firewall = null, $autoStart = null, $activeDiagnosticPartition = null, $option = null, $optionDef = null, $datastorePrincipal = null, $localSwapDatastore = null, $systemResources = null, $dateTimeInfo = null, $flags = null, $adminDisabled = null, $ipmi = null, $sslThumbprintInfo = null, $sslThumbprintData = null, $certificate = null, $pciPassthruInfo = null, $authenticationManagerInfo = null, $featureVersion = null, $powerSystemCapability = null, $powerSystemInfo = null, $cacheConfigurationInfo = null, $wakeOnLanCapable = null) {
		$this->host = $host;
		$this->product = $product;
		$this->hyperThread = $hyperThread;
		$this->consoleReservation = $consoleReservation;
		$this->virtualMachineReservation = $virtualMachineReservation;
		$this->storageDevice = $storageDevice;
		$this->multipathState = $multipathState;
		$this->fileSystemVolume = $fileSystemVolume;
		$this->systemFile = $systemFile;
		$this->network = $network;
		$this->vmotion = $vmotion;
		$this->virtualNicManagerInfo = $virtualNicManagerInfo;
		$this->capabilities = $capabilities;
		$this->datastoreCapabilities = $datastoreCapabilities;
		$this->offloadCapabilities = $offloadCapabilities;
		$this->service = $service;
		$this->firewall = $firewall;
		$this->autoStart = $autoStart;
		$this->activeDiagnosticPartition = $activeDiagnosticPartition;
		$this->option = $option;
		$this->optionDef = $optionDef;
		$this->datastorePrincipal = $datastorePrincipal;
		$this->localSwapDatastore = $localSwapDatastore;
		$this->systemResources = $systemResources;
		$this->dateTimeInfo = $dateTimeInfo;
		$this->flags = $flags;
		$this->adminDisabled = $adminDisabled;
		$this->ipmi = $ipmi;
		$this->sslThumbprintInfo = $sslThumbprintInfo;
		$this->sslThumbprintData = $sslThumbprintData;
		$this->certificate = $certificate;
		$this->pciPassthruInfo = $pciPassthruInfo;
		$this->authenticationManagerInfo = $authenticationManagerInfo;
		$this->featureVersion = $featureVersion;
		$this->powerSystemCapability = $powerSystemCapability;
		$this->powerSystemInfo = $powerSystemInfo;
		$this->cacheConfigurationInfo = $cacheConfigurationInfo;
		$this->wakeOnLanCapable = $wakeOnLanCapable;
	}
}

class HostConfigManager {
	public $cpuScheduler; //ManagedObjectReference
	public $datastoreSystem; //ManagedObjectReference
	public $memoryManager; //ManagedObjectReference
	public $storageSystem; //ManagedObjectReference
	public $networkSystem; //ManagedObjectReference
	public $vmotionSystem; //ManagedObjectReference
	public $virtualNicManager; //ManagedObjectReference
	public $serviceSystem; //ManagedObjectReference
	public $firewallSystem; //ManagedObjectReference
	public $advancedOption; //ManagedObjectReference
	public $diagnosticSystem; //ManagedObjectReference
	public $autoStartManager; //ManagedObjectReference
	public $snmpSystem; //ManagedObjectReference
	public $dateTimeSystem; //ManagedObjectReference
	public $patchManager; //ManagedObjectReference
	public $imageConfigManager; //ManagedObjectReference
	public $bootDeviceSystem; //ManagedObjectReference
	public $firmwareSystem; //ManagedObjectReference
	public $healthStatusSystem; //ManagedObjectReference
	public $pciPassthruSystem; //ManagedObjectReference
	public $licenseManager; //ManagedObjectReference
	public $kernelModuleSystem; //ManagedObjectReference
	public $authenticationManager; //ManagedObjectReference
	public $powerSystem; //ManagedObjectReference
	public $cacheConfigurationManager; //ManagedObjectReference
	public $esxAgentHostManager; //ManagedObjectReference
	public $iscsiManager; //ManagedObjectReference

	function __construct($cpuScheduler = null, $datastoreSystem = null, $memoryManager = null, $storageSystem = null, $networkSystem = null, $vmotionSystem = null, $virtualNicManager = null, $serviceSystem = null, $firewallSystem = null, $advancedOption = null, $diagnosticSystem = null, $autoStartManager = null, $snmpSystem = null, $dateTimeSystem = null, $patchManager = null, $imageConfigManager = null, $bootDeviceSystem = null, $firmwareSystem = null, $healthStatusSystem = null, $pciPassthruSystem = null, $licenseManager = null, $kernelModuleSystem = null, $authenticationManager = null, $powerSystem = null, $cacheConfigurationManager = null, $esxAgentHostManager = null, $iscsiManager = null) {
		$this->cpuScheduler = $cpuScheduler;
		$this->datastoreSystem = $datastoreSystem;
		$this->memoryManager = $memoryManager;
		$this->storageSystem = $storageSystem;
		$this->networkSystem = $networkSystem;
		$this->vmotionSystem = $vmotionSystem;
		$this->virtualNicManager = $virtualNicManager;
		$this->serviceSystem = $serviceSystem;
		$this->firewallSystem = $firewallSystem;
		$this->advancedOption = $advancedOption;
		$this->diagnosticSystem = $diagnosticSystem;
		$this->autoStartManager = $autoStartManager;
		$this->snmpSystem = $snmpSystem;
		$this->dateTimeSystem = $dateTimeSystem;
		$this->patchManager = $patchManager;
		$this->imageConfigManager = $imageConfigManager;
		$this->bootDeviceSystem = $bootDeviceSystem;
		$this->firmwareSystem = $firmwareSystem;
		$this->healthStatusSystem = $healthStatusSystem;
		$this->pciPassthruSystem = $pciPassthruSystem;
		$this->licenseManager = $licenseManager;
		$this->kernelModuleSystem = $kernelModuleSystem;
		$this->authenticationManager = $authenticationManager;
		$this->powerSystem = $powerSystem;
		$this->cacheConfigurationManager = $cacheConfigurationManager;
		$this->esxAgentHostManager = $esxAgentHostManager;
		$this->iscsiManager = $iscsiManager;
	}
}

class HostConfigSpec {
	public $nasDatastore; //HostNasVolumeConfig
	public $network; //HostNetworkConfig
	public $nicTypeSelection; //HostVirtualNicManagerNicTypeSelection
	public $service; //HostServiceConfig
	public $firewall; //HostFirewallConfig
	public $option; //OptionValue
	public $datastorePrincipal; //string
	public $datastorePrincipalPasswd; //string
	public $datetime; //HostDateTimeConfig
	public $storageDevice; //HostStorageDeviceInfo
	public $license; //HostLicenseSpec
	public $security; //HostSecuritySpec
	public $userAccount; //HostAccountSpec
	public $usergroupAccount; //HostAccountSpec
	public $memory; //HostMemorySpec
	public $activeDirectory; //HostActiveDirectory
	public $genericConfig; //KeyAnyValue

	function __construct($nasDatastore = null, $network = null, $nicTypeSelection = null, $service = null, $firewall = null, $option = null, $datastorePrincipal = null, $datastorePrincipalPasswd = null, $datetime = null, $storageDevice = null, $license = null, $security = null, $userAccount = null, $usergroupAccount = null, $memory = null, $activeDirectory = null, $genericConfig = null) {
		$this->nasDatastore = $nasDatastore;
		$this->network = $network;
		$this->nicTypeSelection = $nicTypeSelection;
		$this->service = $service;
		$this->firewall = $firewall;
		$this->option = $option;
		$this->datastorePrincipal = $datastorePrincipal;
		$this->datastorePrincipalPasswd = $datastorePrincipalPasswd;
		$this->datetime = $datetime;
		$this->storageDevice = $storageDevice;
		$this->license = $license;
		$this->security = $security;
		$this->userAccount = $userAccount;
		$this->usergroupAccount = $usergroupAccount;
		$this->memory = $memory;
		$this->activeDirectory = $activeDirectory;
		$this->genericConfig = $genericConfig;
	}
}

class HostConnectInfoNetworkInfo {
	public $summary; //NetworkSummary

	function __construct($summary = null) {
		$this->summary = $summary;
	}
}

class ArrayOfHostConnectInfoNetworkInfo {
	public $HostConnectInfoNetworkInfo; //HostConnectInfoNetworkInfo

	function __construct($HostConnectInfoNetworkInfo = null) {
		$this->HostConnectInfoNetworkInfo = $HostConnectInfoNetworkInfo;
	}
}

class HostNewNetworkConnectInfo {
}

class HostDatastoreConnectInfo {
	public $summary; //DatastoreSummary

	function __construct($summary = null) {
		$this->summary = $summary;
	}
}

class ArrayOfHostDatastoreConnectInfo {
	public $HostDatastoreConnectInfo; //HostDatastoreConnectInfo

	function __construct($HostDatastoreConnectInfo = null) {
		$this->HostDatastoreConnectInfo = $HostDatastoreConnectInfo;
	}
}

class HostDatastoreExistsConnectInfo {
	public $newDatastoreName; //string

	function __construct($newDatastoreName = null) {
		$this->newDatastoreName = $newDatastoreName;
	}
}

class HostDatastoreNameConflictConnectInfo {
	public $newDatastoreName; //string

	function __construct($newDatastoreName = null) {
		$this->newDatastoreName = $newDatastoreName;
	}
}

class HostLicenseConnectInfo {
	public $license; //LicenseManagerLicenseInfo
	public $evaluation; //LicenseManagerEvaluationInfo
	public $resource; //HostLicensableResourceInfo

	function __construct($license = null, $evaluation = null, $resource = null) {
		$this->license = $license;
		$this->evaluation = $evaluation;
		$this->resource = $resource;
	}
}

class HostConnectInfo {
	public $serverIp; //string
	public $inDasCluster; //boolean
	public $host; //HostListSummary
	public $vm; //VirtualMachineSummary
	public $vimAccountNameRequired; //boolean
	public $clusterSupported; //boolean
	public $network; //HostConnectInfoNetworkInfo
	public $datastore; //HostDatastoreConnectInfo
	public $license; //HostLicenseConnectInfo

	function __construct($serverIp = null, $inDasCluster = null, $host = null, $vm = null, $vimAccountNameRequired = null, $clusterSupported = null, $network = null, $datastore = null, $license = null) {
		$this->serverIp = $serverIp;
		$this->inDasCluster = $inDasCluster;
		$this->host = $host;
		$this->vm = $vm;
		$this->vimAccountNameRequired = $vimAccountNameRequired;
		$this->clusterSupported = $clusterSupported;
		$this->network = $network;
		$this->datastore = $datastore;
		$this->license = $license;
	}
}

class HostConnectSpec {
	public $hostName; //string
	public $port; //int
	public $sslThumbprint; //string
	public $userName; //string
	public $password; //string
	public $vmFolder; //ManagedObjectReference
	public $force; //boolean
	public $vimAccountName; //string
	public $vimAccountPassword; //string
	public $managementIp; //string

	function __construct($hostName = null, $port = null, $sslThumbprint = null, $userName = null, $password = null, $vmFolder = null, $force = null, $vimAccountName = null, $vimAccountPassword = null, $managementIp = null) {
		$this->hostName = $hostName;
		$this->port = $port;
		$this->sslThumbprint = $sslThumbprint;
		$this->userName = $userName;
		$this->password = $password;
		$this->vmFolder = $vmFolder;
		$this->force = $force;
		$this->vimAccountName = $vimAccountName;
		$this->vimAccountPassword = $vimAccountPassword;
		$this->managementIp = $managementIp;
	}
}

class HostCpuIdInfo {
	public $level; //int
	public $vendor; //string
	public $eax; //string
	public $ebx; //string
	public $ecx; //string
	public $edx; //string

	function __construct($level = null, $vendor = null, $eax = null, $ebx = null, $ecx = null, $edx = null) {
		$this->level = $level;
		$this->vendor = $vendor;
		$this->eax = $eax;
		$this->ebx = $ebx;
		$this->ecx = $ecx;
		$this->edx = $edx;
	}
}

class ArrayOfHostCpuIdInfo {
	public $HostCpuIdInfo; //HostCpuIdInfo

	function __construct($HostCpuIdInfo = null) {
		$this->HostCpuIdInfo = $HostCpuIdInfo;
	}
}

class HostHyperThreadScheduleInfo {
	public $available; //boolean
	public $active; //boolean
	public $config; //boolean

	function __construct($available = null, $active = null, $config = null) {
		$this->available = $available;
		$this->active = $active;
		$this->config = $config;
	}
}

class FileQueryFlags {
	public $fileType; //boolean
	public $fileSize; //boolean
	public $modification; //boolean
	public $fileOwner; //boolean

	function __construct($fileType = null, $fileSize = null, $modification = null, $fileOwner = null) {
		$this->fileType = $fileType;
		$this->fileSize = $fileSize;
		$this->modification = $modification;
		$this->fileOwner = $fileOwner;
	}
}

class FileInfo {
	public $path; //string
	public $fileSize; //long
	public $modification; //dateTime
	public $owner; //string

	function __construct($path = null, $fileSize = null, $modification = null, $owner = null) {
		$this->path = $path;
		$this->fileSize = $fileSize;
		$this->modification = $modification;
		$this->owner = $owner;
	}
}

class ArrayOfFileInfo {
	public $FileInfo; //FileInfo

	function __construct($FileInfo = null) {
		$this->FileInfo = $FileInfo;
	}
}

class FileQuery {
}

class ArrayOfFileQuery {
	public $FileQuery; //FileQuery

	function __construct($FileQuery = null) {
		$this->FileQuery = $FileQuery;
	}
}

class VmConfigFileQueryFilter {
	public $matchConfigVersion; //int

	function __construct($matchConfigVersion = null) {
		$this->matchConfigVersion = $matchConfigVersion;
	}
}

class VmConfigFileQueryFlags {
	public $configVersion; //boolean

	function __construct($configVersion = null) {
		$this->configVersion = $configVersion;
	}
}

class VmConfigFileQuery {
	public $filter; //VmConfigFileQueryFilter
	public $details; //VmConfigFileQueryFlags

	function __construct($filter = null, $details = null) {
		$this->filter = $filter;
		$this->details = $details;
	}
}

class TemplateConfigFileQuery {
}

class VmDiskFileQueryFilter {
	public $diskType; //string
	public $matchHardwareVersion; //int
	public $controllerType; //string
	public $thin; //boolean

	function __construct($diskType = null, $matchHardwareVersion = null, $controllerType = null, $thin = null) {
		$this->diskType = $diskType;
		$this->matchHardwareVersion = $matchHardwareVersion;
		$this->controllerType = $controllerType;
		$this->thin = $thin;
	}
}

class VmDiskFileQueryFlags {
	public $diskType; //boolean
	public $capacityKb; //boolean
	public $hardwareVersion; //boolean
	public $controllerType; //boolean
	public $diskExtents; //boolean
	public $thin; //boolean

	function __construct($diskType = null, $capacityKb = null, $hardwareVersion = null, $controllerType = null, $diskExtents = null, $thin = null) {
		$this->diskType = $diskType;
		$this->capacityKb = $capacityKb;
		$this->hardwareVersion = $hardwareVersion;
		$this->controllerType = $controllerType;
		$this->diskExtents = $diskExtents;
		$this->thin = $thin;
	}
}

class VmDiskFileQuery {
	public $filter; //VmDiskFileQueryFilter
	public $details; //VmDiskFileQueryFlags

	function __construct($filter = null, $details = null) {
		$this->filter = $filter;
		$this->details = $details;
	}
}

class FolderFileQuery {
}

class VmSnapshotFileQuery {
}

class IsoImageFileQuery {
}

class FloppyImageFileQuery {
}

class VmNvramFileQuery {
}

class VmLogFileQuery {
}

class VmConfigFileInfo {
	public $configVersion; //int

	function __construct($configVersion = null) {
		$this->configVersion = $configVersion;
	}
}

class TemplateConfigFileInfo {
}

class VmDiskFileInfo {
	public $diskType; //string
	public $capacityKb; //long
	public $hardwareVersion; //int
	public $controllerType; //string
	public $diskExtents; //string
	public $thin; //boolean

	function __construct($diskType = null, $capacityKb = null, $hardwareVersion = null, $controllerType = null, $diskExtents = null, $thin = null) {
		$this->diskType = $diskType;
		$this->capacityKb = $capacityKb;
		$this->hardwareVersion = $hardwareVersion;
		$this->controllerType = $controllerType;
		$this->diskExtents = $diskExtents;
		$this->thin = $thin;
	}
}

class FolderFileInfo {
}

class VmSnapshotFileInfo {
}

class IsoImageFileInfo {
}

class FloppyImageFileInfo {
}

class VmNvramFileInfo {
}

class VmLogFileInfo {
}

class HostDatastoreBrowserSearchSpec {
	public $query; //FileQuery
	public $details; //FileQueryFlags
	public $searchCaseInsensitive; //boolean
	public $matchPattern; //string
	public $sortFoldersFirst; //boolean

	function __construct($query = null, $details = null, $searchCaseInsensitive = null, $matchPattern = null, $sortFoldersFirst = null) {
		$this->query = $query;
		$this->details = $details;
		$this->searchCaseInsensitive = $searchCaseInsensitive;
		$this->matchPattern = $matchPattern;
		$this->sortFoldersFirst = $sortFoldersFirst;
	}
}

class HostDatastoreBrowserSearchResults {
	public $datastore; //ManagedObjectReference
	public $folderPath; //string
	public $file; //FileInfo

	function __construct($datastore = null, $folderPath = null, $file = null) {
		$this->datastore = $datastore;
		$this->folderPath = $folderPath;
		$this->file = $file;
	}
}

class ArrayOfHostDatastoreBrowserSearchResults {
	public $HostDatastoreBrowserSearchResults; //HostDatastoreBrowserSearchResults

	function __construct($HostDatastoreBrowserSearchResults = null) {
		$this->HostDatastoreBrowserSearchResults = $HostDatastoreBrowserSearchResults;
	}
}

class HostDatastoreSystemCapabilities {
	public $nfsMountCreationRequired; //boolean
	public $nfsMountCreationSupported; //boolean
	public $localDatastoreSupported; //boolean
	public $vmfsExtentExpansionSupported; //boolean

	function __construct($nfsMountCreationRequired = null, $nfsMountCreationSupported = null, $localDatastoreSupported = null, $vmfsExtentExpansionSupported = null) {
		$this->nfsMountCreationRequired = $nfsMountCreationRequired;
		$this->nfsMountCreationSupported = $nfsMountCreationSupported;
		$this->localDatastoreSupported = $localDatastoreSupported;
		$this->vmfsExtentExpansionSupported = $vmfsExtentExpansionSupported;
	}
}

class VmfsDatastoreInfo {
	public $vmfs; //HostVmfsVolume

	function __construct($vmfs = null) {
		$this->vmfs = $vmfs;
	}
}

class NasDatastoreInfo {
	public $nas; //HostNasVolume

	function __construct($nas = null) {
		$this->nas = $nas;
	}
}

class LocalDatastoreInfo {
	public $path; //string

	function __construct($path = null) {
		$this->path = $path;
	}
}

class VmfsDatastoreSpec {
	public $diskUuid; //string

	function __construct($diskUuid = null) {
		$this->diskUuid = $diskUuid;
	}
}

class VmfsDatastoreCreateSpec {
	public $partition; //HostDiskPartitionSpec
	public $vmfs; //HostVmfsSpec
	public $extent; //HostScsiDiskPartition

	function __construct($partition = null, $vmfs = null, $extent = null) {
		$this->partition = $partition;
		$this->vmfs = $vmfs;
		$this->extent = $extent;
	}
}

class VmfsDatastoreExtendSpec {
	public $partition; //HostDiskPartitionSpec
	public $extent; //HostScsiDiskPartition

	function __construct($partition = null, $extent = null) {
		$this->partition = $partition;
		$this->extent = $extent;
	}
}

class VmfsDatastoreExpandSpec {
	public $partition; //HostDiskPartitionSpec
	public $extent; //HostScsiDiskPartition

	function __construct($partition = null, $extent = null) {
		$this->partition = $partition;
		$this->extent = $extent;
	}
}

class VmfsDatastoreBaseOption {
	public $layout; //HostDiskPartitionLayout
	public $partitionFormatChange; //boolean

	function __construct($layout = null, $partitionFormatChange = null) {
		$this->layout = $layout;
		$this->partitionFormatChange = $partitionFormatChange;
	}
}

class VmfsDatastoreSingleExtentOption {
	public $vmfsExtent; //HostDiskPartitionBlockRange

	function __construct($vmfsExtent = null) {
		$this->vmfsExtent = $vmfsExtent;
	}
}

class VmfsDatastoreAllExtentOption {
}

class VmfsDatastoreMultipleExtentOption {
	public $vmfsExtent; //HostDiskPartitionBlockRange

	function __construct($vmfsExtent = null) {
		$this->vmfsExtent = $vmfsExtent;
	}
}

class VmfsDatastoreOption {
	public $info; //VmfsDatastoreBaseOption
	public $spec; //VmfsDatastoreSpec

	function __construct($info = null, $spec = null) {
		$this->info = $info;
		$this->spec = $spec;
	}
}

class ArrayOfVmfsDatastoreOption {
	public $VmfsDatastoreOption; //VmfsDatastoreOption

	function __construct($VmfsDatastoreOption = null) {
		$this->VmfsDatastoreOption = $VmfsDatastoreOption;
	}
}

class HostDateTimeConfig {
	public $timeZone; //string
	public $ntpConfig; //HostNtpConfig

	function __construct($timeZone = null, $ntpConfig = null) {
		$this->timeZone = $timeZone;
		$this->ntpConfig = $ntpConfig;
	}
}

class HostDateTimeInfo {
	public $timeZone; //HostDateTimeSystemTimeZone
	public $ntpConfig; //HostNtpConfig

	function __construct($timeZone = null, $ntpConfig = null) {
		$this->timeZone = $timeZone;
		$this->ntpConfig = $ntpConfig;
	}
}

class HostDateTimeSystemTimeZone {
	public $key; //string
	public $name; //string
	public $description; //string
	public $gmtOffset; //int

	function __construct($key = null, $name = null, $description = null, $gmtOffset = null) {
		$this->key = $key;
		$this->name = $name;
		$this->description = $description;
		$this->gmtOffset = $gmtOffset;
	}
}

class ArrayOfHostDateTimeSystemTimeZone {
	public $HostDateTimeSystemTimeZone; //HostDateTimeSystemTimeZone

	function __construct($HostDateTimeSystemTimeZone = null) {
		$this->HostDateTimeSystemTimeZone = $HostDateTimeSystemTimeZone;
	}
}

class HostDevice {
	public $deviceName; //string
	public $deviceType; //string

	function __construct($deviceName = null, $deviceType = null) {
		$this->deviceName = $deviceName;
		$this->deviceType = $deviceType;
	}
}

class HostDhcpServiceSpec {
	public $virtualSwitch; //string
	public $defaultLeaseDuration; //int
	public $leaseBeginIp; //string
	public $leaseEndIp; //string
	public $maxLeaseDuration; //int
	public $unlimitedLease; //boolean
	public $ipSubnetAddr; //string
	public $ipSubnetMask; //string

	function __construct($virtualSwitch = null, $defaultLeaseDuration = null, $leaseBeginIp = null, $leaseEndIp = null, $maxLeaseDuration = null, $unlimitedLease = null, $ipSubnetAddr = null, $ipSubnetMask = null) {
		$this->virtualSwitch = $virtualSwitch;
		$this->defaultLeaseDuration = $defaultLeaseDuration;
		$this->leaseBeginIp = $leaseBeginIp;
		$this->leaseEndIp = $leaseEndIp;
		$this->maxLeaseDuration = $maxLeaseDuration;
		$this->unlimitedLease = $unlimitedLease;
		$this->ipSubnetAddr = $ipSubnetAddr;
		$this->ipSubnetMask = $ipSubnetMask;
	}
}

class HostDhcpServiceConfig {
	public $changeOperation; //string
	public $key; //string
	public $spec; //HostDhcpServiceSpec

	function __construct($changeOperation = null, $key = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->key = $key;
		$this->spec = $spec;
	}
}

class ArrayOfHostDhcpServiceConfig {
	public $HostDhcpServiceConfig; //HostDhcpServiceConfig

	function __construct($HostDhcpServiceConfig = null) {
		$this->HostDhcpServiceConfig = $HostDhcpServiceConfig;
	}
}

class HostDhcpService {
	public $key; //string
	public $spec; //HostDhcpServiceSpec

	function __construct($key = null, $spec = null) {
		$this->key = $key;
		$this->spec = $spec;
	}
}

class ArrayOfHostDhcpService {
	public $HostDhcpService; //HostDhcpService

	function __construct($HostDhcpService = null) {
		$this->HostDhcpService = $HostDhcpService;
	}
}

class HostDiagnosticPartitionCreateOption {
	public $storageType; //string
	public $diagnosticType; //string
	public $disk; //HostScsiDisk

	function __construct($storageType = null, $diagnosticType = null, $disk = null) {
		$this->storageType = $storageType;
		$this->diagnosticType = $diagnosticType;
		$this->disk = $disk;
	}
}

class ArrayOfHostDiagnosticPartitionCreateOption {
	public $HostDiagnosticPartitionCreateOption; //HostDiagnosticPartitionCreateOption

	function __construct($HostDiagnosticPartitionCreateOption = null) {
		$this->HostDiagnosticPartitionCreateOption = $HostDiagnosticPartitionCreateOption;
	}
}

class HostDiagnosticPartitionCreateSpec {
	public $storageType; //string
	public $diagnosticType; //string
	public $id; //HostScsiDiskPartition
	public $partition; //HostDiskPartitionSpec
	public $active; //boolean

	function __construct($storageType = null, $diagnosticType = null, $id = null, $partition = null, $active = null) {
		$this->storageType = $storageType;
		$this->diagnosticType = $diagnosticType;
		$this->id = $id;
		$this->partition = $partition;
		$this->active = $active;
	}
}

class HostDiagnosticPartitionCreateDescription {
	public $layout; //HostDiskPartitionLayout
	public $diskUuid; //string
	public $spec; //HostDiagnosticPartitionCreateSpec

	function __construct($layout = null, $diskUuid = null, $spec = null) {
		$this->layout = $layout;
		$this->diskUuid = $diskUuid;
		$this->spec = $spec;
	}
}

class HostDiagnosticPartition {
	public $storageType; //string
	public $diagnosticType; //string
	public $slots; //int
	public $id; //HostScsiDiskPartition

	function __construct($storageType = null, $diagnosticType = null, $slots = null, $id = null) {
		$this->storageType = $storageType;
		$this->diagnosticType = $diagnosticType;
		$this->slots = $slots;
		$this->id = $id;
	}
}

class ArrayOfHostDiagnosticPartition {
	public $HostDiagnosticPartition; //HostDiagnosticPartition

	function __construct($HostDiagnosticPartition = null) {
		$this->HostDiagnosticPartition = $HostDiagnosticPartition;
	}
}

class HostDirectoryStoreInfo {
}

class HostDiskDimensionsChs {
	public $cylinder; //long
	public $head; //int
	public $sector; //int

	function __construct($cylinder = null, $head = null, $sector = null) {
		$this->cylinder = $cylinder;
		$this->head = $head;
		$this->sector = $sector;
	}
}

class HostDiskDimensionsLba {
	public $blockSize; //int
	public $block; //long

	function __construct($blockSize = null, $block = null) {
		$this->blockSize = $blockSize;
		$this->block = $block;
	}
}

class HostDiskDimensions {
}

class HostDiskPartitionAttributes {
	public $partition; //int
	public $startSector; //long
	public $endSector; //long
	public $type; //string
	public $guid; //string
	public $logical; //boolean
	public $attributes; //byte
	public $partitionAlignment; //long

	function __construct($partition = null, $startSector = null, $endSector = null, $type = null, $guid = null, $logical = null, $attributes = null, $partitionAlignment = null) {
		$this->partition = $partition;
		$this->startSector = $startSector;
		$this->endSector = $endSector;
		$this->type = $type;
		$this->guid = $guid;
		$this->logical = $logical;
		$this->attributes = $attributes;
		$this->partitionAlignment = $partitionAlignment;
	}
}

class ArrayOfHostDiskPartitionAttributes {
	public $HostDiskPartitionAttributes; //HostDiskPartitionAttributes

	function __construct($HostDiskPartitionAttributes = null) {
		$this->HostDiskPartitionAttributes = $HostDiskPartitionAttributes;
	}
}

class HostDiskPartitionBlockRange {
	public $partition; //int
	public $type; //string
	public $start; //HostDiskDimensionsLba
	public $end; //HostDiskDimensionsLba

	function __construct($partition = null, $type = null, $start = null, $end = null) {
		$this->partition = $partition;
		$this->type = $type;
		$this->start = $start;
		$this->end = $end;
	}
}

class ArrayOfHostDiskPartitionBlockRange {
	public $HostDiskPartitionBlockRange; //HostDiskPartitionBlockRange

	function __construct($HostDiskPartitionBlockRange = null) {
		$this->HostDiskPartitionBlockRange = $HostDiskPartitionBlockRange;
	}
}

class HostDiskPartitionSpec {
	public $partitionFormat; //string
	public $chs; //HostDiskDimensionsChs
	public $totalSectors; //long
	public $partition; //HostDiskPartitionAttributes

	function __construct($partitionFormat = null, $chs = null, $totalSectors = null, $partition = null) {
		$this->partitionFormat = $partitionFormat;
		$this->chs = $chs;
		$this->totalSectors = $totalSectors;
		$this->partition = $partition;
	}
}

class HostDiskPartitionLayout {
	public $total; //HostDiskDimensionsLba
	public $partition; //HostDiskPartitionBlockRange

	function __construct($total = null, $partition = null) {
		$this->total = $total;
		$this->partition = $partition;
	}
}

class HostDiskPartitionInfo {
	public $deviceName; //string
	public $spec; //HostDiskPartitionSpec
	public $layout; //HostDiskPartitionLayout

	function __construct($deviceName = null, $spec = null, $layout = null) {
		$this->deviceName = $deviceName;
		$this->spec = $spec;
		$this->layout = $layout;
	}
}

class ArrayOfHostDiskPartitionInfo {
	public $HostDiskPartitionInfo; //HostDiskPartitionInfo

	function __construct($HostDiskPartitionInfo = null) {
		$this->HostDiskPartitionInfo = $HostDiskPartitionInfo;
	}
}

class HostDnsConfig {
	public $dhcp; //boolean
	public $virtualNicDevice; //string
	public $hostName; //string
	public $domainName; //string
	public $address; //string
	public $searchDomain; //string

	function __construct($dhcp = null, $virtualNicDevice = null, $hostName = null, $domainName = null, $address = null, $searchDomain = null) {
		$this->dhcp = $dhcp;
		$this->virtualNicDevice = $virtualNicDevice;
		$this->hostName = $hostName;
		$this->domainName = $domainName;
		$this->address = $address;
		$this->searchDomain = $searchDomain;
	}
}

class HostDnsConfigSpec {
	public $virtualNicConnection; //HostVirtualNicConnection

	function __construct($virtualNicConnection = null) {
		$this->virtualNicConnection = $virtualNicConnection;
	}
}

class HostEsxAgentHostManagerConfigInfo {
	public $agentVmDatastore; //ManagedObjectReference
	public $agentVmNetwork; //ManagedObjectReference

	function __construct($agentVmDatastore = null, $agentVmNetwork = null) {
		$this->agentVmDatastore = $agentVmDatastore;
		$this->agentVmNetwork = $agentVmNetwork;
	}
}

class FcoeConfigVlanRange {
	public $vlanLow; //int
	public $vlanHigh; //int

	function __construct($vlanLow = null, $vlanHigh = null) {
		$this->vlanLow = $vlanLow;
		$this->vlanHigh = $vlanHigh;
	}
}

class ArrayOfFcoeConfigVlanRange {
	public $FcoeConfigVlanRange; //FcoeConfigVlanRange

	function __construct($FcoeConfigVlanRange = null) {
		$this->FcoeConfigVlanRange = $FcoeConfigVlanRange;
	}
}

class FcoeConfigFcoeCapabilities {
	public $priorityClass; //boolean
	public $sourceMacAddress; //boolean
	public $vlanRange; //boolean

	function __construct($priorityClass = null, $sourceMacAddress = null, $vlanRange = null) {
		$this->priorityClass = $priorityClass;
		$this->sourceMacAddress = $sourceMacAddress;
		$this->vlanRange = $vlanRange;
	}
}

class FcoeConfigFcoeSpecification {
	public $underlyingPnic; //string
	public $priorityClass; //int
	public $sourceMac; //string
	public $vlanRange; //FcoeConfigVlanRange

	function __construct($underlyingPnic = null, $priorityClass = null, $sourceMac = null, $vlanRange = null) {
		$this->underlyingPnic = $underlyingPnic;
		$this->priorityClass = $priorityClass;
		$this->sourceMac = $sourceMac;
		$this->vlanRange = $vlanRange;
	}
}

class FcoeConfig {
	public $priorityClass; //int
	public $sourceMac; //string
	public $vlanRange; //FcoeConfigVlanRange
	public $capabilities; //FcoeConfigFcoeCapabilities
	public $fcoeActive; //boolean

	function __construct($priorityClass = null, $sourceMac = null, $vlanRange = null, $capabilities = null, $fcoeActive = null) {
		$this->priorityClass = $priorityClass;
		$this->sourceMac = $sourceMac;
		$this->vlanRange = $vlanRange;
		$this->capabilities = $capabilities;
		$this->fcoeActive = $fcoeActive;
	}
}

class HostFeatureVersionInfo {
	public $key; //string
	public $value; //string

	function __construct($key = null, $value = null) {
		$this->key = $key;
		$this->value = $value;
	}
}

class ArrayOfHostFeatureVersionInfo {
	public $HostFeatureVersionInfo; //HostFeatureVersionInfo

	function __construct($HostFeatureVersionInfo = null) {
		$this->HostFeatureVersionInfo = $HostFeatureVersionInfo;
	}
}

class ModeInfo {
	public $browse; //string
	public $read; //string
	public $modify; //string
	public $use; //string
	public $admin; //string
	public $full; //string

	function __construct($browse = null, $read = null, $modify = null, $use = null, $admin = null, $full = null) {
		$this->browse = $browse;
		$this->read = $read;
		$this->modify = $modify;
		$this->use = $use;
		$this->admin = $admin;
		$this->full = $full;
	}
}

class HostFileAccess {
	public $who; //string
	public $what; //string

	function __construct($who = null, $what = null) {
		$this->who = $who;
		$this->what = $what;
	}
}

class HostFileSystemVolumeInfo {
	public $volumeTypeList; //string
	public $mountInfo; //HostFileSystemMountInfo

	function __construct($volumeTypeList = null, $mountInfo = null) {
		$this->volumeTypeList = $volumeTypeList;
		$this->mountInfo = $mountInfo;
	}
}

class HostFileSystemMountInfo {
	public $mountInfo; //HostMountInfo
	public $volume; //HostFileSystemVolume
	public $vStorageSupport; //string

	function __construct($mountInfo = null, $volume = null, $vStorageSupport = null) {
		$this->mountInfo = $mountInfo;
		$this->volume = $volume;
		$this->vStorageSupport = $vStorageSupport;
	}
}

class ArrayOfHostFileSystemMountInfo {
	public $HostFileSystemMountInfo; //HostFileSystemMountInfo

	function __construct($HostFileSystemMountInfo = null) {
		$this->HostFileSystemMountInfo = $HostFileSystemMountInfo;
	}
}

class HostFileSystemVolume {
	public $type; //string
	public $name; //string
	public $capacity; //long

	function __construct($type = null, $name = null, $capacity = null) {
		$this->type = $type;
		$this->name = $name;
		$this->capacity = $capacity;
	}
}

class HostNasVolumeSpec {
	public $remoteHost; //string
	public $remotePath; //string
	public $localPath; //string
	public $accessMode; //string
	public $type; //string
	public $userName; //string
	public $password; //string

	function __construct($remoteHost = null, $remotePath = null, $localPath = null, $accessMode = null, $type = null, $userName = null, $password = null) {
		$this->remoteHost = $remoteHost;
		$this->remotePath = $remotePath;
		$this->localPath = $localPath;
		$this->accessMode = $accessMode;
		$this->type = $type;
		$this->userName = $userName;
		$this->password = $password;
	}
}

class HostNasVolumeConfig {
	public $changeOperation; //string
	public $spec; //HostNasVolumeSpec

	function __construct($changeOperation = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->spec = $spec;
	}
}

class ArrayOfHostNasVolumeConfig {
	public $HostNasVolumeConfig; //HostNasVolumeConfig

	function __construct($HostNasVolumeConfig = null) {
		$this->HostNasVolumeConfig = $HostNasVolumeConfig;
	}
}

class HostNasVolume {
	public $remoteHost; //string
	public $remotePath; //string
	public $userName; //string

	function __construct($remoteHost = null, $remotePath = null, $userName = null) {
		$this->remoteHost = $remoteHost;
		$this->remotePath = $remotePath;
		$this->userName = $userName;
	}
}

class HostLocalFileSystemVolumeSpec {
	public $device; //string
	public $localPath; //string

	function __construct($device = null, $localPath = null) {
		$this->device = $device;
		$this->localPath = $localPath;
	}
}

class HostLocalFileSystemVolume {
	public $device; //string

	function __construct($device = null) {
		$this->device = $device;
	}
}

class HostVfatVolume {
}

class HostFirewallConfigRuleSetConfig {
	public $rulesetId; //string
	public $enabled; //boolean
	public $allowedHosts; //HostFirewallRulesetIpList

	function __construct($rulesetId = null, $enabled = null, $allowedHosts = null) {
		$this->rulesetId = $rulesetId;
		$this->enabled = $enabled;
		$this->allowedHosts = $allowedHosts;
	}
}

class ArrayOfHostFirewallConfigRuleSetConfig {
	public $HostFirewallConfigRuleSetConfig; //HostFirewallConfigRuleSetConfig

	function __construct($HostFirewallConfigRuleSetConfig = null) {
		$this->HostFirewallConfigRuleSetConfig = $HostFirewallConfigRuleSetConfig;
	}
}

class HostFirewallConfig {
	public $rule; //HostFirewallConfigRuleSetConfig
	public $defaultBlockingPolicy; //HostFirewallDefaultPolicy

	function __construct($rule = null, $defaultBlockingPolicy = null) {
		$this->rule = $rule;
		$this->defaultBlockingPolicy = $defaultBlockingPolicy;
	}
}

class HostFirewallDefaultPolicy {
	public $incomingBlocked; //boolean
	public $outgoingBlocked; //boolean

	function __construct($incomingBlocked = null, $outgoingBlocked = null) {
		$this->incomingBlocked = $incomingBlocked;
		$this->outgoingBlocked = $outgoingBlocked;
	}
}

class HostFirewallInfo {
	public $defaultPolicy; //HostFirewallDefaultPolicy
	public $ruleset; //HostFirewallRuleset

	function __construct($defaultPolicy = null, $ruleset = null) {
		$this->defaultPolicy = $defaultPolicy;
		$this->ruleset = $ruleset;
	}
}

class HostFlagInfo {
	public $backgroundSnapshotsEnabled; //boolean

	function __construct($backgroundSnapshotsEnabled = null) {
		$this->backgroundSnapshotsEnabled = $backgroundSnapshotsEnabled;
	}
}

class HostForceMountedInfo {
	public $persist; //boolean
	public $mounted; //boolean

	function __construct($persist = null, $mounted = null) {
		$this->persist = $persist;
		$this->mounted = $mounted;
	}
}

class HostHardwareInfo {
	public $systemInfo; //HostSystemInfo
	public $cpuPowerManagementInfo; //HostCpuPowerManagementInfo
	public $cpuInfo; //HostCpuInfo
	public $cpuPkg; //HostCpuPackage
	public $memorySize; //long
	public $numaInfo; //HostNumaInfo
	public $smcPresent; //boolean
	public $pciDevice; //HostPciDevice
	public $cpuFeature; //HostCpuIdInfo
	public $biosInfo; //HostBIOSInfo

	function __construct($systemInfo = null, $cpuPowerManagementInfo = null, $cpuInfo = null, $cpuPkg = null, $memorySize = null, $numaInfo = null, $smcPresent = null, $pciDevice = null, $cpuFeature = null, $biosInfo = null) {
		$this->systemInfo = $systemInfo;
		$this->cpuPowerManagementInfo = $cpuPowerManagementInfo;
		$this->cpuInfo = $cpuInfo;
		$this->cpuPkg = $cpuPkg;
		$this->memorySize = $memorySize;
		$this->numaInfo = $numaInfo;
		$this->smcPresent = $smcPresent;
		$this->pciDevice = $pciDevice;
		$this->cpuFeature = $cpuFeature;
		$this->biosInfo = $biosInfo;
	}
}

class HostSystemInfo {
	public $vendor; //string
	public $model; //string
	public $uuid; //string
	public $otherIdentifyingInfo; //HostSystemIdentificationInfo

	function __construct($vendor = null, $model = null, $uuid = null, $otherIdentifyingInfo = null) {
		$this->vendor = $vendor;
		$this->model = $model;
		$this->uuid = $uuid;
		$this->otherIdentifyingInfo = $otherIdentifyingInfo;
	}
}

class HostCpuPowerManagementInfo {
	public $currentPolicy; //string
	public $hardwareSupport; //string

	function __construct($currentPolicy = null, $hardwareSupport = null) {
		$this->currentPolicy = $currentPolicy;
		$this->hardwareSupport = $hardwareSupport;
	}
}

class HostCpuInfo {
	public $numCpuPackages; //short
	public $numCpuCores; //short
	public $numCpuThreads; //short
	public $hz; //long

	function __construct($numCpuPackages = null, $numCpuCores = null, $numCpuThreads = null, $hz = null) {
		$this->numCpuPackages = $numCpuPackages;
		$this->numCpuCores = $numCpuCores;
		$this->numCpuThreads = $numCpuThreads;
		$this->hz = $hz;
	}
}

class HostCpuPackage {
	public $index; //short
	public $vendor; //string
	public $hz; //long
	public $busHz; //long
	public $description; //string
	public $threadId; //short
	public $cpuFeature; //HostCpuIdInfo

	function __construct($index = null, $vendor = null, $hz = null, $busHz = null, $description = null, $threadId = null, $cpuFeature = null) {
		$this->index = $index;
		$this->vendor = $vendor;
		$this->hz = $hz;
		$this->busHz = $busHz;
		$this->description = $description;
		$this->threadId = $threadId;
		$this->cpuFeature = $cpuFeature;
	}
}

class ArrayOfHostCpuPackage {
	public $HostCpuPackage; //HostCpuPackage

	function __construct($HostCpuPackage = null) {
		$this->HostCpuPackage = $HostCpuPackage;
	}
}

class HostNumaInfo {
	public $type; //string
	public $numNodes; //int
	public $numaNode; //HostNumaNode

	function __construct($type = null, $numNodes = null, $numaNode = null) {
		$this->type = $type;
		$this->numNodes = $numNodes;
		$this->numaNode = $numaNode;
	}
}

class HostNumaNode {
	public $typeId; //byte
	public $cpuID; //short
	public $memoryRangeBegin; //long
	public $memoryRangeLength; //long

	function __construct($typeId = null, $cpuID = null, $memoryRangeBegin = null, $memoryRangeLength = null) {
		$this->typeId = $typeId;
		$this->cpuID = $cpuID;
		$this->memoryRangeBegin = $memoryRangeBegin;
		$this->memoryRangeLength = $memoryRangeLength;
	}
}

class ArrayOfHostNumaNode {
	public $HostNumaNode; //HostNumaNode

	function __construct($HostNumaNode = null) {
		$this->HostNumaNode = $HostNumaNode;
	}
}

class HostBIOSInfo {
	public $biosVersion; //string
	public $releaseDate; //dateTime

	function __construct($biosVersion = null, $releaseDate = null) {
		$this->biosVersion = $biosVersion;
		$this->releaseDate = $releaseDate;
	}
}

class HostHardwareElementInfo {
	public $name; //string
	public $status; //ElementDescription

	function __construct($name = null, $status = null) {
		$this->name = $name;
		$this->status = $status;
	}
}

class ArrayOfHostHardwareElementInfo {
	public $HostHardwareElementInfo; //HostHardwareElementInfo

	function __construct($HostHardwareElementInfo = null) {
		$this->HostHardwareElementInfo = $HostHardwareElementInfo;
	}
}

class HostStorageOperationalInfo {
	public $property; //string
	public $value; //string

	function __construct($property = null, $value = null) {
		$this->property = $property;
		$this->value = $value;
	}
}

class ArrayOfHostStorageOperationalInfo {
	public $HostStorageOperationalInfo; //HostStorageOperationalInfo

	function __construct($HostStorageOperationalInfo = null) {
		$this->HostStorageOperationalInfo = $HostStorageOperationalInfo;
	}
}

class HostStorageElementInfo {
	public $operationalInfo; //HostStorageOperationalInfo

	function __construct($operationalInfo = null) {
		$this->operationalInfo = $operationalInfo;
	}
}

class ArrayOfHostStorageElementInfo {
	public $HostStorageElementInfo; //HostStorageElementInfo

	function __construct($HostStorageElementInfo = null) {
		$this->HostStorageElementInfo = $HostStorageElementInfo;
	}
}

class HostHardwareStatusInfo {
	public $memoryStatusInfo; //HostHardwareElementInfo
	public $cpuStatusInfo; //HostHardwareElementInfo
	public $storageStatusInfo; //HostStorageElementInfo

	function __construct($memoryStatusInfo = null, $cpuStatusInfo = null, $storageStatusInfo = null) {
		$this->memoryStatusInfo = $memoryStatusInfo;
		$this->cpuStatusInfo = $cpuStatusInfo;
		$this->storageStatusInfo = $storageStatusInfo;
	}
}

class HealthSystemRuntime {
	public $systemHealthInfo; //HostSystemHealthInfo
	public $hardwareStatusInfo; //HostHardwareStatusInfo

	function __construct($systemHealthInfo = null, $hardwareStatusInfo = null) {
		$this->systemHealthInfo = $systemHealthInfo;
		$this->hardwareStatusInfo = $hardwareStatusInfo;
	}
}

class HostHostBusAdapter {
	public $key; //string
	public $device; //string
	public $bus; //int
	public $status; //string
	public $model; //string
	public $driver; //string
	public $pci; //string

	function __construct($key = null, $device = null, $bus = null, $status = null, $model = null, $driver = null, $pci = null) {
		$this->key = $key;
		$this->device = $device;
		$this->bus = $bus;
		$this->status = $status;
		$this->model = $model;
		$this->driver = $driver;
		$this->pci = $pci;
	}
}

class ArrayOfHostHostBusAdapter {
	public $HostHostBusAdapter; //HostHostBusAdapter

	function __construct($HostHostBusAdapter = null) {
		$this->HostHostBusAdapter = $HostHostBusAdapter;
	}
}

class HostParallelScsiHba {
}

class HostBlockHba {
}

class HostFibreChannelHba {
	public $portWorldWideName; //long
	public $nodeWorldWideName; //long
	public $portType; //FibreChannelPortType
	public $speed; //long

	function __construct($portWorldWideName = null, $nodeWorldWideName = null, $portType = null, $speed = null) {
		$this->portWorldWideName = $portWorldWideName;
		$this->nodeWorldWideName = $nodeWorldWideName;
		$this->portType = $portType;
		$this->speed = $speed;
	}
}

class HostInternetScsiHbaParamValue {
	public $isInherited; //boolean

	function __construct($isInherited = null) {
		$this->isInherited = $isInherited;
	}
}

class ArrayOfHostInternetScsiHbaParamValue {
	public $HostInternetScsiHbaParamValue; //HostInternetScsiHbaParamValue

	function __construct($HostInternetScsiHbaParamValue = null) {
		$this->HostInternetScsiHbaParamValue = $HostInternetScsiHbaParamValue;
	}
}

class HostInternetScsiHbaDiscoveryCapabilities {
	public $iSnsDiscoverySettable; //boolean
	public $slpDiscoverySettable; //boolean
	public $staticTargetDiscoverySettable; //boolean
	public $sendTargetsDiscoverySettable; //boolean

	function __construct($iSnsDiscoverySettable = null, $slpDiscoverySettable = null, $staticTargetDiscoverySettable = null, $sendTargetsDiscoverySettable = null) {
		$this->iSnsDiscoverySettable = $iSnsDiscoverySettable;
		$this->slpDiscoverySettable = $slpDiscoverySettable;
		$this->staticTargetDiscoverySettable = $staticTargetDiscoverySettable;
		$this->sendTargetsDiscoverySettable = $sendTargetsDiscoverySettable;
	}
}

class HostInternetScsiHbaDiscoveryProperties {
	public $iSnsDiscoveryEnabled; //boolean
	public $iSnsDiscoveryMethod; //string
	public $iSnsHost; //string
	public $slpDiscoveryEnabled; //boolean
	public $slpDiscoveryMethod; //string
	public $slpHost; //string
	public $staticTargetDiscoveryEnabled; //boolean
	public $sendTargetsDiscoveryEnabled; //boolean

	function __construct($iSnsDiscoveryEnabled = null, $iSnsDiscoveryMethod = null, $iSnsHost = null, $slpDiscoveryEnabled = null, $slpDiscoveryMethod = null, $slpHost = null, $staticTargetDiscoveryEnabled = null, $sendTargetsDiscoveryEnabled = null) {
		$this->iSnsDiscoveryEnabled = $iSnsDiscoveryEnabled;
		$this->iSnsDiscoveryMethod = $iSnsDiscoveryMethod;
		$this->iSnsHost = $iSnsHost;
		$this->slpDiscoveryEnabled = $slpDiscoveryEnabled;
		$this->slpDiscoveryMethod = $slpDiscoveryMethod;
		$this->slpHost = $slpHost;
		$this->staticTargetDiscoveryEnabled = $staticTargetDiscoveryEnabled;
		$this->sendTargetsDiscoveryEnabled = $sendTargetsDiscoveryEnabled;
	}
}

class HostInternetScsiHbaAuthenticationCapabilities {
	public $chapAuthSettable; //boolean
	public $krb5AuthSettable; //boolean
	public $srpAuthSettable; //boolean
	public $spkmAuthSettable; //boolean
	public $mutualChapSettable; //boolean
	public $targetChapSettable; //boolean
	public $targetMutualChapSettable; //boolean

	function __construct($chapAuthSettable = null, $krb5AuthSettable = null, $srpAuthSettable = null, $spkmAuthSettable = null, $mutualChapSettable = null, $targetChapSettable = null, $targetMutualChapSettable = null) {
		$this->chapAuthSettable = $chapAuthSettable;
		$this->krb5AuthSettable = $krb5AuthSettable;
		$this->srpAuthSettable = $srpAuthSettable;
		$this->spkmAuthSettable = $spkmAuthSettable;
		$this->mutualChapSettable = $mutualChapSettable;
		$this->targetChapSettable = $targetChapSettable;
		$this->targetMutualChapSettable = $targetMutualChapSettable;
	}
}

class HostInternetScsiHbaAuthenticationProperties {
	public $chapAuthEnabled; //boolean
	public $chapName; //string
	public $chapSecret; //string
	public $chapAuthenticationType; //string
	public $chapInherited; //boolean
	public $mutualChapName; //string
	public $mutualChapSecret; //string
	public $mutualChapAuthenticationType; //string
	public $mutualChapInherited; //boolean

	function __construct($chapAuthEnabled = null, $chapName = null, $chapSecret = null, $chapAuthenticationType = null, $chapInherited = null, $mutualChapName = null, $mutualChapSecret = null, $mutualChapAuthenticationType = null, $mutualChapInherited = null) {
		$this->chapAuthEnabled = $chapAuthEnabled;
		$this->chapName = $chapName;
		$this->chapSecret = $chapSecret;
		$this->chapAuthenticationType = $chapAuthenticationType;
		$this->chapInherited = $chapInherited;
		$this->mutualChapName = $mutualChapName;
		$this->mutualChapSecret = $mutualChapSecret;
		$this->mutualChapAuthenticationType = $mutualChapAuthenticationType;
		$this->mutualChapInherited = $mutualChapInherited;
	}
}

class HostInternetScsiHbaDigestCapabilities {
	public $headerDigestSettable; //boolean
	public $dataDigestSettable; //boolean
	public $targetHeaderDigestSettable; //boolean
	public $targetDataDigestSettable; //boolean

	function __construct($headerDigestSettable = null, $dataDigestSettable = null, $targetHeaderDigestSettable = null, $targetDataDigestSettable = null) {
		$this->headerDigestSettable = $headerDigestSettable;
		$this->dataDigestSettable = $dataDigestSettable;
		$this->targetHeaderDigestSettable = $targetHeaderDigestSettable;
		$this->targetDataDigestSettable = $targetDataDigestSettable;
	}
}

class HostInternetScsiHbaDigestProperties {
	public $headerDigestType; //string
	public $headerDigestInherited; //boolean
	public $dataDigestType; //string
	public $dataDigestInherited; //boolean

	function __construct($headerDigestType = null, $headerDigestInherited = null, $dataDigestType = null, $dataDigestInherited = null) {
		$this->headerDigestType = $headerDigestType;
		$this->headerDigestInherited = $headerDigestInherited;
		$this->dataDigestType = $dataDigestType;
		$this->dataDigestInherited = $dataDigestInherited;
	}
}

class HostInternetScsiHbaIPCapabilities {
	public $addressSettable; //boolean
	public $ipConfigurationMethodSettable; //boolean
	public $subnetMaskSettable; //boolean
	public $defaultGatewaySettable; //boolean
	public $primaryDnsServerAddressSettable; //boolean
	public $alternateDnsServerAddressSettable; //boolean
	public $ipv6Supported; //boolean
	public $arpRedirectSettable; //boolean
	public $mtuSettable; //boolean
	public $hostNameAsTargetAddress; //boolean
	public $nameAliasSettable; //boolean

	function __construct($addressSettable = null, $ipConfigurationMethodSettable = null, $subnetMaskSettable = null, $defaultGatewaySettable = null, $primaryDnsServerAddressSettable = null, $alternateDnsServerAddressSettable = null, $ipv6Supported = null, $arpRedirectSettable = null, $mtuSettable = null, $hostNameAsTargetAddress = null, $nameAliasSettable = null) {
		$this->addressSettable = $addressSettable;
		$this->ipConfigurationMethodSettable = $ipConfigurationMethodSettable;
		$this->subnetMaskSettable = $subnetMaskSettable;
		$this->defaultGatewaySettable = $defaultGatewaySettable;
		$this->primaryDnsServerAddressSettable = $primaryDnsServerAddressSettable;
		$this->alternateDnsServerAddressSettable = $alternateDnsServerAddressSettable;
		$this->ipv6Supported = $ipv6Supported;
		$this->arpRedirectSettable = $arpRedirectSettable;
		$this->mtuSettable = $mtuSettable;
		$this->hostNameAsTargetAddress = $hostNameAsTargetAddress;
		$this->nameAliasSettable = $nameAliasSettable;
	}
}

class HostInternetScsiHbaIPProperties {
	public $mac; //string
	public $address; //string
	public $dhcpConfigurationEnabled; //boolean
	public $subnetMask; //string
	public $defaultGateway; //string
	public $primaryDnsServerAddress; //string
	public $alternateDnsServerAddress; //string
	public $ipv6Address; //string
	public $ipv6SubnetMask; //string
	public $ipv6DefaultGateway; //string
	public $arpRedirectEnabled; //boolean
	public $mtu; //int
	public $jumboFramesEnabled; //boolean

	function __construct($mac = null, $address = null, $dhcpConfigurationEnabled = null, $subnetMask = null, $defaultGateway = null, $primaryDnsServerAddress = null, $alternateDnsServerAddress = null, $ipv6Address = null, $ipv6SubnetMask = null, $ipv6DefaultGateway = null, $arpRedirectEnabled = null, $mtu = null, $jumboFramesEnabled = null) {
		$this->mac = $mac;
		$this->address = $address;
		$this->dhcpConfigurationEnabled = $dhcpConfigurationEnabled;
		$this->subnetMask = $subnetMask;
		$this->defaultGateway = $defaultGateway;
		$this->primaryDnsServerAddress = $primaryDnsServerAddress;
		$this->alternateDnsServerAddress = $alternateDnsServerAddress;
		$this->ipv6Address = $ipv6Address;
		$this->ipv6SubnetMask = $ipv6SubnetMask;
		$this->ipv6DefaultGateway = $ipv6DefaultGateway;
		$this->arpRedirectEnabled = $arpRedirectEnabled;
		$this->mtu = $mtu;
		$this->jumboFramesEnabled = $jumboFramesEnabled;
	}
}

class HostInternetScsiHbaSendTarget {
	public $address; //string
	public $port; //int
	public $authenticationProperties; //HostInternetScsiHbaAuthenticationProperties
	public $digestProperties; //HostInternetScsiHbaDigestProperties
	public $supportedAdvancedOptions; //OptionDef
	public $advancedOptions; //HostInternetScsiHbaParamValue
	public $parent; //string

	function __construct($address = null, $port = null, $authenticationProperties = null, $digestProperties = null, $supportedAdvancedOptions = null, $advancedOptions = null, $parent = null) {
		$this->address = $address;
		$this->port = $port;
		$this->authenticationProperties = $authenticationProperties;
		$this->digestProperties = $digestProperties;
		$this->supportedAdvancedOptions = $supportedAdvancedOptions;
		$this->advancedOptions = $advancedOptions;
		$this->parent = $parent;
	}
}

class ArrayOfHostInternetScsiHbaSendTarget {
	public $HostInternetScsiHbaSendTarget; //HostInternetScsiHbaSendTarget

	function __construct($HostInternetScsiHbaSendTarget = null) {
		$this->HostInternetScsiHbaSendTarget = $HostInternetScsiHbaSendTarget;
	}
}

class HostInternetScsiHbaStaticTarget {
	public $address; //string
	public $port; //int
	public $iScsiName; //string
	public $authenticationProperties; //HostInternetScsiHbaAuthenticationProperties
	public $digestProperties; //HostInternetScsiHbaDigestProperties
	public $supportedAdvancedOptions; //OptionDef
	public $advancedOptions; //HostInternetScsiHbaParamValue
	public $parent; //string

	function __construct($address = null, $port = null, $iScsiName = null, $authenticationProperties = null, $digestProperties = null, $supportedAdvancedOptions = null, $advancedOptions = null, $parent = null) {
		$this->address = $address;
		$this->port = $port;
		$this->iScsiName = $iScsiName;
		$this->authenticationProperties = $authenticationProperties;
		$this->digestProperties = $digestProperties;
		$this->supportedAdvancedOptions = $supportedAdvancedOptions;
		$this->advancedOptions = $advancedOptions;
		$this->parent = $parent;
	}
}

class ArrayOfHostInternetScsiHbaStaticTarget {
	public $HostInternetScsiHbaStaticTarget; //HostInternetScsiHbaStaticTarget

	function __construct($HostInternetScsiHbaStaticTarget = null) {
		$this->HostInternetScsiHbaStaticTarget = $HostInternetScsiHbaStaticTarget;
	}
}

class HostInternetScsiHbaTargetSet {
	public $staticTargets; //HostInternetScsiHbaStaticTarget
	public $sendTargets; //HostInternetScsiHbaSendTarget

	function __construct($staticTargets = null, $sendTargets = null) {
		$this->staticTargets = $staticTargets;
		$this->sendTargets = $sendTargets;
	}
}

class HostInternetScsiHba {
	public $isSoftwareBased; //boolean
	public $canBeDisabled; //boolean
	public $networkBindingSupport; //HostInternetScsiHbaNetworkBindingSupportType
	public $discoveryCapabilities; //HostInternetScsiHbaDiscoveryCapabilities
	public $discoveryProperties; //HostInternetScsiHbaDiscoveryProperties
	public $authenticationCapabilities; //HostInternetScsiHbaAuthenticationCapabilities
	public $authenticationProperties; //HostInternetScsiHbaAuthenticationProperties
	public $digestCapabilities; //HostInternetScsiHbaDigestCapabilities
	public $digestProperties; //HostInternetScsiHbaDigestProperties
	public $ipCapabilities; //HostInternetScsiHbaIPCapabilities
	public $ipProperties; //HostInternetScsiHbaIPProperties
	public $supportedAdvancedOptions; //OptionDef
	public $advancedOptions; //HostInternetScsiHbaParamValue
	public $iScsiName; //string
	public $iScsiAlias; //string
	public $configuredSendTarget; //HostInternetScsiHbaSendTarget
	public $configuredStaticTarget; //HostInternetScsiHbaStaticTarget
	public $maxSpeedMb; //int
	public $currentSpeedMb; //int

	function __construct($isSoftwareBased = null, $canBeDisabled = null, $networkBindingSupport = null, $discoveryCapabilities = null, $discoveryProperties = null, $authenticationCapabilities = null, $authenticationProperties = null, $digestCapabilities = null, $digestProperties = null, $ipCapabilities = null, $ipProperties = null, $supportedAdvancedOptions = null, $advancedOptions = null, $iScsiName = null, $iScsiAlias = null, $configuredSendTarget = null, $configuredStaticTarget = null, $maxSpeedMb = null, $currentSpeedMb = null) {
		$this->isSoftwareBased = $isSoftwareBased;
		$this->canBeDisabled = $canBeDisabled;
		$this->networkBindingSupport = $networkBindingSupport;
		$this->discoveryCapabilities = $discoveryCapabilities;
		$this->discoveryProperties = $discoveryProperties;
		$this->authenticationCapabilities = $authenticationCapabilities;
		$this->authenticationProperties = $authenticationProperties;
		$this->digestCapabilities = $digestCapabilities;
		$this->digestProperties = $digestProperties;
		$this->ipCapabilities = $ipCapabilities;
		$this->ipProperties = $ipProperties;
		$this->supportedAdvancedOptions = $supportedAdvancedOptions;
		$this->advancedOptions = $advancedOptions;
		$this->iScsiName = $iScsiName;
		$this->iScsiAlias = $iScsiAlias;
		$this->configuredSendTarget = $configuredSendTarget;
		$this->configuredStaticTarget = $configuredStaticTarget;
		$this->maxSpeedMb = $maxSpeedMb;
		$this->currentSpeedMb = $currentSpeedMb;
	}
}

class HostFibreChannelOverEthernetHbaLinkInfo {
	public $vnportMac; //string
	public $fcfMac; //string
	public $vlanId; //int

	function __construct($vnportMac = null, $fcfMac = null, $vlanId = null) {
		$this->vnportMac = $vnportMac;
		$this->fcfMac = $fcfMac;
		$this->vlanId = $vlanId;
	}
}

class HostFibreChannelOverEthernetHba {
	public $underlyingNic; //string
	public $linkInfo; //HostFibreChannelOverEthernetHbaLinkInfo
	public $isSoftwareFcoe; //boolean
	public $markedForRemoval; //boolean

	function __construct($underlyingNic = null, $linkInfo = null, $isSoftwareFcoe = null, $markedForRemoval = null) {
		$this->underlyingNic = $underlyingNic;
		$this->linkInfo = $linkInfo;
		$this->isSoftwareFcoe = $isSoftwareFcoe;
		$this->markedForRemoval = $markedForRemoval;
	}
}

class HostProxySwitchSpec {
	public $backing; //DistributedVirtualSwitchHostMemberBacking

	function __construct($backing = null) {
		$this->backing = $backing;
	}
}

class HostProxySwitchConfig {
	public $changeOperation; //string
	public $uuid; //string
	public $spec; //HostProxySwitchSpec

	function __construct($changeOperation = null, $uuid = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->uuid = $uuid;
		$this->spec = $spec;
	}
}

class ArrayOfHostProxySwitchConfig {
	public $HostProxySwitchConfig; //HostProxySwitchConfig

	function __construct($HostProxySwitchConfig = null) {
		$this->HostProxySwitchConfig = $HostProxySwitchConfig;
	}
}

class HostProxySwitch {
	public $dvsUuid; //string
	public $dvsName; //string
	public $key; //string
	public $numPorts; //int
	public $configNumPorts; //int
	public $numPortsAvailable; //int
	public $uplinkPort; //KeyValue
	public $mtu; //int
	public $pnic; //string
	public $spec; //HostProxySwitchSpec

	function __construct($dvsUuid = null, $dvsName = null, $key = null, $numPorts = null, $configNumPorts = null, $numPortsAvailable = null, $uplinkPort = null, $mtu = null, $pnic = null, $spec = null) {
		$this->dvsUuid = $dvsUuid;
		$this->dvsName = $dvsName;
		$this->key = $key;
		$this->numPorts = $numPorts;
		$this->configNumPorts = $configNumPorts;
		$this->numPortsAvailable = $numPortsAvailable;
		$this->uplinkPort = $uplinkPort;
		$this->mtu = $mtu;
		$this->pnic = $pnic;
		$this->spec = $spec;
	}
}

class ArrayOfHostProxySwitch {
	public $HostProxySwitch; //HostProxySwitch

	function __construct($HostProxySwitch = null) {
		$this->HostProxySwitch = $HostProxySwitch;
	}
}

class HostImageProfileSummary {
	public $name; //string
	public $vendor; //string

	function __construct($name = null, $vendor = null) {
		$this->name = $name;
		$this->vendor = $vendor;
	}
}

class HostIpConfigIpV6Address {
	public $ipAddress; //string
	public $prefixLength; //int
	public $origin; //string
	public $dadState; //string
	public $lifetime; //dateTime
	public $operation; //string

	function __construct($ipAddress = null, $prefixLength = null, $origin = null, $dadState = null, $lifetime = null, $operation = null) {
		$this->ipAddress = $ipAddress;
		$this->prefixLength = $prefixLength;
		$this->origin = $origin;
		$this->dadState = $dadState;
		$this->lifetime = $lifetime;
		$this->operation = $operation;
	}
}

class ArrayOfHostIpConfigIpV6Address {
	public $HostIpConfigIpV6Address; //HostIpConfigIpV6Address

	function __construct($HostIpConfigIpV6Address = null) {
		$this->HostIpConfigIpV6Address = $HostIpConfigIpV6Address;
	}
}

class HostIpConfigIpV6AddressConfiguration {
	public $ipV6Address; //HostIpConfigIpV6Address
	public $autoConfigurationEnabled; //boolean
	public $dhcpV6Enabled; //boolean

	function __construct($ipV6Address = null, $autoConfigurationEnabled = null, $dhcpV6Enabled = null) {
		$this->ipV6Address = $ipV6Address;
		$this->autoConfigurationEnabled = $autoConfigurationEnabled;
		$this->dhcpV6Enabled = $dhcpV6Enabled;
	}
}

class HostIpConfig {
	public $dhcp; //boolean
	public $ipAddress; //string
	public $subnetMask; //string
	public $ipV6Config; //HostIpConfigIpV6AddressConfiguration

	function __construct($dhcp = null, $ipAddress = null, $subnetMask = null, $ipV6Config = null) {
		$this->dhcp = $dhcp;
		$this->ipAddress = $ipAddress;
		$this->subnetMask = $subnetMask;
		$this->ipV6Config = $ipV6Config;
	}
}

class HostIpRouteConfig {
	public $defaultGateway; //string
	public $gatewayDevice; //string
	public $ipV6DefaultGateway; //string
	public $ipV6GatewayDevice; //string

	function __construct($defaultGateway = null, $gatewayDevice = null, $ipV6DefaultGateway = null, $ipV6GatewayDevice = null) {
		$this->defaultGateway = $defaultGateway;
		$this->gatewayDevice = $gatewayDevice;
		$this->ipV6DefaultGateway = $ipV6DefaultGateway;
		$this->ipV6GatewayDevice = $ipV6GatewayDevice;
	}
}

class HostIpRouteConfigSpec {
	public $gatewayDeviceConnection; //HostVirtualNicConnection
	public $ipV6GatewayDeviceConnection; //HostVirtualNicConnection

	function __construct($gatewayDeviceConnection = null, $ipV6GatewayDeviceConnection = null) {
		$this->gatewayDeviceConnection = $gatewayDeviceConnection;
		$this->ipV6GatewayDeviceConnection = $ipV6GatewayDeviceConnection;
	}
}

class HostIpRouteEntry {
	public $network; //string
	public $prefixLength; //int
	public $gateway; //string
	public $deviceName; //string

	function __construct($network = null, $prefixLength = null, $gateway = null, $deviceName = null) {
		$this->network = $network;
		$this->prefixLength = $prefixLength;
		$this->gateway = $gateway;
		$this->deviceName = $deviceName;
	}
}

class ArrayOfHostIpRouteEntry {
	public $HostIpRouteEntry; //HostIpRouteEntry

	function __construct($HostIpRouteEntry = null) {
		$this->HostIpRouteEntry = $HostIpRouteEntry;
	}
}

class HostIpRouteOp {
	public $changeOperation; //string
	public $route; //HostIpRouteEntry

	function __construct($changeOperation = null, $route = null) {
		$this->changeOperation = $changeOperation;
		$this->route = $route;
	}
}

class ArrayOfHostIpRouteOp {
	public $HostIpRouteOp; //HostIpRouteOp

	function __construct($HostIpRouteOp = null) {
		$this->HostIpRouteOp = $HostIpRouteOp;
	}
}

class HostIpRouteTableConfig {
	public $ipRoute; //HostIpRouteOp
	public $ipv6Route; //HostIpRouteOp

	function __construct($ipRoute = null, $ipv6Route = null) {
		$this->ipRoute = $ipRoute;
		$this->ipv6Route = $ipv6Route;
	}
}

class HostIpRouteTableInfo {
	public $ipRoute; //HostIpRouteEntry
	public $ipv6Route; //HostIpRouteEntry

	function __construct($ipRoute = null, $ipv6Route = null) {
		$this->ipRoute = $ipRoute;
		$this->ipv6Route = $ipv6Route;
	}
}

class HostIpmiInfo {
	public $bmcIpAddress; //string
	public $bmcMacAddress; //string
	public $login; //string
	public $password; //string

	function __construct($bmcIpAddress = null, $bmcMacAddress = null, $login = null, $password = null) {
		$this->bmcIpAddress = $bmcIpAddress;
		$this->bmcMacAddress = $bmcMacAddress;
		$this->login = $login;
		$this->password = $password;
	}
}

class IscsiStatus {
	public $reason; //LocalizedMethodFault

	function __construct($reason = null) {
		$this->reason = $reason;
	}
}

class IscsiPortInfo {
	public $vnicDevice; //string
	public $vnic; //HostVirtualNic
	public $pnicDevice; //string
	public $pnic; //PhysicalNic
	public $switchName; //string
	public $switchUuid; //string
	public $portgroupName; //string
	public $portgroupKey; //string
	public $portKey; //string
	public $complianceStatus; //IscsiStatus
	public $pathStatus; //string

	function __construct($vnicDevice = null, $vnic = null, $pnicDevice = null, $pnic = null, $switchName = null, $switchUuid = null, $portgroupName = null, $portgroupKey = null, $portKey = null, $complianceStatus = null, $pathStatus = null) {
		$this->vnicDevice = $vnicDevice;
		$this->vnic = $vnic;
		$this->pnicDevice = $pnicDevice;
		$this->pnic = $pnic;
		$this->switchName = $switchName;
		$this->switchUuid = $switchUuid;
		$this->portgroupName = $portgroupName;
		$this->portgroupKey = $portgroupKey;
		$this->portKey = $portKey;
		$this->complianceStatus = $complianceStatus;
		$this->pathStatus = $pathStatus;
	}
}

class ArrayOfIscsiPortInfo {
	public $IscsiPortInfo; //IscsiPortInfo

	function __construct($IscsiPortInfo = null) {
		$this->IscsiPortInfo = $IscsiPortInfo;
	}
}

class IscsiDependencyEntity {
	public $pnicDevice; //string
	public $vnicDevice; //string
	public $vmhbaName; //string

	function __construct($pnicDevice = null, $vnicDevice = null, $vmhbaName = null) {
		$this->pnicDevice = $pnicDevice;
		$this->vnicDevice = $vnicDevice;
		$this->vmhbaName = $vmhbaName;
	}
}

class ArrayOfIscsiDependencyEntity {
	public $IscsiDependencyEntity; //IscsiDependencyEntity

	function __construct($IscsiDependencyEntity = null) {
		$this->IscsiDependencyEntity = $IscsiDependencyEntity;
	}
}

class IscsiMigrationDependency {
	public $migrationAllowed; //boolean
	public $disallowReason; //IscsiStatus
	public $dependency; //IscsiDependencyEntity

	function __construct($migrationAllowed = null, $disallowReason = null, $dependency = null) {
		$this->migrationAllowed = $migrationAllowed;
		$this->disallowReason = $disallowReason;
		$this->dependency = $dependency;
	}
}

class KernelModuleSectionInfo {
	public $address; //long
	public $length; //int

	function __construct($address = null, $length = null) {
		$this->address = $address;
		$this->length = $length;
	}
}

class KernelModuleInfo {
	public $id; //int
	public $name; //string
	public $version; //string
	public $filename; //string
	public $optionString; //string
	public $loaded; //boolean
	public $enabled; //boolean
	public $useCount; //int
	public $readOnlySection; //KernelModuleSectionInfo
	public $writableSection; //KernelModuleSectionInfo
	public $textSection; //KernelModuleSectionInfo
	public $dataSection; //KernelModuleSectionInfo
	public $bssSection; //KernelModuleSectionInfo

	function __construct($id = null, $name = null, $version = null, $filename = null, $optionString = null, $loaded = null, $enabled = null, $useCount = null, $readOnlySection = null, $writableSection = null, $textSection = null, $dataSection = null, $bssSection = null) {
		$this->id = $id;
		$this->name = $name;
		$this->version = $version;
		$this->filename = $filename;
		$this->optionString = $optionString;
		$this->loaded = $loaded;
		$this->enabled = $enabled;
		$this->useCount = $useCount;
		$this->readOnlySection = $readOnlySection;
		$this->writableSection = $writableSection;
		$this->textSection = $textSection;
		$this->dataSection = $dataSection;
		$this->bssSection = $bssSection;
	}
}

class ArrayOfKernelModuleInfo {
	public $KernelModuleInfo; //KernelModuleInfo

	function __construct($KernelModuleInfo = null) {
		$this->KernelModuleInfo = $KernelModuleInfo;
	}
}

class HostLicenseSpec {
	public $source; //LicenseSource
	public $editionKey; //string
	public $disabledFeatureKey; //string
	public $enabledFeatureKey; //string

	function __construct($source = null, $editionKey = null, $disabledFeatureKey = null, $enabledFeatureKey = null) {
		$this->source = $source;
		$this->editionKey = $editionKey;
		$this->disabledFeatureKey = $disabledFeatureKey;
		$this->enabledFeatureKey = $enabledFeatureKey;
	}
}

class LinkDiscoveryProtocolConfig {
	public $protocol; //string
	public $operation; //string

	function __construct($protocol = null, $operation = null) {
		$this->protocol = $protocol;
		$this->operation = $operation;
	}
}

class HostAccountSpec {
	public $id; //string
	public $password; //string
	public $description; //string

	function __construct($id = null, $password = null, $description = null) {
		$this->id = $id;
		$this->password = $password;
		$this->description = $description;
	}
}

class ArrayOfHostAccountSpec {
	public $HostAccountSpec; //HostAccountSpec

	function __construct($HostAccountSpec = null) {
		$this->HostAccountSpec = $HostAccountSpec;
	}
}

class HostPosixAccountSpec {
	public $posixId; //int
	public $shellAccess; //boolean

	function __construct($posixId = null, $shellAccess = null) {
		$this->posixId = $posixId;
		$this->shellAccess = $shellAccess;
	}
}

class HostLocalAuthenticationInfo {
}

class HostLowLevelProvisioningManagerDiskLayoutSpec {
	public $controllerType; //string
	public $busNumber; //int
	public $unitNumber; //int
	public $srcFilename; //string
	public $dstFilename; //string

	function __construct($controllerType = null, $busNumber = null, $unitNumber = null, $srcFilename = null, $dstFilename = null) {
		$this->controllerType = $controllerType;
		$this->busNumber = $busNumber;
		$this->unitNumber = $unitNumber;
		$this->srcFilename = $srcFilename;
		$this->dstFilename = $dstFilename;
	}
}

class ArrayOfHostLowLevelProvisioningManagerDiskLayoutSpec {
	public $HostLowLevelProvisioningManagerDiskLayoutSpec; //HostLowLevelProvisioningManagerDiskLayoutSpec

	function __construct($HostLowLevelProvisioningManagerDiskLayoutSpec = null) {
		$this->HostLowLevelProvisioningManagerDiskLayoutSpec = $HostLowLevelProvisioningManagerDiskLayoutSpec;
	}
}

class HostLowLevelProvisioningManagerSnapshotLayoutSpec {
	public $id; //int
	public $srcFilename; //string
	public $dstFilename; //string
	public $disk; //HostLowLevelProvisioningManagerDiskLayoutSpec

	function __construct($id = null, $srcFilename = null, $dstFilename = null, $disk = null) {
		$this->id = $id;
		$this->srcFilename = $srcFilename;
		$this->dstFilename = $dstFilename;
		$this->disk = $disk;
	}
}

class ArrayOfHostLowLevelProvisioningManagerSnapshotLayoutSpec {
	public $HostLowLevelProvisioningManagerSnapshotLayoutSpec; //HostLowLevelProvisioningManagerSnapshotLayoutSpec

	function __construct($HostLowLevelProvisioningManagerSnapshotLayoutSpec = null) {
		$this->HostLowLevelProvisioningManagerSnapshotLayoutSpec = $HostLowLevelProvisioningManagerSnapshotLayoutSpec;
	}
}

class ServiceConsoleReservationInfo {
	public $serviceConsoleReservedCfg; //long
	public $serviceConsoleReserved; //long
	public $unreserved; //long

	function __construct($serviceConsoleReservedCfg = null, $serviceConsoleReserved = null, $unreserved = null) {
		$this->serviceConsoleReservedCfg = $serviceConsoleReservedCfg;
		$this->serviceConsoleReserved = $serviceConsoleReserved;
		$this->unreserved = $unreserved;
	}
}

class VirtualMachineMemoryReservationInfo {
	public $virtualMachineMin; //long
	public $virtualMachineMax; //long
	public $virtualMachineReserved; //long
	public $allocationPolicy; //string

	function __construct($virtualMachineMin = null, $virtualMachineMax = null, $virtualMachineReserved = null, $allocationPolicy = null) {
		$this->virtualMachineMin = $virtualMachineMin;
		$this->virtualMachineMax = $virtualMachineMax;
		$this->virtualMachineReserved = $virtualMachineReserved;
		$this->allocationPolicy = $allocationPolicy;
	}
}

class VirtualMachineMemoryReservationSpec {
	public $virtualMachineReserved; //long
	public $allocationPolicy; //string

	function __construct($virtualMachineReserved = null, $allocationPolicy = null) {
		$this->virtualMachineReserved = $virtualMachineReserved;
		$this->allocationPolicy = $allocationPolicy;
	}
}

class HostMemorySpec {
	public $serviceConsoleReservation; //long

	function __construct($serviceConsoleReservation = null) {
		$this->serviceConsoleReservation = $serviceConsoleReservation;
	}
}

class HostMountInfo {
	public $path; //string
	public $accessMode; //string
	public $mounted; //boolean
	public $accessible; //boolean

	function __construct($path = null, $accessMode = null, $mounted = null, $accessible = null) {
		$this->path = $path;
		$this->accessMode = $accessMode;
		$this->mounted = $mounted;
		$this->accessible = $accessible;
	}
}

class HostMultipathInfoLogicalUnitPolicy {
	public $policy; //string

	function __construct($policy = null) {
		$this->policy = $policy;
	}
}

class HostMultipathInfoLogicalUnitStorageArrayTypePolicy {
	public $policy; //string

	function __construct($policy = null) {
		$this->policy = $policy;
	}
}

class HostMultipathInfoFixedLogicalUnitPolicy {
	public $prefer; //string

	function __construct($prefer = null) {
		$this->prefer = $prefer;
	}
}

class HostMultipathInfoLogicalUnit {
	public $key; //string
	public $id; //string
	public $lun; //string
	public $path; //HostMultipathInfoPath
	public $policy; //HostMultipathInfoLogicalUnitPolicy
	public $storageArrayTypePolicy; //HostMultipathInfoLogicalUnitStorageArrayTypePolicy

	function __construct($key = null, $id = null, $lun = null, $path = null, $policy = null, $storageArrayTypePolicy = null) {
		$this->key = $key;
		$this->id = $id;
		$this->lun = $lun;
		$this->path = $path;
		$this->policy = $policy;
		$this->storageArrayTypePolicy = $storageArrayTypePolicy;
	}
}

class ArrayOfHostMultipathInfoLogicalUnit {
	public $HostMultipathInfoLogicalUnit; //HostMultipathInfoLogicalUnit

	function __construct($HostMultipathInfoLogicalUnit = null) {
		$this->HostMultipathInfoLogicalUnit = $HostMultipathInfoLogicalUnit;
	}
}

class HostMultipathInfoPath {
	public $key; //string
	public $name; //string
	public $pathState; //string
	public $state; //string
	public $isWorkingPath; //boolean
	public $adapter; //string
	public $lun; //string
	public $transport; //HostTargetTransport

	function __construct($key = null, $name = null, $pathState = null, $state = null, $isWorkingPath = null, $adapter = null, $lun = null, $transport = null) {
		$this->key = $key;
		$this->name = $name;
		$this->pathState = $pathState;
		$this->state = $state;
		$this->isWorkingPath = $isWorkingPath;
		$this->adapter = $adapter;
		$this->lun = $lun;
		$this->transport = $transport;
	}
}

class ArrayOfHostMultipathInfoPath {
	public $HostMultipathInfoPath; //HostMultipathInfoPath

	function __construct($HostMultipathInfoPath = null) {
		$this->HostMultipathInfoPath = $HostMultipathInfoPath;
	}
}

class HostMultipathInfo {
	public $lun; //HostMultipathInfoLogicalUnit

	function __construct($lun = null) {
		$this->lun = $lun;
	}
}

class HostMultipathStateInfoPath {
	public $name; //string
	public $pathState; //string

	function __construct($name = null, $pathState = null) {
		$this->name = $name;
		$this->pathState = $pathState;
	}
}

class ArrayOfHostMultipathStateInfoPath {
	public $HostMultipathStateInfoPath; //HostMultipathStateInfoPath

	function __construct($HostMultipathStateInfoPath = null) {
		$this->HostMultipathStateInfoPath = $HostMultipathStateInfoPath;
	}
}

class HostMultipathStateInfo {
	public $path; //HostMultipathStateInfoPath

	function __construct($path = null) {
		$this->path = $path;
	}
}

class HostNatServicePortForwardSpec {
	public $type; //string
	public $name; //string
	public $hostPort; //int
	public $guestPort; //int
	public $guestIpAddress; //string

	function __construct($type = null, $name = null, $hostPort = null, $guestPort = null, $guestIpAddress = null) {
		$this->type = $type;
		$this->name = $name;
		$this->hostPort = $hostPort;
		$this->guestPort = $guestPort;
		$this->guestIpAddress = $guestIpAddress;
	}
}

class ArrayOfHostNatServicePortForwardSpec {
	public $HostNatServicePortForwardSpec; //HostNatServicePortForwardSpec

	function __construct($HostNatServicePortForwardSpec = null) {
		$this->HostNatServicePortForwardSpec = $HostNatServicePortForwardSpec;
	}
}

class HostNatServiceNameServiceSpec {
	public $dnsAutoDetect; //boolean
	public $dnsPolicy; //string
	public $dnsRetries; //int
	public $dnsTimeout; //int
	public $dnsNameServer; //string
	public $nbdsTimeout; //int
	public $nbnsRetries; //int
	public $nbnsTimeout; //int

	function __construct($dnsAutoDetect = null, $dnsPolicy = null, $dnsRetries = null, $dnsTimeout = null, $dnsNameServer = null, $nbdsTimeout = null, $nbnsRetries = null, $nbnsTimeout = null) {
		$this->dnsAutoDetect = $dnsAutoDetect;
		$this->dnsPolicy = $dnsPolicy;
		$this->dnsRetries = $dnsRetries;
		$this->dnsTimeout = $dnsTimeout;
		$this->dnsNameServer = $dnsNameServer;
		$this->nbdsTimeout = $nbdsTimeout;
		$this->nbnsRetries = $nbnsRetries;
		$this->nbnsTimeout = $nbnsTimeout;
	}
}

class HostNatServiceSpec {
	public $virtualSwitch; //string
	public $activeFtp; //boolean
	public $allowAnyOui; //boolean
	public $configPort; //boolean
	public $ipGatewayAddress; //string
	public $udpTimeout; //int
	public $portForward; //HostNatServicePortForwardSpec
	public $nameService; //HostNatServiceNameServiceSpec

	function __construct($virtualSwitch = null, $activeFtp = null, $allowAnyOui = null, $configPort = null, $ipGatewayAddress = null, $udpTimeout = null, $portForward = null, $nameService = null) {
		$this->virtualSwitch = $virtualSwitch;
		$this->activeFtp = $activeFtp;
		$this->allowAnyOui = $allowAnyOui;
		$this->configPort = $configPort;
		$this->ipGatewayAddress = $ipGatewayAddress;
		$this->udpTimeout = $udpTimeout;
		$this->portForward = $portForward;
		$this->nameService = $nameService;
	}
}

class HostNatServiceConfig {
	public $changeOperation; //string
	public $key; //string
	public $spec; //HostNatServiceSpec

	function __construct($changeOperation = null, $key = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->key = $key;
		$this->spec = $spec;
	}
}

class ArrayOfHostNatServiceConfig {
	public $HostNatServiceConfig; //HostNatServiceConfig

	function __construct($HostNatServiceConfig = null) {
		$this->HostNatServiceConfig = $HostNatServiceConfig;
	}
}

class HostNatService {
	public $key; //string
	public $spec; //HostNatServiceSpec

	function __construct($key = null, $spec = null) {
		$this->key = $key;
		$this->spec = $spec;
	}
}

class ArrayOfHostNatService {
	public $HostNatService; //HostNatService

	function __construct($HostNatService = null) {
		$this->HostNatService = $HostNatService;
	}
}

class HostNetCapabilities {
	public $canSetPhysicalNicLinkSpeed; //boolean
	public $supportsNicTeaming; //boolean
	public $nicTeamingPolicy; //string
	public $supportsVlan; //boolean
	public $usesServiceConsoleNic; //boolean
	public $supportsNetworkHints; //boolean
	public $maxPortGroupsPerVswitch; //int
	public $vswitchConfigSupported; //boolean
	public $vnicConfigSupported; //boolean
	public $ipRouteConfigSupported; //boolean
	public $dnsConfigSupported; //boolean
	public $dhcpOnVnicSupported; //boolean
	public $ipV6Supported; //boolean

	function __construct($canSetPhysicalNicLinkSpeed = null, $supportsNicTeaming = null, $nicTeamingPolicy = null, $supportsVlan = null, $usesServiceConsoleNic = null, $supportsNetworkHints = null, $maxPortGroupsPerVswitch = null, $vswitchConfigSupported = null, $vnicConfigSupported = null, $ipRouteConfigSupported = null, $dnsConfigSupported = null, $dhcpOnVnicSupported = null, $ipV6Supported = null) {
		$this->canSetPhysicalNicLinkSpeed = $canSetPhysicalNicLinkSpeed;
		$this->supportsNicTeaming = $supportsNicTeaming;
		$this->nicTeamingPolicy = $nicTeamingPolicy;
		$this->supportsVlan = $supportsVlan;
		$this->usesServiceConsoleNic = $usesServiceConsoleNic;
		$this->supportsNetworkHints = $supportsNetworkHints;
		$this->maxPortGroupsPerVswitch = $maxPortGroupsPerVswitch;
		$this->vswitchConfigSupported = $vswitchConfigSupported;
		$this->vnicConfigSupported = $vnicConfigSupported;
		$this->ipRouteConfigSupported = $ipRouteConfigSupported;
		$this->dnsConfigSupported = $dnsConfigSupported;
		$this->dhcpOnVnicSupported = $dhcpOnVnicSupported;
		$this->ipV6Supported = $ipV6Supported;
	}
}

class HostNetOffloadCapabilities {
	public $csumOffload; //boolean
	public $tcpSegmentation; //boolean
	public $zeroCopyXmit; //boolean

	function __construct($csumOffload = null, $tcpSegmentation = null, $zeroCopyXmit = null) {
		$this->csumOffload = $csumOffload;
		$this->tcpSegmentation = $tcpSegmentation;
		$this->zeroCopyXmit = $zeroCopyXmit;
	}
}

class HostNetworkConfigResult {
	public $vnicDevice; //string
	public $consoleVnicDevice; //string

	function __construct($vnicDevice = null, $consoleVnicDevice = null) {
		$this->vnicDevice = $vnicDevice;
		$this->consoleVnicDevice = $consoleVnicDevice;
	}
}

class HostNetworkConfig {
	public $vswitch; //HostVirtualSwitchConfig
	public $proxySwitch; //HostProxySwitchConfig
	public $portgroup; //HostPortGroupConfig
	public $pnic; //PhysicalNicConfig
	public $vnic; //HostVirtualNicConfig
	public $consoleVnic; //HostVirtualNicConfig
	public $dnsConfig; //HostDnsConfig
	public $ipRouteConfig; //HostIpRouteConfig
	public $consoleIpRouteConfig; //HostIpRouteConfig
	public $routeTableConfig; //HostIpRouteTableConfig
	public $dhcp; //HostDhcpServiceConfig
	public $nat; //HostNatServiceConfig
	public $ipV6Enabled; //boolean

	function __construct($vswitch = null, $proxySwitch = null, $portgroup = null, $pnic = null, $vnic = null, $consoleVnic = null, $dnsConfig = null, $ipRouteConfig = null, $consoleIpRouteConfig = null, $routeTableConfig = null, $dhcp = null, $nat = null, $ipV6Enabled = null) {
		$this->vswitch = $vswitch;
		$this->proxySwitch = $proxySwitch;
		$this->portgroup = $portgroup;
		$this->pnic = $pnic;
		$this->vnic = $vnic;
		$this->consoleVnic = $consoleVnic;
		$this->dnsConfig = $dnsConfig;
		$this->ipRouteConfig = $ipRouteConfig;
		$this->consoleIpRouteConfig = $consoleIpRouteConfig;
		$this->routeTableConfig = $routeTableConfig;
		$this->dhcp = $dhcp;
		$this->nat = $nat;
		$this->ipV6Enabled = $ipV6Enabled;
	}
}

class HostNetworkInfo {
	public $vswitch; //HostVirtualSwitch
	public $proxySwitch; //HostProxySwitch
	public $portgroup; //HostPortGroup
	public $pnic; //PhysicalNic
	public $vnic; //HostVirtualNic
	public $consoleVnic; //HostVirtualNic
	public $dnsConfig; //HostDnsConfig
	public $ipRouteConfig; //HostIpRouteConfig
	public $consoleIpRouteConfig; //HostIpRouteConfig
	public $routeTableInfo; //HostIpRouteTableInfo
	public $dhcp; //HostDhcpService
	public $nat; //HostNatService
	public $ipV6Enabled; //boolean
	public $atBootIpV6Enabled; //boolean

	function __construct($vswitch = null, $proxySwitch = null, $portgroup = null, $pnic = null, $vnic = null, $consoleVnic = null, $dnsConfig = null, $ipRouteConfig = null, $consoleIpRouteConfig = null, $routeTableInfo = null, $dhcp = null, $nat = null, $ipV6Enabled = null, $atBootIpV6Enabled = null) {
		$this->vswitch = $vswitch;
		$this->proxySwitch = $proxySwitch;
		$this->portgroup = $portgroup;
		$this->pnic = $pnic;
		$this->vnic = $vnic;
		$this->consoleVnic = $consoleVnic;
		$this->dnsConfig = $dnsConfig;
		$this->ipRouteConfig = $ipRouteConfig;
		$this->consoleIpRouteConfig = $consoleIpRouteConfig;
		$this->routeTableInfo = $routeTableInfo;
		$this->dhcp = $dhcp;
		$this->nat = $nat;
		$this->ipV6Enabled = $ipV6Enabled;
		$this->atBootIpV6Enabled = $atBootIpV6Enabled;
	}
}

class HostNetworkSecurityPolicy {
	public $allowPromiscuous; //boolean
	public $macChanges; //boolean
	public $forgedTransmits; //boolean

	function __construct($allowPromiscuous = null, $macChanges = null, $forgedTransmits = null) {
		$this->allowPromiscuous = $allowPromiscuous;
		$this->macChanges = $macChanges;
		$this->forgedTransmits = $forgedTransmits;
	}
}

class HostNetworkTrafficShapingPolicy {
	public $enabled; //boolean
	public $averageBandwidth; //long
	public $peakBandwidth; //long
	public $burstSize; //long

	function __construct($enabled = null, $averageBandwidth = null, $peakBandwidth = null, $burstSize = null) {
		$this->enabled = $enabled;
		$this->averageBandwidth = $averageBandwidth;
		$this->peakBandwidth = $peakBandwidth;
		$this->burstSize = $burstSize;
	}
}

class HostNicFailureCriteria {
	public $checkSpeed; //string
	public $speed; //int
	public $checkDuplex; //boolean
	public $fullDuplex; //boolean
	public $checkErrorPercent; //boolean
	public $percentage; //int
	public $checkBeacon; //boolean

	function __construct($checkSpeed = null, $speed = null, $checkDuplex = null, $fullDuplex = null, $checkErrorPercent = null, $percentage = null, $checkBeacon = null) {
		$this->checkSpeed = $checkSpeed;
		$this->speed = $speed;
		$this->checkDuplex = $checkDuplex;
		$this->fullDuplex = $fullDuplex;
		$this->checkErrorPercent = $checkErrorPercent;
		$this->percentage = $percentage;
		$this->checkBeacon = $checkBeacon;
	}
}

class HostNicOrderPolicy {
	public $activeNic; //string
	public $standbyNic; //string

	function __construct($activeNic = null, $standbyNic = null) {
		$this->activeNic = $activeNic;
		$this->standbyNic = $standbyNic;
	}
}

class HostNicTeamingPolicy {
	public $policy; //string
	public $reversePolicy; //boolean
	public $notifySwitches; //boolean
	public $rollingOrder; //boolean
	public $failureCriteria; //HostNicFailureCriteria
	public $nicOrder; //HostNicOrderPolicy

	function __construct($policy = null, $reversePolicy = null, $notifySwitches = null, $rollingOrder = null, $failureCriteria = null, $nicOrder = null) {
		$this->policy = $policy;
		$this->reversePolicy = $reversePolicy;
		$this->notifySwitches = $notifySwitches;
		$this->rollingOrder = $rollingOrder;
		$this->failureCriteria = $failureCriteria;
		$this->nicOrder = $nicOrder;
	}
}

class HostNetworkPolicy {
	public $security; //HostNetworkSecurityPolicy
	public $nicTeaming; //HostNicTeamingPolicy
	public $offloadPolicy; //HostNetOffloadCapabilities
	public $shapingPolicy; //HostNetworkTrafficShapingPolicy

	function __construct($security = null, $nicTeaming = null, $offloadPolicy = null, $shapingPolicy = null) {
		$this->security = $security;
		$this->nicTeaming = $nicTeaming;
		$this->offloadPolicy = $offloadPolicy;
		$this->shapingPolicy = $shapingPolicy;
	}
}

class HostNtpConfig {
	public $server; //string

	function __construct($server = null) {
		$this->server = $server;
	}
}

class HostNumericSensorInfo {
	public $name; //string
	public $healthState; //ElementDescription
	public $currentReading; //long
	public $unitModifier; //int
	public $baseUnits; //string
	public $rateUnits; //string
	public $sensorType; //string

	function __construct($name = null, $healthState = null, $currentReading = null, $unitModifier = null, $baseUnits = null, $rateUnits = null, $sensorType = null) {
		$this->name = $name;
		$this->healthState = $healthState;
		$this->currentReading = $currentReading;
		$this->unitModifier = $unitModifier;
		$this->baseUnits = $baseUnits;
		$this->rateUnits = $rateUnits;
		$this->sensorType = $sensorType;
	}
}

class ArrayOfHostNumericSensorInfo {
	public $HostNumericSensorInfo; //HostNumericSensorInfo

	function __construct($HostNumericSensorInfo = null) {
		$this->HostNumericSensorInfo = $HostNumericSensorInfo;
	}
}

class HostPatchManagerResult {
	public $version; //string
	public $status; //HostPatchManagerStatus
	public $xmlResult; //string

	function __construct($version = null, $status = null, $xmlResult = null) {
		$this->version = $version;
		$this->status = $status;
		$this->xmlResult = $xmlResult;
	}
}

class HostPatchManagerStatusPrerequisitePatch {
	public $id; //string
	public $installState; //string

	function __construct($id = null, $installState = null) {
		$this->id = $id;
		$this->installState = $installState;
	}
}

class ArrayOfHostPatchManagerStatusPrerequisitePatch {
	public $HostPatchManagerStatusPrerequisitePatch; //HostPatchManagerStatusPrerequisitePatch

	function __construct($HostPatchManagerStatusPrerequisitePatch = null) {
		$this->HostPatchManagerStatusPrerequisitePatch = $HostPatchManagerStatusPrerequisitePatch;
	}
}

class HostPatchManagerStatus {
	public $id; //string
	public $applicable; //boolean
	public $reason; //string
	public $integrity; //string
	public $installed; //boolean
	public $installState; //string
	public $prerequisitePatch; //HostPatchManagerStatusPrerequisitePatch
	public $restartRequired; //boolean
	public $reconnectRequired; //boolean
	public $vmOffRequired; //boolean
	public $supersededPatchIds; //string

	function __construct($id = null, $applicable = null, $reason = null, $integrity = null, $installed = null, $installState = null, $prerequisitePatch = null, $restartRequired = null, $reconnectRequired = null, $vmOffRequired = null, $supersededPatchIds = null) {
		$this->id = $id;
		$this->applicable = $applicable;
		$this->reason = $reason;
		$this->integrity = $integrity;
		$this->installed = $installed;
		$this->installState = $installState;
		$this->prerequisitePatch = $prerequisitePatch;
		$this->restartRequired = $restartRequired;
		$this->reconnectRequired = $reconnectRequired;
		$this->vmOffRequired = $vmOffRequired;
		$this->supersededPatchIds = $supersededPatchIds;
	}
}

class ArrayOfHostPatchManagerStatus {
	public $HostPatchManagerStatus; //HostPatchManagerStatus

	function __construct($HostPatchManagerStatus = null) {
		$this->HostPatchManagerStatus = $HostPatchManagerStatus;
	}
}

class HostPatchManagerLocator {
	public $url; //string
	public $proxy; //string

	function __construct($url = null, $proxy = null) {
		$this->url = $url;
		$this->proxy = $proxy;
	}
}

class HostPatchManagerPatchManagerOperationSpec {
	public $proxy; //string
	public $port; //int
	public $userName; //string
	public $password; //string
	public $cmdOption; //string

	function __construct($proxy = null, $port = null, $userName = null, $password = null, $cmdOption = null) {
		$this->proxy = $proxy;
		$this->port = $port;
		$this->userName = $userName;
		$this->password = $password;
		$this->cmdOption = $cmdOption;
	}
}

class HostPathSelectionPolicyOption {
	public $policy; //ElementDescription

	function __construct($policy = null) {
		$this->policy = $policy;
	}
}

class ArrayOfHostPathSelectionPolicyOption {
	public $HostPathSelectionPolicyOption; //HostPathSelectionPolicyOption

	function __construct($HostPathSelectionPolicyOption = null) {
		$this->HostPathSelectionPolicyOption = $HostPathSelectionPolicyOption;
	}
}

class HostPciDevice {
	public $id; //string
	public $classId; //short
	public $bus; //byte
	public $slot; //byte
	public $function; //byte
	public $vendorId; //short
	public $subVendorId; //short
	public $vendorName; //string
	public $deviceId; //short
	public $subDeviceId; //short
	public $parentBridge; //string
	public $deviceName; //string

	function __construct($id = null, $classId = null, $bus = null, $slot = null, $function = null, $vendorId = null, $subVendorId = null, $vendorName = null, $deviceId = null, $subDeviceId = null, $parentBridge = null, $deviceName = null) {
		$this->id = $id;
		$this->classId = $classId;
		$this->bus = $bus;
		$this->slot = $slot;
		$this->function = $function;
		$this->vendorId = $vendorId;
		$this->subVendorId = $subVendorId;
		$this->vendorName = $vendorName;
		$this->deviceId = $deviceId;
		$this->subDeviceId = $subDeviceId;
		$this->parentBridge = $parentBridge;
		$this->deviceName = $deviceName;
	}
}

class ArrayOfHostPciDevice {
	public $HostPciDevice; //HostPciDevice

	function __construct($HostPciDevice = null) {
		$this->HostPciDevice = $HostPciDevice;
	}
}

class HostPciPassthruConfig {
	public $id; //string
	public $passthruEnabled; //boolean

	function __construct($id = null, $passthruEnabled = null) {
		$this->id = $id;
		$this->passthruEnabled = $passthruEnabled;
	}
}

class ArrayOfHostPciPassthruConfig {
	public $HostPciPassthruConfig; //HostPciPassthruConfig

	function __construct($HostPciPassthruConfig = null) {
		$this->HostPciPassthruConfig = $HostPciPassthruConfig;
	}
}

class HostPciPassthruInfo {
	public $id; //string
	public $dependentDevice; //string
	public $passthruEnabled; //boolean
	public $passthruCapable; //boolean
	public $passthruActive; //boolean

	function __construct($id = null, $dependentDevice = null, $passthruEnabled = null, $passthruCapable = null, $passthruActive = null) {
		$this->id = $id;
		$this->dependentDevice = $dependentDevice;
		$this->passthruEnabled = $passthruEnabled;
		$this->passthruCapable = $passthruCapable;
		$this->passthruActive = $passthruActive;
	}
}

class ArrayOfHostPciPassthruInfo {
	public $HostPciPassthruInfo; //HostPciPassthruInfo

	function __construct($HostPciPassthruInfo = null) {
		$this->HostPciPassthruInfo = $HostPciPassthruInfo;
	}
}

class PhysicalNicSpec {
	public $ip; //HostIpConfig
	public $linkSpeed; //PhysicalNicLinkInfo

	function __construct($ip = null, $linkSpeed = null) {
		$this->ip = $ip;
		$this->linkSpeed = $linkSpeed;
	}
}

class PhysicalNicConfig {
	public $device; //string
	public $spec; //PhysicalNicSpec

	function __construct($device = null, $spec = null) {
		$this->device = $device;
		$this->spec = $spec;
	}
}

class ArrayOfPhysicalNicConfig {
	public $PhysicalNicConfig; //PhysicalNicConfig

	function __construct($PhysicalNicConfig = null) {
		$this->PhysicalNicConfig = $PhysicalNicConfig;
	}
}

class PhysicalNicLinkInfo {
	public $speedMb; //int
	public $duplex; //boolean

	function __construct($speedMb = null, $duplex = null) {
		$this->speedMb = $speedMb;
		$this->duplex = $duplex;
	}
}

class ArrayOfPhysicalNicLinkInfo {
	public $PhysicalNicLinkInfo; //PhysicalNicLinkInfo

	function __construct($PhysicalNicLinkInfo = null) {
		$this->PhysicalNicLinkInfo = $PhysicalNicLinkInfo;
	}
}

class PhysicalNicHint {
	public $vlanId; //int

	function __construct($vlanId = null) {
		$this->vlanId = $vlanId;
	}
}

class PhysicalNicIpHint {
	public $ipSubnet; //string

	function __construct($ipSubnet = null) {
		$this->ipSubnet = $ipSubnet;
	}
}

class ArrayOfPhysicalNicIpHint {
	public $PhysicalNicIpHint; //PhysicalNicIpHint

	function __construct($PhysicalNicIpHint = null) {
		$this->PhysicalNicIpHint = $PhysicalNicIpHint;
	}
}

class PhysicalNicNameHint {
	public $network; //string

	function __construct($network = null) {
		$this->network = $network;
	}
}

class ArrayOfPhysicalNicNameHint {
	public $PhysicalNicNameHint; //PhysicalNicNameHint

	function __construct($PhysicalNicNameHint = null) {
		$this->PhysicalNicNameHint = $PhysicalNicNameHint;
	}
}

class PhysicalNicHintInfo {
	public $device; //string
	public $subnet; //PhysicalNicIpHint
	public $network; //PhysicalNicNameHint
	public $connectedSwitchPort; //PhysicalNicCdpInfo
	public $lldpInfo; //LinkLayerDiscoveryProtocolInfo

	function __construct($device = null, $subnet = null, $network = null, $connectedSwitchPort = null, $lldpInfo = null) {
		$this->device = $device;
		$this->subnet = $subnet;
		$this->network = $network;
		$this->connectedSwitchPort = $connectedSwitchPort;
		$this->lldpInfo = $lldpInfo;
	}
}

class ArrayOfPhysicalNicHintInfo {
	public $PhysicalNicHintInfo; //PhysicalNicHintInfo

	function __construct($PhysicalNicHintInfo = null) {
		$this->PhysicalNicHintInfo = $PhysicalNicHintInfo;
	}
}

class PhysicalNicCdpDeviceCapability {
	public $router; //boolean
	public $transparentBridge; //boolean
	public $sourceRouteBridge; //boolean
	public $networkSwitch; //boolean
	public $host; //boolean
	public $igmpEnabled; //boolean
	public $repeater; //boolean

	function __construct($router = null, $transparentBridge = null, $sourceRouteBridge = null, $networkSwitch = null, $host = null, $igmpEnabled = null, $repeater = null) {
		$this->router = $router;
		$this->transparentBridge = $transparentBridge;
		$this->sourceRouteBridge = $sourceRouteBridge;
		$this->networkSwitch = $networkSwitch;
		$this->host = $host;
		$this->igmpEnabled = $igmpEnabled;
		$this->repeater = $repeater;
	}
}

class PhysicalNicCdpInfo {
	public $cdpVersion; //int
	public $timeout; //int
	public $ttl; //int
	public $samples; //int
	public $devId; //string
	public $address; //string
	public $portId; //string
	public $deviceCapability; //PhysicalNicCdpDeviceCapability
	public $softwareVersion; //string
	public $hardwarePlatform; //string
	public $ipPrefix; //string
	public $ipPrefixLen; //int
	public $vlan; //int
	public $fullDuplex; //boolean
	public $mtu; //int
	public $systemName; //string
	public $systemOID; //string
	public $mgmtAddr; //string
	public $location; //string

	function __construct($cdpVersion = null, $timeout = null, $ttl = null, $samples = null, $devId = null, $address = null, $portId = null, $deviceCapability = null, $softwareVersion = null, $hardwarePlatform = null, $ipPrefix = null, $ipPrefixLen = null, $vlan = null, $fullDuplex = null, $mtu = null, $systemName = null, $systemOID = null, $mgmtAddr = null, $location = null) {
		$this->cdpVersion = $cdpVersion;
		$this->timeout = $timeout;
		$this->ttl = $ttl;
		$this->samples = $samples;
		$this->devId = $devId;
		$this->address = $address;
		$this->portId = $portId;
		$this->deviceCapability = $deviceCapability;
		$this->softwareVersion = $softwareVersion;
		$this->hardwarePlatform = $hardwarePlatform;
		$this->ipPrefix = $ipPrefix;
		$this->ipPrefixLen = $ipPrefixLen;
		$this->vlan = $vlan;
		$this->fullDuplex = $fullDuplex;
		$this->mtu = $mtu;
		$this->systemName = $systemName;
		$this->systemOID = $systemOID;
		$this->mgmtAddr = $mgmtAddr;
		$this->location = $location;
	}
}

class LinkLayerDiscoveryProtocolInfo {
	public $chassisId; //string
	public $portId; //string
	public $timeToLive; //int
	public $parameter; //KeyAnyValue

	function __construct($chassisId = null, $portId = null, $timeToLive = null, $parameter = null) {
		$this->chassisId = $chassisId;
		$this->portId = $portId;
		$this->timeToLive = $timeToLive;
		$this->parameter = $parameter;
	}
}

class PhysicalNic {
	public $key; //string
	public $device; //string
	public $pci; //string
	public $driver; //string
	public $linkSpeed; //PhysicalNicLinkInfo
	public $validLinkSpecification; //PhysicalNicLinkInfo
	public $spec; //PhysicalNicSpec
	public $wakeOnLanSupported; //boolean
	public $mac; //string
	public $fcoeConfiguration; //FcoeConfig
	public $vmDirectPathGen2Supported; //boolean
	public $vmDirectPathGen2SupportedMode; //string
	public $resourcePoolSchedulerAllowed; //boolean
	public $resourcePoolSchedulerDisallowedReason; //string
	public $autoNegotiateSupported; //boolean

	function __construct($key = null, $device = null, $pci = null, $driver = null, $linkSpeed = null, $validLinkSpecification = null, $spec = null, $wakeOnLanSupported = null, $mac = null, $fcoeConfiguration = null, $vmDirectPathGen2Supported = null, $vmDirectPathGen2SupportedMode = null, $resourcePoolSchedulerAllowed = null, $resourcePoolSchedulerDisallowedReason = null, $autoNegotiateSupported = null) {
		$this->key = $key;
		$this->device = $device;
		$this->pci = $pci;
		$this->driver = $driver;
		$this->linkSpeed = $linkSpeed;
		$this->validLinkSpecification = $validLinkSpecification;
		$this->spec = $spec;
		$this->wakeOnLanSupported = $wakeOnLanSupported;
		$this->mac = $mac;
		$this->fcoeConfiguration = $fcoeConfiguration;
		$this->vmDirectPathGen2Supported = $vmDirectPathGen2Supported;
		$this->vmDirectPathGen2SupportedMode = $vmDirectPathGen2SupportedMode;
		$this->resourcePoolSchedulerAllowed = $resourcePoolSchedulerAllowed;
		$this->resourcePoolSchedulerDisallowedReason = $resourcePoolSchedulerDisallowedReason;
		$this->autoNegotiateSupported = $autoNegotiateSupported;
	}
}

class ArrayOfPhysicalNic {
	public $PhysicalNic; //PhysicalNic

	function __construct($PhysicalNic = null) {
		$this->PhysicalNic = $PhysicalNic;
	}
}

class HostPlugStoreTopologyAdapter {
	public $key; //string
	public $adapter; //string
	public $path; //string

	function __construct($key = null, $adapter = null, $path = null) {
		$this->key = $key;
		$this->adapter = $adapter;
		$this->path = $path;
	}
}

class ArrayOfHostPlugStoreTopologyAdapter {
	public $HostPlugStoreTopologyAdapter; //HostPlugStoreTopologyAdapter

	function __construct($HostPlugStoreTopologyAdapter = null) {
		$this->HostPlugStoreTopologyAdapter = $HostPlugStoreTopologyAdapter;
	}
}

class HostPlugStoreTopologyPath {
	public $key; //string
	public $name; //string
	public $channelNumber; //int
	public $targetNumber; //int
	public $lunNumber; //int
	public $adapter; //string
	public $target; //string
	public $device; //string

	function __construct($key = null, $name = null, $channelNumber = null, $targetNumber = null, $lunNumber = null, $adapter = null, $target = null, $device = null) {
		$this->key = $key;
		$this->name = $name;
		$this->channelNumber = $channelNumber;
		$this->targetNumber = $targetNumber;
		$this->lunNumber = $lunNumber;
		$this->adapter = $adapter;
		$this->target = $target;
		$this->device = $device;
	}
}

class ArrayOfHostPlugStoreTopologyPath {
	public $HostPlugStoreTopologyPath; //HostPlugStoreTopologyPath

	function __construct($HostPlugStoreTopologyPath = null) {
		$this->HostPlugStoreTopologyPath = $HostPlugStoreTopologyPath;
	}
}

class HostPlugStoreTopologyDevice {
	public $key; //string
	public $lun; //string
	public $path; //string

	function __construct($key = null, $lun = null, $path = null) {
		$this->key = $key;
		$this->lun = $lun;
		$this->path = $path;
	}
}

class ArrayOfHostPlugStoreTopologyDevice {
	public $HostPlugStoreTopologyDevice; //HostPlugStoreTopologyDevice

	function __construct($HostPlugStoreTopologyDevice = null) {
		$this->HostPlugStoreTopologyDevice = $HostPlugStoreTopologyDevice;
	}
}

class HostPlugStoreTopologyPlugin {
	public $key; //string
	public $name; //string
	public $device; //string
	public $claimedPath; //string

	function __construct($key = null, $name = null, $device = null, $claimedPath = null) {
		$this->key = $key;
		$this->name = $name;
		$this->device = $device;
		$this->claimedPath = $claimedPath;
	}
}

class ArrayOfHostPlugStoreTopologyPlugin {
	public $HostPlugStoreTopologyPlugin; //HostPlugStoreTopologyPlugin

	function __construct($HostPlugStoreTopologyPlugin = null) {
		$this->HostPlugStoreTopologyPlugin = $HostPlugStoreTopologyPlugin;
	}
}

class HostPlugStoreTopologyTarget {
	public $key; //string
	public $transport; //HostTargetTransport

	function __construct($key = null, $transport = null) {
		$this->key = $key;
		$this->transport = $transport;
	}
}

class ArrayOfHostPlugStoreTopologyTarget {
	public $HostPlugStoreTopologyTarget; //HostPlugStoreTopologyTarget

	function __construct($HostPlugStoreTopologyTarget = null) {
		$this->HostPlugStoreTopologyTarget = $HostPlugStoreTopologyTarget;
	}
}

class HostPlugStoreTopology {
	public $adapter; //HostPlugStoreTopologyAdapter
	public $path; //HostPlugStoreTopologyPath
	public $target; //HostPlugStoreTopologyTarget
	public $device; //HostPlugStoreTopologyDevice
	public $plugin; //HostPlugStoreTopologyPlugin

	function __construct($adapter = null, $path = null, $target = null, $device = null, $plugin = null) {
		$this->adapter = $adapter;
		$this->path = $path;
		$this->target = $target;
		$this->device = $device;
		$this->plugin = $plugin;
	}
}

class HostPortGroupSpec {
	public $name; //string
	public $vlanId; //int
	public $vswitchName; //string
	public $policy; //HostNetworkPolicy

	function __construct($name = null, $vlanId = null, $vswitchName = null, $policy = null) {
		$this->name = $name;
		$this->vlanId = $vlanId;
		$this->vswitchName = $vswitchName;
		$this->policy = $policy;
	}
}

class HostPortGroupConfig {
	public $changeOperation; //string
	public $spec; //HostPortGroupSpec

	function __construct($changeOperation = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->spec = $spec;
	}
}

class ArrayOfHostPortGroupConfig {
	public $HostPortGroupConfig; //HostPortGroupConfig

	function __construct($HostPortGroupConfig = null) {
		$this->HostPortGroupConfig = $HostPortGroupConfig;
	}
}

class HostPortGroupPort {
	public $key; //string
	public $mac; //string
	public $type; //string

	function __construct($key = null, $mac = null, $type = null) {
		$this->key = $key;
		$this->mac = $mac;
		$this->type = $type;
	}
}

class ArrayOfHostPortGroupPort {
	public $HostPortGroupPort; //HostPortGroupPort

	function __construct($HostPortGroupPort = null) {
		$this->HostPortGroupPort = $HostPortGroupPort;
	}
}

class HostPortGroup {
	public $key; //string
	public $port; //HostPortGroupPort
	public $vswitch; //string
	public $computedPolicy; //HostNetworkPolicy
	public $spec; //HostPortGroupSpec

	function __construct($key = null, $port = null, $vswitch = null, $computedPolicy = null, $spec = null) {
		$this->key = $key;
		$this->port = $port;
		$this->vswitch = $vswitch;
		$this->computedPolicy = $computedPolicy;
		$this->spec = $spec;
	}
}

class ArrayOfHostPortGroup {
	public $HostPortGroup; //HostPortGroup

	function __construct($HostPortGroup = null) {
		$this->HostPortGroup = $HostPortGroup;
	}
}

class HostPowerPolicy {
	public $key; //int
	public $name; //string
	public $shortName; //string
	public $description; //string

	function __construct($key = null, $name = null, $shortName = null, $description = null) {
		$this->key = $key;
		$this->name = $name;
		$this->shortName = $shortName;
		$this->description = $description;
	}
}

class ArrayOfHostPowerPolicy {
	public $HostPowerPolicy; //HostPowerPolicy

	function __construct($HostPowerPolicy = null) {
		$this->HostPowerPolicy = $HostPowerPolicy;
	}
}

class PowerSystemCapability {
	public $availablePolicy; //HostPowerPolicy

	function __construct($availablePolicy = null) {
		$this->availablePolicy = $availablePolicy;
	}
}

class PowerSystemInfo {
	public $currentPolicy; //HostPowerPolicy

	function __construct($currentPolicy = null) {
		$this->currentPolicy = $currentPolicy;
	}
}

class HostResignatureRescanResult {
	public $rescan; //HostVmfsRescanResult
	public $result; //ManagedObjectReference

	function __construct($rescan = null, $result = null) {
		$this->rescan = $rescan;
		$this->result = $result;
	}
}

class HostFirewallRulesetIpNetwork {
	public $network; //string
	public $prefixLength; //int

	function __construct($network = null, $prefixLength = null) {
		$this->network = $network;
		$this->prefixLength = $prefixLength;
	}
}

class ArrayOfHostFirewallRulesetIpNetwork {
	public $HostFirewallRulesetIpNetwork; //HostFirewallRulesetIpNetwork

	function __construct($HostFirewallRulesetIpNetwork = null) {
		$this->HostFirewallRulesetIpNetwork = $HostFirewallRulesetIpNetwork;
	}
}

class HostFirewallRulesetIpList {
	public $ipAddress; //string
	public $ipNetwork; //HostFirewallRulesetIpNetwork
	public $allIp; //boolean

	function __construct($ipAddress = null, $ipNetwork = null, $allIp = null) {
		$this->ipAddress = $ipAddress;
		$this->ipNetwork = $ipNetwork;
		$this->allIp = $allIp;
	}
}

class HostFirewallRulesetRulesetSpec {
	public $allowedHosts; //HostFirewallRulesetIpList

	function __construct($allowedHosts = null) {
		$this->allowedHosts = $allowedHosts;
	}
}

class HostFirewallRule {
	public $port; //int
	public $endPort; //int
	public $direction; //HostFirewallRuleDirection
	public $portType; //HostFirewallRulePortType
	public $protocol; //string

	function __construct($port = null, $endPort = null, $direction = null, $portType = null, $protocol = null) {
		$this->port = $port;
		$this->endPort = $endPort;
		$this->direction = $direction;
		$this->portType = $portType;
		$this->protocol = $protocol;
	}
}

class ArrayOfHostFirewallRule {
	public $HostFirewallRule; //HostFirewallRule

	function __construct($HostFirewallRule = null) {
		$this->HostFirewallRule = $HostFirewallRule;
	}
}

class HostFirewallRuleset {
	public $key; //string
	public $label; //string
	public $required; //boolean
	public $rule; //HostFirewallRule
	public $service; //string
	public $enabled; //boolean
	public $allowedHosts; //HostFirewallRulesetIpList

	function __construct($key = null, $label = null, $required = null, $rule = null, $service = null, $enabled = null, $allowedHosts = null) {
		$this->key = $key;
		$this->label = $label;
		$this->required = $required;
		$this->rule = $rule;
		$this->service = $service;
		$this->enabled = $enabled;
		$this->allowedHosts = $allowedHosts;
	}
}

class ArrayOfHostFirewallRuleset {
	public $HostFirewallRuleset; //HostFirewallRuleset

	function __construct($HostFirewallRuleset = null) {
		$this->HostFirewallRuleset = $HostFirewallRuleset;
	}
}

class HostRuntimeInfo {
	public $connectionState; //HostSystemConnectionState
	public $powerState; //HostSystemPowerState
	public $standbyMode; //string
	public $inMaintenanceMode; //boolean
	public $bootTime; //dateTime
	public $healthSystemRuntime; //HealthSystemRuntime
	public $dasHostState; //ClusterDasFdmHostState
	public $tpmPcrValues; //HostTpmDigestInfo

	function __construct($connectionState = null, $powerState = null, $standbyMode = null, $inMaintenanceMode = null, $bootTime = null, $healthSystemRuntime = null, $dasHostState = null, $tpmPcrValues = null) {
		$this->connectionState = $connectionState;
		$this->powerState = $powerState;
		$this->standbyMode = $standbyMode;
		$this->inMaintenanceMode = $inMaintenanceMode;
		$this->bootTime = $bootTime;
		$this->healthSystemRuntime = $healthSystemRuntime;
		$this->dasHostState = $dasHostState;
		$this->tpmPcrValues = $tpmPcrValues;
	}
}

class HostScsiDiskPartition {
	public $diskName; //string
	public $partition; //int

	function __construct($diskName = null, $partition = null) {
		$this->diskName = $diskName;
		$this->partition = $partition;
	}
}

class ArrayOfHostScsiDiskPartition {
	public $HostScsiDiskPartition; //HostScsiDiskPartition

	function __construct($HostScsiDiskPartition = null) {
		$this->HostScsiDiskPartition = $HostScsiDiskPartition;
	}
}

class HostScsiDisk {
	public $capacity; //HostDiskDimensionsLba
	public $devicePath; //string
	public $ssd; //boolean

	function __construct($capacity = null, $devicePath = null, $ssd = null) {
		$this->capacity = $capacity;
		$this->devicePath = $devicePath;
		$this->ssd = $ssd;
	}
}

class ArrayOfHostScsiDisk {
	public $HostScsiDisk; //HostScsiDisk

	function __construct($HostScsiDisk = null) {
		$this->HostScsiDisk = $HostScsiDisk;
	}
}

class ScsiLunCapabilities {
	public $updateDisplayNameSupported; //boolean

	function __construct($updateDisplayNameSupported = null) {
		$this->updateDisplayNameSupported = $updateDisplayNameSupported;
	}
}

class ScsiLunDurableName {
	public $namespace; //string
	public $namespaceId; //byte
	public $data; //byte

	function __construct($namespace = null, $namespaceId = null, $data = null) {
		$this->namespace = $namespace;
		$this->namespaceId = $namespaceId;
		$this->data = $data;
	}
}

class ArrayOfScsiLunDurableName {
	public $ScsiLunDurableName; //ScsiLunDurableName

	function __construct($ScsiLunDurableName = null) {
		$this->ScsiLunDurableName = $ScsiLunDurableName;
	}
}

class ScsiLunDescriptor {
	public $quality; //string
	public $id; //string

	function __construct($quality = null, $id = null) {
		$this->quality = $quality;
		$this->id = $id;
	}
}

class ArrayOfScsiLunDescriptor {
	public $ScsiLunDescriptor; //ScsiLunDescriptor

	function __construct($ScsiLunDescriptor = null) {
		$this->ScsiLunDescriptor = $ScsiLunDescriptor;
	}
}

class ScsiLun {
	public $key; //string
	public $uuid; //string
	public $descriptor; //ScsiLunDescriptor
	public $canonicalName; //string
	public $displayName; //string
	public $lunType; //string
	public $vendor; //string
	public $model; //string
	public $revision; //string
	public $scsiLevel; //int
	public $serialNumber; //string
	public $durableName; //ScsiLunDurableName
	public $alternateName; //ScsiLunDurableName
	public $standardInquiry; //byte
	public $queueDepth; //int
	public $operationalState; //string
	public $capabilities; //ScsiLunCapabilities
	public $vStorageSupport; //string

	function __construct($key = null, $uuid = null, $descriptor = null, $canonicalName = null, $displayName = null, $lunType = null, $vendor = null, $model = null, $revision = null, $scsiLevel = null, $serialNumber = null, $durableName = null, $alternateName = null, $standardInquiry = null, $queueDepth = null, $operationalState = null, $capabilities = null, $vStorageSupport = null) {
		$this->key = $key;
		$this->uuid = $uuid;
		$this->descriptor = $descriptor;
		$this->canonicalName = $canonicalName;
		$this->displayName = $displayName;
		$this->lunType = $lunType;
		$this->vendor = $vendor;
		$this->model = $model;
		$this->revision = $revision;
		$this->scsiLevel = $scsiLevel;
		$this->serialNumber = $serialNumber;
		$this->durableName = $durableName;
		$this->alternateName = $alternateName;
		$this->standardInquiry = $standardInquiry;
		$this->queueDepth = $queueDepth;
		$this->operationalState = $operationalState;
		$this->capabilities = $capabilities;
		$this->vStorageSupport = $vStorageSupport;
	}
}

class ArrayOfScsiLun {
	public $ScsiLun; //ScsiLun

	function __construct($ScsiLun = null) {
		$this->ScsiLun = $ScsiLun;
	}
}

class HostScsiTopologyInterface {
	public $key; //string
	public $adapter; //string
	public $target; //HostScsiTopologyTarget

	function __construct($key = null, $adapter = null, $target = null) {
		$this->key = $key;
		$this->adapter = $adapter;
		$this->target = $target;
	}
}

class ArrayOfHostScsiTopologyInterface {
	public $HostScsiTopologyInterface; //HostScsiTopologyInterface

	function __construct($HostScsiTopologyInterface = null) {
		$this->HostScsiTopologyInterface = $HostScsiTopologyInterface;
	}
}

class HostScsiTopologyTarget {
	public $key; //string
	public $target; //int
	public $lun; //HostScsiTopologyLun
	public $transport; //HostTargetTransport

	function __construct($key = null, $target = null, $lun = null, $transport = null) {
		$this->key = $key;
		$this->target = $target;
		$this->lun = $lun;
		$this->transport = $transport;
	}
}

class ArrayOfHostScsiTopologyTarget {
	public $HostScsiTopologyTarget; //HostScsiTopologyTarget

	function __construct($HostScsiTopologyTarget = null) {
		$this->HostScsiTopologyTarget = $HostScsiTopologyTarget;
	}
}

class HostScsiTopologyLun {
	public $key; //string
	public $lun; //int
	public $scsiLun; //string

	function __construct($key = null, $lun = null, $scsiLun = null) {
		$this->key = $key;
		$this->lun = $lun;
		$this->scsiLun = $scsiLun;
	}
}

class ArrayOfHostScsiTopologyLun {
	public $HostScsiTopologyLun; //HostScsiTopologyLun

	function __construct($HostScsiTopologyLun = null) {
		$this->HostScsiTopologyLun = $HostScsiTopologyLun;
	}
}

class HostScsiTopology {
	public $adapter; //HostScsiTopologyInterface

	function __construct($adapter = null) {
		$this->adapter = $adapter;
	}
}

class HostSecuritySpec {
	public $adminPassword; //string
	public $removePermission; //Permission
	public $addPermission; //Permission

	function __construct($adminPassword = null, $removePermission = null, $addPermission = null) {
		$this->adminPassword = $adminPassword;
		$this->removePermission = $removePermission;
		$this->addPermission = $addPermission;
	}
}

class HostServiceSourcePackage {
	public $sourcePackageName; //string
	public $description; //string

	function __construct($sourcePackageName = null, $description = null) {
		$this->sourcePackageName = $sourcePackageName;
		$this->description = $description;
	}
}

class HostService {
	public $key; //string
	public $label; //string
	public $required; //boolean
	public $uninstallable; //boolean
	public $running; //boolean
	public $ruleset; //string
	public $policy; //string
	public $sourcePackage; //HostServiceSourcePackage

	function __construct($key = null, $label = null, $required = null, $uninstallable = null, $running = null, $ruleset = null, $policy = null, $sourcePackage = null) {
		$this->key = $key;
		$this->label = $label;
		$this->required = $required;
		$this->uninstallable = $uninstallable;
		$this->running = $running;
		$this->ruleset = $ruleset;
		$this->policy = $policy;
		$this->sourcePackage = $sourcePackage;
	}
}

class ArrayOfHostService {
	public $HostService; //HostService

	function __construct($HostService = null) {
		$this->HostService = $HostService;
	}
}

class HostServiceConfig {
	public $serviceId; //string
	public $startupPolicy; //string

	function __construct($serviceId = null, $startupPolicy = null) {
		$this->serviceId = $serviceId;
		$this->startupPolicy = $startupPolicy;
	}
}

class ArrayOfHostServiceConfig {
	public $HostServiceConfig; //HostServiceConfig

	function __construct($HostServiceConfig = null) {
		$this->HostServiceConfig = $HostServiceConfig;
	}
}

class HostServiceInfo {
	public $service; //HostService

	function __construct($service = null) {
		$this->service = $service;
	}
}

class HostSnmpDestination {
	public $hostName; //string
	public $port; //int
	public $community; //string

	function __construct($hostName = null, $port = null, $community = null) {
		$this->hostName = $hostName;
		$this->port = $port;
		$this->community = $community;
	}
}

class ArrayOfHostSnmpDestination {
	public $HostSnmpDestination; //HostSnmpDestination

	function __construct($HostSnmpDestination = null) {
		$this->HostSnmpDestination = $HostSnmpDestination;
	}
}

class HostSnmpConfigSpec {
	public $enabled; //boolean
	public $port; //int
	public $readOnlyCommunities; //string
	public $trapTargets; //HostSnmpDestination
	public $option; //KeyValue

	function __construct($enabled = null, $port = null, $readOnlyCommunities = null, $trapTargets = null, $option = null) {
		$this->enabled = $enabled;
		$this->port = $port;
		$this->readOnlyCommunities = $readOnlyCommunities;
		$this->trapTargets = $trapTargets;
		$this->option = $option;
	}
}

class HostSnmpSystemAgentLimits {
	public $maxReadOnlyCommunities; //int
	public $maxTrapDestinations; //int
	public $maxCommunityLength; //int
	public $maxBufferSize; //int
	public $capability; //HostSnmpAgentCapability

	function __construct($maxReadOnlyCommunities = null, $maxTrapDestinations = null, $maxCommunityLength = null, $maxBufferSize = null, $capability = null) {
		$this->maxReadOnlyCommunities = $maxReadOnlyCommunities;
		$this->maxTrapDestinations = $maxTrapDestinations;
		$this->maxCommunityLength = $maxCommunityLength;
		$this->maxBufferSize = $maxBufferSize;
		$this->capability = $capability;
	}
}

class HostSslThumbprintInfo {
	public $principal; //string
	public $ownerTag; //string
	public $sslThumbprints; //string

	function __construct($principal = null, $ownerTag = null, $sslThumbprints = null) {
		$this->principal = $principal;
		$this->ownerTag = $ownerTag;
		$this->sslThumbprints = $sslThumbprints;
	}
}

class ArrayOfHostSslThumbprintInfo {
	public $HostSslThumbprintInfo; //HostSslThumbprintInfo

	function __construct($HostSslThumbprintInfo = null) {
		$this->HostSslThumbprintInfo = $HostSslThumbprintInfo;
	}
}

class HostStorageArrayTypePolicyOption {
	public $policy; //ElementDescription

	function __construct($policy = null) {
		$this->policy = $policy;
	}
}

class ArrayOfHostStorageArrayTypePolicyOption {
	public $HostStorageArrayTypePolicyOption; //HostStorageArrayTypePolicyOption

	function __construct($HostStorageArrayTypePolicyOption = null) {
		$this->HostStorageArrayTypePolicyOption = $HostStorageArrayTypePolicyOption;
	}
}

class HostStorageDeviceInfo {
	public $hostBusAdapter; //HostHostBusAdapter
	public $scsiLun; //ScsiLun
	public $scsiTopology; //HostScsiTopology
	public $multipathInfo; //HostMultipathInfo
	public $plugStoreTopology; //HostPlugStoreTopology
	public $softwareInternetScsiEnabled; //boolean

	function __construct($hostBusAdapter = null, $scsiLun = null, $scsiTopology = null, $multipathInfo = null, $plugStoreTopology = null, $softwareInternetScsiEnabled = null) {
		$this->hostBusAdapter = $hostBusAdapter;
		$this->scsiLun = $scsiLun;
		$this->scsiTopology = $scsiTopology;
		$this->multipathInfo = $multipathInfo;
		$this->plugStoreTopology = $plugStoreTopology;
		$this->softwareInternetScsiEnabled = $softwareInternetScsiEnabled;
	}
}

class HostHardwareSummary {
	public $vendor; //string
	public $model; //string
	public $uuid; //string
	public $otherIdentifyingInfo; //HostSystemIdentificationInfo
	public $memorySize; //long
	public $cpuModel; //string
	public $cpuMhz; //int
	public $numCpuPkgs; //short
	public $numCpuCores; //short
	public $numCpuThreads; //short
	public $numNics; //int
	public $numHBAs; //int

	function __construct($vendor = null, $model = null, $uuid = null, $otherIdentifyingInfo = null, $memorySize = null, $cpuModel = null, $cpuMhz = null, $numCpuPkgs = null, $numCpuCores = null, $numCpuThreads = null, $numNics = null, $numHBAs = null) {
		$this->vendor = $vendor;
		$this->model = $model;
		$this->uuid = $uuid;
		$this->otherIdentifyingInfo = $otherIdentifyingInfo;
		$this->memorySize = $memorySize;
		$this->cpuModel = $cpuModel;
		$this->cpuMhz = $cpuMhz;
		$this->numCpuPkgs = $numCpuPkgs;
		$this->numCpuCores = $numCpuCores;
		$this->numCpuThreads = $numCpuThreads;
		$this->numNics = $numNics;
		$this->numHBAs = $numHBAs;
	}
}

class HostListSummaryQuickStats {
	public $overallCpuUsage; //int
	public $overallMemoryUsage; //int
	public $distributedCpuFairness; //int
	public $distributedMemoryFairness; //int
	public $uptime; //int

	function __construct($overallCpuUsage = null, $overallMemoryUsage = null, $distributedCpuFairness = null, $distributedMemoryFairness = null, $uptime = null) {
		$this->overallCpuUsage = $overallCpuUsage;
		$this->overallMemoryUsage = $overallMemoryUsage;
		$this->distributedCpuFairness = $distributedCpuFairness;
		$this->distributedMemoryFairness = $distributedMemoryFairness;
		$this->uptime = $uptime;
	}
}

class HostConfigSummary {
	public $name; //string
	public $port; //int
	public $sslThumbprint; //string
	public $product; //AboutInfo
	public $vmotionEnabled; //boolean
	public $faultToleranceEnabled; //boolean
	public $featureVersion; //HostFeatureVersionInfo
	public $agentVmDatastore; //ManagedObjectReference
	public $agentVmNetwork; //ManagedObjectReference

	function __construct($name = null, $port = null, $sslThumbprint = null, $product = null, $vmotionEnabled = null, $faultToleranceEnabled = null, $featureVersion = null, $agentVmDatastore = null, $agentVmNetwork = null) {
		$this->name = $name;
		$this->port = $port;
		$this->sslThumbprint = $sslThumbprint;
		$this->product = $product;
		$this->vmotionEnabled = $vmotionEnabled;
		$this->faultToleranceEnabled = $faultToleranceEnabled;
		$this->featureVersion = $featureVersion;
		$this->agentVmDatastore = $agentVmDatastore;
		$this->agentVmNetwork = $agentVmNetwork;
	}
}

class HostListSummary {
	public $host; //ManagedObjectReference
	public $hardware; //HostHardwareSummary
	public $runtime; //HostRuntimeInfo
	public $config; //HostConfigSummary
	public $quickStats; //HostListSummaryQuickStats
	public $overallStatus; //ManagedEntityStatus
	public $rebootRequired; //boolean
	public $customValue; //CustomFieldValue
	public $managementServerIp; //string
	public $maxEVCModeKey; //string
	public $currentEVCModeKey; //string

	function __construct($host = null, $hardware = null, $runtime = null, $config = null, $quickStats = null, $overallStatus = null, $rebootRequired = null, $customValue = null, $managementServerIp = null, $maxEVCModeKey = null, $currentEVCModeKey = null) {
		$this->host = $host;
		$this->hardware = $hardware;
		$this->runtime = $runtime;
		$this->config = $config;
		$this->quickStats = $quickStats;
		$this->overallStatus = $overallStatus;
		$this->rebootRequired = $rebootRequired;
		$this->customValue = $customValue;
		$this->managementServerIp = $managementServerIp;
		$this->maxEVCModeKey = $maxEVCModeKey;
		$this->currentEVCModeKey = $currentEVCModeKey;
	}
}

class HostSystemHealthInfo {
	public $numericSensorInfo; //HostNumericSensorInfo

	function __construct($numericSensorInfo = null) {
		$this->numericSensorInfo = $numericSensorInfo;
	}
}

class HostSystemIdentificationInfo {
	public $identifierValue; //string
	public $identifierType; //ElementDescription

	function __construct($identifierValue = null, $identifierType = null) {
		$this->identifierValue = $identifierValue;
		$this->identifierType = $identifierType;
	}
}

class ArrayOfHostSystemIdentificationInfo {
	public $HostSystemIdentificationInfo; //HostSystemIdentificationInfo

	function __construct($HostSystemIdentificationInfo = null) {
		$this->HostSystemIdentificationInfo = $HostSystemIdentificationInfo;
	}
}

class HostSystemResourceInfo {
	public $key; //string
	public $config; //ResourceConfigSpec
	public $child; //HostSystemResourceInfo

	function __construct($key = null, $config = null, $child = null) {
		$this->key = $key;
		$this->config = $config;
		$this->child = $child;
	}
}

class ArrayOfHostSystemResourceInfo {
	public $HostSystemResourceInfo; //HostSystemResourceInfo

	function __construct($HostSystemResourceInfo = null) {
		$this->HostSystemResourceInfo = $HostSystemResourceInfo;
	}
}

class HostTargetTransport {
}

class HostParallelScsiTargetTransport {
}

class HostBlockAdapterTargetTransport {
}

class HostFibreChannelTargetTransport {
	public $portWorldWideName; //long
	public $nodeWorldWideName; //long

	function __construct($portWorldWideName = null, $nodeWorldWideName = null) {
		$this->portWorldWideName = $portWorldWideName;
		$this->nodeWorldWideName = $nodeWorldWideName;
	}
}

class HostInternetScsiTargetTransport {
	public $iScsiName; //string
	public $iScsiAlias; //string
	public $address; //string

	function __construct($iScsiName = null, $iScsiAlias = null, $address = null) {
		$this->iScsiName = $iScsiName;
		$this->iScsiAlias = $iScsiAlias;
		$this->address = $address;
	}
}

class HostFibreChannelOverEthernetTargetTransport {
	public $vnportMac; //string
	public $fcfMac; //string
	public $vlanId; //int

	function __construct($vnportMac = null, $fcfMac = null, $vlanId = null) {
		$this->vnportMac = $vnportMac;
		$this->fcfMac = $fcfMac;
		$this->vlanId = $vlanId;
	}
}

class HostDigestInfo {
	public $digestMethod; //string
	public $digestValue; //byte
	public $objectName; //string

	function __construct($digestMethod = null, $digestValue = null, $objectName = null) {
		$this->digestMethod = $digestMethod;
		$this->digestValue = $digestValue;
		$this->objectName = $objectName;
	}
}

class HostTpmDigestInfo {
	public $pcrNumber; //int

	function __construct($pcrNumber = null) {
		$this->pcrNumber = $pcrNumber;
	}
}

class ArrayOfHostTpmDigestInfo {
	public $HostTpmDigestInfo; //HostTpmDigestInfo

	function __construct($HostTpmDigestInfo = null) {
		$this->HostTpmDigestInfo = $HostTpmDigestInfo;
	}
}

class HostUnresolvedVmfsExtent {
	public $device; //HostScsiDiskPartition
	public $devicePath; //string
	public $vmfsUuid; //string
	public $isHeadExtent; //boolean
	public $ordinal; //int
	public $startBlock; //int
	public $endBlock; //int
	public $reason; //string

	function __construct($device = null, $devicePath = null, $vmfsUuid = null, $isHeadExtent = null, $ordinal = null, $startBlock = null, $endBlock = null, $reason = null) {
		$this->device = $device;
		$this->devicePath = $devicePath;
		$this->vmfsUuid = $vmfsUuid;
		$this->isHeadExtent = $isHeadExtent;
		$this->ordinal = $ordinal;
		$this->startBlock = $startBlock;
		$this->endBlock = $endBlock;
		$this->reason = $reason;
	}
}

class ArrayOfHostUnresolvedVmfsExtent {
	public $HostUnresolvedVmfsExtent; //HostUnresolvedVmfsExtent

	function __construct($HostUnresolvedVmfsExtent = null) {
		$this->HostUnresolvedVmfsExtent = $HostUnresolvedVmfsExtent;
	}
}

class HostUnresolvedVmfsResignatureSpec {
	public $extentDevicePath; //string

	function __construct($extentDevicePath = null) {
		$this->extentDevicePath = $extentDevicePath;
	}
}

class HostUnresolvedVmfsResolutionResult {
	public $spec; //HostUnresolvedVmfsResolutionSpec
	public $vmfs; //HostVmfsVolume
	public $fault; //LocalizedMethodFault

	function __construct($spec = null, $vmfs = null, $fault = null) {
		$this->spec = $spec;
		$this->vmfs = $vmfs;
		$this->fault = $fault;
	}
}

class ArrayOfHostUnresolvedVmfsResolutionResult {
	public $HostUnresolvedVmfsResolutionResult; //HostUnresolvedVmfsResolutionResult

	function __construct($HostUnresolvedVmfsResolutionResult = null) {
		$this->HostUnresolvedVmfsResolutionResult = $HostUnresolvedVmfsResolutionResult;
	}
}

class HostUnresolvedVmfsResolutionSpec {
	public $extentDevicePath; //string
	public $uuidResolution; //string

	function __construct($extentDevicePath = null, $uuidResolution = null) {
		$this->extentDevicePath = $extentDevicePath;
		$this->uuidResolution = $uuidResolution;
	}
}

class ArrayOfHostUnresolvedVmfsResolutionSpec {
	public $HostUnresolvedVmfsResolutionSpec; //HostUnresolvedVmfsResolutionSpec

	function __construct($HostUnresolvedVmfsResolutionSpec = null) {
		$this->HostUnresolvedVmfsResolutionSpec = $HostUnresolvedVmfsResolutionSpec;
	}
}

class HostUnresolvedVmfsVolumeResolveStatus {
	public $resolvable; //boolean
	public $incompleteExtents; //boolean
	public $multipleCopies; //boolean

	function __construct($resolvable = null, $incompleteExtents = null, $multipleCopies = null) {
		$this->resolvable = $resolvable;
		$this->incompleteExtents = $incompleteExtents;
		$this->multipleCopies = $multipleCopies;
	}
}

class HostUnresolvedVmfsVolume {
	public $extent; //HostUnresolvedVmfsExtent
	public $vmfsLabel; //string
	public $vmfsUuid; //string
	public $totalBlocks; //int
	public $resolveStatus; //HostUnresolvedVmfsVolumeResolveStatus

	function __construct($extent = null, $vmfsLabel = null, $vmfsUuid = null, $totalBlocks = null, $resolveStatus = null) {
		$this->extent = $extent;
		$this->vmfsLabel = $vmfsLabel;
		$this->vmfsUuid = $vmfsUuid;
		$this->totalBlocks = $totalBlocks;
		$this->resolveStatus = $resolveStatus;
	}
}

class ArrayOfHostUnresolvedVmfsVolume {
	public $HostUnresolvedVmfsVolume; //HostUnresolvedVmfsVolume

	function __construct($HostUnresolvedVmfsVolume = null) {
		$this->HostUnresolvedVmfsVolume = $HostUnresolvedVmfsVolume;
	}
}

class HostVMotionConfig {
	public $vmotionNicKey; //string
	public $enabled; //boolean

	function __construct($vmotionNicKey = null, $enabled = null) {
		$this->vmotionNicKey = $vmotionNicKey;
		$this->enabled = $enabled;
	}
}

class HostVMotionInfo {
	public $netConfig; //HostVMotionNetConfig
	public $ipConfig; //HostIpConfig

	function __construct($netConfig = null, $ipConfig = null) {
		$this->netConfig = $netConfig;
		$this->ipConfig = $ipConfig;
	}
}

class HostVMotionNetConfig {
	public $candidateVnic; //HostVirtualNic
	public $selectedVnic; //string

	function __construct($candidateVnic = null, $selectedVnic = null) {
		$this->candidateVnic = $candidateVnic;
		$this->selectedVnic = $selectedVnic;
	}
}

class HostVirtualNicSpec {
	public $ip; //HostIpConfig
	public $mac; //string
	public $distributedVirtualPort; //DistributedVirtualSwitchPortConnection
	public $portgroup; //string
	public $mtu; //int
	public $tsoEnabled; //boolean

	function __construct($ip = null, $mac = null, $distributedVirtualPort = null, $portgroup = null, $mtu = null, $tsoEnabled = null) {
		$this->ip = $ip;
		$this->mac = $mac;
		$this->distributedVirtualPort = $distributedVirtualPort;
		$this->portgroup = $portgroup;
		$this->mtu = $mtu;
		$this->tsoEnabled = $tsoEnabled;
	}
}

class HostVirtualNicConfig {
	public $changeOperation; //string
	public $device; //string
	public $portgroup; //string
	public $spec; //HostVirtualNicSpec

	function __construct($changeOperation = null, $device = null, $portgroup = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->device = $device;
		$this->portgroup = $portgroup;
		$this->spec = $spec;
	}
}

class ArrayOfHostVirtualNicConfig {
	public $HostVirtualNicConfig; //HostVirtualNicConfig

	function __construct($HostVirtualNicConfig = null) {
		$this->HostVirtualNicConfig = $HostVirtualNicConfig;
	}
}

class HostVirtualNic {
	public $device; //string
	public $key; //string
	public $portgroup; //string
	public $spec; //HostVirtualNicSpec
	public $port; //string

	function __construct($device = null, $key = null, $portgroup = null, $spec = null, $port = null) {
		$this->device = $device;
		$this->key = $key;
		$this->portgroup = $portgroup;
		$this->spec = $spec;
		$this->port = $port;
	}
}

class ArrayOfHostVirtualNic {
	public $HostVirtualNic; //HostVirtualNic

	function __construct($HostVirtualNic = null) {
		$this->HostVirtualNic = $HostVirtualNic;
	}
}

class HostVirtualNicConnection {
	public $portgroup; //string
	public $dvPort; //DistributedVirtualSwitchPortConnection

	function __construct($portgroup = null, $dvPort = null) {
		$this->portgroup = $portgroup;
		$this->dvPort = $dvPort;
	}
}

class HostVirtualNicManagerNicTypeSelection {
	public $vnic; //HostVirtualNicConnection
	public $nicType; //string

	function __construct($vnic = null, $nicType = null) {
		$this->vnic = $vnic;
		$this->nicType = $nicType;
	}
}

class ArrayOfHostVirtualNicManagerNicTypeSelection {
	public $HostVirtualNicManagerNicTypeSelection; //HostVirtualNicManagerNicTypeSelection

	function __construct($HostVirtualNicManagerNicTypeSelection = null) {
		$this->HostVirtualNicManagerNicTypeSelection = $HostVirtualNicManagerNicTypeSelection;
	}
}

class VirtualNicManagerNetConfig {
	public $nicType; //string
	public $multiSelectAllowed; //boolean
	public $candidateVnic; //HostVirtualNic
	public $selectedVnic; //string

	function __construct($nicType = null, $multiSelectAllowed = null, $candidateVnic = null, $selectedVnic = null) {
		$this->nicType = $nicType;
		$this->multiSelectAllowed = $multiSelectAllowed;
		$this->candidateVnic = $candidateVnic;
		$this->selectedVnic = $selectedVnic;
	}
}

class ArrayOfVirtualNicManagerNetConfig {
	public $VirtualNicManagerNetConfig; //VirtualNicManagerNetConfig

	function __construct($VirtualNicManagerNetConfig = null) {
		$this->VirtualNicManagerNetConfig = $VirtualNicManagerNetConfig;
	}
}

class HostVirtualNicManagerInfo {
	public $netConfig; //VirtualNicManagerNetConfig

	function __construct($netConfig = null) {
		$this->netConfig = $netConfig;
	}
}

class HostVirtualSwitchBridge {
}

class HostVirtualSwitchAutoBridge {
	public $excludedNicDevice; //string

	function __construct($excludedNicDevice = null) {
		$this->excludedNicDevice = $excludedNicDevice;
	}
}

class HostVirtualSwitchSimpleBridge {
	public $nicDevice; //string

	function __construct($nicDevice = null) {
		$this->nicDevice = $nicDevice;
	}
}

class HostVirtualSwitchBondBridge {
	public $nicDevice; //string
	public $beacon; //HostVirtualSwitchBeaconConfig
	public $linkDiscoveryProtocolConfig; //LinkDiscoveryProtocolConfig

	function __construct($nicDevice = null, $beacon = null, $linkDiscoveryProtocolConfig = null) {
		$this->nicDevice = $nicDevice;
		$this->beacon = $beacon;
		$this->linkDiscoveryProtocolConfig = $linkDiscoveryProtocolConfig;
	}
}

class HostVirtualSwitchBeaconConfig {
	public $interval; //int

	function __construct($interval = null) {
		$this->interval = $interval;
	}
}

class HostVirtualSwitchSpec {
	public $numPorts; //int
	public $bridge; //HostVirtualSwitchBridge
	public $policy; //HostNetworkPolicy
	public $mtu; //int

	function __construct($numPorts = null, $bridge = null, $policy = null, $mtu = null) {
		$this->numPorts = $numPorts;
		$this->bridge = $bridge;
		$this->policy = $policy;
		$this->mtu = $mtu;
	}
}

class HostVirtualSwitchConfig {
	public $changeOperation; //string
	public $name; //string
	public $spec; //HostVirtualSwitchSpec

	function __construct($changeOperation = null, $name = null, $spec = null) {
		$this->changeOperation = $changeOperation;
		$this->name = $name;
		$this->spec = $spec;
	}
}

class ArrayOfHostVirtualSwitchConfig {
	public $HostVirtualSwitchConfig; //HostVirtualSwitchConfig

	function __construct($HostVirtualSwitchConfig = null) {
		$this->HostVirtualSwitchConfig = $HostVirtualSwitchConfig;
	}
}

class HostVirtualSwitch {
	public $name; //string
	public $key; //string
	public $numPorts; //int
	public $numPortsAvailable; //int
	public $mtu; //int
	public $portgroup; //string
	public $pnic; //string
	public $spec; //HostVirtualSwitchSpec

	function __construct($name = null, $key = null, $numPorts = null, $numPortsAvailable = null, $mtu = null, $portgroup = null, $pnic = null, $spec = null) {
		$this->name = $name;
		$this->key = $key;
		$this->numPorts = $numPorts;
		$this->numPortsAvailable = $numPortsAvailable;
		$this->mtu = $mtu;
		$this->portgroup = $portgroup;
		$this->pnic = $pnic;
		$this->spec = $spec;
	}
}

class ArrayOfHostVirtualSwitch {
	public $HostVirtualSwitch; //HostVirtualSwitch

	function __construct($HostVirtualSwitch = null) {
		$this->HostVirtualSwitch = $HostVirtualSwitch;
	}
}

class HostVmciAccessManagerAccessSpec {
	public $vm; //ManagedObjectReference
	public $services; //string
	public $mode; //string

	function __construct($vm = null, $services = null, $mode = null) {
		$this->vm = $vm;
		$this->services = $services;
		$this->mode = $mode;
	}
}

class ArrayOfHostVmciAccessManagerAccessSpec {
	public $HostVmciAccessManagerAccessSpec; //HostVmciAccessManagerAccessSpec

	function __construct($HostVmciAccessManagerAccessSpec = null) {
		$this->HostVmciAccessManagerAccessSpec = $HostVmciAccessManagerAccessSpec;
	}
}

class HostVmfsRescanResult {
	public $host; //ManagedObjectReference
	public $fault; //LocalizedMethodFault

	function __construct($host = null, $fault = null) {
		$this->host = $host;
		$this->fault = $fault;
	}
}

class ArrayOfHostVmfsRescanResult {
	public $HostVmfsRescanResult; //HostVmfsRescanResult

	function __construct($HostVmfsRescanResult = null) {
		$this->HostVmfsRescanResult = $HostVmfsRescanResult;
	}
}

class HostVmfsSpec {
	public $extent; //HostScsiDiskPartition
	public $blockSizeMb; //int
	public $majorVersion; //int
	public $volumeName; //string

	function __construct($extent = null, $blockSizeMb = null, $majorVersion = null, $volumeName = null) {
		$this->extent = $extent;
		$this->blockSizeMb = $blockSizeMb;
		$this->majorVersion = $majorVersion;
		$this->volumeName = $volumeName;
	}
}

class HostVmfsVolume {
	public $blockSizeMb; //int
	public $maxBlocks; //int
	public $majorVersion; //int
	public $version; //string
	public $uuid; //string
	public $extent; //HostScsiDiskPartition
	public $vmfsUpgradable; //boolean
	public $forceMountedInfo; //HostForceMountedInfo
	public $ssd; //boolean

	function __construct($blockSizeMb = null, $maxBlocks = null, $majorVersion = null, $version = null, $uuid = null, $extent = null, $vmfsUpgradable = null, $forceMountedInfo = null, $ssd = null) {
		$this->blockSizeMb = $blockSizeMb;
		$this->maxBlocks = $maxBlocks;
		$this->majorVersion = $majorVersion;
		$this->version = $version;
		$this->uuid = $uuid;
		$this->extent = $extent;
		$this->vmfsUpgradable = $vmfsUpgradable;
		$this->forceMountedInfo = $forceMountedInfo;
		$this->ssd = $ssd;
	}
}

class NetDhcpConfigInfoDhcpOptions {
	public $enable; //boolean
	public $config; //KeyValue

	function __construct($enable = null, $config = null) {
		$this->enable = $enable;
		$this->config = $config;
	}
}

class NetDhcpConfigInfo {
	public $ipv6; //NetDhcpConfigInfoDhcpOptions
	public $ipv4; //NetDhcpConfigInfoDhcpOptions

	function __construct($ipv6 = null, $ipv4 = null) {
		$this->ipv6 = $ipv6;
		$this->ipv4 = $ipv4;
	}
}

class NetDhcpConfigSpecDhcpOptionsSpec {
	public $enable; //boolean
	public $config; //KeyValue
	public $operation; //string

	function __construct($enable = null, $config = null, $operation = null) {
		$this->enable = $enable;
		$this->config = $config;
		$this->operation = $operation;
	}
}

class NetDhcpConfigSpec {
	public $ipv6; //NetDhcpConfigSpecDhcpOptionsSpec
	public $ipv4; //NetDhcpConfigSpecDhcpOptionsSpec

	function __construct($ipv6 = null, $ipv4 = null) {
		$this->ipv6 = $ipv6;
		$this->ipv4 = $ipv4;
	}
}

class NetDnsConfigInfo {
	public $dhcp; //boolean
	public $hostName; //string
	public $domainName; //string
	public $ipAddress; //string
	public $searchDomain; //string

	function __construct($dhcp = null, $hostName = null, $domainName = null, $ipAddress = null, $searchDomain = null) {
		$this->dhcp = $dhcp;
		$this->hostName = $hostName;
		$this->domainName = $domainName;
		$this->ipAddress = $ipAddress;
		$this->searchDomain = $searchDomain;
	}
}

class NetDnsConfigSpec {
	public $dhcp; //boolean
	public $hostName; //string
	public $domainName; //string
	public $ipAddress; //string
	public $searchDomain; //string

	function __construct($dhcp = null, $hostName = null, $domainName = null, $ipAddress = null, $searchDomain = null) {
		$this->dhcp = $dhcp;
		$this->hostName = $hostName;
		$this->domainName = $domainName;
		$this->ipAddress = $ipAddress;
		$this->searchDomain = $searchDomain;
	}
}

class NetIpConfigInfoIpAddress {
	public $ipAddress; //string
	public $prefixLength; //int
	public $origin; //string
	public $state; //string
	public $lifetime; //dateTime

	function __construct($ipAddress = null, $prefixLength = null, $origin = null, $state = null, $lifetime = null) {
		$this->ipAddress = $ipAddress;
		$this->prefixLength = $prefixLength;
		$this->origin = $origin;
		$this->state = $state;
		$this->lifetime = $lifetime;
	}
}

class ArrayOfNetIpConfigInfoIpAddress {
	public $NetIpConfigInfoIpAddress; //NetIpConfigInfoIpAddress

	function __construct($NetIpConfigInfoIpAddress = null) {
		$this->NetIpConfigInfoIpAddress = $NetIpConfigInfoIpAddress;
	}
}

class NetIpConfigInfo {
	public $ipAddress; //NetIpConfigInfoIpAddress
	public $dhcp; //NetDhcpConfigInfo
	public $autoConfigurationEnabled; //boolean

	function __construct($ipAddress = null, $dhcp = null, $autoConfigurationEnabled = null) {
		$this->ipAddress = $ipAddress;
		$this->dhcp = $dhcp;
		$this->autoConfigurationEnabled = $autoConfigurationEnabled;
	}
}

class NetIpConfigSpecIpAddressSpec {
	public $ipAddress; //string
	public $prefixLength; //int
	public $operation; //string

	function __construct($ipAddress = null, $prefixLength = null, $operation = null) {
		$this->ipAddress = $ipAddress;
		$this->prefixLength = $prefixLength;
		$this->operation = $operation;
	}
}

class ArrayOfNetIpConfigSpecIpAddressSpec {
	public $NetIpConfigSpecIpAddressSpec; //NetIpConfigSpecIpAddressSpec

	function __construct($NetIpConfigSpecIpAddressSpec = null) {
		$this->NetIpConfigSpecIpAddressSpec = $NetIpConfigSpecIpAddressSpec;
	}
}

class NetIpConfigSpec {
	public $ipAddress; //NetIpConfigSpecIpAddressSpec
	public $dhcp; //NetDhcpConfigSpec
	public $autoConfigurationEnabled; //boolean

	function __construct($ipAddress = null, $dhcp = null, $autoConfigurationEnabled = null) {
		$this->ipAddress = $ipAddress;
		$this->dhcp = $dhcp;
		$this->autoConfigurationEnabled = $autoConfigurationEnabled;
	}
}

class NetIpRouteConfigInfoGateway {
	public $ipAddress; //string
	public $device; //string

	function __construct($ipAddress = null, $device = null) {
		$this->ipAddress = $ipAddress;
		$this->device = $device;
	}
}

class NetIpRouteConfigInfoIpRoute {
	public $network; //string
	public $prefixLength; //int
	public $gateway; //NetIpRouteConfigInfoGateway

	function __construct($network = null, $prefixLength = null, $gateway = null) {
		$this->network = $network;
		$this->prefixLength = $prefixLength;
		$this->gateway = $gatewa