<?php
#@LICENSE@#
class rvsitebuilder_license_trial_controller extends HBController 
{
    protected $moduleName = 'rvsitebuilder_license_trial';
    //public $conn;
    public function view($request) 
    {
        
    }
    
    public function accountdetails($params)
    {
      if(isset($params['save'])) {
         if(sizeof($params['custom'])>0)
            $this->ChangeCustom($params);
      }
        
    }
    public function ChangeCustom($params)
    {
         $accid = $params['account']['id'];
         $db = hbm_db();
         foreach ($params['custom'] as $key => $value) {
             $result = $db->query('
                                    SELECT variable 
                                    FROM `hb_config_items_cat` 
                                    WHERE `id` = :catid
                                ', array(':catid' => $key))->fetch();
             foreach ($value as $input) {
                 $val = $input;
             }
             
             if($result['variable'] == 'ip'){
                 try{    
                     $db->query('
                                UPDATE `rvsitebuilder_license_trial` 
                                SET main_ip = :ip,second_ip = :ip
                                WHERE hb_acc_id = :accid
                                ', array(':ip' => $val,
                                         ':accid' => $accid));
                
                }catch(exception $e){
                   echo "ip is unavailable";
                   exit(0);
                }                  
             } 
             else if($result['variable'] == 'expiration_date'){
                 
                 $aDate = $this->calExpireDate($val);
             
                 $db->query('
                            UPDATE `rvsitebuilder_license_trial` 
                            SET exprie = :expdate,effective_expiry = :effdate
                            WHERE hb_acc_id = :accid
                            ', array(':expdate' => $aDate['exp'],
                                     ':effdate' => $aDate['eff'],
                                     ':accid' => $accid));
             }  
                              
         }
        return true;
    } 
    private function calExpireDate($next_due_date = '') {
        date_default_timezone_set('UTC');
        if ($next_due_date == '0000-00-00')  $next_due_date = '2030-01-07';
        $aDate['exp'] = strtotime($next_due_date);
        $aDate['eff'] = mktime(
                                date('H', $aDate['exp'])+23,
                                date('i', $aDate['exp']),
                                date('s', $aDate['exp']),
                                date('n', $aDate['exp']),
                                date('j', $aDate['exp'])+3,
                                date('Y', $aDate['exp'])
                            );
        return $aDate;
    }
}

