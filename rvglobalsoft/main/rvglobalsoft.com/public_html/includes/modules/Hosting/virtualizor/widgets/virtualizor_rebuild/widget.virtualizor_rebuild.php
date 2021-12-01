<?php

class Widget_virtualizor_rebuild extends HostingWidget {

    protected $widgetfullname = "Reload OS";
    protected $description = "Allow clients to change their os.";
    protected $info = array(
        'replacetpl' => 'os.tpl',
        'options' => ServicesWidget::OPTION_UNIQUE_DEFAULT
    );

    public function controller($service, Virtualizor &$module, Template &$smarty, &$params) {
        $smarty->assign('vpsdo', 'reinstall');
        if ($params['changeos'] && $params['token_valid']) {
            if ($module->Reinstall($params['os'])) {
                Engine::addInfo('VPS reinstall scheduled');
                $c = HBLoader::LoadModel('Clientarea');
                //$iid = $c->billForOSTemplate($params['service'], $params['os'], $params['account']['options']['type'] == "single");
                $iid = OSLicenses::billingSingle($params['service'], $params['os']);
                if ($iid) {
                    Utilities::redirect('?cmd=clientarea&action=invoice&id=' . $iid);
                } else {
                    Utilities::redirect('?cmd=clientarea&action=services&vpsdo=vmdetails&service=' . $params['service'] . '&vpsid=' . $params['vpsid']);
                }
            }
        }
        $os = $this->getOSTemplates($service['id'], $module);
        $smarty->assign('distributions', $this->getDistributions($os));
        $smarty->assign('ostemplates', $os);
    }

    protected function getOSTemplates($service, Virtualizor $module) {
        $vpsinfo = $module->getUserVM();
        $type = $vpsinfo['virt'];
        $type = $vpsinfo['hvm'] == 1 ? $type . 'hvm' : $type;
        $os = $module->getOSTemplates($type);

        $c = HBLoader::LoadModel('Clientarea');

        if (isset($os[$type]) && !empty($os[$type])) {
            //check if client have limits.
            $dd = $c->getAvailableOSTemplates($service);
            $temp = array();
            if ($dd) {
                foreach ($os[$type] as $templ) {
                    if (isset($dd[$templ['id']])) {
                        $dd[$templ['id']][3] = $templ['distro'];
                        $temp[] = $dd[$templ['id']];
                    }
                }
            } else {
                foreach ($os[$type] as $templ) {
                    $temp[] = array($templ['id'], $templ['name'], 0, $templ['distro']);
                }
            }

            $os = $temp;
        }
        return $os;
    }

    protected function getDistributions(&$list) {
        $distros = array();
        foreach ($list as $o => $os) {
            if ($this->isWindowsOS($os[3])) {
                $distros['windows'][] = $os[3];
                $list[$o] = array_merge($os, array('distro' => $os[3], 'family' => 'windows'));
            } else {

                if (!in_array($os[3], $distros['linux']))
                    $distros['linux'][] = $os[3];
                $list[$o] = array_merge($os, array('distro' => $os[3], 'family' => 'linux'));
            }
        }
        return $distros;
    }

    protected function isWindowsOS($ostpl) {
        if (preg_match('!winxp|win\d|windows|w2k!i', $ostpl))
            return true;
        return false;
    }

}
