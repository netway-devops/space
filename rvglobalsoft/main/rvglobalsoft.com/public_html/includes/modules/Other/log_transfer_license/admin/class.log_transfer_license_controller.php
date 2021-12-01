<?php

class log_transfer_license_controller extends HBController {
    
    public function _default($request) {
        $this->template->render(APPDIR_MODULES.'Other'.'/log_transfer_license/template/admin/default.tpl',$request,true);

    }
    
    public function searchLicence($request)
    {
        $list = $this->queryLogTranfer(trim($request['ip']));
        //echo '<pre>'.print_r($list,true),'</pre>';
        $this->template->assign('searchData',$list);
        $this->template->render(APPDIR_MODULES.'Other'.'/log_transfer_license/template/admin/default.tpl',$request,true);
        
    }
    
    
    private function queryLogTranfer($ip)
    {
        $db     = hbm_db();
     //   echo $ip;
        $result = $db->query("
                                SELECT 
                                       create_date,
                                       from_ip,
                                       to_ip,
                                       acc_id       
                                FROM   
                                       hb_transfer_log 
                                WHERE
                                       from_ip  = :ip
                                       OR to_ip = :ip       
                             ",array(':ip'=>$ip))->fetchAll();
                             
        return $result;     
    } 
    
}
?>