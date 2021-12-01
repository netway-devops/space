<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.estimateVat.php
 * Type:     function
 * Name:     estimateVat
 * Purpose:  add promptpay to url
 * -------------------------------------------------------------
 */
function smarty_modifier_estimateVat($estimateId,$subtotal=0,$vat=0)
{
    if($estimateId != 0 ){ 
        $resultVat  = ($subtotal*$vat)/100;      
    }

    return   $resultVat;
}