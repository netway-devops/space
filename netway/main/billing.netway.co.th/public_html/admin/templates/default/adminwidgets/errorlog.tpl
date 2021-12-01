<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table table-fixed whitetable" style="">
    <tbody>
    <tbody>
    <tr>
        <th >Error</th>
    </tr>
    </tbody>
    {foreach from=$errorlog item=request name=loop}
        <tr class="{if $request.notseen}notseen{/if}">
            <td><div class="errorless fs11">{$request.date|dateformat:$date_format}
                    <pre>{$request.entry|escape}</pre></div></td>
        </tr>
        {foreachelse}
        <tr>
            <td colspan="3">
                Nothing found
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>

