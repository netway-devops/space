<?php

// Depending on HostBill application.
if ( ! defined('HBF_APPNAME')) {
    exit;
}

require_once(APPDIR . 'modules/Site/domainhandle/user/class.domainhandle_controller.php');


if (isset($_GET['filter']['domain'])) {
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
            $arr['isExpired']   = (strtotime($arr['expires']) < strtotime('-30 days')) ? 1 : 0;
            array_push($aDomains, $arr);
        }
    }
    
    $this->assign('filter', $_GET['filter']['domain']);
    $this->assign('domains', $aDomains);
    $this->assign('sorterpage', $result['page']);
    $this->assign('perpage', $result['limit']);
    $this->assign('totalpages', $result['totalpages']);
    
}








