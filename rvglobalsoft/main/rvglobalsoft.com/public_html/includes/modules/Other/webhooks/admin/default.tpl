{include file="head.tpl"}

<div class="blu">
    <div class="right"><div class="pagination"></div></div>
    <div class="clear"></div>
</div>

<a href="?cmd={$modulename}" id="currentlist" style="display:none"  updater="#updater"></a>
<table cellspacing="0" cellpadding="3" border="0" width="100%" class="table glike hover">
    <tbody>
        <tr>
            <th width="20" class="text-nowrap"><a href="?cmd={$modulename}&orderby=id|ASC" class="sortorder">#</a></th>
            <th><a href="?cmd={$modulename}&orderby=url|ASC" class="sortorder">URL</a></th>
            <th><a href="?cmd={$modulename}&orderby=name|ASC"  class="sortorder">Name</a></th>
            <th><a href="?cmd={$modulename}&orderby=status|ASC"  class="sortorder">Status</a></th>
            <th><a href="?cmd={$modulename}&orderby=created_at|ASC"  class="sortorder">Created</a></th>
            <th width="20"></th>
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
<div class="blu">
    <a href="?cmd={$modulename}&action=add" class="btn btn-default ">Add webhook</a>
    <div class="right"><div class="pagination"></div></div>
    <div class="clear"></div>
</div>

