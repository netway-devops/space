{foreach from=$zones item=zone key=zid}
    <tr>
        <td class="col-sm-1" value="{$zid}"><a href="?cmd={$modulename}&action=show&zone_id={$zid}&server_id={$server_id}&security_token={$security_token}">{$zone}</a></td>
        <td class="col-sm-1 text-center">{if isset($accounts.$zid)}<a href="?cmd=accounts&action=edit&id={$accounts.$zid.account_id}">{$accounts.$zid.account_id}</a>{else}-{/if}</td>
        <td class="col-sm-2">{if isset($clients.$zid)}<a href="?cmd=clients&action=show&id={$clients.$zid.client_id}">{$clients.$zid.firstname} {$clients.$zid.lastname}</a>{else}-{/if}</td>
        <td class="col-sm-1 text-right">
            <a onclick="return ask()" href="?cmd={$modulename}&action=deletezone&server_id={$server_id}&domain_id={$zid}&security_token={$security_token}{if isset($accounts.$zid)}&account_id={$accounts.$zid.account_id}{/if}">
                {$lang.delete|ucfirst}
            </a>

        </td>
        <td class="col-sm-1"><a href="?cmd=dnsimport&action=setup&server={$server_id}&security_token={$security_token}">
                {$lang.Import}
            </a></td>
    </tr>
{/foreach}
<tr>
    <th colspan="4" class="text-center">
        <strong>{$lang.records_per_page}</strong>
        <select name="domains_per_page" id="domains_per_page">
            <option value="10" {if $dns_per_page == 10}selected{/if}>10</option>
            <option value="25" {if $dns_per_page == 25}selected{/if}>25</option>
            <option value="50" {if $dns_per_page == 50}selected{/if}>50</option>
            <option value="100" {if $dns_per_page == 100}selected{/if}>100</option>
            <option value="100000" {if $dns_per_page == 100000}selected{/if}>All</option>
        </select>
    </th>
    <th colspan="1" style="text-align: right" id="psummary">
        <small>{$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span><small>
    </th>
</tr>
{literal}
<script>
    $('#domains_per_page').on('change', function () {
        var page = {dns_per_page: $(this).val()};
        $('#updater').addLoader();
        ajax_update("?cmd=dns_zone_editor&action=show&server={/literal}{$server}{literal}", page, $('#updater'), true);
    });
</script>
{/literal}