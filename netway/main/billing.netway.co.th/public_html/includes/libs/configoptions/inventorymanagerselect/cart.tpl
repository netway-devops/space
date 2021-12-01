{cartfieldlogic}
<select name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}]" style="width:99%"
        class="pconfig_ styled custom_field_{$cf.copy_of}"  id="custom_field_{$cf.copy_of}"
        onchange="$(document).trigger('hbcart.changeform', [this]);if(typeof (simulateCart)=='function') simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}')">
{foreach from=$cf.items item=cit}
    <option data-val="{$cit.copy_of}" value="{$cit.id}" {cartformvalue}{if $cfvalue}selected="selected"{/if} >{$cit.name} {if $cit.price!=0}(
            {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
            {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
        ){/if}</option>
{/foreach}
</select>
