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
$aMyDepartments  = $this->get_template_vars('myDepartments');
// --- Get template variable ---


$filterKeyword      = isset($_POST['filter']['keyword']) ? $_POST['filter']['keyword'] : '';
if (! $filterKeyword && isset($_SESSION['Sortertickets']['filterInput']['keyword'])) {
    $filterKeyword  = $_SESSION['Sortertickets']['filterInput']['keyword'];
}
$this->assign('filterKeyword', $filterKeyword);
/* --- load หน้า ticket ที่พึ่ง reply ไป --- */
if (isset($_SESSION['ticketLastReply']) && $_SESSION['ticketLastReply']) {
    echo '
    <script language="javascript">
    window.location.href = \'?cmd=tickets&list=all&showall=true#' . $_SESSION['ticketLastReply'] . '\';
    </script>';
    unset($_SESSION['ticketLastReply']);
}
