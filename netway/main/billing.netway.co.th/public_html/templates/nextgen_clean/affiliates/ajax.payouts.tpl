{if $logs}
    {foreach from=$logs item=log name=logs}
        <tr {if $smarty.foreach.logs.index%2 == 0}class="even"{/if}>

            <td style="text-align:center">{$log.date|dateformat:$date_format}</td>
            <td style="text-align:center">{$log.amount|price:$affiliate.currency_id}</td>
            <td style="width:50%">{$log.note}</td>
        </tr>
    {/foreach}
    <tr>
        <th colspan="3" style="text-align: right">
            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.pageof} <span id="sorterrecords">{$sorterrecords}</span>
        </th>
    </tr>
{else}
    <tr class="even">
        <td colspan="12" style="text-align: center">{$lang.nothing}</td>
    </tr>
{/if}