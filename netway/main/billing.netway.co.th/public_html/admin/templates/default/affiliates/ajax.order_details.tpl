<div class="row">
    {if $afforder.type=='unassigned'}
        <div class="col-md-12">

            <div class="alert alert-warning" role="alert">This commission was detached by admin from order. Related affiliate will not receive recurring commisions from it</div>
        </div>
    {/if}

    <div class="col-sm-6">
        <label>Date created</label>
        <p>
            {$afforder.date_created|dateformat:$date_format}
        </p>
    </div>
    {if $afforder.paid}
        <div class="col-sm-6">
            <label>Commission ammount</label>
            <p>
                {$afforder.commission|price:$aff_currency}
            </p>
        </div>
        <div class="col-sm-6">
            <label>Accepted on</label>
            <p>
                {$afforder.datepaid|dateformat:$date_format}
            </p>
        </div>
    {/if}
</div>
{if $afforder.description != ''}
    <div class="row">
        <div class="col-sm-12">
            <label>Public note</label>
            <p>{$afforder.description}</p>
        </div>
    </div>
{/if}

{if $invoice}
    <p style="border-bottom: 1px solid rgba(0,0,0,0.1)">
        <strong>{$lang.Invoice}</strong>
    </p>
    <div class="row">
        <div class="col-sm-6">
            <label>ID</label>
            <p>
                <a href="?cmd=invoices&action=edit&id={$invoice.id}">{$invoice|@invoice}</a>
            </p>
        </div>
        <div class="col-sm-6">
            <label>{$lang.Total}</label>
            <p>
                {$invoice.total|price:$invoice.currency_id}
            </p>
        </div>
        <div class="col-sm-6">
            <label>{$lang.Date}</label>
            <p>
                {$invoice.date|dateformat:$date_format}
            </p>
        </div>
        <div class="col-sm-6">
            <label>{$lang.Status}</label>
            <p>
                <label class="label label-{$invoice.status}">{$invoice.status}</label>
            </p>
        </div>
    </div>
{/if}
{if $order}
    <p style="border-bottom: 1px solid rgba(0,0,0,0.1)">
        <strong>{$lang.Order}</strong>
    </p>
    <div class="row">
        <div class="col-sm-6">
            <label>Number</label>
            <p>
                <a href="?cmd=orders&action=edit&id={$order.id}">{$order.number}</a>
            </p>
        </div>
        <div class="col-sm-6">
            <label>{$lang.Total}</label>
            <p>
                {$order.total|price:$order.currency_id}
            </p>
        </div>
        <div class="col-sm-6">
            <label>{$lang.Date}</label>
            <p>
                {$order.date_created|dateformat:$date_format}
            </p>
        </div>
        <div class="col-sm-6">
            <label>{$lang.Status}</label>
            <p>
                <label class="label label-{$order.status}">{$order.status}</label>
            </p>
        </div>
        {if $order.invoice_id}
            <div class="col-sm-6">
                <label>First Invoice</label>
                <p>
                    <a href="?cmd=invoices&action=edit&id={$order.invoice_id}">{$order.invoice_id|@invoice}</a>
                </p>
            </div>
        {/if}
    </div>
{/if}

{if $afforder.items}
    <label>Comissioned Items</label>
    <table class="table table-striped table-bordered">
        <tr>
            <th>Description</th>
            <th>Item price</th>
            <th>Commission plan / rate</th>
        </tr>
        {foreach from=$afforder.items item=item}
            <tr>
                <td>
                    <a href="{$item|@linkitem}" target="_blank"
                       style="white-space: pre-wrap">{$item.description}</a>
                </td>
                <td>
                    {$item.amount|price:$currency}
                </td>
                <td>
                    {if $item.plan}
                        {$item.plan.name}
                    {else} Custom
                    {/if}
                    {if $item.rateType}
                        / {$item.rate} {$item.rateType}
                    {/if}
                </td>
            </tr>
        {/foreach}
    </table>
{/if}

