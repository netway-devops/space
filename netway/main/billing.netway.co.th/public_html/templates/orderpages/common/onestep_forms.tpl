{*
    {include file='common/onestep_forms.tpl' counter_start=0}
    counter_start - used for alternating rows
    
*}{if !$counter_start}{assign value=0 var=counter_start}{/if}{*
*}<input type="hidden" name="custom[-1]" value="dummy" />{*
*}{counter start=$counter_start name=form_custom_counter print=false assign=form_custom_counter}{*
*}{if $custom }{foreach from=$custom item=cf}{*
    *}<div class="cart-form cart-item {if $form_custom_counter % 2 == 0}even{/if} {if $form_custom_counter == 0}first{/if}">{*
        *}<div class="cart-form-body">{include file=$cf.configtemplates.cart}</div>{*
        *}<div class="cart-form-name {if $cf.options &1}cart-form-required{/if}">{$cf.name} {if $cf.options &1}<span class="cart-form-star">*</span>{/if}</div>{*
    *}{if $cf.description!=''}<div class="cart-form-descr" >{$cf.description}</div>{/if}{*
*}</div>{*
*}{counter name=form_custom_counter}{*
*}{/foreach}{/if}