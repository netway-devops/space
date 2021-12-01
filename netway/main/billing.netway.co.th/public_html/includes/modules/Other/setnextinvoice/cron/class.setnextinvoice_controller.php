<?php

class setnextinvoice_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    public function call_daily()
    {
        $message    = '';

        $today      = date('Y-m-d');
        $next12Day  = date('Y-m-d', strtotime('+30 days', strtotime($today)));
        $listclient = $this->getClientNextInvoiceToday($today);
        foreach($listclient as $client){
            //echo $client['client_id']."\n";
            if (! $this->_isMergeInvoice($client['client_id'])) {
                continue;
            }
            $this->setNextInvoiceInDomain($client['client_id'], $today, $next12Day);
            $this->setNextInvoiceInAccount($client['client_id'], $today, $next12Day);
            
        }
        
        return $message;
    }
    
    private function _isMergeInvoice ($clientId)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT a.*
            FROM hb_automation_settings a
            WHERE a.item_id = :clientId
                AND a.type = 'Client'
                AND a.setting = 'GenerateSeparateInvoices'
            ", array(
                ':clientId'     => $clientId
            ))->fetch();
        
        if (isset($result['value']) && $result['value'] == 'on') {
            return false;
        }
        
        return true;
    }
    
    private function getClientNextInvoiceToday($today){
        $db         = hbm_db();
        
        $listClientID = $db->query("SELECT uad.client_id
                                    FROM   (SELECT a.client_id as client_id
                                            FROM   hb_accounts a
                                            WHERE  a.status = 'Active'
                                                   AND a.next_invoice = :today
                                            UNION
                                            SELECT d.client_id as client_id
                                            FROM   hb_domains d
                                            WHERE  d.status = 'Active'
                                                   AND d.next_invoice = :today) uad  
                                    GROUP BY  uad.client_id",
                                    array(':today' => $today))->fetchAll();
                                    
        return  $listClientID;
    }
    
    
    private function setNextInvoiceInDomain($clientID,$today,$next12Day){
        $db         = hbm_db();
        
        $db->query("UPDATE hb_domains 
                    SET    next_invoice = :today
                    WHERE  client_id = :clientid
                           AND status = 'Active'
                           AND next_invoice > :today
                           AND next_invoice <= :next12day",
                   array(':clientid' => $clientID,
                         ':today'    => $today,
                         ':next12day'=> $next12Day));
       
 
    }
    
    
    private function setNextInvoiceInAccount ($clientID, $today, $next12Day)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT *
            FROM hb_accounts
            WHERE  client_id = :clientid
                   AND status = 'Active'
                   AND next_invoice > :today
                   AND next_invoice <= :next12day
            ", array(
                ':today'    => $today,
                ':clientid' => $clientID,
                ':next12day'=> $next12Day
            ))->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $accountId      = $arr['id'];
                $nextInvoice    = $arr['next_invoice'];
                
                $change = array(
                    'serialized'    => '',
                    'data'  => 'Change next invoice : '. $nextInvoice .' to '. $today
                );
                $change = serialize($change);
                
                $db->query("
                    INSERT INTO hb_account_logs (
                    `date`, account_id, admin_login, module, manual, action, result, `change`
                    ) VALUES (
                    NOW(), :account_id, 'setnextinvoice_controller', '-', 0, '', 1, :change
                    )
                    ", array(
                        ':account_id'   => $accountId,
                        ':change'       => $change,
                    ));
            }
        }
        
        $db->query("UPDATE hb_accounts 
                    SET    next_invoice = :today
                    WHERE  client_id = :clientid
                           AND status = 'Active'
                           AND next_invoice > :today
                           AND next_invoice <= :next12day",
                   array(':clientid' => $clientID,
                         ':today'    => $today,
                         ':next12day'=> $next12Day));
        
        $result     = $db->query("
                SELECT id
                FROM hb_accounts
                WHERE next_invoice = :today
                    AND client_id = :clientid
                    AND status = 'Active'
                ", array(
                    ':today'    => $today,
                    ':clientid' => $clientID,
                ))->fetchAll();
        
        if (! count($result)) {
            return;
        }
        
        $aId        = array();
        foreach ($result as $arr) {
            array_push($aId, $arr['id']);
        }
        
        $db->query("
            UPDATE hb_accounts_addons 
            SET next_invoice = :today
            WHERE account_id IN (". implode(',', $aId) .")
                AND status = 'Active'
                AND next_invoice > :today
                AND next_invoice <= :next12day
            ", array(
                ':today'        => $today,
                ':next12day'    => $next12Day
            ));
        
        
    }

    
}
