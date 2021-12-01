<?php
/**
 * @file    ZabbixApi.class.php
 * @brief   Class file for the implementation of the class ZabbixApi.
 *
 * Implement your customizations in this file.
 *
 * This file is part of PhpZabbixApi.
 *
 * PhpZabbixApi is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * PhpZabbixApi is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PhpZabbixApi.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @copyright   GNU General Public License
 * @author      confirm IT solutions GmbH, Rathausstrase 14, CH-6340 Baar
 *
 * @version     $Id: ZabbixApi.class.php 138 2012-10-08 08:00:24Z dbarton $
 */


// Include zabbix abstract
include_once("class.zabbix.api.abstract.php");


/**
 * @brief   Concrete class for the Zabbix API.
 */
class ManageZabbixApi extends ZabbixApiAbstract {

	/**
     * Returns a singleton ZabbixApi instance.
     *
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param bool $autoload
     * @return obj
     * 
     */
     public function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
	
    /**
     * Test Connect Zabbix
     * 
     * @author Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
     * @param $server_hostname 
     * @param $server_username
     * @param $server_password
     * @return bool
     * 
     * @example ManageZabbixApi::singleton()->_connect("http://192.168.1.135/zabbix/api_jsonrpc.php", "admin", "zabbix");
     */
    public function _connect($server_hostname="", $server_username="", $server_password="") {

    	if ($server_hostname)
            $this->setApiUrl($server_hostname);

        return (trim($server_username) == "" || trim($server_password) == "") 
                    ? false
                    : $this->userLogin(array('user' => $server_username, 'password' => $server_password));        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _triggerGet($params=array(), $arrayKeyProperty='') {
        
        return $this->triggerGet($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionDelete($params=array(), $arrayKeyProperty='') {
        
        return $this->actionDelete($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionUpdate($params=array(), $arrayKeyProperty='') {
        
        return $this->actionUpdate($params, $arrayKeyProperty);
        
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _actionGet($params=array(), $arrayKeyProperty='') {
        
        return $this->actionGet($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _userDeleteMedia($params=array(), $arrayKeyProperty='') {
        
        return $this->userDeleteMedia($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _userAddMedia($params=array(), $arrayKeyProperty='') {
        
        return $this->userAddMedia($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _usermediaGet($params=array(), $arrayKeyProperty='') {
        
        return $this->usermediaGet($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param unknown_type $params
     * @param unknown_type $arrayKeyProperty
     */
    public function _userGet($params=array(), $arrayKeyProperty='') {

        return $this->userGet($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _scriptExecute($params=array(), $arrayKeyProperty='') {
        
        return $this->scriptExecute($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _graphGet($params=array(), $arrayKeyProperty='') {
        
        return $this->graphGet($params, $arrayKeyProperty);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _hostGet($params=array(), $arrayKeyProperty='') {
        
        return $this->hostGet($params, $arrayKeyProperty);
        
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @param $arrayKeyProperty
     */
    public function _graphExists($params=array(), $arrayKeyProperty='') {
        
        return $this->graphExists($params, $arrayKeyProperty);
        
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     * @param $graphName
     */
    public function isGraphNameExists($hostName="", $graphName="") {
        
        $res = $this->_graphExists(array(
            "host" => $hostName,
            "name" => $graphName
        ));
        
        return (isset($res) && $res == true && $hostName != "" && $graphName != "") ? true : false;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionID
     * @param $status
     */
    public function doActionUpdateStatus($actionID="", $status="0") {
        
        $params = array(
           "actionid" => $actionID,
           "status" => $status
        );
        
        return $this->_actionUpdate($params);
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $actionID
     * @param $EscPeriod
     */
    public function doActionUpdateEscPeriod($actionID="", $escPeriod="600") {
        
        $params = array(
           "actionid" => $actionID,
           "esc_period" => $escPeriod
        );
        
        return $this->_actionUpdate($params);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     * @param $emailName
     */
    public function isUserMediaEmailNameExists($userID="", $emailName="") {
        
        $isUserMediaEmailExists = false;
        
        $aRes = $this->getUserMediaByUserId($userID);
        
        if (count($aRes)>0) {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->sendto) && $aRes[$i]->sendto != "") {
                    if ($aRes[$i]->sendto == $emailName) {
                        $isUserMediaEmailExists = true;
                        break;
                    }
                }
            }
        }
        
        return $isUserMediaEmailExists;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $params
     * @example $api->doUserDeleteMedia(array("20"))
     */
    public function doUserDeleteMedia($params=array()) {
        
        return $this->_userDeleteMedia($params);
        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     * @param $emailName
     */
    public function doUserAddMedia($userID="", $emailName="") {
        
        $params = array(
           "users" => array(
                array(
                    "userid" => $userID
                )
            ),
            "medias" => array(
                "mediatypeid" => "1",
                "sendto" => $emailName,
                "active" => "0",
                "severity" => "63",
                "period" => "1-7,00:00-24:00"
            )
        );
        
        return $this->_userAddMedia($params);
    }
    
    public function getAllMySqlGraphByHostId($hostID='') {
        
        $aGraph = array(
            'mysql' => array(),
            'myisam' => array(),
            'innodb' => array()
        );
        $aRes = $this->_graphGet(array(
                "output" => "extend",
                "selectHosts" => "extend",
                'filter' => array(
                    'hostid' => array(
                        $hostID
                    )
                )
        ));
        
        $aGraphListMysql = array(
            // 'MySQL Binary/Relay Logs',
            'MySQL Command Counters',
            'MySQL Connections',
            'MySQL Files and Tables',
            'MySQL Handlers',
            'MySQL Network Traffic',
            'MySQL Processlist',
            'MySQL Query Cache',
            'MySQL Query Cache Memory',
            // 'MySQL Query Response Time (Microseconds)',
            // 'MySQL Query Time Histogram (Count)',
            // 'MySQL Replication',
            'MySQL Select Types',
            'MySQL Sorts',
            'MySQL Table Locks',
            'MySQL Temporary Objects',
            'MySQL Threads',
            'MySQL Transaction Handler'
        );
        $aGraphListMyIsam = array(
            'MyISAM Indexes',
            'MyISAM Key Cache'
        );
        $aGraphListInnodb = array(
            'InnoDB Adaptive Hash Index',
            'InnoDB Buffer Pool',
            // 'InnoDB Buffer Pool Activity',
            'InnoDB Buffer Pool Efficiency',
            // 'InnoDB Checkpoint Age',
            // 'InnoDB Current Lock Waits',
            // 'InnoDB I/O',
            // 'InnoDB I/O Pending',
            // 'InnoDB Insert Buffer',
            'InnoDB Insert Buffer Usage',
            // 'InnoDB Internal Hash Memory Usage',
            // 'InnoDB Lock Structures',
            'InnoDB Log',
            'InnoDB Memory Allocation',
            // 'InnoDB Row Lock Time',
            // 'InnoDB Row Lock Waits',
            // 'InnoDB Row Operations',
            // 'InnoDB Semaphores',
            // 'InnoDB Semaphore Waits',
            // 'InnoDB Semaphore Wait Time',
            // 'InnoDB Tables In Use',
            'InnoDB Transactions',
            'InnoDB Transactions Active/Locked'
        );
        
        if (count($aRes) > 0) {
            for ($i=0;$i<count($aRes);$i++) {
                
                if (in_array($aRes[$i]->name, $aGraphListMysql)) {                       
                    array_push($aGraph['mysql'], $aRes[$i]);
                }
                
                if (in_array($aRes[$i]->name, $aGraphListMyIsam)) {                       
                    array_push($aGraph['myisam'], $aRes[$i]);
                }
                
                if (in_array($aRes[$i]->name, $aGraphListInnodb)) {                       
                    array_push($aGraph['innodb'], $aRes[$i]);
                }
                
            }
        }
        
        return $aGraph;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     */
    public function getAllFreeDiskSpaceGraphByHostId($hostID='') {
            
        $aGraph = array();
        $aRes = $this->_graphGet(array(
                "output" => "extend",
                "selectHosts" => "extend",
                'filter' => array(
                    'hostid' => array(
                        $hostID
                    )
                )
        ));
        
        //Disk space usage
        
        if (count($aRes) > 0) {
            for ($i=0;$i<count($aRes);$i++) {
                if (@preg_match('/disk space usage/i', $aRes[$i]->name)) {
                    array_push($aGraph, $aRes[$i]);
                }
            }
        }
        
        return $aGraph;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     */
    public function getAllTriggerByHostId($hostID='') {
        
        $aTriggerList = array(
            'ICMP ping fail from {HOST.HOST} ({HOST.IP})',
            'Processor load is too high on {HOST.HOST} ({HOST.IP})',
            'Lack of free swap space on {HOST.HOST} ({HOST.IP})',
            'Lack of available memory on server {HOST.HOST} ({HOST.IP})',
            'Disk I/O is overloaded on {HOST.HOST} ({HOST.IP})',
            'Apache is down on {HOST.HOST} ({HOST.IP})',
            'MySQL active threads more than 100 on {HOST.HOST} ({HOST.IP})',
            'MySQL connections utilization more than 95% on {HOST.HOST} ({HOST.IP})',
            'MySQL is down on {HOST.HOST} ({HOST.IP})',
            'More than 1000 Mails in the Queue on {HOST.HOST} ({HOST.IP})',
            'nginx is down on {HOST.HOST} ({HOST.IP})'
        );
        $aTriggerListKey = array(
            'trigger-ping',
            'trigger-cpu-processor-load-high',
            'trigger-memory-lack-free-swap',
            'trigger-memory-lack-available',
            'trigger-disk-io-overload',
            'trigger-apache-down',
            'trigger-mysql-thread-more-than-100',
            'trigger-mysql-connection-utilization-more-than-95',
            'trigger-mysql-down',
            'trigger-exim-queue-more-than-1000',
            'trigger-nginx-down'
        );
        
        for ($i=0;$i<count($aTriggerList);$i++) {
            $aTrigger['description'][$aTriggerListKey[$i]] = $aTriggerList[$i];
        }
        
        $aRes = $this->_triggerGet(array(
                "output" => "extend",
                "selectHosts" => "extend",
                'filter' => array(
                    'hostid' => array(
                        $hostID
                    )
                )
        ));
        
        if (count($aRes) > 0) {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->description)) {
                    
                    for ($j=0;$j<count($aTriggerList);$j++) {
                        if ($aTriggerList[$j] == $aRes[$i]->description) {
                            
                            // Replace String
                            $aRes[$i]->description2 = $aRes[$i]->description;
                            $aRes[$i]->description2 = str_replace('{HOST.HOST}', '', $aRes[$i]->description2);
                            $aRes[$i]->description2 = str_replace('({HOST.IP})', '', $aRes[$i]->description2);
                            $aRes[$i]->description2 = str_replace('from', '', $aRes[$i]->description2);
                            $aRes[$i]->description2 = str_replace(' on ', '', $aRes[$i]->description2);
                            
                            $aTrigger[$aTriggerListKey[$j]] = $aRes[$i];
                            break;
                        }
                    }
                    
                }
            }
        }
        
        return $aTrigger;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $accountId
     */
    public function getAllActionByAccountId($accountId='') {
           
        $aAction = array();
        $aActionList = array(
            'a-' . $accountId . '-ping',
            'a-' . $accountId . '-ping-sms',
            'a-' . $accountId . '-cpu-processor-load-high',
            'a-' . $accountId . '-memory-lack-free-swap',
            'a-' . $accountId . '-memory-lack-available',
            'a-' . $accountId . '-apache-down',
            'a-' . $accountId . '-disk-io-overload',
            'a-' . $accountId . '-mysql-thread-more-than-100',
            'a-' . $accountId . '-mysql-connection-utilization-more-than-95',
            'a-' . $accountId . '-mysql-down',
            'a-' . $accountId . '-exim-queue-more-than-1000',
            'a-' . $accountId . '-nginx-down',
            'a-' . $accountId . '-named-down'
        );
        
        // Fix: max=30
        for ($i=0;$i<30;$i++) {
            array_push($aActionList, 'a-' . $accountId . '-free-disk-space-volume-' . $i);
        }
        
        // Fix max=10
        for ($i=0;$i<10;$i++) {
            array_push($aActionList, 'a-' . $accountId . '-raid-divice-status-' . $i);
        }
        
        $aRes= $this->_actionGet(array(
            'output' => 'extend'
        ));

        if (count($aRes) > 0) {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->name)) {
                    if (in_array($aRes[$i]->name, $aActionList)) {                       
                        array_push($aAction, $aRes[$i]);
                    }
                }
            }
        }
        
        return $aAction;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $hostName
     * @param $graphName
     */
    public function getHostMixValuesByVisibleHostName($visibleHostName="") {
        $aHost = array(
            'host' => null,
            'hostId' => null,
            'hostName' => null,
            'isAgentd' => false,
            'isProxy' => false
        );
        
        $aRes = $this->_hostGet(array(
            'output' => 'extend',
            'selectGroups' => 'extend'
        ));

        if (count($aRes) > 0 && isset($visibleHostName) && $visibleHostName != "") {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->name) && $aRes[$i]->name != "" && isset($aRes[$i]->hostid) && $aRes[$i]->hostid != "") {
                     if (@preg_match("/" . $visibleHostName . "/i", $aRes[$i]->name)) {
                        $aHost['host'] = $aRes[$i];
                        
                        // Get Host ID
                        if (isset($aRes[$i]->hostid) && $aRes[$i]->hostid != '') {
                            $aHost['hostId'] = $aRes[$i]->hostid;
                        }
                        
                        // Get Host Name
                        if (isset($aRes[$i]->host) && $aRes[$i]->host != '') {
                            $aHost['hostName'] = $aRes[$i]->host;
                        }
                        
                        // Get Is Agentd
                        if (isset($aRes[$i]->groups[0]->name) && $aRes[$i]->groups[0]->name == 'Linux servers') {
                            $aHost['isAgentd'] = true;
                        }
                        
                        // Get Is Proxy
                        if (isset($aRes[$i]->proxy_hostid) && $aRes[$i]->proxy_hostid == 0) {
                        } else {
                            $aHost['isProxy'] = true;
                        }
                        
                        break;
                     }
                }
            }
        }
        
        return $aHost;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $visibleHostName
     */
    public function getHostIdByVisibleHostName($visibleHostName="") {
        
        $hostID = null;
        
        $aRes = $this->_hostGet(array(
            "output" => "extend"
        ));

        if (count($aRes) > 0 && isset($visibleHostName) && $visibleHostName != "") {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->name) && $aRes[$i]->name != "" && isset($aRes[$i]->hostid) && $aRes[$i]->hostid != "") {
                     if (@preg_match("/" . $visibleHostName . "/i", $aRes[$i]->name)) {
                        $hostID = $aRes[$i]->hostid;
                        break;
                     }
                }
            }
        }
        
        return $hostID;
    }
    
    /**
     * 
     * 
     */
    public function getHostGroupByVisibleHostName($visibleHostName='') {
        $aGroup = array(
            'group_id' => array(),
            'group_name' => array(),
            'isGroupManange' => false
        );
        
        $aRes = $this->_hostGet(array(
            'output' => 'extend',
            'selectGroups' => 'extend'
        ));
        
        if (count($aRes) > 0 && isset($visibleHostName) && $visibleHostName != '') {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->name) && $aRes[$i]->name != "" && isset($aRes[$i]->hostid) && $aRes[$i]->hostid != "") {
                     if (@preg_match("/" . $visibleHostName . "/i", $aRes[$i]->name)) {
                        
                        if (isset($aRes[$i]->groups) && is_array($aRes[$i]->groups)) {
                            for ($j=0;$j<count($aRes[$i]->groups);$j++) {
                                $aGroup['group_id'][$j]['groupid'] = $aRes[$i]->groups[$j]->groupid;
                                $aGroup['group_name'][$j] = $aRes[$i]->groups[$j]->name;
                                
                                // if ($aRes[$i]->groups[$j]->name == 'Managed Services Host Group') {
                                if ($aRes[$i]->groups[$j]->groupid == 34) { // Fix: ID
                                    $aGroup['isGroupManange'] = true;
                                }
                            }
                        }
                     }
                }
            }
        }
        
        return $aGroup;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $visibleHostName
     */
    public function getMetadataByVisibleHostName($visibleHostName="") {
        
        $metadata = null;
        
        $hostID = $this->getHostIdByVisibleHostName($visibleHostName);
        if (isset($hostID) && $hostID != '') {
            
            $aRes = $this->_scriptExecute(array(
                'scriptid' => '8', // re-auto-registration
                'hostid'=> $hostID
            ));
            
            $metadata = (isset($aRes->value) && $aRes->value != '') ? $aRes->value : null;
        }
        
        return $metadata;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $userAlias
     */
    public function getUserIdByUserAlias($userAlias="") {
        
        $aRes= $this->_userGet(array(
            "output" => "extend",
            "filter" => array(
                "alias" => array(
                    $userAlias
                )
            )
        ));
        
        return (isset($aRes[0]->userid) && isset($userAlias) && $userAlias != "") ? $aRes[0]->userid : null;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $userID
     */
    public function getUserMediaByUserId($userID="") {
                
        $aRes= $this->_usermediaGet(array(
            "output" => "extend",
            "userids" => $userID
        ));
        
        return (isset($userID) && $userID != "") ? $aRes : array();
    }
    
    /**
     * 
     */
    public function getIsGraphMixValueByHostName($hostName='') {
        
        $aIsGraph = array(
            'isCpu' => false,
            'isMemory' => false,
            'isDisk' => false,
            'isApahce' => false,
            'isMysql' => false,
            'isNginx' => false,
            'isExim' => false,
            'isNamed' => false
        );
        $aGraphName = array(
            'CPU load',
            'CPU jumps',
            'Memory usage',
            'Disk space usage /',
            'Apache Stats',
            'MySQL Connections',
            'MySQL Threads',
            'Nginx - Connections and Requests status',
            'Nginx - Threads status',
            'Exim Statistics',
            'Exim Traffic Size',
            'Named session open'
        );
        
        for ($i=0;$i<count($aGraphName);$i++) {
            $aIsGraph[$aGraphName[$i]] = false;
            if ($this->isGraphNameExists($hostName, $aGraphName[$i]) === true) {
                $aIsGraph[$aGraphName[$i]] = true;
                    
                // is CPU
                if ($aGraphName[$i] == 'CPU load' || $aGraphName[$i] == 'CPU load') {
                    $aIsGraph['isCpu'] = true;
                }
                // is Memory
                if ($aGraphName[$i] == 'Memory usage') {
                    $aIsGraph['isMemory'] = true;
                }
                // is Disk
                if ($aGraphName[$i] == 'Disk space usage /') {
                    $aIsGraph['isDisk'] = true;
                }
                // is Apahce
                if ($aGraphName[$i] == 'Apache Stats') {
                    $aIsGraph['isApahce'] = true;
                }
                // is MySQL
                if ($aGraphName[$i] == 'MySQL Connections' || $aGraphName[$i] == 'MySQL Threads') {
                    $aIsGraph['isMysql'] = true;
                }
                // is MySQL
                if ($aGraphName[$i] == 'Nginx - Connections and Requests status' 
                    || $aGraphName[$i] == 'Nginx - Threads status') {
                    $aIsGraph['isNginx'] = true;
                }
                // is Exim
                if ($aGraphName[$i] == 'Exim Statistics') {
                    $aIsGraph['isExim'] = true;
                }
                // is Named
                if ($aGraphName[$i] == 'Named session open') {
                    $aIsGraph['isNamed'] = true;
                }
                    
            }
        }
        
        return $aIsGraph;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $hostID
     * @param $graphName
     */
    public function getGraphIdByHostIdGraphName($hostID="", $graphName="") {
        
        $graphId = null;
        
        $aRes = $this->_graphGet(array(
            "output" => "extend",
            "hostids" => $hostID
        ));
        
        if (count($aRes) > 0 && isset($hostID) && $hostID != "" && isset($graphName) && $graphName != "") {
            for ($i=0;$i<count($aRes);$i++) {
                if (isset($aRes[$i]->graphid) && isset($aRes[$i]->name)) {
                    if (@preg_match("/" . $graphName . "/i", $aRes[$i]->name)) {
                        $graphId = $aRes[$i]->graphid;
                    }
                }
            }
        }
        
        return $graphId;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $url
     * @param $user
     * @param $password
     * @param $hostName
     * @param $graphId
     * @param $period
     * @param $imageDest
     */
    public function getGraphImage($aParams = array()) {
        
        $url = $aParams['url'];
        $user = $aParams['user'];
        $password = $aParams['password'];
        $graphId = $aParams['graphId'];
        $period = $aParams['period'];
        $imageName = $aParams['imageName'];
        $imageDest = $aParams['imageDest'];
        
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, $aParams['url'] . "index.php");
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "name=$user&password=$password&autologin=1&enter=Sign+in");
        curl_setopt($ch, CURLOPT_COOKIEJAR, "zabbix_cookie.txt");
        curl_setopt($ch, CURLOPT_COOKIEFILE, "zabbix_cookie.txt");
                    
        // Login    
        $output=curl_exec($ch);

        // Get graph
        curl_setopt($ch, CURLOPT_URL, $url . "chart2.php?graphid=" . $graphId . "&width=750&height=150&period=" . $period);
        $output = curl_exec($ch);
        curl_close($ch);
                    
        if (is_file("zabbix_cookie.txt")) {
            unlink("zabbix_cookie.txt");
        }
    
        if (is_file($imageDest)) {
            unlink($imageDest);
        }
                    
        $fp = fopen($imageDest, 'w');
        fwrite($fp, $output);
        fclose($fp);
        
        return "includes/modules/Hosting/manage_service/public_html/images/tmp/" . $imageName;
    }
    
    
    /**
     * 
     * Enter description here ...
     * @param $url
     * @param $user
     * @param $password
     * @param $hostName
     * @param $graphId
     * @param $period
     * @param $imageDest
     */
    public function getGraphImage2($aParams = array()) {
        
        $url = $aParams['url'];
        $user = $aParams['user'];
        $password = $aParams['password'];
        $graphId = $aParams['graphId'];
        $period = $aParams['period'];
        $imageName = $aParams['imageName'];
        $imageDest = $aParams['imageDest'];
        
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, $aParams['url'] . "index.php");
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "name=$user&password=$password&autologin=1&enter=Sign+in");
        curl_setopt($ch, CURLOPT_COOKIEJAR, "zabbix_cookie.txt");
        curl_setopt($ch, CURLOPT_COOKIEFILE, "zabbix_cookie.txt");
                    
        // Login    
        $output=curl_exec($ch);

        // Get graph
        curl_setopt($ch, CURLOPT_URL, $url . "chart6.php?graphid=" . $graphId . "&width=750&period=" . $period);
        $output = curl_exec($ch);
        curl_close($ch);
                    
        if (is_file("zabbix_cookie.txt")) {
            unlink("zabbix_cookie.txt");
        }
    
        if (is_file($imageDest)) {
            unlink($imageDest);
        }
                    
        $fp = fopen($imageDest, 'w');
        fwrite($fp, $output);
        fclose($fp);
        
        return "includes/modules/Hosting/manage_service/public_html/images/tmp/" . $imageName;
    }
    
    /**
     * 
     * Enter description here ...
     * @param $url
     * @param $user
     * @param $password
     * @param $period
     * @param $imageDest
     * @param $aGraphs
     */
    public function getAllGraphFreeDiskSpaceImage($aParams = array()) {
        
        $url = $aParams['url'];
        $user = $aParams['user'];
        $password = $aParams['password'];
        $period = $aParams['period'];
        $imageDests = $aParams['imageDest'];
        $aGraphs = $aParams['aGraphs'];
        
        $aRes = array();

        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, $aParams['url'] . "index.php");
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "name=$user&password=$password&autologin=1&enter=Sign+in");
        curl_setopt($ch, CURLOPT_COOKIEJAR, "zabbix_cookie.txt");
        curl_setopt($ch, CURLOPT_COOKIEFILE, "zabbix_cookie.txt");
                    
        // Login    
        $output=curl_exec($ch);
        
        for ($i=0;$i<count($aGraphs);$i++) {
        // for ($i=0;$i<2;$i++) { // Debug
            
            // Get graph
            curl_setopt($ch, CURLOPT_URL, $url . "chart6.php?graphid=" . $aGraphs[$i]->graphid . "&width=750&period=" . $period);
            $output = curl_exec($ch);
            
            
            if (is_file("zabbix_cookie.txt")) {
                unlink("zabbix_cookie.txt");
            }
            
            $imageDest = $imageDests . $aGraphs[$i]->graphid . '.png';
                            
            if (is_file($imageDest)) {
                unlink($imageDest);
            }
                        
            $fp = fopen($imageDest, 'w');
            fwrite($fp, $output);
            fclose($fp);
        
            $aRes[$i]['imageDest'] = $imageDest;
            $aRes[$i]['imageName'] = "includes/modules/Hosting/manage_service/public_html/images/tmp/free-disk-space-" . $aGraphs[$i]->graphid . '.png';
            $aRes[$i]['graphId'] = $aGraphs[$i]->graphid;
            
        }
        
        
        curl_close($ch);
                
        return $aRes;
    }


    /**
     * 
     * Enter description here ...
     * @param $url
     * @param $user
     * @param $password
     * @param $period
     * @param $imageDest
     * @param $aGraphs
     */
    public function getAllGraphMysqlImage($aParams = array()) {
        
        $url = $aParams['url'];
        $user = $aParams['user'];
        $password = $aParams['password'];
        $period = $aParams['period'];
        $imageDests = $aParams['imageDest'];
        $aGraphs = $aParams['aGraphs'];
        $type = $aParams['type'];
        
        $aRes = array();

        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, $aParams['url'] . "index.php");
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, "name=$user&password=$password&autologin=1&enter=Sign+in");
        curl_setopt($ch, CURLOPT_COOKIEJAR, "zabbix_cookie.txt");
        curl_setopt($ch, CURLOPT_COOKIEFILE, "zabbix_cookie.txt");
                    
        // Login    
        $output=curl_exec($ch);
        
        for ($i=0;$i<count($aGraphs[$type]);$i++) {
        // for ($i=0;$i<2;$i++) { // Debug
            
            // Get graph
            curl_setopt($ch, CURLOPT_URL, $url . "chart2.php?graphid=" . $aGraphs[$type][$i]->graphid . "&width=750&period=" . $period);
            $output = curl_exec($ch);
            
            
            if (is_file("zabbix_cookie.txt")) {
                unlink("zabbix_cookie.txt");
            }
            
            $imageDest = $imageDests . $aGraphs[$type][$i]->graphid . '.png';
                            
            if (is_file($imageDest)) {
                unlink($imageDest);
            }
                        
            $fp = fopen($imageDest, 'w');
            fwrite($fp, $output);
            fclose($fp);
        
            $aRes[$i]['imageDest'] = $imageDest;
            $aRes[$i]['imageName'] = "includes/modules/Hosting/manage_service/public_html/images/tmp/$type-" . $aGraphs[$type][$i]->graphid . '.png';
            $aRes[$i]['graphId'] = $aGraphs[$type][$i]->graphid;
            
        }
        
        
        curl_close($ch);
                
        return $aRes;
    }

}

?>