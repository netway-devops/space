<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td>
        <td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td>
        <td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td>
        <td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td>
        <td ><input  name="field1" size="25" value="{$server.field1}" class="inp" placeholder="8081"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.display.custom.ip_protocol.name}{$server_fields.display.custom.ip_protocol.name}{/if}</strong></td>
        <td >
            <select name="custom[ip_protocol]">
                {foreach from=$server_fields.display.custom.ip_protocol.default item=ip_protocal}
                    <option {if $server.custom.ip_protocol == $ip_protocal}selected{/if}>{$ip_protocal}</option>
                {/foreach}
            </select>
        </td>
    </tr>

</table>
<div class="sectionhead">PowerDNS Settings </div>
<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    <tr>
        <td  align="right" width="165"><strong>Zone Type</strong> <a class="vtip_description" title="Select zone type that this app will allow to add/create"></a></td>
        <td >
            <select name="custom[zonetype]">
                <option {if !$server.custom.zonetype || $server.custom.zonetype=='MASTER'}selected="selected"{/if} value="MASTER">MASTER</option>
                <option {if $server.custom.zonetype=='NATIVE'}selected="selected"{/if} value="NATIVE">NATIVE</option>
                <option {if $server.custom.zonetype=='SLAVE'}selected="selected"{/if} value="SLAVE">SLAVE</option>
            </select>
        </td>
    </tr>
</table>
<div class="sectionhead">DNSSEC </div>
<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    <tr>
        <td  align="right" width="165"><strong>DNSSEC: Autorectify</strong> <a class="vtip_description" title="If enabled, any DNS change with PowerDNS module will cause zone to be rectified (if DNSSEC for zone is enabled). Requires enabling HostBillQueue module"></a></td>
        <td ><input  name="custom[autorectify]"  value="1" type="checkbox" {if $server.custom.autorectify}checked="checked"{/if} /></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>DNSSEC: Auto-secure</strong> <a class="vtip_description" title="If enabled, all new zones will automatically be secured with DNSSEC"></a></td>
        <td ><input  name="custom[autosecure]"  value="1" type="checkbox" {if $server.custom.autosecure}checked="checked"{/if} /></td>
    </tr>
</table>