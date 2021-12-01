<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    {if $server_fields.display.ip}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.username}<tr><td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.password}<tr><td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>{/if}
    {if $server_fields.display.field1}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td><td >
            {if $pdu_drivers}
            <select name="field1" class="inp" id="pdu_driver" onchange="pduDriverChange()">
                {foreach from=$pdu_drivers item=d key=l}
                <option value="{$l}" {if $l==$server.field1}selected="selected"{/if}>{$d}</option>
                {/foreach}
            </select>
            {else}
            <input  name="field1" size="25" value="{$server.field1}" class="inp"/>
            {/if}
            <a class="vtip_description" title="Select manufacturer or model that is most simmilar to one you want to connect to. <br>You can easily define your own drivers in /includes/modules/Hosting/pdu_snmp/devices"></a>
        </td></tr>{/if}

    <tr><td></td>

    <td id="additional_items">


    </td></tr>

    <tr><td  align="right" width="165"><strong>AC Voltage  <a class="vtip_description" title="Enter if you plan to bill for power consumption, and this device does not support kWh readouts"></a></strong></td><td ><input  name="field2" size="25" value="{$server.field2}" class="inp" placeholder="120"/> V</td></tr>
    <tr><td  align="right" width="165"><strong>Power Factor  <a class="vtip_description" title="Enter if you plan to bill for power consumption, and this device does not support kWh readouts"></a></strong></td><td ><input  name="hash" size="5" value="{$server.hash}" class="inp" placeholder="1.0"/></td></tr>
    <tr><td  align="right" width="165"><strong>Phases  <a class="vtip_description" title="Enter if you plan to bill for power consumption, and this device does not support kWh readouts"></a></strong></td><td >
            <input  name="status_url" value="1" {if $server.status_url!='3'}checked="checked"{/if} type="radio"/> Single-Phase <br>
            <input  name="status_url" value="3" {if $server.status_url=='3'}checked="checked"{/if} type="radio"/> Three-Phase <br>
        </td></tr>

</table>
<script>
    $("a.vtip_description").vTip();

    {literal}

        function pduDriverChange() {
            var driver = $('#pdu_driver').val();
            var server_id=$('input[name=server_id]').val();
            ajax_update('?cmd=pdu_snmp&action=loaddriveroptions',{driver:driver,server_id:server_id},'#additional_items',true);
            return false;
        }

        $(document).ready(function(){
            pduDriverChange();
        });
    {/literal}
</script>