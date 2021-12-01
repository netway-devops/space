
    <strong>Driver info: {$driverinfo.name}</strong>
    <div class="well">{$driverinfo.description}
        <br><br><b>Power billing is: </b>
        {if !$power_billing}
            <label class="label label-warning">Unavailable</label>
        {elseif $power_billing==1}
            <label class="label label-success">Available</label>
        {elseif $power_billing==2}
            <label class="label label-info">Available, averaged</label>
        {elseif $power_billing==3}
            <label class="label label-info">Available, averaged</label>
        {elseif $power_billing==4}
            <label class="label label-info">Available, averaged for entire device</label>
        {/if}
        <br>
        <b>Outlet on/off/reset is:</b>
        {if !$powercycle}
            <label class="label label-warning">Unavailable</label>
        {else}
            <label class="label label-success">Available</label>

        {/if}

    </div>
    {if $driverinfo.snmp}
    <div class="form-horizontal" id="{$id}">
        <div class="form-group">
            <label class="col-sm-2 control-label">SNMP Protocol</label>
            <div class="col-sm-4">
                <select id="snmp" name="custom[snmp]" class="form-control form-control-sm">
                    {foreach from= $driverinfo.snmp item=version key=id}
                        <option value="{$id}" {if $server.custom.snmp == $id}selected{/if}>{$version}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label">SNMP port</label>
            <div class="col-sm-4">
                <input name="custom[snmpport]" type="text" class="form-control form-control-sm" value="{if $server.custom.snmpport}{$server.custom.snmpport}{else}161{/if}"/>
            </div>
        </div>
    </div>
        {foreach from=$driverinfo.snmp item=version key=id}
            {if $driverinfo[$id]}
                <div class="form-horizontal snmp" id="{$id}" style="display: none;">
                    {foreach from=$driverinfo[$id] item=field}
                        <div class="form-group">
                            <label class="col-sm-2 control-label">{$field.name}</label>
                            <div class="col-sm-4">
                                {if $field.value}
                                    <select name="custom[{$id}][{$field.variable}]" class="form-control form-control-sm">
                                        {foreach from=$field.value item=val}
                                            <option value="{$val}" {if $server.custom[$id][$field.variable] == $val}selected{/if}>{$val}</option>
                                        {/foreach}
                                    </select>
                                {else}
                                    <input type="text" class="form-control form-control-sm" name="custom[{$id}][{$field.variable}]" value="{$server.custom[$id][$field.variable]}">
                                {/if}
                            </div>
                        </div>
                    {/foreach}
                </div>
            {/if}
        {/foreach}
    {/if}
{if $driverinfo.features}
    <div>
        <table class="table">
            <thead>
                <tr>
                    <th>Feature</th>
                    <th>Enable</th>
                    <th>OID</th>
                    <th>Values</th>
                    <th>Unit</th>
                    <th>Test</th>
                </tr>
            </thead>
            <tbody>
            {foreach from=$driverinfo.features item=feature}
                <tr>
                    <td>{$feature.feature} {if $feature.description}<a class="vtip_description " title="{$feature.description}"></a>{/if}</td>
                    <td><input type="checkbox" class="enable" name="custom[{$feature.file}]" data-item="{$feature.file}" value="1" {if $feature.enable || $server.custom[$feature.file]}checked="checked"{/if}></td>
                    <td><input type="text" class="{$feature.file} form-control" name="custom[config][{$feature.file}][oid]" value="{$server.custom.config[$feature.file].oid}"></td>
                    <td>
                        {if isset($feature.value)}
                            {if is_array($feature.value)}
                                {foreach from=$feature.value item=val key=id}
                                    <div class="input-group" style="max-width: 90px; float: left;">
                                        <div class="input-group-addon">{$val}</div>
                                        <input type="text" style="max-width: 40px; min-width: 40px;" class="{$feature.file} form-control" name="custom[config][{$feature.file}][value][{$val}]" value="{$server.custom.config[$feature.file].value[$val]}">
                                    </div>
                                {/foreach}
                                <div class="clear"></div>
                            {else}
                                <input type="text" class="{$feature.file}" name="custom[config][{$feature.file}][value]" value="{$server.custom.config[$feature.file].value}">
                            {/if}
                        {/if}
                    </td>
                    <td>
                        {if $feature.unit}
                            <select name="custom[config][{$feature.file}][unit]" class="{$feature.file} form-control" style="max-width: 75px;">
                                {foreach from=$feature.unit item=unit key=id}
                                    <option value="{$id}" {if $server.custom.config[$feature.file].unit == $id}selected{/if}>{$unit}</option>
                                {/foreach}
                            </select>
                        {/if}
                    </td>
                    <td style="text-align: right;">
                        <div class="input-group" style="max-width: 110px; float: left;">
                            {if $feature.port}
                                <input type="text" style="min-width: 60px;" class="{$feature.file} form-control" name="custom[config][{$feature.file}][port]" placeholder="{$lang.Port|ucfirst}" value="{$server.custom.config[$feature.file].port}">
                                <div class="input-group-addon {$feature.file}" style="cursor: pointer;" onclick="changeTest('{$feature.file}');">Test</div>
                            {else}
                                <div class="input-group-addon {$feature.file}" style="border: 1px solid #ccc; cursor: pointer;" onclick="changeTest('{$feature.file}');">Test</div>
                            {/if}
                        </div>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    <input type="hidden" name="custom[test_connection]" id="test_connection" value="listports">
{/if}
{if $features && !$driverinfo.features}<div>
    <b>Show readings to staff/customer: </b><br/>
    {if $features.active_power}<input type="checkbox" name="custom[active_power]" value="1" {if $server.custom.active_power}checked="checked"{/if}/> Active Power <br/>{/if}
    {if $features.apparent_power}<input type="checkbox" name="custom[apparent_power]" value="1"  {if $server.custom.apparent_power}checked="checked"{/if}/> Apparent Power <br/>{/if}
    {if $features.current}<input type="checkbox" name="custom[current]" value="1" {if $server.custom.current}checked="checked"{/if} /> Current <br/>{/if}
    {if $features.maxcurrent}<input type="checkbox" name="custom[maxcurrent]" value="1" {if $server.custom.maxcurrent}checked="checked"{/if} /> Maximum Current <br/>{/if}
    {if $features.voltage}<input type="checkbox" name="custom[voltage]" value="1" {if $server.custom.voltage}checked="checked"{/if} /> Voltage <br/>{/if}


    {if $features.username}
        <strong>Enter web login access details:</strong> <br/>
        Username: <input type="text" name="custom[username]" value="{$server.custom.username}" class="inp" /> <br/>
        Password: <input type="password" name="custom[password]" value="{$server.custom.password}" class="inp" /> <br/>
    {/if}


</div>{else}
    <br/>
{/if}
    {if $driverinfo.features}
        {literal}
        <script>
            $("a.vtip_description").vTip();

            $(function () {
                $('.enable').each(function () {
                   if (!$(this).prop('checked')) {
                       var c = $(this).data('item'),
                           ci = $('.' + c);
                       ci.prop('disabled', true);
                       ci.css('pointer-events', 'none');
                   }
                });
            });

            $('.enable').on('click', function () {
                var c = $(this).data('item'),
                    ci = $('.' + c);
                if (!$(this).prop('checked')) {
                    ci.prop('disabled', true);
                    ci.css('pointer-events', 'none');
                } else {
                    ci.prop('disabled', false);
                    ci.css('pointer-events', '');
                }
            });

            function changeTest(action) {
                $('#test_connection').val(action);
                $('#testing_button').click();
            }
        </script>
        {/literal}
    {/if}
    {if $driverinfo.snmp}
        {literal}
            <script>
                var snmp = $('#snmp');
                $(function () {
                    var version = snmp.val();
                    changeversion(version);
                });

                snmp.on('change', function () {
                    var version = $('#snmp option:selected').val();
                    changeversion(version);
                });

                function changeversion(version) {
                    $('.snmp').hide();
                    $('#'+version).show();
                }
            </script>
        {/literal}
    {/if}
