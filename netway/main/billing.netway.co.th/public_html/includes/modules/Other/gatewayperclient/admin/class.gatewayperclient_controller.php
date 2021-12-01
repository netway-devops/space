<?php

/**
 * Class gatewayperclient_controller
 * Admin controller
 * @see https://dev.hostbillapp.com/dev-kit/advanced-topics/hostbill-controllers/
 * @author HostBill Module Generator <cs@hostbillapp.com>
 */
class gatewayperclient_controller extends HBController
{

    /**
     * Related module object (gatewayperclient)
     * @var gatewayperclient $module
     */
    var $module;


    /**
     * Template object (subclass of Smarty).
     * Use it to assign variables to template
     * @var Smarty $template
     */
    var $template;

    /**
     * This method is runned ALWAYS before any other method in this class.
     * Use it to initialize variables, assign some common stuff to template.
     * @param array $params
     */
    public function beforeCall($params)
    {
        $modDir = strtolower($this->module->getModuleDirName());
        $this->template->pageTitle = $this->module->getModName();
        $this->template->module_template_dir = APPDIR_MODULES . 'Other' . DS . $modDir . DS . 'admin';
        $this->template->assign('moduleurl', Utilities::checkSecureURL(HBConfig::getConfig('InstallURL') . 'includes/modules/Other/' . $modDir . '/admin/'));
        $this->template->assign('modulename', $this->module->getModuleName());
        $this->template->assign('modname', $this->module->getModName());
        $this->template->assign('moduleid', $this->module->getModuleId());

        $gateways = HBLoader::LoadModel('Managemodules')->getModulesDB('Payment', true);
        $this->template->assign('gateways', $gateways);

        if (!$params['action']) {
            $params['action'] = 'default';
            $this->groups($params);
        }
        $this->template->assign('action', $params['action']);
    }

    /**
     * @param $params
     */
    public function groups($params)
    {
        $configs = $this->module->listConfigs('group');
        $this->template->assign('configs', $configs);
        $this->template->showtpl = 'groups';
    }


    /**
     * @param $params
     */
    public function cart($params)
    {
        $configs = $this->module->listConfigs('cart');
        if($configs[0]) {
            $this->template->assign('config', $configs[0]);
            $this->template->assign('selected', array_combine($configs[0]['gateways'], $configs[0]['gateways']));
        }
        $this->template->showtpl = 'cart';

        if ($params['make'] == 'save' && $params['token_valid']) {

            if($configs[0]) {
                $this->module->removeConfig($configs[0]['id']);
            }
            if( !empty($params['gateways'])) {
                $this->module->addConfig($params);

            }

            Utilities::redirect('?cmd=gatewayperclient&action=cart');

        }
    }

    /**
     * @param $params
     * @throws RedirectInterrupt
     */
    public function addgroups($params)
    {
        if ($params['make'] == 'add' && $params['token_valid']) {
            if (!empty($params['items']) && !empty($params['gateways'])) {
                $this->module->addConfig($params);
                Utilities::redirect('?cmd=gatewayperclient&action=groups');
            } else {
                Engine::addError('Please select groups and payment gateways!');
                Utilities::redirect('?cmd=gatewayperclient&action=addgroups');
            }
        }
        $groups = HBLoader::LoadModel('Clients/ClientGroup')->listGroups();
        $this->template->assign('groups', $groups);
        $this->template->showtpl = 'groups';
    }

    /**
     * @param $params
     */
    public function products($params)
    {
        $configs = $this->module->listConfigs('product');
        $this->template->assign('configs', $configs);
        $this->template->showtpl = 'products';
    }

    /**
     * @param $params
     * @throws RedirectInterrupt
     */
    public function addproducts($params)
    {
        if ($params['make'] == 'add' && $params['token_valid']) {
            if (!empty($params['items']) && !empty($params['gateways'])) {
                $this->module->addConfig($params);
                Utilities::redirect('?cmd=gatewayperclient&action=products');
            } else {
                Engine::addError('Please select products and payment gateways!');
                Utilities::redirect('?cmd=gatewayperclient&action=addproducts');
            }
        }
        $products = $this->module->getProducts();
        $this->template->assign('products', $products);
        $this->template->showtpl = 'products';
    }

    /**
     * @param $params
     */
    public function cycles($params)
    {
        $configs = $this->module->listConfigs('cycle');
        $this->template->assign('configs', $configs);
        $this->template->showtpl = 'cycles';
    }

    /**
     * @param $params
     * @throws RedirectInterrupt
     */
    public function addcycles($params)
    {
        if ($params['make'] == 'add' && $params['token_valid']) {
            if (!empty($params['items']) && !empty($params['gateways'])) {
                $this->module->addConfig($params);
                Utilities::redirect('?cmd=gatewayperclient&action=cycles');
            } else {
                Engine::addError('Please select cycles and payment gateways!');
                Utilities::redirect('?cmd=gatewayperclient&action=addcycles');
            }
        }
        $this->template->showtpl = 'cycles';
    }

    /**
     * @param $params
     */
    public function countries($params)
    {
        $configs = $this->module->listConfigs('country');
        $this->template->assign('configs', $configs);
        $this->template->showtpl = 'countries';
    }

    /**
     * @param $params
     * @throws RedirectInterrupt
     */
    public function addcountries($params)
    {
        if ($params['make'] == 'add' && $params['token_valid']) {
            if (!empty($params['items']) && !empty($params['gateways'])) {
                $this->module->addConfig($params);
                Utilities::redirect('?cmd=gatewayperclient&action=countries');
            } else {
                Engine::addError('Please select countries and payment gateways!');
                Utilities::redirect('?cmd=gatewayperclient&action=addcountries');
            }
        }
        $countries = Utilities::get_countries();
        $countries[gatewayperclient::ALL_COUNTRIES]='ALL Countries';
        ksort($countries);
        $this->template->assign('countries', $countries);
        $this->template->showtpl = 'countries';
    }

    /**
     * @param $params
     * @throws RedirectInterrupt
     */
    public function removeconfig($params)
    {
        if ($params['id'] && $params['token_valid']) {
            $this->module->removeConfig($params['id']);
            Utilities::redirect('?cmd=gatewayperclient&action=' . $params['page']);
        }
    }

    /**
     * This method is called if no action param is present in URL, or action handler is not found in this class.
     * @param array $params
     */
    public function update($params)
    {
        if ($params['token_valid'] && $params['client_id']) {
            if (!$this->acl->canI('editClients')) {
                Engine::addError('lackpriviliges_action');
            } else {
                $this->module->saveGateways($params['client_id'], $params['selectall'], $params['customergateways']);
            }
        }
    }
}