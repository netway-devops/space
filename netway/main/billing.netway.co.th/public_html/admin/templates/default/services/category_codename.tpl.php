<?php

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}
require_once(APPDIR . 'libs/hbapiwrapper/hbApiWrapper.php');
$oHBApiWrapper = new hbApiWrapper();

$isActiveModuleDBCIntegration = $oHBApiWrapper->moduleIsActive('dbc_integration');
$this->assign('isActiveModuleDBCIntegration', $isActiveModuleDBCIntegration);
