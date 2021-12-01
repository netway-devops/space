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
$aSubmit    = $this->get_template_vars('submit');
// --- Get template variable ---

/* --- ผูก ticket department กับ knowledgebase category --- */
$aKbCategory    = array();

$result         = $db->query("
        SELECT
            kc.*
        FROM
            hb_knowledgebase_cat kc
        WHERE
            kc.parent_cat = 0
        ORDER BY
            kc.name ASC
        ")->fetchAll();

if (count($result) && isset($aSubmit['kb_category'])) {
    foreach ($result as $arr) {
        if ($arr['id'] == $aSubmit['kb_category']) {
            $arr['selected']        = true;
        }
        $aKbCategory[$arr['id']]    = $arr;
    }
}

$this->assign('aKbCategory', $aKbCategory);


//echo '<pre>'.print_r($aCat,true).'</pre>';