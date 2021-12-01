{if $portlist}
    {if $type=='PDU'}
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="rack-list" id="rack_list" style="display: table;">
            <tbody><tr>
                <th>Port</th>
                <th>ID</th>
                <th>Label</th>
                <th>Connected to</th>
                <th></th>
            </tr>
            </tbody><tbody>
            {foreach from=$portlist item=p name=ports}
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
    {else}
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
            {foreach from=$portlist item=p name=ports}
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
    {/if}
{/if}
