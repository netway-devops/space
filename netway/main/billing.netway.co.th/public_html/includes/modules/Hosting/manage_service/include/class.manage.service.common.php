<?php

/**
 * 
 * Hostbill Manage Service Common
 * 
 * @auther Puttipong Pengprakhon <puttipong at rvglobalsoft.com>
 * 
 */

class ManageServiceCommon {
    
    /**
     * Returns a singleton ManageServiceCommon instance.
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

    public function validate_viewNamedSession($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewNamedSession)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewNamedSession)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewNamedSession($request) {
        
        $raiseError = true;
        $raiseData = array(
              'named_session_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewNamedSession($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewNamedSession)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Named session open'; // Named session open
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);             
                if (isset($graphId) && $graphId != '') {
                    
                    // Named session open
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'named-session-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/named-session-' . $graphId . '.png'
                    );
                    $raiseData['named_session_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewNamedSession)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewNamedSession)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewNamedSession',
            'preViewAs' => 'named_session',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
     
    public function validate_viewMySqlByType($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['graph_id'] = (isset($request['graph_id']) && $request['graph_id'] != '') ? $request['graph_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        $input['type'] = (isset($request['type']) && $request['type'] != '') ? $request['type'] : null;
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                    if (isset($input['graph_id'])) {
                        if (isset($input['type'])) {
                        } else {
                            $input['isValid'] = false;
                            $input['raiseError'] = '__(validate_viewMySqlByType)__ type (mysql|myisam|innodb) Missing.';
                        }
                    } else {
                        $input['isValid'] = false;
                        $input['raiseError'] = '__(validate_viewMySqlByType)__ graph_id Missing.';
                    }
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewMySqlByType)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewMySqlByType)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewMySqlByType($request) {
        
        $raiseError = true;
        $raiseData = array(
              'mysql_by_type_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewMySqlByType($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewFreeDiskSpaceByDisk)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $aParams = array(
                    'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                    'user' => $serverUsername,
                    'password' => $serverPassword,
                    'graphId' => $input['graph_id'],
                    'period' => $input['period'],
                    'imageName' => $input['type'] . '-' . $input['graph_id'] . '.png',
                    'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/' . $input['type'] . '-' . $input['graph_id'] . '.png'
                );
                $raiseData['mysql_by_type_graph'] = $api->getGraphImage($aParams);
                
            } else {
                throw new Exception("__(viewMySqlByType)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewMySqlByType',
            'preViewAs' => 'mysql_by_type',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
     
    public function validate_viewInnodb($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewInnodb)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewInnodb)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewInnodb($request) {
        
        $raiseError = true;
        $raiseData = array();
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewInnodb($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewInnodb)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {

                $aParams = array(
                    'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                    'user' => $serverUsername,
                    'password' => $serverPassword,
                    'period' => $input['period'],
                    'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/innodb-',
                    'aGraphs' => $api->getAllMySqlGraphByHostId($hostId),
                    'type' => 'innodb'
                );
                $raiseData = $api->getAllGraphMysqlImage($aParams);
                
            } else {
                throw new Exception("__(viewMyIsam)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewMyIsam',
            'preViewAs' => 'innodb',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewMyIsam($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewMyIsam)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewMyIsam)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewMyIsam($request) {
        
        $raiseError = true;
        $raiseData = array();
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewMyIsam($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewMyIsam)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {

                $aParams = array(
                    'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                    'user' => $serverUsername,
                    'password' => $serverPassword,
                    'period' => $input['period'],
                    'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/myisam-',
                    'aGraphs' => $api->getAllMySqlGraphByHostId($hostId),
                    'type' => 'myisam'
                );
                $raiseData = $api->getAllGraphMysqlImage($aParams);
                
            } else {
                throw new Exception("__(viewMyIsam)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewMyIsam',
            'preViewAs' => 'myisam',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }

    public function validate_viewMysql($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewMysql)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewMysql)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewMysql($request) {
        
        $raiseError = true;
        $raiseData = array();
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewMysql($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewMysql)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {

                $aParams = array(
                    'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                    'user' => $serverUsername,
                    'password' => $serverPassword,
                    'period' => $input['period'],
                    'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/mysql-',
                    'aGraphs' => $api->getAllMySqlGraphByHostId($hostId),
                    'type' => 'mysql'
                );
                $raiseData = $api->getAllGraphMysqlImage($aParams);
                
            } else {
                throw new Exception("__(viewMysql)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewMysql',
            'preViewAs' => 'mysql',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewFreeDiskSpaceByDisk($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['graph_id'] = (isset($request['graph_id']) && $request['graph_id'] != '') ? $request['graph_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                    if (isset($input['graph_id'])) {
                    } else {
                        $input['isValid'] = false;
                        $input['raiseError'] = '__(validate_viewFreeDiskSpaceByDisk)__ graph_id Missing.';
                    }
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewFreeDiskSpaceByDisk)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewFreeDiskSpaceByDisk)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewFreeDiskSpaceByDisk($request) {
        
        $raiseError = true;
        $raiseData = array(
              'free_disk_space_by_disk_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewFreeDiskSpaceByDisk($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewFreeDiskSpaceByDisk)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                    
                $aParams = array(
                    'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                    'user' => $serverUsername,
                    'password' => $serverPassword,
                    'graphId' => $input['graph_id'],
                    'period' => $input['period'],
                    'imageName' => 'free-disk-space-' . $input['graph_id'] . '.png',
                    'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/free-disk-space-' . $input['graph_id'] . '.png'
                );
                $raiseData['free_disk_space_by_disk_graph'] = $api->getGraphImage2($aParams);
                
            } else {
                throw new Exception("__(viewFreeDiskSpaceByDisk)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewFreeDiskSpaceByDisk',
            'preViewAs' => 'free_disk_space_by_disk',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewFreeDiskSpace($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewFreeDiskSpace)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewFreeDiskSpace)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewFreeDiskSpace($request) {
        
        $raiseError = true;
        $raiseData = array();
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewFreeDiskSpace($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewFreeDiskSpace)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {

                $aParams = array(
                    'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                    'user' => $serverUsername,
                    'password' => $serverPassword,
                    'period' => $input['period'],
                    'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/free-disk-space-',
                    'aGraphs' => $api->getAllFreeDiskSpaceGraphByHostId($hostId)
                );
                $raiseData = $api->getAllGraphFreeDiskSpaceImage($aParams);
                
            } else {
                throw new Exception("__(viewFreeDiskSpace)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewFreeDiskSpace',
            'preViewAs' => 'free_disk_space',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewSwapUsage($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewSwapUsage)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewSwapUsage)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewSwapUsage($request) {
        
        $raiseError = true;
        $raiseData = array(
              'swap_usage_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewSwapUsage($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewSwapUsage)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Swap usage'; // Swap usage
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);             
                if (isset($graphId) && $graphId != '') {
                    
                    // Swap usage
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'swap-usage-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/swap-usage-' . $graphId . '.png'
                    );
                    $raiseData['swap_usage_graph'] = $api->getGraphImage2($aParams);
                    
                } else {
                    throw new Exception("__(viewSwapUsage)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewSwapUsage)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewSwapUsage',
            'preViewAs' => 'swap_usage',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_doRecreate($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        
        if (isset($input["account_id"]) && isset($input["server_id"]) && isset($input["client_id"])) {
        } else {
            if (isset($input["account_id"])) {
                if (isset($input["server_id"])) {
                    if (isset($input["client_id"])) {
                    } else {
                        $input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doRecreate)__ client_id Missing.";
                    }
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doRecreate)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doRecreate)__ account_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function doRecreate($request) {

        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_doRecreate($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doRecreate)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
            // Clean Manage Service
            $request = array(
               "server_hostname" => $serverHostname,
               "server_username" => $serverUsername,
               "server_password" => $serverPassword,
               "account_id" => $input['account_id']
            );
            $aResponse = ManageServiceCommon::singleton()->doCleanManageService($request);
            if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != '') {
                 throw new Exception("__(doRecreate)__ " . $aResponse['raiseError']);
            }
            
            
            // ReCreate Manage Service
            $request = array(
               "server_hostname" => $serverHostname,
               "server_username" => $serverUsername,
               "server_password" => $serverPassword,
               "account_id" => $input['account_id'],
               "client_id" => $input['client_id']
            );
            $aResponse = ManageServiceCommon::singleton()->doCreateManageService($request);
            if (isset($aResponse['raiseError']) && $aResponse['raiseError'] != '') {
                throw new Exception("__(doRecreate)__ " . $aResponse['raiseError']);
            }
            
            
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
            
            echo '<!-- {"ERROR":["' . $raiseError . '"],"INFO":[]'
                . ',"HTML":""'
                . ',"STACK":0} -->';
            exit;
            
        }
        
        echo '<!-- {"ERROR":[],"INFO":["re-create account"],"STACK":0} -->';
        exit;
        
        return true;
    }
    
    public function validate_doCleanManageService($request) {
        $input = array( 
                "isValid" => true,
                "raiseError" => ""
        );
        
        // Variable Default
        // Connect Zabbix
        $input["server_hostname"] = (isset($request["server_hostname"]) && $request["server_hostname"] != "") ? $request["server_hostname"] : null;
        $input["server_username"] = (isset($request["server_username"]) && $request["server_username"] != "") ? $request["server_username"] : null;
        $input["server_password"] = (isset($request["server_password"]) && $request["server_password"] != "") ? $request["server_password"] : null;
        
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        
    
        if (isset($input["server_hostname"]) && isset($input["server_username"]) && isset($input["server_password"])) {
            if (isset($input["account_id"])) {
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doCleanManageService)__ account_id Missing.";
            }
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doCleanManageService)__ Servers zabbix missing. Please check products connect with app zabbix on Hostbill.";
        }
               
        return $input;
    }
    
    public function doCleanManageService($request) {
        
        $raiseError = '';
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_doCleanManageService($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
                        
            // Zabbix Connect By Root
            $api = ManageZabbixApi::singleton();
            $api->_connect($input["server_hostname"], $input["server_username"], $input["server_password"]);
            
            // 1 บน zabbix: ถ้ามี action [a-__hb_account_id__*] ให้ delete ยกเว้น [a-__hb_account_id__-ping]
            $aParams = array();                
            $aActions = $api->getAllActionByAccountId($input["account_id"]);
            if (count($aActions)>0) {
                for ($i=0;$i<count($aActions);$i++) {
                    if ($aActions[$i]->name == 'a-' . $input["account_id"] . '-ping') {
                    } else {
                        array_push($aParams, $aActions[$i]->actionid);
                    }
                }
            }
            if (count($aParams)>0) {
                $api->_actionDelete($aParams);
            }
            
            // 2 บน zabbix: ลบ host group 'Managed Services Host Group'
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $aHostGroup = $api->getHostGroupByVisibleHostName($visibleHostName);
            
            if ($aHostGroup['isGroupManange'] == true) {
                if (isset($aHostGroup['group_id']) && count($aHostGroup['group_id'])>0) {
                    for ($i=0;$i<count($aHostGroup['group_id']);$i++) {
                        if ($aHostGroup['group_id'][$i]['groupid'] == 34) { // Fix 34
                            unset($aHostGroup['group_id'][$i]);
                        }
                    }
                }
                if (count($aHostGroup['group_id'])>0) {
                    $aHostGroup['group_id'] = array_values($aHostGroup['group_id']);
                    
                    $aParams = array();
                    $aParams['host']['visiblehost'] = $visibleHostName;
                    $aParams['host']['groups'] = $aHostGroup['group_id'];
                    
                    $api->rvcustom_createUpdateHostGroup($aParams);
                }
            }
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'doCleanManageService'
        );
        
        return $aResponse;
    }
    
    public function validate_doActions($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["action_id"] = (isset($request["action_id"]) && $request["action_id"] != "") ? $request["action_id"] : null;
        $input["status"] = (isset($request["status"]) && $request["status"] != "") ? $request["status"] : "0";
        $input["esc_period"] = (isset($request["esc_period"]) && $request["esc_period"] != "") ? $request["esc_period"] : "600";       
        
        if (isset($input["account_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["account_id"])) {
                if (isset($input['action_id'])) {
                    if (isset($input["server_id"])) {
                    } else {
                        $input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doActions)__ server_id Missing.";
                    }
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doActions)__ action_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doActions)__ account_id Missing.";
            }
        }
        
        return $input;
    }

    public function doActions($request) {
        
        $raiseError = true;
        
        $raiseData = array();
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_doActions($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doActions)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            $api->doActionUpdateStatus($input['action_id'], $input["status"]);
            $api->doActionUpdateEscPeriod($input['action_id'], $input["esc_period"]);
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "doActions",
            "preViewAs" => "",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewActions($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewActions)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewActions)__ account_id Missing.';
            }
        }
        
        return $input;
    }
    
    
    public function viewActions($request) {
        
        $raiseError = true;
        $raiseData = array();
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewActions($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(viewActions)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            $raiseData = $api->getAllActionByAccountId($input['account_id']);
            $raiseData['trigger'] = $api->getAllTriggerByHostId($api->getHostIdByVisibleHostName('h-' . $input['account_id'] . '_')); 
            
  
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => 'viewActions',
            "preViewAs" => 'actions',
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_doCreateManageService($request) {
        $input = array( 
                'isValid' => true,
                'raiseError' => ''
        );
        
        // Variable Default
        // Connect Zabbix
        $input["server_hostname"] = (isset($request["server_hostname"]) && $request["server_hostname"] != "") ? $request["server_hostname"] : null;
        $input["server_username"] = (isset($request["server_username"]) && $request["server_username"] != "") ? $request["server_username"] : null;
        $input["server_password"] = (isset($request["server_password"]) && $request["server_password"] != "") ? $request["server_password"] : null;
        
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;        
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        
        if (isset($input["server_hostname"]) && isset($input["server_username"]) && isset($input["server_password"])) {
            if (isset($input["account_id"])) {
                if (isset($input["client_id"])) {
                    if (ManageServiceDao::singleton()->isCheckBoxManagedByAccountId($input["account_id"]) == true) {
                    } else {
                        $input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doCreateManageService)__ Please check box at content 'Netway 'worry free' server management services (CentOS) and 'Save Changes'. and Check 'Products & Services'.";
                    }
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doCreateManageService)__ client_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doCreateManageService)__ account_id Missing.";
            }
        } else {
            $input["isValid"] = false;
            $input["raiseError"] = "__(validate_doCreateManageService)__ Servers zabbix missing. Please check products connect with app zabbix on Hostbill.";
        }
        
        return $input;
    }

    public function doCreateManageService($request) {
        $raiseError = '';
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_doCreateManageService($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Zabbix Connect By Root
            $api = ManageZabbixApi::singleton();
            $api->_connect($input["server_hostname"], $input["server_username"], $input["server_password"]);
            
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $userAlias = 'u-' . $input['client_id'];
            
            // ตรวจสอบ บน zabbix: เป็น zabbix agentd หรือไม่
            $aHost = $api->getHostMixValuesByVisibleHostName($visibleHostName);
            if ($aHost['isAgentd'] == true) {
            } else {
                throw new Exception('App "Manage Service" Require Zabbix Agentd. Please install zabbix agentd.');
            }
            
            // ขั้นตอนการทำงาน เมื่อ click create manage_service app
            // 1. บน zabbix: create action [a-__hb_account_id__-cpu-processor-load-high]
            // 2. บน zabbix: create action [a-__hb_account_id__-memory-lack-free-swap]
            // 3. บน zabbix: create action [a-__hb_account_id__-memory-lack-available-memory]
            // 4. บน zabbix: create action [a-__hb_account_id__-disk-io-overload]
            // 5. บน zabbix: create action [a-__hb_account_id__-mysql-thread-more-than-100]
            // 6. บน zabbix: create action [a-__hb_account_id__-mysql-connection-utilization-more-than-95]
            // 7. บน zabbix: create action [a-__hb_account_id__-mysql-down]
            // 8. บน zabbix: create action [a-__hb_account_id__-exim-queue-more-than-1000]
            // 9. บน zabbix: create action [a-__hb_account_id__-nginx-down]
            
            $aParams = array();
            $aParams['action']['userid'] = $api->getUserIdByUserAlias($userAlias);
            
            if (isset($aParams['action']['userid'])) {
                $aParams['action']['hostid'] = $api->getHostIdByVisibleHostName($visibleHostName);
                if (isset($aParams['action']['hostid'])) {
                    
                    $aTrigger = $api->getAllTriggerByHostId($aParams['action']['hostid']);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-cpu-processor-load-high';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-cpu-processor-load-high'];
                    $api->rvcustom_createActionTriggerCpuProcessorLoadToHigh($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-memory-lack-free-swap';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-memory-lack-free-swap'];
                    $api->rvcustom_createActionTriggerMemoryLackFreeSwap($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-memory-lack-available';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-memory-lack-available'];
                    $api->rvcustom_createActionTriggerMemoryLackAvailable($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-disk-io-overload';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-disk-io-overload'];
                    $api->rvcustom_createActionTriggerDiskIoOverload($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-free-disk-space-volume-';
                    $api->rvcustom_createActionTriggerDiskSpace($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-mysql-thread-more-than-100';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-mysql-thread-more-than-100'];
                    $api->rvcustom_createActionTriggerMysqlThreadMore100($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-mysql-connection-utilization-more-than-95';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-mysql-connection-utilization-more-than-95'];
                    $api->rvcustom_createActionTriggerMysqlConnectionUtilizationMore95($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-mysql-down';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-mysql-down'];
                    $api->rvcustom_createActionTriggerMysqlDown($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-exim-queue-more-than-1000';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-exim-queue-more-than-1000'];
                    $api->rvcustom_createActionTriggerEximQuereMore1000($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-nginx-down';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-nginx-down'];
                    $api->rvcustom_createActionTriggerNginxDown($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-apache-down';
                    $aParams['action']['description'] = $aTrigger['description']['trigger-apache-down'];
                    $api->rvcustom_createActionTriggerApacheDown($aParams);
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-raid-divice-status-';
                    $api->rvcustom_createActionTriggerRaidDeviceStatus($aParams);
                    
                    // รอ payment gateway ใหม่
                    // $aParams['action']['name'] = 'a-' . $input['account_id'] . '-ping-sms';
                    // $api->rvcustom_createActionTriggerPingSms($aParams); 
                    
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-named-down';
                    $api->rvcustom_createActionTriggerNamedDown($aParams);
                           
                    $aParams['action']['name'] = 'a-' . $input['account_id'] . '-ping';
                    $api->rvcustom_updateActionTriggerPing($aParams);
                    
                } else {
                    throw new Exception("__(doCreateManageService)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
                }
            } else {
                throw new Exception('__(doCreateManageService)__ Cannot get user_id. Please Check Zabbix User Media Name ' . $userAlias);
            }
            
            
            // 1. บน zabbix: add host เข้า 'Managed Services Host Group'
            $aParams['host']['visiblehost'] = $visibleHostName;            
            $aHostGroup = $api->getHostGroupByVisibleHostName($aParams['host']['visiblehost']);
            if ($aHostGroup['isGroupManange'] == true) {
                // Host exits in host group 'Managed Services Host Group'
            } else {
                array_push($aHostGroup['group_id'], array('groupid' => 34)); #Fix ID 'Managed Services Host Group'
                $aParams['host']['groups'] = $aHostGroup['group_id'];
                $api->rvcustom_createUpdateHostGroup($aParams);
            }
            
            
            //echo '<pre>';
            //echo 'xx';
            //print_r($api->rvcustom_rvtest());
            //print_r($api->getAllActionByAccountId($input['account_id']));
            //exit;
            
            
            
            
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'doCreateManageService'
        );
        
        return $aResponse;
    }
    
    public function validate_doDeleteUserMedia($request) {
 
        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["account_id"] = (isset($request["account_id"]) && $request["account_id"] != "") ? $request["account_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["media_id"] = (isset($request["media_id"]) && $request["media_id"] != "") ? $request["media_id"] : null;
        
        if (isset($input["account_id"]) && isset($input["server_id"]) && isset($input["media_id"])) {
        } else {
            if (isset($input["account_id"])) {
                if (isset($input["server_id"])) {
                    if (isset($input["media_id"])) {
                    } else {
                        $input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doDeleteUserMedia)__ media_id Missing.";
                    }
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doDeleteUserMedia)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doDeleteUserMedia)__ account_id Missing.";
            }
        }
        
        return $input;
    }
    
    public function doDeleteUserMedia($request) {
        
        $raiseError = true;
        $raiseData = array();
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_doDeleteUserMedia($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Graph Id By 
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doDeleteUserMedia)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            $api->doUserDeleteMedia(array($input["media_id"]));
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'doDeleteUserMedia',
            'preViewAs' => '',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }

    public function validate_doAddUserMedia($request) {
 
        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        $input["emailName"] = (isset($request["emailName"]) && $request["emailName"] != "") ? $request["emailName"] : null;
        
        if (isset($input["client_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["client_id"])) {
                if (isset($input["server_id"])) {
                    if (isset($input["emailName"])) {
                    } else {
                        $input["isValid"] = false;
                        $input["raiseError"] = "__(validate_doAddUserMedia)__ Email Not Empty.";
                    }
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_doAddUserMedia)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_doAddUserMedia)__ client_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function doAddUserMedia($request) {
        
        $raiseError = true;
        $raiseData = array(
            'aMedia' => array(
                'mediaid' => ''
            )
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_doAddUserMedia($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Graph Id By 
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(doAddUserMedia)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            
            $userAlias = "u-" . $input["client_id"];
            $userID = $api->getUserIdByUserAlias($userAlias);
            if (isset($userID) && $userID != "") {
                if ($api->isUserMediaEmailNameExists($userID, $input["emailName"])) {
                    throw new Exception("__(doAddUserMedia)__ Email " . $input["emailName"] . " exists. User Media Name " . $userAlias);
                } else {
                    $aResAddMedia = $api->doUserAddMedia($userID, $input["emailName"]);
                    $raiseData['aMedia']['mediaid'] = (isset($aResAddMedia->mediaids[0])) ? $aResAddMedia->mediaids[0] : "";
                }
            } else {
                throw new Exception('__(doAddUserMedia)__ Cannot get user_id. Please Check Zabbix User Media Name ' . $userAlias);
            }
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'doAddUserMedia',
            'preViewAs' => '',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }

    
    public function validate_viewUserMedia($request) {

        $input = array( 
            "isValid" => true,
            "raiseError" => ""
        );
        
        // Variable Default
        $input["client_id"] = (isset($request["client_id"]) && $request["client_id"] != "") ? $request["client_id"] : null;
        $input["server_id"] = (isset($request["server_id"]) && $request["server_id"] != "") ? $request["server_id"] : null;
        
        if (isset($input["client_id"]) && isset($input["server_id"])) {
        } else {
            if (isset($input["client_id"])) {
                if (isset($input["server_id"])) {
                } else {
                    $input["isValid"] = false;
                    $input["raiseError"] = "__(validate_viewUserMedia)__ server_id Missing.";
                }
            } else {
                $input["isValid"] = false;
                $input["raiseError"] = "__(validate_viewUserMedia)__ client_id Missing.";
            }
        }
        
        return $input;
    }
    
    
    public function viewUserMedia($request) {
        
        $raiseError = true;
        
        $raiseData = array(
            'aMedia' => array()
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewUserMedia($request);
            if ($input["isValid"] == false) {
                throw new Exception($input["raiseError"]);
            }
            
            // Get Graph Id By 
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input["server_id"]);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer["server"]["host"]) && $aServer["server"]["host"] != "") ? $aServer["server"]["host"] : "";
                $serverUsername = (isset($aServer["server"]["username"]) && $aServer["server"]["username"] != "") ? $aServer["server"]["username"] : "";
                $serverPassword = (isset($aServer["server"]["password"]) && $aServer["server"]["password"] != "") ? $aServer["server"]["password"] : "";
            } else {
                throw new Exception("__(viewUserMedia)__ Cannot get server zabbix by id " . $input["server_id"] . " Please check server_id.");
            }
            
            
             // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
         
            $userAlias = "u-" . $input["client_id"];
            $userID = $api->getUserIdByUserAlias($userAlias);
            if (isset($userID) && $userID != "") {
                $raiseData['aMedia'] = $api->getUserMediaByUserId($userID);
            } else {
                throw new Exception("__(viewUserMedia)__ Cannot get user_id. Please Check Zabbix User Media Name" . $userAlias);
            }
            
            
        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            "raiseError" => $raiseError,
            "action" => "viewUserMedia",
            "preViewAs" => "user_media",
            "raiseData" => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewNginxThread($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewNginxThread)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewNginxThread)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewNginxThread($request) {
        
        $raiseError = true;
        $raiseData = array(
              'nginx_thread_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewNginxThread($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewNginxThread)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Nginx - Threads status'; // Nginx - Threads status
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);             
                if (isset($graphId) && $graphId != '') {
                    
                    // Get Nginx - Threads status
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'nginx-thread-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/nginx-thread-' . $graphId . '.png'
                    );
                    $raiseData['nginx_thread_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewNginxThread)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewNginxThread)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewNginxThread',
            'preViewAs' => 'nginx_thread',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
   
    public function validate_viewNginxConnect($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewNginxConnect)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewNginxConnect)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewNginxConnect($request) {
        
        $raiseError = true;
        $raiseData = array(
              'nginx_connect_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewNginxConnect($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewNginxConnect)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Nginx - Connections and Requests status'; // Nginx - Connections and Requests status
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);             
                if (isset($graphId) && $graphId != '') {
                    
                    // Get Nginx - Connections and Requests status
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'nginx-connect-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/nginx-connect-' . $graphId . '.png'
                    );
                    $raiseData['nginx_connect_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewNginxConnect)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewNginxConnect)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewNginxConnect',
            'preViewAs' => 'nginx_connect',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
   
   
    public function validate_viewEximTraffic($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewEximTraffic)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewEximTraffic)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewEximTraffic($request) {
        
        $raiseError = true;
        $raiseData = array(
              'exim_traffic_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewEximTraffic($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewEximTraffic)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Exim Traffic Size'; // Exim Traffic Size
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get Exim Traffic Size
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'exim-traffic-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/exim-traffic-' . $graphId . '.png'
                    );
                    $raiseData['exim_traffic_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewEximTraffic)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewEximTraffic)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewEximTraffic',
            'preViewAs' => 'exim_traffic',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewEximStatistic($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewEximStatistic)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewEximStatistic)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewEximStatistic($request) {
        
        $raiseError = true;
        $raiseData = array(
              'exim_statistic_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewEximStatistic($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewEximStatistic)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Exim Statistics'; // Exim Statistics
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get Exim Statistics
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'exim-statistic-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/exim-statistic-' . $graphId . '.png'
                    );
                    $raiseData['exim_statistic_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewEximStatistic)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewEximStatistic)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewEximStatistic',
            'preViewAs' => 'exim_statistic',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewMysqlThread($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewMysqlThread)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewMysqlThread)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewMysqlThread($request) {
        
        $raiseError = true;
        $raiseData = array(
              'mysql_thread_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewMysqlThread($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewMysqlThread)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'MySQL Threads'; // MySQL Threads
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get MySQL Threads
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'mysql-thread-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/mysql-thread-' . $graphId . '.png'
                    );
                    $raiseData['mysql_thread_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewMysqlThread)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewMysqlThread)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewMysqlThread',
            'preViewAs' => 'mysql_thread',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewMysqlConnect($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewMysqlConnect)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewMysqlConnect)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewMysqlConnect($request) {
        
        $raiseError = true;
        $raiseData = array(
              'mysql_connect_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewMysqlConnect($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewMysqlConnect)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'MySQL Connections'; // MySQL Connections
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get MySQL Connections
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'mysql-connect-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/mysql-connect-' . $graphId . '.png'
                    );
                    $raiseData['mysql_connect_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewMysqlConnect)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewMysqlConnect)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewMysqlConnect',
            'preViewAs' => 'mysql_connect',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
 
    public function validate_viewApacheStat($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewApacheStat)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewApacheStat)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewApacheStat($request) {
        
        $raiseError = true;
        $raiseData = array(
              'apache_stat_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewApacheStat($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewApacheStat)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Apache Stats'; // Apache Stats
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get Apache Stats
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'apache-stat-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/apache-stat-' . $graphId . '.png'
                    );
                    $raiseData['apache_stat_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewApacheStat)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewApacheStat)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewApacheStat',
            'preViewAs' => 'apache_stat',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
    
    public function validate_viewMemoryUsage($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewMemoryUsage)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewMemoryUsage)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewMemoryUsage($request) {
        
        $raiseError = true;
        $raiseData = array(
              'memory_usage_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewMemoryUsage($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewMemoryUsage)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'Memory Usage'; // Memory Usage
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get Graph CPU Load
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'memory-usage-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/memory-usage-' . $graphId . '.png'
                    );
                    $raiseData['memory_usage_graph'] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewMemoryUsage)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewMemoryUsage)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewMemoryUsage',
            'preViewAs' => 'memory_usage',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }

    public function validate_viewCpuJump($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewCpuJump)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewCpuJump)__ account_id Missing.';
            }
        }
        
        return $input;
    }

    public function viewCpuJump($request) {
        
        $raiseError = true;
        $raiseData = array(
              'cpu_jump_graph' => '' 
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewCpuJump($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewCpuJump)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'CPU jumps'; // CPU Jump
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get CPU Jump
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'cpu-jump-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/cpu-jump-' . $graphId . '.png'
                    );
                    $raiseData["cpu_jump_graph"] = $api->getGraphImage($aParams);
                    
                } else {
                    throw new Exception("__(viewCpuJump)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewCpuJump)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewCpuJump',
            'preViewAs' => 'cpu_jump',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }
     
    public function validate_viewCpuLoad($request) {

        $input = array( 
            'isValid' => true,
            'raiseError' => ''
        );
        
        // Variable Default
        $input['account_id'] = (isset($request['account_id']) && $request['account_id'] != '') ? $request['account_id'] : null;
        $input['server_id'] = (isset($request['server_id']) && $request['server_id'] != '') ? $request['server_id'] : null;
        $input['period'] = (isset($request['period']) && $request['period'] != '') ? ($request['period'] * 3600 * 24) : '86400';
        
        if (isset($input['account_id']) && isset($input['server_id'])) {
        } else {
            if (isset($input['account_id'])) {
                if (isset($input['server_id'])) {
                } else {
                    $input['isValid'] = false;
                    $input['raiseError'] = '__(validate_viewCpuLoad)__ server_id Missing.';
                }
            } else {
                $input['isValid'] = false;
                $input['raiseError'] = '__(validate_viewCpuLoad)__ account_id Missing.';
            }
        }
        
        return $input;
    }
    
    
    public function viewCpuLoad($request) {
        
        $raiseError = true;
        $raiseData = array(
              'cpu_load_graph' => ''
        );
        
        try {
            
            // Validate
            $input = ManageServiceCommon::singleton()->validate_viewCpuLoad($request);
            if ($input['isValid'] == false) {
                throw new Exception($input['raiseError']);
            }
            
            // Get Server Zabbix
            $aServer = ManageHostbillApi::singleton()->getServerDetailsByServerId($input['server_id']);
            if (isset($aServer['success']) && $aServer['success'] == 1) {
                $serverHostname = (isset($aServer['server']['host']) && $aServer['server']['host'] != '') ? $aServer['server']['host'] : '';
                $serverUsername = (isset($aServer['server']['username']) && $aServer['server']['username'] != '') ? $aServer['server']['username'] : '';
                $serverPassword = (isset($aServer['server']['password']) && $aServer['server']['password'] != '') ? $aServer['server']['password'] : '';
            } else {
                throw new Exception('__(viewCpuLoad)__ Cannot get server zabbix by id ' . $input['server_id'] . ' Please check server_id.');
            }
            
            // Zabbix Connect
            $api = ManageZabbixApi::singleton();
            $api->_connect($serverHostname, $serverUsername, $serverPassword);
            
            // Get Host Id
            $visibleHostName = 'h-' . $input['account_id'] . '_';
            $hostId = $api->getHostIdByVisibleHostName($visibleHostName);
            
            if (isset($hostId) && $hostId != '') {
                
                $graphName = 'CPU load'; // CPU Load
                $graphId = $api->getGraphIdByHostIdGraphName($hostId, $graphName);                
                if (isset($graphId) && $graphId != '') {
                    
                    // Get Graph CPU Load
                    $aParams = array(
                        'url' => preg_replace("/api_jsonrpc.php/", "", $serverHostname),
                        'user' => $serverUsername,
                        'password' => $serverPassword,
                        'graphId' => $graphId,
                        'period' => $input['period'],
                        'imageName' => 'cpu-load-' . $graphId . '.png',
                        'imageDest' => APPDIR_MODULES . 'Hosting/manage_service/public_html/images/tmp/cpu-load-' . $graphId . '.png'
                    );
                    $raiseData["cpu_load_graph"] = $api->getGraphImage($aParams);
                    
                    
                } else {
                    throw new Exception("__(viewCpuLoad)__ Cannot get graph_id. Please install zabbix agentd from visible host name " . $visibleHostName);
                }
                
                
                
            } else {
                throw new Exception("__(viewCpuLoad)__ Cannot get host_id. Please Check Zabbix server visible host name " . $visibleHostName);
            }


            

        } catch (Exception $e) {
            $raiseError = $e->getMessage();
        }
        
        $aResponse = array(
            'raiseError' => $raiseError,
            'action' => 'viewCpuLoad',
            'preViewAs' => 'cpu_load',
            'raiseData' => $raiseData
        );
        
        return $aResponse;
    }


    public function getUrlImage() {
        
        // return "http://192.168.1.189/hostbill.net/public_html/includes/modules/Hosting/manage_service/public_html/images/";
        return "https://netway.co.th/includes/modules/Hosting/manage_service/public_html/images/";
        // return "https://127.0.0.1/includes/modules/Hosting/manage_service/public_html/images/";
        
    }
     
    
}