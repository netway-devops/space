{foreach from=$section.options key=option_var item=option}
    <tr>
        <td width="300" align="right" style="padding-right: 20px;">
            <b>{$option.name}</b>
            {if $option.preview || $option.description}
                <a class="vtip_description" title="{if $option.description}{$option.description|escape} <br><br>{/if}{if $option.preview}<img class='vtip_preview' src='{$previews_path}/{$option.preview}'/>{/if}"></a>
            {/if}
        </td>
        {if $section.show_default}
            <td width="200">
                {if $option.default}
                    <small style="color: #bbb">Default:</small>
                    {if $option.type=='check'}
                        <small style="color: #666"> {if $option.default}Yes{else}No{/if}</small>
                    {else}
                        <small style="color: #666"> {$option.default}</small>
                    {/if}
                {/if}
            </td>
        {/if}
        <td style="padding: 10px;">
            {if $option.type=='input'}
                <input type="text" name="configuration[sections][{$section_var}][options][{$option_var}][value]" value="{$option.value|htmlentities}" class="form-control"/>
            {elseif $option.type=='check'}
                <input id='check_{$section_var}_{$option_var}' type='checkbox' value='1' {if $option.value == 1}checked="checked"{/if} name="configuration[sections][{$section_var}][options][{$option_var}][value]">
                <input id='check_hidden_{$section_var}_{$option_var}' type='hidden' value='0' {if $option.value == 1}checked="checked"{/if} name="configuration[sections][{$section_var}][options][{$option_var}][value]">
                Yes
            {literal}
                <script>
                    $(function () {
                        var c = '#' + 'check_{/literal}{$section_var}_{$option_var}{literal}';
                        var ch = '#' + 'check_hidden_{/literal}{$section_var}_{$option_var}{literal}';
                        $(c).change(function () {
                            var t = $(this).is(':checked');
                            $(ch).prop('disabled', t);
                        }).trigger('change');
                    });
                </script>
            {/literal}
            {elseif $section_var=='css' || $section_var=='js' || $option.type=='css' || $option.type=='js' || $option.type=='html'}
                <textarea id="ace-{$section_var}-{$option_var}-textarea" name="configuration[sections][{$section_var}][options][{$option_var}][value]" style="display: none;" class="form-control" cols="60" rows="5" >{$option.value}</textarea>
                <div id="ace-{$section_var}-{$option_var}"></div>
                <script>
                    CodeEditor.init("{$section_var}", "{$option_var}", "{$option.type}");
                </script>
            {elseif $option.type=='textarea'}
                <textarea name="configuration[sections][{$section_var}][options][{$option_var}][value]" class="form-control" cols="60" rows="5" >{$option.value}</textarea>
            {elseif $option.type=='select'}
                <select name="configuration[sections][{$section_var}][options][{$option_var}][value]" class="form-control" >
                    {foreach from=$option.options key=opt_key item=opt_val}
                        <option {if $option.value == $opt_key}selected="selected"{/if} value="{$opt_key}">{$opt_val}</option>
                    {/foreach}
                </select>
            {elseif $option.type=='colorpicker'}
                <div class="colorpicker-box">
                    <input type="text" id="colorSelector_{$option_var}_i" class="form-control" placeholder="" name="configuration[sections][{$section_var}][options][{$option_var}][value]" value="{$option.value}" />
                    <div class="colorpicker-box-picker" id="colorSelector_{$option_var}" style="background: {$option.value};" onclick="$('#colorSelector_{$option_var}_i').click()"></div>
                </div>
            {literal}
                <script type="text/javascript">
                    $('#colorSelector_{/literal}{$option_var}{literal}').ColorPicker({
                        onSubmit: function (hsb, hex, rgb, el) {
                            $(el).val('#' + hex).ColorPickerHide();
                        },
                        onChange: function (hsb, hex, rgb) {
                            $('#colorSelector_{/literal}{$option_var}{literal}').css('backgroundColor', '#' + hex);
                            $('#colorSelector_{/literal}{$option_var}{literal}_i').val('#' + hex);
                        },
                        livePreview: true,
                        color: {/literal}"{$option.value}"{literal}
                    });
                    $('#colorSelector_{/literal}{$option_var}{literal}_i').on('input', function () {
                        var val = $(this).val();
                        $('#colorSelector_{/literal}{$option_var}{literal}').css('backgroundColor', val);
                        $('#colorSelector_{/literal}{$option_var}{literal}').ColorPickerSetColor(val);
                    });
                </script>
            {/literal}
            {/if}
        </td>
    </tr>
{/foreach}