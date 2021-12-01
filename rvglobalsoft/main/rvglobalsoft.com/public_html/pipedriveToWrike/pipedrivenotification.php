<?php


    $rawdata = @file_get_contents('php://input');
    
    include_once('class.wrikeApiV3.php');
    require('../includes/hostbill.php');
    
 
    if($rawdata!=null){
        $wrike          = new wrikeV3();
        $username       = "pairote@netway.co.th";
        $password       = "ritik,g0Hf";
        
        $token          = authenPipe($username,$password);
        
        $arrDate        = json_decode($rawdata);
        
        if(trim($arrDate->event) == "updated.deal"){
            
            $pipeDeal   = $arrDate->current;
            $taskID     = getTaskID($pipeDeal->id);
            $task       = $wrike->getTask($taskID); 
            $taskStatus = $task['result']['data'][0]['status'];
            if($taskStatus == 'Active'){
                //@mail("panya@rvglobalsoft.com","updated.deal",$pipeDeal->id);
                
                $task_id    = updateTaskWrike($wrike, $pipeDeal, $token);
               
                if($pipeDeal->activities_count != null && $pipeDeal->activities_count > 0){
                    addCommentToTask($wrike,$pipeDeal,$task_id ,$token);
                }
                pipeDriveDealStatus($pipeDeal->id);
            }
        }
        else if(trim($arrDate->event) == "added.deal"){
            
            $pipeDeal   = $arrDate->current;
            $ordertype  = '87244ecdac1ac8178ade6a9a2a16e5656b4a5fdd';
            //@mail("panya@rvglobalsoft.com","add.deal",print_r($pipeDeal,TRUE));
            if(($pipeDeal->pipeline_id == 4 && $pipeDeal->$ordertype == 3)
				||	($pipeDeal->pipeline_id == 11 && $pipeDeal->$ordertype == 3)
				||	($pipeDeal->pipeline_id == 14 && $pipeDeal->$ordertype == 3)
				){
                exit;
            }
            if($pipeDeal->pipeline_id == 21){
                exit;
            }
            
            $taskID     = addTaskWrike($wrike, $pipeDeal, $token);
            
            if($pipeDeal->activities_count != null && $pipeDeal->activities_count > 0){
                addAllCommentToTask($wrike,$pipeDeal,$taskID,$token);
            }
            /*if($pipeDeal->notes_count != null && $pipeDeal->notes_count > 0){
                addNoteToTask($wrike,$pipeDeal,$task_id ,$token);
            }*/
           
        }
        else if($arrDate->event == "deleted.deal"){
           //@mail("panya@rvglobalsoft.com","delete.deal","Test");
            $pipeDeal   = $arrDate->previous;
            deleteTask($wrike, $pipeDeal->id);
        }
        else if($arrDate->event == "added.note"){
           //@mail("panya@rvglobalsoft.com","added.note","Test");
            $pipeDeal   = $arrDate->current;
            addNoteToTask($wrike,$pipeDeal,$token);
            
        }
        
    }
    
    /**
     * authenPipeDrive get token
     */
    
    function authenPipe($username,$password){
            
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL,"https://api.pipedrive.com/v1/authorizations");
        curl_setopt($ch, CURLOPT_POST, 1);
        
        $dateLogin = array('email'=>$username,
                           'password'=>$password);
        
        curl_setopt($ch, CURLOPT_POSTFIELDS,http_build_query($dateLogin));
                  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        
        $arrOutPut = json_decode(curl_exec ($ch));
        curl_close ($ch);
        print_r($arrOutPut);
        $apitoken           = $arrOutPut->data[0]->api_token;
        
        return $apitoken;
            
    }
    
    /**
     * get Stage name by stage id
     */
    function getStageName($id,$token){
        $url = "https://api.pipedrive.com/v1/stages/".$id."?api_token=".$token;
     
        $ch = curl_init();
            
        curl_setopt($ch, CURLOPT_URL,$url);  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        
        $arrOutPut = json_decode(curl_exec ($ch));
        curl_close ($ch);
    
        return $arrOutPut->data->name;
    }
    
    function addAllCommentToTask($wrike,$deal,$taskID,$token){
        $arrOutPut = getDealupdate($deal->id, $token);
        
        foreach ($arrOutPut->data as $value) {
            
         
                if($value->item_type == "activity"){
                    if($value->story_data->action_type == "add"){
                        $text  = $value->story_data->user_name." added a ";
                        $text .= $value->story_data->activity_type." to deal ";
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                         if($value->story_data->activity_content->content_clean != "")
                        $text .= "<br>Note: ".$value->story_data->activity_content->content_clean;
                    }
                    else if($value->story_data->action_type == "edit"){
                        $text  = $value->story_data->user_name."  finished a ";
                        $text .= $value->story_data->activity_type;
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                         if($value->story_data->activity_content->content_clean != "")
                        $text .= "<br>Note: ".$value->story_data->activity_content->content_clean;
                    }
                    else if($value->story_data->action_type == "delete"){
                        $text  = $value->story_data->user_name."  deleted a call";
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                        if($value->story_data->activity_content->content_clean != "")
                        $text .= "<br>Note: ".$value->story_data->activity_content->content_clean;
                    }
                }
                else if($value->item_type == "comment"){
                    if($value->story_data->action_type == "add"){
                        $text  = $value->story_data->user_name." added a note to the deal ";
                        $text .= "<br>".$value->story_data->comment_content;
                    }
                    
                }
                else if($value->item_type == "deal"){
                    if($value->story_data->action_type == "edit"){
                        $text  = $value->story_data->user_name."  edited the deal ";
                        foreach ($value->story_data->change_log as $key) {
                            $text .= "<br>".$key->field_name." : ";
                            $text .= $key->old_value." -> ".$key->new_value;
                        }
                        
                    }
                    
                }
                
                if(isset($text)){
                    $comment = $wrike->addComment($taskID,$text);
                   
                }
            
        }
    }
    
    function addCommentToTask($wrike,$deal,$taskID,$token){
 
        
        $arrOutPut = getDealupdate($deal->id, $token);
        
        foreach ($arrOutPut->data as $value) {
            
            if($deal->update_time == $value->add_time){
                if($value->item_type == "activity"){
                    if($value->story_data->action_type == "add"){
                        $text  = $value->story_data->user_name." added a ";
                        $text .= $value->story_data->activity_type." to deal ";
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                         if($value->story_data->activity_content->content_clean != "")
                        $text .= "<br>Note: ".$value->story_data->activity_content->content_clean;
                    }
                    else if($value->story_data->action_type == "edit"){
                        $text  = $value->story_data->user_name."  finished a ";
                        $text .= $value->story_data->activity_type;
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                         if($value->story_data->activity_content->content_clean != "")
                        $text .= "<br>Note: ".$value->story_data->activity_content->content_clean;
                    }
                    else if($value->story_data->action_type == "delete"){
                        $text  = $value->story_data->user_name."  deleted a call";
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                         if($value->story_data->activity_content->content_clean != "")
                        $text .= "<br>Note: ".$value->story_data->activity_content->content_clean;
                    }
                }
                else if($value->item_type == "comment"){
                    if($value->story_data->action_type == "add"){
                        $text  = $value->story_data->user_name." added a note to the deal ";
                        $text .= "<br>".$value->story_data->comment_content;
                    }
                    
                }
                else if($value->item_type == "deal"){
                    if($value->story_data->action_type == "edit"){
                        $text  = $value->story_data->user_name."  edited the deal ";
                        foreach ($value->story_data->change_log as $key) {
                            $text .= "<br>".$key->field_name." : ";
                            $text .= $key->old_value." -> ".$key->new_value;
                        }
                        
                    }
                    
                }
               
                if(isset($text)){
                    $comment = $wrike->addComment($taskID,$text);
                   
                }
            }
        }
    }
    
    function addNoteToTask($wrike,$deal,$token){
        $taskID = getTaskID($deal->deal_id);
        
        $arrOutPut = getDealupdate($deal->deal_id, $token);
        
        foreach ($arrOutPut->data as $value) {
            
            if($deal->id == $value->item_id){
                if($value->item_type == "comment"){
                    if($value->story_data->action_type == "add"){
                        $text  = $value->story_data->user_name." added a note to the deal ";
                        $text .= "<br>".$value->story_data->comment_content;
                    }
                }
                    
                if(isset($text)){
                    $comment = $wrike->addComment($taskID,$text);
                    
                }
            }
            
        }
    }
    
    
    
    function getDealupdate($dealId,$token){
        
        $url = "https://api.pipedrive.com/v1/deals/".$dealId."/updates?start=0&api_token=".$token;
        $ch  = curl_init();
            
        curl_setopt($ch, CURLOPT_URL,$url);  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        
        $arrOutPut = json_decode(curl_exec ($ch));
        curl_close ($ch);
        
        
        return $arrOutPut;
    }
    
    
    /**
     * add task to wrike
     */
    function addTaskWrike($wrike,$arrData,$tokenPipe){
        $db             = hbm_db();
        
        $desc  = $arrData->title."<br>";
        $desc .= "person_name : ".$arrData->person_name."<br>";
        $desc .= "add_time : ".$arrData->add_time."<br>";
		$desc .= "link : <a href=\"https://netwaycommunication.pipedrive.com/deal/".$arrData->id."\">https://netwaycommunication.pipedrive.com/deal/".$arrData->id."</a><br>";
       
       if($arrData->status == 'won'){
            $status = 'Completed';
            $title = "(Won)".$arrData->title;
        }
        else if($arrData->status == 'lost'){
            $status = 'Completed';
            $title = "(Lost)".$arrData->title;
        }
        else {
            $status = 'Active';
            $title = "(".getStageName($arrData->stage_id,$tokenPipe).")".$arrData->title;
        }
        
        
        //$startDate      = $arrData->add_time."T00:00:00";
        //$dueDate        = $arrData->rotten_time."T00:00:00";
        
        
        if ($arrData->pipeline_id == 4){
            $parent         = "IEAAFYNWI4A5RPPX"; //SALE-SSL
        }
        else if ($arrData->pipeline_id == 12){
            $parent         = "IEAAFYNWI4A5RPRS"; //SALE-NW
        }
        else if ($arrData->pipeline_id == 14){
            $parent         = "IEAAFYNWI4A5RPUP"; //BD
        }
        else if ($arrData->pipeline_id == 11){
            $parent         = "IEAAFYNWI4A5RPP6"; //SALE-EM
        }
        else if ($arrData->pipeline_id == 17){
            $parent         = "IEAAFYNWI4BJPD23"; //Apps
        }
        else if ($arrData->pipeline_id == 8){
            $parent         = "IEAAFYNWI4AWW5XK"; //RV Pipeline
        }
        else if ($arrData->pipeline_id == 18){
            $parent         = "IEAAFYNWI4BPGELK"; //Netway Business Solution
        }        
         
        $task           = $wrike->addTask($title,$desc,$status,$parent);
        $taskID         = $task['result']['data'][0]['id'];
        //@mail("panya@rvglobalsoft.com","Here",print_r($task,TRUE));        
        
        if (! $taskID) {
            return $taskID;
        }
        
        $db->query("
                INSERT INTO `pipedrive_to_wrike`(`deal_id`, `task_id`) 
                VALUES (:dealid,:taskid)     
                ", array(
                    ':dealid'        => $arrData->id,
                    ':taskid'        => $taskID
                ));
       
        return $taskID;
        
    }


    function updateTaskWrike($wrike,$arrData,$tokenPipe){
        $taskID = getTaskID($arrData->id);
     
        if($taskID != null){
        $desc  = $arrData->title."<br>";
        $desc .= "person_name : ".$arrData->person_name."<br>";
        $desc .= "add_time : ".$arrData->add_time."<br>";
		$desc .= "link : <a href=\"https://netwaycommunication.pipedrive.com/deal/".$arrData->id."\">https://netwaycommunication.pipedrive.com/deal/".$arrData->id."</a><br>";
       
       if($arrData->status == 'won'){
            $status = 'Completed';
            $title = "(Won)".$arrData->title;
        }
        else if($arrData->status == 'lost'){
            $status = 'Completed';
            $title = "(Lost)".$arrData->title;
        }
        else {
            $status = 'Active';
            $title = "(".getStageName($arrData->stage_id,$tokenPipe).")".$arrData->title;
        }
        
        //$startDate      = $arrData->add_time."T00:00:00";
        //$dueDate        = $arrData->rotten_time."T00:00:00";    
        
        $task = $wrike->updateTask($taskID,$title,$desc,$status);
        $taskID         = $task['result']['data'][0]['id'];
        }
        return $taskID;
    }
     
    function deleteTask($wrike,$dealID){
        $taskID = getTaskID($dealID);
        $wrike->deleteTask($taskID);
        deleteData($taskID);
    }
    
    
    
    function getTaskID($dealID){
        $db             = hbm_db();
        $result  = $db->query("
                    SELECT task_id as id
                    FROM pipedrive_to_wrike
                    WHERE deal_id = :dealID
                    ", array(
                        ':dealID'    => $dealID
                    ))->fetchAll();
        return $result[0]['id'];
    }
    
    
    
    function getCommentID($activityID){
        $db             = hbm_db();
        $result  = $db->query("
                    SELECT comment_id as id
                    FROM pipedrive_to_wrike_comment
                    WHERE activity_id = :activityID
                    ", array(
                        ':activityID'    => $activityID
                    ))->fetchAll();
        return $result[0]['id'];
    }
    
    function deleteData($taskID){
        $db             = hbm_db();
        $db->query("
                    DELETE FROM `pipedrive_to_wrike` WHERE task_id = :taskid
                    ", array(
                        ':taskid'    => $taskID
                    ));
        
    }
    
    function pipeDriveDealStatus ($dealId) {
    
        $db     = hbm_db();
        $ch     = curl_init();
        //$url = 'api.pipedrive.com/v1/deals?start=1200&limit=500&sort_mode=asc&api_token=2bdb3e62a2c8ca08b9747fc98503c8dcdf75ab25';        
        $url    = 'api.pipedrive.com/v1/deals/'. $dealId .'?api_token=2bdb3e62a2c8ca08b9747fc98503c8dcdf75ab25';
        
        curl_setopt($ch, CURLOPT_HEADER, 0 );
        curl_setopt($ch, CURLOPT_URL,$url);  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        
        $result     = curl_exec ($ch);
        curl_close ($ch);
        
        $aOutPut    = json_decode($result);
        
        $orderTypeFields    = '87244ecdac1ac8178ade6a9a2a16e5656b4a5fdd';
        $stages     = array( 
                        //CS
                        '1'=>'1', //Opportunities
                        '4'=>'2', //Quotations
                        '12'=>'3', //Billing
                        //SALE-SSL
                        '20'=>'1', //Opportunities
                        '21'=>'2', //Communications
                        '22'=>'3', //Quotations
                        '80'=>'4', //Renewal
                        '23'=>'5', //Billing
                        //SALE-GM
                        '14'=>'1', //Opportunities
                        '15'=>'2', //Communications
                        '16'=>'3', //Develop Solutions
                        '17'=>'4', //Quotations
                        '18'=>'5', //Trial 30 Days
                        '24'=>'6', //Renewal
                        '19'=>'7', //Billing
                        //SALE-DS
                        '66'=>'1', //Opportunities
                        '67'=>'2', //Communications
                        '68'=>'3', //Quotation
                        '69'=>'4', //Trail 30 วัน
                        '72'=>'5', //Implement
                        '70'=>'6', //Renewal
                        '71'=>'7', //Billing
                        //BD
                        '73'=>'1', //Opportunities
                        '74'=>'2', //Communications
                        '77'=>'3', //Develop Solutions
                        '75'=>'4', //Quotations
                        '78'=>'5', //Renewals
                        '79'=>'6', //Billing
                        //MKT Deals            
                        '25'=>'1', //Marketing Captured Lead (MCL)
                        '26'=>'2', //Marketing Qualified Lead (MQL)
                        '27'=>'3', //Sales Qualified Lead (SAL)
                        //MKT Partner Deals            
                        '31'=>'1', //Captured
                        '32'=>'2', //Initial Contact
                        '33'=>'3', //Meeting
                        '34'=>'4', //Negotiation
                        '35'=>'5', //Contract Signing
                        '36'=>'6', //Opportunity Optimization
                        //RV Pipeline            
                        '38'=>'1', //Captured
                        '42'=>'2', //Initial Contact
                        '39'=>'3', //Qualified
                        '40'=>'4', //Ordering
                        '41'=>'5', //Billed
                        //Netway Pipeline
                        '57'=>'1', //Demand Generation
                        '58'=>'2', //Prospect (captured)
                        '59'=>'3', //Qualified
                        '60'=>'4', //Develop
                        '61'=>'5', //Solution
                        '62'=>'6', //Proof
                        '63'=>'7', //Close
                        '64'=>'8', //Deploy
                        '65'=>'9' //Support (after sales)
                    );
        $pipeline   = array( 
                        //CS
                        '1'=>'CS',
                        //SALE-SSL
                        '4'=>'SALE-SSL',
                        //SALE-GM
                        '5'=>'SALE-GM',
                        //SALE-DS
                        '12'=>'SALE-DS',
                        //BD
                        '14'=>'BD',
                        //MKT Deals            
                        '6'=>'MKT Deals',
                        //MKT Partner Deals            
                        '7'=>'MKT Partner Deals',
                        //RV Pipeline            
                        '8'=>'RV Pipeline',
                        //Netway Pipeline           
                        '11'=>'Netway Pipeline'
                    );
        $billingStage = array(
                        '1'=>'3',
                        '4'=>'5',
                        '5'=>'7',
                        '12'=>'7',
                        '14'=>'6',
                        '6'=>'3',
                        '7'=>'6',
                        '8'=>'5',
                        '11'=>'9'
                    );
        
        $aData      = $aOutPut->data;    
        
        if (! isset($aData->id) || ! $aData->id) {
            return false;
        }
                                                        
        if ($aData->$orderTypeFields == '2') {
            $orderType      = 'New';
        } else if ($aData->$orderTypeFields == '3') {
            $orderType      = 'Renew';
        } else {
             $orderType     = 'New';
        }
        
        
        /*if (! in_array($aData->status, array('won', 'lost')) ) { 
            return false;
        }*/
            
        if (! in_array($orderType, array('New', 'Renew')) ) {
            if(! in_array($aData->pipeline_id, array('8'))){
                return false;
            }
        }
        
        $result     = $db->query("
                    SELECT 
                        date_changed
                    FROM
                        pipedrive
                    WHERE
                        deal_id = :dealId
                    ", array(
                        ':dealId'        => $dealId
                    ))->fetch();
        
        $update = false;    
        if (isset($result['date_changed'])) {
            $update = true;
            //return false;
        }
            
        $getStage   = $stages[$aData->stage_id];
        $setDbStage = array('0','0','0','0','0','0','0','0','0'); 
        $isWon      = 0;
        
        /*if ($aData->status == 'lost') {
            $getStage   = $getStage;
        }*/
        if ($aData->status == 'won') {
            $getStage   = $billingStage[$aData->pipeline_id];
            $isWon      = 1;
        }
        
        for ($i = 0 ; $i < $getStage ; $i++) {
            $setDbStage[$i]     = 1; 
        }
        
        if($update){
            //@mail("panya@rvglobalsoft.com","case : update",$aData->id);
            $db->query("
                    UPDATE pipedrive
                    SET date_changed = :dateChanged,
                        won_stage_1  = :wonStage1,
                        won_stage_2  = :wonStage2,
                        won_stage_3  = :wonStage3,
                        won_stage_4  = :wonStage4,
                        won_stage_5  = :wonStage5,
                        won_stage_6  = :wonStage6,
                        won_stage_7  = :wonStage7,
                        won_stage_8  = :wonStage8,
                        won_stage_9  = :wonStage9,
                        is_won       = :isWon    
                    WHERE deal_id = :dealId   
            ",array(
                    ':dealId'        => $aData->id,
                    ':dateChanged'   => $aData->update_time,
                    ':wonStage1'     => $setDbStage[0],
                    ':wonStage2'     => $setDbStage[1],
                    ':wonStage3'     => $setDbStage[2],
                    ':wonStage4'     => $setDbStage[3],
                    ':wonStage5'     => $setDbStage[4],
                    ':wonStage6'     => $setDbStage[5],
                    ':wonStage7'     => $setDbStage[6],
                    ':wonStage8'     => $setDbStage[7],
                    ':wonStage9'     => $setDbStage[8],
                    ':isWon'         => $isWon
            ));
        }else{
            //@mail("panya@rvglobalsoft.com","case : insert",$aData->id);
            $db->query("
                INSERT INTO pipedrive (
                    id,deal_id,pipe_line,date_created,date_changed,
                    won_stage_1,won_stage_2,won_stage_3,won_stage_4,won_stage_5,won_stage_6,won_stage_7,
                    won_stage_8,won_stage_9,order_type,is_won
                ) VALUES (
                    '',:dealId,:pipeLine,:dateCreated,:dateChanged,
                    :wonStage1,:wonStage2,:wonStage3,:wonStage4,:wonStage5,:wonStage6,:wonStage7,
                    :wonStage8,:wonStage9,:orderType,:isWon
                )
                ", array(
                        ':dealId'        => $aData->id,
                        ':pipeLine'      => $pipeline[$aData->pipeline_id],
                        ':dateCreated'   => $aData->add_time,
                        ':dateChanged'   => $aData->update_time,
                        ':wonStage1'     => $setDbStage[0],
                        ':wonStage2'     => $setDbStage[1],
                        ':wonStage3'     => $setDbStage[2],
                        ':wonStage4'     => $setDbStage[3],
                        ':wonStage5'     => $setDbStage[4],
                        ':wonStage6'     => $setDbStage[5],
                        ':wonStage7'     => $setDbStage[6],
                        ':wonStage8'     => $setDbStage[7],
                        ':wonStage9'     => $setDbStage[8],
                        ':orderType'     => $orderType,
                        ':isWon'         => $isWon
               ));
        }

    }
 
?>
