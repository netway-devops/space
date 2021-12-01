<?php

function smarty_modifier_html_showjsscript($string)
{
    if(preg_match("/<div class=\"attachment\">/", $string)){
        return nl2br($string);
    }else{
        $string = htmlspecialchars($string);
        $string = str_replace("&lt;strike&gt;","<strike>", $string);
        $string = str_replace("&lt;/strike&gt;","</strike>", $string);
        return nl2br($string);
    }
}