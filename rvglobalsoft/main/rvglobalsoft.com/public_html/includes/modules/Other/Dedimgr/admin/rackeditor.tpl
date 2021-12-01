
<script type="text/javascript" src="{$moduledir}jquery-ui-1.9.2.custom/js/jquery-ui-1.9.2.custom.min.js"></script>
<link rel="stylesheet" href="{$moduledir}jquery-ui-1.9.2.custom/css/ui-lightness/jquery-ui-1.9.2.custom.min.css" type="text/css" />

<script type="text/javascript" src="{$moduledir}popover/jquery.popover-1.1.2.js"></script>
<link rel="stylesheet" href="{$moduledir}popover/popover.css" type="text/css" />
<script type="text/javascript" src="{$moduledir}rack.js"></script>
<script type="text/javascript" src="{$template_dir}hbchat/media/mustache.js?v={$hb_version}"></script>

<input type="hidden" name="rack_id" value="{$rack.id}" id="rack_id" />

<h1>Colocation: <strong>
        <a href="?cmd=module&module={$moduleid}&do=floors&colo_id={$rack.colo_id}">{$rack.coloname}</a></strong>
    &raquo; Floor: <strong><a href="?cmd=module&module={$moduleid}&do=floor&floor_id={$rack.floor_id}">{$rack.floorname}</a> <em>{if $rack.room} Room: {$rack.room}{/if}</em></strong>
    &raquo; Rack: <strong><a href="?cmd=module&module={$moduleid}&do=rack&rack_id={$rack.id}">{$rack.name}</a> ({$rack.units} U)</strong> </h1>



<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td colspan="2"></td>
        <td colspan="2"><div style="padding:15px 14px 15px;">
                <a href="#" class="sorter-ha menuitm menuf" onclick="return editRack('{$rack.id}')"><span>Edit Rack </span></a><!--
                --><a class="menuitm menul" id="monitoringbtn" title="delete" onclick="loadMonitoring(); return false" href="#"><span class="">Monitoring</span></a>
            </div></td>
    </tr>
    <tr>
        <td valign="top" width="30" style="width:20px;">
            <table class="usizer" id="statuscol" cellpadding="0" cellspacing="0" width="20">
                <tbody>
                    <tr><td style="height:18px;">&nbsp;</td></tr>
                    {foreach from=$rack.positions item=i key=k} <tr><td pos="{$k}"></td></tr>{/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="30" style="width:28px;">
            <table class="usizer" id="rowcols" cellpadding="0" cellspacing="0" width="28">
                <tbody>
                    <tr><td style="height:18px;">&nbsp;</td></tr>
                    {foreach from=$rack.positions item=i key=k} <tr><td>{math equation="x + 1" x=$k}U</td></tr>{/foreach}
                </tbody>
            </table>
        </td>
        <td valign="top" width="250">

            <table class="racker" cellpadding="0" cellspacing="0">
                <tbody><tr><td class="rack_top"></td></tr></tbody>
                <tbody id="sortable">{foreach from=$rack.positions item=i key=k}
                    {if $i}

                    <tr class="have_items dragdrop" pos="{$k}" size="{$i.units}" label="{$i.hash}"><td class="rack_{$i.units}u contains" id="item_{$i.id}"  title="{if $i.label}{$i.label} - {/if}{$i.name}">
                            <div class="im_del"><div></div></div>
                            <div class="rackitem {$i.css} server{$i.units}u"><div class="lbl">{if $i.label}{$i.label}{else}{$i.category_name}{/if}</div></div>
                            <div class="im_edit"><div></div></div>
                            <div class="im_sorthandle"><div></div></div>
                        </td></tr>

                    {else}
                    <tr pos="{$k}" class="dragdrop" size="1"><td class="rack_1u canadd"><a class="newitem" href="#" onclick="return addRItem('{$k}')">Add new item</a></td></tr>
                    {/if}
                    {/foreach}
                </tbody>





                <tbody><tr><td class="rack_bottom"></td></tr></tbody>


            </table>
        </td>

        <td valign="top" id="former">
            <div id="addnewitem" style="display:none" class="p6">


            </div>
        </td>
    </tr>
    <tr><td class="floor" colspan="3" align="center">
            <h3>Rack: {$rack.name}</h3>

        </td>
        <td style="background:#fff;padding-left:20px" valign="top">
            <span style="padding-right:20px">Total power: {$rack.power} W </span>
            <span style="padding-right:20px">Total current: {$rack.current} A </span>
            <span style="padding-right:20px">Total weight: {$rack.weight} lbs </span>
            <span style="padding-right:20px">Est. monthly: {$rack.monthly_cost} {$currency.code} </span>
        </td>
    </tr>
</table>
<div id="monitoringdata" style="display:none">
    
</div>{literal}
<div id="mustache" style="display:none">
    <textarea id="hb_status_item">
        <table border="0" cellspacing="0" cellpadding="0" width="730" class="statustable">
            <tr>
                <th>Service</th>
                <th>Status</th>
                <th>Last Check</th>
                <th>Duration</th>
                <th>Attempt</th>
                <th>Info</th>
            </tr>

                        {{#services}}
                        <tr class="rowstatus-{{status}}">
                            <td>{{service}}</td>
                            <td>{{status}}</td>
                            <td>{{lastcheck}}</td>
                            <td>{{duration}}</td>
                            <td>{{attempt}}</td>
                            <td>{{info}}</td>
                        </tr>
                        {{/services}}
        </table>
    </textarea>
</div>
{/literal}
{if $expand}
{literal}
<script>
    $(document).ready(function(){
        editRackItem('{/literal}{$expand}{literal}');
    });
</script>
{/literal}
{/if}