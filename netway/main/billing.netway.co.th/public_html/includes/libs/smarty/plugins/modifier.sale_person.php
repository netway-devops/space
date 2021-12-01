<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.sale_person.php
 * Type:     function
 * Name:     sale_person
 * Purpose:  add promptpay to url
 * -------------------------------------------------------------
 */
function smarty_modifier_sale_person($estimateId)
{
    $db         = hbm_db();
    $aAdmin         = hbm_logged_admin();      
    $result     = $db->query("
                SELECT a.id, a.username  
                FROM hb_order_drafts d,hb_admin_access a
                WHERE  d.staff_member_id = a.id  
                AND d.estimate_id = :estimateId
                ", array(
                ':estimateId'      => $estimateId
                ))->fetch();

    $saleperson  = empty($result) ? $aAdmin['email'] :$result['username'];
    return   $saleperson;

}