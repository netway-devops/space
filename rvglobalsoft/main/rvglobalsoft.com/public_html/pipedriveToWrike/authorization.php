<?
    include_once 'allkey.php';
    include_once 'ln_wrike_class.php';
    $aa = new LN_WRIKE($secret,$api,$access_token,$access_token_secret);
    if(isset($_GET['oauth_token'])){
        $aa->getAccessToken($_GET['oauth_token'],$_GET['oauth_token_secret']);
    }
    else if(isset($_GET['access_token'])){
        echo "access_token : <input type='text' value='".$_GET['access_token']."'><br>";
        echo "access_token_secret : <input type='text' value='".$_GET['access_token_secret']."'><br>";
    }
    else{
        $aa->getRequestToken();
    }