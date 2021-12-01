{*
product
allprices
wrap false|true|select
*}{assign var=cr_display_all value=false}{*
*}{if $allprices}{*
    *}{assign var=cr_display_all value=true}{*
*}{/if}{*
*}{price product=$product showall=$cr_display_all}{*
*}{if $product.paytype=='Free'}{*
    *}{if $cr_display_all ||$wrap}<span class="product-cycle cycle-free">{/if}{*
    *}{$lang.Free}{*
    *}{if $cr_display_all ||$wrap}</span>{/if}{*
*}{elseif $product.paytype=='Once'}{*
    *}{if $cr_display_all ||$wrap}<span class="product-cycle cycle-once">{/if}{*
    *}{$lang.once}{*
    *}{if $cr_display_all ||$wrap}</span>{/if}{*
*}{else}{*
    *}{if $cr_display_all && $wrap=='select'}{*
        *}<select name="{$allprices}">{*
            *}<option value="@@cycle" @@selected>@@cyclename</option>{*
        *}</select>{*
    *}{else}{*
        *}{if $cr_display_all ||$wrap}<span class="product-cycle cycle-@@cycle">{/if}{*
        *}@@cyclename{*
        *}{if $cr_display_all ||$wrap}</span>{/if}{*
    *}{/if}{*
*}{/if}{*
*}{/price}