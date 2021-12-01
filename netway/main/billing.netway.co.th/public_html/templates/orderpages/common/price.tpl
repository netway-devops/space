{*
hideall
hidecode
hidesign
decimal
allprices
currency
showcycle
*}{assign var=cr_display value=true}{*
*}{if $hideall}{*
    *}{assign var=cr_display value=false}{*
*}{/if}{*
*}{assign var=cr_showcode value=true}{*
*}{if $hidecode}{*
    *}{assign var=cr_showcode value=false}{*
*}{/if}{*
*}{assign var=cr_decimal value=$decimal}{*
*}{if !$decimal && $decimal!==0}{*
    *}{assign var=cr_decimal value=false}{*
*}{/if}{*
*}{assign var=cr_frontsign value=true}{*
*}{if $hidesign}{*
    *}{assign var=cr_frontsign value=false}{*
*}{/if}{*
*}{assign var=cr_display_all value=false}{*
*}{if $allprices && $allprices !== true}{*
    *}{assign var=cr_display_input value=true}{assign var=cr_display_all value=true}{*
    *}{elseif $allprices} {assign var=cr_display_all value=true}{*
*}{/if}{*
*}{price product=$product
    display=$cr_display code=$cr_showcode decimals=$cr_decimal sign=$cr_frontsign showall=$cr_display_all}{*
*}{if $product.paytype=='Free'}{*
    *}{if $cr_display_all || $showcycle}<span class="product-price cycle-once">{/if}{*
    *}@@cyclename{*
    *}{if $cr_display_all || $showcycle}</span>{/if}{*
    *}{if $cr_display_input}<input type="hidden" name="{$allprices}" value="Free">{/if}{*
*}{elseif $product.paytype=='Once'}{*
    *}{if $cr_display_all || $showcycle}<span class="product-price cycle-once">{/if}{*
    *}@@price{*
    *}{if $cr_display_all || $showcycle}</span>{/if}{*
    *}{if $showcycle}<span class="product-cycle cycle-once">@@cyclename</span>{/if}{*
    *}{if $cr_display_input}<input type="hidden" name="{$allprices}" value="Once">{/if}{*
*}{else}{*
    *}{if $cr_display_input}{*
        *}<select name="{$allprices}">{*
            *}<option value="@@cycle" @@selected>@@line</option>{*
        *}</select>{*
    *}{else}{*
        *}{if $cr_display_all || $showcycle}<span class="product-price cycle-@@cycle">{/if}{*
        *}@@price{*
        *}{if $cr_display_all || $showcycle}</span>{/if}{*
        *}{if $showcycle}<span class="product-cycle cycle-@@cycle">@@cyclename</span>{/if}{*
    *}{/if}{*
*}{/if}{*
*}{/price}