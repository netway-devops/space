{foreach from=$logs item=log name=foo}
    <tr>
        <td>{$log.date|dateformat:$date_format}</td>
        <td>{$log.description}</td>
        <td  data-label="{$lang.increase}: ">{$log.in|price:$currency}</td>
        <td  data-label="{$lang.decrease}: ">{$log.out|price:$currency}</td>
        <td data-label="{$lang.creditafter}: ">{$log.balance|price:$currency}</td>
        <td  data-label="{$lang.related_invoice}: ">{if $log.invoice_id}<a href="{$ca_url}clientarea/invoice/{$log.invoice_id}/" target="_blank">{$log.invoice_id}</a>{else}-{/if}</td>
    </tr>
{foreachelse}
    <tr><td colspan="100%" class="text-center">{$lang.nothing}</td></tr>
{/foreach}