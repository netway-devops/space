{foreach from=$cf.items item=cit name=nit}
<input name="{if $cf_opt_name && $cf_opt_name != ''}{$cf_opt_name}{else}custom{/if}[{$cf.id}][{$cit.id}]"
       value="1" {if $smarty.foreach.nit.first}id="custom_field_{$cf.copy_of}"{/if}
       type="checkbox" {cartformvalue}{if $cfvalue.val == '1'}checked="checked"{/if}
        onchange="$(document).trigger('hbcart.changeform', [this]);"
       onclick="if(typeof (simulateCart)=='function') simulateCart('{if $cf_opt_formId && $cf_opt_formId != ''}{$cf_opt_formId}{else}#cart3{/if}')"
       class="pconfig_ styled custom_field_{$cf.copy_of}"/>
{$cit.name} {if $cit.price!=0}(
    {if $cit.fee!=0} {$cit.fee|price:$currency} {$lang[$cit.recurring]}{/if}
    {if $cit.setup!=0} {$cit.setup|price:$currency} {$lang.setupfee}{/if}
){/if}
<br/>
{if $cit.description}
    <div class="mt-2 mb-3 text-secondary cf_item_description_value">{$cit.description|escape}</div>
{/if}
{/foreach}