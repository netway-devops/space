<?php

/*************************************************************
 *
 * Hosting Module Class - Manage Service
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * 
 * 
 * @auther Puttipong Pengprakhon (puttipong at rvglobalsoft.com)
 * 
 ************************************************************/

// Load Hostbill Api
include_once(APPDIR_MODULES . "Hosting/manage_service/include/api/class.manage.hostbill.api.php");

// Load Zabbix Api
include_once(APPDIR_MODULES . "Hosting/manage_service/include/api/class.manage.zabbix.api.php");

class manage_service_controller extends HBController {
    
    public function viewNamedSession($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewNamedSession($request));
        $this->json->show();
    }

    public function viewMySqlByType($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewMySqlByType($request));
        $this->json->show();
    }
    
    public function viewInnodb($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewInnodb($request));
        $this->json->show();
    }
    
    public function viewMyIsam($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewMyIsam($request));
        $this->json->show();
    }
    
    public function viewMysql($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewMysql($request));
        $this->json->show();
    }
    
    public function viewFreeDiskSpaceByDisk($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewFreeDiskSpaceByDisk($request));
        $this->json->show();
    }

    public function viewFreeDiskSpace($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewFreeDiskSpace($request));
        $this->json->show();
    }
    
    public function viewSwapUsage($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewSwapUsage($request));
        $this->json->show();
    }
    
    public function doRecreate($request) { 
        ManageServiceCommon::singleton()->doRecreate($request);
    }
    
    public function doActions($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->doActions($request));
        $this->json->show();
    }
    
    public function viewActions($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewActions($request));
        $this->json->show();
    }
    
    public function doDeleteUserMedia($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->doDeleteUserMedia($request));
        $this->json->show();
    }
    
    public function doAddUserMedia($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->doAddUserMedia($request));
        $this->json->show();
    }
    
    public function viewUserMedia($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewUserMedia($request));
        $this->json->show();
    }
    
    public function viewNginxThread($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewNginxThread($request));
        $this->json->show();
    }
    
    public function viewNginxConnect($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewNginxConnect($request));
        $this->json->show();
    }
    
    public function viewEximTraffic($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewEximTraffic($request));
        $this->json->show();
    }
    
    public function viewEximStatistic($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewEximStatistic($request));
        $this->json->show();
    }
    
    public function viewMysqlThread($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewMysqlThread($request));
        $this->json->show();
    }
    
    public function viewMysqlConnect($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewMysqlConnect($request));
        $this->json->show();
    }
    
    public function viewApacheStat($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewApacheStat($request));
        $this->json->show();
    }
    
    public function viewMemoryUsage($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewMemoryUsage($request));
        $this->json->show();
    }
    
    public function viewCpuLoad($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewCpuLoad($request));
        $this->json->show();
    }
    
    public function viewCpuJump($request) {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('aResponse', ManageServiceCommon::singleton()->viewCpuJump($request));
        $this->json->show();
    }
    
    public function accountdetails($params) {
        
        // Assing Button Re-Create
        $this->template->assign("allowrecreatemanageservice", true);
        // $this->template->assign("isenablebuttonmanageservice", ManageServiceDao::singleton()->isCheckBoxManagedByAccountId($params["account"]["account_id"]));
        $this->template->assign("isenablebuttonmanageservice", ManageServiceDao::singleton()->isCheckAddonsPremium($params["account"]["account_id"]));
        
        if (isset($params["account"]["status"]) && strtolower($params["account"]["status"]) == 'active') {
            
            // 1. เงื่อนไข app manage_service จะต้องผูกติดกับ app zabbix เสมอ
            // 2. เงือนไข app zabbix status ต้องเป็น active
            
            
            $this->template->assign('isAppManageService', '1');
            
            // Displays Tabs Monitor Provision
            $this->template->assign("rvServiceMonitorTab", APPDIR_MODULES . 'Hosting/manage_service/templates/admin/monitor.tpl');
            
            // Displays Tabs Notification Provision
            $this->template->assign("rvServiceNotificationTab", APPDIR_MODULES . 'Hosting/manage_service/templates/admin/notification.tpl');
            
            // Verify Metadata
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($params["account"]["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
                
                // Zabbix Connect
                $api = ManageZabbixApi::singleton();
                $api->_connect($serverHostname, $serverUsername, $serverPassword);
                
                
                
                // Get Host Id / Metadata
                /* $visibleHostName = 'h-' . $params["account"]["account_id"] . '_';
                $visibleHostName = 'h-3734_';
                $metadata = $api->getMetadataByVisibleHostName($visibleHostName); */
                
                // print_r($api->isGraphNameExists('vps.graphodesign.com', 'CPU utilization')); // 'CPU load'
                
                
                // Assign Default
                $this->template->assign('isAgentd', 'false');
                
                $visibleHostName = 'h-' . $params["account"]["account_id"] . '_';
                $aHost = $api->getHostMixValuesByVisibleHostName($visibleHostName);
                if ($aHost['isAgentd'] == true) {
                    $this->template->assign('isAgentd', 'true'); // String 'true'

                                        
                    // Display Tabs
                    $aIsGraph = $api->getIsGraphMixValueByHostName($aHost['hostName']);
                    $this->template->assign('isCpu', $aIsGraph['isCpu']);
                    $this->template->assign('isMemory', $aIsGraph['isMemory']);
                    $this->template->assign('isDisk', $aIsGraph['isDisk']);
                    $this->template->assign('isApahce', $aIsGraph['isApahce']);
                    $this->template->assign('isMysql', $aIsGraph['isMysql']);
                    $this->template->assign('isNginx', $aIsGraph['isNginx']);
                    $this->template->assign('isExim', $aIsGraph['isExim']);
                    $this->template->assign('isNamed', $aIsGraph['isNamed']);
                    
                    
                    
                    // Display LLD free disk space && Dispaly LLD RAID
                    $aActions = $api->getAllActionByAccountId($params["account"]["account_id"]);
                    $aActionFreeDiskSpace = array();
                    $aActionRaidStatus = array();
                    for ($i=0;$i<count($aActions);$i++) {
                        if (@preg_match('/-free-disk-space-volume-/i', $aActions[$i]->name)) {
                            array_push($aActionFreeDiskSpace, $aActions[$i]->def_shortdata);
                        }
                        if (@preg_match('/-raid-divice-status-/i', $aActions[$i]->name)) {
                            array_push($aActionRaidStatus, $aActions[$i]->def_shortdata);
                        }
                    }
                    $this->template->assign('aActionFreeDiskSpace', $aActionFreeDiskSpace);
                    $this->template->assign('aActionRaidStatus', $aActionRaidStatus);
                    
                    
                    
                    // Display Graph Disk
                    $aGraphFreeDiskSpace = array();
                    $aGraphs = $api->getAllFreeDiskSpaceGraphByHostId($aHost['hostId']);
                    for ($i=0;$i<count($aGraphs);$i++) {
                        array_push($aGraphFreeDiskSpace, $aGraphs[$i]->graphid);
                    }
                    $this->template->assign('aGraphFreeDiskSpace', $aGraphFreeDiskSpace);
                    $this->template->assign('diskCount', count($aGraphs));
                    
                    
                    
                    // Display Graph MySql
                    $aGraphMysql = array();
                    $aGraphMyIsam = array();
                    $aGraphInnoDb = array();
                    $aGraphs = $api->getAllMySqlGraphByHostId($aHost['hostId']);
                    if (isset($aGraphs['mysql']) && count($aGraphs['mysql'])>0) {
                        for ($i=0;$i<count($aGraphs['mysql']);$i++) {
                            array_push($aGraphMysql, $aGraphs['mysql'][$i]->graphid);
                        }
                    }
                    if (isset($aGraphs['myisam']) && count($aGraphs['myisam'])>0) {
                        for ($i=0;$i<count($aGraphs['myisam']);$i++) {
                            array_push($aGraphMyIsam, $aGraphs['myisam'][$i]->graphid);
                        }
                    }
                    if (isset($aGraphs['innodb']) && count($aGraphs['innodb'])>0) {
                        for ($i=0;$i<count($aGraphs['innodb']);$i++) {
                            array_push($aGraphInnoDb, $aGraphs['innodb'][$i]->graphid);
                        }
                    }
                    $this->template->assign('aGraphMysql', $aGraphMysql);
                    $this->template->assign('aGraphMyIsam', $aGraphMyIsam);
                    $this->template->assign('aGraphInnodb', $aGraphInnoDb);
                    $this->template->assign('mySqlCount', count($aGraphs['mysql']));
                    $this->template->assign('myIsamCount', count($aGraphs['myisam']));
                    $this->template->assign('myInnodbCount', count($aGraphs['innodb']));
                    
                    
                    
                }
                
                
                
                
                /*
                echo '<PRE>';
                print_r($aHost);
                print_r($aIsGraph);
                print $metadata;exit;
                */
                
                // echo '<PRE>';
                //print_r($api->rvcustom_rvtest());
                // print_r($api->getAllActionByAccountId($params["account"]["account_id"]));
                // echo 'xx';
                // exit;
                
            }
            
            
            
            // TODO
            // Assing Hidden Value In Templates
            // $this->template->assign("accountId", $params["account"]["id"]);
            // $this->template->assign("serverId", $params["account"]["server_id"]);
            // $this->template->assign("clientId", $params["account"]["client_id"]);
            
            //echo '<PRE>';
            //print_r($params);
        }
        
/*Array
(
    [cmd] => accounts
    [action] => edit
    [id] => 3527
    [path_info] => 
    [token_valid] => 
    [account] => Array
        (
            [account_id] => 3527
            [module_id] => 112
            [server_id] => 111
            [status] => Pending
            [username] => xenserv
            [password] => dH_5f16j!4
            [rootpassword] => dH_5f16j!4
            [extra_details] => 
            [module] => 112
            [modname] => Manage Service
            [options] => 
        )

)
 * 
 */        
        
        //echo 'xxxxxxx';
        //echo '<PRE>';
        //print_r($params);
        
    }
    
}