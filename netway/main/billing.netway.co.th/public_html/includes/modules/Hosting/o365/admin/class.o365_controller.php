<?php
#@LICENSE@#
require_once(APPDIR .'class.cache.extend.php');
include_once(APPDIR . "libs/azureapi/AzureApi.php");
include_once(APPDIR . "libs/hbapiwrapper/hbApiWrapper.php");
class o365_controller extends HBController 
{
    protected $moduleName = 'o365';
    private $azure_resource_url = 'https://api.partnercenter.microsoft.com';

    public function view($request) 
    {

    }
    
    public function accountdetails($params) 
    {
        try {
            $db        =    hbm_db();
            $accountInfo    =    $params['account'];
            $api = new hbApiWrapper();
            $aGetConfigItemsCatByAccountID = $api->getConfigItemsCatByAccountID($accountInfo['id']);                                        
            $accountConfig    =    $aGetConfigItemsCatByAccountID['config_items_cat'];                
            $o365DetailTPL    =    APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/admin/o365.accounts_management.tpl';
            $this->template->assign('custom_template', $o365DetailTPL);
            $this->template->assign('csslocation', APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/admin/accounts_management.css');
            $this->template->assign('jslocation', APPDIR_MODULES . 'Hosting/' . $this->moduleName . '/templates/admin/accounts_management.js.tpl');
            $this->template->assign('accounts', $accountInfo);
            $this->template->assign('accountConfig', $accountConfig);
            
            foreach($accountConfig as $accData){
                if($accData['variable'] == 'domain_name'){
                    $domainName    =    $accData['data'];
                }
            }
            $this->template->assign('domainName', $domainName);
            $this->template->assign('modifyDomain', str_replace('.', '-', $domainName));
        } catch (Exception $error) {
            $this->onError($error->getMessage());
        }
    }
    
    public function productdetails($params)
    {
    }

    public function addTxtRecord($request)
    {
        $domainName = (isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $txtdata = (isset($request['txtdata']) && $request['txtdata'] != "") ? $request['txtdata'] : null;
        $db = hbm_db();
        $check = false;
        
        if (isset($domainName)) {
            
            $query = sprintf("   
                SELECT
                    hbmc.config
                FROM
                    %s hbmc
                WHERE
                    hbmc.module='cpaneldnszonehandle'
                "
            , "hb_modules_configuration");
                    
            $aRes = $db->query($query)->fetchAll();
        
            $aConf = (count($aRes) > 0 && isset($aRes[0]["config"])) 
                ? unserialize($aRes[0]["config"]) 
                : array();
            if (count($aConf)>0 
                && isset($aConf['DNS Server3 IP']['value']) && $aConf['DNS Server3 IP']['value'] != ''
                && isset($aConf['DNS Server3 WHM Username']['value']) && $aConf['DNS Server3 WHM Username']['value'] != ''
                && isset($aConf['DNS Server3 WHM Hash']['value']) && $aConf['DNS Server3 WHM Hash']['value'] != '') {
                
                if (function_exists('curl_init')) {

                    $user = $aConf['DNS Server3 WHM Username']['value'];
                    $dnsServer = $aConf['DNS Server3 IP']['value'];
                    $remoteAccesskey = $aConf['DNS Server3 WHM Hash']['value'];
                    
                    $cleanaccesshash = preg_replace("'(\r|\n)'","", $remoteAccesskey);
                    $authstr = $user . ":" . $cleanaccesshash;
                    
                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    curl_setopt($ch, CURLOPT_URL, 'https://' . $dnsServer . ':2087/json-api/addzonerecord?api.version=1&domain=' . $domainName . '&name=' . $domainName .'.&class=IN&ttl=3600&type=TXT&txtdata=' . $txtdata );
                    
                    curl_setopt($ch, CURLOPT_HEADER, 0);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                    $curlheaders[0] = "Authorization: WHM $authstr";
                    $curlheaders[1] = "Referer: " . $referer;
                    curl_setopt($ch, CURLOPT_HTTPHEADER, $curlheaders);
                    $output = curl_exec($ch);
                    curl_close($ch);
                    
                    $aOutput = json_decode($output);
                    $check =    true;    
                    $msg =    $aOutput;    
                    
                } else {
                    $msg = 'Error: curl function not exits.';
                }
            } else {
                $msg = 'Error: no server config.';
            }    
        } else {
            $msg = 'Error: no domain name.';
        }

        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", array(
            'data'   => $check,
            'msg'    => $msg
        ));
        $this->json->show();
    }
    
    public function checkTxtRecordForVerifyDomain($request)
    {
            
        $result = $this->getDnsRecordLine($request);
        $check  = TRUE;
        if ($result['isError'] != 1) {
            if(!empty($result)){
                $msg = 'สามารถเพิ่มได้';
                foreach ($result as $line) {    
                    if ($line->type == 'TXT' && $line->txtdata == $request['txtdata']) {
                        $check = FALSE; 
                        $msg   = 'มี TXT Record นี้อยู่เเล้ว';
                        break;
                    }    
                }
            }
        } else if($result['isError'] == 1) {
            $check = FALSE; 
            $msg   = $result['res']->metadata->reason;
        }
        
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign("aResponse", array(
            'data' => $check, // true : ยังไม่มี txt record
            'msg'  => $msg
        ));
        $this->json->show();
    }
    
    public function getDnsRecordLine($request)
    {
            
        $result = $this->dumpzone($request);
        if (isset($result->data->zone)) {
            $aRecord = $result->data->zone[0]->record;    
        } else {
            $aRecord = array(
                'isError' => 1,
                'res'     => $result
            );
        }
        return $aRecord;
    }
    
    public function dumpzone($request)
    {
                
        $domainName = (isset($request['domainName']) && $request['domainName'] != "") ? $request['domainName'] : null;
        $db = hbm_db();
        $res = false;
        
        if (isset($domainName)) {
            $query = sprintf("
                SELECT
                    hbmc.config
                FROM
                    %s hbmc
                WHERE
                    hbmc.module='cpaneldnszonehandle'
            ", "hb_modules_configuration");
                    
            $aRes = $db->query($query)->fetchAll();
        
            $aConf = (count($aRes) > 0 && isset($aRes[0]["config"])) 
                ? unserialize($aRes[0]["config"]) 
                : array();
            if (count($aConf) > 0 
                && isset($aConf['DNS Server3 IP']['value']) && $aConf['DNS Server3 IP']['value'] != ''
                && isset($aConf['DNS Server3 WHM Username']['value']) && $aConf['DNS Server3 WHM Username']['value'] != ''
                && isset($aConf['DNS Server3 WHM Hash']['value']) && $aConf['DNS Server3 WHM Hash']['value'] != '') {
                
                if (function_exists('curl_init')) {
                    $user = $aConf['DNS Server3 WHM Username']['value'];
                    $dnsServer = $aConf['DNS Server3 IP']['value'];
                    $remoteAccesskey = $aConf['DNS Server3 WHM Hash']['value'];                  
                    $cleanaccesshash = preg_replace("'(\r|\n)'","", $remoteAccesskey);
                    $authstr = $user . ":" . $cleanaccesshash;

                    $ch = curl_init();
                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                    curl_setopt($ch, CURLOPT_URL, 'https://' . $dnsServer . ':2087/json-api/dumpzone?api.version=1&domain=' . $domainName);
                        
                    curl_setopt($ch, CURLOPT_HEADER, 0);
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                    $curlheaders[0] = "Authorization: WHM $authstr";
                    $curlheaders[1] = "Referer: " . $referer;
                    curl_setopt($ch, CURLOPT_HTTPHEADER, $curlheaders);
                    $output = curl_exec($ch);
                    curl_close($ch);
                    
                    $aOutput = json_decode($output);
                }
            }
        }
        return $aOutput;
    }
    
    public function editO365Dns($request)
    {
        
        $domainName = (isset($request['domainName']) && $request['domainName'] != "") 
            ? $request['domainName'] 
            : null;
        $mxData = (isset($request['exMxPta']) && $request['exMxPta'] != "") 
            ? $request['exMxPta'] 
            : null;
        $hostname = (isset($request['hostname']) && $request['hostname'] != "") 
            ? $request['hostname'] 
            : null;
        $res = $this->dumpzone(array('domainName' => $domainName));
        if (isset($res->data->zone)) {
            $db             = hbm_db();
            $allRecord      = $this->getDnsRecordLine(array('domainName'    =>    $domainName));
            $mxLine         = -1;
            $exCnameLine    = -1;
            $exTxtLine      = -1;
            $skSrvLine      = -1;
            $skSrvLine1     = -1;
            $skCnameLine    = -1;
            $skCnameLine1   = -1;
            $mbCnameLine    = -1;
            $mbCnameLine1   = -1;
            $adCnameLine    = -1;
            
            foreach ($allRecord as $record) {
                if ($record->type == 'MX' && $record->preference == '0') {
                    $mxLine = $record->Line;
                }
                if($record->type == 'CNAME' && $record->name == 'autodiscover.' . $hostname) {
                    $exCnameLine = $record->Line;
                }
                if ($record->type == 'TXT' && $record->txtdata == 'v=spf1 include:spf.protection.outlook.com -all') {
                    $exTxtLine = $record->Line;
                }
                if ($record->type == 'SRV' && $record->port == '443') {
                    $skSrvLine = $record->Line;
                }
                if ($record->type == 'SRV' && $record->port == '5061') {
                    $skSrvLine1 = $record->Line;
                }
                if ($record->type == 'CNAME' && $record->name == 'sip.' . $hostname) {
                    $skCnameLine = $record->Line;
                }
                if ($record->type == 'CNAME' && $record->name == 'lyncdiscover.' . $hostname) {
                    $skCnameLine1 = $record->Line;
                }
                if ($record->type == 'CNAME' && $record->name == 'enterpriseregistration.' . $hostname) {
                    $mbCnameLine = $record->Line;
                }
                if ($record->type == 'CNAME' && $record->name == 'enterpriseenrollment.' . $hostname) {
                    $mbCnameLine1 = $record->Line;
                }
                if ($record->type == 'CNAME' && $record->name == 'msoid.' . $hostname) {
                    $adCnameLine = $record->Line;
                }
            }
            
            if ($mxLine == -1) { 
                //ถ้ายังไม่มี ให้เพิ่มเข้าไป
                $result = $this->addMxRecord($domainName, $hostname, $mxData);
            } else { //ถ้ามีแล้วให้แก้ไข
                $result = $this->editMxRecord($domainName, $hostname, $mxData, $mxLine);
            }
            
            if ($exCnameLine == -1) {
                $result1 = $this->addExCnameRecord($domainName);
            } else { 
                $result1 = $this->editExCnameRecord($domainName, $hostname, $exCnameLine);
            }
            
            if ($exTxtLine == -1) {
                $result2 = $this->addExTxtRecord($domainName, $hostname);
            } else {
                $result2 = $this->editExTxtRecord($domainName, $hostname, $exTxtLine);
            }
            
            if ($skSrvLine == -1) {
                $result3 = $this->addSkSrvRecord($domainName, $hostname);
            } else {
                $result3 = $this->editSkSrvRecord($domainName, $hostname, $skSrvLine);
            }
            
            if ($skSrvLine1 == -1) {
                $result4 = $this->addSkSrvRecord1($domainName, $hostname);
            } else {
                $result4 = $this->editSkSrvRecord1($domainName, $hostname, $skSrvLine1);
            }
            
            if ($skCnameLine == -1) {
                $result5 = $this->addSkCnameRecord($domainName);
            } else {
                $result5 = $this->editSkCnameRecord($domainName, $hostname, $skCnameLine);
            }
            
            if ($skCnameLine1 == -1) {
                $result6 = $this->addSkCnameRecord1($domainName);
            } else {
                $result6 = $this->editSkCnameRecord1($domainName, $hostname, $skCnameLine1);
            }
            
            if ($mbCnameLine == -1) {
                $result7 = $this->addMbCnameRecord($domainName);
            } else {
                $result7 = $this->editMbCnameRecord($domainName, $hostname, $mbCnameLine);
            }
            
            if ($mbCnameLine1 == -1) {
                $result8 = $this->addMbCnameRecord1($domainName);
            } else {
                $result8 = $this->editMbCnameRecord1($domainName, $hostname, $mbCnameLine1);
            }
            
            if ($adCnameLine == -1) {
                $result9 = $this->addAdCnameRecord($domainName);
            } else {
                $result9 = $this->editAdCnameRecord($domainName, $hostname, $adCnameLine);
            }
                        
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign("aResponse", array(
                'status'    =>    1,
                'msg'       => 'success',
                'data'      =>    array(
                    'result'    =>    $result->metadata,
                    'result1'   =>    $result1->metadata,
                    'result2'   =>    $result2->metadata,
                    'result3'   =>    $result3->metadata,
                    'result4'   =>    $result4->metadata,
                    'result5'   =>    $result5->metadata,
                    'result6'   =>    $result6->metadata,
                    'result7'   =>    $result7->metadata,
                    'result8'   =>    $result8->metadata,
                    'result9'   =>    $result9->metadata,
                )
            ));
            $this->json->show();
        } else {
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign("aResponse", array(
                'status'    => 0,
                'msg'       => $res->metadata->reason
            ));
            $this->json->show();
        }
    }

    public function editAdCnameRecord($domainName, $hostname, $adCnameLine)
    {    
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line=' .  $adCnameLine . '&name=msoid&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=clientconfig.microsoftonline-p.net';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addAdCnameRecord($domainName)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=msoid&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=clientconfig.microsoftonline-p.net';

        $result = $this->editDnsRecord($url);

        return $result;        
    }
    
    public function editMbCnameRecord1($domainName, $hostname, $mbCnameLine1)
    {
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line=' .  $mbCnameLine1 . '&name=enterpriseenrollment&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=enterpriseenrollment.manage.microsoft.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addMbCnameRecord1($domainName)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=enterpriseenrollment&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=enterpriseenrollment.manage.microsoft.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function editMbCnameRecord($domainName, $hostname, $mbCnameLine)
    {
        
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line=' .  $mbCnameLine . '&name=enterpriseregistration&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=enterpriseregistration.windows.net';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addMbCnameRecord($domainName)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=enterpriseregistration&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=enterpriseregistration.windows.net';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
        
    }
    
    public function editSkCnameRecord1($domainName, $hostname, $skCnameLine1)
    {
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line=' . $skCnameLine1 . '&name=lyncdiscover&class=IN&ttl=3600';
        $url .=    '&type=CNAME&cname=webdir.online.lync.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addSkCnameRecord1($domainName)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=lyncdiscover&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=webdir.online.lync.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
        
    }
    
    public function editSkCnameRecord($domainName, $hostname, $skCnameLine)
    {
        
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line=' .  $skCnameLine . '&name=sip&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=sipdir.online.lync.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addSkCnameRecord($domainName)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=sip&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=sipdir.online.lync.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function editSkSrvRecord1($domainName, $hostname, $skSrvLine1)
    {
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line='. $skSrvLine1 .'&name=_sipfederationtls._tcp&class=IN&ttl=3600';
        $url .= '&type=SRV&priority=100&weight=1&port=5061&target=sipfed.online.lync.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addSkSrvRecord1($domainName, $hostname)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=_sipfederationtls._tcp&class=IN&ttl=3600';
        $url .= '&type=SRV&priority=100&weight=1&port=5061&target=sipfed.online.lync.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function editSkSrvRecord($domainName, $hostname, $skSrvLine)
    {
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line='. $skSrvLine .'&name=_sip._tls&class=IN&ttl=3600';
        $url .= '&type=SRV&priority=100&weight=1&port=443&target=sipdir.online.lync.com.';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addSkSrvRecord($domainName, $hostname)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=_sip._tls&class=IN&ttl=3600';
        $url .= '&type=SRV&priority=100&weight=1&port=443&target=sipdir.online.lync.com.';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function editExTxtRecord($domainName, $hostname, $exTxtLine)
    {
        $val = urlencode('v=spf1 include:spf.protection.outlook.com -all');
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line='. $exTxtLine .'&name='. $hostname .'&class=IN&ttl=3600';
        $url .= '&type=TXT&txtdata=' . $val;
        $result    =    $this->editDnsRecord($url);

        return $result;        
    }
    
    public function addExTxtRecord($domainName, $hostname)
    {
        $val = urlencode('"v=spf1 include:spf.protection.outlook.com -all"');
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name='. $hostname .'&class=IN&ttl=3600';
        $url .= '&type=TXT&txtdata=' . $val;
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function editExCnameRecord($domainName, $hostname, $exCnameLine)
    {
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line=' .  $exCnameLine . '&name=autodiscover&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=autodiscover.outlook.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addExCnameRecord($domainName)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=autodiscover&class=IN&ttl=3600';
        $url .= '&type=CNAME&cname=autodiscover.outlook.com';
        
        $result = $this->editDnsRecord($url);
        
        return $result;
        
    }
    
    public function editMxRecord($domainName, $hostname, $mxData, $mxLine)
    {
        $url = 'editzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&line=' .  $mxLine . '&name=' . $hostname . '&class=IN&ttl=3600';
        $url .= '&type=MX&preference=0&exchange=' . $mxData;
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function addMxRecord($domainName, $hostname, $mxData)
    {
        $url = 'addzonerecord?api.version=1&domain=' . $domainName;
        $url .= '&name=' . $hostname . '&class=IN&ttl=3600';
        $url .= '&type=MX&preference=0&exchange=' . $mxData;
        
        $result = $this->editDnsRecord($url);
        
        return $result;
    }
    
    public function editDnsRecord($url)
    {
        $db = hbm_db();
        $query = sprintf("   
            SELECT
                hbmc.config
            FROM
                %s hbmc
            WHERE
                hbmc.module='cpaneldnszonehandle'
        ", "hb_modules_configuration");
                
        $aRes = $db->query($query)->fetchAll();
        $aConf = (count($aRes) > 0 && isset($aRes[0]["config"])) 
            ? unserialize($aRes[0]["config"]) 
            : array();

        if (count($aConf)>0 
            && isset($aConf['DNS Server3 IP']['value']) && $aConf['DNS Server3 IP']['value'] != ''
            && isset($aConf['DNS Server3 WHM Username']['value']) && $aConf['DNS Server3 WHM Username']['value'] != ''
            && isset($aConf['DNS Server3 WHM Hash']['value']) && $aConf['DNS Server3 WHM Hash']['value'] != '') {
            
            if (function_exists('curl_init')) {

                $user = $aConf['DNS Server3 WHM Username']['value'];
                $dnsServer = $aConf['DNS Server3 IP']['value'];
                $remoteAccesskey = $aConf['DNS Server3 WHM Hash']['value'];
                
                $cleanaccesshash = preg_replace("'(\r|\n)'","", $remoteAccesskey);
                $authstr = $user . ":" . $cleanaccesshash;
                
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                curl_setopt($ch, CURLOPT_URL, 'https://' . $dnsServer . ':2087/json-api/' . $url );
                
                curl_setopt($ch, CURLOPT_HEADER, 0);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                $curlheaders[0] = "Authorization: WHM $authstr";
                $curlheaders[1] = "Referer: " . $referer;
                curl_setopt($ch, CURLOPT_HTTPHEADER, $curlheaders);
                $output = curl_exec($ch);
                curl_close($ch);
                
                $aOutput = json_decode($output);    
                
            } else {
                $msg = 'Error: curl function not exits.';
            }
        } else {
            $msg = 'Error: no server config.';
        }    
        
        return $aOutput;
    }

    private function getAccountInformationByID($account_id) 
    {
        try {
            $db  = hbm_db();
            $api = new hbApiWrapper();
            $aConfigItemsCatByAccountID = $api->getConfigItemsCatByAccountID($account_id);
            $aAccountConfig = $aConfigItemsCatByAccountID['config_items_cat'];
            
            $aProductConfig    =    $db->query("
                SELECT p.id as product_id, p.name, acc.billingcycle, acc.status, acc.next_due, acc.next_invoice, acc.server_id, acc.domain, acc.total
                FROM
                    hb_accounts acc
                    INNER JOIN hb_products p ON (acc.product_id = p.id)
                WHERE
                    acc.id = :account_id
            ", array(
                ':account_id'    =>    $account_id
            ))->fetchAll();

            if (empty($aProductConfig[0]) || empty($aProductConfig[0]['server_id'])) {
                throw new Exception('Find not fount server/app ID in account!!');
            }

            $aProductPrices    =    $db->query("
                SELECT
                    id, type, price
                FROM
                    hb_prices
                WHERE
                    rel_id = :product_id
                    AND rel = 'Product'
            ", array(
                ':product_id'    =>    $aProductConfig[0]['product_id']
            ))->fetchAll();

            $aServerDetails = $api->getServerDetails(array('id' => $aProductConfig[0]['server_id']));
            
            /// TODO: หลังจาก update hostbill มา ทำให้ไม่สามารถหาค่า password ของ server details. (ก่อนหน้านี้จะ)
            $aServerDetails['server']['password'] = empty($aServerDetails['server']['password']) ? 'W_QoZSkv-1fs8uU6Yo3xmF43JH_RP_7.8n' : $aServerDetails['server']['password'];

            if (empty($aServerDetails['server']) || empty($aServerDetails['server']['host']) || empty($aServerDetails['server']['ip']) || empty($aServerDetails['server']['password'])) {
                throw new Exception('Server/app connection is invalid!!');
            }

            return array(
                'account_id' => $account_id,
                'account_detail' => $aProductConfig[0],
                'account_configs' => $aAccountConfig,
                'product_prices' => $aProductPrices,
                'server_configs' => $aServerDetails['server']
            );

        } catch (Exception $error) {

            throw new Exception($error->getMessage());
        }
    }
    


    public function getAzureSubscriptionByHBAccountID($hbAccountID)
    {
        try {
            
            $aAccountInfo = $this->getAccountInformationByID($hbAccountID);
            $domain = (isset($aAccountInfo['account_detail']['domain']) && trim($aAccountInfo['account_detail']['domain']) != '') 
            ? trim($aAccountInfo['account_detail']['domain'])
            : null;
            $api = new hbApiWrapper();
            $aProductDetails = $api->getProductDetails(array('id' => $aAccountInfo['account_detail']['product_id']));
            $aProductDetail = array();
            if (empty($aProductDetails['product'])) {
                throw new Exception('Cannot get hostbill product detail(s)!!');
            } else {
                $aProductDetail = $aProductDetails['product'];
            }

            $domain_in_config = null;
            $inFieldDomainName = null;
            $seatQuantity = 0;
            $microsoftID = null;
            $subscriptID = null;
            $hbConfigMsOfferID = null; 
            
            foreach ($aAccountInfo['account_configs'] as $accConf) {
                if ($accConf['variable'] == 'microsoft_id' && trim($accConf['data']) != '') {
                    $microsoftID = trim($accConf['data']);
                } else if (trim($accConf['variable']) == 'domain_name' && trim($accConf['data']) != '') {
                    $inFieldDomainName = (trim($accConf['data']) != '' && trim($accConf['data']) != $domain)
                    ? trim($accConf['data'])
                    : null;
                } else if (preg_match('/Reseller Portal/', $accConf['name'], $match)) {
                    $domain_in_config = (trim($accConf['data']) != '' && trim($accConf['data']) != $domain)
                    ? trim($accConf['data'])
                    : null;
                } elseif ($accConf['variable'] == 'quantity') {
                    $seatQuantity = isset($accConf['qty']) 
                        ? (int) trim($accConf['qty'])
                        : (int) trim($accConf['data']);
                } elseif ($accConf['variable'] == 'subscription_id'  && trim($accConf['data']) != '' ) {
                    $subscriptID = trim($accConf['data']);
                }
            }

            if (isset($aProductDetail['options']['ms_offer_id']) && trim($aProductDetail['options']['ms_offer_id']) != '') {
                $hbConfigMsOfferID = trim($aProductDetail['options']['ms_offer_id']);
            } else {
                throw new Exception('Product ' . $aProductDetail['name']. ' ยังไม่ทำการ config micosoft offer id. กรุณาไปที่ Product Order Page / Connect with app และทำการระบุ micosoft offer!!');
            }
            
            
            $oAZConn = new AzureApi($this->azure_resource_url, $aAccountInfo['server_configs']['host'],  $aAccountInfo['server_configs']['ip'], $aAccountInfo['server_configs']['password'], 60);
            
            $aAzureCustomer = array(
                'customer_id' => $microsoftID
            );
            
            $aDomain = array();
            if ($domain != null) {
                array_push($aDomain, '"' . $domain . '"');
            }
            if ($domain_in_config != null) {
                array_push($aDomain, '"' . $domain_in_config . '"');
            }
                      
            if (is_null($microsoftID)) {
                $aDomain = array();
                if ($domain != null) {
                    array_push($aDomain, '"' . $domain . '"');
                }
                if ($inFieldDomainName != null) {
                    array_push($aDomain, '"' . $inFieldDomainName . '"');
                }

                if ($domain_in_config != null && $domain_in_config != $inFieldDomainName) {
                    array_push($aDomain, '"' . $domain_in_config . '"');
                }

                if (is_null($domain) && is_null($domain_in_config)) {
                    throw new Exception('Hostbill accoubt domain และ "ชื่อโดเมนที่แสดงใน Reseller Portal" หรือมีค่าเป็นค่าว่าง! ทำให้ไม่สามารถอ้างอิงข้อมูลกับที่ Microsoft Partner Center ได้. สามารถแก้ไขได้โดยการอับเดจข้อมูล Hostbill accoubt domain หรือ Microsoft ID ให้ถูกต้อง');
                }

                $aFillter = array("Field" => "domain", "Value" => $domain, "Operator" => "starts_with");

                $aCustomers = $oAZConn->partnerApiGetCustomers($aFillter);
                if (is_null($aCustomers) || empty($aCustomers['totalCount']) || empty($aCustomers['items']) || (int) $aCustomers['totalCount'] <= 0) {
                    if ($domain_in_config != null) {
                        $aFillter = array("Field" => "domain", "Value" => $domain_in_config, "Operator" => "starts_with");
                        $aCustomers = $oAZConn->partnerApiGetCustomers($aFillter);
                    }
                }
                if (is_null($aCustomers) || empty($aCustomers['totalCount']) || empty($aCustomers['items']) || (int) $aCustomers['totalCount'] <= 0) {
                    throw new Exception('ไม่พบข้อมูล Customer ที่เป็นเจ้าของ Domain ' . join(" หรือ ", $aDomain) . ' ใน Microsoft Partner Center! กรุณาตรวจสอบความถูกต้องของข้อมูลให้ละเอียดอีกครั้ง.');
                }

                foreach ($aCustomers['items'] as $item) {
                    if (trim(strtolower($item['companyProfile']['domain'])) == trim(strtolower($domain)) || trim(strtolower($item['companyProfile']['domain'])) == trim(strtolower($domain_in_config))) {
                        $aAzureCustomer['customer_id'] = $item['companyProfile']['tenantId'];
                        $aAzureCustomer['company_name'] = $item['companyProfile']['companyName'];
                        $aAzureCustomer['domain'] = trim($item['companyProfile']['domain']);
                    }
                }
                if (is_null($aAzureCustomer['customer_id'])) {
                    throw new Exception('ไม่พบข้อมูล Customer ที่เป็นเจ้าของ Domain ' . join(" หรือ ", $aDomain) . ' ใน Azure Partner Center! กรุณาตรวจสอบความถูกต้องของข้อมูลให้ละเอียดอีกครั้ง.---');
                }
            } else {
                $aAzCustomerInfo = $oAZConn->partnerApiGetCustomerInfoID($aAzureCustomer['customer_id']);
                $aAzureCustomer['company_name'] = isset($aAzCustomerInfo['companyProfile']['companyName']) 
                    ? trim($aAzCustomerInfo['companyProfile']['companyName']) 
                    : '';
                $aAzureCustomer['domain'] = isset($aAzCustomerInfo['companyProfile']['domain']) 
                    ? trim($aAzCustomerInfo['companyProfile']['domain']) 
                    : '';
            }

            $aSubscriptions = $oAZConn->partnerApiGetSubscriptionsByCustomerID($aAzureCustomer['customer_id']);

            if (is_null($aSubscriptions) || empty($aSubscriptions['totalCount']) || empty($aSubscriptions['items']) || (int) $aSubscriptions['totalCount'] <= 0) {
                throw new Exception('ไม่พบข้อมูล Subscription สำหรับ Microsoft ID "' . $aAzureCustomer['customer_id'] . '" ใน Azure Partner Center!!');
            }

            $aResultSubscription = array();
            foreach ($aSubscriptions['items'] as $subItem) {
                if (trim(strtolower($subItem['billingCycle'])) == 'month' ) {
                    $subItem['billingCycle'] = 'monthly';
                } else if (trim(strtolower($subItem['billingCycle'])) == 'annual' ) {
                    $subItem['billingCycle'] = 'annually';
                }
                if ( trim(strtolower($subItem['offerId'])) == trim(strtolower($hbConfigMsOfferID)) 
                    && $this->compareBillingCycle(trim(strtolower($aAccountInfo['account_detail']['billingcycle'])), trim(strtolower($subItem['billingCycle'])))) {
                    array_push($aResultSubscription, $subItem);
                }
            }

            return array(
                'hbConfigMicrosoftOfferID' => $hbConfigMsOfferID,
                'hasDataMicrosoftIdInHB' => is_null($microsoftID) ? false: true,
                'microsoftId' => $microsoftID,
                'hasDataSubscriptIdInHB' => is_null($subscriptID) ? false: true,
                'subscriptId' => $subscriptID,
                'domain' => $domain,
                'domain_in_config' => $domain_in_config,
                'seatQuantity' => $seatQuantity,
                'aHbAccountInfo' => $aAccountInfo,
                'aAzCustomerInfo'    => $aAzureCustomer,
                'aAzSubscription' => $aResultSubscription
            );

         } catch (Exception $error) {
            throw new Exception($error->getMessage());
        }
    }

    private function getHbBillingCycleySupport($msBillingCycle)
    {
        if (strtolower($msBillingCycle) == 'annually') {
            return  array('free', 'annually', 'biennially', 'triennial', 'quadrennially', 'quinquennially');
        } else if (strtolower($msBillingCycle) == 'monthly') {
            return array('free', 'weekly', 'daily', 'monthly', 'quarterly', 'semi-annually');
        } else {
            return  array('free');
        }
    }

    public function compareBillingCycle($hbBillingCycle, $msBillingCycle)
    {
        $hbBillingCycle = strtolower($hbBillingCycle);
        $msBillingCycle = strtolower($msBillingCycle);

        if ($msBillingCycle == 'none' && in_array($hbBillingCycle, $this->getHbBillingCycleySupport('none'))) {
            return true;
        } else if ($msBillingCycle == 'monthly' && in_array($hbBillingCycle, $this->getHbBillingCycleySupport('monthly'))) {
            return true;
        } else if ($msBillingCycle == 'annually' && in_array($hbBillingCycle, $this->getHbBillingCycleySupport('annually'))) {
            return true;
        } else {
            return false;
        }

    }


    public function getCustomerInfoFromPartnerCenterWithDomain($request)
    {
        try {
            if (empty($request['account_id'])) {
                throw new Exception('Account ID is empty!!');
            }

            $aResult = $this->getAzureSubscriptionByHBAccountID($request['account_id']);

            $hasDataMicrosoftIdInHB = isset($aResult['hasDataMicrosoftIdInHB']) ? $aResult['hasDataMicrosoftIdInHB'] : false;
            $aWarnings = array();

            if (!$hasDataMicrosoftIdInHB) {
                array_push($aWarnings, 'ยังไม่ได้ทำการผูก Microsoft ID เข้ากับ Hostbill account.');
            }

            if (trim(strtolower($aResult['domain'])) != trim(strtolower($aResult['aAzCustomerInfo']['domain']))) {
                array_push($aWarnings, 'ค่า Domain บน Hostbill account ไม่ตรงกับค่า Domain บน Microsoft Partner Center. (มีผลต่อการแสดงรายชื่อ item ใน Invoice)');
            }

            $_aCheckItems = array();
            foreach ($aResult['aAzSubscription'] as $item) {
                if ($item['status'] =='active') {
                    array_push($_aCheckItems, (int) $item['quantity']);
                }
            }

            if (count($_aCheckItems) <= 0) {
                array_push($aWarnings, 'ไม่มีข้อมูล Subscription ที่ active บน Microsoft Partner Center.');
            } else if (count($_aCheckItems) > 1) {
                array_push($aWarnings, 'ข้อมูล Subscription ที่ active บน Microsoft Partner Center มีมากกว่า 1 record.');
            } else if ($_aCheckItems[0] != (int) $aResult['seatQuantity']) {
                array_push($aWarnings, 'ข้อมูล Seat Quantity ที่ Hostbill account ไม่ตรงกับที่ Microsoft Partner Center. กรุณากดปุ่ม Synchronize เพื่ออับเดจข้อมูล.');
            }

            //$this->template->assign('aDebug', $aResult);
            $this->template->assign('module', $request['module']);
            $this->template->assign('account_id', $request['account_id']);
            $this->template->assign('hasDataMicrosoftIdInHB', $hasDataMicrosoftIdInHB);
            $this->template->assign('aWarnings', $aWarnings);
            $this->template->assign('seatQuantity', $aResult['seatQuantity']);
            $this->template->assign('aHbAccountInfo', $aResult['aHbAccountInfo']);
            $this->template->assign('aAzCustomerInfo', $aResult['aAzCustomerInfo']);
            $this->template->assign('aAzSubscription', $aResult['aAzSubscription']);
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.subscription_report.tpl',array(), true);
            
        } catch (Exception $error) {
            $this->template->assign('message', $error->getMessage());
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/ajax.display_error_message.tpl',array(), true);
        }
    }

    public function doSyncMicrosiftID2HBAccount($request)
    {
        try {
            if (empty($request['account_id'])) {
                throw new Exception('Account ID is empty!!');
            }

            $aResult = $this->getAzureSubscriptionByHBAccountID($request['account_id']);

            if ( !isset($aResult['aAzCustomerInfo']['customer_id']) 
                || empty($aResult['aAzCustomerInfo']['customer_id']) 
                || trim($aResult['aAzCustomerInfo']['customer_id']) == ''
            ) {
                throw new Exception('Hostbill account ID is empty!!');
            } else {
                $microsoftID = $aResult['aAzCustomerInfo']['customer_id'];
            }

            $aHBFieldconfigs = array();
            $aHBFieldConfigSubscriptionID = array();
            foreach ($aResult['aHbAccountInfo']['account_configs'] as $item) {
                if ($item['variable'] == 'microsoft_id') {
                    $aHBFieldconfigs = $item;
                    continue;
                } else if ($item['variable'] == 'subscription_id') {
                    $aHBFieldConfigSubscriptionID = $item;
                    continue;
                }
            }

            if (count($aHBFieldconfigs) <= 0 || !isset($aHBFieldconfigs['config_cat']) || !isset($aHBFieldconfigs['config_id'])) {
                throw new Exception('Find not found field Microsoft ID in Hostbill account!!');
            }
            $db        =    hbm_db();
            $db->query("
                UPDATE
                    hb_config2accounts
                SET 
                    data = :microsoftId
                WHERE 
                    account_id = :accountId
                    AND config_cat = :configCat
                    AND config_id = :configId
            ",array(
                ':microsoftId'        => $microsoftID,
                ':accountId'        => $request['account_id'],
                ':configCat'        => $aHBFieldconfigs['config_cat'],
                ':configId'         => $aHBFieldconfigs['config_id']
            ));
            $aUpdateResult = array();
            array_push($aUpdateResult, array(
                'config_cat' => $aHBFieldconfigs['config_cat'],
                'config_id' => $aHBFieldconfigs['config_id'],
                'value' => $microsoftID
            ));

            if (count($aResult['aAzSubscription']) == 1) {
                $subscriptID = $aResult['aAzSubscription'][0]['id'];
                if (isset($aHBFieldConfigSubscriptionID['config_cat']) && isset($aHBFieldConfigSubscriptionID['config_id'])) {
                    $db->query("
                        UPDATE
                            hb_config2accounts
                        SET 
                            data = :data
                        WHERE 
                            account_id = :accountId
                            AND config_cat = :configCat
                            AND config_id = :configId
                    ",array(
                        ':data'        => $subscriptID,
                        ':accountId'        => $request['account_id'],
                        ':configCat'        => $aHBFieldConfigSubscriptionID['config_cat'],
                        ':configId'         => $aHBFieldConfigSubscriptionID['config_id']
                    ));
                    array_push($aUpdateResult, array(
                        'config_cat' => $aHBFieldConfigSubscriptionID['config_cat'],
                        'config_id' => $aHBFieldConfigSubscriptionID['config_id'],
                        'value' => $subscriptID
                    ));
                }
            }

            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign('data', array(
                'status' => true,
                'configs' => $aUpdateResult
            ));
            $this->json->show();
        } catch (Exception $error) {
            $this->onError($error->getMessage());
        }
    }

    public function onError($message)
    {
        $this->loader->component('template/apiresponse', 'json');
        $this->json->assign('errors', array('message' => $message));
        $this->json->show();
    }
}
