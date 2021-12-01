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
        <select  name="type" class="form-control" onchange="{literal}if ($(this).val() == 'Private') {$('.iscomp').hide();$('.ispr').show();} else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
            <option value="Private" {if $submit.type=='Private' || (!$submit.type && in_array('Private', $field.default_value)) || (!$submit.type && !$field.default_value)}selected="selected"{/if}>{$lang.Private}</option>
            <option value="Company" {if $submit.type=='Company' || (!$submit.type && in_array('Company', $field.default_value))}selected="selected"{/if}>{$lang.Company}</option>
        </select>
        {literal}<script>$(function(){$('select[name="type"]').trigger('change');})</script>{/literal}

    {elseif $k=='country'}
        <select name="country" class="form-control">
            {foreach from=$countries key=k item=v}
                <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

            {/foreach}
        </select>

    {else}
        {if $field.field_type=='Input' ||  $field.field_type=='Encrypted' || $field.field_type=='Phonenumber'}
            {if $k=='phonenumber' || $field.field_type=='Phonenumber'}
                <input type="text" value="{$submit[$k]}" class="form-control styled" name="{$k}" id="field_register_{$k}" data-initial-country="{$submit.country|default:$default_country}"/>
                <script>initPhoneNumberField($('#field_register_{$k}'));</script>
            {else}
                <input type="text" value="{$submit[$k]}" class="form-control styled" name="{$k}" id="field_register_{$k}"/>
            {/if}
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