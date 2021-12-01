<div class="product_config_container">
    <input type="hidden" name="update" value="1" />
    {assign var="default" value=$module.default}
    <!-- additional module -->
    <div class="form-horizontal">
        <div class="form-group module-group">
            <label class="control-label col-md-2">{$lang.app_connection}</label>

            {if $additionalservers.$kl }
                <div class="col-md-5 col-lg-6">
                    <div class="ui-ddown serv_picker form-control" id="serv_picker">
                        <div class="ui-ddown-default" placeholder="{$lang.pickservers}">{strip}
                                {if ($module.server && $module.server!='' && $module.server!=0) || $newserverid}
                                    {foreach from=$additionalservers.$kl item=gserver}
                                        {foreach from=$gserver.servers item=server}
                                            {if $module.server[$server.id]}{$server.name}, {/if}
                                        {/foreach}
                                    {/foreach}
                                {/if}
                            {/strip}</div>
                        <div class="ui-ddown-list">
                            <ul>
                                <input type="hidden" name="server[]" value=""/>
                                {foreach from=$additionalservers.$kl item=gserver key=gname}
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
                                                       {if $module.server[$server.id]}checked='checked'{/if}
                                                       value="{$server.id}"
                                                        {if $server.noconfig}data-noconfig{/if} />
                                                <label for="gs-{$server.id}">
                                                    <span>{$server.name}</span>
                                                    ({$server.accounts}
                                                    /{$server.max_accounts} {$lang.Accounts})
                                                </label>
                                            </li>
                                        {/foreach}

                                    {else}
                                        {foreach from=$gserver.servers item=server}
                                            <li class="single" >
                                                <input type="checkbox" class="elcc"
                                                       name="server[{$server.id}]"
                                                       id="gs-{$server.id}"
                                                       {if $module.server[$server.id]}checked='checked'{/if}
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
                <div class="col-md-5 col-lg-4" id="use_added_servers">
                    <a href="#" class="btn btn-default new_control {if $loadable}test-conection{else}load-options{/if}"
                       onclick="return getFieldValues('{if $product_id}{$product_id}{else}{$module.product_id}{/if}',this)">
                        <i class="fa {if $loadable}fa-cloud-download{else}fa-plug{/if}"></i>
                        {if $loadable}{$lang.getvalsfromserver}{else}Test Connection{/if}
                    </a>
                    {foreach from=$additionalservers.$kl item=gserver}
                        <a class="btn btn-default" href="?cmd=servers&action=add&group={$gserver.id}">
                            <i class="fa fa-plus"></i> {$lang.addnewserver}
                        </a>
                        {break}
                    {/foreach}
                </div>
            {else}
                <div class="col-md-10">
                    <a class="btn btn-default" href="?cmd=servers&action=add&module={$module.module}">
                        <i class="fa fa-plus"></i> {$lang.addnewserver}
                    </a>
                    You need to configure your App first in Settings &raquo; Apps
                </div>
            {/if}

        </div>
    </div>

    <div class="product-module-config">
        {if !$multicustomconfig.$kl}
            <div class="multimodule">
                <div id="getvaluesloader" class="test-connection">

                    {if $loadable || $test_connection}
                        {if $test_connection_result}
                            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                                {$lang.test_configuration}:
                                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}
                                {else}{$test_connection_result.result}{/if}
                                {if $test_connection_result.error}: {$test_connection_result.error}{/if}
                            </span>
                        {/if}
                        {if $newserverid}
                            <span style="margin-left: 10px; font-weight: bold; color: #009900;padding:5px"
                                  class="shownice">
                                {$lang.newappadded}
                            </span>
                        {/if}
                    {/if}
                </div>
                <div class="clear"></div>
                <div id="subwiz_opt">
                    <table border="0" width="100%" class="table table-striped" cellpadding="5" cellspacing="0"
                           {if $download_yml && empty($default)}style="display:none"{/if} id="configoptionstable">
                        {if $loadtemplates }
                            <tr>
                                <td colspan="2">

                                    {if $loadtemplates}
                                        <a onclick="return loadOStoConfig({if $product_id}{$product_id}{else}{$module.product_id}{/if})"
                                           class="btn btn-default btn-sm" href="#" id="loadostemplates"
                                           {if !$product.ospick}style="display:none"{/if}>
                                            <span class="fa fa-cloud-download"></span> Load OS templates into Form field
                                        </a>
                                    {if $osconfig_id}
                                        <script type="text/javascript">
                                            editCustomFieldForm({$osconfig_id},{if $product_id}{$product_id}{else}{$module.product_id}{/if});
                                            refreshConfigView({if $product_id}{$product_id}{else}{$module.product_id}{/if});
                                        </script>
                                    {/if}
                                        <script type="text/javascript">
                                            {literal}
                                            if (typeof(getFieldValues) != 'loadOStoConfig') {
                                                window.loadOStoConfig = function (pid) {
                                                    //basically get values from server with extra param - loadosconfig=true
                                                    $('input[name=addserver]').after("<input type='hidden' name='loadosconfig' value='true'/>");
                                                    return getFieldValues(pid);
                                                }
                                            }
                                            {/literal}
                                        </script>
                                    {/if}

                                </td>
                            </tr>
                        {/if}

                        {foreach from=$module.options item=conf key=k name=checker}
                            <tr id="{$k}row">

                                {assign var="name" value=$conf.name}
                                {assign var="amodulename" value=$module.modulename}
                                {assign var="baz" value="$amodulename$name"}

                                <td>
                                    <strong>
                                        {if $lang.$baz}{$lang.$baz}
                                        {elseif $lang.$name}{$lang.$name}:
                                        {elseif $name}{$name}:
                                        {else}{$k}:{/if}
                                    </strong>
                                    {if $conf.description}
                                        <a class="vtip_description" title="{$conf.description}"
                                           {if $conf.variable}id="config_{$conf.variable}_descr"{/if}></a>
                                        <br/>
                                    {/if}
                                </td>
                                <td {if $conf.variable}id="config_{$conf.variable}"{/if}>
                                    {if $conf.type=='input'}
                                        {include file='moduleconfig/ajax.input.tpl'}
                                    {elseif $conf.type=='hbinput'}
                                        {include file='moduleconfig/ajax.hbinput.tpl'}
                                    {elseif $conf.type=='loadable'}
                                        {include file='moduleconfig/ajax.loadable.tpl'}
                                    {elseif $conf.type=='loadablemultiple'}
                                        {include file='moduleconfig/ajax.loadablemultiple.tpl'}
                                    {elseif $conf.type=='loadablebox'}
                                        {include file='moduleconfig/ajax.loadablebox.tpl'}
                                    {elseif $conf.type=='loadablecheck'}
                                        {include file='moduleconfig/ajax.loadablecheck.tpl'}
                                    {elseif $conf.type=='check'}
                                        {include file='moduleconfig/ajax.check.tpl'}
                                    {elseif $conf.type=='select'}
                                        {include file='moduleconfig/ajax.select.tpl'}
                                    {elseif $conf.type=='text'}
                                        {$conf.value|default:$conf.default|escape:'html'}
                                    {elseif $conf.type=='tpl'}
                                        {include file=$conf.tpl}
                                    {/if}
                                    {if $conf.variable || $conf.forms}
                                        <span class="fs11">
                                            <input type="checkbox"
                                                   class="formchecker"
                                                   rel="{if $conf.variable}{$conf.variable}{else}{$k}{/if}"/>
                                            Allow client to adjust during order
                                        </span>
                                    {/if}
                                </td>
                            </tr>
                        {/foreach}
                    </table>
                </div>
            </div>
            {literal}
                <script>
                    $(function () {
                        $("a.vtip_description").not('.vtip_applied').vTip();
                        bindAppWithForms();
                    });
                </script>
            {/literal}
        {else}
            <table style="width: 100%;">
                {include file=$multicustomconfig.$kl}
            </table>
        {/if}
    </div>
</div>