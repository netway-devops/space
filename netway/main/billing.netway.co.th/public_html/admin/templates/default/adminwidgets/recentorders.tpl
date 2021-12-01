
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
            {foreach from=$recentorders item=order name=loop}
                <tr class=" "  >
                    <td width="10">{if $order.balance=='Completed'}<div class="orderpaidflag"></div>{/if}</td>
                    <td><a href="?cmd=orders&action=edit&id={$order.id}&list=all">{$order.number}</a></td>
                    <td>{$order|@profilelink:true:true}</td>
                    <td>{$order.date_created|dateformat:$date_format}</td>
                    <td>{$order.total|price:$order.currency_id}</td>
                    <td>
                        <span class="{$order.status}">{if $lang[$order.status]}{$lang[$order.status]}{else}{$order.status}{/if}</span>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
