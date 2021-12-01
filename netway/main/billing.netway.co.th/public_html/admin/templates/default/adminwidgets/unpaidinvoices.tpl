
<table class="table table-striped" id="datatable_unpaidinvoices">
    <thead>
        <tr>
            <th>Invoice #</th>
            <th>Client Name</th>
            <th>Due Date</th>
            <th>Total</th>
            <th>Gateway</th>
        </tr>
    </thead>
    <tbody>
        {foreach from=$unpaidinvoices item=invoice key=name}
            <tr>
                <td><a href="?cmd=invoices&action=edit&id={$invoice.id}"  rel="{$invoice.id}">
                        {$invoice|@invoice}
                    </a></td>
                <td><a href="?cmd=clients&action=show&id={$invoice.client_id}" class="isclient isclient-{$invoice.group_id}">{$invoice.firstname} {$invoice.lastname}</a>
                </td>
                <td data-sort="{$invoice.duedate}">{$invoice.duedate|dateformat:$date_format}</td>
                <td>{$invoice.total|price:$invoice.currency_id}</td>
                <td>
                    {if $invoice.credit>0 && $invoice.credit>=$invoice.total}
                        {$lang.paidbybalance}
                    {else}
                        {$invoice.module|default:"`$lang.none`"}
                        {if $invoice.credit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}
                    {/if}
                </td>
            </tr>
        {/foreach}
    </tbody>
</table>
{if $ajax}
    <script> $('#datatable_unpaidinvoices').dataTable();</script>
{else}
    {literal}
        <script>
            var unpaidinoivces = function() {
                $('#datatable_unpaidinvoices').dataTable();
            }
            appendLoader("unpaidinoivces");
        </script>{/literal}
{/if}
