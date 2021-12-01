{foreach from=$orders item=order}
    <tr {if $order.paid=='1'}class="compor"{/if}>
        <td>{$order.id}</td>
        <td>{$order.date_created|dateformat:$date_format}</td>
        <td>
            {if $order.client_id}
                <a href="?cmd=clients&action=show&id={$order.client_id}">{$order|@client}</a>
            {else} -
            {/if}
        </td>
        <td>
            {if $order.type == 'recurring'}
                Recurring Commission
            {elseif $order.type == 'order'}
                New Order
            {elseif $order.type == 'unassigned'}
                Unassigned Order
            {elseif $order.type == 'manual'}
                Manual Commission
            {elseif $order.type == 'sub-affiliate'}
                Commission from sub-affiliate order
            {/if}
            {if $order.invoice_id}
                (<a href="?cmd=invoices&action=edit&id={$order.invoice_id}">#{$order.invoice_id|@invoice}</a>)
            {elseif $order.order_id}
                (<a href="?cmd=orders&action=edit&id={$order.order_id}">#{$order.order_id}</a>)
            {/if}
        </td>
        <td>
            {$order.commission|price:$affiliate.currency_id}
        </td>
        <td>
            {if $order.invoice_id}
                <span class="label label-default label-{$order.invoice_status}">{$lang.invoice} - {$order.invoice_status}</span>
            {else}
                <span class="label label-default label-{$order.order_status}">{$lang.Order} - {$order.order_status}</span>
            {/if}
        </td>
        <td>{if $order.description}{$order.description|truncate:30}{else}-{/if}</td>
        <td style="text-align: right">
            {if $order.paid!='1'}
                <a href="#review" data-id="{$order.id}" data-amount="{$order.commission}" data-accepted="0"
                   class="btn btn-success btn-sm aff-review">
                    Review / Accept
                </a>
            {else}
                <a href="#review" data-id="{$order.id}" data-accepted="1"
                   class="btn btn-default btn-sm aff-details">
                    Show details
                </a>
            {/if}
            <a href="?cmd=affiliates&action=affiliate&id={$order.aff_id}&removeref={$order.id}&security_token={$security_token}"
               class="btn btn-danger btn-sm" onclick="return confirm('{$lang.confirmlogab}')"><span
                        class="fa fa-trash-o"></span></a>
        </td>
    </tr>
{/foreach}