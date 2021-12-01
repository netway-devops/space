<select name="option[Email template to send]">
    {if $email_templates}
        {foreach from=$email_templates item=template_group key=group_name}
            <optgroup label="{$group_name}">
            {foreach from=$template_group item=email_template}
                <option value="{$email_template.id}" {if $config.value == $email_template.id}selected{/if}>{$email_template.tplname}</option>
            {/foreach}
            </optgroup>
        {/foreach}
    {/if}
</select>