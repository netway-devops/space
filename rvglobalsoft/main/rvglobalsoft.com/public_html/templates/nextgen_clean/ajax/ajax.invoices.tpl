{if $invoices}
    {foreach from=$invoices item=invoice name=foo}
         <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
              {if $enableFeatures.bulkpayments!='off'}
                <td align="center">
                    <input type="checkbox" value="{$invoice.id}" name="selected[]" {if $invoice.status != 'Unpaid' || $invoice.merge_id}disabled="disabled"{/if}>
                </td>
              {/if}
              <td align="center">
                  <span class="label label-{$invoice.status}">{$lang[$invoice.status]}</span>
              </td>
              <td><a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank">{$invoice|@invoice}</a></td>
              <td >{$invoice.total|price:$invoice.currency_id}</td>
              <td align="center">{$invoice.date|dateformat:$date_format}</td>
              <td align="center">{$invoice.duedate|dateformat:$date_format}</td>
              <td align="center"><a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank" class="view3">{$lang.view}</a></td>
        </tr>
    {/foreach}
{/if}