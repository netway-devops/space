<?php

/**
 * New support ticket has just been created
 * $details =array('ticket_id'=>RELATED TICKET ID IN HOSTBILL DB,
 * 'ticket_number'=>RELATED TICKET NUMBER,
 * 'acc_hash'=>REMOTE ACCESS HASH FOR NON_REGISTERED VIEWS,
 * 'dept_id'=>RELATED DEPARTMENT ID,
 * 'client_id'=>RELATED CLIENT ID (IF ANY),
 * 'name'=>SUBMITTER NAME,
 *  'email'=>SUBMITTER EMAIL,
 *  'subject'=>TICKET SUBJECT,
 *  'body'=>TICKET BODY,
 *  'status'=>TICKET STATUS)
 * Following variable is available to use in this file:  $details
 */
 
/*hosbill tickets to wrike*/
$db            = hbm_db();
$ticketID      = $details['ticket_id'];
$email         = $details['email'];
$name          = $details['name'];
 

require_once(APPDIR . 'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');

$aParam     = array(
    'id'        => $ticketID,
    'email'     => $email,
    'name'      => $name
);
 zendeskintegratehandle_controller::singleton()->createNewTicket($aParam);
