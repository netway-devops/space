<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'modules/Site/supporthandle/user/class.supporthandle_controller.php');
require_once(APPDIR .'modules/Other/zendeskintegratehandle/admin/class.zendeskintegratehandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : (object) array();
// --- hostbill helper ---


// --- Get template variable ---
$aCategory      = $this->get_template_vars();
$aTicket        = $this->get_template_vars('ticket');
// --- Get template variable ---

/* --- รองรับ customfield ที่ลูกค้ากรอกมา --- */
$result         = supporthandle_controller::_extractCustomfield(array(
        'ticketId'      => $aTicket['id']
        ));
if ($result) {
    $aCustomField       = unserialize($result['customfield']);
    $aCustomField_temp  = $aCustomField;
    if (isset($aCustomField['problem'])) {
        $problem        = '\''.$aCustomField['problem'].'\'';
        foreach ($aCustomField_temp as $k => $v ) {
            if (isset($v[$problem]) && is_array($v)) {
                $aCustomField[$k]   = $v[$problem];
            } else {
                $aCustomField[$k]   = $v;
            }
        }
    }
    $aCustomField_temp  = $aCustomField;
    if (isset($aCustomField['problemOn'])) {
        $problem        = '\''.$aCustomField['problemOn'].'\'';
        foreach ($aCustomField_temp as $k => $v ) {
            if (isset($v[$problem]) && is_array($v)) {
                $aCustomField[$k]   = $v[$problem];
            } else {
                $aCustomField[$k]   = $v;
            }
        }
    }
    $aCustomField_temp  = $aCustomField;
    foreach ($aCustomField_temp as $k => $v ) {
        if (is_array($v)) {
            unset($aCustomField[$k]);
        }
    }
    $this->assign('aCustomField', $aCustomField);
    if (isset($result['body'])) {
        echo '<script language="javascript">location.reload();</script>';
    }
}

$result     = zendeskintegratehandle_controller::singleton()->isZendeskTicket($aTicket);
if (isset($result['zendesk_ticket_id']) && $result['zendesk_ticket_id']) {
    if (isset($result['location'])) {
        echo '<script language="javascript">document.location="'. $result['location'] .'";</script>';
        exit;
    }
    echo '<script language="javascript">document.location="https://rvglobalsoft.zendesk.com/hc/en-us/requests/'. $result['zendesk_ticket_id'] .'";</script>';
    exit;
}


//unset($aCategory['lang']);
//echo '<pre>'.print_r($aCustomField, true).'</pre>';