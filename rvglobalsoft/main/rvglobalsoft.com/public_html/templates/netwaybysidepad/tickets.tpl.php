<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api            = new ApiWrapper();
$db             = hbm_db();
$client         = hbm_logged_client();
// --- hostbill helper ---

    require_once(APPDIR . 'modules/Site/supporthandle/user/class.supporthandle_controller.php');
    
    $db          = hbm_db();
    
    $ticketNum   = $this->get_template_vars('tnum');
    
    $ticket      = $db->query("
                                SELECT t.id,t.email 
                                FROM   hb_tickets t
                                WHERE  t.ticket_number =  :tnum
                              ",array(':tnum' => $ticketNum))->fetch();
    
    $ticketID   = $ticket['id'];
    
    $emailSig    =   $db->query("
                                SELECT value  
                                FROM `hb_configuration` 
                                WHERE `setting` = 'EmailSignature'
                              ")->fetch(); 
    
    
    $result         = supporthandle_controller::_extractCustomfield(array(
        'ticketId'      => $ticket['id']
        ));
        
    $customField    = unserialize($result['customfield']);
    if($customField['authMethod'] == 'SSH Key'){
        $email      = trim($ticket['email']);
        $head       = 'RVGlobalsoft Public Key';
        $body       = "Dear Sir,\n\n";
        $body      .= "This email is attaching RVGlobalsoft Public key, as your submit ticket request.\n";
        $body      .= "Please refer to the link below to add our public key in your server.\n";
        $body      .= 'LINK : https://docs.google.com/a/rvglobalsoft.com/document/d/11o0zGaJiWqB1Shdq-IFDeN899so7WjVNiVHRlMOQ4OQ/edit';
        $body      .= "\n\n\n". $emailSig['value'];
        $addihead   = "RVGlobalSoft - Applications and Tools for Hosting Providers ";
        $addihead  .= "RVGlobalSoft - Applications and Tools for Hosting Providers's profile photo";       
        $addihead  .= " order@rvglobalsoft.com"; 
        
        mail($email,$head,$body); 
    }

require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');

$aParam     = array(
    'ticketId'  => $ticketID,
);
 zendeskintegratehandle_controller::singleton()->addTicketAttachment($aParam);
