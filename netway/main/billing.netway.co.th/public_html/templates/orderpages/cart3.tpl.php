<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.discount.custom.php');

// --- hostbill helper ---
$db         = hbm_db();
// --- hostbill helper ---


// --- Get template variable ---
$aProduct           = $this->get_template_vars('product');
$aSubProducts       = $this->get_template_vars('subproducts');
$aAddons            = $this->get_template_vars('addons');
$aCustom            = $this->get_template_vars('custom');
$aContents          = $this->get_template_vars('contents');
// --- Get template variable ---


/* --- แสดงส่วนลด --- */
if (count($aProduct)) {
    $aProduct           = DiscountCustom::singleton()->getInfo($aProduct, 'product');
    $this->assign('aProduct', $aProduct);
}

if (count($aCustom)) {
    $aCustom            = DiscountCustom::singleton()->getInfo($aCustom, 'custom');
    $this->assign('aCustom', $aCustom);
}

if (count($aSubProducts)) {
    $aSubProducts       = DiscountCustom::singleton()->getInfo($aSubProducts, 'subproduct');
    $this->assign('aSubProducts', $aSubProducts);
}

if (count($aAddons)) {
    $aAddons            = DiscountCustom::singleton()->getInfo($aAddons, 'addon');
    $this->assign('aAddons', $aAddons);
}


//echo '<pre>'. print_r($_SESSION['Cart'], true) .'</pre>';
//echo '<pre>'. print_r($aContents, true) .'</pre>';

/* --- 4.8.2 มี bug custom field ไม่แสดง data ใน cart --- */
if (isset($_SESSION['Cart'][2]) && count($_SESSION['Cart'][2])
    && isset($aContents[1]) && count($aContents[1])) {
    $aContents[1]   = $_SESSION['Cart'][2];
    foreach ($_SESSION['Cart'][2] as $cfGroupId => $aCf) {
        foreach ($aCf as $cfGroupId2 => $aCf2) {
            $aContents[1][$cfGroupId][$cfGroupId2]['val']       = $aCf2['val'];
            if ($aCf2['type'] == 'qty') {
                $aContents[1][$cfGroupId][$cfGroupId2]['qty']   = $aCf2['val'];
            }
        }
    }
    $this->assign('contents', $aContents);
}
    
    
foreach($aCustom as $value){
    if($value['name'] == 'Monitoring Service'){
        foreach ($value['items'] as $item) {
            if($item['variable_id'] == 'managed_free'){
                $nameCheck = 'custom['.$item['category_id'].']['.$item['id'].']';
                $this->assign('namefreemonitor', $nameCheck);
            }
                
        }
    }
}

$aProduct  		=   $this->get_template_vars('product');
$aCloudType 	=	explode(' ', $aProduct['name']);
$cloudType 		=   $aCloudType[0];
$result					=	$db->query("
								SELECT 
									id , category_id , name , description
								FROM
									hb_products
								WHERE
									category_id IN (83,84)
									AND name LIKE '$cloudType%'
							")->fetchAll();
$aNewData	= array();							
foreach($result as $value){
	$location 	=	explode(' ', $value['name']);	 
	$aNewData[]	=	array(
						'value'		=>	$value ,
						'location'	=>	$location[1]
					);
}
							
$this->assign('cloudLocationProduct',$aNewData);



