{$field.name} {if $field.items}:
<ul style="padding-left:15px;list-style: disc;clear:both">
    {foreach from=$field.items item=i}
       <li>{if $i.options & 1}<em>{/if}{$i.name}{if $i.options & 1}</em>{/if}</li>
    {/foreach}
</ul>


{/if}