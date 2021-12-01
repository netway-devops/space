<div class="bordered-section article">
    <h2>{$lang.transfers}</h2>
    {if $transfers}
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table table-striped  fullscreen">
            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>

            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>

            <colgroup class="firstcol"></colgroup>
            <colgroup class="alternatecol"></colgroup>
            <tbody>
            <tr>
                <th>{$lang.type}</th>
                <th>{$lang.name}</th>
                <th>{$lang.from|ucfirst}</th>
                <th>{$lang.date}</th>
                <th width="200"></th>
            </tr>
            </tbody>
            <tbody>
            {include file='ajax/ajax.transfers.tpl'}
            </tbody>
        </table>
    {else}
        <h3>{$lang.nothing}</h3>
    {/if}
</div>