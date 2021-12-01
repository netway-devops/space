
<?php

class importongoogle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    private $startAndEndDateOfThisMonth;

    /**
     * 
     * @return string
     */
    public function call_Daily() 
    {
        $this->getKPIDaily();
        $this->getKPIMTD();
        $this->countActiveProducts('All');
        $this->countActiveProducts('nineweb');
        $this->countActiveProducts('netway');
        return $message;
    }
    
    public function countActiveProducts($type = "All"){
        
        $db             =   hbm_db();
        $aAllProducts   =   $db->query("select id , name from hb_products")->fetchAll();
        $header         =   array('date');
        $body           =   array('\'' . date('m/Y'));  
        
        $c  = count($aAllProducts);
        
        for($i = 1 ; $i <= $c ; $i++ ){
            $header[$i]         =   '--- delete ---';
            $body[$i]           =   0;
            $aRealProduct[$i]   =   array(
                                        'id'        =>  $i ,
                                        'name'      =>  '--- delete ---' ,
                                        'data'      =>  array('Active'  =>  0)
                                    );
        }
                      
        foreach($aAllProducts as $product){
            $header[$product['id']]                         =   $product['name'];
            $aRealProduct[$product['id']]                   =   $product;
            $aRealProduct[$product['id']]['data']['Active'] =   0;
            
        }
        
        $subSql =   ''; 
        if($type == 'All'){
            $subSql = 'and a.client_id NOT IN (8485,10878)'; //ทั้งหมดไม่รวม netway & nineweb
        }else if($type == 'nineweb'){
            $subSql =   'and a.client_id IN (10878)'; //nineweb only
        }else if($type == 'netway'){
            $subSql =   'and a.client_id IN (8485)'; //nineweb only
        }      
          
        $serviceSql     =   "select p.id , p.name , p.category_id , count(*) as Active
                            from hb_products p , hb_accounts a
                            where  p.id = a.product_id
                            and a.status = 'Active'
                             {$subSql} 
                            group by p.id
                            order by p.category_id";        
        
        $allServices    =   $db->query($serviceSql)->fetchAll();
                            
        foreach($allServices as $service){
            
            $aRealProduct[$service['id']]['data']['Active'] =   $service['Active'];
            
        }
        
        foreach($aRealProduct as $activeAccount){
            $body[$activeAccount['id']]     =   $activeAccount['data']['Active'];       
        }
        
        echo print_r($body,TRUE);

        $rows = file('/home/rvglobal/public_html/rvmtd/file-'.$type.'.csv');
        $last_row = array_pop($rows);
        $data = str_getcsv($last_row);
        
        $lastDate   =   explode(',', $data[0]);
        
        if(empty($lastDate[0])){
            $list           =   array($header,$body);
        }else{
            $list           =   array($body);
        }
        
        $fp = fopen('/home/rvglobal/public_html/rvmtd/file-'.$type.'.csv', 'a+');

        foreach ($list as $fields) {
            fputcsv($fp, $fields);
        }
        
        fclose($fp);
    
    }
    
    public function getKPIDaily(){
        
      
        $today = date('Y-m-d',strtotime('-1 day',strtotime(date('Y-m-d'))));      
        $aConfigs       = $this->module->configuration;
        $productOrCatID = $this->module->prodcutOrCatId;
        $depaID         = $this->module->departmentID; 
        print_r($depaID);   
        $clientId       = $aConfigs['Client ID']['value'];//'40825206682-kc25gdri7emglrem0j7id182qttnpgtt.apps.googleusercontent.com';
        $clientSecret   = $aConfigs['Client Secret']['value'];//;'sua2Jw7X2thgz2AllHQ1Nyx0';
        $authCode       =  $aConfigs['Auth Code']['value'];//'4/DkC1YP8Cce5SPWxLpfUNGqIRhMDh.ogjTX9EhHuodXE-sT2ZLcbTB8URkhQI';//$aConfigs['Auth Code']['value'];
        $accessToken    = $aConfigs['Access Token']['value'];//'{-quote-access_token-quote-:-quote-ya29.1.AADtN_URuQXsJlb8_VtxrQ6awQOExhflrzoi7NbSWsURkLTVgLxyrUbQcmcuiZv1E9dh7w-quote-,-quote-token_type-quote-:-quote-Bearer-quote-,-quote-expires_in-quote-:3600,-quote-refresh_token-quote-:-quote-1\/GwyQlLlzLIelWhzLNWGyz2zYaY0tyu8Ru1hj3JNsxL0-quote-,-quote-created-quote-:1385968197}';//$aConfigs['Access Token']['value'];
        $documentRootId = $aConfigs['Daily Document Root ID']['value'];
        
        $modPath    = dirname(dirname(__FILE__));
        
        require_once($modPath . '/google-api-php-client/src/Google_Client.php');
        require_once($modPath . '/google-api-php-client/src/contrib/Google_DriveService.php');
        
        $client     = new Google_Client();
        // Get your credentials from the APIs Console
        $client->setAccessType('offline');
        $client->setClientId($clientId);
        $client->setClientSecret($clientSecret);
        $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
        $client->setScopes(array('https://www.googleapis.com/auth/drive', 
            'https://www.googleapis.com/auth/drive.file',
            'https://spreadsheets.google.com/feeds'));
            
            
        $accessToken = preg_replace('/\-quote\-/','"', $accessToken);
        $client->setAccessToken($accessToken);
        if($client->isAccessTokenExpired()){
            $newAccessToken = json_decode($client->getAccessToken());
            $client->refreshToken($newAccessToken->refresh_token);
        }
         
         
        $service = new Google_DriveService($client);

        /*$aFile  = array();
        try {
            $aFile = $service->files->get($documentRootId);
        } catch (Exception $e) {
            echo 'An error occurred:' . $e->getMessage();
            return $message;
            exit;
        }
        $this->template->assign('aFile', $aFile);*/
        
        $oToken     = json_decode($client->getAccessToken());
        require_once(dirname(dirname(__FILE__)) . '/Google/Spreadsheet/Autoloader.php');
        $request            = new Google\Spreadsheet\Request($oToken->access_token);
        
        $serviceRequest     = new Google\Spreadsheet\DefaultServiceRequest($request);
        Google\Spreadsheet\ServiceRequestFactory::setInstance($serviceRequest);
        
        $spreadsheetService = new Google\Spreadsheet\SpreadsheetService();
         
         
        try{
                
            $spreadsheetFeed    = $spreadsheetService->getSpreadsheets();
            
        }catch(exception $e){
            $message = $e->getMessage().'Daily-NetwayHostbill-2014'.'from '.$_SERVER["REMOTE_ADDR"].' - '.date("d m Y - H:i");
            $message = wordwrap($message, 70);
            $subject = 'Change token cron kpi - '.date("d m Y - H:i");
            mail('panya@rvglobalsoft.com', $subject, $message);
            echo 'token access please change'.$e->getMessage();
            return $message;
            exit(0);
        }
        
        $spreadsheet        = $spreadsheetFeed->getByTitle('Daily-RvSupport'); 
        $worksheetFeed      = $spreadsheet->getWorksheets();
        $worksheet          = $worksheetFeed->getByTitle('Sheet1');
        $listFeed           = $worksheet->getListFeed();
        $xml                = $listFeed->getXml();
        $columnName         = $listFeed->getColumnNames($xml);
        
        foreach ($listFeed->getEntries() as $entry) {
            $values[] = $entry->getValues();
        }
        
        
        $n=0;
        foreach ($values as $val) {
            $spdate = explode('/',$val[$columnName[0]]);
            
            if(sizeof($spdate) == 3){
                
                $newdate = date('d/m/Y',strtotime($spdate[2].'-'.$spdate[0].'-'.$spdate[1]));
                if($newdate == date('d/m/Y',strtotime($today))){
                    break;
                }
            }
            $n++;    
        }
        
       
        if($n >= sizeof($values)){
            $arr                    = array();
            $arr[$columnName[0]]    = date('m/d/Y',strtotime($today));
            $listFeed->insert($arr);
            $this->getKPIDaily();
            return 0;
        }
        
        $entries                    = $listFeed->getEntries();
        $listEntry1                 = $entries[$n];
        $values1                    = $listEntry1->getValues();
        
        
        $responseAndResolveAll          = $this->getAverageResponseTime($today);
        $unresponseAndResponseOver      = $this->countUnresponsedAndResponseTimeOver($today);
        $responseAndResolveGCS          = $this->getAverageResponseAndResolveGCS($depaID, $today);
        $unresponseAndResponseOverGCS   = $this->countUnresponsedAndResponseTimeOverGCS($depaID, $today);
        $responseAndResolveDev1         = $this->getAverageResponseAndResolveDev1($depaID, $today);
        $unresponseAndResponseOverDev1  = $this->countUnresponsedAndResponseTimeOverDev1($depaID, $today);
        $responseAndResolveDev2         = $this->getAverageResponseAndResolveDev2($depaID , $today);
        $unresponseAndResponseOverDev2  = $this->countUnresponsedAndResponseTimeOverDev2($depaID, $today);
        
        $values1[$columnName[1]]        = $responseAndResolveAll['avg_response'];
        $values1[$columnName[2]]        = $responseAndResolveAll['avg_resolve'];
        $values1[$columnName[3]]        = $unresponseAndResponseOver['unresponse'];
        $values1[$columnName[4]]        = $unresponseAndResponseOver['responseover'];
        $values1[$columnName[5]]        = $this->countDailyNewTicket($today);
        $values1[$columnName[6]]        = $this->countDailyChat($today) ;
        
        $values1[$columnName[7]]        = $responseAndResolveGCS['avg_response'];
        $values1[$columnName[8]]        = $responseAndResolveGCS['avg_resolve'];
        $values1[$columnName[9]]        = $unresponseAndResponseOverGCS['unresponse'];
        $values1[$columnName[10]]       = $unresponseAndResponseOverGCS['responseover'];
        $values1[$columnName[11]]       = $this->countDailyNewTicketGCS($depaID,$today);
        
        $values1[$columnName[12]]       = $responseAndResolveDev1['avg_response'];
        $values1[$columnName[13]]       = $responseAndResolveDev1['avg_resolve'];
        $values1[$columnName[14]]       = $unresponseAndResponseOverDev1['unresponse'];
        $values1[$columnName[15]]       = $unresponseAndResponseOverDev1['responseover'];
        $values1[$columnName[16]]       = $this->countDailyNewTicketDev1($depaID,$today);
        
        $values1[$columnName[17]]       = $responseAndResolveDev2['avg_response'];
        $values1[$columnName[18]]       = $responseAndResolveDev2['avg_resolve'];
        $values1[$columnName[19]]       = $unresponseAndResponseOverDev2['unresponse'];
        $values1[$columnName[20]]       = $unresponseAndResponseOverDev2['responseover'];
        $values1[$columnName[21]]       = $this->countDailyNewTicketDev2($depaID,$today);
        $values1[$columnName[22]]       = $this->getAverageResolveTimeFromCounterDev1($depaID, $today);
        $values1[$columnName[23]]       = $this->getAverageResolveTimeFromCounterDev2($depaID, $today);
        $values1[$columnName[24]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rv2Factor'], $today);
        $values1[$columnName[25]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rvSiteBuilder'], $today);
        $values1[$columnName[26]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rvskinAndRVSubversion'], $today);
        $values1[$columnName[27]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rvPanel'], $today);
        
        
        $listEntry1->update($values1);
        
        if($n >= 2){
            for($i=1; $i<5 && $n-$i>0 ;$i++){
               
                $listEntry2    = $entries[$n-$i];
                $values2       = $listEntry2->getValues();
                $spiltday      = explode("/",$values2[$columnName[0]] );
                $day           = date('Y-m-d',strtotime($spiltday[2]."-".$spiltday[0]."-".$spiltday[1]));
                
                
                $responseAndResolveAll          = $this->getAverageResponseTime($day);
                //$unresponseAndResponseOver      = $this->countUnresponsedAndResponseTimeOver($day);
                $responseAndResolveGCS          = $this->getAverageResponseAndResolveGCS($depaID, $day);
                //$unresponseAndResponseOverGCS   = $this->countUnresponsedAndResponseTimeOverGCS($depaID, $day);
                $responseAndResolveDev1         = $this->getAverageResponseAndResolveDev1($depaID, $day);
                //$unresponseAndResponseOverDev1  = $this->countUnresponsedAndResponseTimeOverDev1($depaID, $day);
                $responseAndResolveDev2         = $this->getAverageResponseAndResolveDev2($depaID , $day);
                //$unresponseAndResponseOverDev2  = $this->countUnresponsedAndResponseTimeOverDev2($depaID, $day);
                        
                
                $values2[$columnName[1]]        = $responseAndResolveAll['avg_response'];
                $values2[$columnName[2]]        = $responseAndResolveAll['avg_resolve'];
                //$values2[$columnName[3]]        = $unresponseAndResponseOver['unresponse'];
                //$values2[$columnName[4]]        = $unresponseAndResponseOver['responseover'];
                //$values2[$columnName[5]]        = $this->countDailyNewTicket($day);
                //$values2[$columnName[6]]        = $this->countDailyChat($day) ;
                
                $values2[$columnName[7]]        = $responseAndResolveGCS['avg_response'];
                $values2[$columnName[8]]        = $responseAndResolveGCS['avg_resolve'];
                //$values2[$columnName[9]]        = $unresponseAndResponseOverGCS['unresponse'];
                //$values2[$columnName[10]]       = $unresponseAndResponseOverGCS['responseover'];
                //$values2[$columnName[11]]       = $this->countDailyNewTicketGCS($day);
                
                $values2[$columnName[12]]       = $responseAndResolveDev1['avg_response'];
                $values2[$columnName[13]]       = $responseAndResolveDev1['avg_resolve'];
                //$values2[$columnName[14]]       = $unresponseAndResponseOverDev1['unresponse'];
                //$values2[$columnName[15]]       = $unresponseAndResponseOverDev1['responseover'];
                //$values2[$columnName[16]]       = $this->countDailyNewTicketDev1($day);
                
                $values2[$columnName[17]]       = $responseAndResolveDev2['avg_response'];
                $values2[$columnName[18]]       = $responseAndResolveDev2['avg_resolve'];
                //$values2[$columnName[19]]       = $unresponseAndResponseOverDev2['unresponse'];
                //$values2[$columnName[20]]       = $unresponseAndResponseOverDev2['responseover'];
                //$values2[$columnName[21]]       = $this->countDailyNewTicketDev2($day);
                $values2[$columnName[22]]       = $this->getAverageResolveTimeFromCounterDev1($depaID, $day);
                $values2[$columnName[23]]       = $this->getAverageResolveTimeFromCounterDev2($depaID, $day);
                $values2[$columnName[24]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rv2Factor'], $day);
                $values2[$columnName[25]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rvSiteBuilder'], $day);
                $values2[$columnName[26]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rvskinAndRVSubversion'], $day);
                $values2[$columnName[27]]       = $this->getAverageResolveTimeFromCounterDevs($depaID['rvPanel'], $day);
                $listEntry2->update($values2);
            }
        }
        
    }
    
    
    
    public function getKPIMTD(){
      
        $aConfigs       = $this->module->configuration;
        $productOrCatID = $this->module->prodcutOrCatId;
        
        
        $clientId       = $aConfigs['Client ID']['value'];//'40825206682-kc25gdri7emglrem0j7id182qttnpgtt.apps.googleusercontent.com';
        $clientSecret   = $aConfigs['Client Secret']['value'];//;'sua2Jw7X2thgz2AllHQ1Nyx0';
        $authCode       =  $aConfigs['Auth Code']['value'];//'4/DkC1YP8Cce5SPWxLpfUNGqIRhMDh.ogjTX9EhHuodXE-sT2ZLcbTB8URkhQI';//$aConfigs['Auth Code']['value'];
        $accessToken    = $aConfigs['Access Token']['value'];//'{-quote-access_token-quote-:-quote-ya29.1.AADtN_URuQXsJlb8_VtxrQ6awQOExhflrzoi7NbSWsURkLTVgLxyrUbQcmcuiZv1E9dh7w-quote-,-quote-token_type-quote-:-quote-Bearer-quote-,-quote-expires_in-quote-:3600,-quote-refresh_token-quote-:-quote-1\/GwyQlLlzLIelWhzLNWGyz2zYaY0tyu8Ru1hj3JNsxL0-quote-,-quote-created-quote-:1385968197}';//$aConfigs['Access Token']['value'];
        $documentRootId = $aConfigs['Month Document Root ID']['value'];
       
        $modPath    = dirname(dirname(__FILE__));
      
        require_once($modPath . '/google-api-php-client/src/Google_Client.php');
        require_once($modPath . '/google-api-php-client/src/contrib/Google_DriveService.php');
        
        $client     = new Google_Client();
        
        
        
        // Get your credentials from the APIs Console
        $client->setAccessType('offline');
        $client->setClientId($clientId);
        $client->setClientSecret($clientSecret);
        $client->setRedirectUri('urn:ietf:wg:oauth:2.0:oob');
        $client->setScopes(array('https://www.googleapis.com/auth/drive', 
            'https://www.googleapis.com/auth/drive.file',
            'https://spreadsheets.google.com/feeds'));
        $accessToken = preg_replace('/\-quote\-/','"', $accessToken);
       
        
        $client->setAccessToken($accessToken);
 
        if($client->isAccessTokenExpired()){
            $newAccessToken = json_decode($client->getAccessToken());
            $client->refreshToken($newAccessToken->refresh_token);
        }
        
        $service = new Google_DriveService($client);

       
        $oToken =  json_decode($client->getAccessToken());
        /*$aFile  = array();
        try {
            $aFile = $service->files->get($documentRootId);
        } catch (Exception $e) {
            echo 'An error occurred:' . $e->getMessage();
            exit;
        }
        
        
        $this->template->assign('aFile', $aFile);*/
        
        
        require_once(dirname(dirname(__FILE__)) . '/Google/Spreadsheet/Autoloader.php');
     
        $request            = new Google\Spreadsheet\Request($oToken->access_token);
        
        $serviceRequest     = new Google\Spreadsheet\DefaultServiceRequest($request);
        Google\Spreadsheet\ServiceRequestFactory::setInstance($serviceRequest);
        
        $spreadsheetService = new Google\Spreadsheet\SpreadsheetService();
        
        
         try{
                
            $spreadsheetFeed    = $spreadsheetService->getSpreadsheets();
            
         }catch(exception $e){
            $message = $e->getMessage().'MTD-RvHostbill'.'from '.$_SERVER["REMOTE_ADDR"].' - '.date("d m Y - H:i");
            $message = wordwrap($message, 70);
            $subject = 'Change token cron kpi - '.date("d m Y - H:i");
            mail('panya@rvglobalsoft.com', $subject, $message);
            echo 'token access please change'.$e->getMessage();
           
            exit(0);
        }
         
         
        $spreadsheet        = $spreadsheetFeed->getByTitle('MTD-RvHostbill'); 
        $worksheetFeed      = $spreadsheet->getWorksheets();
        $worksheet          = $worksheetFeed->getByTitle('Sheet1');
        $listFeed           = $worksheet->getListFeed();
        $xml                = $listFeed->getXml();
        $columnName         = $listFeed->getColumnNames($xml);
        
        foreach ($listFeed->getEntries() as $entry) {
            $values[] = $entry->getValues();
        }
        
        
        $n=0;
        foreach ($values as $val) {
            $spdate = explode('/',$val[$columnName[0]]);
            
            // Format M/D/Y 1/1/2015
            if(sizeof($spdate) == 3){
                $spdate     = array($spdate[0], $spdate[2]);
            }
            
            // Format M/Y 1/2015
            if(sizeof($spdate) == 2){
                
                $newdate = date('m/Y',strtotime($spdate[1].'-'.$spdate[0].'-1'));
                if($newdate == date('m/Y')){
                    break;
                }
            }
            $n++;    
        }
        
        //echo '<rpe>'. $n ." ". sizeof($values) ." ". print_r($newdate,true) .'</pre>';
        //exit;
        
        $today = date('Y-m-d');
        if($n >= sizeof($values)){
            $arr                    = array();
            $arr[$columnName[0]]    = '\'' . date('m/Y');
            $listFeed->insert($arr);
            $this->getKPIMTD();
            return 0;
        }
        
        
        
        
        $entries                    = $listFeed->getEntries();
        $listEntry1                 = $entries[$n];
        $values1                    = $listEntry1->getValues();
        
        
        
        
        
       
       
        $cNumber = 1;
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveSSL($productOrCatID);
        $countActiveSSL = $this -> countActiveSSL($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countNewSSL($productOrCatID, $today);
        $values1[$columnName[$cNumber++]] = $this -> countTerminatedSSL($productOrCatID, $today);
        $cRevSSL = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueSSL($productOrCatID, $today);
        
        
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSkinNOCClientAccount($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSkinNOCLicense($productOrCatID);
        $values1[$columnName[$cNumber++]] = 0;
        $values1[$columnName[$cNumber++]] = 0;
        $cRevRVSkinNOC = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRVSkinNOC($productOrCatID, $today);
       
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSkinDistributorClientAccount($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSkinDistributorLicense($productOrCatID);
        $values1[$columnName[$cNumber++]] = 0;
        $values1[$columnName[$cNumber++]] = 0;
        $cRevRVSkinDis = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRVSkinDistributor($productOrCatID, $today);
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSkinRegular($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countNewRVSkinRegular($productOrCatID, $today);
        $values1[$columnName[$cNumber++]] = $this -> countTerminatedRVSkinRegular($productOrCatID, $today);
        $cRevRVSkinReg = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRVSkinRegular($productOrCatID, $today);
        
        
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSiteBuiderNOCClientAccount($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSiteBuiderNOCLicense($productOrCatID);
        $values1[$columnName[$cNumber++]] = 0;
        $values1[$columnName[$cNumber++]] = 0;
        $cRevRVSiteBuiderNOC = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRVSiteBuiderNOC($productOrCatID, $today);
       
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSiteBuiderDistributorClientAccount($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSiteBuiderDistributorLicense($productOrCatID);
        $values1[$columnName[$cNumber++]] = 0;
        $values1[$columnName[$cNumber++]] = 0;
        $cRevRVSiteBuiderDis = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRVSiteBuiderDistributor($productOrCatID, $today);
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveRVSiteBuiderRegular($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countNewRVSiteBuiderRegular($productOrCatID, $today);
        $values1[$columnName[$cNumber++]] = $this -> countTerminatedRVSiteBuiderRegular($productOrCatID, $today);
        $cRevRVSiteBuiderReg = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRVSiteBuiderRegular($productOrCatID, $today);
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveRV2FactorForWHMAccount($productOrCatID);
        $values1[$columnName[$cNumber++]] = 0;
        $values1[$columnName[$cNumber++]] = 0;
        $cRevRV2FactorForWHM= $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRV2FactorForWHM($productOrCatID, $today);
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveRV2FactorForCPanelAccount($productOrCatID);
        $values1[$columnName[$cNumber++]] = 0;
        $values1[$columnName[$cNumber++]] = 0;
        $cRevRV2FactorForCPanel = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRV2FactorForCPanel($productOrCatID, $today);
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveRV2FactorForAppAccount($productOrCatID);
        $values1[$columnName[$cNumber++]] = 0;
        $values1[$columnName[$cNumber++]] = 0;
        $cRevRV2FactorForApp = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueRV2FactorForApp($productOrCatID, $today);
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveCPanelDedM($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countNewCPanelDedM($productOrCatID, $today);
        $values1[$columnName[$cNumber++]] = $this -> countTerminatedCPanelDedM($productOrCatID, $today);
        $cRevCPanelDedM = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueCPanelDedM($productOrCatID, $today);
        
        
        
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveCPanelVPSM($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countNewCPanelVPSM($productOrCatID, $today);
        $values1[$columnName[$cNumber++]] = $this -> countTerminatedCPanelVPSM($productOrCatID, $today);
        $cRevCPanelVPSM = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueCPanelVPSM($productOrCatID, $today);
        
        
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveCPanelDedY($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countNewCPanelDedY($productOrCatID, $today);
        $values1[$columnName[$cNumber++]] = $this -> countTerminatedCPanelDedY($productOrCatID, $today);
        $cRevCPanelDedY = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueCPanelDedY($productOrCatID, $today);
        
        
        $values1[$columnName[$cNumber++]] = $this -> countActiveCPanelVPSY($productOrCatID);
        $values1[$columnName[$cNumber++]] = $this -> countNewCPanelVPSY($productOrCatID, $today);
        $values1[$columnName[$cNumber++]] = $this -> countTerminatedCPanelVPSY($productOrCatID, $today);
        $cRevCPanelVPSY = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueCPanelVPSY($productOrCatID, $today);
        
        $values1[$columnName[$cNumber++]] = $this -> countknowledgebase();
        $values1[$columnName[$cNumber++]]   = $this -> countClientActive();
       
        $values1[$columnName[$cNumber++]]   = $this -> countClientAccount();
		$values1[$columnName[$cNumber++]] 	= $this -> countActiveSSLInternalNetway($productOrCatID);
        $values1[$columnName[$cNumber++]] = $countActiveSSL - $this -> countActiveSSLInternalNetway($productOrCatID);
		
        $values1[$columnName[$cNumber++]] = $this->countActiveSoftaculous($productOrCatID);
        
        $cRevSoftware = $cNumber;
        $values1[$columnName[$cNumber++]] = $this -> getRevenueSoftware($productOrCatID, $today);
        
        $values1[$columnName[$cNumber]] = $this->countActiveCPanelDedM($productOrCatID) + $this->countActiveCPanelVPSM($productOrCatID) + $this->countActiveCPanelDedY($productOrCatID) + $this -> countActiveCPanelVPSY($productOrCatID);
        
        $values1[$columnName[0]] = '\''.$values1[$columnName[0]];
        $listEntry1->update($values1);

        if($n>=2){
            for($i=1; $i<3 && $n-$i>0 ;$i++){
                $listEntry1_1 = $entries[$n-$i];
                $values1_1 = $listEntry1_1->getValues();
                $spiltday      = explode("/",$values1_1[$columnName[0]] );
                $day           = date('Y-m-t',strtotime($spiltday[1]."-".$spiltday[0]."-1"));
                $values1_1[$columnName[$cRevSSL]]               = $this -> getRevenueSSL($productOrCatID, $day);      
                $values1_1[$columnName[$cRevRVSkinNOC]]         = $this -> getRevenueRVSkinNOC($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRVSkinDis]]         = $this -> getRevenueRVSkinDistributor($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRVSkinReg]]         = $this -> getRevenueRVSkinRegular($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRVSiteBuiderNOC]]   = $this -> getRevenueRVSiteBuiderNOC($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRVSiteBuiderDis]]   = $this -> getRevenueRVSiteBuiderDistributor($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRVSiteBuiderReg]]   = $this -> getRevenueRVSiteBuiderRegular($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRV2FactorForWHM]]   = $this -> getRevenueRV2FactorForWHM($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRV2FactorForCPanel]] = $this -> getRevenueRV2FactorForCPanel($productOrCatID, $day); 
                $values1_1[$columnName[$cRevRV2FactorForApp]]   = $this -> getRevenueRV2FactorForApp($productOrCatID, $day); 
                $values1_1[$columnName[$cRevCPanelDedM]]        = $this -> getRevenueCPanelDedM($productOrCatID, $day); 
                $values1_1[$columnName[$cRevCPanelVPSM]]        = $this -> getRevenueCpanelVpsM($productOrCatID, $day); 
                $values1_1[$columnName[$cRevCPanelDedY]]        = $this -> getRevenueCPanelDedY($productOrCatID, $day); 
                $values1_1[$columnName[$cRevCPanelVPSY]]        = $this -> getRevenueCpanelVpsY($productOrCatID, $day); 
                $values1_1[$columnName[$cRevSoftware]]          = $this -> getRevenueSoftware($productOrCatID, $day);
                $values1_1[$columnName[0]] = '\''.$values1_1[$columnName[0]];
                $listEntry1_1->update($values1_1);
            }
        }
        
        
    }

    public function getRevenueSoftware($arrValue,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i,
                                        hb_products p
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id = p.id
                                        AND p.category_id IN (6) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }

    public function countActiveSoftaculous($arrValue){
        $db = hbm_db();
        
        $result = $db->query("
                                 SELECT 
                                        count(*) as Softaculous
                                 FROM 
                                        hb_accounts a
                                 WHERE 
                                        a.status ='Active' 
                                        and a.product_id IN (144,145)
                             ",array())->fetchAll();
        return $result[0]['Softaculous'];
    }

	public function countActiveSSLInternalNetway($arrValue){
        $db = hbm_db();
        
        $result = $db->query("
                                 SELECT 
                                        count(*) as cactivessl
                                 FROM 
                                        hb_accounts a,
                                        hb_products p 
                                 WHERE 
                                        a.status ='Active' 
                                        and a.product_id = p.id 
                                        and p.category_id = :categoryID
                                        and a.client_id IN (8485,10878)
                             ",array(':categoryID' => $arrValue['sslCategory']))->fetchAll();
        return $result[0]['cactivessl'];
    }
    
    public function countClientAccount(){
        
        $db = hbm_db();
        
        $result = $db->query("
                                 SELECT 
                                        count(status) as allAccount
                                 FROM 
                                        hb_client_access hca 
                
                             ")->fetch();
        return $result['allAccount'];
        
    }
    
    
     public function countActiveSSL($arrValue){
        $db = hbm_db();
        
        $result = $db->query("
                                 SELECT 
                                        count(*) as cactivessl
                                 FROM 
                                        hb_accounts a,
                                        hb_products p 
                                 WHERE 
                                        a.status ='Active' 
                                        and a.product_id = p.id 
                                        and p.category_id = :categoryID
                             ",array(':categoryID' => $arrValue['sslCategory']))->fetchAll();
        return $result[0]['cactivessl'];
    }
    
    
    
    
     public function countNewSSL($arrValue,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cnewssl
                                FROM 
                                        hb_accounts a 
                                        inner join hb_products p 
                                        on a.product_id = p.id 
                                WHERE 
                                        p.category_id = :categoryID 
                                        and a.status = 'Active'
                                        and Date(a.date_created) BETWEEN :startDate and :endDate 
                             ",array(':categoryID' => $arrValue['sslCategory'],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cnewssl'];
    }
    
    
    
    public function countTerminatedSSL($arrValue,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cterminatssl
                                FROM 
                                        `hb_accounts` a 
                                        inner join hb_products p 
                                        on a.product_id = p.id 
                                WHERE
                                        p.category_id = :categoryID 
                                        and a.status = 'Terminated'
                                        and Date(a.date_changed) BETWEEN :startDate and :endDate 
                             ",array(':categoryID' => $arrValue['sslCategory'],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cterminatssl'];
    }
    
    
     
     public function getRevenueSSL($arrValue,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i,
                                        hb_products p
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id = p.id
                                        AND p.category_id = :categoryID 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND a.client_id NOT IN (8485,10878)
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':categoryID' => $arrValue['sslCategory'],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
 
    public function countknowledgebase(){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as countkb
                                FROM
                                        hb_knowledgebase
                             ",array())->fetchAll(); 
        return $result[0]['countkb'];
    }
    
    
    
    
    public function countClientActive(){
        $db = hbm_db();
        $result = $db->query("
                                    SELECT
                                            count(cli.id) as cclient
                                    FROM
                                           (SELECT 
                                                    ca.id as id
                                            FROM 
                                                    hb_client_access ca
                                                    LEFT JOIN hb_domains d
                                                    ON ca.id = d.client_id
                                                    LEFT JOIN hb_accounts a
                                                    ON ca.id = a.client_id 
                                            WHERE 
                                                ca.status = 'Active'
                                                    AND (d.status ='Active' OR a.status = 'Active')
                                                    AND a.product_id <> 49
                                            group by ca.id) cli
                                ",array())->fetchAll(); 
        return $result[0]['cclient'];
        
    }
    
    
    
    
   
    
    
    
    public function countActiveRVSkinNOCClientAccount($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND product_id = :productID
                             ",array(':productID' => $productID['rvskinNocProductID'][0]))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    public function countActiveRVSkinNOCLicense($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        sum(ac.qty) as sumlicense
                                FROM 
                                        hb_config2accounts ac 
                                        JOIN hb_config_items_cat f 
                                        ON 
                                            (
                                            ac.`rel_type`='Hosting' 
                                            AND f.product_id in (:productID1,:productID2) 
                                            AND ac.config_cat=f.id 
                                            AND f.name = 'quantity'
                                            )
                                        JOIN hb_accounts a 
                                        ON (
                                            ac.account_id = a.id
                                            AND a.status = 'Active'
                                            )
                             ",array(':productID1' => $productID['rvskinNocProductID'][0],
                                     ':productID2' => $productID['rvskinNocProductID'][1]
                                    ))->fetchAll(); 
        return $result[0]['sumlicense'];
    }
    
    public function getRevenueRVSkinNOC($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (:productID1,:productID2) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rvskinNocProductID'][0],
                                     ':productID2' => $productID['rvskinNocProductID'][1],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
     public function countActiveRVSkinDistributorClientAccount($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND product_id = :productID
                             ",array(':productID' => $productID['rvskinDistributorProductID'][0]))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    public function countActiveRVSkinDistributorLicense($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        sum(ac.qty) as sumlicense
                                FROM 
                                        hb_config2accounts ac 
                                        JOIN hb_config_items_cat f 
                                        ON 
                                            (
                                            ac.`rel_type`='Hosting' 
                                            AND f.product_id in (:productID1,:productID2) 
                                            AND ac.config_cat=f.id 
                                            AND f.name = 'quantity'
                                            )
                                        JOIN hb_accounts a 
                                        ON (
                                            ac.account_id = a.id
                                            AND a.status = 'Active'
                                            )     
                             ",array(':productID1' => $productID['rvskinDistributorProductID'][0],
                                     ':productID2' => $productID['rvskinDistributorProductID'][1]
                                    ))->fetchAll(); 
        return $result[0]['sumlicense'];
    }
    
    public function getRevenueRVSkinDistributor($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (:productID1,:productID2) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rvskinDistributorProductID'][0],
                                     ':productID2' => $productID['rvskinDistributorProductID'][1],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    public function countActiveRVSkinRegular($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5,
                                                           :productID6,
                                                           :productID7,
                                                           :productID8
                                                          )
                             ",array(':productID1' => $productID['rvSkinRegularProductID'][0],
                                     ':productID2' => $productID['rvSkinRegularProductID'][1],
                                     ':productID3' => $productID['rvSkinRegularProductID'][2],
                                     ':productID4' => $productID['rvSkinRegularProductID'][3],
                                     ':productID5' => $productID['rvSkinRegularProductID'][4],
                                     ':productID6' => $productID['rvSkinRegularProductID'][5],
                                     ':productID7' => $productID['rvSkinRegularProductID'][6],
                                     ':productID8' => $productID['rvSkinRegularProductID'][7]
                                    ))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    public function countNewRVSkinRegular($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cnew
                                FROM 
                                        hb_accounts 
                                WHERE 
                                        product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5,
                                                           :productID6,
                                                           :productID7,
                                                           :productID8
                                                          ) 
                                        and status = 'Active'
                                        and Date(date_created) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['rvSkinRegularProductID'][0],
                                     ':productID2' => $productID['rvSkinRegularProductID'][1],
                                     ':productID3' => $productID['rvSkinRegularProductID'][2],
                                     ':productID4' => $productID['rvSkinRegularProductID'][3],
                                     ':productID5' => $productID['rvSkinRegularProductID'][4],
                                     ':productID6' => $productID['rvSkinRegularProductID'][5],
                                     ':productID7' => $productID['rvSkinRegularProductID'][6],
                                     ':productID8' => $productID['rvSkinRegularProductID'][7],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cnew'];
    }
    
    
    
    public function countTerminatedRVSkinRegular($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cterminat
                                FROM 
                                        `hb_accounts` 
                                    
                                WHERE
                                        product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5,
                                                           :productID6,
                                                           :productID7,
                                                           :productID8
                                                          )  
                                        and status = 'Terminated'
                                        and Date(date_changed) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['rvSkinRegularProductID'][0],
                                     ':productID2' => $productID['rvSkinRegularProductID'][1],
                                     ':productID3' => $productID['rvSkinRegularProductID'][2],
                                     ':productID4' => $productID['rvSkinRegularProductID'][3],
                                     ':productID5' => $productID['rvSkinRegularProductID'][4],
                                     ':productID6' => $productID['rvSkinRegularProductID'][5],
                                     ':productID7' => $productID['rvSkinRegularProductID'][6],
                                     ':productID8' => $productID['rvSkinRegularProductID'][7],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cterminat'];
    }
    
    
    
    public function getRevenueRVSkinRegular($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5,
                                                           :productID6,
                                                           :productID7,
                                                           :productID8
                                                          ) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rvSkinRegularProductID'][0],
                                     ':productID2' => $productID['rvSkinRegularProductID'][1],
                                     ':productID3' => $productID['rvSkinRegularProductID'][2],
                                     ':productID4' => $productID['rvSkinRegularProductID'][3],
                                     ':productID5' => $productID['rvSkinRegularProductID'][4],
                                     ':productID6' => $productID['rvSkinRegularProductID'][5],
                                     ':productID7' => $productID['rvSkinRegularProductID'][6],
                                     ':productID8' => $productID['rvSkinRegularProductID'][7],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    public function countActiveRVSiteBuiderNOCClientAccount($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND product_id = :productID
                             ",array(':productID' => $productID['rvsiteBuiderNocProductID'][0]))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    public function countActiveRVSiteBuiderNOCLicense($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        sum(ac.qty) as sumlicense
                                FROM 
                                        hb_config2accounts ac 
                                        JOIN hb_config_items_cat f 
                                        ON 
                                            (
                                            ac.`rel_type`='Hosting' 
                                            AND f.product_id in (:productID1,:productID2) 
                                            AND ac.config_cat=f.id 
                                            AND f.name = 'quantity'
                                            )
                                        JOIN hb_accounts a 
                                        ON (
                                            ac.account_id = a.id
                                            AND a.status = 'Active'
                                            )
                             ",array(':productID1' => $productID['rvsiteBuiderNocProductID'][0],
                                     ':productID2' => $productID['rvsiteBuiderNocProductID'][1]
                                    ))->fetchAll(); 
        return $result[0]['sumlicense'];
    }
    
    public function getRevenueRVSiteBuiderNOC($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (:productID1,:productID2) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rvsiteBuiderNocProductID'][0],
                                     ':productID2' => $productID['rvsiteBuiderNocProductID'][1],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    public function countActiveRVSiteBuiderDistributorClientAccount($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND product_id = :productID
                             ",array(':productID' => $productID['rvsiteBuiderDistributorProductID'][0]))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    public function countActiveRVSiteBuiderDistributorLicense($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        sum(ac.qty) as sumlicense
                                FROM 
                                        hb_config2accounts ac 
                                        JOIN hb_config_items_cat f 
                                        ON 
                                            (
                                            ac.`rel_type`='Hosting' 
                                            AND f.product_id in (:productID1,:productID2) 
                                            AND ac.config_cat=f.id 
                                            AND f.name = 'quantity'
                                            )
                                        JOIN hb_accounts a 
                                        ON (
                                            ac.account_id = a.id
                                            AND a.status = 'Active'
                                            )
                             ",array(':productID1' => $productID['rvsiteBuiderDistributorProductID'][0],
                                     ':productID2' => $productID['rvsiteBuiderDistributorProductID'][1]
                                    ))->fetchAll(); 
        return $result[0]['sumlicense'];
    }
    
    public function getRevenueRVSiteBuiderDistributor($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (:productID1,:productID2) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rvsiteBuiderDistributorProductID'][0],
                                     ':productID2' => $productID['rvsiteBuiderDistributorProductID'][1],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    
    public function countActiveRVSiteBuiderRegular($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          )
                             ",array(':productID1' => $productID['rvSiteBuiderProductID'][0],
                                     ':productID2' => $productID['rvSiteBuiderProductID'][1],
                                     ':productID3' => $productID['rvSiteBuiderProductID'][2],
                                     ':productID4' => $productID['rvSiteBuiderProductID'][3],
                                     ':productID5' => $productID['rvSiteBuiderProductID'][4]
                                    ))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    public function countNewRVSiteBuiderRegular($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cnew
                                FROM 
                                        hb_accounts 
                                WHERE 
                                        product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4
                                                          ) 
                                        and status = 'Active'
                                        and Date(date_created) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['rvSiteBuiderProductID'][0],
                                     ':productID2' => $productID['rvSiteBuiderProductID'][1],
                                     ':productID3' => $productID['rvSiteBuiderProductID'][2],
                                     ':productID4' => $productID['rvSiteBuiderProductID'][3],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cnew'];
    }
    
    
    
    public function countTerminatedRVSiteBuiderRegular($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cterminat
                                FROM 
                                        `hb_accounts` 
                                    
                                WHERE
                                        product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4
                                                          )  
                                        and status = 'Terminated'
                                        and Date(date_changed) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['rvSiteBuiderProductID'][0],
                                     ':productID2' => $productID['rvSiteBuiderProductID'][1],
                                     ':productID3' => $productID['rvSiteBuiderProductID'][2],
                                     ':productID4' => $productID['rvSiteBuiderProductID'][3],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cterminat'];
    }
    
    
    
    public function getRevenueRVSiteBuiderRegular($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          ) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rvSiteBuiderProductID'][0],
                                     ':productID2' => $productID['rvSiteBuiderProductID'][1],
                                     ':productID3' => $productID['rvSiteBuiderProductID'][2],
                                     ':productID4' => $productID['rvSiteBuiderProductID'][3],
                                     ':productID5' => $productID['rvSiteBuiderProductID'][4],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    
    public function countActiveRV2FactorForWHMAccount($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        sum(ac.qty) as sumlicense
                                FROM 
                                        hb_config2accounts ac 
                                        JOIN hb_config_items_cat f 
                                        ON 
                                            (
                                            ac.`rel_type`='Hosting' 
                                            AND f.product_id in (:productID1,:productID2) 
                                            AND ac.config_cat=f.id 
                                            AND f.name = 'quantity'
                                            )
                                        JOIN hb_accounts a 
                                        ON (
                                            ac.account_id = a.id
                                            AND a.status = 'Active'
                                            )
                             ",array(':productID1' => $productID['rv2factorWHMProductID'][1],
                                     ':productID2' => $productID['rv2factorWHMProductID'][2]
                                    ))->fetchAll(); 
        $result2 = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND product_id = :productID
                             ",array(':productID' => $productID['rv2factorWHMProductID'][0]))->fetchAll(); 
       
        
        return $result[0]['sumlicense'] + $result2[0]['cactive'];
    }
    
    
    
    
    public function getRevenueRV2FactorForWHM($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          ) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rv2factorWHMProductID'][0],
                                     ':productID2' => $productID['rv2factorWHMProductID'][1],
                                     ':productID3' => $productID['rv2factorWHMProductID'][2],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    
    public function countActiveRV2FactorForCPanelAccount($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        sum(ac.qty) as sumlicense
                                FROM 
                                        hb_config2accounts ac 
                                        JOIN hb_config_items_cat f 
                                        ON 
                                            (
                                            ac.`rel_type`='Hosting' 
                                            AND f.product_id in (:productID1,:productID2) 
                                            AND ac.config_cat=f.id 
                                            AND f.name = 'quantity'
                                            )
                                        JOIN hb_accounts a 
                                        ON (
                                            ac.account_id = a.id
                                            AND a.status = 'Active'
                                            )
                             ",array(':productID1' => $productID['rv2factorCPanelProductID'][0],
                                     ':productID2' => $productID['rv2factorCPanelProductID'][1]
                                    ))->fetchAll(); 
       
       
        
        return $result[0]['sumlicense'] ;
    }
    
    
    
    
    public function getRevenueRV2FactorForCPanel($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                           :productID1,
                                                           :productID2
                                                          ) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rv2factorCPanelProductID'][0],
                                     ':productID2' => $productID['rv2factorCPanelProductID'][1],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    public function countActiveRV2FactorForAppAccount($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        sum(ac.qty) as sumlicense
                                FROM 
                                        hb_config2accounts ac 
                                        JOIN hb_config_items_cat f 
                                        ON 
                                            (
                                            ac.`rel_type`='Hosting' 
                                            AND f.product_id in (:productID1,:productID2) 
                                            AND ac.config_cat=f.id 
                                            AND f.name = 'quantity'
                                            )
                                        JOIN hb_accounts a 
                                        ON (
                                            ac.account_id = a.id
                                            AND a.status = 'Active'
                                            )
                             ",array(':productID1' => $productID['rv2factorAPPProductID'][0],
                                     ':productID2' => $productID['rv2factorAPPProductID'][1]
                                    ))->fetchAll(); 
       
       
        
        return $result[0]['sumlicense'] ;
    }
    
    
    
    
    public function getRevenueRV2FactorForApp($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                           :productID1,
                                                           :productID2
                                                          ) 
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['rv2factorAPPProductID'][0],
                                     ':productID2' => $productID['rv2factorAPPProductID'][1],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    public function countActiveCPanelDedM($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle NOT LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          )
                             ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2]
                                    ))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    
    
    public function countNewCPanelDedM($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cnew
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle NOT LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          )
                                        AND Date(date_created) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cnew'];
    }


    public function countTerminatedCPanelDedM($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cterminatssl
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Terminated'
                                        AND billingcycle NOT LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          )
                                        and Date(date_changed) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cterminatssl'];
    }
    
    
     public function getRevenueCPanelDedM($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          ) 
                                        AND a.billingcycle NOT LIKE 'Annually'
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    
    
    
    public function countActiveCPanelVPSM($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle NOT LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          )
                             ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4]
                                    ))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    
    
    public function countNewCPanelVPSM($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cnew
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle NOT LIKE 'Annually'
                                        AND product_id in (
                                                            :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          )
                                        AND Date(date_created) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4],                                     
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cnew'];
    }


    public function countTerminatedCPanelVPSM($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cterminatssl
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Terminated'
                                        AND billingcycle NOT LIKE 'Annually'
                                        AND product_id in (
                                                            :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          )
                                        and Date(date_changed) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cterminatssl'];
    }
    
    
     public function getRevenueCPanelVPSM($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                            :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          ) 
                                        AND a.billingcycle NOT LIKE 'Annually'
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    
    
    
    
    
    
    
    public function countActiveCPanelDedY($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          )
                             ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2]
                                    ))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    
    
    public function countNewCPanelDedY($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cnew
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          )
                                        AND Date(date_created) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cnew'];
    }


    public function countTerminatedCPanelDedY($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cterminatssl
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Terminated'
                                        AND billingcycle LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          )
                                        and Date(date_changed) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cterminatssl'];
    }
    
    
     public function getRevenueCPanelDedY($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3
                                                          ) 
                                        AND a.billingcycle LIKE 'Annually'
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['cpanelDedProductID'][0],
                                     ':productID2' => $productID['cpanelDedProductID'][1],
                                     ':productID3' => $productID['cpanelDedProductID'][2],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    
    
    
    public function countActiveCPanelVPSY($productID){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cactive
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle LIKE 'Annually'
                                        AND product_id in (
                                                           :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          )
                             ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4]
                                    ))->fetchAll(); 
        return $result[0]['cactive'];
    }
    
    
    
    
    
    public function countNewCPanelVPSY($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cnew
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Active'
                                        AND billingcycle LIKE 'Annually'
                                        AND product_id in (
                                                            :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          )
                                        AND Date(date_created) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cnew'];
    }


    public function countTerminatedCPanelVPSY($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cterminatssl
                                FROM 
                                        hb_accounts a
                                WHERE 
                                        status = 'Terminated'
                                        AND billingcycle LIKE 'Annually'
                                        AND product_id in (
                                                            :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          )
                                        and Date(date_changed) BETWEEN :startDate and :endDate 
                             ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll();
        return $result[0]['cterminatssl'];
    }
    
    
     public function getRevenueCPanelVPSY($productID,$date){
        $startAndEndDate = $this->getStartAndEndDateOfThisMonth($date);
        $startDate = $startAndEndDate[0];
        $endDate = $startAndEndDate[1];
        $db = hbm_db();
                           
        $result = $db->query("
                                SELECT
                                        sum(ii.amount) as revenue
                                FROM 
                                        hb_invoice_items ii,
                                        hb_accounts a,
                                        hb_invoices i                                       
                                WHERE 
                                        ii.type = 'Hosting'
                                        AND ii.item_id = a.id
                                        AND a.product_id in (
                                                            :productID1,
                                                           :productID2,
                                                           :productID3,
                                                           :productID4,
                                                           :productID5
                                                          ) 
                                        AND a.billingcycle LIKE 'Annually'
                                        AND ii.invoice_id = i.id
                                        AND i.status = 'Paid'
                                        AND date(i.datepaid) BETWEEN :startDate and :endDate  
                              ",array(':productID1' => $productID['cpanelVPSProductID'][0],
                                     ':productID2' => $productID['cpanelVPSProductID'][1],
                                     ':productID3' => $productID['cpanelVPSProductID'][2],
                                     ':productID4' => $productID['cpanelVPSProductID'][3],
                                     ':productID5' => $productID['cpanelVPSProductID'][4],
                                     ':startDate' => $startDate,
                                     ':endDate' => $endDate))->fetchAll(); 
                                     
       if($result[0]['revenue'] == null){
           $result[0]['revenue']=0;
       }
        return $result[0]['revenue'];
    }
    
    
    
    
    
    
    
    
    
    public function getStartAndEndDateOfThisMonth($date){
        if($this->startAndEndDateOfThisMonth == null || $this->startAndEndDateOfThisMonth[2] != $date){
            $splitDate = explode('-', $date); 
            $newDate =  $splitDate[0].'-'.$splitDate[1].'-1';
            $startDate = date('Y-m-d',strtotime($newDate));
            $endDate = date('Y-m-t',strtotime($newDate ));
            $this->startAndEndDateOfThisMonth = array($startDate,$endDate,$date);
        }
        return $this->startAndEndDateOfThisMonth;
    }
    
    
    
    
    
    
    
    public function getAverageResponseTime($today){
        $db = hbm_db();
        $startDate      = date('Y-m-d H:i:s', strtotime($today));
        $endDate        = date('Y-m-d H:i:s', strtotime('+1 day', strtotime($today)) -1 );
        $sql = sprintf("
                SELECT 
                        AVG(sub.timediff) avg_response,
                        AVG(TIMESTAMPDIFF(MINUTE, tc.date, tc.lastupdate )) avg_resolve  
                FROM (
                        SELECT 
                                t.id, TIMESTAMPDIFF(MINUTE, t.date, MIN(r.date) ) `timediff` 
                        FROM 
                                hb_tickets t 
                        JOIN 
                                hb_ticket_replies r 
                                ON t.id=r.ticket_id 
                                AND r.`type`='Admin'
                        WHERE 
                                t.date >= '%s' 
                                AND t.date <= '%s'
                        GROUP BY 
                                r.ticket_id 
                        ORDER BY 
                                t.date ASC, r.date ASC
                ) sub
                LEFT JOIN 
                            hb_tickets tc 
                            ON tc.id=sub.id 
                            AND tc.`status`='Closed'",$startDate,$endDate);
        
        $result = $db->query($sql, array())->fetch();
         if($result['avg_response']==null)
            $result['avg_response'] = 0;
        if($result['avg_resolve']==null)
            $result['avg_resolve'] = 0;
        if (isset($result['avg_response'])) {
            $ans   = array(
                    'avg_response'      => floor($result['avg_response']) ,
                    'avg_resolve'       => floor($result['avg_resolve']) 
                );
        }
        
        return $ans;
    }
    
    
    public function countUnresponsedAndResponseTimeOver($today){
        $db = hbm_db();
        $result = $db->query("
                              SELECT 
                                    sum(unresponsed_timeover) as unresponse,
                                    sum(responsed_timeover) as responseover
                              FROM 
                                    `hb_kpi_ticket` 
                              WHERE 
                                    DATE(date) = :today
                             ",array(':today' => $today))->fetchAll(); 
        if($result[0]['unresponse'] == null)
            $result[0]['unresponse'] = 0;
        if($result[0]['responseover'] == null)
            $result[0]['responseover'] = 0;
        return array('unresponse' => $result[0]['unresponse'],'responseover' => $result[0]['responseover']);
    }
    
    
    public function countDailyNewTicket($today){
           $db = hbm_db();
          
           $result = $db->query("
                                SELECT 
                                        count(*) as cnewtickets
                                FROM 
                                        hb_tickets
                                WHERE 
                                        DATE(date) = :today
                                ",array(':today' => $today))->fetchAll(); 
           return $result[0]['cnewtickets'];
    } 
    
    public function countDailyChat($today){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                        count(*) as cchat
                                FROM 
                                        `hb_chat_discussions2` cd 
                                WHERE 
                                        date(cd.date_start) = :today
                             ",array(':today' => $today))->fetchAll(); 
        return $result[0]['cchat'];
    }
    
    
    
    
    
    
    
    
    
    public function countUnresponsedAndResponseTimeOverGCS($arrDepaID,$today){
        $db = hbm_db();
        $result = $db->query("
                              SELECT 
                                    sum(unresponsed_timeover) as unresponse,
                                    sum(responsed_timeover) as responseover
                              FROM 
                                    `hb_kpi_ticket` 
                              WHERE 
                                    dept_id IN (:deptID1,:deptID2,:deptID3,:deptID4,:deptID5)
                                    AND DATE(date) = :today
                             ",array(':deptID1' => $arrDepaID['sslCertificates'],
                                     ':deptID2' => $arrDepaID['billingAndPayment'],
                                     ':deptID3' => $arrDepaID['cPanelWHMLicense'],
                                     ':deptID4' => $arrDepaID['bouncedMail'],
                                     ':deptID5' => $arrDepaID['translation'],
                                     ':today' => $today))->fetchAll(); 
        if($result[0]['unresponse'] == null)
            $result[0]['unresponse'] = 0;
        if($result[0]['responseover'] == null)
            $result[0]['responseover'] = 0;
        return array('unresponse' => $result[0]['unresponse'],'responseover' => $result[0]['responseover']);
    }
    
    
    
    public function countUnresponsedAndResponseTimeOverDev1($arrDepaID,$today){
        $db = hbm_db();
        $result = $db->query("
                              SELECT 
                                    sum(unresponsed_timeover) as unresponse,
                                    sum(responsed_timeover) as responseover
                              FROM 
                                    `hb_kpi_ticket` 
                              WHERE 
                                    dept_id IN (:deptID1,:deptID2)
                                    AND DATE(date) = :today
                             ",array(':deptID1' => $arrDepaID['rvSiteBuilder'],
                                     ':deptID2' => $arrDepaID['rvskinAndRVSubversion'],
                                     ':today' => $today))->fetchAll(); 
        if($result[0]['unresponse'] == null)
            $result[0]['unresponse'] = 0;
        if($result[0]['responseover'] == null)
            $result[0]['responseover'] = 0;
        return array('unresponse' => $result[0]['unresponse'],'responseover' => $result[0]['responseover']);
    }
    
    
    
    
     public function countUnresponsedAndResponseTimeOverDev2($arrDepaID,$today){
        $db = hbm_db();
        $result = $db->query("
                              SELECT 
                                    sum(unresponsed_timeover) as unresponse,
                                    sum(responsed_timeover) as responseover
                              FROM 
                                    `hb_kpi_ticket` 
                              WHERE 
                                    dept_id IN (:deptID1,:deptID2)
                                    AND DATE(date) = :today
                             ",array(':deptID1' => $arrDepaID['rv2Factor'],
                                     ':deptID2' => $arrDepaID['rvPanel'],
                                     ':today' => $today))->fetchAll(); 
        if($result[0]['unresponse'] == null)
            $result[0]['unresponse'] = 0;
        if($result[0]['responseover'] == null)
            $result[0]['responseover'] = 0;
        return array('unresponse' => $result[0]['unresponse'],'responseover' => $result[0]['responseover']);
    }
    
    
    
    
    
    public function countDailyNewTicketGCS($arrDepaID,$today){
           $db = hbm_db();
          
           $result = $db->query("
                                    SELECT 
                                            count(*) as cnewtickets
                                    FROM 
                                            hb_tickets
                                    WHERE 
                                            DATE(date) = :today
                                            AND dept_id IN (:deptID1,:deptID2,:deptID3,:deptID4,:deptID5)
                                ",array(':deptID1' => $arrDepaID['sslCertificates'],
                                         ':deptID2' => $arrDepaID['billingAndPayment'],
                                         ':deptID3' => $arrDepaID['cPanelWHMLicense'],
                                         ':deptID4' => $arrDepaID['bouncedMail'],
                                         ':deptID5' => $arrDepaID['translation'],
                                        ':today' => $today))->fetchAll(); 
           return $result[0]['cnewtickets'];
    } 





    public function countDailyNewTicketDev1($arrDepaID,$today){
           $db = hbm_db();
          
           $result = $db->query("
                                    SELECT 
                                            count(*) as cnewtickets
                                    FROM 
                                            hb_tickets
                                    WHERE 
                                            DATE(date) = :today
                                            AND dept_id IN (:deptID1,:deptID2)
                                ",array(':deptID1' => $arrDepaID['rvSiteBuilder'],
                                        ':deptID2' => $arrDepaID['rvskinAndRVSubversion'],
                                        ':today' => $today))->fetchAll(); 
           return $result[0]['cnewtickets'];
    } 
    
    
    
    
    public function countDailyNewTicketDev2($arrDepaID,$today){
           $db = hbm_db();
          
           $result = $db->query("
                                    SELECT 
                                            count(*) as cnewtickets
                                    FROM 
                                            hb_tickets
                                    WHERE 
                                            DATE(date) = :today
                                            AND dept_id IN (:deptID1,:deptID2)
                                ",array(':deptID1' => $arrDepaID['rv2Factor'],
                                        ':deptID2' => $arrDepaID['rvPanel'],
                                        ':today' => $today))->fetchAll(); 
           return $result[0]['cnewtickets'];
    } 







    public function getAverageResponseAndResolveGCS($arrDepaID,$today){
        $db = hbm_db();
        $startDate      = date('Y-m-d H:i:s', strtotime($today));
        $endDate        = date('Y-m-d H:i:s', strtotime('+1 day', strtotime($today)) -1 );
  
        $result = $db->query("
                                SELECT 
                                        AVG(sub.timediff) avg_response,
                                        AVG(TIMESTAMPDIFF(MINUTE, tc.date, tc.lastupdate )) avg_resolve  
                                FROM (
                                        SELECT 
                                                t.id, TIMESTAMPDIFF(MINUTE, t.date, MIN(r.date) ) `timediff` 
                                        FROM 
                                                hb_tickets t 
                                        JOIN 
                                                hb_ticket_replies r 
                                                ON t.id=r.ticket_id 
                                                AND r.`type`='Admin'
                                        WHERE 
                                                t.date >= :startDate 
                                                AND t.date <= :endDate
                                                AND t.dept_id IN (:deptID1,:deptID2,:deptID3,:deptID4,:deptID5)
                                        GROUP BY 
                                                r.ticket_id 
                                        ORDER BY 
                                                t.date ASC, r.date ASC
                                ) sub
                                LEFT JOIN 
                                            hb_tickets tc 
                                            ON tc.id=sub.id 
                                            AND tc.`status`='Closed'
                              ", array(':deptID1' => $arrDepaID['sslCertificates'],
                                         ':deptID2' => $arrDepaID['billingAndPayment'],
                                         ':deptID3' => $arrDepaID['cPanelWHMLicense'],
                                         ':deptID4' => $arrDepaID['bouncedMail'],
                                         ':deptID5' => $arrDepaID['translation'],
                                       ':startDate' => $startDate,
                                       ':endDate' => $endDate))->fetch();
        if($result['avg_response']==null)
            $result['avg_response'] = 0;
        if($result['avg_resolve']==null)
            $result['avg_resolve'] = 0;
        if (isset($result['avg_response'])) {
            $ans   = array(
                    'avg_response'      => floor($result['avg_response']) ,
                    'avg_resolve'       => floor($result['avg_resolve']) 
                );
        }
        return $ans;
    }
    
    
    public function getAverageResponseAndResolveDev1($arrDepaID,$today){
        $db = hbm_db();
        $startDate      = date('Y-m-d H:i:s', strtotime($today));
        $endDate        = date('Y-m-d H:i:s', strtotime('+1 day', strtotime($today)) -1 );
  
        $result = $db->query("
                                SELECT 
                                        AVG(sub.timediff) avg_response,
                                        AVG(TIMESTAMPDIFF(MINUTE, tc.date, tc.lastupdate )) avg_resolve  
                                FROM (
                                        SELECT 
                                                t.id, TIMESTAMPDIFF(MINUTE, t.date, MIN(r.date) ) `timediff` 
                                        FROM 
                                                hb_tickets t 
                                        JOIN 
                                                hb_ticket_replies r 
                                                ON t.id=r.ticket_id 
                                                AND r.`type`='Admin'
                                        WHERE 
                                                t.date >= :startDate 
                                                AND t.date <= :endDate
                                                AND t.dept_id IN (:deptID1,:deptID2)
                                        GROUP BY 
                                                r.ticket_id 
                                        ORDER BY 
                                                t.date ASC, r.date ASC
                                ) sub
                                LEFT JOIN 
                                            hb_tickets tc 
                                            ON tc.id=sub.id 
                                            AND tc.`status`='Closed'
                              ", array(':deptID1' => $arrDepaID['rvSiteBuilder'],
                                        ':deptID2' => $arrDepaID['rvskinAndRVSubversion'],
                                       ':startDate' => $startDate,
                                       ':endDate' => $endDate))->fetch();
        if($result['avg_response']==null)
            $result['avg_response'] = 0;
        if($result['avg_resolve']==null)
            $result['avg_resolve'] = 0;
        if (isset($result['avg_response'])) {
            $ans   = array(
                    'avg_response'      => floor($result['avg_response']) ,
                    'avg_resolve'       => floor($result['avg_resolve']) 
                );
        }
        return $ans;
    }
    
    
    
    
    public function getAverageResponseAndResolveDev2($arrDepaID,$today){
        $db = hbm_db();
        $startDate      = date('Y-m-d H:i:s', strtotime($today));
        $endDate        = date('Y-m-d H:i:s', strtotime('+1 day', strtotime($today)) -1 );
  
        $result = $db->query("
                                SELECT 
                                        AVG(sub.timediff) avg_response,
                                        AVG(TIMESTAMPDIFF(MINUTE, tc.date, tc.lastupdate )) avg_resolve  
                                FROM (
                                        SELECT 
                                                t.id, TIMESTAMPDIFF(MINUTE, t.date, MIN(r.date) ) `timediff` 
                                        FROM 
                                                hb_tickets t 
                                        JOIN 
                                                hb_ticket_replies r 
                                                ON t.id=r.ticket_id 
                                                AND r.`type`='Admin'
                                        WHERE 
                                                t.date >= :startDate 
                                                AND t.date <= :endDate
                                                AND t.dept_id IN (:deptID1,:deptID2)
                                        GROUP BY 
                                                r.ticket_id 
                                        ORDER BY 
                                                t.date ASC, r.date ASC
                                ) sub
                                LEFT JOIN 
                                            hb_tickets tc 
                                            ON tc.id=sub.id 
                                            AND tc.`status`='Closed'
                              ", array(':deptID1' => $arrDepaID['rv2Factor'],
                                        ':deptID2' => $arrDepaID['rvPanel'],
                                       ':startDate' => $startDate,
                                       ':endDate' => $endDate))->fetch();
        if($result['avg_response']==null)
            $result['avg_response'] = 0;
        if($result['avg_resolve']==null)
            $result['avg_resolve'] = 0;
        if (isset($result['avg_response'])) {
            $ans   = array(
                    'avg_response'      => floor($result['avg_response']) ,
                    'avg_resolve'       => floor($result['avg_resolve']) 
                );
        }
        return $ans;
    }
    
    public function getAverageResolveTimeFromCounterDev2($arrDepaID,$today){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                       AVG(tmc.counter_in_minute) as avgmin
                                FROM 
                                       hb_ticket_ma_counter tmc,
                                       hb_tickets t
                                WHERE
                                       tmc.ticket_id = t.id
                                       AND tmc.date LIKE '{$today}%'
                                       AND t.dept_id IN (:deptID1,:deptID2)
                              ", array(':deptID1' => $arrDepaID['rv2Factor'],
                                        ':deptID2' => $arrDepaID['rvPanel']))->fetch();
        if($result['avgmin']==null){
            $result['avgmin'] = 0;   
        }                                
        return $result['avgmin'];
    }
    
    
    public function getAverageResolveTimeFromCounterDev1($arrDepaID,$today){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                       AVG(tmc.counter_in_minute) as avgmin
                                FROM 
                                       hb_ticket_ma_counter tmc,
                                       hb_tickets t
                                WHERE
                                       tmc.ticket_id = t.id
                                       AND tmc.date LIKE '{$today}%'
                                       AND t.dept_id IN (:deptID1,:deptID2)
                              ", array(':deptID1' => $arrDepaID['rvSiteBuilder'],
                                       ':deptID2' => $arrDepaID['rvskinAndRVSubversion']))->fetch();
        if($result['avgmin']==null){
            $result['avgmin'] = 0;  
        }                                 
        return $result['avgmin'];
    }
    
    public function getAverageResolveTimeFromCounterDevs($DepID,$day){
        $db = hbm_db();
        $result = $db->query("
                                SELECT 
                                       AVG(tmc.counter_in_minute) as avgmin
                                FROM 
                                       hb_ticket_ma_counter tmc,
                                       hb_tickets t
                                WHERE
                                       tmc.ticket_id = t.id
                                       AND tmc.date LIKE '{$day}%'
                                       AND t.dept_id = {$DepID}
                              ")->fetch();
        if($result['avgmin']==null){
            $result['avgmin'] = 0;  
        }                                 
        return $result['avgmin'];
    }

}
