{foreach from=$c.items item=itm}{if $c.values[$itm.id]}Client selected: {$itm.name}
    {if $admindata.access.viewOrdersPrices}
        {if $itm.price}({$itm.price|price:$currency:true:$forcerecalc}){/if}
    {/if}
    <input type="hidden" name="custom[{$kk}]" value="{$itm.id}"/>{/if}
{/foreach}
