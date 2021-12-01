 {foreach from=$cst.items item=cit}
 {if $cit.name}{$cit.name}{/if}  
 {if $cst.data[$cit.id]}{foreach from=$cst.data[$cit.id]|json_decode:true item=san name=san}{$san.name}{if !$smarty.foreach.san.last}, {/if}{/foreach}{/if}<br/>
 {/foreach}