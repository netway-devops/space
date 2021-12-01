<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td>
        <td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{else}{$lang.Port}{/if}</strong></td>
        <td ><input  name="field1" size="25" value="{$server.field1}" class="inp" placeholder="8081"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{else}{$lang.api_key}{/if}</strong></td>
        <td ><input  name="field2" size="25" value="{$server.field2}" class="inp"/></td>
    </tr>
</table>