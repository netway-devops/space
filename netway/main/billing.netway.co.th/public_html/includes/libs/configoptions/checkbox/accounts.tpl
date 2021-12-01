{foreach from=$c.items item=cit}
    <input name="custom[{$kk}][{$cit.id}]" data-variable="{$c.variable}" value="1" type="checkbox" {if $c.values[$cit.id]}checked="checked"{/if} {if $fieldlogic}id="custom_field_{$c.id}"{/if}/>
    {$cit.name}
    {if $admindata.access.viewOrdersPrices}
        {if $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}
    {/if}
    <br/>
    {if $cit.description}
        <span style="display:block;color: #777;margin-bottom: 5px;" class="text-secondary cf_item_description_value">{$cit.description|escape}</span>
    {/if}
{/foreach}