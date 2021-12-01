<?php

class getaccountexpirydatehandle_controller extends HBController {
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
        $this->getaccountexpirydate();
        return $message;
    }
    
    public function getaccountexpirydate()
    {
         $db         = hbm_db();

        require_once(APPDIR . 'class.general.custom.php');
        require_once(APPDIR . 'class.api.custom.php');
        require_once(APPDIR . 'class.config.custom.php');
        require_once(APPDIR . 'modules/Other/billingcycle/api/class.billingcycle_controller.php');
        
        $adminUrl   = GeneralCustom::singleton()->getAdminUrl();
        $apiCustom  = ApiCustom::singleton($adminUrl . '/api.php');
        
        /*หา accountid ล่าสุดที่ทำการอัพเดตวันหมดอายุ*/
        $nwAccountExpireIndex       = ConfigCustom::singleton()->getValue('nwAccountExpireIndex');
                        
        $maxId       = $db->query("  
                        SELECT MAX( id ) as maxId 
                        FROM hb_accounts
                        ")->fetch();
        
        if ($maxId['maxId'] < $nwAccountExpireIndex) {
            ConfigCustom::singleton()->setValue('nwAccountExpireIndex', 0);
            return false;
        }
                        
        $startAccountId = $nwAccountExpireIndex + 1;

        /*ทำการอัพเดตวันหมดอายุทีละ 100 account*/
        $count      = 100;
        
        for ($i = 0; $i < $count; $i++) {
            $accountId      = $startAccountId + $i;
            
            $result         = $db->query("
                        SELECT 
                            ha.next_due, ha.billingcycle
                        FROM 
                            hb_accounts ha
                        WHERE 
                            ha.id = :accountId
                        ",array(
                                ':accountId' => $accountId
                        ))->fetch();
            
            $nextDue        = $nextDue['next_due'];
            
            $post           = array(
                           'call'      => 'module',
                           'module'    => 'billingcycle',
                           'fn'        => 'getAccountExpiryDate',
                           'accountId' => $accountId,
                           'nextDue'   => $nextDue
                           );
                           
            //$result         = $apiCustom->request($post);
            $result         = billingcycle_controller::getAccountExpiryDate($post);
            $result         = isset($result[1]) ? $result[1] : array();
            if(! $result['expireTimeStamp']){
                continue;
            }
            
            $expireTimeStamp    = $result['expireTimeStamp'];
            $expireDate         = date('Y-m-d', $expireTimeStamp);
            
            /* --- บันทึกวันหมดอายุ --- */
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
            
            /* --- หาวันหมดอายุ due ล่าสด --- */
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
                    $expireDate        = self::_convertStrtotime($expire);
                }
            }
            else if (preg_match('/-\s*(\d{1,2}\/\d{1,2}\/\d{4})/', $result['description'], $matches)) {
                $expire         = isset($matches[1]) ? $matches[1] : '';
                if ($expire) {
                    $expireDate        = self::_convertStrtotime($expire);
                }
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
                                ':date'      => $expireDate
                        ));

        }
        
        ConfigCustom::singleton()->setValue('nwAccountExpireIndex', $accountId);
        
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


