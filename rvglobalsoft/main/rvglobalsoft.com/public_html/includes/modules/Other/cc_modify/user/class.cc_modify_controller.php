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
            
        $cliendid = $_SESSION['AppSettings']['login']['id'];
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

    public function getPaidInv($request) 
    {
        $db = hbm_db();
            
        $cliendid = $_SESSION['AppSettings']['login']['id'];
        $inv_id = $request['inv'];
       	$query = sprintf("   
        		DELETE FROM 
        			%s
				WHERE 
					invoice_id='%s'
					AND status in ('Pending','Cancelled') 
				"
                , "hb_manual_payment"
                , $inv_id
            );
           // echo'=====>'. $query;  exit;              
        $aRes = $db->query($query);
        return $aRes;
   }
	
   public function updatecc($request) {
       $this->loader->component('template/apiresponse', 'json');

           $db = hbm_db();
          
           $cliendid = $_SESSION['AppSettings']['login']['id'];
           if (isset($request['cardholder'])) { 
                $query = sprintf("
                        UPDATE 
                            %s
                        SET
                            cardholder='%s',
                            cardcvv='%s'
                        WHERE
                            client_id='%s'
                        "
                        , "hb_client_billing"
                        , $request['cardholder']
                        , $request['cardcvv']
                        , $cliendid
                        );
           } else {
                $query = sprintf("
                        UPDATE 
                            %s
                        SET
                            cardcvv='%s'
                        WHERE
                            client_id='%s'
                        "
                        , "hb_client_billing"
                        , $request['cardcvv']
                        , $cliendid
                        );
            }
            $db->query($query);

        /* --- ตรวจสอบว่ามี invoice ที่เป็น manualcc ค้างอยู่ให้แจ้งเจ้าหน้าที่ว่ามีการแก้ไข credit card --- */
        $invoiceId      = isset($request['inv']) ? $request['inv'] : 0;
        
        //[XXX ขอรับทุกอีเมล์] if (! $invoiceId) {
            self::_notifyStaffCreditcardUpdated();
        //}
        
        $aDel = $this->getPaidInv($request);
        $data = array('cardholder' => $cardholder);
        $this->json->assign("aResponse", $data);
        $this->json->show();
   }
   
   /**
    * ส่ง email หา staff เมื่อ client update cc
    */
   private function _notifyStaffCreditcardUpdated ()
   {
        $db         = hbm_db();
        
        $client     = hbm_logged_client();
        $oClient    = (object) $client;
        
        $currentDate    = date('Y-m-d', time());
        
        $result     = $db->query("
                SELECT 
                    m.id, i.id AS invoice_id, 
                    i.status, i.date, i.duedate, i.total, 
                    d.id AS client_id, d.firstname, d.lastname, 
                    m.status AS state
                FROM 
                    hb_client_details d
                    RIGHT JOIN 
                        hb_invoices i ON d.id = i.client_id
                    RIGHT JOIN 
                        hb_manual_payment m ON i.id = m.invoice_id
                WHERE
                    d.id = :clientId
                    AND i.status = 'Unpaid'
                    AND i.duedate < :currentDate 
                ", array(
                    ':clientId'         => $oClient->id,
                    ':currentDate'      => $currentDate
                ))->fetch();
        
        if (! isset($result['id'])) {
            return false;
        }
        
        return true;
        
        $aData          = $result;
        
        require_once(APPDIR_LIBS . 'mail/class.phpmailer.php');
        
        $mail           = new PHPMailer;
        
        $mail->From         = $oClient->email;
        $mail->FromName     = $oClient->firstname . ' '. $oClient->lastname;
        $mail->addReplyTo($oClient->email, $oClient->firstname . ' '. $oClient->lastname);
        
        $mail->addAddress('paisarn@netway.co.th');  // Add a recipient
        $mail->addAddress('metinee@netway.co.th');  // Add a recipient
        $mail->addAddress('prasit@netway.co.th');  // Add a recipient
        
        $mail->WordWrap = 70;                                 // Set word wrap to 50 characters
        
        $message            = '
            ==============================
            ';
        foreach ($aData as $k => $v) {
        $message           .= '
            '. $k .'        : '. $v .'
            ';
        }
        $message           .= '
            ==============================
            ';
            
        $mail->Subject      = 'Client#' . $oClient->id . ' has been change credit card information';
        $mail->Body         = 'รายละเอียด  ' . $message;
    
        $mail->send();
        
        return true;
   }
   

}