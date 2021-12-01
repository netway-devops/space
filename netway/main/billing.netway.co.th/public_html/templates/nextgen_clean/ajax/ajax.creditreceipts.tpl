{foreach from=$receipts item=receipt}
    <tr>
        {if $enableFeatures.bulkpayments!='off'}
            <td>
                <input type="checkbox" class="checkme" value="{$receipt.id}" name="selected[]" {if $receipt.status != 'Receiptunpaid' || $invoice.merge_id}disabled="disabled"{/if}>
            </td>
        {/if}
        <td>
            <span class="label flat-ui-label label-{$receipt.status}">{$lang[$receipt.status]}</span>
        </td>
        <td  class="bold invoice-c">
            <a href="{$ca_url}clientarea/invoice/{$receipt.id}/">
                #{$receipt|@invoice}
            </a>
        </td>
        <td>{$receipt.total|price:$receipt.currency_id}</td>
        <td>{$receipt.date|dateformat:$date_format}</td>
        <td>
            {$receipt.duedate|dateformat:$date_format}
        </td>
        <td align="center"><a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank" class="view3">{$lang.view}</a></td>
    </tr>
    {foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}