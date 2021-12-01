<!-- Service forms -->
{foreach from=$modules item=forms key=module}
    {foreach from=$forms item=input key=key}
        <div class="clear" id="serviceform_{$key}">
            <label class="nodescr">
                {$input.label}
            </label>
            {if $input.type == 'select'}
                <select class="w250" name="service[{$module}][{$input.name}]">
                    {foreach from=$input.options item=option}
                        <option value="{$option.value}" {if $option.selected}selected{/if}>{$option.label}</option>
                    {/foreach}
                    {foreach from=$input.optiongroups item=group}
                        <optgroup label="{$group.label}">
                            {foreach from=$group.options item=option}
                                <option value="{$option.value}"
                                        {if $option.selected}selected{/if}>{$option.label}</option>
                            {/foreach}
                        </optgroup>
                    {/foreach}
                </select>
            {else}
                <input class="w250" name="service[{$module}][{$input.name}]"
                       value="{$input.value}" type="{$input.type}"/>
            {/if}
        </div>
    {/foreach}
{/foreach}