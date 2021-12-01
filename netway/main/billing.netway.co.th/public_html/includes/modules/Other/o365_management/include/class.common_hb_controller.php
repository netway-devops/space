<?php

require_once(APPDIR .'class.cache.extend.php');
include_once(APPDIR . "libs/azureapi/AzureApi.php");
include_once(APPDIR . "libs/hbapiwrapper/hbApiWrapper.php");

class AzurePartnerCenterManagementCommonHBController extends HBController {
    private $azure_resource_url = 'https://api.partnercenter.microsoft.com';
    
    protected function hbApi() {
        return new hbApiWrapper();
    }

    protected function getServersConf() 
    {
        try {
            $db         = hbm_db();
            $aQueryServersConf     = $db->query("
            SELECT  s.id
            FROM 
                hb_modules_configuration m,
                hb_servers s
            WHERE
                m.module = 'o365'
                AND m.id = s.default_module
            ")->fetchAll();
            $aServersConf = array();
            $api = new ApiWrapper();
            foreach ($aQueryServersConf as $value) {
                $aServerDetails = $api->getServerDetails(array('id' => $value['id']));
                if ($aServerDetails['success'] == 1) {
                    array_push($aServersConf, $aServerDetails['server']);
                }
            }
            if (count($aServersConf) > 0) {
                return $aServersConf;
            } else {
                throw new Exception('ไม่ได้ทำการ connection app "Azure Partner Center" . โปรดไปที่เมนู Serrings/Apps Connections และทำการ Connection App "Azure Partner Center" ให้เสร็จก่อน.');
            }
        } catch(Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    protected function connectAzurePartnerCenter()
    {
        try {
            $aServersConf = $this->getServersConf();
            $aConnectAzurePartnerCenter = array();
            foreach ($aServersConf as $conf) {
                array_push($aConnectAzurePartnerCenter, new AzureApi($this->azure_resource_url, $conf['host'],  $conf['ip'], $conf['password'], 60));
            }
            return $aConnectAzurePartnerCenter;
        } catch(Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function syncCustomersFromAzurePartnerCenter()
    {
        try {
            $aConn = $this->connectAzurePartnerCenter();
        } catch(Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function connectMicrosoftPartnerCenterWithHBServerID($serverID) {
        try {
            $aServerDetails = $this->hbApi()->getServerDetails(array('id' => $serverID));
            $aServerDetails['server']['password'] = empty($aServerDetails['server']['password']) ? 'W_QoZSkv-1fs8uU6Yo3xmF43JH_RP_7.8n' : $aServerDetails['server']['password'];
            if (empty($aServerDetails['server']) || empty($aServerDetails['server']['host']) || empty($aServerDetails['server']['ip']) || empty($aServerDetails['server']['password'])) {
                throw new Exception('Server/app connection is invalid!!');
            }
            return new AzureApi($this->azure_resource_url, $aServerDetails['server']['host'],  $aServerDetails['server']['ip'], $aServerDetails['server']['password'], 60);
        } catch(Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    public function getMicrosoftIDForAccount($accountID) {
        try {
            $aGetAccountDetails =  $this->hbApi()->getAccountDetails(array('id' => $accountID));
            if (isset($aGetAccountDetails['details'])) {
                $aAccountDetails = $aGetAccountDetails['details'];
                foreach ($aAccountDetails['custom'] as $key => $item) {
                    if ($item['variable'] == '') {

                    }
                }
            } else {
                throw new Exception('Cannot get details hostbill account ID: ' . $accountID . '!!');
            }
        } catch(Exception $error) {
            throw new Exception($error->getMessage());
        }
    }


}