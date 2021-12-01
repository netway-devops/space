<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.estimateLastTotal.php
 * Type:     function
 * Name:     estimateLastTotal
 * Purpose:  add promptpay to url
 * -------------------------------------------------------------
 */
function smarty_modifier_estimateLastTotal($estimateId,$subtotal=0,$total=0,$vat=0)
{
    if($estimateId != 0 ){  
        
        $vatCalculate  = ($subtotal*$vat)/100;   
        $lastTotal     = $total-$vatCalculate;
    
    }
    
    return   $lastTotal;
}