<?php

class hostpartnerhandle_controller extends HBController {

    private static  $instance;
    
    public static function singleton ()
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c();
        }
        
        return self::$instance;
    }
    
    public function __clone ()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    
    public function beforeCall ($request)
    {
        $aNotification  = isset($_SESSION['notification']) ? $_SESSION['notification'] : array();
        $this->template->assign('aNotification', $aNotification);
        
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
    
    public function _default ($request)
    {
        $db             = hbm_db();
    }
    
    public function dataCompany ()
    {
        $db         = hbm_db();
        $clientId   = $_GET['id'];
        
        if(isset($clientId)){
        $result     = $db->query("
                SELECT hp.*,ca.email ,cd.firstname,cd.lastname
                FROM hb_client_details cd 
                LEFT JOIN hb_client_access ca 
                    ON ca.id = cd.id 
                LEFT JOIN hb_hosting_partner hp 
                    ON hp.client_id = cd.id 
                WHERE hp.client_id = :clientId
                
                ",array(
                ':clientId' => $clientId
                ))->fetch();
        }
        
        if (isset($result)) {
            $this->template->assign('data', $result);
        }
        
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl', array(), true);
    }
    
    
    public function ApproveCompany ($request)
    {
        $db         = hbm_db();
        $clientID     = isset($request['clientID'])?$request['clientID']:0;
         
        if($clientID!= 0){
        $dataPartner = $db->query("
                    SELECT * 
                    FROM hb_hosting_partner
                    WHERE client_id = {$clientID}
                    AND status = 0
                    AND  status_edit_company = 0
                   ")->fetch(); 
        
            if(isset($dataPartner['id'])){
                $result  = $db->query("
                     UPDATE hb_hosting_partner 
                     SET  status = 1  ,
                     status_edit_company = 1   
                     WHERE id = {$dataPartner['id']}
                     AND client_id = {$dataPartner['client_id']}
                    ");
            } 
            
        }
        
        $hostingPartner = $db->query("
                    SELECT * 
                    FROM hb_hosting_partner
                    WHERE client_id = {$clientID}
                    AND status = 1
                    AND status_edit_company = 1
                   ")->fetch(); 
        
            if(isset($hostingPartner)){
                $UpdateClientDetail= $db->query("
                         UPDATE hb_client_details 
                         SET  companyname = '{$hostingPartner['company_name']}',
                              company = 1
                         WHERE id = {$hostingPartner['client_id']}
                        ");
            }
        
      
        $dataClientDetail = $db->query("
                     SELECT cd.* ,hp.*
                     FROM hb_client_details cd
                     LEFT JOIN  hb_hosting_partner hp
                        ON  cd.id = hp.client_id
                     WHERE cd.id = {$clientID}
                         AND cd.company = 1
                         AND cd.companyname != ''
                         AND hp.status = 1
                   ")->fetch(); 
                   
        if (isset($dataClientDetail)) {
            
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl', array(), true);
        }
    }




    public function dataEditCompany ()
    {
        $db         = hbm_db();
        $clientId   = $_GET['id'];
        
        if(isset($clientId)){
        $result     = $db->query("
                SELECT hp.*,ca.email ,cd.firstname,cd.lastname
                FROM hb_client_details cd 
                LEFT JOIN hb_client_access ca 
                    ON ca.id = cd.id 
                LEFT JOIN hb_hosting_partner hp 
                    ON hp.client_id = cd.id 
                WHERE hp.client_id = :clientId
                ",array(
                ':clientId' => $clientId
                ))->fetch();
        }
        if (isset($result)) {
            $this->template->assign('EditCompany', $result);
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl', array(), true);
       
        }
        
       
    }
    
    public function EditCompany ($request)
    {
        $db         = hbm_db();
        $clientID     = isset($request['clientID'])?$request['clientID']:0;
         
        if($clientID != 0){
        $dataPartner = $db->query("
                    SELECT * 
                    FROM hb_hosting_partner
                    WHERE client_id = {$clientID}
                    AND status = 1
                    AND  status_edit_company = 0
                   ")->fetch(); 
        
            if(isset($dataPartner['client_id'])){
                $result  = $db->query("
                     UPDATE hb_hosting_partner 
                     SET status_edit_company = 1   
                     WHERE id = {$dataPartner['id']}
                     AND client_id = {$dataPartner['client_id']}
                    ");
            } 
            
        }
        
        $hostingPartner = $db->query("
                    SELECT * 
                    FROM hb_hosting_partner
                    WHERE client_id = {$clientID}
                    AND status = 1
                    AND status_edit_company = 1
                   ")->fetch(); 
                   
           if(isset($hostingPartner)){
                $UpdateClientDetail= $db->query("
                     UPDATE hb_client_details 
                     SET  companyname = '{$hostingPartner['company_name']}'     
                     WHERE id = {$hostingPartner['client_id']}
                    ");
            }     
 
        if (isset($hostingPartner)) {
            
            $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl', array(), true);
        }
    }
    
    
    
    
    
    
    public function afterCall ($request)
    {
        $aAdmin         = hbm_logged_admin();
        $this->template->assign('oAdmin', (object)$aAdmin);
        
        $_SESSION['notification']   = array();
    }
}
