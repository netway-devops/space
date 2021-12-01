<table width="100%">
    <tbody>
        <tr>
            <td align="right" width="150"><label class="control-label">{$lang.app_connection}</label></td>
            <td>
                {if $additionalservers[0]}
                    <div style="margin-left: 8px;">
                        <div class="ui-ddown serv_picker form-control" id="serv_picker">
                            <div class="ui-ddown-default" placeholder="{$lang.pickservers}">{strip}
                                    {if ($product.server && $product.server!='' && $product.server!=0) || $newserverid}
                                        {foreach from=$additionalservers[0] item=gserver}
                                            {foreach from=$gserver.servers item=server}
                                                {if $product.server[$server.id]}{$server.name}, {/if}
                                            {/foreach}
                                        {/foreach}
                                    {/if}
                                {/strip}</div>
                            <div class="ui-ddown-list">
                                <ul>
                                    <input type="hidden" name="server[]" value=""/>
                                    {foreach from=$additionalservers[0] item=gserver key=gname}
                                        {if $gserver.qty>1}
                                            <li class="grouped category">
                                                <input type="checkbox" class="serv-pick-group ccc_{$gserver.id}"
                                                       id="gro-{$gserver.id}"/>
                                                <label for="gro-{$gserver.id}">
                                                    {$gname} ({$gserver.qty} {$lang.Servers})
                                                </label>
                                            </li>
                                            {foreach from=$gserver.servers item=server}
                                                <li class="grouped nested" >
                                                    <input type="checkbox"
                                                           class="elcc cc_{$server.group_id}"
                                                           name="server[{$server.id}]"
                                                           id="gs-{$server.id}"
                                                           {if $product.server[$server.id]}checked='checked'{/if}
                                                           value="{$server.id}"
                                                            {if $server.noconfig}data-noconfig{/if} />
                                                    <label for="gs-{$server.id}">
                                                        <span>{$server.name}</span>
                                                    </label>
                                                </li>
                                            {/foreach}

                                        {else}
                                            {foreach from=$gserver.servers item=server}
                                                <li class="single" >
                                                    <input type="checkbox" class="elcc"
                                                           name="server[{$server.id}]"
                                                           id="gs-{$server.id}"
                                                           {if $product.server[$server.id]}checked='checked'{/if}
                                                           value="{$server.id}"
                                                            {if $server.noconfig}data-noconfig{/if} />
                                                    <label for="gs-{$server.id}">
                                                        {$gname}: <span>{$gserver.servers[0].name}</span>
                                                    </label>
                                                </li>
                                            {/foreach}
                                        {/if}
                                    {/foreach}
                                </ul>
                                <a href="#close" class="editbtn right">{$lang.Close}</a>
                            </div>
                        </div>
                    </div>
            <td width="300">
                <div id="use_added_servers" style="float: right">
                    <a href="#" class="btn btn-default {if $loadable}test-conection{else}load-options{/if}"
                       onclick="return getFieldValues('{if $product_id}{$product_id}{else}{$module.product_id}{/if}',this)">
                        <i class="fa {if $loadable}fa-cloud-download{else}fa-plug{/if}"></i>
                        {if $loadable}{$lang.getvalsfromserver}{else}Test Connection{/if}
                    </a>
                    {foreach from=$additionalservers[0] item=gserver}
                        <a class="btn btn-default" href="?cmd=servers&action=add&group={$gserver.id}">
                            <i class="fa fa-plus"></i> {$lang.addnewserver}
                        </a>
                        {break}
                    {/foreach}
                </div>
            </td>
                {else}
                    <div style="padding: 0 9px;">
                        <a class="btn btn-default" href="?cmd=servers&action=add&module={$product.module}">
                            <i class="fa fa-plus"></i> {$lang.addnewserver}
                        </a>
                        You need to configure your App first in Settings &raquo; Apps
                    </div>
                {/if}
            </td>
        </tr>
    </tbody>
</table>
<div id="getvaluesloader">
    {if $test_connection_result}
        <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
            {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}
            {else}{$test_connection_result.result}
            {/if}
            {if $test_connection_result.error}: {$test_connection_result.error}
            {/if}
            </span>
    {/if}
</div>
<div class="clear"></div>
{if $product.app_id}
    <input type="hidden" name="modules[0][update]" value="1" />
    <input type="hidden" value="{$product.app_id}" name="app_id"/>
{elseif $product.module}
    <div id="prod_serverform" {if $modconfig &&  !$modconfig.config}style="display: none"{/if}
         class="sectionheadblue prod_serverform">
        <div style="font-size: 14px"><strong>Enter App details</strong></div>
        <input name="addserver" value="{if $server_values.addserver || !$servers}1{else}0{/if}" type="hidden"/>

        <table border="0" cellpadding="0" cellspacing="6" width="100%" style="margin-bottom:10px;">

            {foreach from=$modconfig.config item=conf key=k}
                <tr>

                    {assign var="name" value=$k}
                    {assign var="name2" value=$modconfig.module}
                    {assign var="baz" value="$name2$name"}
                    <td align="right" width="165">
                        <strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</strong>
                    </td>
                    {if $conf.type=='input'}
                        <td><input type="text" name="option[{$k}]" value="{$conf.value}" class="inp toserialize"/></td>
                    {elseif $conf.type=='password'}
                        <td><input type="password" autocomplete="off" name="option[{$k}]" value="{$conf.value}"
                                   class="inp toserialize"/></td>
                    {elseif $conf.type=='check'}
                        <td><input name="option[{$k}]" type="checkbox" value="1" class="toserialize"
                                   {if $conf.value == "1"}checked="checked"{/if} style="margin:0px"/></td>
                    {elseif $conf.type=='select'}
                        <td><select name="option[{$k}]" class="inp toserialize">
                                {foreach from=$conf.default item=selectopt}
                                    <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                                {/foreach}
                            </select></td>
                    {elseif $conf.type=='textarea'}
                        <td>
                            <span style="vertical-align:top">
                                <textarea name="option[{$k}]" rows="5" cols="60"
                                          style="margin:0px"
                                          class="toserialize">{$conf.value}</textarea></span>
                        </td>
                    {/if}

                </tr>
            {/foreach}
            <tr>
                <td></td>
                <td>
                    <a href="#" class="new_control greenbtn" onclick="return saveProductFull();"><span class="disk">Save
                            app settings</span></a>
                    <span style="margin-left: 30px"><a onclick="return testDomConnection()" id="testing_button" href="#"
                                                       class="new_control"><span
                                    class="wizard">{$lang.test_configuration}</span></a></span>
                </td>
            </tr>
        </table>
    </div>
    <div id="loadable" style="text-align:center;padding:5px 0px;display: none"></div>
    <script type="text/javascript">
        {literal}
        function testDomConnection() {
            $('#loadable').html('<img src="ajax-loading.gif" />').show();
            var fields = $('form#productedit .toserialize').serialize();
            ajax_update('index.php?cmd=servers&action=test_connection&' + fields, {module_id: $('#modulepicker').val()}, '#loadable');
            return false;
        }
        {/literal}
    </script>
{/if}