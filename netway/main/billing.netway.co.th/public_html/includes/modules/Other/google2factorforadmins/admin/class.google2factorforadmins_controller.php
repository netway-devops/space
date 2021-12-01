<?php

class google2factorforadmins_controller extends HBController{
    
    public function beforeCall($params)
    {
        $modDir = strtolower($this->module->getModuleDirName());
        $this->template->pageTitle = $this->module->getModName();
        $this->template->module_template_dir = APPDIR_MODULES . 'Other' . DS . $modDir . DS . 'admin';
        $this->template->assign('moduleurl', Utilities::checkSecureURL(HBConfig::getConfig('InstallURL') . 'includes/modules/Other/' . $modDir . '/admin/'));
        $this->template->assign('modulename', $this->module->getModuleName());
        $this->template->assign('modname', $this->module->getModName());
        $this->template->assign('moduleid', $this->module->getModuleId());
        $this->template->showtpl = 'default';
        
        $secret =   '';
        $secret =   $this->module->get2fasecretadmin();
        if($secret != ''){
            $this->template->assign('secret',$secret);
        }
        
        $enable =   '';
        $enable =   $this->module->get2faenable();
        if($enable['value'] != ''){
            $this->template->assign('enable',$enable);
        }
        
        if(!isset($_COOKIE['2facRemember7days'])){
            $this->template->assign('showRememberMe',1);
        }
        
    }
    
    public function _default($params){

        if ($params['token_valid']) {
            if ($this->module->verifyCode($params['securitycode'])) {
                $this->module->updateFirstLogin();
                if(isset($params['2facRemember7days']) && $params['2facRemember7days'] == '1') $this->module->setCookie7Days();
                Utilities::redirect('index.php');
            }
        }

    }
    
    public function saveSecret($request){
        
        $this->module->updateSecret($request['secretData']);
        
    }

}

?>