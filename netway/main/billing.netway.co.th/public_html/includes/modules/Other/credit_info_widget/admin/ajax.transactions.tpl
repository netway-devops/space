<table class="table table-striped" id="datatable_credit" style="margin-top:10px;" data-order='[[ 0, "desc" ]]'>
    <thead>
    <tr>
        <th  width="130">{$lang.Date}</th>
        <th  width="150">Client</th>
        <th>Description</th>
        <th width="90">Increase</th>
        <th width="90">Decrease</th>
        <th width="90">Credit after</th>
        <th width="130">Trans. id</th>
        <th width="90">Invoice</th>
        <th width="130">Staff</th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$creditlog item=email}
        <tr>
            <td>{$email.date|dateformat:$date_format}</td>
            <td>
                <a href="?cmd=clients&action=show&id={$email.client_id}" target="_blank">{$email.firstname} {$email.lastname}</a>
            </td>
            <td>{$email.description}</td>
            <td>{$email.in|price:$email.currency_id}</td>
            <td>{$email.out|price:$email.currency_id}</td>
            <td>{$email.balance|price:$email.currency_id}</td>
            <td>{if $email.transid}<a href="?cmd=transactions&action=edit&id={$email.transid}" target="_blank" title="{$email.transaction_id}">{$email.transaction_id|truncate:16}</a>{elseif $email.transaction_id}{$email.transaction_id|truncate:16}{else}-{/if}</td>
            <td>{if $email.invoice_id}<a href="?cmd=invoices&action=edit&id={$email.invoice_id}&list=all" target="_blank">{$email.invoice_id}</a>{else}-{/if}</td>
            <td>{if $email.admin_id}<a href="?cmd=editadmins&action=administrator&id={$email.admin_id}" target="_blank">{$email.admin_name}</a>{else}-{/if}</td>
        </tr>
    {/foreach}
    </tbody>
</table>
<script> $('#datatable_credit').dataTable();</script>
