<?php

class findaccountmoderbill_controller extends HBController {

    public function _default($request) {
       if(isset($request['ivc'])){
           $data = $this->search($request['ivc']);
          
           $this->template->assign('data', $data);
           
       }
       
       $this->template->assign('url', $_SERVER['HTTP_ORIGIN']);
        
       $this->template->render(APPDIR_MODULES.'Other'.'/findaccountmoderbill/tempates/admin/default.tpl',$request,true);

    }
    
    private function search($invoiceID)
    {
        
        $db = hbm_db();
      
        $result = $db->query("
                                SELECT 
                                        ca.email as mail_hostbill,
                                        a.id as account_id,
                                        a.client_id as cid,
                                        l.invoice_id
                                FROM 
                                        mb_invoice_log l,
                                        mb_client_package_variables c, 
                                        rvsitebuilder_license sb,
                                        hb_accounts a,
                                        hb_client_access ca
                                WHERE 
                                        l.cp_id = c.cp_id
                                        AND c.cp_id =l.cp_id
                                        AND c.cpv_id = sb.cpv_id
                                        AND sb.hb_acc = a.id
                                        AND a.client_id = ca.id
                                        AND l.invoice_id = :invoiceid
                        ",array(':invoiceid' => $invoiceID))->fetchAll();
       return $result;  
    }
}
?>
    