<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    <tr>
        <td  align="right" width="165"><strong>Database Type</strong></td>
        <td >
            <select name="custom[backend]">
                <option {if $server.custom.backend=='MySQL'}selected="selected"{/if}>MySQL</option>
                <option {if $server.custom.backend=='PostgreSQL'}selected="selected"{/if}>PostgreSQL</option>
            </select>
        </td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td>
        <td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td>
        <td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td>
        <td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td>
        <td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td>
        <td ><input  name="field1" size="25" value="{$server.field1}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</strong></td>
        <td ><input  name="field2" size="25" value="{$server.field2}" class="inp" placeholder="3306"/></td>
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
        <td  align="right" width="165"><strong>PowerDNS version</strong></td>
        <td >
            <select name="custom[version]">
                <option {if $server.custom.version=='3'}selected="selected"{/if} value="3">3.x</option>
                <option {if $server.custom.version=='4'}selected="selected"{/if} value="4">4.x</option>
            </select>
        </td>
    </tr>

    <tr>
        <td  align="right" width="165"><strong>SSH Hostname</strong> <a class="vtip_description" title="Required for DNSSec, module will use SSH to run dnssec commands. Leave empty if no DNSSEC is used/installed on PDNS"></a></td>
        <td ><input  name="custom[hostname]" size="25" value="{$server.custom.hostname}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>SSH Port</strong></td>
        <td ><input  name="custom[port]" size="25" value="{$server.custom.port}" class="inp" placeholder="22"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>SSH Username</strong> <a class="vtip_description" title="Required for DNSSec, module will use this user to connect over SSH to PowerDNS to run dnssec commands"></a></td>
        <td ><input  name="custom[username]" size="25" value="{$server.custom.username}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>SSH Private key</strong> <a class="vtip_description" title="Enter path where your private key for ssh user is located. Refer to documentation for details"></a></td>
        <td ><input  name="custom[sshkey]" size="25" value="{$server.custom.sshkey}" class="inp" placeholder="/home/hostbill/.ssh/id_rsa"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>DNSSEC: Autorectify</strong> <a class="vtip_description" title="If enabled, any DNS change with PowerDNS module will cause zone to be rectified (if DNSSEC for zone is enabled). Requires enabling HostBillQueue module"></a></td>
        <td ><input  name="custom[autorectify]"  value="1" type="checkbox" {if $server.custom.autorectify}checked="checked"{/if} /></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>DNSSEC: Auto-secure</strong> <a class="vtip_description" title="If enabled, all new zones will automatically be secured with DNSSEC"></a></td>
        <td ><input  name="custom[autosecure]"  value="1" type="checkbox" {if $server.custom.autosecure}checked="checked"{/if} /></td>
    </tr>
</table>
