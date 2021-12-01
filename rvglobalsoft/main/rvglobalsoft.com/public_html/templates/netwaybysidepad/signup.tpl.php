<?php
// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

// --- hostbill helper ---
$api            = new ApiWrapper();
$db             = hbm_db();
$client         = hbm_logged_client();
// --- hostbill helper ---

$isSecure   = false;
if (isset($_POST['g-recaptcha-response'])) {
    $code   = $_POST['g-recaptcha-response'];
    $data   = array(
        'secret'    => '6LeCWWcUAAAAADc-CnPlyCzAwnRAxr3AnW49UfWC',
        'response'  => $code
    );
    
    $curl       = curl_init();
    curl_setopt($curl, CURLOPT_URL, 'https://www.google.com/recaptcha/api/siteverify');
    curl_setopt($curl, CURLOPT_POST, true);
    curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($data));
    //curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    $result     = curl_exec($curl);
    curl_close($curl);
    
    $result = json_decode($result, true);
    
    if (isset($result['success']) && $result['success']) {
        $isSecure   = true;
    }
    
}
$this->assign('isSecure', $isSecure);

//echo '<pre>' .print_r($result, true) .'</pre>';

