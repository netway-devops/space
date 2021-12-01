{php}
$templatePath   = $this->get_template_vars('template_path');
include($templatePath . 'sendmessage.tpl.php');
{/php}

<link href="{$template_dir}js/chosen/chosen.css" rel="stylesheet" media="all">
<script type="text/javascript" src="{$template_dir}js/chosen/chosen.min.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td><h3>{$lang.notifyclients}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=sendmessage"  class="tstyled {if $action == 'default'}selected{/if}">{$lang.SendEmail}</a>
            {if 'config:EnablePortalNotifications:on'|checkcondition}
                <a href="?cmd=sendmessage&action=asnotification"  class="tstyled {if $action == 'asnotification'}selected{/if}">Portal Notify</a>
            {/if}
            {if 'config:MobileNotificationsClient:on'|checkcondition}
                <a href="?cmd=sendmessage&action=asmobile" class="tstyled {if $action == 'asmobile'}selected{/if}">Mobile Notification</a>
            {/if}
        </td>

        <td  valign="top" class="bordered">
            <div id="bodycont">
                {literal}
                <script type="text/javascript">
                    $(document).ready(function () {
                        $('#client-search').chosensearch({width: '100%'});
                        $('.select_template, #mobile_modules').chosenedge({
                            enable_split_word_search: true,
                            search_contains: true,
                        });
                        var radio = $('input[name=email_type]:checked').val(),
                            variable = $('input[name=use_variables]');

                        if (radio == 'template') {
                            $('.compose').hide();
                        } else {
                            $('.template').hide();
                        }

                        if (variable.prop('checked') == false)
                            $('.variables').hide();

                        $('input[name=email_type]').on('change', function () {
                            if ($(this).val() == 'template') {
                                $('#tpl_name, .variables').hide();
                            } else {
                                check_variable(variable);
                                check_tpl_name($('input[name=save]'));
                            }
                            $('.compose').toggle();
                            $('.template').toggle();
                        });
                        $('#preview-form-act').hide();

                        variable.on('change', function () {
                            check_variable(this);
                        });

                        $('#clientfilter').click(function () {
                            $.facebox({ajax: '?cmd=tickets&action=clientfilter'});
                            return false;
                        });
                        var to = $('#to');
                        if (to.length > 0)
                            to.height(to[0].scrollHeight - 12);

                        $('#msg_body').on('keyup', function () {
                            $('#character-length').html($(this).val().length);
                        });
                    });

                    function check_variable(checkbox) {
                        if ($(checkbox).prop('checked')) {
                            $('.variables').show();
                        } else {
                            $('.variables').hide();
                        }
                    }
                    function check_tpl_name(checkbox) {
                        if ($(checkbox).prop('checked')) {
                            $('#tpl_name').show();
                        } else {
                            $('#tpl_name').hide();
                        }
                    }
                    function save_tpl() {
                        if($("input[name='save']:checked").val() == 1) {
                            $('#tpl_name').show();
                        } else {
                            $('#tpl_name').hide();
                        }
                    }
                    function send_email(email = false) {
                        if($('#to').val() == '') {
                            alert('{/literal}{$lang.tofieldempty}{literal}');
                            return false;
                        }
                        if (!email || $("input[name='email_type']:checked").val() == 'compose') {
                            if($('#msg_body').val() == '') {
                                if(!confirm('{/literal}{$lang.withoutbody}{literal}'))
                                    return false;
                            }
                            if($('#subject').val() == '') {
                                if(!confirm('{/literal}{$lang.withoutsubject}{literal}'))
                                    return false;
                            }
                        }

                        return true;
                    }

                </script>
                {/literal}
                <div id="newshelfnav" class="newhorizontalnav" style="margin-bottom: 20px;">
                    <div class="list-1">
                        <ul>
                            <li class="{if $action == 'default'}active{/if}">
                                <a {if $action != 'default'} href="?cmd=sendmessage"{/if}><span>Send Email</span></a>
                            </li>
                            {if 'config:EnablePortalNotifications:on'|checkcondition}
                                <li class="{if $action == 'asnotification'}active{/if} last">
                                    <a {if $action != 'asnotification'} href="?cmd=sendmessage&action=asnotification"{/if}><span>Portal Notify</span></a>
                                </li>
                            {/if}
                            {if 'config:MobileNotificationsClient:on'|checkcondition}
                                <li class="{if $action == 'asmobile'}active{/if} last">
                                    <a {if $action != 'asmobile'} href="?cmd=sendmessage&action=asmobile"{/if}><span>Mobile Notification</span></a>
                                </li>
                            {/if}
                            <li class="{if $action == 'asticket'}active{/if}">
                                <a {if $action != 'asticket'} href="?cmd=tickets&action=new{if $selected}&client_id={$selected}{/if}"{/if}><span>Create Ticket</span></a>
                            </li>
                        </ul>
                    </div>
                </div>
                {if $sent}
                    <div class="blu" style="padding: 5px;">

                        <a href="?cmd=sendmessage{if $action == 'asmobile'}&action=asmobile{/if}"><strong>{$lang.sendanother}</strong></a>
                    </div>
                    <div class="lighterblue" style="padding:10px">
                        {if $logs}
                            {foreach from=$logs item=log}
                                {if $action=='asticket'}
                                    {if $log.success}
                                        Ticket created for
                                    {else}
                                        Could not create ticket for
                                    {/if}
                                {else}
                                    {if $log.failed}
                                        {$lang.no_clients_found}
                                    {elseif $log.success}
                                        {if $action == 'asmobile'}
                                            {$lang.messagesentto}
                                        {else}
                                            {$lang.emailsentto}
                                        {/if}
                                    {else}
                                        {if $action == 'asmobile'}
                                            {$lang.cantsendmessageto}
                                        {else}
                                            {$lang.cantsendto}
                                        {/if}
                                    {/if}
                                {/if}
                                {if $log.client_id && $log.client_name}<a href="?cmd=clients&action=show&id={$log.client_id}">{$log.client_name}</a>
                                {else}<strong>{$log.email}</strong>
                                {/if}.
                                <br />
                            {/foreach}
                        {/if}
                    </div>
                    <div class="blu">
                        <a href="?cmd=sendmessage{if $action == 'asmobile'}&action=asmobile{/if}" ><strong>&laquo; {$lang.sendanother}</strong></a>
                    </div>
                {else}
                    <form action="?cmd=sendmessage{if $action != 'default'}&action={$action}{/if}" method="post" id="massform">
                        <input type="hidden" name="type" value="{$sendtype}" />
                        {if $sms}
                            <input type="hidden" name="sms" value="1" />
                        {/if}
                        {foreach from=$selected item=item}
                            <input type="hidden" name="selected[]" value="{$item}" />
                        {/foreach}
                        <div class="lighterblue col-sm-12">
                            {if $action != 'asnotification' && $action != 'asmobile'}
                                <div class="form-group">
                                    <label class="control-label">{$lang.From}:</label>
                                    <div class="">
                                        <input placeholder="Name" type="text" name="from1" value="{if $submit.from1}{$submit.from1}{else}{$from1}{/if}" size="30" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div>
                                        <input placeholder="E-mail address" type="text" name="from2" value="{if $submit.from2}{$submit.from2}{else}{if $from2}{$from2}{/if}{/if}" size="30" class="form-control" />
                                    </div>
                                </div>
                            {/if}
                            {if $action == 'asnotification'}
                                <div class="form-group">
                                    <label class="control-label">{$lang.To}:</label>
                                    <div class="input-group">
                                        <select name="to[]" class="form-control chosen" id="client-search" data-required multiple="multiple">
                                            {foreach from=$recipients item=item}
                                                <option value="{$item[0]}" {if ($selected == $item[0]) || ($submit.to && in_array($item[0], $submit.to))}selected{/if}>#{$item[0]} {$item[1]} {$item[2]}</option>
                                            {/foreach}
                                        </select>
                                        <span class="input-group-btn">
                                            <a href="#" class="btn btn-info" data-return="array" id="clientfilter">{$lang.search_clients}</a>
                                        </span>
                                    </div>
                                </div>
                            {else}
                                <div class="form-group">
                                    <label class="control-label">{$lang.To}:</label>
                                    <div class="input-group">
                                        <textarea name="to" rows="1" style="width: 100%" id="to" class="form-control">{if $submit.to}{$submit.to}{else}{$to_list}{/if}</textarea>
                                        <span class="input-group-btn">
                                            <a href="#" class="btn btn-info" data-return="all" id="clientfilter">{$lang.search_clients}</a>
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="radio">
                                        <label>
                                            <input type="radio" value="compose" name="email_type" {if !$email_type || $email_type == 'compose'}checked{/if} class="email_type">
                                            <strong>{$lang.compose_message}</strong>
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" value="template" name="email_type" class="email_type" {if $email_type == 'template'}checked{/if}>
                                            <strong>{if $action == 'asmobile'}{$lang.use_mobile_template}{else}{$lang.use_template}{/if}</strong>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group template">
                                    {if $action == 'default'}
                                        <label class="control-label">{$lang.select_template}:</label>
                                        <div>
                                            <select name="template" class="form-control chosen select_template">
                                                {foreach from=$email_templates item=groups key=name}
                                                    <optgroup label="{$name}">
                                                        {foreach from=$groups item=item}
                                                            <option value="{$item.id}" {if $submit.template == $item.id}selected{/if}>{$item.tplname}</option>
                                                        {/foreach}
                                                    </optgroup>
                                                {/foreach}
                                            </select>
                                        </div>
                                    {elseif $action == 'asmobile'}
                                        <label class="control-label">{$lang.select_mobile_template}:</label>
                                        <div>
                                            <select name="template" class="form-control chosen select_template">
                                                {foreach from=$email_templates item=template key=name}
                                                    <option value="{$template.id}" {if $submit.template == $template.id}selected{/if}>{$template.tplname}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    {/if}
                                </div>
                            {/if}
                            <div class="form-group compose">
                                <label class="control-label">{$lang.Subject}:</label>
                                <div>
                                    <input type="text" name="subject" style="width: 100%" value="{$submit.subject}" id="subject{if $action == 'asnotification'}_notify{/if}" class="form-control" {if $action == 'asnotification'}required{/if}/>
                                </div>
                            </div>
                            {if !$sms && $action != 'asnotification'}
                                <div class="form-group compose">
                                    <div>
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="save" value="1" {if $submit.save}checked="checked"{/if} onclick="save_tpl()" />
                                            <strong>{if $action == 'asmobile'}{$lang.save_as_mobile_template}{else}{$lang.save_as_email_template}{/if}</strong>
                                        </label>
                                        {if $action != 'asmobile'}
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="html" value="1" {if $submit.html}checked="checked"{/if} style="vertical-align: middle"/>
                                                <strong>HTML</strong> <span style="font-size: 100%;" class="vtip_description" title="With this option you can use html tags in your messages to clients"></span>
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="checkbox" name="notify" value="1" {if $submit.notify}checked="checked"{/if} style="vertical-align: middle"/>
                                                <strong>{$lang.add_notify}</strong>
                                            </label>
                                        {/if}
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="use_variables" {if $submit.use_variables}checked{/if} value="1">
                                            <strong>{$lang.use_variables}</strong>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group" id="tpl_name" style="display:none;">
                                    <label class="control-label">{$lang.Templatename}:</label>
                                    <div>
                                        <input type="text" name="tpl_name" size="50" value="{$submit.subject}" class="form-control"/>
                                    </div>
                                </div>
                            {/if}
                            {if $action == 'asmobile' && count($mobile_mods) > 1}
                                <div class="form-group">
                                    <label class="control-label">{$lang.notificationmodules}:</label>
                                    <div>
                                        <select id="mobile_modules" name="mobile_mods[]" multiple class="form-control chosen">
                                            {foreach from=$mobile_mods item=module}
                                                <option value="{$module.id}" {if in_array($module.id, $submit.mobile_mods)}selected{/if}>{$module.modname_unparsed}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                            {/if}
                            <div class="form-group compose">
                                <label class="control-label">{$lang.Body}:</label>
                                <div>
                                    <textarea style="width: 100%" rows="20" name="body" id="msg_body" class="form-control">{$submit.body}</textarea>
                                </div>
                                <div style="padding-top: 5px;">
                                    <label>Character count: <span id="character-length">0</span></label>
                                </div>
                            </div>
                            {if $action == 'default' || $action == 'asmobile'}
                                <div class="form-group variables">
                                    <label class="control-label">{$lang.Variables}:</label>
                                    <div>
                                        {include file='ajax.emailvariables.tpl'}
                                    </div>
                                </div>
                            {/if}
                        </div>
                        <div class="blu" style="padding: 10px">
                            {if $action=='asnotification'}
                                <input type="submit" name="notification" value="Create Notification" class="btn btn-primary" style="margin-top: 10px;" onclick="return send_email();"/>
                            {elseif !$sms}
                                <input type="submit" name="send" value="{$lang.SendMessage}"  class="btn btn-primary" style="margin-top: 10px;" onclick="return send_email(true);"/>
                            {else}
                                <input type="submit" name="send" value="Send SMS" style="margin-top: 10px;" class="btn btn-primary"/>
                            {/if}
                        </div>
                        <input type="hidden" name="mass_email" value="1">
                        {securitytoken}
                    </form>
                {/if}
            </div>
        </td>
    </tr>
</table>