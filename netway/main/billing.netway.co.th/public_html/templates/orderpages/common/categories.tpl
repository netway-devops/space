{foreach from=$categories item=i name=categories name=cats}
{if $i.id == $current_cat} <strong>{$i.name}</strong> {if !$smarty.foreach.cats.last}|{/if}
{else} <a href="{$ca_url}cart/{$i.slug}/&amp;step={$step}{if $addhosting}&amp;addhosting=1{/if}">{$i.name}</a> {if !$smarty.foreach.cats.last}|{/if}
{/if}
{/foreach}
{if $logged=='1'} | {if $current_cat=='addons'}<strong>{else}<a href="{$ca_url}cart&amp;step={$step}&amp;cat_id=addons">{/if}{$lang.prodaddons}{if $current_cat=='addons'}</strong>{else}</a>{/if}{/if}



{foreach from=$categories item=i name=categories name=cats}
{if $i.id == $current_cat && $i.description!=''}
<div style="text-align:left;margin-top:10px;">{$i.description}</div>
{/if}
{/foreach}