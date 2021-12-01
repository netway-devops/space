{foreach from=$settings item=option key=key name=settings}
    {if !$smarty.foreach.settings.first}
        <hr>
    {/if}
    <div class="control-group">
        <label class="control-label" for="{$key}">
            <strong>
                {$option.title}
            </strong>
            {if $option.tooltip}
            <span class="vtip_description" title="{$option.tooltip|escape}"></span>
            {/if}
            {if $option.description}
                {$option.description}
            {/if}
        </label>
        <div class="controls">
            {if $option.type == 'text' || $option.type == 'input'}
                <input type="text" name="{$option.name}" style="width: 90%"
                       id="{$key}" value="{$option.value|escape}">
            {elseif $option.type == 'textarea'}
                <textarea name="{$option.name}" style="width: 90%"
                          id="{$key}">{$option.value|escape}</textarea>
            {elseif $option.type == 'radio' || $option.type == 'checkbox'}
                {foreach from=$option.items item=opt name=options}
                    {if $option.value !== ''}
                        <input type="{$option.type}" style="margin: 0px" name="{$opt.name|escape}"
                               value="{$opt.value|escape}"
                               {if $opt.selected}checked{/if}>
                        {$opt.title}{if $opt.description}, {$opt.description}{/if}
                        {if !$smarty.foreach.options.last}
                            <br>
                        {/if}
                    {/if}
                {/foreach}
            {elseif $option.key == 'DefaultNameservers'}
                {include file='../common/tpl/settings_nameservers.tpl'}
            {elseif $option.type == 'tpl'}
                {include file=$option.tpl}
            {else}
                <select id="{$key}" name="{$option.name}" style="width: 90%">
                    {foreach from=$option.items item=opt}
                        {if $option.value !== ''}
                            <option value="{$opt.value|escape}" {if $opt.selected}selected{/if} >
                                {$opt.title}{if $opt.description}, {$opt.description}{/if}
                            </option>
                        {/if}
                    {/foreach}
                </select>
            {/if}
        </div>
    </div>
{/foreach}