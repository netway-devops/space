<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR .'modules/Site/attachmenthandle/admin/class.attachmenthandle_controller.php');
require_once(APPDIR .'modules/Site/supporthandle/admin/class.supporthandle_controller.php');
require_once(APPDIR .'modules/Other/supportcataloghandle/admin/class.supportcataloghandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Custom helper ---
require_once(APPDIR . 'class.api.custom.php');
require_once(APPDIR . 'class.general.custom.php');
$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

// --- Get template variable ---
$aTicket            = $this->get_template_vars('ticket');
$aAttachments       = $this->get_template_vars('attachments');
$aReplies           = $this->get_template_vars('replies');
// --- Get template variable ---

if ($aTicket['id'] && ! isset($_GET['internal'])) {
    $result     = $db->query("
        SELECT zt.*
        FROM hb_zendesk_ticket zt,
            hb_tickets t
        WHERE t.ticket_number = :ticketNumber
            AND zt.ticket_id = t.id
        ", array(
            ':ticketNumber'     => $aTicket['ticket_number']
        ))->fetch();
    
    if (isset($result['zendesk_ticket_id']) && $result['zendesk_ticket_id']) {
        header('location:https://pdi-netway.zendesk.com/agent/tickets/'. $result['zendesk_ticket_id']);
        exit;
    }
}

$aAttachments   = attachmenthandle_controller::singleton()->isImage($aAttachments);
$this->assign('attachments', $aAttachments);

$aSubmitter     = supporthandle_controller::singleton()->getSubmitter($aTicket['id']);
$this->assign('aSubmitter', $aSubmitter);

$aReplies       = supporthandle_controller::singleton()->beautifierReply($aReplies);
$this->assign('replies', $aReplies);

$result         = supportcataloghandle_controller::singleton()->autoassignAsIncident($aTicket['id']);


//$xxxx           = $this->get_template_vars();
//echo '<pre>'.print_r($_SERVER,true).'</pre>';