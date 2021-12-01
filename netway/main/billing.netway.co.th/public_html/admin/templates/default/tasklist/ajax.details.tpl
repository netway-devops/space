{if $task.description}
    <div class="form-group">
        {$task.description}
    </div>
{/if}

{if $place == 'metrics'}
    {include file="tasklist/_metrics_details.tpl"}
{else}
    {include file="tasklist/_default_details.tpl"}
{/if}

{if $task.filters}
    <div class="form-group">
        <a class="btn btn-default btn-xs tasklist-contitions">
            <i class="fa fa-code"></i>
            Additional conditions
        </a>
        <div id="query-builder" data-filters="{$task.filters|@json_encode|escape}" data-rules="{$task.conditions|@json_encode|escape}"></div>
    </div>
{/if}

{foreach from=$task.config item=conf key=k}
    <div class="form-group">
        {if $conf.type != 'checkbox' && $conf.type != 'radio'}
            <label>{$conf.name}</label>
        {/if}
        {if $k=='email_id'}
            <div id="new_taskmail_msg" class="form-group">
                <select name="config[email_id]" class="form-control">
                    {foreach from=$conf.default.All item=email}
                        <option value="{$email.id}"
                                {if $conf.value==$email.id}selected="selected"{/if}>
                            {$email.tplname}
                        </option>
                    {/foreach}
                </select>
            </div>
            {$lang.Or}
            <a href="?cmd=emailtemplates&action=add&inline=true&to=new_taskmail&dontclose=true"
               class="btn btn-default btn-compose-msg btn-xs" target="_blank" >
                <i class="fa fa-plus-square"></i> {$lang.composenewmsg}
            </a>
        {elseif $k == 'staff'}
            <select id="staff_list" name="config[staff][]" class="form-control chosen" multiple>
                {foreach from=$conf.default item=admin}
                    <option value="{$admin.id}" {if in_array($admin.id, $conf.value)}selected="selected"{/if}>{$admin.username}</option>
                {/foreach}
            </select>
        {else}
            {if $conf.type=='select'}
                <select name="config[{$k}]" class="form-control">
                    {foreach from=$conf.default item=i}
                        <option {if $conf.value==$i}selected="selected"{/if}>{$i}</option>
                    {/foreach}
                </select>
            {elseif $conf.type=='loadable'}
                <select name="config[{$k}]" class="form-control">
                    {foreach from=$conf.default item=i}
                        <option value="{if $i.id}{$i.id}{else}{$i.name}{/if}" {if $conf.value==$i.id}selected="selected"{/if}>
                            {if $i.name}{$i.name}{/if}
                        </option>
                    {/foreach}
                </select>
            {elseif $conf.type=='textarea'}
                <textarea name="config[{$k}]" rows="6" placeholder="{$conf.default}" class="form-control">{$conf.value|escape}</textarea>
            {elseif $conf.type=='checkbox'}
                {if $k === 'use_variables' && $task.handler === 'TaskList::openSupportTicket'}
                    {literal}
                        <script>
                            $(function () {
                                $('.vtip_description').vTip();
                                $('.toggle_variables').on('change', function () {
                                    if($(this).is(':checked')) {
                                        $('.panel_variables').show();
                                    } else {
                                        $('.panel_variables').hide();
                                    }
                                }).trigger('change');
                            });
                            function switchVariable(el) {
                                var v = $(el).val();
                                if (v == 0)
                                    return;
                                $('#var-container').val(v);
                                $('#variable-box').show();
                            }
                        </script>
                    {/literal}
                    <div class="row">
                        <div class="col-md-2">
                            <div class="checkbox">
                                <label>
                                    <input class="toggle_variables" name="config[{$k}]" type="checkbox" {if $conf.value}checked="checked"{/if} value="1" title="{$conf.default}"/>
                                    {$conf.name}
                                </label>
                            </div>
                        </div>
                        <div class="col-md-10">
                            {if $variables}
                                <div class="panel panel-default panel_variables">
                                    <div class="panel-heading">
                                        <span>Template variables</span>
                                        <i class="vtip_description" title="Variables will be replaced by actual values when ticket will be opened.<br/>
                                            I.e. {literal}{$product.name}{/literal} will be replaced with product name
                                        "></i>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group">
                                            <select class="form-control" onchange="switchVariable(this);" id="tpl_variables">
                                                <option value="0">---</option>
                                                {foreach from=$variables item=var key=var_key}
                                                    {if ($to=='unsuspend' || $to=='suspend' || $to=='terminate' || $to=='welcome') && ($var_key=='domain' || $var_key=='invoice' || $var_key=='other')}
                                                    {else}
                                                        <optgroup label="{if $lang[$var_key]}{$lang[$var_key]}{else}{$var_key}{/if}">
                                                            {foreach from=$var item=var_desc key=var_name}
                                                                <option value="{ldelim}${if $var_key != 'other'}{$var_key}.{/if}{$var_name}{rdelim}">{if $lang[$var_desc]}{$lang[$var_desc]}{else}{$var_desc}{/if} </option>
                                                            {/foreach}
                                                        </optgroup>
                                                    {/if}
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="form-group" id="variable-box" style="display:none">
                                            <label class="fs11">Copy & paste to template:</label>
                                            <input type="text" readonly id="var-container" class="form-control"/>
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                {else}
                    <div class="checkbox">
                        <label>
                            <input name="config[{$k}]" type="checkbox" {if $conf.value}checked="checked"{/if} value="1" title="{$conf.default}" />
                            {$conf.name}
                        </label>
                    </div>
                {/if}
            {elseif $conf.type=='input'}
                <input name="config[{$k}]" class="form-control" rows="6" value="{$conf.value|escape}" type="text"/>
            {/if}
        {/if}
    </div>
{/foreach}

<div class="clear"></div>

