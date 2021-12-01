
<table class="data-table backups-list"  width="100%" cellspacing=0>

    <thead>
        <tr>
            {if $advanced}
                <td>{if $vpsdo!='egressfirewall'}IP{/if}</td>
                <td>{$lang.protocol}</td>
                <td>{$lang.startport}</td>
                <td>{$lang.endport}</td>
                <td>CIDR</td>
                <td>&nbsp;</td>
            {else}
                <td>{$lang.type}</td>
                <td>{$lang.protocol}</td>
                <td>{$lang.startport}</td>
                <td>{$lang.endport}</td>
                <td>CIDR</td>
                <td>&nbsp;</td>
            {/if}
        </tr>
    </thead>
    {foreach item=rule from=$firewall.advanced name=ruleloop}

        <tr>
            <td>{$rule.ipaddress}</td>
            <td>{$rule.protocol|upper}</td>
            <td>{if $rule.protocol=='ICMP'}{$lang.type}: {$rule.icmptype}{else}{if $rule.startport}{$rule.startport}{else}-{/if}{/if}</td>
            <td>{if $rule.protocol=='ICMP'}{$lang.code}: {$rule.icmpcode}{else}{if $rule.endport}{$rule.endport}{else}-{/if}{/if}</td>
            <td>{$rule.cidrlist}</td>
            <td  style="text-align:right">
                <a class="small_control small_delete fs11" onclick="return confirm('{$lang.areyousureremoverule}')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo={$vpsdo}{if $vpsid}&vpsid={$vpsid}{/if}&rule={$rule.id}&do=ruledrop&security_token={$security_token}{if $ip_id}&ipid={$ip_id}{/if}">{$lang.remove}</a>
            </td>
        </tr>

    {/foreach}

    {foreach item=rule from=$firewall.ingress name=ruleloop}

        <tr>
            <td>{$lang.ingress}</td>
            <td>{$rule.protocol|upper}</td>
            <td>{if $rule.protocol=='ICMP'}{$lang.type}: {$rule.icmptype}{else}{$rule.startport}{/if}</td>
            <td>{if $rule.protocol=='ICMP'}{$lang.code}: {$rule.icmpcode}{else}{$rule.endport}{/if}</td>
            <td>{$rule.cidr}</td>
            <td  style="text-align:right">
                <a class="small_control small_delete fs11" onclick="return confirm('{$lang.areyousureremoverule}')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall{if $vpsid}&vpsid={$vpsid}{/if}&rule={$rule.ruleid}&do=ruledrop&security_token={$security_token}&ruletype=ingress">{$lang.remove}</a>
            </td>
        </tr>
    {/foreach}
    {foreach item=rule from=$firewall.engress name=ruleloop}
        <tr>
            <td>{$lang.engress}</td>
            <td>{$rule.protocol|upper}</td>
            <td>{if $rule.protocol=='ICMP'}{$lang.type}: {$rule.icmptype}{else}{$rule.startport}{/if}</td>
            <td>{if $rule.protocol=='ICMP'}{$lang.code}: {$rule.icmpcode}{else}{$rule.endport}{/if}</td>
            <td>{$rule.cidr}</td>
            <td  style="text-align:right">
                <a class="small_control small_delete fs11" onclick="return  confirm('{$lang.areyousureremoverule}')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall{if $vpsid}&vpsid={$vpsid}{/if}&rule={$rule.ruleid}&do=ruledrop&security_token={$security_token}&ruletype=engress">{$lang.remove}</a>
            </td>
        </tr>
    {/foreach}
    {if !$firewall.ingress && !$firewall.engress && !$firewall.advanced}
        <tr><td colspan="6">{$lang.nothing}</td></tr>
        {/if}
</table>


<div class="clear"></div>
{if !$advanced || ($vpsdo=='egressfirewall' && $networkids) || ($vpsdo=='firewall' && $ips)}
    <form action="" method="post" id='formaddrule'>
        <input type="hidden" name="do" value="addrule"/>
        <input type="hidden" name="securitygroupid" value="{$firewall.securitygroupid}"/>
        {if $ip_id}
            <input type="hidden" name="ipid" value="{$ip_id}"/>
        {/if}

        <br/><h3> {$lang.addrule}: </h3>
        <table class="data-table backups-list form-horizontal"  width="100%" cellspacing="0" style="border-top:solid 1px #DDDDDD;">

            <tr>
                {if $advanced}

                    <td>
                        {if $vpsdo=='egressfirewall'}
                            {if count($networkids) > 1}
                                <select name="networkid" style="width:auto">
                                    {foreach from=$networkids item=network}
                                        <option {if $submit.networkid == $network[0]}selected="selected"{/if} value="{$network[0]}">{$network[1]}</option>
                                    {foreachelse}
                                        <option value="">{$lang.none}</option>
                                    {/foreach}
                                </select>
                            {else}
                                {foreach from=$networkids item=network}
                                    <b>{$lang.network}</b><br>
                                    <input type="hidden" name="networkid" value="{$network[0]}" />
                                    {$network[1]}
                                    {break}
                                {foreachelse}
                                    <b>{$lang.network}</b><br>
                                    {$lang.none}
                                {/foreach}
                            {/if}
                        {else}
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
                        {/if}
                    </td>
                {else}
                    <td>
                        <b>{$lang.type}:</b><br/>
                        <select name="type" style="width:auto">
                            <option {if $submit.type == "ingress"}selected="selected"{/if} value="ingress">{$lang.ingress}{$lang.rule}</option>
                            <option {if $submit.type == "engress"}selected="selected"{/if} value="engress">{$lang.engress}{$lang.rule}</option>
                        </select>
                    </td>
                {/if}
                <td>
                    <b>CIDR</b><br/>
                    <input name="cidr" value="{$submit.cidr}" required style="width:auto"/>
                </td>
                <td>
                    <b>{$lang.protocol}:</b><br/>
                    <select name="protocol" onchange="$('.PROTO').hide().filter('input').prop('disabled', true).attr('disabled', 'disabled');
                        $('.' + $(this).val()).show().filter('input').prop('disabled', false).removeAttr('disabled');" style="width:auto">
                        <option {if $submit.protocol == "TCP"}selected="selected"{/if} >TCP</option>
                        <option {if $submit.protocol == "UDP"}selected="selected"{/if} >UDP</option>
                        <option {if $submit.protocol == "ICMP"}selected="selected"{/if} >ICMP</option>
                {if $vpsdo=='egressfirewall'}<option {if $submit.protocol == "ALL"}selected="selected"{/if} >{$lang.all}</option>{/if}
            </select></td>
        <td style="width: 20%; white-space: nowrap; text-align: right">
            <b class="UDP TCP PROTO">{$lang.startport}:</b>
            <b class="ICMP PROTO" style="display:none">{$lang.icmptype}:</b>
            <strong class="UDP TCP PROTO"style="padding-left: 15px; font-size: 15px; font-family: Helvetica,sans-serif; visibility: hidden">&ndash;</strong>
            <br/>
            <input class="UDP TCP ICMP PROTO" name="startport" value="{$submit.startport}" size="5" required style="width:auto"/> 
            <strong class="UDP TCP PROTO" style="padding-left: 15px; font-size: 15px; font-family: Helvetica,sans-serif;">&ndash;</strong>
        </td>
        <td style="width: 10%; white-space: nowrap;">
            <b class="UDP TCP PROTO">{$lang.endport}:</b>
            <b class="ICMP PROTO" style="display:none">{$lang.icmpcode}:</b><br/>
            <input class="UDP TCP ICMP PROTO" name="endport" value="{$submit.endport}" size="5" required style="width:auto"/>
        </td>

        <td style="width: 20%; text-align: center" valign="bottom">
            <input type="submit" value="{$lang.submit}" style="font-weight:bold;padding:2px 3px;"  class="blue" />
        </td>
    </tr>


</table>

{securitytoken}</form>
{/if}