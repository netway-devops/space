<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR_MODULES . 'Site/domainhandle/admin/class.domainhandle_controller.php');


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aCategory   = $this->get_template_vars('category');
// --- Get template variable ---

// --- load promotion ---
if (isset($aCategory['id'])) {
    $result     = domainhandle_controller::singleton()->getCategoryPromotion($aCategory['id']);
    $aCategory['promotion']    = $result;
    $aCategory['codeName']    = isset($result['codeName']) ? $result['codeName'] : '';
    $this->assign('category', $aCategory);
}

//check Force Redirect
if(preg_match('/\{SSL\}/',$aCategory['opconfig']['redirecturl'])){
     $redirectUrl = preg_replace('/\{SSL\}/','',$aCategory['opconfig']['redirecturl']);
}else{
   $redirectUrl = preg_replace('/\{CMS\_URL\}/','',$aCategory['opconfig']['redirecturl']);
}
  $this->assign('redirectUrl', $redirectUrl);

//check cart template
$cartTemplate = explode("/",$aCategory['template']);
if($cartTemplate[1]){
  $cartTemplate = $cartTemplate[1] ;
} else{
  $cartTemplate = $aCategory['template'];
}
$this->assign('cartTemplate', $cartTemplate);

$pathOrderpage = MAINDIR."templates/orderpages/product_categories/".$aCategory['slug'].".orderpage";

//check file.orderpage 
$checkFile = is_file($pathOrderpage);

//write file.orderpage when hostbill open list sub-category|product page
if($checkFile == 0){
  $myfile = fopen($pathOrderpage, "w") or die("Unable to open file!");
  fclose($myfile);
}



