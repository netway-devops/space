<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'class.general.custom.php');


// --- hostbill helper ---
$api        = new ApiWrapper();
$db         = hbm_db();
// --- hostbill helper ---

// --- Get template variable ---
$aDetails   = $this->get_template_vars('details');
// --- Get template variable ---

$accountId  = $aDetails['id']; 
$productId  = $aDetails['product_id']; 
$aCustom    = $aDetails['custom']; 

$isLicense  = 0;

$result     = $db->query("
    SELECT p.category_id
    FROM hb_products p
    WHERE p.id = '{$productId}'
    AND p.category_id = '6'
    ")->fetch();

if (isset($result['category_id'])) {

    $ip         = GeneralCustom::singleton()->getIPFromConfig2Account($accountId);
    $publicIp   = GeneralCustom::singleton()->getPublicIPFromConfig2Account($accountId);

    $isLicense      = 1;
    $sbId           = 0;
    $sbAccountId    = 0;
    $aSite          = array();
    
    $setStatusLicense = $db->query("
               SELECT * 
               FROM hb_accounts
               WHERE id = '{$accountId}'
               ")->fetch();
               
               
    $result     = $db->query("
        SELECT sb.*
        FROM rvsitebuilder_license sb
        WHERE sb.hb_acc = '{$accountId}'
        ")->fetch();
    if (isset($result['license_id'])) {
        
         $sbId   = $result['license_id'];
         $aSite  = $result;
         
        if (isset($result['hb_acc'])) {
            $sbAccountId    = $result['hb_acc'];
        }
         
        if($setStatusLicense['status']=='Active'){ 
                 $result['active'] = $db->query("    
                     UPDATE rvsitebuilder_license 
                     SET  active = '1'
                     WHERE hb_acc = {$sbAccountId}
                     AND license_id = {$sbId} 
                ");
         }else{
                  $result['active'] = $db->query("    
                     UPDATE rvsitebuilder_license 
                     SET  active = '0'
                     WHERE hb_acc = {$sbAccountId}
                     AND license_id = {$sbId} 
                ");
                
          }
          
        
      $aSite['expire'] = date("d/m/Y",$aSite['expire']);
    }
        


    if (! $sbId) {
        $result     = $db->query("
            SELECT sb.*
            FROM rvsitebuilder_license sb
            WHERE sb.primary_ip = '{$ip}' 
                OR sb.primary_ip = '{$publicIp}' 
                OR sb.secondary_ip = '{$ip}' 
                OR sb.secondary_ip = '{$publicIp}' 
            ")->fetch();
        if (isset($result['hb_acc'])) {
            $sbAccountId    = $result['hb_acc'];
        }
    }
    
    $this->assign('sbId', $sbId);
    $this->assign('sbAccountId', $sbAccountId);
    $this->assign('aSite', $aSite);
    
    
    // -----------RVSkin------------
    
    $skId           = 0;
    $skAccountId    = 0;
    $aSkin          = array();
    
    $result     = $db->query("
        SELECT rk.*
        FROM rvskin_license rk
        WHERE rk.hb_acc = '{$accountId}'
        ")->fetch();
    if (isset($result['license_id'])) {
        $skId   = $result['license_id'];
        $aSkin  = $result;
        
        if (isset($result['hb_acc'])) {
            $skAccountId    = $result['hb_acc'];
        }
        
        if($setStatusLicense['status']=='Active'){ 
                 $result['active'] = $db->query("    
                     UPDATE rvskin_license 
                     SET  active = 'yes'
                     WHERE hb_acc = {$skAccountId}
                     AND license_id = {$skId} 
                ");
         }else{
                  $result['active'] = $db->query("    
                     UPDATE rvskin_license 
                     SET  active = 'no'
                     WHERE hb_acc = {$skAccountId}
                     AND license_id = {$skId} 
                ");
                
          }
        
     $aSkin['expire'] = date("d/m/Y",$aSkin['expire']);
     
    }
        
    if (! $skId) {
        $result     = $db->query("
            SELECT rk.*
            FROM rvskin_license rk
            WHERE rk.main_ip = '{$ip}' 
                OR rk.main_ip = '{$publicIp}' 
                OR rk.second_ip = '{$ip}' 
                OR rk.second_ip = '{$publicIp}' 
            ")->fetch();
        if (isset($result['hb_acc'])) {
            $skAccountId    = $result['hb_acc'];
        }
        
    }
       
    $this->assign('skId', $skId);
    $this->assign('skAccountId', $skAccountId);
    $this->assign('aSkin', $aSkin);
    

}

$this->assign('isLicense', $isLicense);

//echo '<pre>'.print_r($aDetails,true).'</pre>';