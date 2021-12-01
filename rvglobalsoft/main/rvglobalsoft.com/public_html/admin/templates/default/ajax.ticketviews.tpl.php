<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$oAdmin     = (object) hbm_logged_admin();
// --- hostbill helper ---

// --- Get template variable ---
$aTicket    = $this->get_template_vars('ticket');
$action         = $this->get_template_vars('action');
$aDepartments   = $this->get_template_vars('departments');
$aViews         = $this->get_template_vars('views');
// --- Get template variable ---

/* --- get ticket more info --- */
$result     = $db->query("
            SELECT
                t.id, t.date
            FROM
                hb_tickets t
            WHERE
                t.id = :ticketId
            ", array(
                ':ticketId'     => $aTicket['id']
            ))->fetch();
            
if (isset($result['id']) && $result['id']) {
    $aTicket['date']    = $result['date'];
}

$this->assign('aTicket', $aTicket);
/* --- bug hostbill 4.7.0 ไม่มี department ถ้ามันแก้แล้วลบทิ้งได้เลย --- */
if ($action == 'add' || $action == 'edit' || $action == 'fromfilter') {
    if (! is_array($aDepartments) || ! count($aDepartments)) {
        $result     = $db->query("
                    SELECT
                        td.id, td.name
                    FROM
                        hb_ticket_departments td
                    WHERE
                        1
                    ORDER BY td.name ASC
                    ")->fetchAll();
        
        $this->assign('departments', $result);
    }
}

/* --- ป้องกันการลบ view --- */

$aViewInfos         = array();

if (count($aViews)) {
    $aViewInfos     = $aViews;
    
    foreach ($aViews as $k => $v) {
        
        if ($oAdmin->username == $v['username'] 
            || isset($oAdmin->access['deleteSupportTicket'])
            || isset($oAdmin->access['closeSupportTicket']) ) {
            
            $aViewInfos[$k]['isDeleteable'] = 1;
            
        }
    }
    
    $this->assign('aViewInfos', $aViewInfos);
}

//echo '<pre>---'.print_r($oAdmin,true).'---</pre>';