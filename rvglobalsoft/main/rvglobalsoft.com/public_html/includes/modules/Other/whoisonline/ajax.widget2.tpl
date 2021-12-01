{if !$clients}
    No clients found
{else}
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table table-fixed whitetable" style="">
        <tbody>
        <tr>
            <th width="15%">Id</th>
            <th>Client</th>
            <th>IP</th>
            <th>Last seen</th>
        </tr>
        {foreach from=$clients item=client name=foo}
            <tr class="{if $smarty.foreach.foo.index%2 == 0}even {else}odd {/if}">
                <td width="15%"><a href="?cmd=clients&action=show&id={$client.id}" target="_blank">{$client.id}</a></td>
                <td>{$client|@profilelink:true}</td>
                <td><span><a href="https://geoiptool.com/en/?IP={$client.ip}" target="_blank">{$client.ip}</a></span></td>
                <td>{$client.lastseen}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
{/if}