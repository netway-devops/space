<div class="blu">
    <div class="left menubar">
        With selected:
        <a href="#" queue="push" name="sync" class="submiter menuitm"><span><strong>Synchronize</strong></span></a>
    </div>
    <div class="clear"></div>
</div>
<a updater="#updater" style="display:none" id="currentlist" href="?cmd=plesk12"></a>
<form id="testform">
    <table class="glike hover" width="100%" cellspacing="0" cellpadding="3" border="0">
        <thead>
            <tr>
                <th width="20"><input type="checkbox" id="checkall"></th>
                <th>Account</th>
                <th>Product</th>
                <th>Synchronization</th>
                <th>User ID</th>
                <th>Subscription ID</th>
                <th></th>
            </tr>
        </thead>
        <tbody id="updater">
            {include file="ajax.default.tpl"}
        </tbody>
    </table>
</form>