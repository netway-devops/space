{foreach from=$receipts item=receipt}
    <tr>
        {if $enableFeatures.bulkpayments!='off'}
            <td class="noncrucial">
                <input type="checkbox" class="checkme" value="{$receipt.id}" name="selected[]" {if $receipt.status != 'Receiptunpaid' || $invoice.merge_id}disabled="disabled"{/if}>
            </td>
        {/if}
        <td  class="inline-row">
            <a href="{$ca_url}clientarea/invoice/{$receipt.id}/">
                #{$receipt|@invoice}
            </a>
        </td>
        <td  class="inline-row-right">
            <span class="badge badge-{$receipt.status}">{$lang[$receipt.status]}</span>
        </td>
        <td data-label="{$lang.total}: ">{$receipt.total|price:$receipt.currency_id}</td>
        <td data-label="{$lang.invoicedate}: ">{$receipt.date|dateformat:$date_format}</td>
        <td  class="noncrucial">
            {$receipt.duedate|dateformat:$date_format}
        </td>
        <td  class="noncrucial">
            <a href="{$ca_url}clientarea/invoice/{$receipt.id}/">
                <i class="material-icons icon-info-color">link</i>
            </a>
        </td>
    </tr>
    {foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}