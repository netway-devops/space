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
    Unable to list ports
{/if}
{elseif $action=='accountseditor'}
{literal}
<script type="text/javascript">
    function assignIP() {
        var v = $('#imap_item_id').val();
        if(v==-2) {
            //manual
            var opt={
                account_id:$('#account_id').val(),
                ip:$('#ipam_manual_ip').val(),
                manual:1
            };
        } else if (v>0) {
            var opt={
                account_id:$('#account_id').val(),
                ip:$('#imap_ip_id').val(),
                manual:0
            };
        } else {
            return false;
        }
        $.post('?cmd=module&module=ipam&action=addaccip',opt,function(d){
            parse_response(d);
            loadIpamMGR() ;
        });
        return false;

    }
    function unassignAllIPs() {
        if(!confirm('Are you sure?')) {
            return false;
        }

        $.post('?cmd=module&module=ipam&action=removeaccip',{account_id:$('#account_id').val(),current:[],toremove:'all'},function(){
            loadIpamMGR() ;
        });


        $.getJSON("?cmd=zabbix&action=doIpamDelete", {
            accountId: $("#account-id").val(),
            serverId: $("#server-id").val(),
            ipaddress: "all"
        }, function(data) {
            json = data.aResponse;
            
            if (json.complete == "1" || json.complete == 1) {
            } else {
            }
        });
        
        return false;

    }
    function unassignIP(ip) {
    if(!confirm('Are you sure?')) {
        return false;
    }
        
        $.post('?cmd=module&module=ipam&action=removeaccip',{account_id:$('#account_id').val(),toremove:ip},function(){
            loadIpamMGR() ;
        });


        $.getJSON("?cmd=zabbix&action=doIpamDelete", {
            accountId: $("#account-id").val(),
            serverId: $("#server-id").val(),
            ipaddress: ip
        }, function(data) {
            json = data.aResponse;
            
            if (json.complete == "1" || json.complete == 1) {
            } else {
            }
        });

        
        return false;

    }
    function getCurrentIps() {
        var ip=[];
        $('.ipam_ips').each(function(n){
            ip[n]=$(this).val();
        });
        return ip;
    }
    
    function load_ipam_options(select) {
                var v = parseInt($(select).val());


                $('#ipam_ips_loader').hide();
                $('#ipam_manual_loader').hide();
                if(v==-2) {
                 $('#ipam_manual_loader').show();
                    return;

                } if (v>0) {
                    $('#ipam_ips_loader').show();
                    ajax_update("?cmd=module&module=ipam&action=accountslistip",{group:v},'#ipam_ips_loader',true);
                }

        return false;
    }
    
</script>
{/literal}
<div id="add_ipam" style="display:none" class="p6">
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

{if $ipam_ips}
<h3>Assigned IPs:</h3>

{if count($ipam_ips)>4}<div style="padding:10px 0px">
<a onclick="$(this).hide();$('#add_ipam').show();$('.vt').vTip();return false;" class="new_control" href="#"><span class="addsth"><strong>Assign new IP</strong></span></a>
<a href="#" class="menuitm " title="delete" onclick="return unassignAllIPs()"><span class="rmsth">Unassign all IPs</span></a>
</div>
{/if}
<ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

{foreach from=$ipam_ips item=ip key=i name=iploop}
<li style="background:#ffffff" class="power_row" data_1="{$itm.item_id}" data_2="{$itm.port_id}" ><div style="border-bottom:solid 1px #ddd;">
{if $smarty.foreach.iploop.first}<input type="hidden" name="ip" value="{$i}" class="ipam_ips"  />{else}<input type="hidden" name="additional_ip[]" value="{$i}" class="ipam_ips" />{/if}
<table width="100%" cellspacing="0" cellpadding="5" border="0" {if $ip.status == 'reserved'}style="background: #efefef"{/if}>
<tbody><tr>
<td width="120" valign="top"><div style="padding:10px 0px;"><a onclick="return unassignIP('{$i}')" title="delete" class="menuitm " href="#"><span class="rmsth">Unassign</span></a>
</div></td>
<td >
    <b>{$i} {if $ip.status == 'reserved'}<span style="font-weight: normal">({$ip.client_description})</span>{/if}</b>

</td>
<td width="160" > {if $ip.rdns} rDNS: {$ip.rdns} {/if}</td>

<td width="160" > {if $ip.inipam} IPAM list: <a class="external" target="_blank" href="?cmd=module&module=ipam&group={$ip.listid}">{$ip.listname}</a> {/if}</td>
</tr>
</tbody></table></div></li>
{/foreach}
</ul>

<a onclick="$(this).hide();$('#add_ipam').show();$('.vt').vTip();return false;" class="new_control" href="#"><span class="addsth"><strong>Assign new IP</strong></span></a>
<a href="#" class="menuitm " title="delete" onclick="return unassignAllIPs()"><span class="rmsth">Unassign all IPs</span></a>
{else}

    <div class="blank_state_smaller blank_forms" id="blank_ipam">
        <div class="blank_info">
            <h3>No IP has been assigned to this account yet</h3>
            You can easily use IPAM module with this account - assign existing IP address from your pools, or enter it manually
            <div class="clear"></div>
            <br /><a onclick="$('#blank_ipam').hide();$('.vt').vTip();$('#add_ipam').show();return false;" class="new_control" href="#"><span class="addsth"><strong>Assign IP</strong></span></a>

            <div class="clear"></div>
        </div>
    </div>
{/if}
{/if}