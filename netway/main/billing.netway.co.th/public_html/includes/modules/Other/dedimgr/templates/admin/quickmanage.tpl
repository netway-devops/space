<script src="{$moduledir}js/quickmanage.js"></script>
{literal}
<style>
    .popover-content {
        max-width:410px;
    }
</style>{/literal}
<ul id="qm-port-menu" class="dropdown-menu">
    <li><a href="#refresh">Refresh port status</a></li>
    <li><a href="#up">Enable port</a></li>
    <li><a href="#down">Disable port</a></li>
</ul>
<div id="qm-graphs">
    <div class="ldaily lgraph"></div>
    <div class="lweekly lgraph"></div>
    <div class="lmonthly lgraph"></div>
</div>

<div id="filter-modal" style="display: none;">
    <form class="searchform filterform" action="?cmd=dedimgr&do=quickmanage" method="POST">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label>Device Category</label>
                    <select class="form-control" name="filter[category_id]">
                        <option value="">Any</option>
                        {foreach from=$categories item=cat}
                            <option value="{$cat.id}" 
                                    {if $currentfilter.category_id == $cat.id}selected{/if}
                                    >{$cat.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group">
                    <label>Device Type</label>
                    <select class="form-control" name="filter[type_id]">
                        <option value="">Any</option>
                        {foreach from=$types item=type}
                            <option value="{$type.id}" 
                                    data-category-id="{$type.category_id}"
                                    {if $currentfilter.type_id == $type.id}selected{/if}
                                    >{$type.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group">
                    <label>Colocation</label>
                    <select class="form-control" name="filter[colo_id]">
                        <option value="">Any</option>
                        {foreach from=$colocations item=colo}
                            <option value="{$colo.id}" 
                                    {if $currentfilter.colo_id == $colo.id}selected{/if}
                                    >{$colo.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group">
                    <label>Floor</label>
                    <select class="form-control" name="filter[floor_id]">
                        <option value="">Any</option>
                        {foreach from=$floors item=floor}
                            <option value="{$floor.id}" 
                                    data-colo-id="{$floor.colo_id}"
                                    {if $currentfilter.floor_id == $floor.id}selected{/if}
                                    >{$floor.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="form-group">
                    <label>Rack</label>
                    <select class="form-control" name="filter[rack_id]">
                        <option value="">Any</option>
                        {foreach from=$racks item=rack}
                            <option value="{$rack.id}" 
                                    data-flor-id="{$rack.floor_id}"
                                    data-colo-id="{$rack.colo_id}"
                                    {if $currentfilter.rack_id == $rack.id}selected{/if}
                                    >{$rack.name}</option>
                        {/foreach}
                    </select>
                </div>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <label>Label</label>
                    <input class="form-control" name="filter[label]" value="{$currentfilter.label}" type="text">
                </div>
                <div class="form-group">
                    <label>IP Address</label>
                    <input class="form-control" name="filter[ipaddress]" value="{$currentfilter.ipaddress}"  type="text">
                </div>
                <div class="form-group">
                    <label>Client ID</label>
                    <input class="form-control" name="filter[client_id]" value="{$currentfilter.client_id}"  type="text">
                </div>
                <div class="form-group">
                    <label>Account ID</label>
                    <input class="form-control" name="filter[account_id]" value="{$currentfilter.account_id}"  type="text">
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"  name="filter[graph]" value="1" {if $currentfilter.graphs}checked{/if}>
                        Has graphs assigned
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"  name="filter[pdu]" value="1" {if $currentfilter.pdu}checked{/if}>
                        Connected with pdu app
                    </label>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="filter[nic]" value="1" {if $currentfilter.nic}checked{/if} >
                        Connected with switch app
                    </label>
                </div>
            </div>
        </div>
    </form>
</div>

<div class="blu">
    <div class="right">
        <div class="pagination"></div>
    </div>
    <div class="clear"></div>
</div>

<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
<a href="?cmd=dedimgr&do=quickmanage" id="currentlist" style="display:none" updater="#updater"></a>
<table class="rack-list">
    <thead>
        <tr>
            <th>Label</th>
            <th>IP</th>
            <th>Power</th>
            <th>Switch</th>
            <th>Graphs</th>
            <th>Service</th>
            <th>Location</th>
            <th></th>
        </tr>
    </thead>
    <tbody id="updater">
        {include file="ajax.quickmanage.tpl"}
    </tbody>
</table>

<div class="blu">
    <div class="right">
        <div class="pagination"></div>
    </div>
    <div class="clear"></div>
</div>