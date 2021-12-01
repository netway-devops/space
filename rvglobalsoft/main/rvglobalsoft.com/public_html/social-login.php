<?php
require('includes/hostbill.php');

// --- hostbill helper ---
$db         = hbm_db();
$api        = new ApiWrapper();
$client     = hbm_logged_client();
// --- hostbill helper ---

use OAuth\OAuth2\Service\Google;
use OAuth\OAuth2\Service\Facebook;
use OAuth\OAuth1\Service\Twitter;
use OAuth\OAuth2\Service\Microsoft;
use OAuth\OAuth2\Service\Linkedin;
use OAuth\OAuth2\Service\Linkedinv2;
use OAuth\Common\Storage\Session;
use OAuth\Common\Consumer\Credentials;

use OAuth\ServiceFactory;
use OAuth\Common\Http\Uri\Uri;

require_once (APPDIR .'libs/PHPoAuthLib-0.8.10/src/OAuth/bootstrap.php');

$servicesCredentials    = array();
$servicesCredentials['google']['key']       = '155526011120-hj0tnej8n0ap1mdconfvvraqbvafumae.apps.googleusercontent.com';
$servicesCredentials['google']['secret']    = '_IS0TmOvaLr_N2u2aDb8iSun';
$servicesCredentials['facebook']['key']     = '475784502447266';
$servicesCredentials['facebook']['secret']  = '61e2aa4b8f0a45f03b2d56d809479eda';
$servicesCredentials['twitter']['key']      = 'pedning verify twitter developer account';
$servicesCredentials['twitter']['secret']   = 'pedning verify twitter developer account';
$servicesCredentials['microsoft']['key']    = '0000000048322833';
$servicesCredentials['microsoft']['secret'] = 'fsglPDG22-)kvgOYQT453}$';
$servicesCredentials['linkedin']['key']     = '81w4qypj0q1ft2';
$servicesCredentials['linkedin']['secret']  = 'Pc9rR8eDzPO2rdHs';

$storage    = new Session();

$currentUri     = new Uri('https://rvglobalsoft.com/social-login.php');
$serviceFactory = new ServiceFactory();

if (isset($_GET['social'])) {
    $social     = $_GET['social'];
    $_SESSION['social'] = $social;
}
$social     = isset($_SESSION['social']) ? $_SESSION['social'] : 'google';
if (isset($_GET['redirectUrl'])) {
    $redirectUrl     = $_GET['redirectUrl'];
    $_SESSION['redirectUrl'] = $redirectUrl;
}
$redirectUrl    = isset($_SESSION['redirectUrl']) ? $_SESSION['redirectUrl'] : 'https://rvglobalsoft.com/index.php?cmd=clientarea';

// Setup the credentials for the requests
$credentials    = new Credentials(
    $servicesCredentials[$social]['key'],
    $servicesCredentials[$social]['secret'],
    $currentUri->getAbsoluteUri()
);

$aData      = array();

switch ($social)
{
    case 'google' : {
        $service    = $serviceFactory->createService($social, $credentials, $storage, array(
            'userinfo_email', 'userinfo_profile'
            ));
        
        if (! empty($_GET['code'])) {
            $state  = isset($_GET['state']) ? $_GET['state'] : null;
            $service->requestAccessToken($_GET['code'], $state);
            $result = json_decode($service->request('userinfo'), true);
            $password   = crypt($result['id'],'st');
            $_SESSION['SSO_profilepicture'] =   $result['picture'];
            $aData  = array(
                'firstname'     => $result['given_name'],
                'lastname'      => $result['family_name'],
                'email'         => $result['email'],
                'password'      => $password,
                'password2'     => $password,
            );
            
        } else {
            $url    = $service->getAuthorizationUri();
            header('Location: ' . $url);
            exit;
        }
        
        break;
    }
    case 'facebook' : {
        $service    = $serviceFactory->createService($social, $credentials, $storage, array());
        
        if (! empty($_GET['code'])) {
            $state  = isset($_GET['state']) ? $_GET['state'] : null;
            $token  = $service->requestAccessToken($_GET['code'], $state);
            $result = json_decode($service->request('/me?fields=id,name,email'), true);
            $aName  = explode(' ', $result['name']);
            $_SESSION['SSO_profilepicture'] =   'https://graph.facebook.com/'.$result['id'].'/picture?type=square';
            $password   = crypt($result['id'],'st');
            $aData  = array(
                'firstname'     => $aName[0],
                'lastname'      => $aName[1],
                'email'         => $result['email'],
                'password'      => $password,
                'password2'     => $password,
            );
            
        } else {
            $url    = $service->getAuthorizationUri();
            header('Location: ' . $url);
            exit;
        }
        
        break;
    }
    case 'microsoft' : {
        $service    = $serviceFactory->createService($social, $credentials, $storage, array('basic', 'contacts_emails'));
        
        if (! empty($_GET['code'])) {
            $token  = $service->requestAccessToken($_GET['code']);
            $accessToken    = $token->getAccessToken();
            $url    = 'https://apis.live.net/v5.0/me?'. http_build_query(array(
                'access_token' => $accessToken,
                ));
            $result = (array) json_decode(file_get_contents($url));
            $result['email']    = isset($result['emails']->account) ? $result['emails']->account : '';
            
            $urlphoto    = 'https://apis.live.net/v5.0/me/picture?'. http_build_query(array(
                'access_token' => $accessToken,
                ));
                
            $img = file_get_contents($urlphoto);
            $file = MAINDIR.'socialavatar/'.$result['id'].'.jpg';
            file_put_contents($file, $img);
            $_SESSION['SSO_profilepicture'] =   'https://rvglobalsoft.com/socialavatar/'.$result['id'].'.jpg';
            
            $password   = crypt($result['id'],'st');
            $aData  = array(
                'firstname'     => $result['first_name'],
                'lastname'      => $result['last_name'],
                'email'         => $result['email'],
                'password'      => $password,
                'password2'     => $password,
            );
            
        } else {
            $url    = $service->getAuthorizationUri();
            header('Location: ' . $url);
            exit;
        }
        
        break;
    }
    case 'linkedin' : {
         $service    = $serviceFactory->createService('Linkedinv2', $credentials, $storage, array('r_liteprofile', 'r_emailaddress'));
        
        if (! empty($_GET['code'])) {
            $state  = isset($_GET['state']) ? $_GET['state'] : null;
            $token  = $service->requestAccessToken($_GET['code'], $state);
            
            $result = json_decode($service->request('/me'), true);
            $result['firstName']    = $result['localizedFirstName'];
            $result['lastName']     = $result['localizedLastName'];
            
            $password   = crypt($result['id'],'st');
            $aData  = array(
                'firstname'     => $result['firstName'],
                'lastname'      => $result['lastName'],
                'email'         => $result['email'],
                'password'      => $password,
                'password2'     => $password,
            );
            
            $result = json_decode($service->request('/emailAddress?q=members&projection=(elements*(handle~))'), true);
            $result['email']    = isset($result['elements'][0]['handle~']['emailAddress']) ?
                        $result['elements'][0]['handle~']['emailAddress'] : '';
            $aData['email']     = $result['email'];
            
        } else {
            $url    = $service->getAuthorizationUri();
            header('Location: ' . $url);
            exit;
        }
        
        break;
    }
}

if (! isset($result['email'])) {
    header('Location: index.php?line='. __LINE__);
    exit;
}

$email      = $result['email'];
$rawData    = $result;

$result     = $db->query("
    SELECT cd.*, ca.email, ca.group_id
    FROM hb_client_access ca,
        hb_client_details cd
    WHERE ca.email = :email
        AND ca.id = cd.id
    ORDER BY ca.id ASC
    LIMIT 1
    ", array(
        ':email'    => $email
    ))->fetch();

if (! isset($result['id'])) {
   $result  = $api->addClient($aData);
    if (! isset($result['client_id'])) {
        
        $subject    = $email .' ไม่สามารถสมัครเข้าใช้งานเว็บไซต์ rvglobalsoft.com ได้';
        $message    = "
        
        Social login : ". $social ."
        ==================================================
        ". print_r($rawData, true) ."
        
        ";
        $header     = 'MIME-Version: 1.0' . "\r\n" .
                'Content-type: text/plain; charset=utf-8' . "\r\n" .
                'From: ' . $email . "\r\n" .
                'Reply-To: ' . $email . "\r\n" .
                'X-Mailer: PHP/' . phpversion();
        $mailto     = 'sales@rvglobalsoft.com';
        @mail($mailto, $subject, $message, $header);
        
        header('Location: index.php?line='. __LINE__);
        exit;
    }
}

$duration   = '180';    //Time in seconds for how long user login link will work
$secret     = '9b03d002-5096-4e6b-af11-f84d6c41e601'; //Secret code set in module configuration (in previous step)
$hash       = md5($email.$secret.$duration); //Verification string

$data       = http_build_query([
    'email'     => $email,
    'duration'  => $duration,
    'hash'      => $hash,
    'redirect'  => $redirectUrl, //optional
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
        
        $result     = $db->query("
            SELECT id
            FROM hb_admin_details
            WHERE email = :email
                AND email != 'prasit@rvglobalsoft.com'
            ", array(
                ':email'    => $email
            ))->fetch();
        if (isset($result['id'])) {
            echo '<br><h3 style="text-align: center;color:##000000;">คุณไม่สามารถทำ Social Login ได้เนื่องจาก Email ของคุณเป็น Staff </h3><h4 style="text-align: center;color: #be0812;">กรุณาตรวจสอบ Email ใหม่!</h4>';
            
            exit;   
        }
        
        header('Location: '. $liginUrl);
        exit;
        
   }
}


header('Location: index.php?line='. __LINE__);
exit;

//echo '<pre>'. print_r($result, true) .'</pre>';

