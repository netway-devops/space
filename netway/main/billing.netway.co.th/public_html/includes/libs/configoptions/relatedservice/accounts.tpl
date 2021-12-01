<select name="custom[{$kk}]" {if $fieldlogic}id="custom_field_{$c.id}"{/if} {if $cmd == 'orders' && $c.options & 1}required{/if}>
    <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
    {foreach from=$c.items item=itm}
        <option value="{$itm.id}" {if $c.values[$itm.id]}selected="selected"{/if}>{$itm.name}
            {if $admindata.access.viewOrdersPrices}
                {if $itm.price}({$itm.price|price:$currency:true:$forcerecalc}){/if}
            {/if}
        </option>
    {/foreach}
</select>
