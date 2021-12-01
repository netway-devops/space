<?php

function smarty_modifier_showsslstatus($string , $field)
{
    require_once HBFDIR_LIBS . 'RvLibs/SSL/PHPLibs.php';
    $oAuth =& RvLibs_SSL_PHPLibs::singleton();
    $aStatus = $oAuth->getStatusDescription($string);
    return    $aStatus[$field];
}