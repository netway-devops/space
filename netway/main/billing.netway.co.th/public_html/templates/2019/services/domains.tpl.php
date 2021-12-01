<?php

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/domainhandle/user/class.domainhandle_controller.php');

// Add Free DNS Services (AUTO) Puttipong Pengprakhon (puttipong at rvglobalsoft.com)
$aClient = hbm_logged_client();

if (count($aClient)>0 && isset($aClient['id']) && $aClient['id'] != '') {
    
    require_once(APPDIR . 'class.general.custom.php');
    require_once(APPDIR . 'class.api.custom.php');
       
    $adminUrl = GeneralCustom::singleton()->getAdminUrl();
    $apiCustom = ApiCustom::singleton($adminUrl . '/api.php');
    
    $post = array(
           'call' => 'module',
           'module' => 'billingcycle',
           'fn' => 'addFreeDNSServices',
           'clientID' => $aClient['id']
    );
    $apiCustom->request($post);
}

if (isset($_GET['filter']['domain']) ) {
    $sorterpage = $this->get_template_vars('sorterpage');
    $perpage    = $this->get_template_vars('perpage');
    $totalpages = $this->get_template_vars('totalpages');
    $aDomains   = array(); //$this->get_template_vars('domains');
    $filter     = $_GET['filter']['domain'];
    $aRequest   = array(
        'filter'    => $filter,
        'page'      => $sorterpage,
        'limit'     => $perpage,
        'totalpages'    => $totalpages
    );
    $result     = domainhandle_controller::singleton()->listDomain($aRequest);
    
    if (count($result['domains'])) {
        foreach ($result['domains'] as $arr) {
            $expire     = strtotime($arr['expires']);
            $expire     = $expire - time();
            $arr['daytoexpire'] = ($expire > 0) ? ceil($expire/(60*60*24)) : 0;
            array_push($aDomains, $arr);
        }
    }
    
    $this->assign('domains', $aDomains);
    $this->assign('sorterpage', $result['page']);
    $this->assign('perpage', $result['limit']);
    $this->assign('totalpages', $result['totalpages']);
    
    $this->assign('totalpages', $result['totalpages']);
    $this->assign('filterDomain', '?filter[domain]=active');
}

/*
$result = $this->get_template_vars();
echo '<pre>'. print_r($result, true) .'</rpe>';exit;
*/

