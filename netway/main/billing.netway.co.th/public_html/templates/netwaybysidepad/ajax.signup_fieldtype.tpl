{if $k=='type'}
    <select  id="field_{$k}" name="type" style="width: 90%;">
        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
        <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
    </select>
{elseif $k=='country'}
    <select name="country" style="width: 90%;" id="field_{$k}" class="chzn-select">
        {foreach from=$countries key=k item=v}
            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>
        {/foreach}
    </select>
{else}
    {if $field.field_type=='Input'}
        {if  $k=='captcha'}
            <div style="white-space: nowrap;">
                <img class="capcha" style="width: 120px; height: 60px;" src="?cmd=root&action=captcha#{$stamp}" /> 
                <span style="display: inline-block; width: 65%; white-space: normal;">
                    {$lang.typethecharacters}<br />
                    <a href="#" onclick="return singup_image_reload();" >{$lang.refresh}</a>
                </span>
            </div>
        {/if}
        <input type="text" value="{$submit[$k]}" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
    {elseif $field.field_type=='Password'}
        <input type="password" value="" style="width: 90%;" name="{$k}" class="" id="field_{$k}" />
    {elseif $field.field_type=='Select'}
        <select name="{$k}" style="width: 90%;" id="field_{$k}" >
            {foreach from=$field.default_value item=fa}
                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
            {/foreach}
        </select>
    {elseif $field.field_type=='Check'}
        {foreach from=$field.default_value item=fa}
            <input type="checkbox" name="{$k}[{$fa}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
        {/foreach}
    {/if}
{/if}