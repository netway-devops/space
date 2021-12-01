{foreach from=$items item=item}
    <tr>
        <td>
            <a href="{$moduleurl}&do=itemeditor&item_id={$item.id}" class="qm-item"
               data-id="{$item.id}">
                {if $item.label}{$item.label}
                {else}{$item.category_name} - {$item.name}
                {/if}
            </a>
        </td>
        <td>
            <div class="qm-ips-list {if $item.IPs|@count > 1}multi{/if}">
                {foreach from=$item.IPs item=ip}
                    <span>{$ip.ipaddress}</span>
                {/foreach}
                {if $item.IPs|@count > 1}
                    <a class="btn btn-xs" 
                       title="List all IPs" data-title="">
                        <i class="fa fa-caret-down"></i>
                    </a>
                {/if}
            </div>
        </td>
        <td>
            <div class="qm-pdu-list qm-btn-group {if $item.PDU|@count > 1}multi{/if}">
                {foreach from=$item.PDU item=port}
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
                
                {if $item.PDU|@count > 4}
                    <div class="dropdown qm-width"></div>
                    <a class="btn btn-xs qm-port qm-port-unknown qm-show-more-ports" 
                       title="Device Ports" data-title="">
                        <i class="fa fa-caret-down"></i>
                    </a>
                {/if}
            </div>
        </td>
        <td>
            <div class="qm-nic-list qm-btn-group {if $item.NIC|@count > 1}multi{/if}">
                {foreach from=$item.NIC item=port}
                    <div class="dropdown" 
                         data-port-id="{$port.managed_port}">
                        <a class="qm-port qm-port-{if $port.port_status==1}up{elseif $port.port_status==0}down{else}unknown{/if} btn btn-xs"
                           title="{if $port.port_status==1}Up{elseif $port.port_status==0}Down{else}Unknown{/if}"
                           data-toggle="dropdown">
                            <span class="number">{$port.number}</span>
                            <span class="status">{if $port.port_status==1}up{elseif $port.port_status==0}down{else}unknown{/if}</span>
                            <span class="caret"></span>
                        </a>
                    </div>
                {/foreach}
                {if $item.NIC|@count > 4}
                    <div class="dropdown qm-width"></div>
                    <a class="btn btn-xs qm-port qm-port-unknown qm-show-more-ports" 
                       title="Show more ports .." data-title="">
                        <i class="fa fa-caret-down"></i>
                    </a>
                {/if}
            </div>
        </td>
        <td>
            {if $item.graphs}
                <a href="#graphs" class="btn btn-primary qm-graphs btn-xs"
                   data-item-id="{$item.id}"
                   data-sources="{$item.graphs|@json_encode|escape}">
                    <i class="fa fa-area-chart"></i>
                </a>
            {/if}
        </td>
        <td>
            {if $item.account_id}
                <a href="?cmd=accounts&action=edit&id={$item.account_id}">#{$item.account_id} - {$item|@client}</a>
            {/if}
        </td>
        <td>
            <a href="{$moduleurl}&do=floors&colo_id={$item.colo_id}">{$item.colo_name}</a>
            &raquo; <a href="{$moduleurl}&do=floor&floor_id={$item.floor_id}">{$item.floor_name}</a>
            &raquo; <a href="{$moduleurl}&do=rack&rack_id={$item.rack_id}">{$item.rack_name}</a>
        </td>
        <td style="text-align: right">
            <!-- Single button -->
            <div class="btn-group">
                <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Manage <span class="caret"></span>
                </button>
                <a href="{$moduleurl}&do=itemeditor&item_id={$item.id}" target="_blank" class="btn btn-default btn-xs"><i class="fa fa-share"></i></a>

                <ul class="dropdown-menu dropdown-menu-right">
                    <li><a href="{$moduleurl}&do=itemeditor&item_id={$item.id}&subdo=update">Update</a></li>
                    <li><a href="{$moduleurl}&do=itemeditor&item_id={$item.id}&subdo=graphs">Graphs</a></li>
                    <li><a href="{$moduleurl}&do=itemeditor&item_id={$item.id}&subdo=connections">Connections</a></li>
                    <li><a href="{$moduleurl}&do=itemeditor&item_id={$item.id}&subdo=ipam">IPAM</a></li>
                    <li><a href="{$moduleurl}&do=itemeditor&item_id={$item.id}&subdo=configurations">Configs</a></li>
                    <li><a href="{$moduleurl}&do=itemeditor&item_id={$item.id}&subdo=logs">Logs</a></li>
                </ul>
            </div>
        </td>
    </tr>
{foreachelse}
    <tr>
        <td>Nothing to display</td>
    </tr>
{/foreach}