<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$db         = hbm_db();
$aClient    = hbm_logged_client();
// --- hostbill helper ---

// --- Get template variable ---

$aCategories    = $this->get_template_vars('categories');
$current_cat    = $this->get_template_vars('current_cat');
$aCategory      = $this->get_template_vars('category');
$aOpconfig      = $this->get_template_vars('opconfig');
$step           = $this->get_template_vars('step');
$action         = $this->get_template_vars('action');
$cartContent    = $this->get_template_vars('cart_contents');

// --- Get template variable ---
 $isCartContent = isset($cartContent[0]['id'])?1:0;

# redirect ไปยังหน้าอื่นถ้ามีการตั้งค่าไว้
if($step < 3 && $step != 1 && $isCartContent == 0){
    if (isset($aOpconfig['redirecturl']) && $aOpconfig['redirecturl'] && ($action == 'default' || $action == 'domain-names')) {
        if(!isset($aClient['id']) || $aOpconfig['forceredirect'] == 1){      //ถ้าลูกค้าไม่ได้ login ให้redirect
                if(preg_match('/\{SSL\}/', $aOpconfig['redirecturl'])){
                    $productPage = preg_replace('/\{SSL\}/i','',$aOpconfig['redirecturl']);
                    echo '<script> document.location = "https://ssl.in.th'.$productPage.'"; </script>';
                    exit;
                }
                elseif(preg_match('/\{CMS\_URL\}/', $aOpconfig['redirecturl'])){
                    $productPage = preg_replace('/\{CMS\_URL\}/i','',$aOpconfig['redirecturl']);
                    echo '<script> document.location = "'.CMS_URL.$productPage.'"; </script>';
                    exit;
                }

        }
    }
}