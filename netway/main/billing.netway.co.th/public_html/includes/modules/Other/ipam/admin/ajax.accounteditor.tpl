{if $action=='accountslistip'}
    {if $list}
        <select name="imap_ip_id" id="imap_ip_id" class="inp">
            <option value="-{$groupid}">Assign entire list</option>
            {foreach from=$list item=port key=k}
                <option value="{$port.ipaddress}">{$port.ipaddress}</option>
            {/foreach}
        </select>
        <a href="#" onclick="return assignIP();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a>
    {else}
        Unable to list free IPs
    {/if}
{elseif $action=='accountseditor'}
    <div id="ReassignIPs" style="display:none;" bootbox data-title="Re-assign all IPs to new service"
         data-formaction="?cmd=ipam&action=reassignips&account_id={$account_id}">
        <div class="form-group">
            <label>Target account</label>
            <select name="target_account_id" class="form-control" style="min-width:180px"></select>
            <p class="help-block">
               Using this feature will result in moving all IPs from this account to target account selected above, it will not change anything other than owner/related service for IPs/subnets.
            </p>
        </div>
        {securitytoken}
    </div>

    <link rel="stylesheet" href="templates/default/js/gui.elements.css" type="text/css">
    <link rel="stylesheet" href="../includes/modules/Other/ipam/admin/stylesheet.css" type="text/css">
    <script src="../includes/modules/Other/ipam/admin/js/jquery.mask.min.js" type="text/javascript"></script>
    <script src="templates/default/js/gui.elements.js" type="text/javascript"></script>
    {literal}
        <script type="text/javascript">
            $('#ReassignIPs').bootboxform().on('bootbox-form.shown', function (e, dialog) {
                $('select', dialog).chosensearch({
                    width: "100%",
                    placeholder_text: "Search for account id/domain",
                    enable_split_word_search: true,
                    search_contains: true,
                    type: 'Accounts',
                    args: {type: 'Accounts'},
                    none_option: {
                        name: "None",
                        value: 0,
                        query: ''
                    }
                });
            });

            var ipam_assign_type = '{/literal}{if $type}{$type}{else}account{/if}{literal}';
            function assignIP() {
                var v = $('#imap_item_id').val();
                if (v == -2) {
                    //manual
                    var opt = {
                        account_id: $('#account_id').val(),
                        type: ipam_assign_type,
                        list_id: $('#imap_item_id').val(),
                        ip: $('#ipam_manual_ip').val(),
                        manual: 1
                    };
                } else if (v > 0) {
                    var opt = {
                        account_id: $('#account_id').val(),
                        type: ipam_assign_type,
                        list_id: $('#imap_item_id').val(),
                        ip: $('#imap_ip_id').val(),
                        manual: 0
                    };
                } else {
                    return false;
                }
                $.post('?cmd=module&module=ipam&action=addaccip', opt, function(d) {
                    parse_response(d);
                    loadIpamMGR();
                });
                return false;

            }
            function reassignAllIPs() {
                $('#ReassignIPs').trigger('show')
                return false;
            }
            function unassignAllIPs() {
                if (!confirm('Are you sure?')) {
                    return false;
                }

                $.post('?cmd=module&module=ipam&action=removeaccip', {account_id: $('#account_id').val(), current: [], toremove: 'all', type:ipam_assign_type}, function() {
                    loadIpamMGR();
                });
                return false;
            }
            function setMainIp(ip){
                var params = {
                    account_id: $('#account_id').val(),
                    current: {/literal}{$ipam_ips_simple|@json_encode}{literal}
                };
                var ipr = params.current.splice(params.current.indexOf(ip),1)[0];
                params.current.unshift(ipr);
                $.post('?cmd=module&module=ipam&action=addaccip', params, function() {
                    loadIpamMGR();
                });
            }
            function load_ipam_options(select) {
                var v = parseInt($(select).val());
                $('#ipam_ips_loader').hide();
                $('#ipam_manual_loader').hide();
                if (v == -2) {
                    $('#ipam_manual_loader').show();
                    return;
                }
                if (v > 0) {
                    $('#ipam_ips_loader').show();
                    ajax_update("?cmd=module&module=ipam&action=accountslistip", {group: v,type:ipam_assign_type}, '#ipam_ips_loader', true);
                }
                return false;
            }
            function load_subnet(id) {
                ajax_update("?cmd=module&module=ipam&action=accountseditor", {subnet_id: id, account_id: $('#account_id').val()}, '#ipameditor', true);
                return false;
            }

            function unassignIP(ip, list_id = false) {
                if (!confirm('Are you sure?')) {
                    return false;
                }
                $.post('?cmd=module&module=ipam&action=removeaccip', {account_id: $('#account_id').val(), toremove: ip, type: ipam_assign_type, list_id: list_id}, function() {
                    loadIpamMGR();
                });
                return false;
            }
            function advEdit(id) {
                $.facebox({
                    ajax: "?cmd=module&module=ipam&action=editip&id=" + id,
                    width: 900,
                    nofooter: true,
                    opacity: 0.5
                });
                return false;
            }
            function ipam_go_back() {
                ajax_update("?cmd=module&module=ipam&action=accountseditor", {account_id: $('#account_id').val()}, '#ipameditor', true);
                return false;
            }
            function moveIpToIPAM(ip) {
                $.post('?cmd=ipam&action=manualip', {account_id: $('#account_id').val(), ip: ip, make: 'move'}, function(data) {
                    parse_response(data);
                    loadIpamMGR();
                });
            }

            function removeManualIP(ip) {
                $.post('?cmd=ipam&action=manualip', {account_id: $('#account_id').val(), ip: ip, make: 'remove'}, function(data) {
                    parse_response(data);
                    loadIpamMGR();
                });
            }
        </script>
    {/literal}

    {if !$subnet}
        <div id="add_ipam" style="display:none; margin-bottom: 10px;" class="p6">
            <div class="left" style="margin-right:10px;padding:4px"><b>Assign new IP:</b></div>
            <select name="imap_item_id" id="imap_item_id" class="inp left" onchange="load_ipam_options(this)" style="margin-right:10px;">
                <option value="0">Select assign method:</option>
                <option value="-2">Enter IP/subnet manually</option>
                <option value="-1" disabled style="color:gray;">Assign IP from IPAM list:</option>
                {foreach from=$lists item=list}
                    <option value="{$list.id}" {if $list.indent!='0'}style="padding-left:10px"{/if}>{$list.name}</option>
                {/foreach}
            </select>
            <div id="ipam_ips_loader" class="left" style="display:none"></div>
            <div id="ipam_manual_loader" class="left" style="display:none">IP: <a class="vtip_description vt" title="You can enter: <br/>- single IP<br/>- CIDR subnet (x.x.x.x/y)<br/>- IP range x.x.x.x - y.y.y.y"></a><input class="inp" name="manual_ip" id="ipam_manual_ip" style="width:250px"/>
                <a href="#" onclick="return assignIP();" class="new_control greenbtn" onclick="return false;"><span class="addsth"><strong>Assign</strong></span></a></div>
            <div class="clear"></div>
        </div>
        <div id="add_main" style="display:none; margin-bottom: 10px;" class="p6">
            <b>Select Main IP:</b>
            <select name="imap_main_ip" id="imap_main_ip" class="inp" style="margin-right:10px;" >
                {foreach from=$ipam_ips item=ip}
                    <option value="{$ip.ip}" >{$ip.ip}</option>
                {/foreach}
            </select>
            <a href="#" onclick="return setMainIp($('#imap_main_ip').val());" class="new_control"><strong>Change</strong></a>
        </div>
    {/if}
    {if $ipam_ips}
        {if count($ipam_ips)>1 && !$subnet}
            <div style="padding:10px 0px">
                {if $type=='account'}
                    <a href="#" class="menuitm " title="Change Main IP" onclick="$(this).hide(); $('#add_main').show(); return false"><i class="fa fa-cog"></i> Change Main IP</a>
                {/if}
                {if count($ipam_ips)>4}
                    <a onclick="$(this).hide();
                        $('#add_ipam').show();
                        $('.vt').vTip();
                        return false;" class="new_control" href="#"><span class="addsth"><strong>Assign new IP</strong></span></a>
                    <a href="#" class="menuitm " title="delete" onclick="return unassignAllIPs()"><i class="fa fa-trash-o"></i> Unassign all IPs</a>
                    <a href="#" class="menuitm " title="reassign" onclick="return reassignAllIPs()"><i class="fa fa-retweet"></i> Re-assign IPs</a>
                {/if}
            </div>
        {/if}

        {if $subnets && count($subnets.servers) > 1}
            <h3>IPs subnets:</h3>
            <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">
                {foreach from=$subnets.servers item=serv}
                    <li style="background:#ffffff">
                        <div style="border-bottom:solid 1px #ddd;">
                            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                                <tbody>
                                <tr>
                                    <td width="400">
                                        <a class="btn_subnet" href="#" onclick="load_subnet({$serv.server.id});return false;">
                                            <b>{$serv.server.name}</b>
                                        </a>
                                    </td>
                                    <td width="300"><b>{if $serv.server.private}Private{else}Public{/if}</b></td>
                                    <td width="250">VLAN: {if $serv.server.vlan_name}<b>{$serv.server.vlan_name}</b>{else}-{/if}</td>
                                    <td>IPs: <b>{$serv.ips_total}</b></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </li>
                {/foreach}
            </ul>
        {elseif $subnet.id}
            <div style="margin-bottom: 10px;">
                <a href="#" onclick="ipam_go_back();return false;">« Go back</a>
            </div>
            <h3 style="margin-bottom: 10px;"><b>{$subnet.name}</b> subnet. Assigned IPs:</h3>
            <div class="subnet_ips_list">
                <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">
                    {foreach from=$subnet_ips item=ip key=i name=iploop}
                        {include file="ajax.accounteditor_ip.tpl"}
                    {/foreach}
                </ul>
            </div>
        {else}
            <h3 style="margin-bottom: 10px;">Assigned IPs:</h3>
            <div class="subnet_ips_list">
                <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">
                    {foreach from=$ipam_ips item=ip key=i name=iploop}
                        {include file="ajax.accounteditor_ip.tpl"}
                    {/foreach}
                </ul>
            </div>
        {/if}
        {if !$subnet}
            <a onclick="$(this).hide();
                    $('#add_ipam').show();
                    $('.vt').vTip();
                    return false;" class="new_control" href="#"><span class="addsth"><strong>Assign new IP</strong></span></a>
                    <a href="#" class="menuitm " title="delete" onclick="return unassignAllIPs()"><i class="fa fa-trash-o"></i> Unassign all IPs</a>
                    <a href="#" class="menuitm " title="reassign" onclick="return reassignAllIPs()"><i class="fa fa-retweet"></i> Re-assign IPs</a>
        {/if}
    {else}
        <div class="blank_state_smaller blank_forms" id="blank_ipam">
            <div class="blank_info">
                <h3>No IP from IPAM has been assigned to this {$type} yet</h3>
                You can easily use IPAM module with this {$type} - assign existing IP address from your pools, or enter it manually
                <div class="clear"></div>
                <br /><a onclick="$('#blank_ipam').hide();
                $('.vt').vTip();
                $('#add_ipam').show();
                return false;" class="new_control" href="#"><span class="addsth"><strong>Assign IP</strong></span></a>

                <div class="clear"></div>
            </div>
        </div>
    {/if}

    {if $details.additional_ip}
        <hr>
        <h3 style="margin-bottom: 10px;">IPs added outside of IPAM:</h3>
        <table cellspacing="0" cellpadding="5" border="0">
            <tbody>
                {if $details.ip}
                    <tr>
                        <td>{$lang.mainip}</td>
                        <td><input value="{$details.ip}" name="ip" readonly="readonly"/></td>
                        <td><a class="btn btn-sm btn-default" onclick="if(confirm('Are you sure to move this IP to IPAM?'))return moveIpToIPAM('{$details.ip}');">Move to IPAM</a></td>
                        <td><a class="btn btn-sm btn-default" onclick="if(confirm('Are you sure to remove?'))return removeManualIP('{$details.ip}');" style="color: red;">Remove</a></td>
                    </tr>
                {/if}
                {foreach from=$details.additional_ip item=ip}
                    {if $ip!=='' && !$ip|in_array:$ipam_ips_simple}
                        <tr>
                            <td>{$lang.addip}</td>
                            <td><input value="{$ip}" name="additional_ip[]" readonly="readonly"/></td>
                            <td><a class="btn btn-sm btn-default" onclick="if(confirm('Are you sure to move this IP to IPAM?'))return moveIpToIPAM('{$ip}');">Move to IPAM</a></td>
                            <td><a class="btn btn-sm btn-default" onclick="if(confirm('Are you sure to remove?'))return removeManualIP('{$ip}');" style="color: red;">Remove</a></td>
                        </tr>
                    {/if}
                {/foreach}
            </tbody>
        </table>
    {/if}
{/if}