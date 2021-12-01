{foreach from=$notifications item=item name=foo}
    <tr>
        <td>{if !$item.seen} <span class="badge badge-sm badge-info">{$lang.new}</span> {/if} {$item.date_added|dateformat:$date_format}</td>
        <td><a href="?cmd=clientarea&action=portal_notifications&notification={$item.id}">{$item.subject}</a></td>
        <td>
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
    <tr><td colspan="3">{$lang.nothing}</td></tr>
{/foreach}