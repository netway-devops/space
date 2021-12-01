{foreach from=$draw item=i}
    {if $i.connected_to}
        ({$i.number} -> {$i.connected_to_number}) <a href="{$moduleurl}&do=itemeditor&item_id={$i.connected_id}">#{$i.connected_id} - {$i.label}</a><br/>
    {/if}

{/foreach}