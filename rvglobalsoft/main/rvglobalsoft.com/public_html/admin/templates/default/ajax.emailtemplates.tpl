{if $action=='getvariables'}
    {include file='ajax.emailvariables.tpl'}
{elseif $action=='adds'}

{elseif $action == 'edit' || $action=='add'}
    <script type="text/javascript" src="https://rvglobalsoft.com/7944web/templates/default/js/ckeditor/ckeditor.js"></script>
    <link href="{$template_dir}js/chosen/chosen.css" rel="stylesheet" media="all">
    {if $input_type === 'wysiwyg'}
        <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
    {else}
        <script type="text/javascript" src="{$template_dir}js/ace/ace.js?v={$hb_version}"></script>
    {/if}
    <script type="text/javascript" src="{$template_dir}js/chosen/chosen.min.js?v={$hb_version}"></script>
    <script type="text/javascript" src="{$template_dir}js/emailtemplates.js?v={$hb_version}"></script>

    <form method="post" class="template-form" action="?cmd=emailtemplates" onsubmit="return submitform(this)">
        {if $action=='add'}
            <input type="hidden" name="action" value="add"/>
        {else}
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="id" value="{$email.id}"/>
        {/if}
        {if $inline}
            <input type="hidden" name="inline" value="1"/>
        {/if}
        <div class="lighterblue" style="padding:5px;">
            {if $email.send=='0'}
                <div class="imp_msg" id="disablednote">
                    <strong>{$lang.disablednote}</strong>
                    <a href="#" onclick="$('#disablednote').hide();
                            ajax_update('?cmd=emailtemplates&make=enable&id={$email.id}');
                            return false;" class="editbtn">{$lang.Enable}</a>
                </div>
            {/if}
            {if $action=='add'}
                <input type="hidden" name="make" value="add"/>
            {else}
                <input type="hidden" name="make" value="edit"/>
            {/if}
            {if $to}
                <input type="hidden" name="to" value="{$to}"/>
            {/if}
            {if $dontclose}
                <input type="hidden" name="dontclose" value="true"/>
            {/if}
            {if !$editable_groups}
                <input type="hidden" name="group" value="{$email.group}"/>
            {/if}

            <input type="hidden" name="send" value="{$email.send}"/>
            <input type="hidden" name="system" value="{$email.system}"/>

            <div class="" style="padding: 0 6px;">
                <div class="form-group">
                    <label>Template name</label>
                    <input type="text" name="tplname" class="form-control"
                           {if $email.system}readonly{/if}
                           value="{$email.tplname|escape}"/>
                </div>
            </div>
            {foreach from=$langs item=lgname key=lgid name="loop"}
                {if !is_array($email.message)}
                    {assign var=send_as value=$email.sendas}
                    {assign var=tpl_subject value=$email.subject}
                    {assign var=tpl_message value=$email.message}
                    {assign var=alt_message value=$email.altmessage}
                {else}
                    {assign var=send_as value=$email.sendas.$lgid}
                    {assign var=tpl_subject value=$email.subject.$lgid}
                    {assign var=tpl_message value=$email.message.$lgid}
                    {assign var=alt_message value=$email.altmessage.$lgid}
                {/if}
                <table width="100%" cellspacing="0" cellpadding="6"
                       {if !$smarty.foreach.loop.first}style="display:none"{/if} id="langform_{$lgid}">
                    <tr>{$language_tabs}{$lgname|capitalize}
                        <td width="160">
                            <input type="hidden" value="{$lgid}" name="language_id[{$lgid}]"/>
                            <input type="hidden" value="{$lgname}" name="language_name[{$lgid}]"/>
                            <strong>{$lang.Subject}:</strong>
                            {if $language_tabs }
                                <br/>
                                <small>({$lgname|capitalize})</small>
                            {/if}
                        </td>
                        <td>
                            {hbinput value=$tpl_subject style="" class="inp" size="50" name="subject[`$lgid`]"}
                        </td>
                    </tr>
                    <tr>
                        <td width="160">
                            <strong>Send as:</strong>
                        </td>
                        <td>
                            <input type="text" name="sendas[{$lgid}]" class="inp form-sendas" selected="selected" value="HTML" disabled="">
                           <!-- <select name="sendas[{$lgid}]" class="inp form-sendas">
                                <option {if $send_as == 'plain'}selected="selected"{/if} value="plain">Plain text
                                </option>
                                <option {if $send_as == 'html'}selected="selected"{/if} value="html">HTML</option>
                                <option {if $send_as == 'both'}selected="selected"{/if} value="both">HTML + Plain text
                                    (Alternative content)
                                </option>
                            </select>-->
                        </td>
                    </tr>
                    <tr>
                        <td width="160">
                            <strong>Post portal notification:</strong>
                        </td>
                        <td>
                            <input class="__notify" type="checkbox" value="1" name="notify"
                                   {if $email.notify}checked="checked"{/if}
                                   onchange="$('.__notify').prop('checked', $(this).prop('checked'));">
                        </td>
                    </tr>
                    {if $editable_groups}
                        <tr>
                            <td width="160">
                                <strong>{$lang.Group}:</strong>
                            </td>
                            <td>
                                <select name="group" class="inp change-group">
                                    {foreach from=$editable_groups item=group}
                                        <option value="{$group}"
                                                {if $email.group == $group}selected="selected"{/if}>{if $group == 'Invoice'}Billing{else}{$group}{/if}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                    {/if}
                    <tbody id="mbody">
                    <tr class="message-form">
                        <td valign="top">
                            <strong>{$lang.Body}:</strong>
                            <br><small class="body-type"></small>
                        </td>
                        <td valign="top">
                            {$language_tabs}    
                            {if $input_type === 'wysiwyg'}
                                {hbwysiwyg wrapper="div" style="width:99%;" additionaltabs=$language_tabs
                                value=$tpl_message  class="inp wysiw_editor message input-wysiwyg" cols="100" rows="15"
                                name="message[`$lgid`]" featureset="full" editortype="tinymce" blockwysiwyg=true}
                            {else}
                                {hbwysiwyg wrapper="div" style="width:99%;" additionaltabs=$language_tabs
                                value=$tpl_message  class="inp wysiw_editor message input-code" cols="100" rows="15"
                                name="message[`$lgid`]" featureset="ace" editortag="HTML" editortype="ace"}
                            {/if}

                            {if $email.group=='Mobile'}
                                <label>Character count:
                                    <span class="char_counter" data-id="{$lgid}">0</span>
                                </label>
                            {/if}
                        </td>
                    </tr>
                    <tr class="altmessage-form">
                        <td valign="top">
                            <strong>Alternative Body:</strong>
                            <br/><small>(Plain text)</small>
                        </td>
                        <td valign="top">
                            {if $type === 'ace'}
                                {hbwysiwyg wrapper="div" style="width:99%;" additionaltabs=$language_tabs
                                value=$alt_message  class="inp wysiw_editor altmessage" cols="100" rows="15"
                                name="altmessage[`$lgid`]" featureset="ace" editortag="HTML" editortype="ace"}
                            {else}
                                {hbwysiwyg wrapper="div" style="width:99%;" additionaltabs=$language_tabs
                                value=$alt_message  class="inp wysiw_editor altmessage" cols="100" rows="15"
                                name="altmessage[`$lgid`]" editortype="plain"}
                            {/if}
                            {if $email.group=='Mobile'}
                                <label>Character count:
                                    <span class="char_counter_alt" data-id="{$lgid}">0</span>
                                </label>
                            {/if}
                        </td>
                    </tr>
                    </tbody>
                    {if $action == 'edit'}
                    <tr>
                        <td></td>
                        <td>
                            ถ้าต้องการให้ link ใน email เป็น https ให้ไส่ modifier https ด้วย เช่น LOGIN LINK {literal}{$system_url|https}{/literal}<br />
                            มีการ Fix js code ให้เลือก tab ภาษาไทย อัตโนมัติ
                        </td>
                    </tr>
                    {/if}
                </table>
            {literal}
                <script type="text/javascript">
                    (function () {
                        var id = {/literal}'{$lgid}'{literal},
                            index = $('#langform_' + id).prevAll('table').length;
                        $('#langform_' + id + ' .message-form .additional').eq(index).addClass('active');
                        $('#langform_' + id + ' .altmessage-form .additional').eq(index).addClass('active');
                    })()
                        CKEDITOR.replace( 'message[{/literal}{$lgid}{literal}]' );
                </script>
            {/literal}
            {/foreach}

            {if isset($email.message)}
               <fieldset>
                   <legend>English plain text message</legend>
                   <blockquote>
                   {if is_array($email.message)}
                      {assign var='emailMessage' value=$email.message[1]}
                   {else}
                      {assign var='emailMessage' value=$email.message}
                   {/if}
                   {php}
                       $emailMessage     = $this->get_template_vars('emailMessage');
                       if (preg_match('/dateformat\:\$date\_format/', $emailMessage)) {
                           $emailMessage = preg_replace('/dateformat\:\$date\_format/', 'date_format:\'%d %b %Y\'', $emailMessage);
                       }
                       $this->assign('emailMessage', $emailMessage);
                   {/php}
                   <pre>{$emailMessage}</pre>
                   </blockquote>
               </fieldset>
            {/if}

            {include file='ajax.emailvariables.tpl'}
            {if $inline}
                <input type="submit" name="submit" value="{$lang.savechanges}"
                       class="btn btn-primary btn-sm"/>
            {/if}
        </div>
        {securitytoken}
    </form>
    <form id="previewform" target="_blank" method="post" action="?cmd=emailtemplates&action=preview">
        {securitytoken}
    </form>
{/if}