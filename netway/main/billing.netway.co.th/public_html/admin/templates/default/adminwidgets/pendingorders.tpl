
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table whitetable" style="">
    <tbody>
    <tr>
        <th></th>
        <th>{$lang.orderhash}</th>
        <th>{$lang.clientname}</th>
        <th>{$lang.Date}</th>
        <th>{$lang.Total}</th>
        <th>{$lang.Status}</th>
    </tr>

    {foreach from=$pendingorders item=order name=floop}
        <tr  >

            <td width="10">{if $order.balance=='Completed'}<div class="orderpaidflag"></div>{/if}</td>
            <td><a href="?cmd=orders&action=edit&id={$order.id}&list=all">{$order.number}</a></td>
            <td><a href="?cmd=clients&action=show&id={$order.client_id}"  class="isclient isclient-{$order.group_id}">{$order.name}</a></td>
            <td>{$order.date_created|dateformat:$date_format}</td>
            <td>{$order.total|price:$order.currency_id}</td>
            <td>
                <span class="{$order.status}">{if $lang[$order.status]}{$lang[$order.status]}{else}{$order.status}{/if}</span>
            </td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="5">No pending orders</td>
        </tr>
    {/foreach}
    </tbody>
</table>
