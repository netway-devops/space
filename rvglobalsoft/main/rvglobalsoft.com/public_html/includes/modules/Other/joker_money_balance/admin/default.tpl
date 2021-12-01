{include file="menu.tpl"}

<div class="blu">
    <div class="right"><div class="pagination"></div></div>
    <div class="clear"></div>
</div>
<a href="?cmd={$modulename}" id="currentlist" style="display:none"  updater="#updater"></a>
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
    <tbody>
    <tr>
        <th width="20" class="text-nowrap"><a href="?cmd={$modulename}&orderby=id|ASC" class="sortorder">#</a></th>
        <th><a href="?cmd={$modulename}&orderby=name|ASC" class="sortorder">Name</a></th>
        <th><a href="?cmd={$modulename}&orderby=api_key|ASC"  class="sortorder">API Key</a></th>
        <th><a href="?cmd={$modulename}&orderby=ote|ASC"  class="sortorder">Environment</a></th>
        <th><a href="?cmd={$modulename}&orderby=display|ASC"  class="sortorder">Status</a></th>
        <th width="200"></th>
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
    <div class="right"><div class="pagination"></div></div>
    <div class="clear"></div>
</div>
