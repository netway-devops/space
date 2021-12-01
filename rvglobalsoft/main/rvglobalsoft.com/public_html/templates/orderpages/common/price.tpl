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
*}{if $product.paytype=='Free'}{*
    *}{if $cr_display_all || $showcycle}<span class="product-price cycle-once">{/if}{*
    *}{$lang.Free}{*
    *}{if $cr_display_all || $showcycle}</span>{/if}{*
    *}{if $cr_display_input}<input type="hidden" name="{$allprices}" value="Free">{/if}{*
*}{elseif $product.paytype=='Once'}{*
    *}{if $cr_display_all || $showcycle}<span class="product-price cycle-once">{/if}{*
    *}{$product.m|price:$currency:$cr_display:false:$cr_showcode:$cr_decimal:$cr_frontsign}{*
    *}{if $cr_display_all || $showcycle}</span>{/if}{*
    *}{if $showcycle}<span class="product-cycle cycle-once">{$lang.once}</span>{/if}{*
    *}{if $cr_display_input}<input type="hidden" name="{$allprices}" value="Once">{/if}{*
*}{else}{*
    *}{if $cr_display_input}<select name="{$allprices}" >{/if}{*
    *}{foreach from=$product item=p_price key=p_cycle}{*
        *}{if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}{*
            *}{if $p_price > 0}{*
                *}{if $cr_display_input}<option value="{$p_cycle}" {if $cycle==$p_cycle}selected="selected"{/if}>{*
                *}{elseif $cr_display_all || $showcycle}<span class="product-price cycle-{$p_cycle}">{/if}{*
                *}{$p_price|price:$currency:$cr_display:false:$cr_showcode:$cr_decimal:$cr_frontsign}{*
                *}{if $cr_display_input} {$lang.$p_cycle}</option>{else}{*
                    *}{if $cr_display_all || $showcycle}</span>{/if}{*
                    *}{if $showcycle}<span class="product-cycle cycle-{$p_cycle}">{$lang.$p_cycle}</span>{/if}{*
                    *}{if !$cr_display_all}{break}{/if}{*
                *}{/if}{*
            *}{/if}{*
        *}{/if}{*
    *}{/foreach}{*
    *}{if $cr_display_input}</select>{/if}{*
*}{/if}