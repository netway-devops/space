<?php

class autoclose_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    public function call_EveryRun()  
    {
        $this->autoclose();
        $message    = 'Update wrike success.';
        return $message;
    }
    
    public function autoclose(){
            
        $db     = hbm_db();
 
        include_once MAINDIR . 'pipedriveToWrike/class.wrikeApiV3.php';
        require_once APPDIR . 'class.config.custom.php';
        
        $wrike          = new wrikeV3();
        $autoCloseTicketsId       = ConfigCustom::singleton()->getValue('autoCloseTicketsId');
        
        $maxId       = $db->query("  
                        SELECT MAX( ticket_id ) as maxId 
                        FROM tickets_to_wrike
                        ")->fetch();
        
        if ($maxId['maxId'] < $autoCloseTicketsId) {
            ConfigCustom::singleton()->setValue('autoCloseTicketsId', 4695);
            return false;
        }
        
        $startTicketId = $autoCloseTicketsId + 1;
        $count      = 25;
       
        for ($i = 0; $i < $count; $i++) {
            $ticketId      = $startTicketId + $i;
            
            $result        = $db->query("
                                        SELECT 
                                            tk.status , tkw.task_id , tk.dept_id , tk.subject
                                        FROM 
                                            hb_tickets tk ,
                                            tickets_to_wrike tkw                                            
                                        WHERE 
                                            tk.id = tkw.ticket_id
                                            AND tkw.ticket_id = :ticketId
                                        ",array(
                                                ':ticketId' => $ticketId
                                        ))->fetch();
                                  
            if($result['status'] != 'Closed'){
                continue;
            }else{
                
                $task           = $wrike->getTask($result['task_id']);
                $taskID         = $result['task_id'];
                $backlog        = $task['result']['data'][0]['dates']['type'];
                $status         = $task['result']['data'][0]['status'];
                $deleted        = $task['result']['data'][0]['scope'];
                
                if($deleted == 'RbTask' || $status == 'Completed'){
                    continue;
                }else{
                    if( $backlog == 'Backlog' && $status == 'Active'){  //เป็น backlog และ status เป็น active
                    
                        $title     = '(Closed) '.$result['subject'];
                        $status    = 'Completed'; //completed
                        $text      = "Ticket auto close.";
                        $wrike->addComment($taskID,$text);
                        $wrike->updateTask($taskID,$title,'',$status);
                   
                    }
                }
            }
        }
        ConfigCustom::singleton()->setValue('autoCloseTicketsId', $ticketId);
    }

}
