{foreach from=$c.items item=cit}
<input name="custom[{$kk}][{$cit.id}]"  value="1" type="checkbox" {if $c.values[$cit.id]}checked="checked"{/if}/> 
{$cit.name}
    {if $admindata.access.viewOrdersPrices}
        {if $cit.price}({$cit.price|price:$currency:true:$forcerecalc}){/if}<br/>
    {/if}
{/foreach}