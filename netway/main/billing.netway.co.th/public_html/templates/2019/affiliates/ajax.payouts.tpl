{if $logs}
    {foreach from=$logs item=log name=logs}
        <tr>
            <td data-label="{$lang.date}">{$log.date|dateformat:$date_format}</td>
            <td data-label="{$lang.withdrawn}">{$log.amount|price:$affiliate.currency_id}</td>
            <td data-label="{$lang.note}">{$log.note}</td>
        </tr>
    {/foreach}
{else}
    <tr class="table-content">
        <td class="text-center" colspan="3">{$lang.nothing}</td>
    </tr>
{/if}