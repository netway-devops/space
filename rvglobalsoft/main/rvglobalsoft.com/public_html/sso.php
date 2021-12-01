<?php
require('includes/hostbill.php');

// --- hostbill helper ---
$client     = hbm_logged_client();
$db         = hbm_db();
$api        = new ApiWrapper();
// --- hostbill helper ---

require_once(APPDIR .'libs/php-jwt-1.0.0/Authentication/JWT.php');


/*
 * https://rvglobalsoft.com/sso.php
 * Post {
 *  token {
 *      email
 *      clientid
 *  }
 *  redirect = https://rvglobalsoft.com/clientarea/invoice/51437
 * }
 * 
 * 9b03d002-5096-4e6b-af11-f84d6c41e601
 * 
*/

$request    = $_POST;
$key        = '9b03d002-5096-4e6b-af11-f84d6c41e601';
$token      = isset($request['token']) ? $request['token'] : '';
$redirect   = isset($request['redirect']) ? $request['redirect'] : '';

$jwt        = JWT::decode($token, $key, array('HS256'));

if (isset($jwt->clientid) && isset($jwt->email)) {
    
    $result     = $db->query("
        SELECT *
        FROM hb_client_access
        WHERE id = '{$jwt->clientid}'
            AND email = '{$jwt->email}'
        ")->fetch();
    if (! isset($result['id'])) {
        exit;
    }
    
    
    $email      = $jwt->email;
    
    $duration   = '180';    //Time in seconds for how long user login link will work
    $secret     = $key; //Secret code set in module configuration (in previous step)
    $hash       = md5($email.$secret.$duration); //Verification string
    
    $data       = http_build_query([
        'email'     => $email,
        'duration'  => $duration,
        'hash'      => $hash,
        'redirect'  => $redirect, //optional
    ]); //data to post
    
    $ch         = curl_init();
    curl_setopt($ch, CURLOPT_URL, 'https://rvglobalsoft.com/index.php?cmd=autologin&action=login');
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    $result     = curl_exec($ch);
    //die('Error: "' . curl_error($ch) . '" - Code: ' . curl_errno($ch));
    curl_close($ch);
    
    if ($result) {
        $result = json_decode($result, true);
       if ($result['success']) {
            $liginUrl   = $result['login_url'];  //url to link customer to HostBill
            $token      = $result['token']; //token we can use to log user out
            unset($_SESSION['redirectUrl']);
            
            header('Location: '. $liginUrl);
            exit;
            
       }
    }

    
}






