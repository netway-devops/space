{if $invoices}
    {foreach from=$invoices item=invoice name=foo}
	{assign var=invoiceId value=$invoice.id}
    {if isset($aInvoiceDatas.$invoiceId.isHidden) && $aInvoiceDatas.$invoiceId.isHidden}
       {continue}
    {/if}
         <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if} valign="top">
              <td><span class="label label-{$invoice.status}">{$lang[$invoice.status]}</span></td>
              <td class="cell-border">
                  <a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank">{if $proforma && ($invoice.status=='Paid' || $invoice.status=='Refunded') && $invoice.paid_id!=''}{$invoice.paid_id}{else}{$invoice.date|invprefix:$prefix}{$invoice.id}{/if}</a>
			  </td>
              <td class="cell-border">{$invoice.total|price:$invoice.currency_id}</td>
              <td class="cell-border">{$invoice.date|date_format:'%d %b %Y'}</td>
              <td class="cell-border">{$invoice.duedate|date_format:'%d %b %Y'}</td>
              <td class="cell-border"><a href="{$ca_url}clientarea/invoice/{$invoice.id}/" target="_blank" class="view3">{$lang.view}</a></td>
        </tr>
    {/foreach}
{/if}