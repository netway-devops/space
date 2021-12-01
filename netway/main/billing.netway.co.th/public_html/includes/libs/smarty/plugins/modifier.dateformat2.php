<?php
/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.dateformat2.php
 * Type:     function
 * Name:     dateformat2
 * Purpose:  add dateformat2 to url
 * -------------------------------------------------------------
 */
function smarty_modifier_dateformat2($string)
{
    # %d %b %Y
    $string = date('d F Y', strtotime($string));
    return $string;
}