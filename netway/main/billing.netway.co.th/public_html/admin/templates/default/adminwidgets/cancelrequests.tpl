<table class="whitetable" width="100%">
    <tr>
        <th>Service</th>
        <th>Status</th>
        <th>Cancel On</th>
        <th>Customer</th>
        <th>Type</th>
    </tr>
    {foreach from=$cancelrequests item=service}
        <tr>
            <td>
                {if $service.item_type === 'Account'}
                    <a href="?cmd=accounts&action=edit&id={$service.id}">#{$service.id} {if $service.domain}{$service.domain}{elseif $service.name}{$service.name}{/if}</a>
                {elseif $service.item_type === 'Domain'}
                    <a href="?cmd=domains&action=edit&id={$service.id}">#{$service.id} {$service.domain}</a>
                {/if}
            </td>
            <td><span class="{$service.status}">{$service.status}</span></td>
            <td>{$service.next_invoice|dateformat:$date_format} -
                {if $service.left >= 0}{$service.left} days left{else}{$service.left|abs} days overdue{/if}
            </td>
            <td><a href="?cmd=clients&action=show&id={$service.client_id}" class="isclient isclient-{$service.group_id}">{$service|@client}</a></td>
            <td>{$service.type}</td>
        </tr>
    {/foreach}
</table>