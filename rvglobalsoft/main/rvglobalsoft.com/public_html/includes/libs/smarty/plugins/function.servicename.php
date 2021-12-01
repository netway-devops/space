<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.servicename.php
 * Type:     function
 * Name:     servicename
 * Purpose:  servicename
 * -------------------------------------------------------------
 */
function smarty_function_servicename($params,$template) {
    if(isset($template->_tpl_vars['service']['id'])){
        $accID = $template->_tpl_vars['service']['id'];
        $name='';
        if(!isset($template->_tpl_vars['service']['product_name'])){
            $db         = hbm_db();
            $result    = $db->query("
                            SELECT
                                p.name as product
                            FROM 
                                hb_accounts acc
                                INNER JOIN hb_products p ON ( acc.product_id = p.id )
                            WHERE 
                                acc.id = :accid
                            ",array(':accid' => $accID))->fetch();
            $name = $result['product'];
        }
        else{
            $name = $template->_tpl_vars['service']['product_name'];
        }
        return $name;
    }
    return '';
}
