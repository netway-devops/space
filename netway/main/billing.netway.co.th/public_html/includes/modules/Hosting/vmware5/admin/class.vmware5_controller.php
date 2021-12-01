<?php

class Vmware5_Controller extends HBController {

    /**
     * @var Vmware5
     */
    public $module;
    protected $templateDir;

    public function beforeCall($params) {
        
    }

    function accountdetails($params) {
        $this->templateDir = APPDIR_MODULES
                . $this->module->getModuleType()
                . DS . strtolower($this->module->getModuleName())
                . DS . 'admin' . DS;

        $this->template->assign('moduletpldir', $this->templateDir);

        if (isset($params['vpsdo']) && is_callable(array($this, 'vpsdo_' . $params['vpsdo']))) {
            $this->setupModule($params['id']);

            $params['type'] = $params['account']['options']['type'] == "multi" ? 'cloud' : ( $params['account']['options']['type'] == 'single' ? 'single' : 'reseller' );
            if (empty($params['vpsid']))
                $params['vpsid'] = $params['account']['extra_details']['option6'];


            $this->template->assign('vpsdo', $params['vpsdo']);
            $this->{'vpsdo_' . $params['vpsdo']}($params);
        }
    }

    private function vpsdo_listvms($params) {
        $vms = $this->module->listHostVms();
        usort($vms, function($a, $b) {
            return $a['id'] > $b['id'];
        });

        $this->template->assign('list', $vms);
        $this->template->assign('current', $params['current']);
        $this->template->showtpl = $this->templateDir . 'uuid';
    }

    private function vpsdo_assignvm(&$params) {

        $vms = $this->module->Vms();
        HBDebug::debug("Client assign vps, total " . count($vms));
        if ($vms[$params['vpsid']]) {
            HBDebug::debug("Client VPS, assign {$params['vpsid']}", (array) $vms[$params['vpsid']]);
            try {
                LocalCloud::removeAccount($params['id']);
                $this->module->VmImport($params['vpsid']);
                $vm = $this->module->VmDataFull($params['vpsid']);
                $this->module->VmAssign($vm);
            } catch (Exception $ex) {
                Engine::addError($ex->getMessage());
            }

            $details = $this->module->getDetails();
            $vmId = $details['option6']['value'];

            HBDebug::debug("Client VPS before clientsvms - {$vmId}", $details);

            $params['vpsdo'] = 'clientsvms';
            $this->vpsdo_clientsvms($params);
        } else {
            $params['vpsdo'] = 'listvms';
            Engine::addError('Could not assign selected VPS');
            $this->vpsdo_listvms($params);
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

}
