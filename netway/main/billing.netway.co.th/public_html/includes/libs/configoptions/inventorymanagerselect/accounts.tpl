<select name="custom[{$kk}]" {if $fieldlogic}id="custom_field_{$c.copy_of}"{/if} >
    <option value="0" {if $c.value=='0'}selected="selected"{/if}>-</option>
    {foreach from=$c.items item=itm}
        <option data-val="{$itm.copy_of}" value="{$itm.id}" {if $c.values[$itm.id]}selected="selected"{/if}>{$itm.name}
            {if $admindata.access.viewOrdersPrices}
                {if $itm.price}({$itm.price|price:$currency:true:$forcerecalc}){/if}
            {/if}
        </option>
    {/foreach}
</select>