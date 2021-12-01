<?php error_reporting(E_ALL & ~E_STRICT & ~E_NOTICE);
@session_start();
set_include_path(dirname(__FILE__) . '/pear' . PATH_SEPARATOR . dirname(__FILE__) . '/RvLibs' . PATH_SEPARATOR . get_include_path());
require_once 'PEAR.php';
include_once dirname(__FILE__) . '/RvLibs/RvGlobalStoreApi.php';

define('RVGLOBALSTORE_API_URL', 'http://api.rvglobalsoft.com/apps');
define('RV_APPS_ID', 'hostbill');

$cpUserId = 'cp_2017e59be50b2fab8bf23616b55f2255';

$cpPublickey = '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAunwRbfnJHW+XEXivp4Sn
mc38Us77OvmgLQ8DeNvWlHOHRdrKahSxtWTHA8sGN4cvpaDTtsRIa3NjPob2Vb0X
lxr/8XQthfrnVbJTDprfbyVpYYTdkXw6l1ReKGnQSUoSxbFrIALX1fzrAR3ci2Gj
alOCVaqSySSR+T3YEgfW+0siUXajkTV+Rdyp4Pv4UAzsHm7J7S5rRsBhHNoHnofu
7PFW167+wmINPW8qvRtP3L75lDxcUWyeuOcEPLzUduSdTTzHeMK4NhRy2L5jPa5R
qDtie5Rj3aNdEAL5tvEEyInaG+Cp0wx1wiMjGOePoXr4o/Rh7WguyQB+l9HNVR1I
BQIDAQAB
-----END PUBLIC KEY-----';

/// request_authorizekey
$oAuthAPI = RvLibs_RvGlobalStoreApi::request_authorizekey(RVGLOBALSTORE_API_URL, $cpUserId, $cpPublickey);
echo '<b>Respont call RvLibs_RvGlobalStoreApi::request_authorizekey($rvglobalsoftApiUrl, $cpUserId, $cpPublickey)</b>';
echo '<pre>';
print_r($oAuthAPI);
echo '</pre>';


$oUserConnect = RvLibs_RvGlobalStoreApi::connect(RVGLOBALSTORE_API_URL, $oAuthAPI['authorizeid'], $oAuthAPI['authorizekey']);



$oRes = RvLibs_RvGlobalStoreApi::singleton()->request('get', '/serverinfo', array());
echo '<b>Respont call RvLibs_RvGlobalStoreApi::connect($rvglobalsoftApiUrl, $authorizeid, $authorizekey); <br />RvLibs_RvGlobalStoreApi::singleton()->request(\'get\', \'/serverinfo\', array());</b>';
echo '<pre>';
print_r($oRes);
echo '</pre>';


/*

echo "<hr>";


$oRes2 = RvLibs_RvGlobalStoreApi::singleton()->request('get', '/vipuserinfo', array('action_do' => 'viewlog' , 'cpuser_id' => 'cp_30e35438f118ddf4e20497111de7a0d0'));

echo '<pre>';
print_r($oRes2);
echo '</pre>';
*/
