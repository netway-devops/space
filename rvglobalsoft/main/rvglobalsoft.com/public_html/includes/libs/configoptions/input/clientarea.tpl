 {foreach from=$cst.items item=cit}{if $cit.name}{$cit.name}{/if}
     {if $cst.data[$cit.id]}{$cst.data[$cit.id]|escape}{/if}<br/>
 {/foreach}