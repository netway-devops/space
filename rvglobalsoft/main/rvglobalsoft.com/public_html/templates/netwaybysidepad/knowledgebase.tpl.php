<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');
require_once(APPDIR . 'class.config.custom.php');
require_once(APPDIR . 'modules/Site/kbhandle/user/class.kbhandle_controller.php');

// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
$client     = hbm_logged_client();
$oClient    = isset($client['id']) ? (object) $client : (object) array();
// --- hostbill helper ---

$this->assign('hbsid', $oClient->s_id);

// --- Get template variable ---
$aCategory  = $this->get_template_vars('category');
$action     = $this->get_template_vars('action');
$aResults   = $this->get_template_vars('results');
$aArticle   = $this->get_template_vars('article');
$aPath      = $this->get_template_vars('path');
$caUrl      = $this->get_template_vars('ca_url');
// --- Get template variable ---


/* --- ใช้เรื่อง url friendly --- */
if (isset($aCategory['categories']) && count($aCategory['categories'])) {
    $arrs    = $aCategory['categories'];
    foreach ($arrs as $k => $arr) {
        $slag   = $arr['name'];
        $aCategory['categories'][$k]['slug']    = GeneralCustom::singleton()->urlFriendlyThai($slag);
    }
}
if (isset($aCategory['articles']) && count($aCategory['articles'])) {
    $arrs    = $aCategory['articles'];
    foreach ($arrs as $k => $arr) {
        $slag   = $arr['title'];
        $aCategory['articles'][$k]['slug']    = GeneralCustom::singleton()->urlFriendlyThai($slag);
    }
}
$this->assign('aCategory',$aCategory);


/* --- ปรับปรุงระบบค้นหา kb --- */
if ($action == 'search' && trim($_POST['query']) != '') {
    $_POST['query']     = trim($_POST['query']);
    $term       = (isset($_POST['term']) && $_POST['term'] == 'AND') ? 'AND' : 'OR';

    $result     = kbhandle_controller::_searchArticle(array(
            'term'      => $term,
            'query'     => $_POST['query']
            ));

    if (count($result)) {
        $this->assign('results', $result);
    }

    $this->assign('term', $term);
}


if ($action == 'search' && count($aResults)) {
    $arrs    = $aResults;
    foreach ($arrs as $k => $arr) {
        $slag   = $arr['title'];
        $aResults[$k]['slug']    = GeneralCustom::singleton()->urlFriendlyThai($slag);
    }
}
$this->assign('aResults', $aResults);


/* --- kb comment able by disqus --- */
/**
 * http://help.disqus.com/customer/portal/articles/236206-integrating-single-sign-on
 */
if (isset($oClient->id) && $oClient->id) {

    $nwDisqusSecretKey      = ConfigCustom::singleton()->getValue('nwDisqusSecretKey');
    $nwDisqusPublicKey      = ConfigCustom::singleton()->getValue('nwDisqusPublicKey');

    $data   = array(
        'id'        => $oClient->id,
        'username'  => $oClient->email,
        'email'     => $oClient->email
    );

    function dsq_hmacsha1($data, $key) {
        $blocksize=64;
        $hashfunc='sha1';
        if (strlen($key)>$blocksize)
            $key=pack('H*', $hashfunc($key));
        $key=str_pad($key,$blocksize,chr(0x00));
        $ipad=str_repeat(chr(0x36),$blocksize);
        $opad=str_repeat(chr(0x5c),$blocksize);
        $hmac = pack(
                    'H*',$hashfunc(
                        ($key^$opad).pack(
                            'H*',$hashfunc(
                                ($key^$ipad).$data
                            )
                        )
                    )
                );
        return bin2hex($hmac);
    }

    $disqusMessage      = base64_encode(json_encode($data));
    $disqusTimestamp    = time();
    $disqusHmac         = dsq_hmacsha1($disqusMessage . ' ' . $disqusTimestamp, $nwDisqusSecretKey);
    $this->assign('disqusMessage', $disqusMessage);
    $this->assign('disqusTimestamp', $disqusTimestamp);
    $this->assign('disqusHmac', $disqusHmac);
    $this->assign('nwDisqusPublicKey', $nwDisqusPublicKey);

}

/* --- Detect ว่าเป็น google doc ที่ publish หรือเปล่า --- */
if (isset($aArticle['google_drive_file_id']) && $aArticle['google_drive_file_id']) {
    $aHeader        = @get_headers('https://docs.google.com/a/rvglobalsoft.com/document/d/'.
                        $aArticle['google_drive_file_id']  .'/pub');
    if (! isset($aHeader[0]) || ! preg_match('/200\sOK/i', $aHeader[0])) {
        $this->assign('isGDocNotPublish', true);
    }
    $aArticle['body']   = preg_replace('/src="([^"]*)"/i', 'src="'. $caUrl .'?cmd=kbhandle&action=view&gFile='
        . $aArticle['google_drive_file_id'] .'"', $aArticle['body']);
    $this->assign('article', $aArticle);
}

/* --- knowledgebase ระบบใหม่ -- */
$rootCategory   = 0;
if ($action == 'category' || $action == 'article') {
    $pathIndex          = (count($aPath)) ? count($aPath)-1 : 0;
    $rootCategory       = isset($aPath[$pathIndex]['id']) ? $aPath[$pathIndex]['id'] : 0;
}
$this->assign('rootCategory', $rootCategory);
$result         = kbhandle_controller::_getCategory(array());
$listSubCategories      = array();
if (isset($result[$rootCategory]) && count($result[$rootCategory])) {
    $aCategory  = $result[$rootCategory];
    foreach ($aCategory as $catId => $arr) {
        $listSubCategories[$catId]          = $arr;
        $listSubCategories[$catId]['items'] = (isset($result[$catId]) && count($result[$catId]))
                                                ? $result[$catId] : array();

    }
}
$this->assign('listSubCategories', $listSubCategories);
$result         = kbhandle_controller::_buildJumpMenuCategory(array(
                    'linkUrl'   => $caUrl .'knowledgebase/category'
                    ));
$this->assign('listCategories', $result);
$result         = kbhandle_controller::_listArticle(array('catId' => $rootCategory));
$this->assign('listArticles', $result);

/* --- แก้ไข slug สำหรับ breadcrumb  --- */
if (count($aPath)) {
    $aPath_temp     = $aPath;
    foreach ($aPath_temp as $k => $v) {
        $aPath[$k]['slug']      = GeneralCustom::singleton()->urlFriendlyThai($v['name']);
    }
    $this->assign('path', $aPath);
    if (isset($aPath[0]['slug'])) {
        if (preg_match('/rv2factor/i', $aPath[0]['slug'])) {
            $this->assign('blogUrl', 'http://blog.rvglobalsoft.com/category/2-factor-authentication/');
            $this->assign('forumUrl', 'http://forum.rvglobalsoft.com/index.php?showforum=31');
        } elseif (preg_match('/rvsitebuilder/i', $aPath[0]['slug'])) {
            $this->assign('blogUrl', 'http://blog.rvglobalsoft.com/category/rvsitebuilder/');
            $this->assign('forumUrl', 'http://forum.rvglobalsoft.com/index.php?showforum=16');
			$this->assign('yoursayUrl', 'http://yoursay.rvsitebuilder.com/');
			$this->assign('vdotutorials', 'https://goo.gl/J3vY8q');
        } elseif (preg_match('/^ssl/i', $aPath[0]['slug'])) {
            $this->assign('blogUrl', 'http://blog.rvglobalsoft.com/category/ssl-certificates/');
        } elseif (preg_match('/rvskin/i', $aPath[0]['slug'])) {
            $this->assign('blogUrl', 'http://blog.rvglobalsoft.com/category/rvskin/');
            $this->assign('forumUrl', 'http://forum.rvglobalsoft.com/index.php?showforum=14');
        } elseif (preg_match('/license/i', $aPath[0]['slug'])) {
            $this->assign('blogUrl', 'http://blog.rvglobalsoft.com/category/software-license/');
        }
    }
}

//echo '<pre>'.print_r($aPath, true).'</pre>';