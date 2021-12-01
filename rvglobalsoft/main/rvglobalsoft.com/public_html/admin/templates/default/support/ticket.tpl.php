<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR .'modules/Site/attachmenthandle/admin/class.attachmenthandle_controller.php');
require_once(APPDIR .'modules/Site/supporthandle/admin/class.supporthandle_controller.php');
require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');


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


$aAttachments   = attachmenthandle_controller::singleton()->isImage($aAttachments);
$this->assign('attachments', $aAttachments);

$aSubmitter     = supporthandle_controller::singleton()->getSubmitter($aTicket['id']);
$this->assign('aSubmitter', $aSubmitter);

$aReplies       = supporthandle_controller::singleton()->beautifierReply($aReplies);
$this->assign('replies', $aReplies);

$result     = zendeskintegratehandle_controller::singleton()->isZendeskTicket($aTicket);
$this->assign('aZendeskTicket', $result);

//echo '<pre>'.print_r($aTicket,true).'</pre>';



