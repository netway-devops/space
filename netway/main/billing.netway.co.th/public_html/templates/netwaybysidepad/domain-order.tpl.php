<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

$db         = hbm_db();
$aClient    = hbm_logged_client();

$step           =   0;

$aPost      = isset($_POST) ? $_POST : array();

$aGet       = isset($_GET) ? $_GET : array();
$aGet       = filter_input_array($aGet, [
    'id' => FILTER_VALIDATE_INT,
    'domain' => FILTER_SANITIZE_STRING,
]);

$_SESSION['domainordercart']  =   isset($_SESSION['domainordercart']) ? $_SESSION['domainordercart'] : array();
$_SESSION['domainordercart']['incart'] = isset($_SESSION['domainordercart']['incart']) ? $_SESSION['domainordercart']['incart'] : 0; 


if(isset($aPost) && $aPost['order-domain'] == 1){
    $step       =   1;  
    foreach($aPost['selected_tld'] as $key  => $value){
        $aPPrice  =   explode('-', $aPost['selected_period'][$key]['period']);
        $_SESSION['domainordercart']['items'][$key]['period']   =   $aPPrice[0];
        $_SESSION['domainordercart']['items'][$key]['price']    =   $aPPrice[1];
        $_SESSION['domainordercart']['items'][$key]['type']     =   'Register';
    }
    foreach($aPost['selected_tld_transfer'] as $key  => $value){
        $aPPrice  =   explode('-', $aPost['selected_period'][$key]['period']);
        $_SESSION['domainordercart']['items'][$key]['period']   =   $aPPrice[0];
        $_SESSION['domainordercart']['items'][$key]['price']    =   $aPPrice[1];
        $_SESSION['domainordercart']['items'][$key]['type']     =   'Transfer';
    }
    $_SESSION['domainordercart']['incart'] = 1;
}

if(isset($aGet) && $aGet['action'] == 'addhosting'){
    $productId  =   isset($aGet['id']) ?  $aGet['id'] : 22;
    $_SESSION['domainordercart']['hosting'] = array(
                'product_id'    =>  $productId ,
                'hostname'      =>  '',
                'billing_cycle' =>  'Monthly'
            );
    $this->assign('isOrderHosting', 1); 
}

if(isset($aGet) && $aGet['domain'] != ''){
    $this->assign('autorderDomain', $aGet['domain']); 
    $_SESSION['domainordercart']['incart'] = 0;
    $step = 0;
}

if(isset($aPost) && isset($aPost['removeItem']) && $aPost['removeItem'] != ''){
    $step = 1;
    unset($_SESSION['domainordercart'][items][$aPost['removeItem']]);
    if(count($_SESSION['domainordercart'][items]) == 0){
        unset($_SESSION['domainordercart']);
    }
}

if($_SESSION['domainordercart']['incart'] == 1){
    $step = 1;
}

if(isset($aPost) && $aPost['cartDomainIsCheckout'] && isset($_SESSION['domainordercart']['items'])){
   $_SESSION['domainordercart']['cartDomainIsCheckout'] =   1;
   if($aClient['id'] == '' || !isset($aClient['id'])){
       header('Location: /clientarea/?redirect_url=domain-order');
       exit();
   }
}

if(isset($_SESSION['domainordercart']['cartDomainIsCheckout']) && $_SESSION['domainordercart']['cartDomainIsCheckout'] == 1){
   
   /*** create order ***/     
   require_once(APPDIR . 'modules/Site/domainhandle/user/class.domainhandle_controller.php');
   $aResponse   =   domainhandle_controller::singleton()->createOrder($_SESSION['domainordercart']);
   unset($_SESSION['domainordercart']); 
   if($aResponse['orderHostingonly']){
       header('location: /clientarea/invoice/'.$aResponse['invoiceId']);
   }
   //echo $aClient['id'] . '/';
   $resultClientAddress =   $db->query("
        SELECT
            *
        FROM
            hb_domains
        WHERE
            client_id = :client_id
            AND extended != ''
        ORDER BY id DESC LIMIT 0,1
    ",array(
        ':client_id'        =>  $aClient['id']
    ))->fetch();
    
   $this->assign('aClientAddress', unserialize($resultClientAddress['extended']));
   $this->assign('aRequireAddressField', array(
   'email' , 
   'firstname' , 
   'lastname' , 
   'companyname' ,
   'address1' ,
   'address2' ,
   'city' ,
   'state' ,
   'postcode' ,
   'country' ,
   'phonenumber'
   ));
   
   $oCountry    =   file_get_contents('http://country.io/names.json');
   
   $this->assign('aCountry',json_decode($oCountry));
   $this->assign('invoiceId', $aResponse['invoiceId']);
   $this->assign('aAddressType', array('registrant' , 'admin' /*, 'tech' , 'billing'*/));
   $this->assign('aClient', $aClient); 
   $step = 2;
}

if($step == 1){
    
//$_SESSION['domainordercart'] = array();

    $productId = isset($_SESSION['domainordercart']['hosting']['product_id']) ? $_SESSION['domainordercart']['hosting']['product_id'] : 22;
    
    $resultProduct =   $db->query("
        SELECT
            id , category_id
        FROM
            hb_products
        WHERE
            id = :id
           
    ",array(
        ':id'       =>  $productId
    ))->fetch();
    
    $resultPromotion =   $db->query("
        SELECT
            *
        FROM
            hb_categories
        WHERE
            id = :id
           
    ",array(
        ':id'       => $resultProduct['category_id']
    ))->fetch();
    
    $this->assign('categoryId', $resultProduct['category_id']);

    $result =   $db->query("
        SELECT
            p.id as pid , p.name , c.*
        FROM
            hb_products p , hb_common c
        WHERE
            p.category_id = :id
            AND p.id = c.id
            AND c.rel = 'Product'
            AND c.paytype = 'Regular'
            AND p.visible = 1
        ORDER BY p.id ASC
    ",array(
        ':id'       => $resultProduct['category_id']
    ))->fetchAll();
    $listHostingPlan = array();
    foreach($result as $hostingCommon){
        $listHostingPlan[$hostingCommon['pid']]['pid']      =   $hostingCommon['pid'];
        $listHostingPlan[$hostingCommon['pid']]['name']     =   $hostingCommon['name'];
        $listHostingPlan[$hostingCommon['pid']]['price']    =   array(
            'Monthly'       =>      $hostingCommon['m']
            ,'Quarterly'     =>      $hostingCommon['q']
            ,'Semi-Annually' =>      $hostingCommon['s']
            ,'Annually'       =>      $hostingCommon['a']
            ,'Biennially'       =>      $hostingCommon['b']
            ,'Triennially'       =>      $hostingCommon['t']
        );     
    }
    $this->assign('listHostingPlan', json_encode($listHostingPlan));
    $this->assign('alistHostingPlan', $listHostingPlan);
}

$this->assign('step', $step);
$this->assign('promotion', $resultPromotion['promotion']);
$this->assign('inDomainCart', $_SESSION['domainordercart']);
$this->assign('listDomainOrder', json_encode($_SESSION['domainordercart']['items']));


//echo '<pre>' . print_r($_SESSION['domainordercart'],TRUE) . '</pre>';



