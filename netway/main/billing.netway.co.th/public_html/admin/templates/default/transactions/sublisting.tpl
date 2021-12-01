<table class="table table-striped" width="100%">


    <thead>
    <tr>
        <th width="30">Type</th>
        <th class="col-md-3">Transaction id</th>
        <th>Status</th>
        <th>Document</th>
        <th>Amount in</th>
        <th>Amount out</th>
        <th>Date</th>

    </tr>
    </thead>
    <tbody>
    {foreach from=$listing item=tr}
        <tr>
            <td>{$tr.type}</td>
            <td><a href="?cmd=transactions&action=edit&id={$tr.id}" target="_blank">{$tr.trans_id}</a></td>
            <td><span class="{$tr.status}">{if $lang[$tr.status]}{$lang[$tr.status]}{else}{$tr.status}{/if}</span></td>
            <td>{if $tr.invoice_id}<a href="?cmd=invoices&action=edit&id={$tr.invoice_id}" target="_blank">{if $tr.invoice}{$tr.invoice|@invoice}{else}{$tr.invoice_id}{/if}</a>{else}-{/if}</td>
            <td>{$tr.in|price:$tr.currency_id}</td>
            <td>{$tr.out|price:$tr.currency_id}</td>
            <td>{$tr.date|dateformat:$date_format}</td>
        </tr>
    {/foreach}
    </tbody>
</table>