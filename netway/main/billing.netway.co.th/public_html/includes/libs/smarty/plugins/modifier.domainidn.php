<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.domainidn.php
 * Type:     function
 * Name:     domainidn
 * Purpose:  convert domainidn to readable
 * -------------------------------------------------------------
 */

require_once(APPDIR . 'idna_convert.class.php');

function smarty_modifier_domainidn ($string)
{
    $IDN            = new idna_convert();
    return $IDN->decode($string);
}
