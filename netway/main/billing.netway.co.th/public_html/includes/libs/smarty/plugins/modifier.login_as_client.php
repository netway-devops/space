<?php

function smarty_modifier_login_as_client ($string, $systemUrl, $clientId)
{
    $string     .= ' <a class="menuitm" href="'. $systemUrl .'?action=adminlogin&id='. $clientId .'" target="_blank"><span ><strong>Login as client</strong></span></a> ';
    return $string;
}


