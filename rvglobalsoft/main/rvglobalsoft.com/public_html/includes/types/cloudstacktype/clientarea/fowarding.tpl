
<table class="data-table backups-list"  width="100%" cellspacing=0>

    <thead>
        <tr>
            <td>IP</td>
            <td>{$lang.protocol}</td>
            <td>{$lang.publicport}</td>
            <td>{$lang.privateport}</td>
            {if $ip_id || !$vpsid}<td>{$lang.hostname}</td>{/if}
            <td>&nbsp;</td>
        </tr>
    </thead>
    {counter name=rules print=false start=0 assign=rules_couter}
    {foreach item=rule from=$fowardrules name=ruleloop}
        {if $ip_id || $vpsid == $rule.virtualmachineid || $network_overview}
            {counter name=rules}
        <tr>
            <td>{if !$ip_id}<a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=fowarding{if $vpsid}&vpsid={$vpsid}{/if}&ipid={$rule.ipaddressid}" />{/if}{$rule.ipaddress}{if !$ip_id}</a>{/if}</td>
            <td>{$rule.protocol|upper}</td>
            <td>{$rule.publicport}</td>
            <td>{$rule.privateport}</td>
            {if $ip_id || !$vpsid}<td><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=fowarding&vpsid={$rule.virtualmachineid}" />{$rule.virtualmachinedisplayname}</a></td>{/if}
            <td  style="text-align:right">
                <a class="small_control small_delete fs11" onclick="return  confirm('Are you sure you want to remove this rule')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=fowarding{if $vpsid}&vpsid={$vpsid}{/if}&rule={$rule.id}&do=ruledrop&security_token={$security_token}{if $ip_id}&ipid={$ip_id}{/if}">{$lang.remove}</a>
            </td>
        </tr>
        {/if}
    {/foreach}

    {if !$rules_couter}
        <tr><td colspan="6">{$lang.nothing}</td></tr>
    {/if}
</table>


<div class="clear"></div>
{if $ips}
<form action="" method="post" id='formaddrule'>
    <input type="hidden" name="do" value="addrule"/>
    {if $ip_id}
        <input type="hidden" name="ipid" value="{$ip_id}"/>
    {/if}
    <br/><h3> {$lang.addrule}: </h3>
    <table class="data-table backups-list form-horizontal"  width="100%" cellspacing="0" style="border-top:solid 1px #DDDDDD;">
        <tr>
            <td>
                <b>IP</b><br/>
                {if !$ip_id}
                    <select name="ip" style="width:auto">
                        {foreach from=$ips item=ip}
                            <option {if $submit.ip == $ip.id}selected="selected"{/if} value="{$ip.id}">{$ip.address}</option>
                        {foreachelse}
                            <option value="">{$lang.none}</option>
                        {/foreach}
                    </select>
                {else}
                    {foreach from=$ips item=ip}
                        {if $ip_id == $ip.id}
                            <input type="hidden" name="ip" value="{$ip.id}" />
                            {$ip.address}
                        {/if}
                    {/foreach}
                {/if}
            </td>
            {if !$vpsid}
                <td>
                <b>VM:</b><br/>
                <select name="vpsid" style="width:auto">
                    {foreach from=$vms item=n key=k}
                        <option value="{$n.id}" >{$n.displayname}</option>
                    {/foreach}
                </select>
                </td>
            {/if}
            <td>
                <b>{$lang.protocol}:</b><br/>
                <select name="protocol" onchange="$('.PROTO').hide();$('.'+$(this).val()).show();" style="width:auto">
                    <option {if $submit.protocol == "TCP"}selected="selected"{/if} >TCP</option>
                    <option {if $submit.protocol == "UDP"}selected="selected"{/if} >UDP</option>
                </select>
            </td>
            <td style="width: 20%; white-space: nowrap; text-align: right">
                <b class="UDP TCP PROTO">{$lang.publicport}:</b><b class="ICMP PROTO" style="display:none">{$lang.icmptype}:</b>
                <strong style="padding-left: 15px; font-size: 15px; font-family: Helvetica,sans-serif; visibility: hidden">&ndash;</strong>
                <br/>
                <input name="startport" value="{$submit.startport}" size="5" required style="width:auto"/> 
                <strong style="padding-left: 15px; font-size: 15px; font-family: Helvetica,sans-serif;">&ndash;</strong>
            </td>
            <td style="width: 10%; white-space: nowrap;">
                <b class="UDP TCP PROTO">{$lang.privateport}:</b><b class="ICMP PROTO" style="display:none">{$lang.icmpcode}:</b><br/>
                <input name="endport" value="{$submit.endport}" size="5" required style="width:auto"/>
            </td>

            <td style="width: 20%; text-align: center" valign="bottom">
                <input type="submit" value="{$lang.submit}" style="font-weight:bold;padding:2px 3px;"  class="blue" />
            </td>
        </tr>
    </table>
    {securitytoken}
</form>
{/if}