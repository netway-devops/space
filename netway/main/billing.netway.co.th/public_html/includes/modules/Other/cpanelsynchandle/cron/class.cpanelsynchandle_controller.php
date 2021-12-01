<?php

class cpanelsynchandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function call_Hourly()  
    {
        $message    = '';
        $this->cpanelsynOwner();
        return $message;
    }
    
    public function cpanelsynOwner(){
            
       $db      = hbm_db();
       
       require_once APPDIR . 'class.config.custom.php';
       
       $synserverId       = ConfigCustom::singleton()->getValue('synserverid');
       
       
       $maxId       = $db->query("  
                        SELECT MAX( s.id ) as maxId 
                        FROM 
                            hb_server_groups sg , hb_servers s
                        WHERE
                            sg.id = s.group_id
                            AND sg.module = 8
                        ")->fetch();
                             
       if ($maxId['maxId'] < $synserverId) {
            ConfigCustom::singleton()->setValue('synserverid', 0);
            return false;
        }
              
       $startsynserverid = $synserverId + 1;
       $server = $db->query("
                              SELECT
                                s.id , s.ip , s.username , s.hash
                              FROM 
                                hb_server_groups sg , hb_servers s
                              WHERE
                                sg.id = s.group_id
                                AND sg.module = 8
                                AND s.id = {$startsynserverid}
                             ")->fetch();
                             
       if(empty($server['hash'])){
           ConfigCustom::singleton()->setValue('synserverid', $startsynserverid);
           return false;
       }     
       
            $serverId =  $server['id'];
            # The contents of /root/.accesshash
            $whmhash = $server['hash'];
            $whmusername = $server['username'];
              
            $query = "https://". $server['ip'] .":2087/json-api/listaccts?api.version=1";
  
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST,0);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER,0);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER,1);
              
            $header[0] = "Authorization: WHM $whmusername:" . preg_replace("'(\r|\n)'","",$whmhash);
            curl_setopt($curl,CURLOPT_HTTPHEADER,$header);
            curl_setopt($curl, CURLOPT_URL, $query);
              
            $datas = curl_exec($curl);
            if ($datas == false) {
                error_log("curl_exec threw error \"" . curl_error($curl) . "\" for $query");
            }
            curl_close($curl);
              
            $aData = json_decode($datas);

            foreach($aData as $data){
               foreach($data->acct as $user){

                   $db->query("
                              UPDATE 
                                hb_accounts
                              SET 
                                owner = :owner
                              WHERE 
                                domain = :domain               
                              ", array(
                                ':owner'       => $user->owner ,
                                ':domain'        => $user->domain 
                              ));
                              
                    $result = $db->query("
                              SELECT
                                count(*) as num
                              FROM 
                                hb_cpanel_account_lists 
                              WHERE
                                user = :user
                             ",array(
                                    ':user' => $user->user
                             ))->fetch();

                    if($result['num'] != 0){
                                
                        $db->query("
                              UPDATE 
                                hb_cpanel_account_lists
                              SET 
                                update_date = NOW() , server_id = :serverId , owner = :owner
                              WHERE 
                                user = :user               
                              ", array(
                                ':owner'       => $user->owner ,
                                ':user'        => $user->user ,
                                ':serverId'    => $serverId 
                              ));    
                        
                    }else{
                                             
                        $db->query("
                              INSERT INTO 
                                hb_cpanel_account_lists (create_date,update_date,server_id,user,owner)
                              VALUE (NOW(),NOW(),:serverId,:user,:owner)               
                              ", array(
                                ':owner'       => $user->owner ,
                                ':user'        => $user->user ,
                                ':serverId'    => $serverId
                              ));
                    }
               }
            }
            ConfigCustom::singleton()->setValue('synserverid', $startsynserverid);
        }
}
