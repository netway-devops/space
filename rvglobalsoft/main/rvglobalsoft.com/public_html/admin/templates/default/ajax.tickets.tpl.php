<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

require_once(APPDIR . 'libs/htmlpurifier/library/HTMLPurifier.auto.php');
require_once(APPDIR . 'modules/Site/supporthandle/admin/class.supporthandle_controller.php');
require_once(APPDIR . 'modules/Other/adminconfigurationhandle/class.adminconfigurationhandle.php');
require_once(APPDIR . 'modules/Other/optimizationhandle/class.optimizationhandle.php');

// --- Get template variable ---
$aTicket        = $this->get_template_vars('ticket');
$aAdmindata     = $this->get_template_vars('admindata');
$aTickets       = $this->get_template_vars('tickets');
$currentlist    = $this->get_template_vars('currentlist');
$currentdept    = $this->get_template_vars('currentdept');
$perpage        = $this->get_template_vars('perpage');
$assigned       = $this->get_template_vars('assigned');
$cmd            = $this->get_template_vars('cmd');
$currentfilter  = $this->get_template_vars('currentfilter');
$action         = $this->get_template_vars('action');
$aReplies       = $this->get_template_vars('replies');
$aStaffMembers  = $this->get_template_vars('staff_members');
// --- Get template variable ---

/* --- Rebuild content --- */
$ticketBody = $aTicket['body'];

$ticketBody = preg_replace('/##a#(.*)##(.*)#a##/i', '<a $1>$2</a>', $ticketBody);

// ทำความสะอาด html
$purifierConfig     = HTMLPurifier_Config::createDefault();

$purifierConfig->set('HTML.Allowed', 'a');//'table,tr,td,h1,h2,h3,p,ul,ol,li,a,b,i,br,img');
$purifierConfig->set('HTML.AllowedAttributes', 'a.href,img.src');
$purifierConfig->set('AutoFormat.RemoveEmpty', true);
$purifierConfig->set('HTML.TidyLevel', 'heavy');

$purifier           = new HTMLPurifier($purifierConfig);
$ticketBody         = $purifier->purify($ticketBody);

$this->assign('ticketBody', $ticketBody);


/* --- filter $aTickets ticket ใหม่ เอาเฉพาะ Open+ClientReply --- */
//$showall        = $this->get_template_vars();
//echo '<pre>'.print_r($showall, true).'</pre>';
//echo '<pre>'.print_r($_GET, true).'</pre>';
//echo '<pre>'.print_r($_POST, true).'</pre>';

$cmd                = (isset($_GET['cmd'])) ? $_GET['cmd'] : $cmd;
$howToList          = (isset($_POST['list']) && $_POST['list']) ? $_POST['list'] : $currentlist;

$myScheduleTicketTotal  = 0;
$totalChangeManagement  = 0;

if ($cmd == 'tickets' 
    && ! count($currentfilter)
    && ($currentlist == 'all' || ($_POST['make'] == 'poll' && $_POST['list'] == 'all'))) {
    
    $page           = isset($_GET['page']) ? $_GET['page']+0 : $_POST['page']+0;
    $assigned       = (isset($_GET['assigned']) && $_GET['assigned']) ? $_GET['assigned'] : $assigned;
    $assigned       = (isset($_POST['assigned']) && $_POST['assigned']) ? $_POST['assigned'] : $assigned;
    $currentdept    = (isset($_POST['dept']) && count($_POST['dept'])) ? implode(',', $_POST['dept']) : $currentdept;
    
    /* --- [XXX] ต้อง echo เพื่อแก้ไขปัญหาเมื่ออยู่หน้า 2 เป็นต้นไป ไม่ให้ javascript reload ไปหน้าแรก --- */
    echo '&nbsp;';
    
    $result         = supporthandle_controller::ticketOpenAndClientReply(array(
                            'limit'         => 500, // $perpage,
                            'offset'        => 0, // ($page * $perpage),
                            'assigned'      => $assigned,
                            'currentdept'   => $currentdept
                            
                        ));
    
    $total          = $result['total'];
    $this->assign('totalOpenAndClientReply', $total);
    
    $aTickets       = isset($result['result']) ? $result['result'] : array();
    
    if ($assigned) {
        
        //array_push($aTickets, array('header' => 'My Fulfillment Tickets', 'title' => 'In-progress รวมที่ assign โดยตรง หรือ ให้รับผิดชอบร่วม แต่ไม่เอา spam*'));
        
        $result         = supporthandle_controller::myFulfillmentTicket(array(
                                'limit'         => 500, // $perpage,
                                'offset'        => 0, // ($page * $perpage),
                                'assigned'      => $assigned
                                
                            ));
        
        $this->assign('myFulfillmentTicketTotal', $result['total']);
        $total          = (isset($result['total']) && ($result['total'] > $total)) ? $result['total'] : $total;
        
        if (isset($result['result']) && count($result['result'])) {
            foreach ($result['result'] as $arr) {
                array_push($aTickets, $arr);
            }
        }
        
        
        /*
        array_push($aTickets, array('header' => 'My Responsible Ticket ( ticket ที่ถูก assign ให้รับผิดชอบร่วม )'));
        
        $result         = supporthandle_controller::myTicketCoWorker(array(
                                'limit'         => $perpage,
                                'offset'        => ($page * $perpage)
                                
                            ));
        
        $total          = (isset($result['total']) && ($result['total'] > $total)) ? $result['total'] : $total;
        
        if (isset($result['result']) && count($result['result'])) {
            foreach ($result['result'] as $arr) {
                array_push($aTickets, $arr);
            }
        }
        */
        
        $result         = $db->query("
                SELECT t.name
                FROM  sc_team t,
                    sc_team_member tm
                WHERE t.id = tm.team_id
                    AND tm.staff_id = :staffId
                ", array(
                    ':staffId'  => $aAdmindata['id']
                ))->fetch();
        
        $teamName       = isset($result['name']) ? $result['name'] : '';
        
        array_push($aTickets, array('header' => 'Unassigned Tickets' . ( ($teamName == 'Helpdesk') ? '':' <!--(escalated)--> '), 
            'title' => 'Open. In-progress and Client-reply แต่ไม่เอา spam* --- team '. $teamName));
        
        $result         = supporthandle_controller::unassignTicket(array(
                                'limit'         => $perpage,
                                'offset'        => ($page * $perpage),
                                'team'          => $teamName
                                
                            ));
        
        $total          = (isset($result['total']) && ($result['total'] > $total)) ? $result['total'] : $total;
        
        if (isset($result['result']) && count($result['result'])) {
            foreach ($result['result'] as $arr) {
                array_push($aTickets, $arr);
            }
        }
        
        $result         = supporthandle_controller::allFulfillmentTicket(array(
                                'limit'         => 500, // $perpage,
                                'offset'        => 0, // ($page * $perpage)
                                
                            ));
        
        $this->assign('allFulfillmentTicketTotal', $result['total']);
        
        $result         = $db->query("
                SELECT
                    td.view_id, 
                    td.sorter,
                    tv.name
                FROM
                    hb_ticket_dashboard td,
                    hb_ticket_views tv
                WHERE
                    td.admin_id = :adminId
                    AND td.view_id = tv.id
                ORDER BY td.sorter ASC
                ", array(
                    ':adminId'      => $aAdmindata['id']
                ))->fetchAll();
                
        if (count($result)) {
            $aViews     = $result;
            foreach ($aViews as $arr) {
                
                array_push($aTickets, array(
                    'header'        => 'Latest: ' . $arr['name'],
                    'loadViewId'    => $arr['view_id'],
                    'sortOrder'     => $arr['sorter']
                    ));

            }
        }
        
        /* --- my schedule ticket --- */
        $result         = supporthandle_controller::myTicketSchedule(array(
                                'limit'         => $perpage,
                                'offset'        => ($page * $perpage),
                                'assigned'      => $assigned
                                
                            ));
        
        $myScheduleTicketTotal  = (isset($result['total']) && $result['total']) ? $result['total'] : 0;
        
        array_push($aTickets, array('header' => 'Assigned ticket (กรณีที่พนักงานลาหรือไม่เข้างาน หัวหน้าต้อง reassign ให้พนักงานคนอื่นด้วย)', 'title' => 'รายการ ticket ที่ถูก assign ให้ staff คนอื่น ทั้ง Open และ Client Reply'));
        
        $result         = supporthandle_controller::assignedTicket(array(
                                'limit'         => 500, // $perpage,
                                'offset'        => 0, // ($page * $perpage)
                                
                            ));
        
        if (isset($result['result']) && count($result['result'])) {
            foreach ($result['result'] as $arr) {
                array_push($aTickets, $arr);
            }
        }
        
    }
    
    /* --- All change management --- */
    $result         = supporthandle_controller::allChnageManagementTicket(array(
                            'limit'         => $perpage,
                            'offset'        => ($page * $perpage)
                        ));
    
    $totalChangeManagement      = (isset($result['total']) && $result['total']) ? $result['total'] : 0;
    if ($currentdept == 16) {
        if (isset($result['result']) && count($result['result'])) {
            $aTickets       = array();
            foreach ($result['result'] as $arr) {
                array_push($aTickets, $arr);
            }
        }
    }
    
    $this->assign('tickets', $aTickets);
    
    $sorterpage     = $page + 1;
    $totalpages     = ceil($total / $perpage);
    $sorterrecords  = $total;
    $sorterlow      = ($page * $perpage) + 1;
    $sorterhigh     = (($sorterlow + $perpage -1) > $sorterrecords) ? $sorterrecords : ($sorterlow + $perpage -1);
    
    $this->assign('totalpages', $totalpages);
    $this->assign('sorterrecords', $sorterrecords);
    $this->assign('sorterpage', $sorterpage);
    $this->assign('sorterlow', $sorterlow);
    $this->assign('sorterhigh', $sorterhigh);
    
    $this->assign('reassignSorterrecords', $sorterrecords);
    
}

$this->assign('isAssignedView', $assigned);
$this->assign('howToList', $howToList);
$this->assign('myScheduleTicketTotal', $myScheduleTicketTotal);
$this->assign('totalChangeManagement', $totalChangeManagement);


/* --- show ticket owner สำหรับเอาออกตอน close ticket  --- */
$isSelfUnassignAble     = ($aTicket['owner_id'] == $aAdmindata['id']) ? true : false;
$this->assign('isSelfUnassignAble', $isSelfUnassignAble);

/* --- ไม่อนุญาติให้ close ถ้ายังไม่มี reply --- */
$isHaveReplyCloseAble   = false;
$result     = $db->query("
        SELECT 
            COUNT(tr.id) AS total
        FROM 
            hb_ticket_replies tr
        WHERE
            tr.ticket_id = :ticketId
        ", array(
            ':ticketId'     => $aTicket['id']
        ))->fetch();

if (isset($result['total']) && $result['total']) {
    $isHaveReplyCloseAble   = true;
}
if (! $isHaveReplyCloseAble) {
    // หรือถ้ามี comment ก็ให้ close ได้
    $result     = $db->query("
            SELECT 
                COUNT(tn.id) AS total
            FROM 
                hb_tickets_notes tn
            WHERE
                tn.ticket_id = :ticketId
                AND tn.admin_id != 0
            ", array(
                ':ticketId'     => $aTicket['id']
            ))->fetch();
    
    if (isset($result['total']) && $result['total']) {
        $isHaveReplyCloseAble   = true;
    }
}
$this->assign('isHaveReplyCloseAble', $isHaveReplyCloseAble);


/* --- ถ้า status เป็น scheduled ตั้งวันที่ล่วงหน้า 1 วัน --- */

$scheduledDate  = $aTicket['scheduled_date'];

if ($aTicket['status'] == 'Scheduled') {
    if (! strtotime($aTicket['scheduled_date'])) {
        $scheduledDate      = date('Y-m-d',strtotime('+1 day', time()));
        $db->query("
            UPDATE
                hb_tickets
            SET
                scheduled_date = :scheduledDate
            WHERE
                id = :ticketId
            ", array(
                ':ticketId'         => $aTicket['id'],
                ':scheduledDate'    => $scheduledDate
            ));
    }
}
$this->assign('scheduledDate', $scheduledDate);


/* --- simple search --- */
if (isset($_POST['filter']['keyword'])) {
    
    $keyword        = trim($_POST['filter']['keyword']);
    
    $aTicketIds     = array(0);
    $aTicketFields  = array();
    $aTickets       = is_array($aTickets) ? $aTickets : array();
    if (count($aTickets)) {
        foreach ($aTickets as $v) {
            array_push($aTicketIds, $v['id']);
        }
    }

    $aTicketFields  = array_keys($aTickets[0]);
    
    $select     = "
                SELECT
                    t.admin_read, t.id, t.type, cd.firstname, cd.lastname,
                    t.date, t.lastreply, t.dept_id, t.name,
                    t.client_id, t.status, t.ticket_number,
                    CONCAT ('#',t.ticket_number,' - ',t.subject) AS tsubject, td.name AS deptname,
                    t.priority, t.flags, t.escalated, t.tags, COALESCE (tr.name, t.name) AS rpname
                FROM
                    hb_tickets t
                    JOIN hb_ticket_departments td ON t.dept_id = td.id
                    LEFT JOIN hb_ticket_replies tr ON ( tr.ticket_id = t.id AND t.lastreply = tr.date)
                    LEFT JOIN hb_client_details cd 
                        ON cd.id = t.client_id
            ";
    
    $result     = $db->query("
            (
                {$select}
                WHERE
                    t.ticket_number = :keyword
                    OR t.subject LIKE :keywordWildcards
                    OR t.body LIKE :keywordWildcards
                    OR t.email LIKE :keywordWildcards
                ORDER BY 
                    t.date DESC
                LIMIT 60
            )
            UNION (
               {$select},
                    hb_ticket_replies trx
                WHERE
                    t.id = trx.ticket_id
                    AND trx.body LIKE :keywordWildcards
                ORDER BY 
                    t.date DESC
                LIMIT 60
            )
            UNION (
               {$select},
                    hb_tickets_notes tn
                WHERE
                    t.id = tn.ticket_id
                    AND tn.note LIKE :keywordWildcards
                ORDER BY 
                    t.date DESC
                LIMIT 60
            )
            ", array(
                ':keyword'              => $keyword,
                ':keywordWildcards'     => '%'.$keyword.'%'
            ))->fetchAll();
    
    foreach ($result as $v) {
        
        if (is_numeric($v['id']) && ! in_array($v['id'], $aTicketIds)) {
            array_push($aTicketIds, $v['id']);
            array_push($aTickets, $v);
        }
        
    }
    
    $this->assign('tickets', $aTickets);
}


/* --- tag staff ถ้า assign ให้ใคร --- */
if (isset($aTicket['id'])) {
    
    if ($aTicket['owner_id']) {
        
        $result     = $db->query("
                    SELECT 
                        aa.id, aa.username
                    FROM 
                        hb_admin_access aa
                    WHERE
                        aa.id = :ownerId
                    ", array(
                        ':ownerId'  => $aTicket['owner_id']
                    ))->fetch();
                    
        if (isset($result['id']) && $result['username']) {
            $username   = '@' . substr($result['username'],0, strpos($result['username'], '@'));
            
            $result     = $db->query("
                        SELECT 
                            t.id, t.tag
                        FROM 
                            hb_tags t,
                            hb_tickets_tags tt
                        WHERE
                            t.tag = :tagName
                            AND t.id = tt.tag_id
                            AND tt.ticket_id = :ticketId
                        ", array(
                            ':tagName'  => $username,
                            ':ticketId' => $aTicket['id']
                        ))->fetch();
                        
            if (! isset($result['id'])) {

                /* --- ถ้ายังไม่ได้เชื่อม tag กับ ticket  --- */
                $result     = $db->query("
                            SELECT 
                                t.id, t.tag
                            FROM 
                                hb_tags t
                            WHERE
                                t.tag = :tagName
                            ", array(
                                ':tagName'  => $username
                            ))->fetch();
                            
                if (! isset($result['id'])) {
                    $db->query("
                    INSERT INTO hb_tags (
                        id, tag
                    ) VALUES (
                        '', :tagName
                    )
                    ", array(
                        ':tagName'  => $username
                    ));
                    $result     = $db->query("
                                SELECT 
                                    t.id, t.tag
                                FROM 
                                    hb_tags t
                                WHERE
                                    t.tag = :tagName
                                ", array(
                                    ':tagName'  => $username
                                ))->fetch();
                }
                
                $tagId      = $result['id'];
                if ($tagId) {
                    $db->query("
                    REPLACE INTO hb_tickets_tags (
                        tag_id, ticket_id
                    ) VALUES (
                        :tagId, :ticketId
                    )
                    ", array(
                        ':tagId'        => $tagId,
                        ':ticketId'     => $aTicket['id']
                    ));
                    echo '<script language="javascript">location.reload();</script>';
                }
            
            }
            
        }
    }
    
}

/* --- ดึงข้อมูลว่า tag staff คนใหนบ้าง --- */
$aTagStaff      = array();
if ($action == 'view' && isset($aTicket['id'])) {
    
    $result     = $db->query("
            SELECT 
                aa.id
            FROM 
                hb_tickets_tags tt,
                hb_tags t
                LEFT JOIN
                    hb_admin_access aa
                    ON aa.username LIKE CONCAT(SUBSTR(t.tag, 2), '@%')
            WHERE
                tt.ticket_id = :ticketId
                AND t.id = tt.tag_id
            ", array(
                ':ticketId' => $aTicket['id']
            ))->fetchAll();
            
    if (count($result)) {
        foreach ($result as $arr) {
            array_push($aTagStaff, $arr['id']);
        }
    }
    
}
$this->assign('aTagStaff', $aTagStaff);

/* --- แสดง comment ตามช่วงเวลา --- */

$aNotes         = array();

if ($action == 'view' && isset($aTicket['id'])) {
    $aDate      = array();
    $aDate[0]   = strtotime($aTicket['date']);
    
    if (count($aReplies)) {
        foreach ($aReplies as $arr) {
            $aDate[$arr['id']]  = strtotime($arr['date']);
        }
    }
    
    krsort($aDate);
    
    $result     = $db->query("
            SELECT
                tn.*, d.id AS fileId, d.name AS fileName
            FROM
                hb_tickets_notes tn
                LEFT JOIN
                    hb_downloads d
                    ON
                        d.rel_id = tn.id
                        AND d.rel_type = 4
            WHERE
                tn.ticket_id = :ticketId
            ORDER BY 
                tn.date ASC
            ", array(
                ':ticketId'     => $aTicket['id']
            ))->fetchAll();
    
    if (count($result)) {
        foreach ($result as $arr) {
            $noteDate       = strtotime($arr['date']);
            foreach ($aDate as $replyId => $replyDate) {
                if ($replyDate <= $noteDate) {
                    if (! is_array($aNotes[$replyId])) {
                        $aNotes[$replyId]   = array();
                    }
                    array_push($aNotes[$replyId], $arr);
                    break;
                }
            }
        }
    }
    
}

$this->assign('aNotes', $aNotes);

/* --- subscribe <=> tag ticket --- */
$result         = supporthandle_controller::ticketTagAndSubscribeSync(array(
        'ticketId'      => $aTicket['id']
        ));


/* --- load client --- */
$loadClient         = (isset($_GET['lc'])) ? true : false;
$this->assign('loadClient', $loadClient);


/* --- Client information --- */
$result         = supporthandle_controller::getClient(array(
        'clientId'      => $aTicket['client_id']
        ));
$this->assign('aClient', $result);

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

if ($cmd == 'tickets' && $action == 'clienttickets') {
    $aTickets           = supporthandle_controller::getLastreplyTime(array('aTickets' => $aTickets));
    $this->assign('tickets', $aTickets);
}

/* --- extend admin field --- */
$result             = adminconfigurationhandle::singleton()->extendField($aStaffMembers,'username');
$this->assign('staff_members', $result);

// --- เอา ticket reply จาก archive กลับมา ---
if (isset($aTicket['id'])) {
    $result         = optimizationhandle::singleton()->restoreTicketReplyArchive($aTicket['id']);
    if ($result) {
        echo '<script language="javascript">location.reload();</script>';
    }
}

if (isset($_GET['list']) && $_GET['list'] == 'Fulfillment') {
    $result         = supporthandle_controller::allFulfillmentTicket(array(
                            'limit'         => 500, // $perpage,
                            'offset'        => 0, // ($page * $perpage)
                            
                        ));
    
    if (isset($result['result']) && count($result['result'])) {
        foreach ($result['result'] as $arr) {
            array_push($aTickets, $arr);
        }
    }
    
    $this->assign('tickets', $aTickets);
    
}
