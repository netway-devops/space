<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Custom helper ---
require_once(APPDIR . 'class.api.custom.php');
$adminUrl   = $this->get_template_vars('admin_url');
$apiCustom  = ApiCustom::singleton($adminUrl.'/api.php');
// --- Custom helper ---

// --- Get template variable ---
$aStats     = $this->get_template_vars('stats');
// --- Get template variable ---

/* --- Invoice unpaid stats --- */
$this->assign('listExt', isset($_GET['listExt']) ? $_GET['listExt'] : '');
$this->assign('statusExt', isset($_GET['statusExt']) ? $_GET['statusExt'] : '');

$aStatsInfo     = array();
if (! isset($_GET['action'])) {
    $aUnpaidFilter  = array(
                        'unpaidOverdueDomain',
                        'unpaidOverdueService',
                        'unpaidNewDomain',
                        'unpaidNewService',
                        'unpaidIsShipped'
                    );
    foreach ($aUnpaidFilter as $invoiceFilterName) {
        $aParam     = array(
            'call'      => 'module',
            'module'    => 'invoicefilter',
            'fn'        => $invoiceFilterName
        );
        $result = $apiCustom->request($aParam);
        if ($result['success']) {
            $aStats[$invoiceFilterName] = $result['total'];
            $aStatsInfo[$invoiceFilterName] = htmlspecialchars($result['sql'], ENT_QUOTES);
        }
    }
}

$this->assign('aStats', $aStats);
$this->assign('aStatsInfo', $aStatsInfo);