<table class="table table-striped" id="datatable_credit" style="margin-top:10px;">
    <thead>
    <tr>
        <th>Client Name</th>
        <th>Total Credit</th>
        <th>Log</th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$creditlog item=invoice key=name}
        <tr>

            <td>
                <a href="?cmd=clients&action=show&id={$invoice.client_id}" class="isclient isclient-{$invoice.group_id}" target="_blank">{$invoice.firstname} {$invoice.lastname}</a>
            </td>
            <td data-sort="{$invoice.credit}">{$invoice.credit|price:$invoice.currency_id}</td>
            <td>
                <a href="?cmd=clientcredit&filter[client_id]={$invoice.client_id}" target="_blank">Log</a>

            </td>
        </tr>
    {/foreach}
    </tbody>
</table>
    <script> $('#datatable_credit').dataTable();</script>
