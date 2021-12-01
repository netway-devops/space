{foreach from=$invoices item=invoice}

	{assign var=invoiceId value=$invoice.id}
    {if isset($aInvoiceDatas.$invoiceId.isHidden) && $aInvoiceDatas.$invoiceId.isHidden}
       {continue}
    {/if}

    <tr>
        {if $enableFeatures.bulkpayments!='off'}
            <td class="noncrucial">
                <input type="checkbox" class="checkme" value="{$invoice.id}" name="selected[]" {if $invoice.status != 'Unpaid' || $invoice.merge_id}disabled="disabled"{/if}>
            </td>
        {/if}
        <td  class="inline-row">
            <a href="{$ca_url}clientarea/invoice/{$invoice.id}/">
                #{$invoice|@invoice}
            </a>
        </td>
        <td  class="inline-row-right">
            <span class="badge badge-{$invoice.status}">{$lang[$invoice.status]}</span>
        </td>
        <td data-label="{$lang.total}: ">{$invoice.total|price:$invoice.currency_id}</td>
        <td data-label="{$lang.invoicedate}: ">{$invoice.date|dateformat:$date_format}</td>
        <td  class="noncrucial">
            {$invoice.duedate|dateformat:$date_format}
        </td>
        <td  class="noncrucial">
            <a href="{$ca_url}clientarea/invoice/{$invoice.id}/">
                <i class="material-icons icon-info-color">link</i>
            </a>
        </td>
    </tr>
{foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}