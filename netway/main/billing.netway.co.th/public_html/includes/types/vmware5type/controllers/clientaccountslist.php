<?php

/* @var $this OnAppCloud */
/* @var $params array */
/* @var $smarty Template */

if (isset($params['make']) && $params['make'] == 'loadvmstatus') {
    $smarty->assign('account_id', $params['vmid']);
    $smarty->assign('status', $this->_getVMStatus($params['vmid']));
    $smarty->showTpl(MAINDIR . 'includes' . DS . 'types' . DS . 'vmware5type' . DS . 'clientarea' . DS . 'vmstatus.tpl');
    return;
}

if (isset($params['make']) && strstr($params['make'], 'power')) {
    $smarty->assign('account_id', $params['vmid']);
    $smarty->assign('status', $this->_setVMStatus($params['vmid'], $params['make']));
    $smarty->showTpl(MAINDIR . 'includes' . DS . 'types' . DS . 'vmware5type' . DS . 'clientarea' . DS . 'vmstatus.tpl');
    return;
}
//1. get product type
//extra = services list returned from $this->listClientAccounts($cid);
if (!empty($extra)) {
    $a = $extra[0];
    if (count($extra) == 1) {
        Utilities::redirect('?cmd=clientarea&action=services&service=' . $a['id']);
    }
}
return;
