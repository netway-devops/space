<?php

     
    include_once 'allkey.php';
    include_once 'ln_wrike_class.php';
    require('../includes/hostbill.php');
    
    
    if(isset($_GET['run'])){
        $wrike          = LN_WRIKE::singleton($secret,$api,$access_token,$access_token_secret);
        $username       = "pairote@netway.co.th";
        $password       = "ritik,g0Hf";
        
        $token          = authenPipe($username,$password);
        try{
        $url = "https://api.pipedrive.com/v1/deals?start=0&sort_mode=asc&api_token=".$token;
        $ch  = curl_init();
            
        curl_setopt($ch, CURLOPT_URL,$url);  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        
        $arrOutPut = json_decode(curl_exec ($ch));
        curl_close ($ch);
        
        $data = $arrOutPut->data;
        foreach ($data as $key) {
            $taskID = getTaskID($key->id);
            if($taskID==null){
                $taskID = addTaskWrike($wrike,$key,$token);
                if($key->activities_count != null && $key->activities_count > 0){
                    addAllCommentToTask($wrike,$key,$taskID,$token);
                }
            }
        }
        }catch(exception $e){
            echo $e->getMessage();
        }
    }
    
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
        //print_r($arrOutPut);
        $apitoken           = $arrOutPut->data[0]->api_token;
        
        return $apitoken;
            
    }
    
    function addTaskWrike($wrike,$arrData,$tokenPipe){
        $db             = hbm_db();
        
        $desc  = $arrData->title."<br>";
        $desc .= "person_name : ".$arrData->person_name."<br>";
        $desc .= "add_time : ".$arrData->add_time."<br>";
       
       if($arrData->status == 'won'){
            $status = 1;
            $title = "(Won)".$arrData->title;
        }
        else if($arrData->status == 'lost'){
            $status = 1;
            $title = "(Lost)".$arrData->title;
        }
        else {
            $status = 0;
            $title = "(".getStageName($arrData->stage_id,$tokenPipe).")".$arrData->title;
        }
        
        
        //$startDate      = $arrData->add_time."T00:00:00";
        //$dueDate        = $arrData->rotten_time."T00:00:00";
        
        
        if($arrData->pipeline_id == 1){
            $parent         = "23698389";
        }
        else if ($arrData->pipeline_id == 4)
            $parent         = "23819940";
        else if ($arrData->pipeline_id == 5)
            $parent         = "23819943";
        else if ($arrData->pipeline_id == 3)
            $parent         = "23819961";
        else if ($arrData->pipeline_id == 6)
            $parent         = "23819951";
        else if ($arrData->pipeline_id == 7)
            $parent         = "23819969";
        else if ($arrData->pipeline_id == 8)
            $parent         = "23820010";
        
         
        $task           = $wrike->addTask($title,$desc,$status,false,false,false,false,false,false,$parent,188854);
        $arrTask        = json_decode($task);
        $taskID         = $arrTask->task->id; 
       // @mail("sukit@rvglobalsoft.com","test",$task,"test");        
        
        $db->query("
                INSERT INTO `pipedrive_to_wrike`(`deal_id`, `task_id`) 
                VALUES (:dealid,:taskid)     
                ", array(
                    ':dealid'        => $arrData->id,
                    ':taskid'        => $taskID
                ));
       
        return $taskID;
        
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
    
    function getDealupdate($dealId,$token){
        
        $url = "https://api.pipedrive.com/v1/deals/".$dealId."/updates?start=0&api_token=".$token;
        $ch  = curl_init();
            
        curl_setopt($ch, CURLOPT_URL,$url);  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        
        $arrOutPut = json_decode(curl_exec ($ch));
        curl_close ($ch);
        
        
        return $arrOutPut;
    }
    function addAllCommentToTask($wrike,$deal,$taskID,$token){
        $arrOutPut = getDealupdate($deal->id, $token);
        
        foreach ($arrOutPut->data as $value) {
            
         
                if($value->item_type == "activity"){
                    if($value->story_data->action_type == "add"){
                        $text  = $value->story_data->user_name." added a ";
                        $text .= $value->story_data->activity_type." to deal ";
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                    }
                    else if($value->story_data->action_type == "edit"){
                        $text  = $value->story_data->user_name."  finished a ";
                        $text .= $value->story_data->activity_type;
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
                    }
                    else if($value->story_data->action_type == "delete"){
                        $text  = $value->story_data->user_name."  deleted a call";
                        $text .= "<br>Subject: ".$value->story_data->activity_subject;
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

?>
