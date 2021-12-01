<?php

class whitelist_ip_country_handle_controller extends HBController {


    public function beforeCall ($request)
    {
        
    }
    
    public function _default ($request)
    {
        $db         = hbm_db();
        
        $result     = $db->query("
            SELECT
                gip.*
            FROM
                hb_geo_ip_country gip
            WHERE
                gip.is_whitelist = 1
            ORDER BY
                gip.id DESC
            ")->fetchAll();
        
        $this->template->assign('data', $result);
        $this->_beforeRender();
        $this->template->render(dirname(dirname(__FILE__)) .'/templates/admin/default.tpl',array(), true);
    }
    
    public function add ($request)
    {
        $db         = hbm_db();
        
        $ipaddress  = isset($request['ipaddress']) ? $request['ipaddress'] : '';
        $ip2long    = ip2long($ipaddress);
        
        if (! $ip2long) {
            header('location:?cmd=whitelist_ip_country_handle');
            exit;
        }
        
        $db->query("
            INSERT INTO hb_geo_ip_country (
                id, ip_start, ip_end, ip_long_start, ip_long_end, country_code, country_name, is_whitelist
            ) VALUES (
                '', :ipaddress, :ipaddress, :ip2long, :ip2long, 'TH', 'THAILAND', '1'
            )
            ", array(
                ':ipaddress'    => $ipaddress,
                ':ip2long'      => $ip2long
            ));

        header('location:?cmd=whitelist_ip_country_handle');
        exit;
    }
    
    public function delete ($request)
    {
        $db         = hbm_db();
        
        $id         = isset($request['id']) ? $request['id'] : 0;
        
        if (! $id) {
            header('location:?cmd=whitelist_ip_country_handle');
            exit;
        }
        
        $db->query("
            DELETE FROM hb_geo_ip_country WHERE id = :id
            ", array(
                ':id'    => $id
            ));

        header('location:?cmd=whitelist_ip_country_handle');
        exit;
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

?>
    