<?php
class rvlogin_license_controller extends HBController 
{
    protected $moduleName = 'rvproduct_license';
    public $module;
    public function view($request) 
    {
    
    }
    
    public function verifyRVLoginIP($request){
        $db = hbm_db();    
        if(isset($request['ip'])){
            $ip = trim($request['ip']);
        
            if(filter_var($ip, FILTER_VALIDATE_IP)){
                $getIP  = $db->query("
                        SELECT 
                            license_id,hb_acc
                        FROM 
                            rvlogin_license
                        WHERE
                            primary_ip=:ip
                            OR secondary_ip  =:ip
                        ", array(
                        ':ip' => $ip
                        ))->fetch();
                if ($getIP) {
                  
                    $aRes['response']    = false;
                    $aRes['msg']    = 'License RVLogin IP:' . $ip . ' already exists in the system<br>';
                  
                } else { 
                    $aRes['response'] = true;
                } 
                
    
            }
            else{
                 $aRes['response']    = false;
                 $aRes['msg']    = 'Field "IP Address" format invalid<br>';
                
            }
            
            $this->loader->component('template/apiresponse', 'json');
            $this->json->assign("aResponse", $aRes);
            $this->json->show();    
        }
    }
}    
?>
    