{foreach from=$invoices item=invoice}
{assign var="invoiceId" value=$invoice.id}

    <tr data-flags="{$invoice.flags}">
        <td><input type="checkbox" class="check" value="{$invoice.id}" name="selected[]"/></td>
        {if $currentlist!='recurring'}
            {if $eumethod && $currentlist != 'receiptpaid' && $currentlist != 'receiptunpaid' && $currentlist != 'receiptcanceled' && $currentlist != 'creditnote'}
                <td>
                    <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" data-pjax rel="{$invoice.id}">
                       {$invoice|@invoice_proforma}
                    </a>
                </td>
                <td>
                    <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" data-pjax rel="{$invoice.paid_id}">
                        {$invoice.paid_id}
                    </a>
                </td>
            {elseif $eumethod && ($currentlist == 'receiptpaid' || $currentlist == 'receiptunpaid' || $currentlist == 'receiptcanceled' || $currentlist == 'creditnote')}
                <td>
                    <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" data-pjax rel="{$invoice.id}">
                        {if $invoice.paid_id} {$invoice.paid_id} {else} {$invoice|@invoice} {/if}
                    </a>
                </td>
            {else}
                <td>
                    <a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" data-pjax rel="{$invoice.id}">
                        {$invoice|@invoice}
                    </a>
                </td>
            {/if}
            <td>{$aInvoiceDetails.$invoiceId.invoice_number} {$aInvoiceDetails.$invoiceId.sim_number}</td>
            <td>
                {if $invoice.client_id}
                    {$invoice|@profilelink:true:true}
                {else}
                    <span style="font-style: italic">{$lang.no_clients_attached}</span>
                {/if}
                {if $aInvoiceNotify[$invoiceId]} <small style="color:red;">* ยังไม่มีแจ้งเตือน</small><br /> {/if}
                 <small>{$aInvoiceServices[$invoiceId]}</small>
            </td>
            <td>{$invoice.date|dateformat:$date_format}</td>
            <td>{$invoice.duedate|dateformat:$date_format}</td>
            <td>{$invoice.grandtotal|price:$invoice.currency_id}</td>
            <td>
                {if $invoice.credit>0 && $invoice.credit>=$invoice.subtotal2}
                    {$lang.paidbybalance}
                {else}
                    {$invoice.module|default:"`$lang.none`"} 
                    {if $invoice.credit>0}<span class="fs11">+ {$lang.paidbybalance}</span>{/if}
                {/if}
            </td>
            <td><span class="{$invoice.status}">{if $lang[$invoice.status]}{$lang[$invoice.status]}{else}{$invoice.status}{/if}</span></td>
            <td>
                {if $invoice.locked}
                    <a href="?cmd=invoices&action=menubutton&make=unlock&id={$invoice.id}"
                       title="This invoice is currently hidden in client area, click to unlock" class="invoiceUnlock padlock"></a>
                {/if}
            </td>
        {else}
            <td><a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}"  data-pjax  rel="{$invoice.id}">{$invoice.recurring_id}</a></td>
            <td>{$invoice|@profilelink:true:true}</td>
            <td>{$invoice.grandtotal|price:$invoice.currency_id}</td>
            <td>{$invoice.start_from|dateformat:$date_format}</td>
            <td>
                {if $invoice.recstatus!='Stopped' &&  $invoice.next_invoice!='' && $invoice.next_invoice!='0000-00-00' && ($invoice.invoices_left || !$invoice.occurrences)}
                    {$invoice.next_invoice|dateformat:$date_format} ({if $invoice.invoices_left && $invoice.occurrences}{$invoice.invoices_left}
                    {else}&#8734;
                    {/if} {$lang.remaining})
                {else}-
                {/if}
            </td>
            <td>{$invoice.module}</td>
            <td>{$lang[$invoice.frequency]}</td>
        {/if}
        <td><a href="?cmd=invoices&action=edit&id={$invoice.id}&list={$currentlist}" data-pjax class="editbtn" rel="{$invoice.id}">{$lang.Edit}</a></td>
        <td>
            {if !$forbidAccess.deleteInvoices}
                <a href="?cmd=invoices&action=menubutton&make=deleteinvoice&id={$invoice.id}" class="deleteInvoice delbtn">delete</a>
            {/if}
        </td>
    </tr>
{foreachelse}
    <tr>
        <td colspan="11"><p align="center" > {$lang.nothingtodisplay} </p></td>
    </tr>
{/foreach}