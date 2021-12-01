<div 
    {if $field.type=='Company' && $fields.type}class="iscomp form-group" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}" 
    {elseif $field.type=='Private' && $fields.type}class="ispr form-group" style="{if $submit.type=='Company'}display:none{/if}" 
    {else} class="form-group" {/if} >
    <label for="{$k}">
        {if $k=='type'}
            {$lang.clacctype}
        {elseif $field.options & 1}
            {if $lang[$k]}{$lang[$k]}
            {else}{$field.name}
            {/if}
        {else}{$field.name}
        {/if}
    </label>
    {if $k=='type'}
        <select  name="type" class="form-control" onchange="{literal}if ($(this).val() == 'Private') {
                    $('.iscomp').hide();
                    $('.ispr').show();
                } else {
                    $('.ispr').hide();
                    $('.iscomp').show();
                }{/literal}">
            <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
            <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
        </select>
    {elseif $k=='country'}
        <select name="country" class="form-control">
            {foreach from=$countries key=k item=v}
                <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

            {/foreach}
        </select>
    {else}
        {if $field.field_type=='Input'}
            <input type="text" value="{$submit[$k]}" class="form-control" name="{$k}" class="styled"/>
        {elseif $field.field_type=='Password'}
            <input type="password" autocomplete="off" value="" class="form-control" name="{$k}" class="styled"/>
        {elseif $field.field_type=='Select'}
            <select name="{$k}" class="form-control">
                {foreach from=$field.default_value item=fa}
                    <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                {/foreach}
            </select>
        {elseif $field.field_type=='Check'}
            <div class="checkbox">

                {foreach from=$field.default_value item=fa}
                    <label>
                        <input type="checkbox" name="{$k}[{$fa}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}
                    </label>

                {/foreach}
            </div>
        {/if}
    {/if}
    {if $field.description}
        <p class="help-block">{$field.description}</p>
    {/if}
</div>