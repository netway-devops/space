{foreach from=$cf.items item=cit}
    <textarea 
        name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]" 
        id="custom_field_{$cf.copy_of}"
        class="form-control styled custom_field" style="width:99%"
        onchange="$(document).trigger('hbcart.changeform', [this]);if (typeof(simulateCart)=='function')simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}');"
        {cartformvalue}>{$cfvalue.val}</textarea> 
        <br/>
{/foreach}