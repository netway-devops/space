<?php

class rvsitebuilderlicensehandle_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    
    /**
     * พี่กวงเปลี่ยนไม่บ่อย
     * @return string
     */
    public function call_EveryRun() 
    {
        $message        = '';
        
        $message        .= $this->_activateRVSitebuilderForCrediCardSubscribtion();
        
        return $message;
    }
    
    private function _activateRVSitebuilderForCrediCardSubscribtion ()
    {
        $message        = '';
        $db             = hbm_db();
        $api            = new ApiWrapper();
        
        $pastTime1      = date('Y-m-d H:i:s', strtotime('-1 hour'));
        $pastTime2      = date('Y-m-d H:i:s', strtotime('-10 minute'));
        
        # payment_module = 49  Credit Card (subscribe)
        $result         = $db->query("
            SELECT a.id
            FROM hb_accounts a
            WHERE ( a.date_created BETWEEN '{$pastTime1}' AND '{$pastTime2}' )
                AND a.status = 'Pending'
                AND a.payment_module = '49'
            LIMIT 1
            ")->fetchAll();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $aParam     = array(
                    'id'    => $arr['id']
                );
                $result2    = $api->accountCreate($aParam);
                $message    .= json_encode($result2);
            }
        }
        
        
        return $message;
    }
    
}


