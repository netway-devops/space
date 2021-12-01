<?php
/*
* HOSTBILL CONFIGURATION: BASIC SETTINGS:
*/

if (! function_exists('getENVConfig')) {
    function getENVConfig($aEnvData, $key)
    {
        $result   = (isset($aEnvData[$key]) && $aEnvData[$key]) ? $aEnvData[$key] : '';
        return $result;
    }
}

# HostBill by default have error_reporting turned off,
# so on critical error it will render blank page.
# While developing set enable_debug to true will display more errors on the screen.
$enable_debug = getENVConfig($aEnvData, 'enable_debug');

$path_env = dirname(dirname(__DIR__)).'/.env';
$aEnvData = file_exists($path_env) ? parse_ini_file($path_env) : [];

// Database host / default: localhost
$db_host = getENVConfig($aEnvData, 'db_host');
// Database name
$db_name = getENVConfig($aEnvData, 'db_name');
 // Database username
$db_user = getENVConfig($aEnvData, 'db_user');
 // Database password
$db_pass = getENVConfig($aEnvData, 'db_pass');
// Please enter here Credit Card Encryption Hash used to encode credit cards details in Database. Use only ASCII letters and digits
$ccEncryptionHash = getENVConfig($aEnvData, 'ccEncryptionHash');
// Note, hash above has been automatically generated during installation.
// Please copy it into safe place or use your value.
$config['HBCache.Driver'] = 'memcached';
$config['HBCache.Memcached.host'] = '127.0.0.1';
$config['HBCache.Memcached.port'] = 11211;

 /*
  * ADVANCED SETTINGS:
  */

// Additional security settings:  http://wiki.hostbillapp.com/index.php?title=Additional_security
//Admininstrator folder name, default is admin
 $hb_admin_folder='7944web';
 //Absolute location of templates_c dir - leave false for default
 $hb_templates_c_dir = getENVConfig($aEnvData, 'hb_templates_c_dir');
 //Absolute location of attachments dir - leave false for default
 $hb_attachments_dir = getENVConfig($aEnvData, 'hb_attachments_dir');
 //Absolute location of downlods dir - leave false for default
 $hb_downloads_dir = getENVConfig($aEnvData, 'hb_downloads_dir');
 // Advanced DB settings:
 //Database Port
$db_port = getENVConfig($aEnvData, 'db_port');
 //Database Engine - mysql is default
$db_engine = getENVConfig($aEnvData, 'db_engine');

define('BILLING_URL', getENVConfig($aEnvData, 'billing_url'));
define('CMS_URL', getENVConfig($aEnvData, 'cms_url'));
define('CRM_URL', getENVConfig($aEnvData, 'crm_url'));
define('CRISP_URL', getENVConfig($aEnvData, 'crisp_url'));
define('HOSTBILL_ATTACHMENT_DIR', $hb_attachments_dir);

/**
 * CUSTOM CONFIGURATION
 * กำหนดค่าไว้ใช้ภายในโปรแกรม hostbill ทั้งเว็บ ปกติจะใช้ define
 */

 if (! isset($_SESSION['aUserRuntime'])) {
    $_SESSION['aUserRuntime']   = array();
}
$_SESSION['aUserRuntime'][]     = date('Y-m-d H:i:s', (time() + (7*60*60)));
if (count($_SESSION['aUserRuntime']) > 100) {
    $_SESSION['aUserRuntime']   = array();
}

$_SESSION['userRequestTime']    = microtime(true);
