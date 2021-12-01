{foreach from=$cst.items item=cit key=k}{if $cst.value != $k}{continue}{/if} {if $cit.name}{$cit.name}{/if}
    {if $service.showbilling && !$hide_price}{if $cit.price>0}( {$cit.price|price:$currency:1:1} ){/if}{/if}<br/>{/foreach}

