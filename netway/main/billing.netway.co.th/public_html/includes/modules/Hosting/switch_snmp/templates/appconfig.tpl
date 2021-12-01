<div class="form-horizontal">
    {if $server_fields.display.ip}
        <div class="form-group">
            <label class="col-sm-2 control-label">{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</label>
            <div class="col-sm-5">
                <input type="text" name="ip" size="60" value="{$server.ip}" class="form-control">
            </div>
        </div>
    {/if}
    {if $server_fields.display.field2}
        <div class="form-group">
            <label class="col-sm-2 control-label">{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</label>
            <div class="col-sm-5">
                <select name="field2" class="form-control">
                    <option value="v2" {if 'v2'==$server.field2}selected="selected"{/if}>v2</option>
                    <option value="v3" {if 'v3'==$server.field2}selected="selected"{/if}>v3</option>
                </select>
            </div>
        </div>
    {/if}
    {if $server_fields.display.field1}
        <div class="form-group snmp-v2">
            <label class="col-sm-2 control-label">{if $server_fields.description.field1}{$server_fields.description.field1}{/if}<a class="vtip_description" style="padding-left: 15px;" title="Select manufacturer or model that is most simmilar to one you want to connect to. <br>You can easily define your own drivers in /includes/modules/Hosting/switch_snmp/devices"></a></label>
            <div class="col-sm-5">
                {if $pdu_drivers}
                    <select name="field1" class="form-control v2">
                        {foreach from=$pdu_drivers item=d key=l}
                            <option value="{$l}" {if $l==$server.field1}selected="selected"{/if}>{$d}</option>
                        {/foreach}
                    </select>
                {else}
                    <input  name="field1" size="25" value="{$server.field1}" class="form-control v2"/>
                {/if}
            </div>
        </div>
        <div class="form-group snmp-v3">
            <label class="col-sm-2 control-label">{if $server_fields.description.field1}{$server_fields.description.field1}{/if}<a class="vtip_description" style="padding-left: 15px;" title="Select manufacturer or model that is most simmilar to one you want to connect to. <br>You can easily define your own drivers in /includes/modules/Hosting/switch_snmp/devices (drivers for SNMP v3 should start with 'v3_' in the directory name)"></a></label>
            <div class="col-sm-5">
                {if $pdu_drivers_v3}
                    <select name="field1" class="form-control v3">
                        {foreach from=$pdu_drivers_v3 item=d key=l}
                            <option value="{$l}" {if $l==$server.field1}selected="selected"{/if}>{$d}</option>
                        {/foreach}
                    </select>
                {else}
                    <input  name="field1" size="25" value="{$server.field1}" class="form-control v3"/>
                {/if}
            </div>
        </div>
    {/if}
    {if $server_fields.display.username}
        <div class="form-group">
            <label class="col-sm-2 control-label">{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</label>
            <div class="col-sm-5">
                <input type="text" name="username" size="25" value="{$server.username}" class="form-control"/>
            </div>
        </div>
    {/if}
    {if $server_fields.display.password}
        <div class="form-group">
            <label class="col-sm-2 control-label">{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</label>
            <div class="col-sm-5">
                <input type="password" name="password" size="25" class="form-control" value="{$server.password}" autocomplete="off"/>
            </div>
        </div>
    {/if}
    {if $server_fields.display.custom}
        <div class="snmp-v3">
            {foreach from=$server_fields.display.custom item=custom key=key}
                <div class="form-group">
                    <label class="col-sm-2 control-label">{if $custom.name}{$custom.name}{else}{$key}{/if}</label>
                    <div class="col-sm-5">
                        {if $custom.type == 'select'}
                            {if $custom.default}
                                <select name="custom[{$key}]" class="form-control">
                                    {foreach from=$custom.default item=opt}
                                        <option {if $server.custom.$key == $opt}selected{/if}>{$opt}</option>
                                    {/foreach}
                                </select>
                            {/if}
                        {else}
                            <input type="{$custom.type}" name="custom[{$key}]" size="25" value="{$server.custom.$key}" class="form-control"/>
                        {/if}
                    </div>
                </div>
            {/foreach}
        </div>
    {/if}
</div>
{literal}
<script>
    $("a.vtip_description").vTip();
    var field2 = $('select[name=field2]');
    $(function () {
        if (field2.val() === 'v2') {
            $('.snmp-v3').hide();
            $('.v3').prop('disabled', true);
        } else if (field2.val() === 'v3') {
            $('.snmp-v2').hide();
            $('.v2').prop('disabled', true);
        }
    });

    field2.on('change', function () {
        if (field2.val() === 'v2') {
            $('.snmp-v3').slideUp(function () {
                $('.v3').prop('disabled', true);
            });
            $('.v2').prop('disabled', false);
            $('.snmp-v2').slideDown();
        } else {
            $('.v3').prop('disabled', false);
            $('.snmp-v3').slideDown();
            $('.snmp-v2').slideUp(function () {
                $('.v2').prop('disabled', true);
            });
        }
    });
</script>
{/literal}