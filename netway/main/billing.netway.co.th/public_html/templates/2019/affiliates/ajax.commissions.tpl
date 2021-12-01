{if $orders}
    {foreach from=$orders item=order name=orders}
        <tr>
            <td data-label="{$lang.signupdate}">{$order.date_created|dateformat:$date_format}</td>
            <td data-label="{$lang.services}">
                {if $order.acstatus}
                    {$lang.Account}: {$order.pname}
                {/if}
                {if $order.domstatus}
                    <br />{$lang.Domain}: {$order.domain}
                {/if}
                {if $order.order_id == 0}
                    {if $order.description != ''}{$order.description}{else}-{/if}
                {else}
                    <br />
                    {$lang.total}: {$order.total|price:$order.currency_id}
                {/if}
                {if $moredetails }
                    <br />
                    {if $order.firstname || $order.lastname || $order.companyname}
                        {$lang.clientinfo}:
                        {if $order.companyname}{$order.companyname}
                        {else}{$order.firstname}{$order.lastname}{$order.companyname}
                        {/if}
                        <br />
                    {/if}
                    {if $order.inv_id}
                        <br /><b>{$lang.related_invoice}</b> <br />
                        {$lang.invoicenum}:
                        {if $order.invoice_id}
                            {$order.invoice_id}
                            <br />
                            {$lang.date}: {$order.invoice_date|dateformat:$date_format} <br />
                            {$lang.duedate}: {$order.invoice_due|dateformat:$date_format} <br />
                            {$lang.total}: {$order.invoice_total|price:$order.currency_id}
                        {elseif $proforma && ($order.inv_status=='Paid' || $order.inv_status=='Refunded') && $order.inv_paid!=''}
                            {$order.inv_paid}
                            <br />
                            {$lang.date}: {$order.inv_date|dateformat:$date_format} <br />
                            {$lang.duedate}: {$order.inv_due|dateformat:$date_format} <br />
                            {$lang.total}: {$order.inv_total|price:$order.currency_id}
                        {else}
                            {$order.inv_date|invprefix:$prefix:$order.client_id}
                            {$order.inv_id}
                            <br />
                            {$lang.date}: {$order.inv_date|dateformat:$date_format} <br />
                            {$lang.duedate}: {$order.inv_due|dateformat:$date_format} <br />
                            {$lang.total}: {$order.inv_total|price:$order.currency_id}
                        {/if}
                    {/if}
                {/if}
            </td>
            <td data-label="{$lang.commission}">{$order.commission|price:$affiliate.currency_id}</td>
            <td data-label="{$lang.status}"><strong>{if $order.paid=='1'}{$lang.approved}{else}{$lang.Pending}{/if}</strong></td>
        </tr>
    {/foreach}
{else}
    <tr>
        <td colspan="4" class="text-center">{$lang.nothing}</td>
    </tr>
{/if}