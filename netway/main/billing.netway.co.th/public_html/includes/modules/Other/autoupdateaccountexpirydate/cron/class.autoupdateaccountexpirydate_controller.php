<?php

class autoupdateaccountexpirydate_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * Sync Knowledgebase category
     * @return string
     */
    public function call_Hourly()  
    {
        $message    = '';
        $this->autoupdateaccountexpirydate();
        return $message;
    }
    
    public function autoupdateaccountexpirydate()
    {
            $db         = hbm_db();
            require_once(APPDIR . 'modules/Other/billingcycle/api/class.billingcycle_controller.php');
                        
            $result1 = $db->query("
                                SELECT id
                                FROM
                                    hb_accounts
                                WHERE
                                    DATE_FORMAT(next_due,'%Y-%m') <> DATE_FORMAT(next_expiry_date,'%Y-%m')
                                    AND DATE_FORMAT(next_due,'%Y-%m') > DATE_FORMAT(next_expiry_date,'%Y-%m')
                                    AND next_expiry_date <> '0000-00-00'
                                    AND status = 'Active' 
                                    AND billingcycle NOT IN ( 'Free',  'One Time' )
                                    AND DATEDIFF(next_due,next_expiry_date) > 3
                                ")->fetchAll();
            
            
            foreach($result1 as $accountId1){
               
                $accountId  = $accountId1['id'];
                
                if (empty($accountId)) {
                      echo '<!-- {"ERROR":["No accountId"]'
                            . ',"INFO":[]'
                            . ',"STACK":0} -->';
                      continue;
                }
                
                $result    = $db->query("
                            SELECT 
                                ha.next_due, ha.billingcycle, ha.expiry_date, ha.next_expiry_date
                            FROM 
                                hb_accounts ha
                            WHERE 
                                ha.id = :accountId
                            ",array(
                                ':accountId' => $accountId
                            ))->fetch();
                            
                $tempExpiryDate     = $result['expiry_date'];
                $tempNextExpiryDate = $result['next_expiry_date'];
                $nextDue            = $result['next_due'];
                
                $post = array(
                               'call'      => 'module',
                               'module'    => 'billingcycle',
                               'fn'        => 'getAccountExpiryDate',
                               'accountId' => $accountId,
                               'nextDue'   => $nextDue
                               );
               
                $result         = billingcycle_controller::getAccountExpiryDate($post);
                $result         = isset($result[1]) ? $result[1] : array();
                
                if(! $result['expireTimeStamp']){
                      echo '<!-- {"ERROR":["No expiry date"]'
                            . ',"INFO":[]'
                            . ',"STACK":0} -->';
                      continue;
                }
                
                $expireTimeStamp    = $result['expireTimeStamp'];
                $expireDate         = date('Y-m-d', $expireTimeStamp);
                $nextExpiryDate     = $expireDate;
                
                if($tempExpiryDate != $expireDate){
                    $isUpdate = true;
                }
                
                $db->query("
                          UPDATE 
                            hb_accounts
                          SET 
                            expiry_date = :date
                          WHERE 
                            id     = :accountId
                           ",array(
                                ':accountId' => $accountId,
                                ':date'      => $expireDate
                            ));
                           
                $result       = $db->query("
                                SELECT 
                                    ii.id, ii.type,ii.description
                                FROM 
                                    hb_invoice_items ii,
                                    hb_invoices i
                                WHERE 
                                    ii.type = 'Hosting'
                                    AND ii.item_id = :itemId
                                    AND ii.invoice_id = i.id
                                    AND i.status IN ('Paid', 'Unpaid')
                                ORDER BY i.duedate DESC, i.id DESC
                                ", array(
                                    ':itemId'   => $accountId
                                ))->fetch();  
    
                if (preg_match('/\-\s(\d{2}\s[a-zA-Z]{3}\s\d{4})/', $result['description'], $matches)) {
                    $expire         = isset($matches[1]) ? $matches[1] : '';
                    if ($expire) {
                        $nextExpiryDate     = self::_convertStrtotime($expire);
                    }
                }
                else if (preg_match('/-\s*(\d{1,2}\/\d{1,2}\/\d{4})/', $result['description'], $matches)) {
                    $expire         = isset($matches[1]) ? $matches[1] : '';
                    if ($expire) {
                        $nextExpiryDate     = self::_convertStrtotime($expire);
                    }
                }
                
                if($tempNextExpiryDate != $nextExpiryDate){
                    $isUpdate = true;
                } 
                
                $db->query("
                          UPDATE 
                            hb_accounts
                          SET 
                            next_expiry_date = :date
                          WHERE 
                            id     = :accountId
                           ",array(
                                    ':accountId' => $accountId,
                                    ':date'      => $nextExpiryDate
                            ));
              
              echo '<!-- {"ERROR":[]'
                    . ',"INFO":["'. ($isUpdate ? 'isupdate': 'notupdate') .'"]'
                    . ',"STACK":0} -->';
              
            }
    }
    
    private function _convertStrtotime ($str = '00/00/0000')
    {
        $aMonth     = array(
            'jan' => '1',
            'feb' => '2',
            'mar' => '3',
            'apr' => '4',
            'may' => '5',
            'jun' => '6',
            'jul' => '7',
            'aug' => '8',
            'sep' => '9',
            'oct' => '10',
            'nov' => '11',
            'dec' => '12',
        );

        if (preg_match('/(\d{2})\s([a-zA-Z]{3})\s(\d{4})/', $str, $matches)) {
            $d  = isset($matches[1]) ? $matches[1] : 00;
            $m  = ( isset($matches[2]) && isset($aMonth[strtolower($matches[2])]) ) ? $aMonth[strtolower($matches[2])] : 00;
            $y  = isset($matches[3]) ? $matches[3] : 0000;
            return strtotime($y .'-'. $m .'-'. $d);
        }
        
        $d  = substr($str,0,2);
        $m  = substr($str,3,2);
        $y  = substr($str,6);
        return strtotime($y .'-'. $m .'-'. $d);
    }
    
}


