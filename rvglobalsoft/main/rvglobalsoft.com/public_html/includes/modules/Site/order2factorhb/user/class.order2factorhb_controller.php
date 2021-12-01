<?php
require_once APPDIR . "class.general.custom.php";
class order2factorhb_controller extends HBController {
    
    function beforeCall($request) {
        $this->_beforeRender();
    }
    
    function _default($request) {
      
    }
    
    public static function &singleton($autoload=false) {
        static $instance;
        // If the instance is not there, create one
        if (!isset($instance) || $autoload) {
            $class = __CLASS__;
            $instance = new $class();
        }
        return $instance;
    }
    
    public function gotoStep3($request) {
       $this->template->render( dirname(dirname(__FILE__)).'/templates/gotostep3.tpl');
    }
    
    public function logined($client){
        if($client['status'] == 1){
             return true;
	}
        else {
             return false;
	}
    }
    
    
    public function checkLogIn($request){
        $client = hbm_logged_client();
        if($this->logined($client)){
             $this->checkOrder($client);
        }  
        else{ 
            $this->template->render( dirname(dirname(__FILE__)).'/templates/gotostep4.tpl');
		}
    }

    public function checkLogInPaidProduct($request){
        $client = hbm_logged_client();
        if($this->logined($client)){
             $this->checkOrderPaidProduct($request,$client);
        }  
        else {
            $this->template->render( dirname(dirname(__FILE__)).'/templates/gotostep3.tpl');
		}
    }
    
    
    
    public function gotoUpgrade($request){
        $this->template->render( dirname(dirname(__FILE__)).'/templates/gotoupgrade.tpl');
    }
    
    
    
    public function checkOrder($client){

        $db         = hbm_db();
        $oClient    = (object) $client;
        $clientID  = $oClient->id;
        $result    = $db->query("
                    SELECT 
                        status,product_id,id
                    FROM
                        hb_accounts
                    WHERE
                        client_id = :cid
                        AND product_id IN (58,59)
                    ORDER BY
                        date_created DESC
                    ",array(':cid' => $clientID))->fetch();
        if($result){
            $this->template->assign('status',$result['status']);
            $this->template->assign('accid',$result['id']);
            $this->template->render( dirname(dirname(__FILE__)).'/templates/gotolistservice.tpl');    
                   
        }
        else{
            $this->template->render( dirname(dirname(__FILE__)).'/templates/gotostep4.tpl');
            
        }
        
    }
    
    
    public function checkOrderPaidProduct($request,$client){
        $db         = hbm_db();
        $oClient    = (object) $client;
        $clientID  = $oClient->id;
        $result    = $db->query("
                    SELECT 
                        status,product_id,id
                    FROM
                        hb_accounts
                    WHERE
                        client_id = :cid
                        AND product_id IN (58,59)
                    ORDER BY
                        id DESC
                    ",array(':cid' => $clientID))->fetch();
        if($result){
            if($result['product_id'] == 58){
                $request['upgrades'] = 59;
                $request['cycle'][59] = $request['cycle'];
                $request['aid'] = $result['id'];
                $this->setCartUpgrade($request);
            }
            else if($result['status'] == 'Terminated'){
                $queryString = array('cycle' => $request['cycle'],
                                     'custom[-1]' => 'dummy',
                                     'custom[13][13]' => $request['qty'],
                                     'custom[109]'  => 110,
                                     'action' => 'addconfig',
                                     'tagproductname' => '2-factor Authentication for WHM');
                $this->template->assign('querystring',http_build_query($queryString));
                $this->template->render( dirname(dirname(__FILE__)).'/templates/gotoPaidProduct.tpl');
            }
            else{
                $this->template->assign('status',$result['status']);
                $this->template->assign('accid',$result['id']);
                $this->template->render( dirname(dirname(__FILE__)).'/templates/gotolistservice.tpl');    
            }     
        }
        else{
            $this->template->render( dirname(dirname(__FILE__)).'/templates/gotostep3.tpl');
            
        }
        
    }
    
    
    public function setCartUpgrade($request){
        
        $api = new ApiWrapper();
        $params = array(
          'id'=>$request['upgrades']
        );
        $return = $api->getProductDetails($params);
        //echo '<pre>'.print_r($request,true).'</pre>';
        //echo '<pre>'.print_r($return,true).'</pre>';
 
        $cycle = $request['cycle'][$request['upgrades']];
        $nextd;
        $nextacc;
        if($cycle == 'm'){
            $dayo   = date('d');
            $today  = date('Y-m-d');
         
            if($dayo>=1 && $dayo<=6){
                $nextM  = date('Y-m-07');
            }
            else{
                $nextM  = date('Y-m-07',strtotime($today.'+1 month'));
            }
            
            $difference = round(abs(strtotime($nextM)-strtotime($today))/86400);
            
            if($dayo<=20 && $dayo>7){
                $total = $difference*($return['product'][$cycle] / 30);
                $nextd = date('07/m/Y',strtotime($today.'+1 month'));   
                $nextacc = $nextM;
            }
            else if($dayo == 7){
                $total = $return['product'][$cycle];
                $nextd = date('07/m/Y',strtotime($today.'+1 month'));   
                $nextacc = $nextM;
            }
            else{
                if($dayo>=1 && $dayo<=6){
                    $total = ($difference*($return['product'][$cycle] / 30))+$return['product'][$cycle];  
                    $nextd = date('07/m/Y',strtotime($today.'+1 month'));
                    $nextacc = date('Y-m-07',strtotime($today.'+1 month'));
                }
                else{
                    $total = ($difference*($return['product'][$cycle] / 30))+$return['product'][$cycle];  
                    $nextd = date('07/m/Y',strtotime($today.'+2 month'));
                    $nextacc = date('Y-m-07',strtotime($today.'+2 month'));
                }    
                
            }
        }
        else{
            $dayo   = date('d');
            $dif    = abs($dayo - 7);
            $avgByDate   = $return['product'][$cycle]/365;
            if($dayo>=1 && $dayo<=6){
                $nextd       = date('07/m/Y');  
                $nextacc     = date('Y-m-07');
                $total       = $avgByDate*$dif;
            }
            else if($dayo == 7){
                $total = $return['product'][$cycle];
                $nextd       = date('07/m/Y',strtotime('+1 year'));  
                $nextacc     = date('Y-m-07',strtotime('+1 year'));  
            }
            else{
                $total = $return['product'][$cycle]-($dif*$avgByDate);
                $nextd       = date('07/m/Y',strtotime('+1 year'));  
                $nextacc     = date('Y-m-07',strtotime('+1 year')); 
            }
            
            $total = number_format($total, 2, '.', '');
        }
        
        
        $_SESSION['Upgrade']['product'] = array('account_id'=>$request['aid'],
                                          'product_id'=>58,
                                          'new_product_id' => 59,
                                          'category_id' => 2,
                                          'new_billing' => $cycle,
                                          'category_name' => 'RV2Factor',
                                          'product_name' => '2-factor Authentication for WHM (Free 1 account for 30 days)',
                                          'new_category_id' => 2,
                                          'new_category_name' => 'RV2Factor',
                                          'new_product_name' => '2-factor Authentication for WHM',
                                          'tax' => 1,
                                          'upgrade_name' => 'RV2Factor: 2-factor Authentication for WHM (Free 1 account for 30 days) -> 2-factor Authentication for WHM',
                                          'billingcycle' => 'Free',
                                          'new_value' => $return['product'][$cycle],
                                          'charge' => $total,
                                          'nextdue' => $nextd,
                                          'nextdueAcc' => $nextacc);
                                          
    
                                                                          
         $_SESSION['Upgrade']['config'] = array(13 => array('old_qty' => 0,
                                                            'new_config_id' => 13,
                                                            'old_config_id' => 0,
                                                            'new_qty' => $request['qty'],
                                                            'config_cat_name' => 'quantity',
                                                            'new_config_name' => '',
                                                            'charge' => ($request['qty'])*$total)
                                              );
                                              
         $_SESSION['UpgradeCustom'] = $_SESSION['Upgrade'];
         $url                = GeneralCustom::singleton()->getClientUrl();
         $this->Redirect($url.'upgrade/');
    }


    private function Redirect($url, $permanent = false)
    {
        header('Location: ' . $url, true, $permanent ? 301 : 302);
    
        exit();
    }
    
    
    public function addInvoice($request){
        $db                 = hbm_db();
        $url                = GeneralCustom::singleton()->getClientUrl();
        
        
        $client             = hbm_logged_client();
        
        if($this->logined($client) && isset($_SESSION['UpgradeCustom'])){
            $clientID           = $client['id'];
            $price              = $_SESSION['UpgradeCustom']['product']['charge'];
            $newValue           = $_SESSION['UpgradeCustom']['product']['new_value'];
            $qty                = $_SESSION['UpgradeCustom']['config'][13]['new_qty'];
            $nameProduct        = $_SESSION['UpgradeCustom']['product']['upgrade_name'];
            $nextDue            = $_SESSION['UpgradeCustom']['product']['nextdueAcc'];
            $status             = 'Unpaid';
            $modulePay          = $request['gateway'];
            $accID              = $_SESSION['UpgradeCustom']['product']['account_id'];
            $detail             = 'Upgrade:'.$nameProduct.' <br>';
            $detail            .= 'Add '.$qty.' account(s). Price is calculated from ';
            $detail            .= date('d/m/Y').' to '.$_SESSION['UpgradeCustom']['product']['nextdue'];
            $total              = $price*$qty;
            $reTotal            = $newValue*$qty;
        
            if(isset($client['credit'])){
                $credit         = $client['credit'];
            }
            else {
                $credit         = 0;             
            }
            
            if($_SESSION['Upgrade']['product']['new_billing'] == 'm'){
                $cycle = 'Monthly';    
            }
            else if($_SESSION['Upgrade']['product']['new_billing'] == 'a'){
                $cycle = 'Annually';
            }    
         
            if($total <= $credit){
                $status = 'Paid';    
                $credit = $total;
            }
            $resSend        = false;
            $resCreateINV   = $this->createInvoice($clientID);
            if($resCreateINV['success']){
                $invoiceId      = $resCreateINV['invoice_id'];
                $this->insertUpgrade($accID,$clientID,$invoiceId,'Pending',$total,$newValue,$cycle,$qty);
                $resAddInvItem  = $this->addInvoiceItem($invoiceId, $detail, $price, $qty,$accID);
                
                if($resAddInvItem){
                  
                    $resEditInvoice = $this->editInvoiceDetail($invoiceId, $modulePay,$credit);
         
                    if($resEditInvoice['success']){
                        $resSend = $this->setInvoiceStatusAndSendInvoice($invoiceId,$status);     
                    }
                           
                }
                    
            }
           
         
            if($resSend){
                if($credit > 0){
                    $this->cutCredit($clientID, $credit, $invoiceId); 
                }
             
                if($status == 'Paid'){
                   
                    $this->setUpgradePaid($accID,$reTotal,$cycle,$nextDue,$qty,$invoiceId);
                    
                }
                
      
                $this->Redirect($url.'clientarea/invoice/'.$invoiceId);   
            }
            else{               
                $this->template->render( dirname(dirname(__FILE__)).'/templates/showerror.tpl');    
            }
            
               
        }
        
        

    }

    public function setUpgradePaid($accid,$reTotal,$cycle,$nextDue,$qty,$invoiceID){
        $db         = hbm_db();
        $nextinv    = date('Y-m-d',strtotime($nextDue.'-7 days'));

        $db->query("
                    UPDATE hb_accounts 
                    SET
                          `product_id`='59',
                          `total`=:retotal,
                          `billingcycle`=:cycle,
                          `next_due`=:nextDue,
                          `next_invoice`=:nextinv,
                          `status`='Active',
                          `username`='',
                          `password`='',
                          `rootpassword`='',
                          `autosuspend`='0',
                          `autosuspend_date`='0000-00-00',
                          `date_changed`=NOW(),
                          `extra_details`='a:0:{}',
                          `manual`='0'
                    WHERE
                          id=:accid
                    ",array(
                            ':accid'      => $accid,
                            ':retotal'    => $reTotal,
                            ':nextDue'   => $nextDue,
                            ':cycle'      => $cycle,
                            ':nextinv'    => $nextinv));
         $all2factor =  $db->query("SELECT id,product_id
                                   FROM hb_accounts
                                   WHERE product_id != 59
                                         AND order_id IN (SELECT order_id
                                                          FROM hb_accounts
                                                          WHERE id = :accid)",array(':accid'=>$accid))->fetchAll();
         if(sizeof($all2factor)>0){
             foreach ($all2factor as $value) {
                $db->query("
                    UPDATE hb_accounts 
                    SET
                          `product_id`= :product_id,
                          `billingcycle`=:cycle,
                          `next_due`=:nextDue,
                          `next_invoice`=:nextinv,
                          `status`='Active',
                          `autosuspend`='0',
                          `autosuspend_date`='0000-00-00',
                          `date_changed`=NOW(),
                          `extra_details`='a:0:{}',
                          `manual`='0'
                    WHERE
                          id=:accid
                    ",array(':product_id' => $value['product_id'],
                            ':accid'      => $value['id'],
                            ':nextDue'   => $nextDue,
                            ':cycle'      => 'Monthly',
                            ':nextinv'    => $nextinv));       
             }
         }
                        
         $db->query("INSERT INTO 
                    hb_config2accounts(`rel_type`,`account_id`,`config_cat`,`config_id`,`qty`,`data`) VALUES
                    ('Hosting',:accid,'13','13',:qty,'1')
                    ",array(
                            ':accid'  => $accid,
                            ':qty'    => $qty
                            ));
                             
         $db->query("INSERT INTO 
                    hb_config2accounts(`rel_type`,`account_id`,`config_cat`,`config_id`,`qty`,`data`) VALUES
                    ('Hosting',:accid,'109','0','1','')
                    ",array(
                            ':accid'  => $accid
                            ));   
                                      
         $db->query(" 
                    UPDATE `hb_config_upgrades` 
                    SET status=:status
                    WHERE account_id = :id
                          AND order_id = :inv
                    ",array(':status' => 'Upgraded',
                            ':inv'  => '999'.$invoiceID,
                            ':id'   => $accid));  
         
        $db->query(" 
                    UPDATE `hb_upgrades` 
                    SET status=:status
                    WHERE account_id = :id
                          AND order_id = :inv
                          AND product_id = 59
                    ",array(':status' => 'Upgraded',
                            ':inv'  => '999'.$invoiceID,
                            ':id'   => $accid));                       
        
    }
    
    public function insertUpgrade($accid,$clientID,$invoiceID,$status,$total,$newvalue,$cycle,$qty){
         $db         = hbm_db();
      
         $db->query("
                     INSERT INTO hb_upgrades (`rel_type`,`account_id`,order_id,`client_id`,`product_id`,`status`,`total`,`new_value`,`new_billing`)
                     VALUES ('Hosting',:accid,:inv,:clientid,'59',:status,:total,:newvalue,:cycle)
                        ",array(':accid'      => $accid,
                                ':clientid'   => $clientID,
                                ':inv'        => '999'.$invoiceID,  
                                ':status'     => $status,
                                ':total'      => $total,
                                ':newvalue'   => $newvalue,
                                ':cycle'      => $cycle));
                            
        $db->query("
                     INSERT INTO hb_config_upgrades (`rel_type`,`account_id`,order_id,`config_cat`,`old_config_id`,`new_config_id`,`old_qty`,`new_qty`,`status`)
                     VALUES ('Hosting',:accid,:inv,'13','0','0','0',:qty,:status)
                        ",array(':accid'      => $accid,
                                ':inv'        => '999'.$invoiceID,  
                                ':qty'        => $qty,
                                ':status'     => $status));
           
        $db->query("
                     INSERT INTO hb_config_upgrades(`rel_type`,`account_id`,order_id,`config_cat`,`old_config_id`,`new_config_id`,`old_qty`,`new_qty`,`status`)
                     VALUES ('Hosting',:accid,:inv,'109','0','0','0','1',:status)
                        ",array(':accid'      => $accid,
                                ':inv'        => '999'.$invoiceID,  
                                ':status'     => $status));
                                
       
    }
    
    private function cutCredit($clientID,$creadit,$invID){
        if(isset($clientID) && isset($creadit) && isset($invID)){
            $db         = hbm_db();
            $db->query("
                        UPDATE hb_client_billing SET `credit`=`credit`- :credit WHERE `client_id`=:cid
                        ",array(':cid'      => $clientID,
                                ':credit'   => $creadit));
         
            $result    = $db->query("
                        SELECT credit FROM hb_client_billing WHERE client_id=:cid LIMIT 1
                        ",array(':cid' => $clientID))->fetch();
          
            $db->query("
                       INSERT INTO hb_client_credit_log 
                       (`date`, `client_id`, `in`, `out`, `balance`,`description`,transaction_id,`invoice_id`,`admin_id`,`admin_name`)
                        VALUES (NOW(),:cid,0,:credit,:balance,'Credit applied to invoice','0',:inv,'1','admin@rvglobalsoft.com')
                        ",array(':cid'      => $clientID,
                                ':credit'   => $creadit,
                                ':balance'  => $result['credit'],
                                ':inv'      => $invID));     
                                   
        }
                
    }
    
    private function createInvoice($clientID){
        $api = new ApiWrapper();
        $params = array(
            'client_id'=>$clientID
        );
        $return = $api->addInvoice($params);
        return $return;
    }
    
    private function addInvoiceItem($invoiceId,$detail,$price,$qty,$accid){
         $db         = hbm_db();

         $db->query("
                       INSERT INTO `hb_invoice_items`
                       (`invoice_id`,`type`,`item_id`,`description`,`amount`,`taxed`,`qty`,`unit_price`) 
                       VALUES (:id,'Other',:accid,:line,:amount,'1',:qty,:price)
                        ",array(':id'     => $invoiceId,
                                ':line'   => $detail,
                                ':price'  => $price*$qty,
                                ':qty'    => $qty,
                                ':accid'  => $accid,
                                ':amount' => $price));     
         
        
        return true;
    }

    private function editInvoiceDetail($invoiceId,$modulePay,$credit = null){
        $api = new ApiWrapper();
        $params = array(
            'id'=>$invoiceId,
            'date'=>date(),
            'payment_module'=>$modulePay
        );
        if($credit != null)
            $params['credit'] = $credit;
        $return = $api->editInvoiceDetails($params);
        return $return;
    }
    
    private function setInvoiceStatusAndSendInvoice($invoiceId,$status){
         $api = new ApiWrapper();
        $params = array(
            'id'=>$invoiceId,
            'status'=>$status
        );
        $return = $api->setInvoiceStatus($params);
        if($return['success']){
            $params = array(
                'id'=>$invoiceId
            );
            $return = $api->sendInvoice($params);
            if($return['success'])
                return true;
            else 
                return false;
        }
        else{
            return false;
        }
                 
    }
    
    private function addCredit($clientId,$amount){
        $api = new ApiWrapper();
       $params = array(
          'client_id'=>$clientId,
          'amount'=>$amount
       );
       $return = $api->addClientCredit($params);
       return $return;
    }
    
    function afterCall($request) {
      
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', MAINDIR . 'templates/');
    }
}