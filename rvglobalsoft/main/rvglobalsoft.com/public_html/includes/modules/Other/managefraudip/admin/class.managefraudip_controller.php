<?php

class managefraudip_controller extends HBController {
        
        
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
       
        $data = $this->listAllFraudIp();
        $this->template->assign('data',$data);
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    private function listAllFraudIp(){
        $db     = hbm_db();
        $result = $db->query("SELECT * FROM fraud_server_ip")->fetchAll();
        return $result;
    }
    
    public function addFraudIp($request){
        $db     = hbm_db();
        $admin  = hbm_logged_admin();
        $db->query("INSERT INTO `fraud_server_ip`( `ip`, `note`, `who`) VALUES (:ip,:note,:who)",
                    array(':ip' => $request['ip'],
                          ':note' => $request['note'],
                          ':who'  => $admin['username']));
        hbm_redirect('&cmd=managefraudip');
        
    
        exit();
    }
    public function deleteFraudIp($request){
         $db     = hbm_db();
        $admin  = hbm_logged_admin();
        $db->query("DELETE FROM `fraud_server_ip` WHERE id = :id",
                    array(':id' => $request['id']));
        hbm_redirect('&cmd=managefraudip');
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) 
            . '/templates/');
    }

    public function afterCall ($request)
    {
        
    }
        
}

?>
    