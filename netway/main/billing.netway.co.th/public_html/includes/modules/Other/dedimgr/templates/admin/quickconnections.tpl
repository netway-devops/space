


<div class="blu">
    <div class="left">
        <a href="?cmd=dedimgr&do=quickconnections&export=1&security_token={$security_token}" class="btn btn-sm btn-default">Export to Excel</a>
    </div>
    <div class="right">
        <div class="pagination"></div>
    </div>
    <div class="clear"></div>
</div>

<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
<a href="?cmd=dedimgr&do=quickconnections" id="currentlist" style="display:none" updater="#updater"></a>
<table class="rack-list">
    <thead>
    <tr>
        <th><a href="?cmd=dedimgr&do=quickconnections&orderby=id|ASC" class="sortorder">Item</a></th>
        <th><a href="?cmd=dedimgr&do=quickconnections&orderby=client_id|ASC" class="sortorder">Owner</a></th>
        <th><a href="?cmd=dedimgr&do=quickconnections&orderby=account_id|ASC" class="sortorder">Service</a></th>
        <th>Location</th>
        <th>Connections</th>
        <th></th>
    </tr>
    </thead>
    <tbody id="updater">
        {include file="ajax.quickconnections.tpl"}
    </tbody>
</table>

<div class="blu">
    <div class="right">
        <div class="pagination"></div>
    </div>
    <div class="clear"></div>
</div>