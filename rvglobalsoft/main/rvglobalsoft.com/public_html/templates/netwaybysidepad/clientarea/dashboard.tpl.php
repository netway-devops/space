<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aOpenedtickets     = $this->get_template_vars('openedtickets');
// --- Get template variable ---

require_once(APPDIR . 'modules/Site/zendeskhandle/user/class.zendeskhandle_controller.php');


$dueinvoices = $this->get_template_vars('dueinvoices');
if($dueinvoices){
    $this->_tpl_vars['acc_balance'] = 0;
    foreach ($this->_tpl_vars['dueinvoices'] as $invoice=>$foo){
        $this->_tpl_vars['acc_balance'] +=$foo['total'];
    }

    for($i = 0;$i<sizeof($this->_tpl_vars['dueinvoices']);$i++) {
        $invoiceID = $this->_tpl_vars['dueinvoices'][$i]['id'];
        $result = $db->query("
                                SELECT
                                        mc.modname as paymentmd
                                FROM
                                        hb_invoices i
                                        INNER JOIN hb_modules_configuration mc
                                        ON (i.payment_module = mc.id )
                                WHERE
                                        i.id = :invoiceid
                        ",array(':invoiceid' => $invoiceID))->fetch();
      $this->_tpl_vars['dueinvoices'][$i]['paymentmethod'] = $result['paymentmd'];
    }
}

$clientId = $this->_tpl_vars['clientdata']['id'];
$accountList = $api->getClientAccounts(array('id' => $clientId));
$domain = '';
$count = 0;

if($accountList['success']){
    foreach($accountList['accounts'] as $v){
        $accountDetail = $db->query("SELECT order_id, next_due, domain FROM hb_accounts WHERE id = {$v['id']}")->fetch();
//          $accountDetail = $api->getAccountDetails(array('id' => $v['id']));
        if($accountDetail){
            $orderId = $accountDetail['order_id'];
            $isSSL = $db->query("SELECT order_id FROM hb_ssl_order WHERE order_id = '{$orderId}' AND authority_orderid != '' AND symantec_status = 'COMPLETED'")->fetch();
            if(isset($isSSL['order_id']) && $isSSL['order_id'] != '' && strtotime($accountDetail['next_due'])-(60*60*24*90) < strtotime('now')){
                if($domain == ''){
                    $domain = $accountDetail['domain'];
                    $expDate = date('d M Y', strtotime($accountDetail['next_due']));
                }
                $count++;
            }
        }
       $accountProduct = $db->query("
                    SELECT a.client_id,a.status,p.*,ca.email,cd.country
                    FROM hb_accounts a 
                    LEFT JOIN hb_products p 
                    ON a.product_id= p.id 
                    LEFT JOIN hb_client_access ca 
                       ON a.client_id = ca.id 
                    LEFT JOIN hb_client_details cd
                       ON cd.id = ca.id 
                    WHERE cd.id = {$clientId}
                    AND a.status != 'Terminated'
                    AND p.id = {$v['product_id']} 
                    AND p.category_id = '6' 
                    AND p.id IN (66,67,99,100,157,155,158)
                ")->fetch();
    }

}
$this->assign('accountProduct', $accountProduct);


if($domain != ''){
    $systemUrl = $this->get_template_vars('system_url');
    $caUrl = $this->get_template_vars('ca_url');
    $alertTxt = "SSL Certificate for domain \"{$domain}\" ";
    if($count > 1){
        $alertTxt .= "<a href=\"{$systemUrl}{$caUrl}clientarea/services/ssl/\">and more</a> ";
    }
    $alertTxt .= "will be expired soon ({$expDate}).";
    $alertTxt .= "<br><br>";
    $alertTxt .= "You can renew the SSL Certificate from today onward, the expiration date will be continued from the expiration date in the Certificate not the renewal date.";
    $this->_tpl_vars['sslalerttext'] = $alertTxt;

}

$info = $this->get_template_vars('info');
$ga_mode = $this->_tpl_vars['ga_mode'];
if($ga_mode != '' && $info[0] == 'Thank you. Your cancellation request has been submitted. If you have done this by mistake please open a support ticket to notify us immediately, otherwise your account may be terminated.'){
    $this->_tpl_vars['cancel'] = true;
}

$annoucements = $db->query("SELECT * FROM hb_annoucements ORDER BY date DESC")->fetchAll();
$this->_tpl_vars['annoucements'] = $annoucements;

$result     = zendeskhandle_controller::singleton()->searchTicket(array());
foreach ($aOpenedtickets as $arr) {
    $ticketId   = $arr['id'];
    unset($result[$ticketId]);
}
$this->assign('openedtickets2', $result);
//echo '<pre>'. print_r($result, true) .'</pre>';  

require_once(APPDIR . 'modules/Site/hostpartnerhandle/user/class.hostpartnerhandle_controller.php');
require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');


//-------------Add Company----------------------

    $checkingPartner = $db->query("
                        SELECT *
                        FROM hb_hosting_partner
                        WHERE client_id = $clientId
                   
                    ")->fetch();  

    if(isset($_POST['submit']) && $_POST['submit'] == 'Submit'&& empty($checkingPartner['client_id']))
    {
        $companyClientId = $clientId;  
        $country         = $_POST['country'];
        $companyName     = $_POST['companyName']; 
        $webUrl          = $_POST['weburl']; 
        $title           = $_POST['title']; 
        $fileLogo        = $_FILES['logoupload']['name'];
        $fileSize        = $_FILES['logoupload']['size'];
        $fileTmpName     = $_FILES['logoupload']['tmp_name'];
        $fileType        = $_FILES['logoupload']['type'];
        $exploded        = explode('.',$fileLogo);
        $fileExtension   = strtolower(end($exploded));
        $templatePath    = $this->get_template_vars('template_path');
        $uploadDirectory = $templatePath.'images/';
        $errors = '';   
        $fileExtensions = array('jpeg','jpg','png','gif'); 
        $uploadPath     =  $uploadDirectory . basename($fileLogo);   
            if (! in_array($fileExtension,$fileExtensions)) {
                    $errors = "This file extension is not allowed. Please upload a JPEG or PNG file";
            }
            if ($eFileSize > 150000   ) {
                $errors = "This file is more than 150KB. Sorry, it has to be less than or equal to 150KB";
            }
            if (empty($errors)) {
                $didUpload = move_uploaded_file($fileTmpName, $uploadPath);
                if ($didUpload) {
                    $didUpload = "The file " . basename($fileName) . " has been uploaded";
                }else {
                    echo "An error occurred somewhere. Try again or contact the admin";
                }
            }else{
                foreach ($errors as $error){
                    echo $error . "These are the errors" . "\n";
                }
            }
            
          $aParam     = array(
             'clientId'     => $companyClientId,
             'companyName'  => $companyName,
             'country'      => $country,
             'logoupload'   => $fileLogo,
             'webUrl'       => $webUrl,
             'title'        => $title    
           );
           
         $companyData = hostpartnerhandle_controller::singleton()->AddCompany($aParam);
         
         $_SESSION['isAddCompany'] = 0; 
         
        if(isset($companyData['client_id']) && $companyData['client_id'] != 0){
      
       
             $value         = array(
                 'clientId'     => $companyData['client_id'],
                 'email'        => $accountProduct['email'],
                 'companyName'  => $companyData['company_name'],
                 'webUrl'       => $companyData['web_url'],
                 'title'        => $companyData['title']       
            );
    
             $ticketCompany    = zendeskintegratehandle_controller::singleton()->createTicketAddCompany($value);
            if(isset($ticketCompany)){
                 $_SESSION['isAddCompany'] = 1; 
                $this->assign('ticketCompany',$ticketCompany); 
            }
            
            
        }
             if($_SESSION['isAddCompany'] == 1 ){
                 $_SESSION['isAddCompany'] = 0;
                  echo "<script>
                      alert('Your information has been submitted to our team to review it.');
                      window.location.assign('https://rvglobalsoft.com/clientarea');
                  </script>";  
                
             }
    
    }else{
        $this->assign('checkingPartner',$checkingPartner);  
    }
    
    
     if(isset($_POST['save']) && $_POST['save'] == 'Save' && $checkingPartner['status_edit_company']== 1)
    {
        
        $eCompanyClientId = $clientId;  
        $eCompanyName     = $_POST['editcompanyName']; 
        $eWebUrl          = $_POST['editWeburl']; 
        $eTitle           = $_POST['editTitle']; 
        $eFileLogo        = $_FILES['Editlogoupload']['name'];
        $eFileSize        = $_FILES['Editlogoupload']['size'];
        $eFileTmpName     = $_FILES['Editlogoupload']['tmp_name'];
        $eFileType        = $_FILES['Editlogoupload']['type'];
        if($eFileLogo == '' || empty($eFileLogo)){
            $eFileLogo =$checkingPartner['logo'];
        }
        $exploded        = explode('.',$eFileLogo);
        $eFileExtension   = strtolower(end($exploded));
        $templatePath    = $this->get_template_vars('template_path');
        $uploadDirectory = $templatePath.'images/';
        $errors = '';   
        $eFileExtensions = array('jpeg','jpg','png'); 
        $uploadPath     =  $uploadDirectory . basename($eFileLogo);   
            if (! in_array($eFileExtension,$eFileExtensions)) {
                    $errors = "This file extension is not allowed. Please upload a JPEG or PNG file";
            }
            if ($eFileSize > 150000 ) {
                $errors = "This file is more than 150KB. Sorry, it has to be less than or equal to 150KB";
            }
            if ($errors == '') {
                $didUpload = move_uploaded_file($eFileTmpName, $uploadPath);
                if ($didUpload) {
                    $didUpload = "The file " . basename($eFileLogo) . " has been uploaded";
                }else {
                    echo "An error occurred somewhere. Try again or contact the admin";
                }
            }else{
                foreach ($errors as $error){
                    echo $error . "These are the errors" . "\n";
                }
            }
            
          $aParam     = array(
             'eCompanyClientId' => $eCompanyClientId,
             'eCompanyName'     => $eCompanyName,
             'eFileLogo'        => $eFileLogo,
             'eWebUrl'          => $eWebUrl,
             'eTitle'           => $eTitle    
           );
           
         $EditData = hostpartnerhandle_controller::singleton()->EditCompanyData($aParam);
         
         $_SESSION['isEditCompany'] = 0; 
         
        if(isset($EditData['client_id']) && $EditData['client_id'] != 0){ 
        
             $value         = array(
                 'clientId'     => $EditData['client_id'],
                 'email'        => $accountProduct['email'],
                 'companyName'  => $EditData['company_name'],
                 'webUrl'       => $EditData['web_url'],
                 'title'        => $EditData['title']       
            );
    
            $ticketEditCompany    = zendeskintegratehandle_controller::singleton()->createTicketEditCompany($value);
            
            if(isset($ticketEditCompany)){
                 $_SESSION['isEditCompany'] = 1; 
                 $this->assign('ticketEditCompany',$ticketEditCompany); 
            }
         
        }
             if($_SESSION['isEditCompany'] == 1 ){
                  $_SESSION['isEditCompany'] = 0;
                  echo "<script>
                      alert('Your edited information has been submitted to our team to review it.');
                      window.location.assign('https://rvglobalsoft.com/clientarea');
                  </script>";
                
             }
    }
    
   
    