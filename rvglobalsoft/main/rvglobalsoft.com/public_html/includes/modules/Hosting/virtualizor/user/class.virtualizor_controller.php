<?php

/**
 *
 */
class Virtualizor_Controller extends HBController {

    /**
     * @var Virtualizor
     */
    var $module;
    protected $section;

    protected function belongsToMe($vpsid, $service) {
        $c = new Clientarea_Model();
        $service = $c->getServiceDetails($service);
        if (empty($service))
            return false;
        if (!empty($service['veid']) && $service['veid'] == $vpsid)
            return true;
        if (isset($service['extra']['vps'][$vpsid]))
            return true;
        $vm = $this->module->getUserVM();
        foreach ($vm as $v)
            if ($v['veid'] == $vpsid)
                return true;
        return false;
    }

    public function accountdetails($params) {

        $this->template->assign('commontpl', MAINDIR . 'templates' . DS . 'common' . DS . 'cloudhosting' . DS);
        $this->template->assign('commondir', MAINDIR . 'templates' . DS . 'common' . DS . 'cloudhosting' . DS);

        $this->clientareapath = APPDIR_MODULES
                . $this->module->getModuleType()
                . DS . strtolower($this->module->getModuleName())
                . DS . 'templates' . DS . 'clientarea' . DS;
        $this->template->assign('onappdir', $this->clientareapath);
        Engine::singleton()->getObject('language')->addTranslation('onapp');
        //$this->template->assign('vpsdo', 'overview.cloud');
        $extra = $params['account'];
        if ($extra['status'] == 'Active' && $params['vpsdo'] != 'billing') {
            $this->setupModule($params['service']);
            
            if (is_callable(array($this, 'singlevm_' . $params['vpsdo']))) {
                $this->{'singlevm_' . $params['vpsdo']}($params);
            } else {
                $this->singlevm_default($params);
            }

            $this->template->assign('s_vm', $this->session2vm());
            $this->template->assign('o_sections', array(
                'o_rebuild' => true,
                'o_reboot' => true,
                'o_startstop' => true,
            ));
        } else {
            $this->billing($params);
        }

        $this->template->assign('provisioning_type', $params['account']['options']['type'] == "multi" ? 'cloud' : ( $params['account']['options']['type'] == 'reseller' ? 'reseller' : 'single' ) );
        $ovps = $this->template->get_template_vars('vpsdo');
        $this->template->assign('vpsdo', isset($params['vpsdo']) ? Registrator::paranoid($params['vpsdo']) : false);
        $this->template->assign('vpsid', isset($params['vpsid']) ? Registrator::paranoid($params['vpsid']) : false);

        $this->section = empty($this->section) ? 'vmdetails' : $this->section;
        $this->template->showtpl = $this->clientareapath . $this->section;
        $this->template->assign('vmsection', $this->section);
    }

    protected function billing(&$params) {
        $params['vpsdo'] = 'billing';
        $this->section = 'billing';
    }

    protected function singlevm_shutdown($params) {
        if ($params['token_valid'])
            $this->module->PowerOff();
        Engine::addInfo("Shutdown signal has been sent to the VPS");
        Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
    }

    protected function singlevm_startup($params) {
        if ($params['token_valid'])
            $this->module->PowerON();
        Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
    }

    protected function singlevm_reboot($params) {
        if ($params['token_valid'])
            $this->module->Reboot();
        Engine::addInfo('Restart signal has been sent to the VPS');
        Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
    }

    protected function singlevm_reinstall($params) {

        $this->section = 'vmdetails';
        if ($params['changeos'] && $params['token_valid']) {
            if ($this->module->Reinstall($params['os']))
                HBConfig::storeSetting(array(), '_virtualizor'); {
                $c = HBLoader::LoadModel('Clientarea');
                //$iid = $c->billForOSTemplate($params['service'], $params['os'], $params['account']['options']['type'] == "single");
                $iid = OSLicenses::billingSingle($params['service'], $params['os']);

                if ($iid) {
                    Utilities::redirect('?cmd=clientarea&action=invoice&id=' . $iid);
                } else {
                    Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
                }
            }
        } else {
            $os = $this->getOSTemplates($params);
            $this->template->assign('distributions', $this->getDistributions($os));
            $this->template->assign('ostemplates', $os);
        }
    }
    
    protected function singlevm_console($params) {
        $this->section = 'vmdetails';
        $console = $this->module->getConsoleInfo();

        if ($console && !empty($console['port'])) {
            $this->template->assign('console', $console);
        } else {
            Engine::addError('There were errors while launching the VNC Viewer. It could be disabled for this VPS');
            Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
        }
    }

    protected function singlevm_upgrade($params) {
        $this->section = 'vmdetails';
        $c = HBLoader::LoadModel('Clientarea');
        $upg = $c->getServiceUpgrades($params['service']);
        if ($upg === -1) {
            //invoice is unpaid for this service
            Engine::addError('upgrade_due_invoice');
            Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
        }

        if (empty($upg)) {
            Engine::addError('Its not possible to upgrade this package at this moment. Please contact us to change your resource limits.');
            Utilities::redirect('?cmd=clientarea&action=services&service=' . $params['service']);
        }
    }

    protected function singlevm_default($params) {
        $this->section = 'vmdetails';
        $extra = $params['account'];

        $vpsinfo = $this->session2vm();
        if (!is_array($vpsinfo))
            $vpsinfo = array();
        
        $vpsinfo = array_merge($vpsinfo, $this->module->getUserVM());
        $this->vm2session($vpsinfo);

        $this->template->assign('vpsdo', 'details');
        if ($params['vpsdo'] == 'vmactions') {
            $this->section = 'vmactions';
        }

        $this->template->assign('vpsdetails', $vpsinfo);
        $this->template->assign('VMDetails', $vpsinfo);

        if (Controller::isAjax() && isset($params['status'])) {
            $this->template->assign('service_id', $params['account']['id']);
            $this->template->assign('vpsid', $params['vpsid']);
            $this->template->display(APPDIR_MODULES
                    . $this->module->getModuleType()
                    . DS . strtolower($this->module->getModuleName())
                    . DS . 'templates' . DS . 'clientarea'
                    . DS . 'ajax.vmstatus.tpl');
            die();
        }
    }

    protected function setupModule($service) {
        $a = HBLoader::LoadModel('Accounts');
        $data = $a->getAccount($service);
        $account_config = array();
        $account_config = $a->getAccountModuleConfig($service);

        $s = HBLoader::LoadModel('Servers');
        $servdata = $s->getServerDetails($data['server_id']);
        $this->module->connect($servdata);

        $this->module->setAccountConfig($account_config);
        $this->module->setAccount($data);
        $this->module->addUser($data['username'], $data['password'], Utilities::getClientEmail($data['client_id']));
    }

    protected function getOSTemplates($params) {
        $os = $this->module->api->images()->getAll();

        $c = HBLoader::LoadModel('Clientarea');

        if ($os->images) {
            //check if client have limits.
            $dd = $c->getAvailableOSTemplates($params['service']);
            $temp = array();
            if ($dd) {
                foreach ($os->images as $image /* $tname => $type */) {
                    if (isset($dd[$image->id])) {
                        $tmp = $dd[$image->id];
                        $tmp['distro'] = $image->distribution;
                        $tmp['family'] = $this->isWindowsOS($image->distribution) ? 'windows' : 'linux';
                        $temp[] = $tmp;
                    }
                }
            } else {
                foreach ($os->images as $image) {
                    $temp[] = array('0' => $image->id, '1' => $image->name, '2' => 0, 'distro' => $image->distribution, 'family' => $this->isWindowsOS($image->distribution) ? 'windows' : 'linux');
                }
            }
            $os = $temp;
        }
        return $os;
    }

    protected function getDistributions(&$list) {
        $distros = array();
        foreach ($list as $t => $os) {
            $osname = $os['distro'];
            if ($this->isWindowsOS($osname)) {
                $distros['windows'][] = $osname;
            } else {
                $distros['linux'][] = $osname;
            }
        }
        $distros['linux'] = array_unique($distros['linux']);
        $distros['windows'] = array_unique($distros['windows']);
        return $distros;
    }

    protected function isWindowsOS($ostpl) {
        if (preg_match('!winxp|win\d|windows|w2k!i', $ostpl))
            return true;
        return false;
    }

    protected function searchDistro($ostpl) {
        $distro = array('debian', 'ubuntu', 'centos', 'rhel', 'fedora', 'gentoo', 'linux', 'windows');
        foreach ($distro as $dis) {
            if (stristr($ostpl, $dis)) {
                return $dis;
            }
        }
        if ($this->isWindowsOS($ostpl)) {
            return 'windows';
        } else {
            return 'linux';
        }
    }

    protected function vm2session($vm) {
        $vmodl = HBConfig::getSetting('_virtualizor');
        if (!is_array($vmodl))
            $vmodl = array();
        $vm = array_merge($vmodl, $vm, array(
            'distro' => strtolower($vm['os']['distro']),
            'hostname' => $vm['hostname'],
            'time' => time()
        ));
        HBConfig::storeSetting($vm, '_virtualizor');
    }

    protected function session2vm() {
        //$vms = HBConfig::getSetting('_virtualizor');
        return HBConfig::getSetting('_virtualizor');
    }

}