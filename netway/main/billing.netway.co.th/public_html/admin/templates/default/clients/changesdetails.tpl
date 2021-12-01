<h3>Client profile changes from {$details.date|dateformat:$date_format} by {$details.who}</h3>

<table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
    <tbody>
        <tr>
            <th>Field</th>
            <th>Old value</th>
            <th>New value</th>
        </tr>
        {foreach from=$details.change item=change key=field name=fl}
        <tr {if $smarty.foreach.fl.index%2==0}class="odd"{else}class="even"{/if}>
            <td><b>{if $lang.$field}{$lang.$field}{else}{$field}{/if}</b></th>
            <td class="lastitm">{$change.from}</td>
            <td class="lastitm">{$change.to}</td>
        </tr>

        {/foreach}
    </tbody>
</table>
