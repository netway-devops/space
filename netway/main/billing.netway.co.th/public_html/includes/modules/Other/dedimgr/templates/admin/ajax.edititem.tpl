{if $monitoring_data}
    <script type="text/javascript">MonitoringData['{$item.hash}'] = {$monitoring_data};</script>
{/if}
<script type="text/javascript" src="{$moduledir}js/edititem.js"></script>
<script type="text/javascript" src="{$moduledir}js/quickmanage.js"></script>
<link href="{$moduledir}css/edititem.css" rel="stylesheet"  type="text/css"/>

<div id="ticketbody" style="border-top:none;margin-bottom:10px;">
    <div>
        <h1 class="left" style="margin: 20px 5px;">#{$item.id} {$item.category_name} - {$item.name} {if $item.label}&raquo; {$item.label}{/if}  </h1>
        <div class="left" style="margin: 18px 10px; position: relative;max-width: 200px;">
            <div class="qm-pdu-list qm-btn-group {if $item_ports|@count > 1}multi{/if}">
                {foreach from=$item_ports item=port}
                    <div class="dropdown"
                         data-port-id="{$port.managed_port}">
                        <a class="qm-port qm-port-{if $port.port_status==1}up{elseif $port.port_status==0}down{else}unknown{/if} btn btn-xs"
                           title="{if $port.port_status==1}On{elseif $port.port_status==0}Off{else}Unknown{/if}"
                           data-toggle="dropdown">
                            <span class="number">{$port.number}</span>
                            <span class="status">{if $port.port_status==1}on{elseif $port.port_status==0}off{else}unknown{/if}</span>
                            <span class="caret"></span>
                        </a>
                    </div>
                {/foreach}

                {if $item_ports|@count > 4}
                    <div class="dropdown qm-width"></div>
                    <a class="btn btn-xs qm-port qm-port-unknown qm-show-more-ports"
                       title="Device Ports" data-title="">
                        <i class="fa fa-caret-down"></i>
                    </a>
                {/if}
            </div>

            <ul id="qm-port-menu" class="dropdown-menu">
                <li><a href="#refresh">Refresh port status</a></li>
                <li><a href="#up">Enable port</a></li>
                <li><a href="#down">Disable port</a></li>
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>



    <ul class="nav nav-pills">
        <li {if !$subdo}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}">
                <i class="fa fa-list-alt"></i>
                Summary
            </a>
        </li>
        <li {if $subdo=='update'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=update">
                <i class="fa fa-pencil-square-o"></i>
                Update
            </a>
        </li>
        <li {if $subdo=='graphs'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=graphs">
                <i class="fa fa-area-chart" aria-hidden="true"></i>
                Graphs
                <span class="badge">{$counters.graphs}</span>
            </a>
        </li>
        <li {if $subdo=='connections'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=connections">
                <i class="fa fa-code-fork" aria-hidden="true"></i>
                Connections
                <span class="badge">{$counters.connections}</span>
            </a>
        </li>
        <li {if $subdo=='ipam'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=ipam">
                <i class="fa fa-list-ol" aria-hidden="true"></i>
                IPAM
                <span class="badge">{$counters.ipam}</span>
            </a>
        </li>

        <li {if $subdo=='power'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=power">
                <i class="fa fa-plug" aria-hidden="true"></i>
                Power
                <span class="badge">{$counters.power}</span>
            </a>
        </li>
        <li {if $subdo=='switch'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=switch">
                <i class="fa fa-arrows-h" aria-hidden="true"></i>
                Switch
                <span class="badge">{$counters.switch}</span>
            </a>
        </li>
        <li {if $subdo=='passwords'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=passwords">
                <i class="fa fa-asterisk" aria-hidden="true"></i>
                Passwords
                <span class="badge">{$counters.passwords}</span>
            </a>
        </li>
        <li {if $subdo=='configurations'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=configurations">
                <i class="fa fa-wrench" aria-hidden="true"></i>
                Configurations
                <span class="badge">{$counters.configurations}</span>
            </a>
        </li>
        {if $inventory_manager}<li {if $subdo=='inventory'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=inventory">
                <i class="fa fa-truck" aria-hidden="true"></i>
                Inventory
            </a>
            </li>{/if}
        <li {if $subdo=='logs'}class="active"{/if}>
            <a href="?cmd=dedimgr&do=itemeditor&item_id={$item.id}&subdo=logs">
                <i class="fa fa-history" aria-hidden="true"></i>
                Logs
                <span class="badge">{$counters.logs}</span>
            </a>
        </li>
    </ul>
</div>

{literal}
    <script>
        $(document).ready(function () {
            ajax_update('?cmd=dedimgr&action=renewCounters&security_token={/literal}{$security_token}{literal}',{{/literal}item_id:{$item.id}{literal}});
        });
    </script>
{/literal}

<div style="padding:0px 5px">
    {if $subdo=='graphs'}
        {include file='ajax.item.graphs.tpl'}
    {elseif $subdo=='update'}
        {include file='ajax.item.update.tpl'}
    {elseif $subdo=='inventory'}
        {include file='ajax.item.inventory.tpl'}
    {elseif $subdo=='configurations'}
        {include file='ajax.item.configurations.tpl'}
    {elseif $subdo=='connections'}
        {include file='ajax.item.connections.tpl'}
    {elseif $subdo=='ipam'}
        {include file='ajax.item.ipam.tpl'}
    {elseif $subdo=='passwords'}
        {include file='ajax.item.passwords.tpl'}
    {elseif $subdo=='power'}
        {include file='ajax.item.power.tpl'}
    {elseif $subdo=='switch'}
        {include file='ajax.item.switch.tpl'}
    {elseif $subdo=='logs'}
        {include file='ajax.item.logs.tpl'}
    {elseif !$subdo}
        {include file='ajax.item.summary.tpl'}
    {/if}
</div>

<div class="conv_content"></div>