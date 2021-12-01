<?php

/*************************************************************
 *
 * Hosting Module Class - RvGlobalsoft Common
 * 
 * http://dev.hostbillapp.com/dev-kit/provisioning-modules/admin-area/
 * http://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * 
 * 
 ************************************************************/

class cc_modify_controller extends HBController {
    
    
    /**
     * 
     * Enter description here ...
     * @param $request
     */
    public function view($request) {

        
    }
    
    /**
     * 
     * Enter description here ...
     * @param $request
     */
    public function getcc($request) {
        $this->loader->component('template/apiresponse', 'json');
        $db = hbm_db();
            
        $cliendid = $request['id'];//$_SESSION['AppSettings']['login']['id'];
        $query = sprintf("   
                                SELECT
                                    c.cardholder,c.cardcvv
                                FROM 
                                    %s c
                                WHERE
                                    c.client_id='%s'                
                                "
                                , "hb_client_billing"
                                , $cliendid
                            );
                            
        $aRes = $db->query($query)->fetchAll();
        $cardholder = (isset($aRes[0]['cardholder']) && $aRes[0]['cardholder'] != '') ? $aRes[0]['cardholder'] : '-no data-';
        $cardcvv= (isset($aRes[0]['cardcvv']) && $aRes[0]['cardcvv'] != '') ? sprintf('%03s' , $aRes[0]['cardcvv']) : '-no data-';
        $data = array('cardholder' => $cardholder,'cardcvv'=>$cardcvv);
        $this->json->assign("aResponse", $data);
        $this->json->show();
   }
    

}