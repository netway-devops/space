<input type="hidden" name="rack_id" value="{if $rack_id}{$rack_id}{else}{$rack.id}{/if}" />
<input type="hidden" name="id" value="{$item.id}" id="item_id"/>
<div class="row no-gutter">
    <div class="col-md-6 mainleftcol ">
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title"><img src="{$moduledir}icons/network-ethernet.png" alt="" /> Network ports: <span class="group_label">{if $ports.NIC.in.label}{$ports.NIC.in.label} (default){else}Default{/if}</span></h3>
                <div class="box-tools pull-right">
                    <a href="#" data-item_id="{$item.id}" data-type="NIC" data-direction="in" data-label="{$ports.NIC.in.label}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                    <a href="#" data-item_id="{$item.id}" data-type="NIC" data-direction="in" class="btn btn-sm btn-default portAddNewGroup">Add custom group</a>
                </div>
            </div>
            <div class="box-body" >
                <div class="crow clearfix port-group-container"  id="NIC_in_0">
                    {if $ports.NIC.in.ports}
                        {include file='ajax.connections.tpl' portlist=$ports.NIC.in.ports}
                    {/if}
                </div>
            </div>
            <div class="box-footer">
                Ports count:
                <select name="conn[NIC][in]" onchange="setports(0,$(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'NIC', 'in')" class="w50">
                    <option value="0" {if $ports.NIC.in.count=='0'}selected="selected"{/if}>0</option>
                    {section name=foo loop=64}
                        <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.NIC.in.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                    {/section}
                </select>
            </div>
        </div>
        {foreach from=$groups.NIC.in item=group}
            <div class="box  box-solid">
                <div class="box-header">
                    <h3 class="box-title"><img src="{$moduledir}icons/network-ethernet.png" alt="" /> Network ports: {$group.name}</h3>
                    <div class="box-tools pull-right">
                        <a href="#" data-item_id="{$item.id}" data-group_id="{$group.id}" data-label="{$group.name}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                    </div>
                </div>
                <div class="box-body" >
                    <div class="crow clearfix port-group-container"  id="NIC_in_{$group.id}">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_list" style="display: table;">
                            <tbody><tr>
                                <th>Port</th>
                                <th>ID</th>
                                <th>Label</th>
                                <th>MAC</th>
                                <th>IP</th>
                                <th>Connected to</th>
                                <th></th>
                            </tr>
                            </tbody>
                            <tbody>
                            {foreach from=$group.ports item=p}
                                <tr class="rack-list-item">
                                    <td >
                                        <div class="port-group">
                                            <div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if} onclick="getportdetails('{$p.id}')">
                                                {if $p.connected_to!='0'}
                                                    <div class="{if $p.type=="NIC"}hasconnection{else}haspower{/if}"></div>
                                                {/if}
                                                {if $p.port_status!='-1'}
                                                    <div class="port-status port-status-{$p.port_status}"></div>
                                                {/if}
                                                <div class="nth"><div>{$p.number}</div></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>{$p.port_id}</td>
                                    <td>{$p.port_name}</td>
                                    <td>{$p.mac}</td>
                                    <td>{$p.ipv4}</td>
                                    <td>{if $p.connected_to}
                                            <a href="?cmd=dedimgr&do=itemeditor&item_id={$p.connected_id}">{$p.title}</a>{/if}</td>
                                    <td class="rack-list-act">
                                        <div>
                                            <a href="##" onclick="getportdetails('{$p.id}')" class="menuitm menu-auto" title="Edit"><span class="editsth"></span></a>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="box-footer">
                    Ports count:
                    <select name="conn[NIC][in]" onchange="setports({$group.id}, $(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'NIC', 'in')" class="w50">
                        <option value="0" {if $group.count=='0'}selected="selected"{/if}>0</option>
                        {section name=foo loop=64}
                            <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$group.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                        {/section}
                    </select>
                    <div class="pull-right">
                        <a href="#" data-group_id="{$group.id}" class="btn btn-sm btn-default portDeleteGroup">Remove Group</a>
                    </div>
                </div>
            </div>
        {/foreach}

        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title"><img src="{$moduledir}icons/network-ethernet.png" alt="" />  Switch uplink ports: <span class="group_label">{if $ports.NIC.out.label}{$ports.NIC.out.label} (default){else}Default{/if}</span> </h3>
                <div class="box-tools pull-right">
                    <a href="#" data-item_id="{$item.id}" data-type="NIC" data-direction="out" data-label="{$ports.NIC.out.label}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                    <a href="#" data-item_id="{$item.id}" data-type="NIC" data-direction="out" class="btn btn-sm btn-default portAddNewGroup">Add custom group</a>
                </div>
            </div>
            <div class="box-body" >
                <div class="crow clearfix port-group-container"  id="NIC_out_0">
                    {if $ports.NIC.out.ports}
                        {include file='ajax.connections.tpl' portlist=$ports.NIC.out.ports}
                    {/if}
                </div>
            </div>
            <div class="box-footer">
                <a class="vtip_description" title="Use for switch only"></a>
                Ports count:
                <select name="conn[NIC][OUT]" onchange="setports(0,$(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'NIC', 'out')" class="w50">
                    <option value="0" {if $ports.NIC.out.count=='0'}selected="selected"{/if}>0</option>
                    {section name=foo loop=4}
                        <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.NIC.out.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                    {/section}
                </select>
            </div>
        </div>
            {foreach from=$groups.NIC.out item=group}
                <div class="box  box-solid">
                    <div class="box-header">
                        <h3 class="box-title"><img src="{$moduledir}icons/network-ethernet.png" alt="" /> Switch uplink ports: {$group.name}</h3>
                        <div class="box-tools pull-right">
                            <a href="#" data-item_id="{$item.id}" data-group_id="{$group.id}" data-label="{$group.name}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                        </div>
                    </div>
                    <div class="box-body" >
                        <div class="crow clearfix port-group-container"  id="NIC_out_{$group.id}">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_list" style="display: table;">
                                <tbody><tr>
                                    <th>Port</th>
                                    <th>ID</th>
                                    <th>Label</th>
                                    <th>MAC</th>
                                    <th>IP</th>
                                    <th>Connected to</th>
                                    <th></th>
                                </tr>
                                </tbody><tbody>
                                {foreach from=$group.ports item=p}
                                    <tr class="rack-list-item">
                                        <td >
                                            <div class="port-group">
                                                <div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if} onclick="getportdetails('{$p.id}')">
                                                    {if $p.connected_to!='0'}
                                                        <div class="{if $p.type=="NIC"}hasconnection{else}haspower{/if}"></div>
                                                    {/if}
                                                    {if $p.port_status!='-1'}
                                                        <div class="port-status port-status-{$p.port_status}"></div>
                                                    {/if}
                                                    <div class="nth"><div>{$p.number}</div></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>{$p.port_id}</td>
                                        <td>{$p.port_name}</td>
                                        <td>{$p.mac}</td>
                                        <td>{$p.ipv4}</td>
                                        <td>{if $p.connected_to}
                                                <a href="?cmd=dedimgr&do=itemeditor&item_id={$p.connected_id}">{$p.title}</a>{/if}</td>
                                        <td class="rack-list-act">
                                            <div>
                                                <a href="##" onclick="getportdetails('{$p.id}')" class="menuitm menu-auto" title="Edit"><span class="editsth"></span></a>
                                            </div>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="box-footer">
                        Ports count:
                        <select name="conn[NIC][out]" onchange="setports({$group.id},$(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'NIC', 'out')" class="w50">
                            <option value="0" {if $group.count=='0'}selected="selected"{/if}>0</option>
                            {section name=foo loop=64}
                                <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$group.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                            {/section}
                        </select>
                        <div class="pull-right">
                            <a href="#" data-group_id="{$group.id}" class="btn btn-sm btn-default portDeleteGroup">Remove Group</a>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>

    <div class="col-md-6 mainrightcol ">
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title"><img src="{$moduledir}icons/plug.png" alt="" />
                    <span>In-Power sockets: <span class="group_label">{if $ports.PDU.in.label}{$ports.PDU.in.label} (default){else}Default{/if}</span></span>
                </h3>
                <div class="box-tools pull-right">
                    <a href="#" data-item_id="{$item.id}" data-type="PDU" data-direction="in" data-label="{$ports.PDU.in.label}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                    <a href="#" data-item_id="{$item.id}" data-type="PDU" data-direction="in" class="btn btn-sm btn-default portAddNewGroup">Add custom group</a>
                </div>
            </div>
            <div class="box-body" >
                <div class="crow clearfix port-group-container"  id="PDU_in_0">
                    {if $ports.PDU.in.ports}
                        {include file='ajax.connections.tpl' portlist=$ports.PDU.in.ports type='PDU'}
                    {/if}
                </div>
            </div>
            <div class="box-footer">
                Sockets count:
                <select name="conn[PDU][IN]"  onchange="setports(0,$(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'PDU', 'in')" class="w50">
                    <option value="0" {if $ports.PDU.in.count=='0'}selected="selected"{/if}>0</option>
                    {section name=foo loop=4}
                        <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.PDU.in.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                    {/section}
                </select>
            </div>
        </div>
        {foreach from=$groups.PDU.in item=group}
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title"><img src="{$moduledir}icons/plug.png" alt="" />
                    <span>In-Power sockets: {$group.name}</span>
                </h3>
                <div class="box-tools pull-right">
                    <a href="#" data-item_id="{$item.id}" data-group_id="{$group.id}" data-label="{$group.name}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                </div>
            </div>
            <div class="box-body" >
                <div class="crow clearfix port-group-container"  id="PDU_in_{$group.id}">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_list" style="display: table;">
                        <tbody><tr>
                            <th>Port</th>
                            <th>ID</th>
                            <th>Label</th>
                            <th>Connected to</th>
                            <th></th>
                        </tr>
                        </tbody><tbody>
                        {foreach from=$group.ports item=p}
                            <tr class="rack-list-item">
                                <td >
                                    <div class="port-group">
                                        <div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if} onclick="getportdetails('{$p.id}')">
                                            {if $p.connected_to!='0'}
                                                <div class="{if $p.type=="NIC"}hasconnection{else}haspower{/if}"></div>
                                            {/if}
                                            {if $p.port_status!='-1'}
                                                <div class="port-status port-status-{$p.port_status}"></div>
                                            {/if}
                                            <div class="nth"><div>{$p.number}</div></div>
                                        </div>
                                    </div>
                                </td>
                                <td>{$p.port_id}</td>
                                <td>{$p.port_name}</td>
                                <td>{if $p.connected_to}
                                        <a href="?cmd=dedimgr&do=itemeditor&item_id={$p.connected_id}">{$p.title}</a>{/if}
                                </td>
                                <td class="rack-list-act">
                                    <div>
                                        <a href="##" onclick="getportdetails('{$p.id}')" class="menuitm menu-auto" title="Edit"><span class="editsth"></span></a>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="box-footer">
                Sockets count:
                <select name="conn[PDU][IN]"  onchange="setports({$group.id},$(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'PDU', 'in')" class="w50">
                    <option value="0" {if $group.count=='0'}selected="selected"{/if}>0</option>
                    {section name=foo loop=4}
                        <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$group.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                    {/section}
                </select>
                <div class="pull-right">
                    <a href="#" data-group_id="{$group.id}" class="btn btn-sm btn-default portDeleteGroup">Remove Group</a>
                </div>
            </div>
        </div>
        {/foreach}
        <div class="box  box-solid">
            <div class="box-header">
                <h3 class="box-title"><img src="{$moduledir}icons/plug.png" alt="" />
                    <span>PDU OUT-Power sockets: <span class="group_label">{if $ports.PDU.out.label}{$ports.PDU.out.label} (default){else}Default{/if}</span></span>
                </h3>
                <div class="box-tools pull-right">
                    <a href="#" data-item_id="{$item.id}" data-type="PDU" data-direction="out" data-label="{$ports.PDU.out.label}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                    <a href="#" data-item_id="{$item.id}" data-type="PDU" data-direction="out" class="btn btn-sm btn-default portAddNewGroup">Add custom group</a>
                </div>
            </div>
            <div class="box-body" >
                <div class="crow clearfix port-group-container"  id="PDU_out_0">
                    {if $ports.PDU.out.ports}
                        {include file='ajax.connections.tpl' portlist=$ports.PDU.out.ports  type='PDU'}
                    {/if}
                </div>
            </div>
            <div class="box-footer">
                <a class="vtip_description" title="Use for PDU only"></a> Sockets count:
                <select name="conn[PDU][OUT]" onchange="setports(0,$(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'PDU', 'out')" class="w50">
                    <option value="0" {if $ports.PDU.out.count=='0'}selected="selected"{/if}>0</option>
                    {section name=foo loop=64}
                        <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$ports.PDU.out.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                    {/section}
                </select>
            </div>
        </div>
        {foreach from=$groups.PDU.out item=group}
            <div class="box  box-solid">
                <div class="box-header">
                    <h3 class="box-title"><img src="{$moduledir}icons/plug.png" alt="" />
                        <span>PDU OUT-Power sockets: {$group.name}</span>
                    </h3>
                    <div class="box-tools pull-right">
                        <a href="#" data-item_id="{$item.id}" data-group_id="{$group.id}" data-label="{$group.name}" class="btn btn-sm btn-default portEditGroupLabel">Edit label</a>
                    </div>
                </div>
                <div class="box-body" >
                    <div class="crow clearfix port-group-container"  id="PDU_out_{$group.id}">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_list" style="display: table;">
                                <tbody><tr>
                                    <th>Port</th>
                                    <th>ID</th>
                                    <th>Label</th>
                                    <th>Connected to</th>
                                    <th></th>
                                </tr>
                                </tbody><tbody>
                                {foreach from=$group.ports item=p}
                                    <tr class="rack-list-item">
                                        <td >
                                            <div class="port-group">
                                                <div class="connector {if $p.title}hastitle{/if}" {if $p.title}title="{$p.title}"{/if} onclick="getportdetails('{$p.id}')">
                                                    {if $p.connected_to!='0'}
                                                        <div class="{if $p.type=="NIC"}hasconnection{else}haspower{/if}"></div>
                                                    {/if}
                                                    {if $p.port_status!='-1'}
                                                        <div class="port-status port-status-{$p.port_status}"></div>
                                                    {/if}
                                                    <div class="nth"><div>{$p.number}</div></div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>{$p.port_id}</td>
                                        <td>{$p.port_name}</td>
                                        <td>
                                            {if $p.connected_to}
                                                <a href="?cmd=dedimgr&do=itemeditor&item_id={$p.connected_id}">{$p.title}</a>
                                            {/if}
                                        </td>
                                        <td class="rack-list-act">
                                            <div>
                                                <a href="##" onclick="getportdetails('{$p.id}')" class="menuitm menu-auto" title="Edit"><span class="editsth"></span></a>
                                            </div>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                    </div>
                </div>
                <div class="box-footer">
                    Sockets count:
                    <select name="conn[PDU][OUT]"  onchange="setports({$group.id},$(this).closest('.box').find('tr.rack-list-item').length,$(this).val(), 'PDU', 'out')" class="w50">
                        <option value="0" {if $group.count=='0'}selected="selected"{/if}>0</option>
                        {section name=foo loop=4}
                            <option value="{$smarty.section.foo.iteration}" {if $smarty.section.foo.iteration==$group.count}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>
                        {/section}
                    </select>
                    <div class="pull-right">
                        <a href="#" data-group_id="{$group.id}" class="btn btn-sm btn-default portDeleteGroup">Remove Group</a>
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
    <div class="col-md-12">
        <div class="fs11" style="line-height:25px;">
            <b>Legend:</b>
            <ul class="port-legend">
                <li><div class="port-status port-status-1"></div> This port is UP/ON</li>
                <li><div class="port-status port-status-0"></div> This port is DOWN/OFF</li>
                <li><div class="hasconnection"></div> This port is connected</li>
                <li><div class="haspower"></div> This power socket is connected</li>
            </ul>
        </div>
    </div>

</div>
