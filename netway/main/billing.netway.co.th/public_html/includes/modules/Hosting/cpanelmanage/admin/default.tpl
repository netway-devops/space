<div id="newshelfnav" class="newhorizontalnav" >
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a href="?cmd={$modulename}"><span>{$modname}</span></a>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript" src="{$moduleurl}script.js"></script>
<form action="" method="post">
    <div class="blu">
        <div class="left">
            {if $licenses}
                <button type="button" class="btn btn-sm btn-success do-check" data-action="check">Check Licenses</button>
                <button type="button" class="btn btn-sm btn-warning do-check-all" data-action="check_all">Check All Licenses</button>
            {/if}
            <a href="?cmd=cpanelmanage&action=get_licenses" class="btn btn-sm btn-primary">Get Available Licenses</a>
        </div>
        <div class="right"><div class="pagination"></div></div>
        <div class="clear"></div>
    </div>
    <a href="?cmd={$modulename}" id="currentlist" style="display:none"  updater="#updater"></a>
    <table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
        <tbody>
        <tr>
            <th width="20" class="text-nowrap"><input type="checkbox" class="check-all" value="1"></th>
            <th><a href="?cmd={$modulename}&orderby=ip|ASC" class="sortorder">IP</a></th>
            <th><a href="?cmd={$modulename}&orderby=status|ASC"  class="sortorder">Status</a></th>
            <th><a href="?cmd={$modulename}&orderby=account_id|ASC"  class="sortorder">Account</a></th>
            <th>Client</th>
            <th><a href="?cmd={$modulename}&orderby=date|ASC"  class="sortorder">Last check</a></th>
            <th><a href="?cmd={$modulename}&orderby=ip|ASC"  class="sortorder">Link</a></th>
            <th><a href="?cmd={$modulename}&orderby=error|ASC"  class="sortorder">Error</a></th>
        </tr>
        </tbody>
        <tbody id="updater">
            {include file='ajax.default.tpl'}
        </tbody>
        <tbody id="psummary">
        <tr>
            <th></th>
            <th colspan="9">
                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
            </th>
        </tr>
        </tbody>
    </table>
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages">
    <div class="blu">
        <div class="left">
            {if $licenses}
                <button type="button" class="btn btn-sm btn-success do-check" data-action="check">Check Licenses</button>
                <button type="button" class="btn btn-sm btn-warning do-check-all" data-action="check_all">Check All Licenses</button>
            {/if}
            <a href="?cmd=cpanelmanage&action=get_licenses" class="btn btn-sm btn-primary">Get Available Licenses</a>
        </div>
        <div class="right"><div class="pagination"></div></div>
        <div class="clear"></div>
    </div>
    {securitytoken}
    <div id="task-progress"></div>
</form>