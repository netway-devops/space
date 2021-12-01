<?php

function smarty_modifier_newaddress($string, $invoiceId = 0,$is_netway=0,$client_id=0)
{

    $string   =  strtotime($string);
    $checkDue = '2020-07-29';
    $checkDue = strtotime($checkDue);

    $oldNetwayFrom ="Netway Communication Co.,Ltd. <br>1518/5 CaseSHun (4FL.) Pracharaj 1 Road, Wongsawang, Bang Sue, Bangkok 10800 Thailand.";
    
    $newNetwayFrom = "Netway Communication Co.,Ltd. <br>57/25 Village No.9, Bang Phut Sub-district, Pak Kret District, Nonthaburi Province 11120 Thailand.";
    
    $oldRvFrom = "RV Global Soft Co.,Ltd. <br>1518/5 CaseSHun (4FL.) Pracharaj 1 Road, Wongsawang, Bang Sue, Bangkok 10800 Thailand.";
    
    $newRvFrom = "RV Global Soft Co.,Ltd. <br>57/25 Village No.9, Bang Phut Sub-district, Pak Kret District, Nonthaburi Province 11120 Thailand.";


    # softlayer
    $aInvoiceNewAddress  = array(54264,
    54740,
    55145,
    55609,
    56000,
    56485,
    56917,
    57393,
    57788,
    58157);
        
    if($is_netway == 1){        
        if($string >= $checkDue){
            if (in_array($invoiceId, $aInvoiceNewAddress)) {
                return $newNetwayFrom;
            }
            return $newNetwayFrom;
        }
        else{
            return $oldNetwayFrom;
        }
       
    }else{
        if($string >= $checkDue){
            if (in_array($invoiceId, $aInvoiceNewAddress)) {
                return $newRvFrom ;
            }
            if($invoiceId >= 59237 && $client_id == 8475 ){
                return $newNetwayFrom ;
            }
            return $newRvFrom ; 

        }else{
            return $oldRvFrom;
        }     
        
    }
   
}