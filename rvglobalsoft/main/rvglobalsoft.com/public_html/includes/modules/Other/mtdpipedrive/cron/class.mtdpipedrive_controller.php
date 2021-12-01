<?php

class mtdpipedrive_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * Sync Knowledgebase category
     * @return string
     */
    public function call_Daily() 
    {
        for($i = 0 ; $i >=-3  ; $i--){
            $month = mktime(0, 0, 0, date("m")+$i, date("d"),   date("Y"));
            $this->MTDPipedrive('New',$month);
            $this->MTDPipedrive('Renew',$month);
            $this->MTDPipedrive('other',$month);
        }
        return $message;
    }
    
    public function MTDPipedrive($orderType,$month)
    {
        $message    = '';
        $today      = date('Y-m',$month);

        $aConfigs       = $this->module->configuration;
        $clientId       = $aConfigs['Client ID']['value'];
        $clientSecret   = $aConfigs['Client Secret']['value'];
        $authCode       = $aConfigs['Auth Code']['value'];
        $accessToken    = $aConfigs['Access Token']['value'];
        $documentRootId = $aConfigs['MTD Pipedrive Document ID']['value'];
        
        $modPath    = dirname(dirname(__FILE__));
        
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/Google_Client.php');
        require_once(dirname($modPath) . '/kbongoogle/google-api-php-client/src/contrib/Google_DriveService.php');
        
        $client     = new Google_Client();
        // Get your credentials from the APIs Console
        $client->setClientId($clientId);
        $client->setClientSecret($clientSecret);
        $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
        $client->setScopes(array('https://www.googleapis.com/auth/drive'));
        $accessToken = preg_replace('/\-quote\-/','"', $accessToken);
        $client->setAccessToken($accessToken);
        
        $service = new Google_DriveService($client);

        $aFile  = array();
        try {
            $aFile = $service->files->get($documentRootId);
        } catch (Exception $e) {
            echo 'An error occurred:' . $e->getMessage();
            exit;
        }
        
        $oToken             = json_decode($client->getAccessToken());
        require_once(dirname($modPath) . '/importongoogle/Google/Spreadsheet/Autoloader.php');
        $request            = new Google\Spreadsheet\Request($oToken->access_token);
        
        $serviceRequest     = new Google\Spreadsheet\DefaultServiceRequest($request);
        Google\Spreadsheet\ServiceRequestFactory::setInstance($serviceRequest);
        
        $spreadsheetService = new Google\Spreadsheet\SpreadsheetService();
        
        try{
            $spreadsheetFeed    = $spreadsheetService->getSpreadsheets();
        }catch(exception $e){
            $message        = $e->getMessage();
            return $message;
            exit(0);
        }
        
        $spreadsheet        = $spreadsheetFeed->getByTitle('MTD-Pipedrive'); 
        $worksheetFeed      = $spreadsheet->getWorksheets();
        $worksheet          = $worksheetFeed->getByTitle('new deal');
        
        if($orderType == 'Renew'){
            $worksheet          = $worksheetFeed->getByTitle('renewal deal');
        }
        $teams      = array('CS','SALE-SSL','SALE-GM','SALE-DS','BD','SYSNOC','MKT Deals','MKT Partner Deals','RV Pipeline','Projects','Netway Pipeline');
        
        if($orderType == 'other'){
            $worksheet          = $worksheetFeed->getByTitle('other');
            $teams              = array('RV Pipeline','Projects');
            $orderType          = 'New';
        }
         
        $listFeed           = $worksheet->getListFeed();
        $xml                = $listFeed->getXml();
        $columnName         = $listFeed->getColumnNames($xml);
        //echo '<pre>'. print_r($xml, true) .'</pre>';
        //echo '<pre>'. print_r($columnName, true) .'</pre>';
        
        $entries            = $listFeed->getEntries();
        
        if (! count($entries)) {
            $message        = '$entries error';
            return $message;
            exit;
        }
        
        $stages     = array('won_stage_1','won_stage_2','won_stage_3','won_stage_4','won_stage_5','won_stage_6','won_stage_7','won_stage_8','won_stage_9','is_won');
        $aData      = array('');
        
        $c = 0;
        for($i = 0 ; $i < count($teams) ; $i++){
            for($j = 0 ; $j < count($stages) ; $j++){
                $aData[++$c]     = $this->getCountWinStage($today,$orderType,$teams[$i],$stages[$j]);                   
            }
        }
        
        foreach ($entries as $entry) {
            $values         = $entry->getValues();
            
            if (! count($values)) {
                continue;
            }
            
            $day            = array_shift(array_slice($values, 0, 1));
            $mtdTime        = strtotime($day);
            
            if (! $mtdTime) {
                continue;
            }
            
            if ($day != date('n/1/Y',$month)) {
                if ($entry == end($entries)){ //ขึ้นเดือนใหม่
                    $arr                             = array();
                    $arr[$columnName[0]]             = date('n/1/Y',$month);
                    $listFeed->insert($arr);
                }
                continue;
            }
            
            $aField         = $values;
            $i              = 0;
            
            foreach ($aField as $k => $v) {
                if (isset($aData[$i]) && $aData[$i] != '') {
                    $values[$k]     = $aData[$i];
                }
                $i++;
            }
            
            $entry->update($values);
            break;
        }

        return $message;
        
    }
    
    public function getCountWinStage($today,$orderType,$teams,$stages)
    {
        $db = hbm_db();
        
        $result = $db->query("SELECT 
                                        count(*) as num
                                 FROM 
                                        pipedrive p
                                 WHERE
                                        p.date_changed LIKE '" .$today. "%'
                                        AND p.pipe_line = '" .$teams. "'
                                        AND p.order_type = '". $orderType ."'
                                        AND p." . $stages ." = 1
                                 ")->fetch();                  
        return $result['num'];  
    }
    
}


