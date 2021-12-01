<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     
 * Type:     function
 * Name:     order_pages
 * Purpose:  Dynamic price and link to order
 * -------------------------------------------------------------
 */
function smarty_modifier_order_pages($string,$current_cat)
{
    if(preg_match('/^{include::(.*)\.tpl}/', $string , $output)){
        
        $myfile = fopen(MAINDIR . 'templates/netwaybysidepad/'. $output[1] .'.tpl', "r") or die("Unable to open file!");
        $readfileStr =  fread($myfile,filesize(MAINDIR . 'templates/netwaybysidepad/'. $output[1] .'.tpl'));
        fclose($myfile);
        return _convert_price($readfileStr,$current_cat);
        
    }else{
        return _convert_price($string,$current_cat);
    }
        
}

function _convert_price($string,$current_cat){
    
    $db         = hbm_db();
    $sql = "
        SELECT * 
        FROM  `hb_common` 
        WHERE 1
        AND rel = 'product'
        AND ( paytype = 'Regular' OR paytype = 'Once')
    ";    
    
    $result =   $db->query($sql)->fetchAll();
    
    if(empty($result)){
        return $string;
    }else{
        $aTemplateVariable  =   array();
        foreach($result as $key => $value){
            $aTemplateVariable[$value['id']]    =   $value;
        }
    }
    
    if (preg_match_all("/{(.*?)}/", $string, $m)) {
        foreach ($m[1] as $i => $varname) {
            $variable = explode(".", $varname);
            if($variable[0] == 'price'){
                $string =   str_replace($m[0][$i], sprintf('%s', number_format($aTemplateVariable[$variable[1]][$variable[2]],2,'.',',')), $string);
            }else if($variable[0] == 'link'){
                $string =   str_replace($m[0][$i], sprintf('%s', '/?cmd=cart&action=add&id='. $variable[1]) , $string);
            }else if($variable[0] == 'pricepermonth'){
                $string =   str_replace($m[0][$i], sprintf('%s', number_format($aTemplateVariable[$variable[1]][$variable[2]]/12,2,'.',',')), $string);
            }else if($variable[0] == 'current_cat'){
                $string =   str_replace($m[0][$i], sprintf('%s', $current_cat), $string);
            }
        }
    }
    
    return $string;
}

