<?php

/* @var $this OnAppCloud */
/* @var $params array */
/* @var $smarty Template */

Engine::singleton()->getObject('language')->addTranslation('onapp');

$onappdir = MAINDIR . 'includes' . DS . 'types' . DS . 'vmware5type' . DS . 'clientarea' . DS;
$reselldir = MAINDIR . 'includes' . DS . 'types' . DS . 'vmware5type' . DS . 'clientarea' . DS;
$smarty->assign('onappdir', $onappdir);
$smarty->assign('reselldir', $reselldir);
$smarty->assign('provisioning_type', 'single');


if (isset($_SESSION['my_rspace_distro'])) {
    $smarty->assign('vmdistro', $_SESSION['my_rspace_distro']);
}

if (isset($_SESSION['my_rspace_hostname'])) {
    $smarty->assign('vmhostname', $_SESSION['my_rspace_hostname']);
}

$section = false;
if ($params['vpsdo'] != 'billing' && $extra['status'] == 'Active') {



    $module = ModuleFactory::singleton()->getModuleById($extra['module']);
    /* @var $module RackSpaceCloud */
    if (is_null($module)) {
        return false;
    }
    $c = HBLoader::LoadModel('Clientarea');
    $s = HBLoader::LoadModel('Servers');
    $servdata = $s->getServerDetails($extra['server_id']);
    $servdata = $module->connect($servdata);

    $servdetails = ($servdata['host'] != '') ? $servdata['host'] : $servdata['ip'];
    $a = HBLoader::LoadModel('Accounts');
    $data = $a->getAccount($params['service']);
    $account_config = array();
    $account_config = $a->getAccountModuleConfig($params['service']);
    $module->setAccountConfig($account_config);

    $module->setAccount($data);
    $module->addUser($data['username'], $data['password'], Utilities::getClientEmail($data['client_id']));
    if (isset($params['vpsid'])) {
        $extra = array_merge($extra, array('machine_id' => $params['vpsid']));
        if (isset($params['vpsid']) && $params['vpsid'] != $data['extra_details']['option6']) {
            //theft protect 1
            Utilities::redirect('?cmd=clientarea&action=services&vpsdo=vmdetails&service=' . $params['service']);
        }
    }

    $smarty->assign('vpsdo', isset($params['vpsdo']) ? Registrator::paranoid($params['vpsdo']) : false);
    $smarty->assign('vpsid', isset($params['vpsid']) ? Registrator::paranoid($params['vpsid']) : false);
    if (isset($params['vpsid']) && $params['vpsdo'] != 'upgrade') {
        switch ($params['vpsdo']) {


            case 'reboot':
                $module->PrepareSpecific($extra);
                if ($params['token_valid'])
                    $module->Reboot();
                Utilities::redirect('?cmd=clientarea&action=services&vpsdo=vmdetails&service=' . $params['service'] . '&vpsid=' . $params['vpsid']);
                break;

            case 'poweroff':
                $module->PrepareSpecific($extra);
                if ($params['token_valid'])
                    $module->Stop();
                Utilities::redirect('?cmd=clientarea&action=services&vpsdo=vmdetails&service=' . $params['service'] . '&vpsid=' . $params['vpsid']);
                break;
            case 'hardpoweroff':
                $module->PrepareSpecific($extra);
                if ($params['token_valid'])
                    $module->Stop();
                Utilities::redirect('?cmd=clientarea&action=services&vpsdo=vmdetails&service=' . $params['service'] . '&vpsid=' . $params['vpsid']);
                break;
            case 'poweron':
                $module->PrepareSpecific($extra);
                if ($params['token_valid'])
                    $module->Start();
                Utilities::redirect('?cmd=clientarea&action=services&vpsdo=vmdetails&service=' . $params['service'] . '&vpsid=' . $params['vpsid']);
                break;

            case 'vmactions':
            default:

                $section = 'vmdetails';
                $module->PrepareSpecific($extra);
                $vpsinfo = $module->getVMDetails();
                $vpsinfo['hostname']=$data['domain'];

                $this->updateVMDetails($extra['id'], $vpsinfo);

                if (isset($vpsinfo['guset'])) {
                    $_SESSION['my_rspace_distro'] = $vpsinfo['guset']['os_version']['distro'];
                }
                $_SESSION['my_rspace_hostname'] = $vpsinfo['name_label'];

                $smarty->assign('vpsdetails', $vpsinfo);
                $smarty->assign('VMDetails', $vpsinfo);
                $smarty->assign('vpsdo', 'details');
                if ($params['vpsdo'] == 'vmactions') {
                    $smarty->showTpl($reselldir . 'vmactions.tpl');
                    return;
                }

                break;
        }
    } else {
        switch ($params['vpsdo']) {
            case 'upgrade':
                $section = 'vmdetails';


                $upg = $c->getServiceUpgrades($params['service']);
                if ($upg === -1) {
                    //invoice is unpaid for this service
                    $this->addError('upgrade_due_invoice');
                    Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
                }
                $fieldupgrades = $c->getConfigFieldsUpgrades($extra['custom'], $extra);
                foreach ($fieldupgrades as $fid => $fv) {
                    if ($fv['variable'] == 'os')
                        unset($fieldupgrades[$fid]);
                }
                if (empty($upg) && empty($fieldupgrades)) {
                    $this->addError('Its not possible to upgrade this package at this moment. Please contact us to change your resource limits.');
                    Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
                }

                $smarty->assign('upgrades', $upg);
                $smarty->assign('fieldupgrades', $fieldupgrades);
                break;

            default:

                Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service'] . '&vpsdo=vmdetails&vpsid=' . $data['extra_details']['option6']);

                break;
        }
    }
} else {
    $params['vpsdo'] = 'billing';


    $section = 'billing';
    $smarty->assign('vpsdo', $params['vpsdo']);
    $smarty->assign('vpsid', isset($params['vpsid']) ? $params['vpsid'] : false);
}

if ($section) {
    $smarty->showTpl($reselldir . $section);
    $smarty->assign('vmsection', $section);
}
