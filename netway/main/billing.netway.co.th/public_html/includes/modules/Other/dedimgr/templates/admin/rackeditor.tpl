
<!--<script type="text/javascript" src="{$moduledir}js/jquery-ui-1.9.2.custom.min.js"></script>-->
<!--<link rel="stylesheet" href="{$moduledir}css/ui-lightness/jquery-ui-1.9.2.custom.min.css" type="text/css" />-->

<link rel="stylesheet" href="{$moduledir}css/popover.css" type="text/css" />
<script type="text/javascript" src="{$moduledir}js/jquery.popover.js"></script>
<script type="text/javascript" src="{$moduledir}js/rack.js"></script>
<script type="text/javascript" src="{$template_dir}hbchat/media/mustache.js?v={$hb_version}"></script>

{if $inventory_manager}
    <link rel="stylesheet" type="text/css" media="screen" href="{$moduleliburl}jqgrid/css/ui.jqgrid.css" />
    <script src="{$moduleliburl}jqgrid/js/grid.locale-en.js" type="text/javascript"></script>
    <script src="{$moduleliburl}jqgrid/js/jquery.jqGrid.min.js" type="text/javascript"></script>
{/if}
{if $monitoring_data}
    <script type="text/javascript">
        $.extend(MonitoringData, {$monitoring_data} || {literal}{}{/literal}) ;;
        {literal}
        $(function(){
            loadMonitoring(MonitoringData);
        });
        {/literal}
    </script>
{/if}
<input type="hidden" name="rack_id" value="{$rack.id}" id="rack_id" />

<h1>Colocation: <strong>
        <a href="?cmd=dedimgr&do=floors&colo_id={$rack.colo_id}">{$rack.coloname}</a></strong>
    &raquo; Floor: <strong><a href="?cmd=dedimgr&do=floor&floor_id={$rack.floor_id}">{$rack.floorname}</a> <em>{if $rack.room} Room: {$rack.room}{/if}</em></strong>
    &raquo; Rack: <strong><a href="?cmd=dedimgr&do=rack&rack_id={$rack.id}">{$rack.name}</a> ({$rack.units} U)</strong> </h1>

<p id="rackview_switch">
    <a class="menuitm menu-auto {if !$rackview}activated{/if}" href="?cmd=dedimgr&do=listview&rel=rack&id={$rack.id}" data-rel="rack_view">Details</a>
    <a class="menuitm menu-auto {if $rackview=='list'}activated{/if}" href="?cmd=dedimgr&do=listview&rel=rack&id={$rack.id}&type=list" data-rel="rack_list">List</a>
    <a class="menuitm menu-auto {if $rackview=='ipam'}activated{/if}" href="?cmd=dedimgr&do=listview&rel=rack&id={$rack.id}&type=ipam" data-rel="rack_ipam">IPAM</a>
</p>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_ipam">
    <tr>
        <th>Position</th>
        <th>Device</th>
        <th>Port</th>
        <th>Ip</th>
        <th>Subnet / VLAN</th>
        <th></th>
    </tr>
    {foreach from=$rackips item=i}
        <tr class="rack-list-item">
            <td class="rack-list-u">
                <div>
                    {math equation="x + 1" x=$i.position}
                </div>
            </td>
            <td>
                {$i.item.category_name}: {$i.item.name} - {$i.item.label}
            </td>
            <td>
                <div onclick="getportdetails({$i.id})" class="port "><div>{$i.number}</div></div>
            </td>
            <td>{$i.ipaddress}</td>
            <td class="rack-list-ca">
                {if !$i.ipam}
                    <em>No ipam module</em>
                {else}
                    <em>Subnet: {if $i.subnet_id}<a href="?cmd=module&module=ipam&action=details&group={$i.subnet_id}" target="_blank">{$i.subnet_name}</a>{else}None{/if}</em>
                    <em>VLAN: {if $i.vlan_id}<a href="?cmd=module&module=ipam&action=vlan_details&group={$i.vlan_id}" target="_blank">{$i.vlan_name}</a>{else}None{/if}</em>
                {/if}
            </td>
            <td class="rack-list-act">
                <div>
                    <a href="?cmd=dedimgr&do=itemeditor&item_id={$i.item_id}" class="menuitm menu" title="Edit" ><span class="editsth"></span></a></a>
                </div>
            </td>
        </tr>
    {/foreach}
    <tr>
        <td colspan="10">
            <span style="padding-right:20px">Total power: {$rack.power} W </span>
            <span style="padding-right:20px">Total current: {$rack.current} A </span>
            <span style="padding-right:20px">Total weight: {$rack.weight} lbs </span>
            <span style="padding-right:20px">Est. monthly: {$rack.monthly_cost} {$currency.code} </span>
        </td>
    </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_list">
    <tr>
        <th>Position</th>
        <th>Device</th>
        <th>Label</th>
        <th>Units</th>
        <th>Assigment</th>
        <th>Server pool</th>
        <th></th>
    </tr>
    {foreach from=$rack.positions item=positions key=location}
        <tbody>
        {if $location!='Front'}
            <tr><th colspan="7">{if $lang[$location]}{$lang[$location]}{else}{$location}{/if}</th></tr>
        {/if}
        {foreach from=$positions item=i}
            {if $i}
                <tr class="rack-list-item">
                    <td class="rack-list-u">
                        <div>
                            {math equation="x + 1" x=$i.position}
                        </div>
                    </td>
                    <td>{$i.category_name}: {$i.name}</td>
                    <td>{$i.label}</td>
                    <td>{$i.units}U</td>
                    <td class="rack-list-ca">
                        <em>Client: {if $i.client_id}<a href="?cmd=clients&action=show&id={$i.client_id}" >#{$i.client_id} {$i.firstname} {$i.lastname}</a>{else}None{/if}</em>
                        <em>Account: {if $i.account_id}<a href="?cmd=accounts&action=edit&id={$i.account_id}" >#{$i.account_id} {$i.domain}</a>{else}None{/if}</em>
                    </td>
                    <td>
                        {if !$i.pool_id}None{else}
                            {foreach from=$pools item=pool}
                                {if $i.pool_id == $pool.id}
                                    #{$pool.id} {$pool.name}{break}
                                {/if}
                            {/foreach}
                        {/if}
                    </td>
                    <td class="rack-list-act">
                        <div>
                            <a href="?cmd=dedimgr&do=itemeditor&item_id={$i.id}"  class="menuitm menu-auto" title="Edit"><span class="editsth"></span></a>
                            <a class="menuitm menu-auto" title="delete" onclick="return confirm('Are you sure you want to remove this item?');" href="?cmd=dedimgr&do=rack&make=delitem&id={$i.id}&rack_id={$rack.id}"><span class="delsth"></span></a>
                        </div>
                    </td>
                </tr>
                {foreach from=$i.bladeitems item=g name=blade}
                    <tr class="rack-list-item blade">
                        <td class="rack-list-u">
                            <div>{if $smarty.foreach.blade.last}&#x2514;{else}&#x251c;{/if}</div>
                        </td>
                        <td>{$g.category_name}: {$g.name}</td>
                        <td>{$g.label}</td>
                        <td>-</td>
                        <td class="rack-list-ca">
                            <em>Client: {if $g.client_id}<a href="?cmd=clients&action=show&id={$g.client_id}" >#{$g.client_id} {$g.firstname} {$g.lastname}</a>{else}None{/if}</em>
                            <em>Account: {if $g.account_id}<a href="?cmd=accounts&action=edit&id={$g.account_id}" >#{$g.account_id} {$g.domain}</a>{else}None{/if}</em>
                        </td>
                        <td>
                            {if !$i.pool_id}None{else}
                                {foreach from=$pools item=pool}
                                    {if $i.pool_id == $pool.id}
                                        #{$pool.id} {$pool.name}{break}
                                    {/if}
                                {/foreach}
                            {/if}
                        </td>
                        <td class="rack-list-act">
                            <div>
                                <a href="?cmd=dedimgr&do=itemeditor&item_id={$i.id}"  class="menuitm menu-auto" title="Edit" ><span class="editsth"></span></a>
                                <a class="menuitm menu-auto" title="delete" onclick="return confirm('Are you sure you want to remove this item?');" href="?cmd=dedimgr&do=rack&make=delitem&id={$i.id}&rack_id={$rack.id}"><span class="delsth"></span></a>
                            </div>
                        </td>
                    </tr>
                {/foreach}
            {/if}
        {/foreach}
        </tbody>
    {/foreach}
    <tr>
        <td colspan="10">
            <span style="padding-right:20px">Total power: {$rack.power} W </span>
            <span style="padding-right:20px">Total current: {$rack.current} A </span>
            <span style="padding-right:20px">Total weight: {$rack.weight} lbs </span>
            <span style="padding-right:20px">Est. monthly: {$rack.monthly_cost} {$currency.code} </span>
        </td>
    </tr>
</table>
<div class="row" id="rack_view">
    <div class="col-lg-6">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" >
            <tr>
                <td colspan="2"></td>
                <td colspan="3" class="text-center"><label style="font-size: 15px;">Front view</label></td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td colspan="3" class="rack-header">
                    <a href="#<<" title="Expand left side" onclick="return expandRack('l')"><i class="fa fa-caret-square-o-left"></i></a>
                    <a href="#>>" title="Expand right side" onclick="return expandRack('r')" class="right"><i class="fa fa-caret-square-o-right"></i></a>
                    <a href="#edit" title="Edit rack details" onclick="return editRack('{$rack.id}')"><i class="fa fa-pencil-square"></i></a>
                    <a href="#monitoring" title="Load monitoring" id="monitoringbtn" onclick="loadMonitoring();return false" ><i class="fa fa-refresh"></i></a>
                </td>
                <td></td>
            </tr>
            <tr>
                <td valign="top" width="30">
                    <table class="rack-table" id="statuscol" cellpadding="0" cellspacing="0" width="20">
                        <tbody>
                        {foreach from=$rack.positions.Front item=i key=k}
                            <tr>
                                <td pos="{$k}"></td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </td>
                <td valign="top" width="30">
                    <table class="rack-table rack-u-legend" id="rowcols" cellpadding="0" cellspacing="0" width="28">
                        <tbody>
                        {foreach from=$rack.positions.Front item=i key=k}
                            <tr><td>{math equation="x + 1" x=$k}U</td></tr>
                        {/foreach}
                        </tbody>
                    </table>
                </td>
                <td valign="top" width="1" >
                    <div class="rack-mount">
                        <div class="rack-side rack-side-l">
                            {foreach from=$rack.positions.Lside item=i key=k name=cols}
                            {if $smarty.foreach.cols.index % $rack.units ==0}{if !$smarty.foreach.cols.first}</div>{/if}<div class="col-group">{/if}
                            {if $i}
                                {include file="rack_item.tpl"}
                            {else}
                                <div class="newitem"></div>
                            {/if}
                            {/foreach}
                        </div><!-- col-group -->
                    </div>
                </td>
                <td valign="top" width="200" >
                    <table class="rack-front" cellpadding="0" cellspacing="0">
                        <tbody class="sortable" data-location="Front">
                        {foreach from=$rack.positions.Front item=i key=k}
                            {if $i}
                                <tr class="have_items dragdrop" data-position="{$k}" data-units="{$i.units}" data-id="{$i.id}" data-depth="{$i.depth}" label="{$i.hash}">
                                    <td class="rack_{$i.units}u contains rack-row" id="item_{$i.id}" >
                                        {include file="rack_item.tpl" orientation=0}
                                    </td>
                                </tr>
                            {else}
                                <tr data-position="{$k}" class="dragdrop" data-units="1">
                                    <td class="rack_1u canadd">
                                        <a class="newitem" href="#" >Add new item</a>
                                    </td>
                                </tr>
                            {/if}
                        {/foreach}
                        </tbody>
                    </table>
                </td>
                <td valign="top" width="1" >
                    <div class="rack-mount">
                        <div class="rack-side rack-side-r">
                            {foreach from=$rack.positions.Rside item=i key=k name=cols}
                            {if $smarty.foreach.cols.index % $rack.units ==0}{if !$smarty.foreach.cols.first}</div>{/if}<div class="col-group">{/if}
                            {if $i}
                                {include file="rack_item.tpl"}
                            {else}
                                <div class="newitem"></div>
                            {/if}
                            {/foreach}
                        </div><!-- col-group -->
                    </div>
                </td>
                <td valign="top" id="former" style="padding-left:10px">
                    <b>{$rack.name} Summary:</b>
                    <div  class="p6" style="width:180px;margin-bottom:10px">
                        <span style="padding-right:20px">Total power: {$rack.power} W </span> <br/>
                        <span style="padding-right:20px">Total current: {$rack.current} A </span><br/>
                        <span style="padding-right:20px">Total weight: {$rack.weight} lbs </span><br/>
                        <span style="padding-right:20px">Est. monthly: {$rack.monthly_cost} {$currency.code} </span>
                    </div>
                    <b>0U devices mounted:</b>
                    <div style="width:200px;margin-bottom:10px">
                        <table class="rack-front" cellpadding="0" cellspacing="0">
                            <tbody data-location="Zero">{foreach from=$rack.positions.Zero item=i key=k}
                                {if $i}
                                    <tr class="have_items dragdrop" data-position="{$k}" data-units="1" data-id="{$i.id}" label="{$i.hash}">
                                        <td class="rack_{$i.units}u contains rack-row" id="item_{$i.id}" >
                                            {include file="rack_item.tpl" orientation=0}
                                        </td>
                                    </tr>
                                {else}
                                    <tr data-position="{$k}" class="dragdrop" data-units="1">
                                        <td class="rack_1u canadd">
                                            <a class="newitem" href="#" onclick="return false">Add new item</a>
                                        </td>
                                    </tr>
                                {/if}
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2"></td>
                <td class="rack-floor" colspan="3" align="center">
                    <h3>Rack: {$rack.name}</h3>
                </td>
                <td style="padding-left:20px" valign="top"></td>
            </tr>
        </table>
    </div>
    <div class="col-lg-3">
        {include file="ajax.rackeditor.tpl" name="Side view" loc="Side" locclass='fside'}
    </div>
    <div class="col-lg-3">
        {include file="ajax.rackeditor.tpl" name="Rear view" loc="Back" locclass='back'}
    </div>
</div>
<script type="text/javascript">
    initRack();
    {if $expand}
    {literal}
    $(document).ready(function() {
        editRackItem('{/literal}{$expand}{literal}');
    });
    {/literal}
    {/if}
</script>