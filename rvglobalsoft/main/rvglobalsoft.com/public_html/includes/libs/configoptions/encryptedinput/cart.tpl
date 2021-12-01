{foreach from=$cf.items item=cit}
    <input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]" 
       id="custom_field_{$cf.copy_of}" {cartformvalue} value="{$cfvalue.val}"
       class="styled custom_field custom_field_{$cf.copy_of}" type="text"
       onchange="$(document).trigger('hbcart.changeform', [this]);if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"/>
    <br/>
{/foreach}