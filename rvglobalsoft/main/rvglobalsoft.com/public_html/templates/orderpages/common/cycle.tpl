{*
product
allprices
wrap false|true|select
*}{assign var=cr_display_all value=false}{*
*}{if $allprices}{*
    *}{assign var=cr_display_all value=true}{*
*}{/if}{*
*}{if $product.paytype=='Free'}{if $cr_display_all ||$wrap}<span class="product-cycle cycle-free">{/if}{$lang.Free}{if $cr_display_all ||$wrap}</span>{/if}{*
*}{elseif $product.paytype=='Once'}{if $cr_display_all ||$wrap}<span class="product-cycle cycle-once">{/if}{$lang.once}{if $cr_display_all ||$wrap}</span>{/if}{*
*}{else}{*
    *}{if $cr_display_all && $wrap=='select'}<select name="{$allprices}" >{/if}{*
    *}{foreach from=$product item=p_price key=p_cycle}{*
        *}{if $p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5'}{*
            *}{if $p_price > 0}{*
                *}{if $cr_display_all && $wrap=='select'}<option value="{$p_cycle}" {if $cycle==$p_cycle}selected="selected"{/if}>{*
                *}{elseif $cr_display_all ||$wrap}<span class="product-cycle cycle-{$p_cycle}">{/if}{*
                *}{$lang.$p_cycle}{*
                *}{if $cr_display_all && $wrap=='select'}</option>{*
                *}{elseif $cr_display_all ||$wrap}</span>{/if}{*
                *}{if !$cr_display_all}{break}{/if}{*
            *}{/if}{*
        *}{/if}{*
    *}{/foreach}{*
    *}{if $cr_display_all && $wrap=='select'}</select>{/if}{*
*}{/if}