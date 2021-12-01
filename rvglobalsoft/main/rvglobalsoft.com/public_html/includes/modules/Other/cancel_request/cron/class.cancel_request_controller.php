<?php
require_once APPDIR . "class.api.custom.php";
class cancel_request_controller extends HBController {
    /* 
     * Under $this->module HostBill will load your module
     * in this case it will be Example 
    */
    public $module;
    

    /**
     * 
     * @return string
     */
    public function call_Daily() 
    {
        $message = $this->terminateCancelRequest();
        $message .= "OK..................................OK";
        echo $message;
        return "ok\b";
    }
    
    
    private function terminateCancelRequest(){
         $today  =  date('Y-m-d');
         $list   =  $this->listExpireCancelRequest($today);
         
         $adminURL       = $this->getAdminURL();
         $url            = $adminURL.'api.php';
         //echo $url;
         $apiCustom = ApiCustom::singleton($url);
         $post = array(
           'call' => 'accountTerminate'
         );
         
         $message = 'Terminated  '.count($list)." accounts\n\n";
         foreach ($list as $key => $account) {
             $post['id'] = $account['id'];
             $result = $apiCustom->request($post);
             
             $message .=  json_encode($result)."\n";
         }
         
         $message .= "\n";
         return $message;
    }
    
    private function listExpireCancelRequest($today){
      
        $db = hbm_db();
        $result = $db->query("SELECT acc.id
                              FROM   
                                     hb_cancel_requests cr
                                     INNER JOIN hb_accounts acc 
                                     ON (cr.account_id = acc.id)
                              WHERE  
                                     cr.type = 'End of billing period'
                                     AND acc.next_due <= :today
                                     AND acc.status = 'Active'
                             ",array(':today' => $today))->fetchAll();
                             
        return $result;    
    }
    
    private function getAdminURL(){
        if (isset($_SERVER['HTTP_HOST'])) {
            $adminUrl   = (isset($_SERVER['HTTPS']) ? 'https://' : 'http://') . $_SERVER['HTTP_HOST']
                    . (preg_match('/^192\.168\.1|localhost/', $_SERVER['HTTP_HOST']) 
                        ? '/demo/rvglobalsoft.com/public_html/7944web/'
                        : '/7944web/');
        } else {
            $adminUrl = 'https://rvglobalsoft.com/7944web/';
        }   
        
        return $adminUrl;
    }
    
      
}
