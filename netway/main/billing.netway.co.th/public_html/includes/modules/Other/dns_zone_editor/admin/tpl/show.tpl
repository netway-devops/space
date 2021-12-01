<form method="POST" action="">
    <input type="hidden" value="{$server|escape}" name="server">
    {if !$zones}
        <p class="error">
            There are no DNS zones for this server.
        </p>
        <a class="dns-btn" href="?cmd={$modulename}&security_token={$security_token}" >Go Back</a>
    {else}
        <p class="info">Found {$zones_count} zone(s)</p>
        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="clear"></div>
        </div>
        <a href="?cmd={$modulename|strtolower}&action=show&server={$server|escape}" id="currentlist" style="display:none"  updater="#updater"></a>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>
                    <a href="?cmd={$modulename|strtolower}&action=show&server={$server|escape}&orderby=name|ASC" class="sortorder">Zone(s)</a>
                </th>
                <th class="text-center">
                    <strong>{if isset($lang.AccountId)}{$lang.AccountId}{else}Account Id{/if}</strong>
                </th>
                <th>
                    <strong>{$lang.Client}</strong>
                </th>
            </tr>
            </thead>
            <tbody id="updater">
                {include file='tpl/ajax.show.tpl'}
            </tbody>
        </table>
        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages">
        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="clear"></div>
        </div>
        {securitytoken}
    {/if}
</form>

<br>
<div class="row">
    <form action="?cmd={$modulename}&action=addzone" method="post" class="form-horizontal">
        <div class="form-group">
            <input type='hidden' name="server_id" value="{$server_id}" class="form-control" readonly>
            <input type='hidden' name="domain_id" value="{$zone_id}" class="form-control" readonly>
            <div class="col-sm-1" style="margin-left: 20px;">
                <button type="submit" value="true" class="btn btn-success">{if isset($lang.adddomain)}{$lang.adddomain}{else}Add domain{/if}</button>
            </div>
            <div class="col-sm-2" style="margin-left: 20px;">
                <a class="btn btn-info" href="?cmd={$modulename}&security_token={$security_token}&refresh=1&action=show&server={$server_id}" >Refresh listing</a>
                <a class="btn btn-default" href="?cmd={$modulename}" >Go Back</a>
            </div>
        </div>
        {securitytoken}
    </form>
