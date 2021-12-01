<?php

class domain_autorenew_controller extends HBController {
    
    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
        $api        = new ApiWrapper();
        
        $result     = $db->query("
                SELECT
                    d.id, d.name,
                    mc.module
                FROM
                    hb_domains d,
                    hb_modules_configuration mc,
                    hb_domain_renew dr
                WHERE
                    d.reg_module = mc.id
                    AND d.id = dr.id
                    AND dr.is_auto_renew = 1
                ORDER BY d.name ASC
                ")->fetchAll();
        
        $aDatas     = array();
        
        if (count($result)) {
            foreach ($result as $arr) {
                $registrar      = $arr['module'];
                if (! isset($aDatas[$registrar]) || ! is_array($aDatas[$registrar])) {
                    $aDatas[$registrar]     = array();
                }
                $domainId       = $arr['id'];
                $aDatas[$registrar][$domainId]  = $arr;
                
            }
        }
        
        $this->template->assign('aDatas', $aDatas);
        
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    private function _beforeRender ()
    {
        $this->template->assign('tplPath', dirname(dirname(__FILE__)) . '/templates/');
        $this->template->assign('tplClientPath', dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))) 
            . '/templates/');
    }

    public function afterCall ($request)
    {
        
    }
}