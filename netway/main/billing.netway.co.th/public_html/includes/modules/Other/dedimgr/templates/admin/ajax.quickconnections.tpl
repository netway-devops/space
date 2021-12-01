{foreach from=$items item=item}
    <tr>
        <td>
            <a href="{$moduleurl}&do=itemeditor&item_id={$item.id}" class="qm-item"
               data-id="{$item.id}">
                #{$item.id} -
                {if $item.label}{$item.label}
                {else}{$item.category_name} - {$item.name}
                {/if}
            </a>
        </td>

        <td>
            {if $item.cid}
                <a href="?cmd=clients&action=show&id=={$item.cid}" target="_blank">{$item|@profilelink}</a>
                {else}
                -
            {/if}
        </td>

        <td>
            {if $item.account_id}
                <a href="?cmd=accounts&action=edit&id={$item.account_id}" target="_blank">#{$item.account_id} {$item.domain}</a>
            {else}
                -
            {/if}
        </td>

        <td>
            <a href="{$moduleurl}&do=floors&colo_id={$item.colo_id}">{$item.colo_name}</a>
            &raquo; <a href="{$moduleurl}&do=floor&floor_id={$item.floor_id}">{$item.floor_name}</a>
            &raquo; <a href="{$moduleurl}&do=rack&rack_id={$item.rack_id}">{$item.rack_name}</a>
        </td>

        <td style="font-size:12px; line-height: 12px;">
            {if $item.connections.PDU.out.connected}<strong>Power outlets:</strong><br/>
                {include file='ajax.quickconnect.tpl' draw=$item.connections.PDU.out.ports}
            {/if}
            {if $item.connections.PDU.in.connected}<strong>Power inlets:</strong><br/>
                {include file='ajax.quickconnect.tpl' draw=$item.connections.PDU.in.ports}

            {/if}
            {if $item.connections.NIC.out.connected}<strong>Uplinks: </strong><br/>
                {include file='ajax.quickconnect.tpl' draw=$item.connections.NIC.out.ports}

            {/if}
            {if $item.connections.NIC.in.connected}<strong>Net ports: </strong><br/>
                {include file='ajax.quickconnect.tpl' draw=$item.connections.NIC.in.ports}
             {/if}


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