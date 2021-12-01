{foreach from=$notifications item=item name=foo}
    <tr>
        <td width="20%">{if !$item.seen} <span class="badge badge-sm badge-Pending">{$lang.new}</span> {/if} {$item.date_added|dateformat:$date_format}</td>
        <td><a class="break-word" href="?cmd=clientarea&action=portal_notifications&notification={$item.id}">{$item.subject}</a></td>
        <td width="35%"  data-label="{$lang.relatedto}: ">
            {if $lang[$item.rel_type]}{$lang[$item.rel_type]}
            {else}{$item.rel_type}
            {/if}

            {if $item.url} <a href="{$item.url}">#{$item.rel_id}</a>
            {elseif $item.rel_type && $item.rel_id} {$item.rel_id}
            {else} -
            {/if}
        </td>
    </tr>
{foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}