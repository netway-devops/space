{if !$submit.sla_level_one && !$submit.sla_level_two && !$submit.sla_level_zero && !($submit.options & 131072) && !($submit.options & 262144)}
    <tr class="blank_sla">
        <td colspan="10">
            <div class="blank_services">
                <div class="blank_info">
                    <h1>{$lang.slaescalate}</h1>
                    {$lang.blanksla}
                    <div class="clear"></div>
                    <a class="new_add new_menu" href="#" onclick="$(this).parents('.blank_sla').hide().nextAll().show();
                                                        return false;" style="margin-top:10px">
                        <span>{$lang.Enable}</span>
                    </a>
                    <div class="clear"></div>
                </div>
            </div>
        </td>
    </tr>
    {assign value=1 var=hidesla}
{/if}
<tr {if $hidesla}style="display:none"{/if}>
    <td width="190" align="right"><strong>{$lang.escalate_unresponded}:</strong></td>
    <td><span style="width:190px;display:inline-block">
            <span><input type="checkbox" onclick="check_i(this)"
                         {if $submit.sla_level_one}checked="checked"{/if} value="1">
                <input type="text" value="{$submit.sla_level_one}" size="5" name="sla_level_one"
                       class="inp config_val" {if !$submit.sla_level_one}disabled{/if} />
            </span>
            <select class="inp" name="sla_multi">
                <option {if $submit.sla_multi == 1}selected="selected"{/if}
                        value="1">{$lang.minutes|capitalize}</option>
                <option {if $submit.sla_multi == 60}selected="selected"{/if}
                        value="60">{$lang.hours|capitalize}</option>
                <option {if $submit.sla_multi == 1440}selected="selected"{/if}
                        value="1440">{$lang.days|capitalize}</option>
            </select></span>


        And {$lang.applymacro}
        <select name="macro_sla1_id" class="inp" style="max-width:300px">
            <option value="0"> --</option>
            {foreach from=$macros item=macro}
                <option {if $submit.macro_sla1_id == $macro.id}selected="selected"{/if}
                        value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
            {/foreach}
        </select>
    </td>
</tr>
<tr {if $hidesla}style="display:none"{/if}>
    <td align="right"><strong>{$lang.escalate_unresolved}</strong></td>
    <td><span style="width:190px;display:inline-block">
            <span>
                <input type="checkbox" onclick="check_i(this)"
                       {if $submit.sla_level_two}checked="checked"{/if} value="1"/>
                <input type="text" value="{$submit.sla_level_two}" size="5" name="sla_level_two"
                       class="inp  config_val" {if !$submit.sla_level_two}disabled{/if} /></span>
            <select class="inp" name="sla_multi2">
                <option {if $submit.sla_multi2 == 1}selected="selected"{/if}
                        value="1">{$lang.hours|capitalize}</option>
                <option {if $submit.sla_multi2 == 24}selected="selected"{/if}
                        value="24">{$lang.days|capitalize}</option>
            </select></span>
        And {$lang.applymacro}
        <select name="macro_sla2_id" class="inp" style="max-width:300px">
            <option value="0"> --</option>
            {foreach from=$macros item=macro}
                <option {if $submit.macro_sla2_id == $macro.id}selected="selected"{/if}
                        value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
            {/foreach}
        </select>
    </td>
</tr>
<tr {if $hidesla}style="display:none"{/if}>
    <td align="right"><strong>Ask to close tickets that are in answered state</strong></td>
    <td><span style="width:190px;display:inline-block">
            <span>
                <input type="checkbox" onclick="check_i(this)"
                       {if $submit.sla_level_zero}checked="checked"{/if} value="1"/>
                <input type="text" value="{$submit.sla_level_zero}" size="5" name="sla_level_zero"
                       class="inp  config_val" {if !$submit.sla_level_zero}disabled{/if} /></span>
            <select class="inp" name="sla_multi0">
                <option {if $submit.sla_multi0 == 1}selected="selected"{/if}
                        value="1">{$lang.hours|capitalize}</option>
                <option {if $submit.sla_multi0 == 24}selected="selected"{/if}
                        value="24">{$lang.days|capitalize}</option>
            </select></span>
        And {$lang.applymacro}
        <select name="macro_sla0_id" class="inp" style="max-width:300px">
            <option value="0"> --</option>
            {foreach from=$macros item=macro}
                <option {if $submit.macro_sla0_id == $macro.id}selected="selected"{/if}
                        value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
            {/foreach}
        </select>
    </td>
</tr>
<tr {if $hidesla}style="display:none"{/if}>
    <td align="right"><strong>Allow clients to report reply to manager</strong></td>
    <td><span style="width:190px;display:inline-block">
            <span>
                <input type="checkbox" name="reportreply" {if $submit.options & 131072}checked="checked"{/if} value="1"/>
            </span>
        </span>
        And {$lang.applymacro}
        <select name="macro_reportreply" class="inp" style="max-width:300px">
            <option value="0"> --</option>
            {foreach from=$macros item=macro}
                <option {if $submit.macro_reportreply == $macro.id}selected="selected"{/if}
                        value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
            {/foreach}
        </select>
    </td>
</tr>
<tr {if $hidesla}style="display:none"{/if}>
    <td align="right"><strong>Allow clients to report ticket to manager</strong></td>
    <td><span style="width:190px;display:inline-block">
            <span>
                <input type="checkbox" name="reportticket" {if $submit.options & 262144}checked="checked"{/if} value="1"/>
            </span>
        </span>
        And {$lang.applymacro}
        <select name="macro_reportticket" class="inp" style="max-width:300px">
            <option value="0"> --</option>
            {foreach from=$macros item=macro}
                <option {if $submit.macro_reportticket == $macro.id}selected="selected"{/if}
                        value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
            {/foreach}
        </select>
    </td>
</tr>