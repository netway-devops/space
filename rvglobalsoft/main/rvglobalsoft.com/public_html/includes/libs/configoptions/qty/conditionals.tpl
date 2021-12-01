Here you can control other fields appearance dependent on this field value.
{if $field.id=='new'}
    <div style="margin:10px;text-align:center;font-weight: bold">Please save your field before adding logic/conditions</div>
{else}
    <div style="border:solid 1px #ddd;background:#F5F9FF; margin:10px 0px; ">
        <table width="100%" cellspacing="0" cellpadding="5" border="0">
            <tbody>
            <tr>
                <td align="left">
                    <div style="padding:5px 5px;">If {$field.name} value is</div>
                    <div>
                        <select style="margin:0 20px 0 0;" name="config[conditional][new][condition]">
                            <option value="0"> ---</option>
                            <option value="more">&gt; (more than)</option>
                            <option value="less">&lt; (less than)</option>
                            <option value="eq">= (equals)</option>
                        </select>
                        <input type="text" name="config[conditional][new][conditionval]" size="3" value="0" style="margin:0px;"/>
                    </div>
                </td>
                <td>
                    <div style="padding:5px 5px;">Than</div>
                    <select style="margin:0px;" id="condition_field_action" onchange="changeFieldAction($(this).val())" name="config[conditional][new][action]">
                        <option value="hide">Hide</option>
                        <option value="show">Show</option>
                        <option value="setval">Set value</option>
                    </select></td>
                <td id="select_target_id">
                    Loading...
                </td>
                <td align="right">
                    <div style="padding:26px 0 0;">
                        <a href="#" class="new_control greenbtn" onclick="saveChangesField(); return false"><span>{$lang.Add}</span></a></div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        {literal}
        setTimeout(function () {
            ajax_update("?cmd=configfields&action=helper&do=getotherfields&field_id={/literal}{$field.id}{literal}", false, '#select_target_id');
        }, 200);
        function changeFieldAction(val) {
            ajax_update("?cmd=configfields&action=helper&do=getotherfields&field_id={/literal}{$field.id}{literal}", {act: val}, '#select_target_id');
        }
        {/literal}
    </script>
    {if $field.config.conditionals}
        <br/>
        <h3 style="margin-top:10px">Current Field Logic</h3>
        <ul style="border:solid 1px #ddd;border-bottom:none;" class="grab-sorter" id="customitemseditor">
            {foreach from=$field.config.conditionals item=f key=k}
                <li style="background:#ffffff" id="conditional_{$k}">
                    <div style="border-bottom:solid 1px #ddd;">
                        <input type="hidden" name="config[conditional][{$k}][condition]" value="{$f.condition}"/>
                        <input type="hidden" name="config[conditional][{$k}][conditionval]" value="{$f.conditionval}"/>
                        <input type="hidden" name="config[conditional][{$k}][action]" value="{$f.action}"/>
                        <input type="hidden" name="config[conditional][{$k}][target]" value="{$f.target}"/>
                        <input type="hidden" name="config[conditional][{$k}][targetname]" value="{$f.targetname}"/>
                        <input type="hidden" name="config[conditional][{$k}][targetval]" value="{$f.targetval}"/>
                        <table width="100%" cellspacing="0" cellpadding="5" border="0">
                            <tbody>
                            <tr>
                                <td>
                                    If
                                    <b>{$field.name}</b> {if $f.condition=='more'}is more than{elseif $f.condition=='less'}is less than{else}equals to{/if}
                                    {$f.conditionval},
                                    than
                                    <b>{if $f.action=='show'}Show{elseif $f.action=='hide'}Hide{else}Set value of{/if}
                                        {foreach from=$fields item=item}
                                            {if $item.copy_of==$f.target}<b>{$item.name}</b>{break}{/if}
                                        {/foreach}
                                        {if $f.targetval} to {$f.targetval} {/if}
                                    </b>
                                </td>
                                <td valign="top" align="right">
                                    <div style="padding:5px 0px;">
                                        <a href="#" style="width:12px;height:14px;display:block; box-sizing: content-box;" class="menuitm" title="delete" onclick="$('#condition_field_new_val').val(0);$('#conditional_{$k}').remove();saveChangesField(); return false">
                                            <span class="delsth"></span>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </li>
            {/foreach}
        </ul>
    {/if}
{/if}