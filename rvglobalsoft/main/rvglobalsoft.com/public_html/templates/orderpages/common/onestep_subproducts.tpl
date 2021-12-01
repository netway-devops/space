{*
    {include file='common/onestep_subproducts.tpl' counter_start=0}
    counter_start - used for alternating rows

*}{if !$counter_start}{assign value=0 var=counter_start}{/if}{*
*}<input type="hidden" name="subproducts[0]" value="0" />{*
*}{counter start=$counter_start name=form_custom_counter print=false assign=form_custom_counter}{*
*}{foreach from=$subproducts item=a key=k}{*
*}<div class="cart-subproduct cart-item {if $form_custom_counter % 2 == 0}even{/if} {if $form_custom_counter == 0}first{/if}">{*
*}<div class="cart-subproduct-body"><input name="subproducts[{$k}]" type="checkbox" value="1" {if $selected_subproducts.$k}checked="checked"{/if}/></div>{*
*}<div class="cart-subproduct-name">{*
    *}<span class="category-name">{$a.category_name}</span>{*
    *}<span class="product-name">{$a.name}</span>{*
*}</div>{*
*}<div class="cart-subproduct-price">{*
    *}{if $a.paytype=='Free'}{*
        *}<span class="product-cycle cycle-free">{$lang.free}</span>{*
        *}<input type="hidden" name="subproducts_cycles[{$k}]" value="free"/>{*
    *}{elseif $a.paytype=='Once'}{*
        *}<span class="product-price cycle-once">{$a.m|price:$currency}</span>{*
        *}<span class="product-cycle cycle-once">{$lang.once}</span>{*
        *}{if $a.m_setup!=0}<span class="product-setup cycle-once">{$a.m_setup|price:$currency} {$lang.setupfee}</span>{/if}{*
        *}<input type="hidden" name="subproducts_cycles[{$k}]" value="once"/>{*
    *}{else}{*
        *}<select name="subproducts_cycles[{$k}]" >{*
            *}{foreach from=$a item=p_price key=p_cycle}{*
                *}{if $p_price > 0 && ($p_cycle == 'd' || $p_cycle == 'w' || $p_cycle == 'm' || $p_cycle == 'q' || $p_cycle == 's' || $p_cycle == 'a' || $p_cycle == 'b' || $p_cycle == 't' || $p_cycle == 'p4' || $p_cycle == 'p5') }
                    *}<option value="{$p_cycle}" {if (!$contents[4][$k] && $cycle==$p_cycle) || $contents[3][$k].recurring==$p_cycle} selected="selected"{/if}>{$a.$p_cycle|price:$currency} {assign var=p_scycle value="`$p_cycle`_setup"}{$lang.$p_cycle}{if $a.$p_scycle!=0} + {$a.$p_scycle|price:$currency} {$lang.setupfee}{/if}</option>{*
            *}{/if}{*
            *}{/foreach}{*
        *}</select>{*
    *}{/if}{*
*}</div>{*
*}{if $a.description!=''}<div class="cart-subproduct-descr" >{$a.description}</div>{/if}{*
*}</div>{*
*}{counter name=form_custom_counter}{*
*}{/foreach}