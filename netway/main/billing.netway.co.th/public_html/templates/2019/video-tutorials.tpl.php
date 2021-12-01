<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

header('Location: https://netway.co.th');

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.config.custom.php');
// require_once(APPDIR . 'modules/Site/kbhandle/user/class.kbhandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : (object) array();
// --- hostbill helper ---


// --- Get template variable ---
$aCategory  = $this->get_template_vars('category');
$action     = $this->get_template_vars('action');
$aResults   = $this->get_template_vars('results');
$aArticle   = $this->get_template_vars('article');
$aPath      = $this->get_template_vars('path');
$caUrl      = $this->get_template_vars('system_url');
// --- Get template variable ---

$videoCategory= $db->query(" SELECT *
                  FROM hb_kb_category  WHERE  kb_category_id 
                  IN ( 360000737312,360000737292,360000697351,
                       360000690312,360000696311,360000695931,
                       360000695771,360001257931,360001259152
                      )
                  ORDER BY add_time DESC

        ")->fetchAll();
    foreach($videoCategory as $key => $value){
        $videoCategory[$key]['section'] =   $db->query("select * from hb_kb_section where kb_category_id in ('".$value['kb_category_id']."')")->fetchAll();
    }
    $this->assign('videoCategory',$videoCategory);
