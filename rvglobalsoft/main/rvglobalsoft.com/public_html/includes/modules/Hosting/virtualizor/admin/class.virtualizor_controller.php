<?php

class Virtualizor_Controller extends HBController {

    /**
     * @var Virtualizor
     */
    public $module;

    public function beforeCall($params) {
        
    }

    function accountdetails($params) {
        $typetemplates = array();
        $typetemplates['adminaccounts']['details']['replace'] = APPDIR_MODULES
                . $this->module->getModuleType()
                . DS . strtolower($this->module->getModuleName())
                . DS . 'templates' . DS . 'adminarea'
                . DS . 'account.tpl';
        $this->adminareatpl = $typetemplates['adminaccounts']['details']['replace'];
        $this->template->assign('typetemplates', $typetemplates);
        $this->template->assign('moduletpldir', APPDIR_MODULES
                . $this->module->getModuleType()
                . DS . strtolower($this->module->getModuleName())
                . DS . 'templates' . DS . 'adminarea' . DS);

        if (isset($params['vpsdo']) && is_callable(array($this, 'vpsdo_' . $params['vpsdo']))) {
            $this->setupModule($params['id']);
            $this->{'vpsdo_' . $params['vpsdo']}($params);
            $this->template->assign('vpsdo', $params['vpsdo']);
            //$this->template->assign('solusurl', $this->module->getPanelLoginUrl());
        }
    }

    private function vpsdo_clientsvms($params) {

        $vm = $this->module->getUserVM();
        $this->template->assign('vm', empty($vm) ? false : $vm);
        $this->template->assign('moduleid', $this->module->getModuleId());
        $this->template->showtpl = $this->adminareatpl;
        return;
    }

    protected function vpsdo_shutdown($params) {
        if ($params['token_valid'])
            if ($this->module->PowerOff($params['vpsid'])) {
                Engine::addInfo('Server stopped');
            }
    }

    protected function vpsdo_startup($params) {
        if ($params['token_valid'])
            if ($this->module->PowerON($params['vpsid'])) {
                Engine::addInfo('Server started');
            }
    }

    protected function vpsdo_reboot($params) {
        if ($params['token_valid'])
            if ($this->module->Reboot()) {
                Engine::addInfo('Server rebooted');
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

    public function productdetails($params) {
        $this->template->assign('customconfig', APPDIR_MODULES
                . $this->module->getModuleType()
                . DS . strtolower($this->module->getModuleName())
                . DS . 'templates' . DS . 'adminarea'
                . DS . 'productconfig.tpl');
        $this->template->assign('module_templates', APPDIR_MODULES
                . $this->module->getModuleType()
                . DS . strtolower($this->module->getModuleName())
                . DS . 'templates' . DS . 'adminarea' . DS);

        if (isset($params['server_id'])) {
            $s = HBLoader::LoadModel('Servers');
            $this->module->connect($s->getServerDetails($params['server_id']));
        }

        switch ($params['make']) {
            case 'loadoptions': $this->load_options($params);
                break;
            case 'importformel': $this->load_form($params);
                break;
            case 'updateostemplates': $this->update_ostemplates($params);
                break;
            default: break;
        }

        if (Controller::isAjax()) {
            $this->template->assign('make', $params['make']);
            $this->template->render(APPDIR_MODULES
                    . $this->module->getModuleType()
                    . DS . strtolower($this->module->getModuleName())
                    . DS . 'templates' . DS . 'adminarea'
                    . DS . 'ajax.productconfig.tpl');
        }
        return true;
    }

    protected function update_ostemplates($params) {
        if ($params['id'] == 'new') {
            Engine::addError("Please save your product first");
            return;
        }
        $cx = HBLoader::LoadModel('ConfigFields');
        $c = $cx->getField($params['fid']);
        if (!$c || !$c['items'])
            return;

        if (!empty($params['other']) && is_string($params['other'])) {
            parse_str($params['other'], $params['other']);
        }

        $type = 'all';
        if (isset($params['other']['options']) && is_array($params['other']['options']) && isset($params['other']['options']['vpstype'])) {
            $type = $params['other']['options']['vpstype'];
        }

        $os = $this->module->getOSTemplates($type);
        if (!$os) {
            Engine::addError("Unable to fetch OS Templates list");
            return;
        }

        foreach ($os[$type] as $k=>$o) {
            foreach ($c['items'] as $item) {
                if ($o['id'] == $item['variable_id']) {
                    unset($os[$type][$k]);
                }
            }
        }
        $cnt = 0;
        if (!empty($os[$type])) {
            foreach ($os[$type] as $val) {
                $cnt++;
                $cx->addField(array(
                    'category_id' => $params['fid'],
                    'name' => $val['name'],
                    'variable_id' => $val['id']
                ));
            }

            Engine::addInfo("Os templates list has been updated with {$cnt} new items");
        }
    }

    protected function load_form($params) {

        if ($params['id'] == 'new') {
            Engine::addError("Please save your product first");
            return;
        }

        $f = HBLoader::LoadModel('ConfigFields');
        Engine::singleton()->getObject('language')->addTranslation('configfields');
        $file = APPDIR_MODULES
                . $this->module->getModuleType()
                . DS . strtolower($this->module->getModuleName())
                . DS . 'ymls' . DS . $params['variableid'] . '.yml';

        if (file_exists($file)) {
            $fid = $f->import($params['id'], file_get_contents($file));
            if ($fid) {
                $this->template->assign('fid', $fid[0]);
                $this->template->assign('pid', $params['id']);
            }
        } else {

            if (!$params['server_id']) {
                Engine::addError("Please configure your app first");
            }

            $var = array(
                'type' => 'select',
                'category' => 'software',
                'premade' => '1',
                'product_id' => $params['id'],
                'options' => ConfigOption::OPTION_SHOWCART | ConfigOption::OPTION_REQUIRED,
                'items' => array()
            );
            if (!empty($params['other']) && is_string($params['other'])) {
                parse_str($params['other'], $params['other']);
            }
            $type = 'all';
            if (isset($params['other']['options']) && is_array($params['other']['options']) && isset($params['other']['options']['vpstype'])) {
                $type = $params['other']['options']['vpstype'];
            }
            if ($params['variableid'] == 'os1') {
                $var['name'] = 'OS Template';
                $var['variable'] = 'os';
                $resp = $this->module->getOSTemplates($type);
                $items = array();
                foreach ($resp as $type)
                    $items = array_merge($items, $type);
            } elseif ($params['variableid'] == 'server') {
                $var['name'] = 'Cloud Location';
                $var['variable'] = 'server';
                $resp = $this->module->getServers($type);
                $items = array();
                foreach ($resp as $type)
                    $items = array_merge($items, $type);
            } elseif ($params['variableid'] == 'servergroup') {
                $var['name'] = 'Cluster Location';
                $var['variable'] = 'servergroup';
                $items = $this->module->getServerGroups();
            }
            if (!empty($items)) {
                foreach ($items as $obj) {
                    $var['items'][] = array('variable_id' => $obj['id'], 'name' => $obj['name']);
                }
                $fid = $f->addFieldCat($var);
                if ($fid) {
                    $this->template->assign('fid', $fid);
                    $this->template->assign('pid', $params['id']);
                    $this->template->assign('vartype', $var['variable']);
                }
            }
        }
    }

    protected function load_options($params) {
        if (!$params['server_id']) {
            Engine::addError("Please configure your app first");
            return;
        }
        if (isset($params['server_id'])) {
            $s = HBLoader::LoadModel('Servers');
            $this->module->connect($s->getServerDetails($params['server_id']));
        }
        if (isset($params['opt'])) {
            $this->template->assign('types', $params['types']);
            $this->template->assign('valx', $params['opt']);
            $defval = isset($params['options']) ? $params['options'][$params['opt']] : $params[$params['opt']];
            $this->template->assign('defval', $defval);
            switch ($params['opt']) {
                case 'server': //  network bridge
                    $this->template->assign('modvalues', $this->module->getServers());
                    break;
                case 'servergroup': //  network bridge
                    $this->template->assign('modvalues', $this->module->getServerGroups());
                    break;
                case 'option4': //  network bridge
                    $this->template->assign('modvalues', $this->module->getOSTemplates());
                    break;
                case 'vpsplan': //  network bridge
                    $this->template->assign('modvalues', $this->module->getPlans());
                    break;
            }
        }
    }

}