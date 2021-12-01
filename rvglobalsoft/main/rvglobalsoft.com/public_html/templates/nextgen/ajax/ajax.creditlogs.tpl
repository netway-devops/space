
{if $logs}
    {foreach from=$logs item=log name=foo}
        <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
            <td align="center">{$log.date|dateformat:$date_format}</td>
            <td align="center">{$log.description}</td>
            <td align="center">{$log.in|price:$currency}</td>
            <td align="center">{$log.out|price:$currency}</td>
            <td align="center">{$log.balance|price:$currency}</td>
            <td align="center">{if $log.invoice_id}<a href="{$ca_url}clientarea/invoice/{$log.invoice_id}/" target="_blank">{$log.invoice_id}</a>{else}-{/if}</td>
        </tr>
    {/foreach}
{/if}