<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.licenseIp.php
 * Type:     function
 * Name:     licenseIp
 * Purpose:  ip
 * -------------------------------------------------------------
 */
function smarty_function_licenseIp($params,$template) {
    if(isset($template->_tpl_vars['service']['id'])){
        $accID = $template->_tpl_vars['service']['id'];
        $ip='';
        if(!isset($template->_tpl_vars['service']['forms']['ip']['value'])){
            $db         = hbm_db();
            $result    = $db->query("
                            SELECT
                                ac.data as ip
                            FROM 
                                hb_accounts acc
                                INNER JOIN hb_config2accounts ac ON ( acc.id = ac.account_id )
                                INNER JOIN hb_config_items_cat f ON ( ac.config_cat = f.id )
                            WHERE 
                                acc.id = :accid
                                AND f.variable = 'ip'
                            ",array(':accid' => $accID))->fetch();
            $ip = $result['ip'];
        }
        else{
            $ip = $template->_tpl_vars['service']['forms']['ip']['value'];
        }
        return $ip;
    }
}
