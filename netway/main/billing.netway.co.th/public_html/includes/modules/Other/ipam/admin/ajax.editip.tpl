
{if !$mode}
    {literal}
        <script type="text/javascript">
            $(function () {
                $('.form_container').hide().eq(0).show();
                $('.content .fleft > div').eq(0).addClass('actv');
                $('.content .fleft > div').each(function (x) {
                    $(this).click(function () {
                        actv_form = x;
                        $('.form_container').hide().eq(x).show();
                        $('.content .fleft > div').removeClass('actv').eq(x).addClass('actv');
                    });
                });
                $("a.vtip_description").vTip();
                $('#mac').mask('HH:HH:HH:HH:HH:HH', {
                    translation: {H: {pattern: /[A-Fa-f0-9]/}},
                });
                $('#ipamclient_id', '#facebox').chosensearch({width: "250px"})
            });

            function showDevice(id) {
                $.facebox({
                    ajax: "?cmd=module&module={/literal}{$dedimgr}{literal}&do=itemeditor&item_id=" + id,
                    width: 900,
                    nofooter: true,
                    opacity: 0.5,
                    addclass: 'modernfacebox'
                });
                return false;
            }

            function ipam_ipsubmit(form) {
                var form_data = form.serializeObject();
                ajax_update("?cmd=module&module=ipam", form_data, function (data) {
                    if (typeof refreshTree == 'function') {
                        refreshTree();
                        refreshView();
                    } else if (typeof loadIpamMGR == 'function') {
                        loadIpamMGR();
                    }
                    if (form_data.save && form_data.id) {
                        switch (form_data.action) {
                            case 'editip':
                                advEdit(form_data.save, form_data.id);
                                break;
                            default:
                                $(document).trigger('close.facebox');
                        }
                    }
                });
            }

        </script>
    {/literal}
    <table width="100%">
        <tr>
            <td class="fleft">
                <div>General details</div>
                <div>Assignment</div>
                <div>Hardware</div>
                <div>Audit Log</div>
                <div>Ownership history</div>
            </td>
            <td class="fright">
                <h3 style="margin-bottom:0px;">
                    Edit IP Details and assigment
                </h3>
                <form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false" id="edit_ipform">
                    <input type="hidden" name="action" value="editip" />
                    <input type="hidden" name="save" value="{$item.server_id}" />
                    <input type="hidden" name="id" value="{$item.id}" id="ipam_id" />
                    <br/>
                    <div class="form_container">

                        <label>IP</label><input type="text" name="ipaddress" value="{$item.ipaddress}" />
                        <div class="clear"></div>

                        <label>Netmask</label><input type="text" name="mask" value="{$item.mask}" />
                        <div class="clear"></div>
                        
                         <label>WAN IP</label><input type="text" name="wanip" value="{$item.wanip}" />
                        <div class="clear"></div>

                        <label>MAC</label>
                        <input type="text" name="mac" value="{$item.mac}" id="mac"/>
                        <div class="clear"></div>

                        <label>Hostname</label><input type="text" name="domains" value="{$item.domains}" />
                        <div class="clear"></div>

                        <label>RDNS</label><textarea class="w250" name="revdns">{$item.revdns}</textarea>
                        <div class="clear"></div>

                        <label>Admin description</label><textarea class="w250" name="descripton">{$item.descripton}</textarea>
                        <div class="clear"></div>

                        <label>Client description</label><textarea class="w250" name="client_description">{$item.client_description}</textarea>
                        <div class="clear"></div>

                        <label>Status</label>
                        <select name="status">
                            <option value="assigned">Assignable</option>
                            <option value="reserved" {if $item.status==='reserved'}selected{/if}>Reserved</option>
                        </select>
                        <div class="clear"></div>

                    </div>
                    <div class="form_container">

                        {include file="ajax.editassignment.tpl" inline=true ip=$item}

                    </div>
                    <div class="form_container">
                        {if $dedimgr}
                            {if !$port1 && !$port2}
                                <p><em>No device/port assigned in <a href="?cmd=module&module=dedimgr" target="_blank">Dedimgr</a></em> </p>
                            {else}
                                <p><strong>Related devices and ports</strong></p>
                                <div class="clear"></div>
                                <a href="?cmd=module&module=dedimgr&do=rack&rack_id={$port1.rack_id}&expand={$port1.item_id}" target="_blank" style="display: block; padding: 7px; float: left;">
                                    {$port1.label} -
                                    #{$port1.number} 
                                    {if $port1.port_name} ({$port1.port_name}){/if}
                                    {if $port1.mac} MAC:{$port1.mac|upper}{/if}
                                </a>

                                {if $port2}
                                    <div class="join_type"><div><img src="templates/default//img/arrow.png"></div></div>
                                    <div class="clear"></div>

                                    <a href="?cmd=module&module=dedimgr&do=rack&rack_id={$port2.rack_id}&expand={$port2.item_id}" target="_blank" style="display: block; padding: 7px; float: left;">
                                        {$port2.label} -
                                        #{$port2.number} 
                                        {if $port2.port_name} ({$port2.port_name}){/if}
                                        {if $port2.mac} MAC:{$port2.mac|upper}{/if}
                                    </a>
                                {/if}
                            {/if}
                        {else}
                            <p><em>This option is available only when Dedicated Servers Manager is present</em></p>
                        {/if}
                    </div>
                    <div class="form_container">
                        <table class="table table-striped" style="width: 100%" cellspacing="0" cellpadding="6">
                            <thead>
                                <tr>
                                    <th width="140">Date</th>
                                    <th>Change</th>
                                    <th>By</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach from=$logs item=log}
                                    <tr>
                                        <td width="140">{$log.date|dateformat:$date_format}</td>
                                        <td>{$log.log}</td>
                                        <td>{$log.changedby}</td>
                                    </tr>
                                {foreachelse}
                                    <tr><td colspan="3">No logs available</td></tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <div class="form_container">
                        <table class="table table-striped" style="width: 100%" cellspacing="0" cellpadding="6">
                            <thead>
                                <tr>
                                    <th>Owner</th>
                                    <th>From</th>
                                    <th>Until</th>
                                </tr>
                            </thead>
                            <tbody>
                                {assign var="prev" value=false}
                                {foreach from=$history key=thekey item=log}
                                    <tr>
                                        <td>
                                            {if $log.client > 1}
                                                <a href="?cmd=clients&action=show&id={$log.client}">#{$log.client} {$log.client|client}</a>
                                            {elseif $log.client == -1}
                                                <span>-Not assigned-</span>
                                            {else}
                                                <span>Client not found</span>
                                            {/if}
                                            {if $log.account > 1}
                                                <span> | </span><a href="?cmd=accounts&action=edit&id={$log.account}">#{$log.account} Account</a>
                                            {/if}
                                        </td>
                                        <td>{$log.from|dateformat:$date_format|default:"-"}</td>
                                        <td>
                                            {if $log.until}
                                                {$log.until|dateformat:$date_format|default:"-"}
                                            {/if}
                                        </td>
                                    </tr>
                                {foreachelse}
                                    <tr><td colspan="3">No history available</td></tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </form>
            </td>
        </tr>
    </table>
    <div class="f-footer">
        <div class="left spinner" style="display: none;">
            <img src="ajax-loading2.gif">
        </div>
        <div class="right">
            <span class="bcontainer ">
                <a class="new_control greenbtn" onclick="ipam_ipsubmit($('#edit_ipform', '#facebox'));
                        return false" href="#">
                    <span>Save</span>
                </a>
            </span>
            <span class="bcontainer">
                <a class="submiter menuitm" href="#" onclick="$(document).trigger('close.facebox');
                        return false;">
                    <span>Close</span>
                </a>
            </span>
        </div>
        <div class="clear"></div>
    </div>
{elseif $mode == 'testcon'}
    {if $conection == 1}<span class="Successfull"><strong>Successfull!</strong></span>{else}<span class="error">Error: {$conection}</span>{/if}
{/if}