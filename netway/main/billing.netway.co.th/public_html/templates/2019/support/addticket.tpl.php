<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'modules/Site/supporthandle/user/class.supporthandle_controller.php');
require_once(APPDIR . 'modules/Site/kbhandle/user/class.kbhandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : (object) array();
// --- hostbill helper ---


// --- Get template variable ---
$aDepts     = $this->get_template_vars('depts');
$aSubmit    = $this->get_template_vars('submit');
$caUrl      = $this->get_template_vars('ca_url');
$deptId     = isset($_GET['deptId']) ? $_GET['deptId'] : 0;
// --- Get template variable ---

/* --- [XXX] --- */
$this->assign('deptId', $deptId);
$kbCategory         = 0;
if (count($aDepts)) {
    foreach ($aDepts as $arr) {
        if ($arr['id'] == $deptId) {
            $kbCategory      = $arr['kb_category'];
        }
        
    }
}
if ($kbCategory) {
    $result         = supporthandle_controller::_listKbSubCateogry(array('catId' => $kbCategory));
    $this->assign('aKbCategory', $result);
}

$result         = kbhandle_controller::_buildJumpMenuCategory(array(
                    'linkUrl'   => $caUrl .'knowledgebase/category',
                    'target'    => '_blank'
                    ));
$this->assign('listCategories', $result);

//unset($aCategory['lang']);
//echo '<pre>'.print_r($aDepts, true).'</pre>';