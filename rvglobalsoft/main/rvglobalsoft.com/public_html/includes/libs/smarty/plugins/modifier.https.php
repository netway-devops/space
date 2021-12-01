<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.https.php
 * Type:     function
 * Name:     https
 * Purpose:  add https to url
 * -------------------------------------------------------------
 */
function smarty_modifier_https($string)
{
    return preg_replace('/http\:/', 'https:', $string);
}